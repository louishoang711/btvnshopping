package vn.com.btvn.dao;

import java.util.List;
import vn.com.btvn.entity.Product;

public interface IProductDao {
    void insert(Product product);
    void update(Product product);
    void delete(int id) throws Exception;
    Product findById(int id);
    List<Product> findAll();
    List<Product> findLatest(int limit);
    List<Product> findPage(int page, int pageSize, String keyword, Integer categoryId, boolean activeOnly);
    long count(String keyword, Integer categoryId, boolean activeOnly);
}
