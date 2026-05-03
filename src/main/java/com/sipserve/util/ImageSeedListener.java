package com.sipserve.util;

import com.sipserve.dao.ProductDAO;
import com.sipserve.model.Product;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

import java.io.IOException;
import java.io.InputStream;
import java.util.List;
import java.util.Optional;

/**
 * On application startup, scans for products whose image_data is NULL
 * and loads the bytes from /assets/images/{image_url} into the DB.
 * Safe to run on every restart - it skips rows that already have BLOB data.
 */
@WebListener
public class ImageSeedListener implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        ServletContext ctx = sce.getServletContext();
        ProductDAO dao = new ProductDAO();

        List<Integer> pending;
        try {
            pending = dao.findIdsWithoutImageData();
        } catch (RuntimeException ex) {
            ctx.log("ImageSeed: skipped (DB not ready) - " + ex.getMessage());
            return;
        }

        if (pending.isEmpty()) {
            ctx.log("ImageSeed: all product images already in DB.");
            return;
        }

        int loaded = 0;
        for (int id : pending) {
            Optional<Product> opt = dao.findById(id);
            if (opt.isEmpty() || opt.get().getImageUrl() == null) continue;

            String filename = opt.get().getImageUrl();
            String resourcePath = "/assets/images/" + filename;

            try (InputStream in = ctx.getResourceAsStream(resourcePath)) {
                if (in == null) {
                    ctx.log("ImageSeed: missing file " + resourcePath);
                    continue;
                }
                byte[] bytes = in.readAllBytes();
                String mime = guessMime(filename);
                dao.updateImage(id, bytes, mime);
                loaded++;
            } catch (IOException ex) {
                ctx.log("ImageSeed: failed to read " + resourcePath, ex);
            }
        }

        ctx.log("ImageSeed: loaded " + loaded + " product image(s) into DB.");
    }

    private static String guessMime(String filename) {
        String f = filename.toLowerCase();
        if (f.endsWith(".png"))  return "image/png";
        if (f.endsWith(".gif"))  return "image/gif";
        if (f.endsWith(".webp")) return "image/webp";
        return "image/jpeg";
    }
}
