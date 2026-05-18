package com.sipserve.controller.customer;

import com.sipserve.dao.ProductDAO;
import com.sipserve.model.Product;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Optional;

/**
 * Handles two routes for products:
 *   /product?id=5  -> product details page
 *   /image?id=5    -> streams the product's image bytes from MySQL
 *
 * Self-heals the image: if image_data is NULL but image_url points to a
 * file in the webapp, the file is loaded into the DB on first request.
 */
@WebServlet(name = "ProductServlet", urlPatterns = { "/product", "/image" })
public class ProductServlet extends HttpServlet {

    private final ProductDAO productDAO = new ProductDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        if ("/image".equals(req.getServletPath())) {
            serveImage(req, resp);
        } else {
            showDetails(req, resp);
        }
    }

    /* ---------------- /image ---------------- */

    private void serveImage(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        int id;
        try {
            id = Integer.parseInt(req.getParameter("id"));
        } catch (NumberFormatException ex) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid id");
            return;
        }

        Optional<Product> opt = productDAO.findImage(id);
        byte[] data = opt.map(Product::getImageData).orElse(null);
        String mime = opt.map(Product::getImageType).orElse(null);

        // Self-heal: load file from webapp if BLOB missing
        if (data == null) {
            Optional<Product> full = productDAO.findById(id);
            if (full.isPresent() && full.get().getImageUrl() != null) {
                Loaded l = loadFromDisk(full.get().getImageUrl());
                if (l != null) {
                    productDAO.updateImage(id, l.bytes, l.mime);
                    data = l.bytes;
                    mime = l.mime;
                }
            }
        }

        if (data == null) {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Image not found");
            return;
        }

        if (mime == null) mime = "image/jpeg";
        resp.setContentType(mime);
        resp.setContentLength(data.length);
        resp.setHeader("Cache-Control", "public, max-age=86400");

        try (OutputStream out = resp.getOutputStream()) {
            out.write(data);
        }
    }

    /* ---------------- /product ---------------- */

    private void showDetails(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        int id;
        try {
            id = Integer.parseInt(req.getParameter("id"));
        } catch (NumberFormatException ex) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid id");
            return;
        }

        Optional<Product> opt = productDAO.findById(id);
        if (opt.isEmpty()) {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Product not found");
            return;
        }

        req.setAttribute("product", opt.get());
        req.getRequestDispatcher("/WEB-INF/views/customer/product-details.jsp")
                .forward(req, resp);
    }

    /* ---------------- helpers ---------------- */

    private Loaded loadFromDisk(String filename) {
        ServletContext ctx = getServletContext();
        String path = "/assets/images/" + filename;
        try (InputStream in = ctx.getResourceAsStream(path)) {
            if (in == null) {
                ctx.log("ProductServlet: missing resource " + path);
                return null;
            }
            return new Loaded(in.readAllBytes(), guessMime(filename));
        } catch (IOException ex) {
            ctx.log("ProductServlet: failed to read " + path, ex);
            return null;
        }
    }

    private static String guessMime(String filename) {
        String f = filename.toLowerCase();
        if (f.endsWith(".png"))  return "image/png";
        if (f.endsWith(".gif"))  return "image/gif";
        if (f.endsWith(".webp")) return "image/webp";
        return "image/jpeg";
    }

    private static final class Loaded {
        final byte[] bytes;
        final String mime;
        Loaded(byte[] b, String m) { this.bytes = b; this.mime = m; }
    }
}