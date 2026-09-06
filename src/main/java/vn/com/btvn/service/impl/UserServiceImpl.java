package vn.com.btvn.service.impl;

import java.util.List;
import vn.com.btvn.dao.IUserDao;
import vn.com.btvn.dao.impl.UserDaoImpl;
import vn.com.btvn.entity.User;
import vn.com.btvn.service.IUserService;
import vn.com.btvn.util.PasswordUtil;

public class UserServiceImpl implements IUserService {

    private IUserDao userDao = new UserDaoImpl();

    @Override
    public void insert(User user) {
        userDao.insert(user);
    }

    @Override
    public void update(User user) {
        userDao.update(user);
    }

    @Override
    public void delete(int id) throws Exception {
        userDao.delete(id);
    }

    @Override
    public User findById(int id) {
        return userDao.findById(id);
    }

    @Override
    public User findByUsername(String username) {
        return userDao.findByUsername(username);
    }

    @Override
    public User findByEmail(String email) {
        return userDao.findByEmail(email);
    }

    @Override
    public User authenticate(String usernameOrEmail, String password) {
        if (usernameOrEmail == null || password == null) return null;
        User user = usernameOrEmail.contains("@")
                ? userDao.findByEmail(usernameOrEmail)
                : userDao.findByUsername(usernameOrEmail.trim());
        if (user == null || !PasswordUtil.matches(password, user.getPassword())) return null;

        // Existing records created before account activation was added are treated as verified.
        boolean needsActivationMigration = !user.hasActivationState();
        if (needsActivationMigration) {
            user.setActive(1);
        }
        if (!PasswordUtil.isEncoded(user.getPassword())) {
            user.setPassword(PasswordUtil.hash(password));
            userDao.update(user);
        } else if (needsActivationMigration) {
            userDao.update(user);
        }
        return user;
    }

    @Override
    public User register(User user) {
        if (findByUsername(user.getUsername()) != null) {
            throw new IllegalArgumentException("Tên đăng nhập đã tồn tại.");
        }
        if (findByEmail(user.getEmail()) != null) {
            throw new IllegalArgumentException("Email đã được sử dụng.");
        }
        user.setPassword(PasswordUtil.hash(user.getPassword()));
        user.setActive(0);
        user.setRole(0);
        userDao.insert(user);
        return user;
    }

    @Override
    public void activate(int userId) {
        User user = findById(userId);
        if (user == null) throw new IllegalArgumentException("Không tìm thấy tài khoản.");
        user.setActive(1);
        userDao.update(user);
    }

    @Override
    public void changePassword(int userId, String newPassword) {
        User user = findById(userId);
        if (user == null) throw new IllegalArgumentException("Không tìm thấy tài khoản.");
        user.setPassword(PasswordUtil.hash(newPassword));
        userDao.update(user);
    }

    @Override
    public List<User> findAll() {
        return userDao.findAll();
    }

    @Override
    public synchronized User getOrCreateDefaultUser() {
        User existingAdmin = userDao.findByUsername("admin");
        if (existingAdmin != null) return existingAdmin;
        // Tạo user mặc định nếu chưa có
        User defaultUser = new User();
        defaultUser.setUsername("admin");
        defaultUser.setPassword("123456");
        defaultUser.setFullname("Nguyễn Văn A");
        defaultUser.setPhone("0912345678");
        defaultUser.setEmail("admin@hcmute-shop.local");
        defaultUser.setImages("https://cdn-icons-png.flaticon.com/512/3135/3135715.png");
        defaultUser.setRole(1);
        defaultUser.setActive(1);
        defaultUser.setPassword(PasswordUtil.hash(defaultUser.getPassword()));
        userDao.insert(defaultUser);
        return defaultUser;
    }
}
