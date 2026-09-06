package vn.com.btvn.config;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import vn.com.btvn.entity.Category;
import vn.com.btvn.entity.User;
import vn.com.btvn.service.IProductService;
import vn.com.btvn.service.IUserService;
import vn.com.btvn.service.impl.ProductServiceImpl;
import vn.com.btvn.service.impl.UserServiceImpl;

public class Test {
    public static void main(String[] args) {
        EntityManager enma = JpaConfig.getEntityManager();
        EntityTransaction trans = enma.getTransaction();
        try {
            trans.begin();
            trans.commit();
            IUserService userService = new UserServiceImpl();
            IProductService productService = new ProductServiceImpl();
            User admin = userService.getOrCreateDefaultUser();
            System.out.println("Kết nối CSDL và tạo bảng thành công!");
            System.out.println("Admin: " + admin.getUsername());
            System.out.println("Số sản phẩm hiện tại: " + productService.count("", null, false));
        } catch (Exception e) {
            e.printStackTrace();
            if (trans.isActive()) trans.rollback();
            throw e;
        } finally {
            enma.close();
            JpaConfig.close();
        }
    }
}
