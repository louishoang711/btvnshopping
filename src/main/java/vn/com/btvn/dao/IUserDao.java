package vn.com.btvn.dao;

import java.util.List;
import vn.com.btvn.entity.User;

public interface IUserDao {
    void insert(User user);
    void update(User user);
    void delete(int id) throws Exception;
    User findById(int id);
    User findByUsername(String username);
    List<User> findAll();
}
