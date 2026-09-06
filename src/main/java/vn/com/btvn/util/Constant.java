package vn.com.btvn.util;

import java.nio.file.Path;
import java.nio.file.Paths;

public class Constant {
    private static final String CONFIGURED_UPLOAD_DIR = System.getenv("SHOPPING_UPLOAD_DIR");
    public static final String DIR = CONFIGURED_UPLOAD_DIR == null || CONFIGURED_UPLOAD_DIR.isBlank()
            ? Paths.get(System.getProperty("user.home"), "btvnshopping-uploads").toString()
            : Path.of(CONFIGURED_UPLOAD_DIR).toAbsolutePath().normalize().toString();

    private Constant() {
    }
}
