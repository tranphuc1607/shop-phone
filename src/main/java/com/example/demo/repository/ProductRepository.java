package com.example.demo.repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.sql.Statement;


import org.springframework.stereotype.Repository;

import com.example.demo.config.ConnectionPoolImlp;
import com.example.demo.entity.Brand;
import com.example.demo.entity.Product;
import com.example.demo.entity.ProductImage;
import com.example.demo.entity.ProductSpecification;

@Repository
public class ProductRepository {
       public List<Brand> getAllBrands() throws SQLException {
        Connection connection = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        List<Brand> brands = new ArrayList<>();
    
        try {
            connection = ConnectionPoolImlp.getInstance().getConnection(); // Lấy kết nối từ Connection Pool
    
            String sql = "SELECT id, name FROM brand"; // SQL truy vấn lấy tất cả brand
            ps = connection.prepareStatement(sql);
            rs = ps.executeQuery(); // Thực thi truy vấn và lấy kết quả
    
            while (rs.next()) {
                int id = rs.getInt("id"); // Lấy id của brand
                String name = rs.getString("name"); // Lấy tên của brand
    
                // Tạo đối tượng Brand và thêm vào danh sách
                Brand brand = new Brand(id, name);
                brands.add(brand);
            }
    
        } catch (SQLException e) {
            throw new SQLException("Error fetching brands", e);
        } finally {
            // Đảm bảo rằng tài nguyên được đóng khi không sử dụng nữa
            if (rs != null) try { rs.close(); } catch (SQLException ignored) {}
            if (ps != null) try { ps.close(); } catch (SQLException ignored) {}
            if (connection != null) ConnectionPoolImlp.getInstance().releaseConnection(connection); // Trả kết nối lại cho pool
        }
    
        return brands; // Trả về danh sách các brand
    }

    public void saveProduct(Product product) throws SQLException {
    Connection conn = null;
    PreparedStatement psProduct = null;
    PreparedStatement psSpec = null;
    PreparedStatement psImage = null;

    try {
        conn = ConnectionPoolImlp.getInstance().getConnection();
        conn.setAutoCommit(false);

        // 1. Insert product
        String sqlProduct = "INSERT INTO products (name, description, price, stock_quantity, created_at, brand_id) VALUES (?, ?, ?, ?, ?, ?)";
        psProduct = conn.prepareStatement(sqlProduct, Statement.RETURN_GENERATED_KEYS);
        psProduct.setString(1, product.getName());
        psProduct.setString(2, product.getDescription());
        psProduct.setBigDecimal(3, product.getPrice());
        psProduct.setInt(4, product.getStockQuantity());
        psProduct.setString(5, product.getCreatedAt());
        psProduct.setInt(6, product.getBrand().getId());

        psProduct.executeUpdate();

        ResultSet rs = psProduct.getGeneratedKeys();
        int productId = -1;
        if (rs.next()) {
            productId = rs.getInt(1);
            product.setId(productId); // gán lại ID cho product
        }

        // 2. Insert specification
        ProductSpecification spec = product.getSpecification();
        if (spec != null) {
            String sqlSpec = "INSERT INTO product_specification (ram, storage, screen, battery, os, chipset, product_id) VALUES (?, ?, ?, ?, ?, ?, ?)";
            psSpec = conn.prepareStatement(sqlSpec);
            psSpec.setString(1, spec.getRam());
            psSpec.setString(2, spec.getStorage());
            psSpec.setString(3, spec.getScreen());
            psSpec.setString(4, spec.getBattery());
            psSpec.setString(5, spec.getOs());
            psSpec.setString(6, spec.getChipset());
            psSpec.setInt(7, productId);

            psSpec.executeUpdate();
        }

        // 3. Insert product images
        List<ProductImage> images = product.getImages();
        if (images != null && !images.isEmpty()) {
            String sqlImage = "INSERT INTO product_image (url, is_primary, product_id) VALUES (?, ?, ?)";
            psImage = conn.prepareStatement(sqlImage);
            for (ProductImage image : images) {
                psImage.setString(1, image.getUrl());
                psImage.setBoolean(2, image.getIsPrimary() != null && image.getIsPrimary());
                psImage.setInt(3, productId);
                psImage.addBatch();
            }
            psImage.executeBatch();
        }

        conn.commit();

    } catch (SQLException e) {
        if (conn != null) conn.rollback();
        throw e;
    } finally {
        if (psProduct != null) psProduct.close();
        if (psSpec != null) psSpec.close();
        if (psImage != null) psImage.close();
        if (conn != null) ConnectionPoolImlp.getInstance().releaseConnection(conn);
    }
}

    public void save(Product newProduct) {
        // TODO Auto-generated method stub
        throw new UnsupportedOperationException("Unimplemented method 'save'");
    }

}
