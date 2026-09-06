package vn.com.btvn.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.com.btvn.entity.Product;
import vn.com.btvn.service.ICategoryService;
import vn.com.btvn.service.IProductService;
import vn.com.btvn.service.impl.CategoryServiceImpl;
import vn.com.btvn.service.impl.ProductServiceImpl;

@WebServlet(urlPatterns = { "/home", "/product", "/product/detail" })
public class ProductController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final int PAGE_SIZE = 6;
    private final IProductService productService = new ProductServiceImpl();
    private final ICategoryService categoryService = new CategoryServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        switch (request.getServletPath()) {
            case "/home" -> home(request, response);
            case "/product" -> products(request, response);
            case "/product/detail" -> detail(request, response);
            default -> response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    private void home(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("latestProducts", productService.findLatest(10));
        request.setAttribute("categories", categoryService.findAll());
        request.getRequestDispatcher("/views/store/home.jsp").forward(request, response);
    }

    private void products(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int page = parsePage(request.getParameter("page"));
        String keyword = request.getParameter("q") == null ? "" : request.getParameter("q").trim();
        Integer categoryId = parseId(request.getParameter("category"));
        long total = productService.count(keyword, categoryId, true);
        int totalPages = Math.max(1, (int) Math.ceil(total / (double) PAGE_SIZE));
        page = Math.min(page, totalPages);

        request.setAttribute("products", productService.findPage(page - 1, PAGE_SIZE, keyword, categoryId, true));
        request.setAttribute("categories", categoryService.findAll());
        request.setAttribute("page", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("total", total);
        request.setAttribute("q", keyword);
        request.setAttribute("selectedCategory", categoryId);
        request.getRequestDispatcher("/views/store/products.jsp").forward(request, response);
    }

    private void detail(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Integer id = parseId(request.getParameter("id"));
        Product product = id == null ? null : productService.findById(id);
        if (product == null || product.getStatus() != 1) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Không tìm thấy sản phẩm.");
            return;
        }
        request.setAttribute("product", product);
        request.getRequestDispatcher("/views/store/product-detail.jsp").forward(request, response);
    }

    private int parsePage(String value) {
        try { return Math.max(1, Integer.parseInt(value)); } catch (Exception ignored) { return 1; }
    }
    private Integer parseId(String value) {
        try { return value == null || value.isBlank() ? null : Integer.valueOf(value); } catch (NumberFormatException ignored) { return null; }
    }
}
