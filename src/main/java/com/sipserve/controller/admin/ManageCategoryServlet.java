package com.sipserve.controller.admin;

import com.sipserve.dao.CategoryDAO;
import com.sipserve.model.Category;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

        import java.io.IOException;
import java.util.List;

@WebServlet("/manageCategories")
public class ManageCategoryServlet extends HttpServlet {

    private final CategoryDAO categoryDAO = new CategoryDAO();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        // DELETE
        if (action != null && action.equals("delete")) {

            int id = Integer.parseInt(request.getParameter("id"));
            categoryDAO.deleteCategory(id);

            response.sendRedirect("manageCategories");
            return;
        }

        // EDIT (LOAD DATA)
        if (action != null && action.equals("edit")) {

            int id = Integer.parseInt(request.getParameter("id"));

            Category editCategory = categoryDAO.getCategoryById(id);

            request.setAttribute("editCategory", editCategory);
        }

        List<Category> categories = categoryDAO.getAllCategories();
        request.setAttribute("categories", categories);

        request.getRequestDispatcher(
                "/WEB-INF/views/admin/manage-categories.jsp"
        ).forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String idStr = request.getParameter("id");
        String name = request.getParameter("name");
        String description = request.getParameter("description");

        Category category = new Category();
        category.setName(name);
        category.setDescription(description);

        // UPDATE
        if (idStr != null && !idStr.isEmpty()) {

            category.setId(Integer.parseInt(idStr));
            categoryDAO.updateCategory(category);

        } else {

            // CREATE
            categoryDAO.addCategory(category);
        }

        response.sendRedirect("manageCategories");
    }
}