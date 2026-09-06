package vn.com.btvn.service.impl;

import java.util.List;

import vn.com.btvn.dao.IProductDao;
import vn.com.btvn.dao.impl.ProductDaoImpl;
import vn.com.btvn.entity.Product;
import vn.com.btvn.service.IProductService;

public class ProductServiceImpl implements IProductService {
    private final IProductDao productDao = new ProductDaoImpl();

    @Override public void insert(Product product) { productDao.insert(product); }
    @Override public void update(Product product) { productDao.update(product); }
    @Override public void delete(int id) throws Exception { productDao.delete(id); }
    @Override public Product findById(int id) { return productDao.findById(id); }
    @Override public List<Product> findAll() { return productDao.findAll(); }
    @Override public List<Product> findLatest(int limit) { return productDao.findLatest(limit); }
    @Override public List<Product> findPage(int page, int pageSize, String keyword, Integer categoryId, boolean activeOnly) {
        return productDao.findPage(page, pageSize, keyword, categoryId, activeOnly);
    }
    @Override public long count(String keyword, Integer categoryId, boolean activeOnly) {
        return productDao.count(keyword, categoryId, activeOnly);
    }
}
