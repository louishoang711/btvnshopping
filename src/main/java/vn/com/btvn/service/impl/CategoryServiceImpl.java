package vn.com.btvn.service.impl;

import java.util.List;
import vn.com.btvn.dao.ICategoryDao;
import vn.com.btvn.dao.impl.CategoryDaoImpl;
import vn.com.btvn.entity.Category;
import vn.com.btvn.service.ICategoryService;

public class CategoryServiceImpl implements ICategoryService {
    public ICategoryDao cateDao = new CategoryDaoImpl();

    @Override
    public List<Category> findAll() { return cateDao.findAll(); }

    @Override
    public Category findById(int id) { return cateDao.findById(id); }

    @Override
    public List<Category> searchByName(String keyword) { return cateDao.searchByName(keyword); }

    @Override
    public void insert(Category category) {
        Category cate = this.findByCategoryname(category.getCategoryname());
        if (cate == null) {
            cateDao.insert(category);
        }
    }

    @Override
    public void update(Category category) {
        Category cate = this.findById(category.getCategoryId());
        if (cate != null) {
            cateDao.update(category);
        }
    }

    @Override
    public void delete(int id) throws Exception {
        cateDao.delete(id);
    }

    @Override
    public int count() { return cateDao.count(); }

    @Override
    public List<Category> findAll(int page, int pagesize) { return cateDao.findAll(page, pagesize); }

    @Override
    public Category findByCategoryname(String name) {
        try {
            return cateDao.findByCategoryname(name);
        } catch (Exception e) {
            return null;
        }
    }
}
