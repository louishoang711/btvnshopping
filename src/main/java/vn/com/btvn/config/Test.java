package vn.com.btvn.config;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import vn.com.btvn.entity.Category;
import vn.com.btvn.entity.Video;

public class Test {
    public static void main(String[] args) {
        EntityManager enma = JpaConfig.getEntityManager();
        EntityTransaction trans = enma.getTransaction();
        
        Category cate = new Category();
        cate.setCategoryname("Dien thoai");
        cate.setImages("dienthoai.jpg");
        cate.setStatus(1);
        
        Video video = new Video();
        video.setVideoId("v01");
        video.setTitle("Review iPhone");
        video.setCategory(cate);
        
        try {
            trans.begin();
            enma.persist(cate);
            enma.persist(video);
            trans.commit();
            System.out.println("Tạo bảng và thêm dữ liệu thành công!");
        } catch (Exception e) {
            e.printStackTrace();
            trans.rollback();
        } finally {
            enma.close();
        }
    }
}