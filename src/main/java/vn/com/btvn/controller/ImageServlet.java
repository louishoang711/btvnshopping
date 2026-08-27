package vn.com.btvn.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
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
        if (fileName != null) {
            File file = new File(Constant.DIR + File.separator + fileName);
            if (file.exists()) {
                resp.setContentType("image/jpeg");
                try (FileInputStream fis = new FileInputStream(file);
                     OutputStream os = resp.getOutputStream()) {
                    byte[] buffer = new byte[1024];
                    int len;
                    while ((len = fis.read(buffer)) != -1) {
                        os.write(buffer, 0, len);
                    }
                }
            }
        }
    }
}