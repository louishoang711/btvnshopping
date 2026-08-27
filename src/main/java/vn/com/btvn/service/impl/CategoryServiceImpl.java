package vn.com.btvn.service.impl;

import java.util.List;
import vn.com.btvn.dao.CategoryDao;
import vn.com.btvn.dao.impl.CategoryDaoImpl;
import vn.com.btvn.model.Category;
import vn.com.btvn.service.CategoryService;

public class CategoryServiceImpl implements CategoryService {
    CategoryDao categoryDao = new CategoryDaoImpl();

    @Override
    public void insert(Category category) {
        categoryDao.insert(category);
    }

    @Override
    public void edit(Category category) {
        categoryDao.edit(category);
    }

    @Override
    public void delete(int id) {
        categoryDao.delete(id);
    }

    @Override
    public Category get(int id) {
        return categoryDao.get(id);
    }

    @Override
    public List<Category> getAll() {
        return categoryDao.getAll();
    }
}