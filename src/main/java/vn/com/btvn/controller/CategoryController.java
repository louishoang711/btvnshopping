package vn.com.btvn.controller;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import java.util.Objects;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import vn.com.btvn.entity.Category;
import vn.com.btvn.service.ICategoryService;
import vn.com.btvn.service.impl.CategoryServiceImpl;
import vn.com.btvn.util.Constant;
import vn.com.btvn.util.FileUploadUtil;

@MultipartConfig(maxFileSize = 10L * 1024 * 1024, maxRequestSize = 12L * 1024 * 1024)
@WebServlet(urlPatterns = { "/admin/categories", "/admin/category/add", "/admin/category/insert",
        "/admin/category/edit", "/admin/category/update", "/admin/category/delete" })
public class CategoryController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    public ICategoryService cateService = new CategoryServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String url = req.getRequestURI();
        if (url.contains("/admin/categories")) {
            List<Category> list = cateService.findAll();
            req.setAttribute("listcate", list);
            req.getRequestDispatcher("/views/admin/category-list.jsp").forward(req, resp);
        } else if (url.contains("/admin/category/add")) {
            req.getRequestDispatcher("/views/admin/category-add.jsp").forward(req, resp);
        } else if (url.contains("/admin/category/edit")) {
            int id;
            try { id = Integer.parseInt(req.getParameter("id")); }
            catch (Exception exception) { resp.sendError(HttpServletResponse.SC_BAD_REQUEST); return; }
            Category category = cateService.findById(id);
            if (category == null) { resp.sendError(HttpServletResponse.SC_NOT_FOUND); return; }
            req.setAttribute("cate", category);
            req.getRequestDispatcher("/views/admin/category-edit.jsp").forward(req, resp);
        } else if (url.contains("/admin/category/delete")) {
            int id = Integer.parseInt(req.getParameter("id"));
            try {
                cateService.delete(id);
                req.getSession().setAttribute("adminMessage", "Đã xóa danh mục.");
            } catch (Exception e) {
                req.getSession().setAttribute("adminError", "Không thể xóa danh mục đang có sản phẩm.");
            }
            resp.sendRedirect(req.getContextPath() + "/admin/categories");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        String url = req.getRequestURI();

        if (url.contains("/admin/category/insert")) {
            String categoryname = req.getParameter("categoryname");
            String statusStr = req.getParameter("status");
            String images = req.getParameter("images");

            // Server-side validation
            if (categoryname == null || categoryname.trim().length() < 3) {
                req.setAttribute("error", "Tên danh mục không được để trống và phải có ít nhất 3 ký tự!");
                req.setAttribute("categoryname", categoryname);
                req.getRequestDispatcher("/views/admin/category-add.jsp").forward(req, resp);
                return;
            }
            if (categoryname.trim().length() > 200) {
                req.setAttribute("error", "Tên danh mục không được vượt quá 200 ký tự.");
                req.setAttribute("categoryname", categoryname);
                req.getRequestDispatcher("/views/admin/category-add.jsp").forward(req, resp);
                return;
            }
            if (cateService.findByCategoryname(categoryname.trim()) != null) {
                req.setAttribute("error", "Tên danh mục đã tồn tại.");
                req.setAttribute("categoryname", categoryname);
                req.getRequestDispatcher("/views/admin/category-add.jsp").forward(req, resp);
                return;
            }

            int status = 1;
            try {
                if (statusStr != null) status = Integer.parseInt(statusStr);
            } catch (NumberFormatException ignored) {}

            Category category = new Category();
            category.setCategoryname(categoryname.trim());
            category.setStatus(status);

            String uploadPath = Constant.DIR;
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdirs();

            try {
                String uploaded = FileUploadUtil.saveImage(req.getPart("images1"), "category");
                if (uploaded != null) {
                    category.setImages(uploaded);
                } else if (images != null && !images.trim().isEmpty()) {
                    category.setImages(images.trim());
                } else {
                    category.setImages(null);
                }
            } catch (IllegalArgumentException exception) {
                req.setAttribute("error", exception.getMessage());
                req.setAttribute("categoryname", categoryname);
                req.getRequestDispatcher("/views/admin/category-add.jsp").forward(req, resp);
                return;
            }

            cateService.insert(category);
            req.getSession().setAttribute("adminMessage", "Đã thêm danh mục mới.");
            resp.sendRedirect(req.getContextPath() + "/admin/categories");
            return;
        }

        if (url.contains("/admin/category/update")) {
            int categoryid = Integer.parseInt(req.getParameter("categoryid"));
            String categoryname = req.getParameter("categoryname");
            String statusStr = req.getParameter("status");
            String images = req.getParameter("images");

            Category category = cateService.findById(categoryid);
            if (category == null) { resp.sendError(HttpServletResponse.SC_NOT_FOUND); return; }

            // Server-side validation
            if (categoryname == null || categoryname.trim().length() < 3 || categoryname.trim().length() > 200) {
                req.setAttribute("error", "Tên danh mục không được để trống và phải có ít nhất 3 ký tự!");
                req.setAttribute("cate", category);
                req.getRequestDispatcher("/views/admin/category-edit.jsp").forward(req, resp);
                return;
            }
            Category sameName = cateService.findByCategoryname(categoryname.trim());
            if (sameName != null && sameName.getCategoryId() != categoryid) {
                req.setAttribute("error", "Tên danh mục đã tồn tại.");
                req.setAttribute("cate", category);
                req.getRequestDispatcher("/views/admin/category-edit.jsp").forward(req, resp);
                return;
            }

            int status = category.getStatus();
            try {
                if (statusStr != null) status = Integer.parseInt(statusStr);
            } catch (NumberFormatException ignored) {}

            String fileold = category.getImages();
            category.setCategoryname(categoryname.trim());
            category.setStatus(status);

            String uploadPath = Constant.DIR;
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdirs();

            try {
                String uploaded = FileUploadUtil.saveImage(req.getPart("images1"), "category");
                if (uploaded != null) {
                    category.setImages(uploaded);
                } else if (images != null && !images.isEmpty()) {
                    category.setImages(images);
                } else {
                    category.setImages(fileold);
                }
            } catch (IllegalArgumentException exception) {
                req.setAttribute("error", exception.getMessage());
                req.setAttribute("cate", category);
                req.getRequestDispatcher("/views/admin/category-edit.jsp").forward(req, resp);
                return;
            }

            cateService.update(category);
            if (!Objects.equals(fileold, category.getImages())) FileUploadUtil.deleteLocalImage(fileold);
            req.getSession().setAttribute("adminMessage", "Đã cập nhật danh mục.");
            resp.sendRedirect(req.getContextPath() + "/admin/categories");
        }
    }

    public static void deleteFile(String filePath) throws IOException {
        Path path = Paths.get(filePath);
        Files.deleteIfExists(path);
    }
}
