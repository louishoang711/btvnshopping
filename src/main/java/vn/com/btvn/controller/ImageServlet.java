package vn.com.btvn.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.com.btvn.util.Constant;

@WebServlet(urlPatterns = { "/image" })
public class ImageServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String fileName = req.getParameter("fname");
        if (fileName != null && !fileName.isBlank()) {
            Path uploadRoot = Path.of(Constant.DIR).toAbsolutePath().normalize();
            Path requested = uploadRoot.resolve(new File(fileName).getName()).normalize();
            if (!requested.startsWith(uploadRoot)) {
                resp.sendError(HttpServletResponse.SC_BAD_REQUEST);
                return;
            }
            File file = requested.toFile();
            if (file.isFile()) {
                String contentType = Files.probeContentType(requested);
                resp.setContentType(contentType == null ? "application/octet-stream" : contentType);
                resp.setHeader("Cache-Control", "public, max-age=86400");
                try (FileInputStream fis = new FileInputStream(file);
                     OutputStream os = resp.getOutputStream()) {
                    byte[] buffer = new byte[1024];
                    int len;
                    while ((len = fis.read(buffer)) != -1) {
                        os.write(buffer, 0, len);
                    }
                }
            } else {
                resp.sendError(HttpServletResponse.SC_NOT_FOUND);
            }
        } else {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST);
        }
    }
}
