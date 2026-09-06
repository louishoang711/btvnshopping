package vn.com.btvn.dao.impl;

import java.util.List;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;
import vn.com.btvn.config.JpaConfig;
import vn.com.btvn.dao.IProductDao;
import vn.com.btvn.entity.Product;

public class ProductDaoImpl implements IProductDao {
    @Override
    public void insert(Product product) {
        executeWrite(entityManager -> entityManager.persist(product));
    }

    @Override
    public void update(Product product) {
        executeWrite(entityManager -> entityManager.merge(product));
    }

    @Override
    public void delete(int id) throws Exception {
        EntityManager entityManager = JpaConfig.getEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();
        try {
            transaction.begin();
            Product product = entityManager.find(Product.class, id);
            if (product == null) {
                throw new Exception("Không tìm thấy sản phẩm.");
            }
            entityManager.remove(product);
            transaction.commit();
        } catch (Exception exception) {
            if (transaction.isActive()) transaction.rollback();
            throw exception;
        } finally {
            entityManager.close();
        }
    }

    @Override
    public Product findById(int id) {
        EntityManager entityManager = JpaConfig.getEntityManager();
        try {
            return entityManager.find(Product.class, id);
        } finally {
            entityManager.close();
        }
    }

    @Override
    public List<Product> findAll() {
        EntityManager entityManager = JpaConfig.getEntityManager();
        try {
            return entityManager.createNamedQuery("Product.findAll", Product.class).getResultList();
        } finally {
            entityManager.close();
        }
    }

    @Override
    public List<Product> findLatest(int limit) {
        EntityManager entityManager = JpaConfig.getEntityManager();
        try {
            return entityManager.createQuery(
                    "SELECT p FROM Product p WHERE p.status = 1 ORDER BY p.createdAt DESC, p.productId DESC",
                    Product.class)
                    .setMaxResults(limit)
                    .getResultList();
        } finally {
            entityManager.close();
        }
    }

    @Override
    public List<Product> findPage(int page, int pageSize, String keyword, Integer categoryId, boolean activeOnly) {
        EntityManager entityManager = JpaConfig.getEntityManager();
        try {
            TypedQuery<Product> query = entityManager.createQuery(
                    "SELECT p FROM Product p" + buildWhere(keyword, categoryId, activeOnly)
                            + " ORDER BY p.createdAt DESC, p.productId DESC",
                    Product.class);
            bindParameters(query, keyword, categoryId);
            return query.setFirstResult(Math.max(0, page) * pageSize)
                    .setMaxResults(pageSize)
                    .getResultList();
        } finally {
            entityManager.close();
        }
    }

    @Override
    public long count(String keyword, Integer categoryId, boolean activeOnly) {
        EntityManager entityManager = JpaConfig.getEntityManager();
        try {
            TypedQuery<Long> query = entityManager.createQuery(
                    "SELECT COUNT(p) FROM Product p" + buildWhere(keyword, categoryId, activeOnly), Long.class);
            bindParameters(query, keyword, categoryId);
            return query.getSingleResult();
        } finally {
            entityManager.close();
        }
    }

    private String buildWhere(String keyword, Integer categoryId, boolean activeOnly) {
        StringBuilder jpql = new StringBuilder(" WHERE 1 = 1");
        if (activeOnly) jpql.append(" AND p.status = 1");
        if (keyword != null && !keyword.isBlank()) jpql.append(" AND LOWER(p.productName) LIKE :keyword");
        if (categoryId != null) jpql.append(" AND p.category.categoryId = :categoryId");
        return jpql.toString();
    }

    private void bindParameters(TypedQuery<?> query, String keyword, Integer categoryId) {
        if (keyword != null && !keyword.isBlank()) query.setParameter("keyword", "%" + keyword.trim().toLowerCase() + "%");
        if (categoryId != null) query.setParameter("categoryId", categoryId);
    }

    private void executeWrite(EntityAction action) {
        EntityManager entityManager = JpaConfig.getEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();
        try {
            transaction.begin();
            action.execute(entityManager);
            transaction.commit();
        } catch (RuntimeException exception) {
            if (transaction.isActive()) transaction.rollback();
            throw exception;
        } finally {
            entityManager.close();
        }
    }

    @FunctionalInterface
    private interface EntityAction {
        void execute(EntityManager entityManager);
    }
}
