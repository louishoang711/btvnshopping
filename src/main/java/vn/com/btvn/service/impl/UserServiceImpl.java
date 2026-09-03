package vn.com.btvn.service.impl;

import java.util.List;
import vn.com.btvn.dao.IUserDao;
import vn.com.btvn.dao.impl.UserDaoImpl;
import vn.com.btvn.entity.User;
import vn.com.btvn.service.IUserService;

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
    public List<User> findAll() {
        return userDao.findAll();
    }

    @Override
    public synchronized User getOrCreateDefaultUser() {
        List<User> list = userDao.findAll();
        if (list != null && !list.isEmpty()) {
            return list.get(0);
        }
        // Tạo user mặc định nếu chưa có
        User defaultUser = new User();
        defaultUser.setUsername("admin");
        defaultUser.setPassword("123456");
        defaultUser.setFullname("Nguyễn Văn A");
        defaultUser.setPhone("0912345678");
        defaultUser.setEmail("admin@btvnshopping.com");
        defaultUser.setImages("https://cdn-icons-png.flaticon.com/512/3135/3135715.png");
        defaultUser.setRole(1);
        userDao.insert(defaultUser);
        return defaultUser;
    }
}
