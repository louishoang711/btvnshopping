package vn.com.btvn.controller;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.regex.Pattern;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import vn.com.btvn.entity.User;
import vn.com.btvn.service.IUserService;
import vn.com.btvn.service.impl.UserServiceImpl;
import vn.com.btvn.util.Constant;

@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2,  // 2MB
    maxFileSize = 1024 * 1024 * 10,       // 10MB
    maxRequestSize = 1024 * 1024 * 50     // 50MB
)
@WebServlet(urlPatterns = { "/profile", "/profile/update" })
public class ProfileController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private IUserService userService = new UserServiceImpl();

    // Regex kiểm tra số điện thoại Việt Nam (10 chữ số, bắt đầu bằng 0)
    private static final Pattern PHONE_PATTERN = Pattern.compile("^(0|\\+84)[3|5|7|8|9][0-9]{8}$");

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User user = userService.getOrCreateDefaultUser();
        req.setAttribute("user", user);
        req.getRequestDispatcher("/views/profile.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String idStr = req.getParameter("id");
        String fullname = req.getParameter("fullname");
        String phone = req.getParameter("phone");
        String imageUrl = req.getParameter("images");

        User user = null;
        if (idStr != null && !idStr.isEmpty()) {
            try {
                user = userService.findById(Integer.parseInt(idStr));
            } catch (Exception ignored) {}
        }
        if (user == null) {
            user = userService.getOrCreateDefaultUser();
        }

        // 1. Server-side Validation: Kiểm tra fullname
        if (fullname == null || fullname.trim().length() < 2) {
            req.setAttribute("error", "Họ và tên không được để trống và phải có ít nhất 2 ký tự!");
            req.setAttribute("user", user);
            req.getRequestDispatcher("/views/profile.jsp").forward(req, resp);
            return;
        }

        // 2. Server-side Validation: Kiểm tra số điện thoại hợp lệ
        if (phone == null || !PHONE_PATTERN.matcher(phone.trim()).matches()) {
            req.setAttribute("error", "Số điện thoại không hợp lệ! Vui lòng nhập đúng 10 số (bắt đầu bằng 03, 05, 07, 08, 09).");
            user.setFullname(fullname.trim());
            req.setAttribute("user", user);
            req.getRequestDispatcher("/views/profile.jsp").forward(req, resp);
            return;
        }

        // 3. Xử lý upload ảnh đại diện (Multipart)
        String uploadPath = Constant.DIR;
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        String fileOld = user.getImages();
        try {
            Part part = req.getPart("imageFile");
            if (part != null && part.getSize() > 0) {
                String submittedFileName = Paths.get(part.getSubmittedFileName()).getFileName().toString();
                int index = submittedFileName.lastIndexOf(".");
                String ext = (index != -1) ? submittedFileName.substring(index + 1).toLowerCase() : "jpg";

                // Kiểm tra định dạng file ảnh
                if (!ext.matches("^(jpg|jpeg|png|gif|webp)$")) {
                    req.setAttribute("error", "Chỉ chấp nhận các định dạng ảnh: JPG, PNG, GIF, WEBP!");
                    user.setFullname(fullname.trim());
                    user.setPhone(phone.trim());
                    req.setAttribute("user", user);
                    req.getRequestDispatcher("/views/profile.jsp").forward(req, resp);
                    return;
                }

                String newFileName = "user_" + System.currentTimeMillis() + "." + ext;
                part.write(uploadPath + File.separator + newFileName);

                // Xóa ảnh cũ nếu là ảnh upload cục bộ
                if (fileOld != null && !fileOld.startsWith("http")) {
                    try {
                        Files.deleteIfExists(Paths.get(uploadPath + File.separator + fileOld));
                    } catch (Exception ignored) {}
                }
                user.setImages(newFileName);
            } else if (imageUrl != null && !imageUrl.trim().isEmpty()) {
                user.setImages(imageUrl.trim());
            }
        } catch (FileNotFoundException fne) {
            fne.printStackTrace();
        }

        // 4. Cập nhật thông tin vào User
        user.setFullname(fullname.trim());
        user.setPhone(phone.trim());

        // 5. Lưu vào Database qua JPA
        try {
            userService.update(user);
            req.setAttribute("message", "Cập nhật thông tin cá nhân thành công!");
        } catch (Exception e) {
            req.setAttribute("error", "Lỗi khi cập nhật cơ sở dữ liệu: " + e.getMessage());
        }

        req.setAttribute("user", user);
        req.getRequestDispatcher("/views/profile.jsp").forward(req, resp);
    }
}
