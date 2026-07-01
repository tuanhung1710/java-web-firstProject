package dao;

import model.Account;
import utility.SecurityUtils;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.UUID;

public class AccountDAO extends DBContext {
    
    /**
     * Xác thực người dùng bằng email và mật khẩu
     * @param email Email đăng nhập
     * @param password Mật khẩu gốc chưa mã hóa
     * @return Đối tượng Account nếu đăng nhập thành công, null nếu thất bại
     */
    public Account login(String email, String password) {
        String sql = "SELECT Id, FullName, Email, Phone, PasswordHash, Role, IsActive, CreatedAt, UpdatedAt FROM Users WHERE Email = ?";
        
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, email);
            
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    boolean isActive = rs.getBoolean("IsActive");
                    
                    // Kiểm tra tài khoản có đang hoạt động hay không
                    if (!isActive) {
                        return null; 
                    }
                    
                    String dbPasswordHash = rs.getString("PasswordHash");
                    String idStr = rs.getString("Id");
                    
                    // Sử dụng Id dưới dạng chuỗi làm muối (salt) để băm mật khẩu
                    String hashedInputPassword = SecurityUtils.hashPassword(password, idStr);
                    
                    // So sánh mật khẩu đã băm với PasswordHash trong DB
                    String genericHash123456 = "8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92";
                    
                    if (hashedInputPassword.equals(dbPasswordHash) || 
                        (password.equals("123456") && dbPasswordHash.equals(genericHash123456))) {
                        
                        // Tự động cập nhật (Migrate) mật khẩu trong DB thành chuẩn có Salt nếu đang dùng hash cũ
                        if (dbPasswordHash.equals(genericHash123456)) {
                            updatePasswordHash(idStr, hashedInputPassword);
                        }
                        
                        Account account = new Account();
                        account.setId(UUID.fromString(idStr));
                        account.setFullName(rs.getString("FullName"));
                        account.setEmail(rs.getString("Email"));
                        account.setPhone(rs.getString("Phone"));
                        account.setPasswordHash(dbPasswordHash);
                        account.setRole(rs.getString("Role"));
                        account.setIsActive(isActive);
                        account.setCreatedAt(rs.getTimestamp("CreatedAt"));
                        account.setUpdatedAt(rs.getTimestamp("UpdatedAt"));
                        
                        return account;
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * Kiểm tra xem Email đã tồn tại trong CSDL chưa
     * @param email Email cần kiểm tra
     * @return true nếu đã tồn tại, false nếu chưa
     */
    public boolean checkEmailExist(String email) {
        String sql = "SELECT 1 FROM Users WHERE Email = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, email);
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    return true;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * Đăng ký tài khoản mới cho Cư dân
     * @param account Đối tượng chứa thông tin người dùng
     * @param plainPassword Mật khẩu chưa mã hóa
     * @return true nếu đăng ký thành công
     */
    public boolean register(Account account, String plainPassword) {
        String sql = "INSERT INTO Users (Id, FullName, Email, Phone, PasswordHash, Role, IsActive, CreatedAt, UpdatedAt) "
                   + "VALUES (?, ?, ?, ?, ?, ?, ?, GETDATE(), GETDATE())";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            // Tự sinh Id mới (UUID)
            UUID newId = UUID.randomUUID();
            account.setId(newId);
            
            // Băm mật khẩu với muối là chuỗi Id vừa sinh
            String hashedPass = SecurityUtils.hashPassword(plainPassword, newId.toString());
            
            st.setString(1, newId.toString());
            st.setString(2, account.getFullName());
            st.setString(3, account.getEmail());
            st.setString(4, account.getPhone());
            st.setString(5, hashedPass);
            // Mặc định gán role là resident nếu chưa có
            st.setString(6, (account.getRole() != null && !account.getRole().isEmpty()) ? account.getRole() : "resident");
            st.setInt(7, 1); // 1 = Active
            
            int rowsAffected = st.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * Cập nhật PasswordHash mới vào DB
     */
    private void updatePasswordHash(String id, String newHashedPassword) {
        String sql = "UPDATE Users SET PasswordHash = ? WHERE Id = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, newHashedPassword);
            st.setString(2, id);
            st.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
