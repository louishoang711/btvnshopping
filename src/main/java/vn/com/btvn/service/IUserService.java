package vn.com.btvn.service;

import java.util.List;
import vn.com.btvn.entity.User;

public interface IUserService {
    void insert(User user);
    void update(User user);
    void delete(int id) throws Exception;
    User findById(int id);
    User findByUsername(String username);
    User findByEmail(String email);
    User authenticate(String usernameOrEmail, String password);
    User register(User user);
    void activate(int userId);
    void changePassword(int userId, String newPassword);
    List<User> findAll();
    User getOrCreateDefaultUser();
}
