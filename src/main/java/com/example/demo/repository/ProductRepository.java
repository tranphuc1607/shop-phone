package com.example.demo.repository;

//import java.math.BigDecimal;
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
        String sqlProduct = "INSERT INTO product (name, description, created_at, price, stock_quantity, image, brand_id) VALUES (?, ?, ?, ?, ?, ?, ?)";
        psProduct = conn.prepareStatement(sqlProduct, Statement.RETURN_GENERATED_KEYS);
        
        psProduct.setString(1, product.getName());
        psProduct.setString(2, product.getDescription());
        psProduct.setString(3, product.getCreatedAt());
        psProduct.setString(4, product.getPrice());
        psProduct.setString(5, product.getStockQuantity());
        psProduct.setString(6, product.getImage());
        psProduct.setInt(7, product.getBrand().getId());

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

    public List<Product> getAllProducts() throws SQLException {
        Connection connection = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        List<Product> products = new ArrayList<>();
    
        try {
            connection = ConnectionPoolImlp.getInstance().getConnection(); // Lấy kết nối từ pool
    
            String sql = "SELECT " +
                         "p.id, p.name, p.description, p.price, p.stock_quantity, p.image, " +
                         "b.id AS brand_id, b.name AS brand_name " +
                         "FROM product p " +
                         "JOIN brand b ON p.brand_id = b.id";
    
            ps = connection.prepareStatement(sql);
            rs = ps.executeQuery();
    
            while (rs.next()) {
                int id = rs.getInt("id");
                String name = rs.getString("name");
                String description = rs.getString("description");
                String price = rs.getString("price");
                String stockQuantity = rs.getString("stock_quantity");
                String image = rs.getString("image");
                int brandId = rs.getInt("brand_id");
                String brandName = rs.getString("brand_name");
    
                // Tạo đối tượng Product
                Product product = new Product();
                product.setId(id);
                product.setName(name);
                product.setDescription(description);
                product.setPrice(price);
                product.setStockQuantity(stockQuantity);
                product.setImage(image);
    
                // Tạo đối tượng Brand và gán vào Product
                Brand brand = new Brand();
                brand.setId(brandId);
                brand.setName(brandName);
                product.setBrand(brand);
    
                products.add(product);
            }
    
        } catch (SQLException e) {
            throw new SQLException("Error fetching products", e);
        } finally {
            // Đóng tài nguyên
            if (rs != null) try { rs.close(); } catch (SQLException ignored) {}
            if (ps != null) try { ps.close(); } catch (SQLException ignored) {}
            if (connection != null) ConnectionPoolImlp.getInstance().releaseConnection(connection);
        }
    
        return products;
    }
    
    public Product findProductById(int productId) throws SQLException {
    Connection connection = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    Product product = null;

    try {
        connection = ConnectionPoolImlp.getInstance().getConnection();

        String sql = "SELECT " +
                     "p.id, p.name, p.description, p.price, p.stock_quantity, p.image, p.created_at, " +
                     "b.id AS brand_id, b.name AS brand_name, " +
                     "s.id AS spec_id, s.ram, s.storage, s.screen, s.battery, s.os, s.chipset " +
                     "FROM product p " +
                     "JOIN brand b ON p.brand_id = b.id " +
                     "LEFT JOIN product_specification s ON p.id = s.product_id " +
                     "WHERE p.id = ?";

        ps = connection.prepareStatement(sql);
        ps.setInt(1, productId);
        rs = ps.executeQuery();

        if (rs.next()) {
            // Brand
            Brand brand = new Brand();
            brand.setId(rs.getInt("brand_id"));
            brand.setName(rs.getString("brand_name"));

            // Product
            product = new Product();
            product.setId(rs.getInt("id"));
            product.setName(rs.getString("name"));
            product.setDescription(rs.getString("description"));
            product.setPrice(rs.getString("price"));
            product.setStockQuantity(rs.getString("stock_quantity"));
            product.setImage(rs.getString("image"));
            product.setCreatedAt(rs.getString("created_at"));
            product.setBrand(brand);

            // Specification
            //int specId = rs.getInt("spec_id");

            ProductSpecification spec = new ProductSpecification();
            spec.setRam(rs.getString("ram"));
            spec.setStorage(rs.getString("storage"));
            spec.setScreen(rs.getString("screen"));
            spec.setBattery(rs.getString("battery"));
            spec.setOs(rs.getString("os"));
            spec.setChipset(rs.getString("chipset"));
            spec.setProduct(product); // liên kết ngược
            product.setSpecification(spec);
            
        }

    } catch (SQLException e) {
        throw new SQLException("Error finding product by id: " + productId, e);
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException ignored) {}
        if (ps != null) try { ps.close(); } catch (SQLException ignored) {}
        if (connection != null) ConnectionPoolImlp.getInstance().releaseConnection(connection);
    }

    return product;
}

public void updateProductQuantity(int productId, int newQuantity) throws SQLException {
    Connection conn = null;
    PreparedStatement ps = null;

    try {
        conn = ConnectionPoolImlp.getInstance().getConnection();
        String sql = "UPDATE product SET stock_quantity = stock_quantity - ? WHERE id = ? AND stock_quantity >= ?";
        ps = conn.prepareStatement(sql);
        ps.setInt(1, newQuantity);
        ps.setInt(2, productId);
        ps.setInt(3, newQuantity); // Đảm bảo rằng số lượng tồn kho không âm
        int rowsUpdated = ps.executeUpdate();
        conn.commit(); // Commit the transaction
        if (rowsUpdated == 0) {
            throw new SQLException("Không tìm thấy sản phẩm với ID = " + productId);
        }

    } catch (SQLException e) {
        throw new SQLException("Error updating product quantity", e);
    } finally {
        if (ps != null) ps.close();
        if (conn != null) ConnectionPoolImlp.getInstance().releaseConnection(conn);
    }
}


public void updateProduct(Product product) throws SQLException {
    Connection conn = null;
    PreparedStatement psUpdateProduct = null;
    PreparedStatement psUpdateSpec = null;

    try {
        conn = ConnectionPoolImlp.getInstance().getConnection();
        conn.setAutoCommit(false);

        // 1. Update product table
        String sqlUpdateProduct = "UPDATE product SET name=?, description=?, price=?, stock_quantity=?, image=?, brand_id=? WHERE id=?";
        psUpdateProduct = conn.prepareStatement(sqlUpdateProduct);

        psUpdateProduct.setString(1, product.getName());
        psUpdateProduct.setString(2, product.getDescription());
        psUpdateProduct.setString(3, product.getPrice());
        psUpdateProduct.setString(4, product.getStockQuantity());
        psUpdateProduct.setString(5, product.getImage());
        psUpdateProduct.setInt(6, product.getBrand().getId());
        psUpdateProduct.setInt(7, product.getId());

        int updatedRows = psUpdateProduct.executeUpdate();

        if (updatedRows == 0) {
            throw new SQLException("Không tìm thấy sản phẩm để cập nhật với ID = " + product.getId());
        }

        // 2. Update specification table
        String sqlUpdateSpec = "UPDATE product_specification SET ram=?, storage=?, screen=?, battery=?, os=?, chipset=? WHERE product_id=?";
        psUpdateSpec = conn.prepareStatement(sqlUpdateSpec);

        psUpdateSpec.setString(1, product.getSpecification().getRam());
        psUpdateSpec.setString(2, product.getSpecification().getStorage());
        psUpdateSpec.setString(3, product.getSpecification().getScreen());
        psUpdateSpec.setString(4, product.getSpecification().getBattery());
        psUpdateSpec.setString(5, product.getSpecification().getOs());
        psUpdateSpec.setString(6, product.getSpecification().getChipset());
        psUpdateSpec.setInt(7, product.getId());

        int updatedSpecRows = psUpdateSpec.executeUpdate();

        if (updatedSpecRows == 0) {
            // Nếu không có bản ghi specs hiện tại, có thể insert mới (tùy nghiệp vụ)
            String sqlInsertSpec = "INSERT INTO specification (product_id, ram, storage, screen, battery, os, chipset) VALUES (?, ?, ?, ?, ?, ?, ?)";
            try (PreparedStatement psInsertSpec = conn.prepareStatement(sqlInsertSpec)) {
                psInsertSpec.setInt(1, product.getId());
                psInsertSpec.setString(2, product.getSpecification().getRam());
                psInsertSpec.setString(3, product.getSpecification().getStorage());
                psInsertSpec.setString(4, product.getSpecification().getScreen());
                psInsertSpec.setString(5, product.getSpecification().getBattery());
                psInsertSpec.setString(6, product.getSpecification().getOs());
                psInsertSpec.setString(7, product.getSpecification().getChipset());
                psInsertSpec.executeUpdate();
            }
        }

        conn.commit();

    } catch (SQLException e) {
        if (conn != null) {
            try {
                conn.rollback();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
        throw e;
    } finally {
        if (psUpdateProduct != null) psUpdateProduct.close();
        if (psUpdateSpec != null) psUpdateSpec.close();
        if (conn != null) conn.close();
    }
}




}
