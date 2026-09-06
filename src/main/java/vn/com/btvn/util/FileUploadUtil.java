package vn.com.btvn.util;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Set;
import java.util.UUID;

import jakarta.servlet.http.Part;

public final class FileUploadUtil {
    private static final Set<String> IMAGE_EXTENSIONS = Set.of("jpg", "jpeg", "png", "gif", "webp");
    private static final long MAX_IMAGE_SIZE = 10L * 1024 * 1024;

    private FileUploadUtil() {
    }

    public static String saveImage(Part part, String prefix) throws IOException {
        if (part == null || part.getSize() == 0) return null;
        if (part.getSize() > MAX_IMAGE_SIZE) throw new IllegalArgumentException("Ảnh không được vượt quá 10MB.");
        String original = Paths.get(part.getSubmittedFileName()).getFileName().toString();
        int dot = original.lastIndexOf('.');
        String extension = dot >= 0 ? original.substring(dot + 1).toLowerCase() : "";
        if (!IMAGE_EXTENSIONS.contains(extension)) {
            throw new IllegalArgumentException("Chỉ chấp nhận ảnh JPG, PNG, GIF hoặc WEBP.");
        }
        Files.createDirectories(Path.of(Constant.DIR));
        String fileName = prefix + "_" + UUID.randomUUID().toString().replace("-", "") + "." + extension;
        part.write(Path.of(Constant.DIR, fileName).toString());
        return fileName;
    }

    public static void deleteLocalImage(String fileName) {
        if (fileName == null || fileName.isBlank() || fileName.startsWith("http")) return;
        try {
            Path uploadRoot = Path.of(Constant.DIR).toAbsolutePath().normalize();
            Path file = uploadRoot.resolve(new File(fileName).getName()).normalize();
            if (file.startsWith(uploadRoot)) Files.deleteIfExists(file);
        } catch (IOException ignored) {
        }
    }
}
