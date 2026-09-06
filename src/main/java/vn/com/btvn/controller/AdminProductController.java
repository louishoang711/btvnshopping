package vn.com.btvn.controller;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import vn.com.btvn.entity.Category;
import vn.com.btvn.entity.Product;
import vn.com.btvn.service.ICategoryService;
import vn.com.btvn.service.IProductService;
import vn.com.btvn.service.impl.CategoryServiceImpl;
import vn.com.btvn.service.impl.ProductServiceImpl;
import vn.com.btvn.util.FileUploadUtil;

@MultipartConfig(maxFileSize = 10L * 1024 * 1024, maxRequestSize = 12L * 1024 * 1024)
@WebServlet(urlPatterns = { "/admin/products", "/admin/product/add", "/admin/product/insert",
        "/admin/product/edit", "/admin/product/update", "/admin/product/delete" })
public class AdminProductController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final int PAGE_SIZE = 10;

    private final IProductService productService = new ProductServiceImpl();
    private final ICategoryService categoryService = new CategoryServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        switch (request.getServletPath()) {
            case "/admin/products" -> list(request, response);
            case "/admin/product/add" -> showForm(request, response, new Product(), false);
            case "/admin/product/edit" -> edit(request, response);
            case "/admin/product/delete" -> delete(request, response);
            default -> response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        if ("/admin/product/insert".equals(request.getServletPath())) insert(request, response);
        else if ("/admin/product/update".equals(request.getServletPath())) update(request, response);
        else response.sendError(HttpServletResponse.SC_NOT_FOUND);
    }

    private void list(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int page = parsePositiveInt(request.getParameter("page"), 1);
        String keyword = trim(request.getParameter("q"));
        Integer categoryId = parseNullableInt(request.getParameter("category"));
        long total = productService.count(keyword, categoryId, false);
        int totalPages = Math.max(1, (int) Math.ceil(total / (double) PAGE_SIZE));
        page = Math.min(page, totalPages);

        request.setAttribute("products", productService.findPage(page - 1, PAGE_SIZE, keyword, categoryId, false));
        request.setAttribute("categories", categoryService.findAll());
        request.setAttribute("page", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("total", total);
        request.setAttribute("q", keyword);
        request.setAttribute("selectedCategory", categoryId);
        request.getRequestDispatcher("/views/admin/product-list.jsp").forward(request, response);
    }

    private void edit(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Integer id = parseNullableInt(request.getParameter("id"));
        Product product = id == null ? null : productService.findById(id);
        if (product == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Không tìm thấy sản phẩm.");
            return;
        }
        showForm(request, response, product, true);
    }

    private void insert(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Product product = new Product();
        String error = bindAndValidate(request, product);
        if (error != null) {
            request.setAttribute("error", error);
            showForm(request, response, product, false);
            return;
        }
        try {
            String uploaded = FileUploadUtil.saveImage(request.getPart("imageFile"), "product");
            product.setImages(uploaded != null ? uploaded : trimToNull(request.getParameter("images")));
            productService.insert(product);
            request.getSession().setAttribute("adminMessage", "Đã thêm sản phẩm mới.");
            response.sendRedirect(request.getContextPath() + "/admin/products");
        } catch (IllegalArgumentException exception) {
            request.setAttribute("error", exception.getMessage());
            showForm(request, response, product, false);
        }
    }

    private void update(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Integer id = parseNullableInt(request.getParameter("productId"));
        Product product = id == null ? null : productService.findById(id);
        if (product == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Không tìm thấy sản phẩm.");
            return;
        }
        String oldImage = product.getImages();
        String error = bindAndValidate(request, product);
        if (error != null) {
            request.setAttribute("error", error);
            showForm(request, response, product, true);
            return;
        }
        try {
            String uploaded = FileUploadUtil.saveImage(request.getPart("imageFile"), "product");
            String imageUrl = trimToNull(request.getParameter("images"));
            if (uploaded != null) product.setImages(uploaded);
            else if (imageUrl != null) product.setImages(imageUrl);
            productService.update(product);
            if (uploaded != null && !uploaded.equals(oldImage)) FileUploadUtil.deleteLocalImage(oldImage);
            request.getSession().setAttribute("adminMessage", "Đã cập nhật sản phẩm.");
            response.sendRedirect(request.getContextPath() + "/admin/products");
        } catch (IllegalArgumentException exception) {
            request.setAttribute("error", exception.getMessage());
            showForm(request, response, product, true);
        }
    }

    private void delete(HttpServletRequest request, HttpServletResponse response) throws IOException {
        Integer id = parseNullableInt(request.getParameter("id"));
        if (id != null) {
            Product product = productService.findById(id);
            try {
                productService.delete(id);
                if (product != null) FileUploadUtil.deleteLocalImage(product.getImages());
                request.getSession().setAttribute("adminMessage", "Đã xóa sản phẩm.");
            } catch (Exception exception) {
                request.getSession().setAttribute("adminError", "Không thể xóa sản phẩm: " + exception.getMessage());
            }
        }
        response.sendRedirect(request.getContextPath() + "/admin/products");
    }

    private String bindAndValidate(HttpServletRequest request, Product product) {
        String name = trim(request.getParameter("productName"));
        String description = trim(request.getParameter("description"));
        Integer categoryId = parseNullableInt(request.getParameter("categoryId"));
        Integer quantity = parseNullableInt(request.getParameter("quantity"));
        BigDecimal price = parsePrice(request.getParameter("price"));
        int status = "0".equals(request.getParameter("status")) ? 0 : 1;

        if (name.length() < 3 || name.length() > 255) return "Tên sản phẩm phải có từ 3 đến 255 ký tự.";
        if (description.length() > 2000) return "Mô tả không được vượt quá 2000 ký tự.";
        if (price == null || price.signum() < 0) return "Giá sản phẩm phải là số không âm.";
        if (quantity == null || quantity < 0) return "Số lượng phải là số nguyên không âm.";
        Category category = categoryId == null ? null : categoryService.findById(categoryId);
        if (category == null) return "Vui lòng chọn danh mục hợp lệ.";

        product.setProductName(name);
        product.setDescription(description);
        product.setPrice(price);
        product.setQuantity(quantity);
        product.setStatus(status);
        product.setCategory(category);
        return null;
    }

    private void showForm(HttpServletRequest request, HttpServletResponse response, Product product, boolean editing)
            throws ServletException, IOException {
        List<Category> categories = categoryService.findAll();
        request.setAttribute("categories", categories);
        request.setAttribute("product", product);
        request.setAttribute("editing", editing);
        request.getRequestDispatcher("/views/admin/product-form.jsp").forward(request, response);
    }

    private int parsePositiveInt(String value, int fallback) {
        try { return Math.max(1, Integer.parseInt(value)); } catch (Exception ignored) { return fallback; }
    }
    private Integer parseNullableInt(String value) {
        try { return value == null || value.isBlank() ? null : Integer.valueOf(value); } catch (NumberFormatException ignored) { return null; }
    }
    private BigDecimal parsePrice(String value) {
        try { return value == null || value.isBlank() ? null : new BigDecimal(value.trim()); } catch (NumberFormatException ignored) { return null; }
    }
    private String trim(String value) { return value == null ? "" : value.trim(); }
    private String trimToNull(String value) { String result = trim(value); return result.isEmpty() ? null : result; }
}
