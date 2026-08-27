package vn.com.btvn.dao;

import java.util.List;
import vn.com.btvn.model.Category;

public interface CategoryDao {
    void insert(Category category);
    void edit(Category category);
    void delete(int id);
    Category get(int id);
    List<Category> getAll();
}