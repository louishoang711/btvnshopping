package vn.com.btvn.config;

import java.util.HashMap;
import java.util.Map;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

public class JpaConfig {
    private static final EntityManagerFactory FACTORY =
            Persistence.createEntityManagerFactory("jpa-hibernate-mysql", connectionProperties());

    private JpaConfig() {
    }

    public static EntityManager getEntityManager() {
        return FACTORY.createEntityManager();
    }

    public static void close() {
        if (FACTORY.isOpen()) {
            FACTORY.close();
        }
    }

    private static Map<String, Object> connectionProperties() {
        Map<String, Object> properties = new HashMap<>();
        putIfPresent(properties, "jakarta.persistence.jdbc.url", "DB_URL");
        putIfPresent(properties, "jakarta.persistence.jdbc.user", "DB_USERNAME");
        putIfPresent(properties, "jakarta.persistence.jdbc.password", "DB_PASSWORD");
        return properties;
    }

    private static void putIfPresent(Map<String, Object> properties, String key, String environmentName) {
        String value = System.getenv(environmentName);
        if (value != null && !value.isBlank()) {
            properties.put(key, value);
        }
    }
}
