package vn.com.btvn.config;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import vn.com.btvn.entity.Category;

public class Test {
    public static void main(String[] args) {
        EntityManager enma = JpaConfig.getEntityManager();
        EntityTransaction trans = enma.getTransaction();
        try {
            trans.begin();
            trans.commit();
            System.out.println("Kết nối CSDL và tạo bảng thành công!");
        } catch (Exception e) {
            e.printStackTrace();
            trans.rollback();
            throw e;
        } finally {
            enma.close();
        }
    }
}