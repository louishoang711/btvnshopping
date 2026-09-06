package vn.com.btvn.controller;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.com.btvn.entity.Category;
import vn.com.btvn.service.ICategoryService;
import vn.com.btvn.service.impl.CategoryServiceImpl;
import vn.com.btvn.service.IProductService;
import vn.com.btvn.service.impl.ProductServiceImpl;

@WebServlet(urlPatterns = { "/admin", "/admin/dashboard" })
public class DashboardController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final ICategoryService categoryService = new CategoryServiceImpl();
    private final IProductService productService = new ProductServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Category> categories = categoryService.findAll();
        request.setAttribute("listcate", categories);
        request.setAttribute("productCount", productService.count("", null, false));
        request.setAttribute("latestProducts", productService.findLatest(5));
        request.getRequestDispatcher("/views/admin/dashboard.jsp").forward(request, response);
    }
}
