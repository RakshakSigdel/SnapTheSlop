package com.snaptheslop.snaptheslop.user.model.dao;

import com.snaptheslop.snaptheslop.config.DBConnection;
import com.snaptheslop.snaptheslop.user.model.UserDTO;
import com.snaptheslop.snaptheslop.security.PasswordUtil;

import java.sql.*;

public class UserDAO {

    /**
     * Register a new user by saving their data to the database
     */
    public boolean registerUser(UserDTO user, String password) {
        String sql = "INSERT INTO users (firstName, lastName, email, phoneNumber, municipality, wardNo, province, password, role, accountStatus, memberSince, userId) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, NOW(), ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, user.getFirstName());
            pstmt.setString(2, user.getLastName());
            pstmt.setString(3, user.getEmail());
            pstmt.setString(4, user.getPhoneNumber());
            pstmt.setString(5, user.getMunicipality());
            pstmt.setString(6, user.getWardNo());
            pstmt.setString(7, user.getProvince());
            pstmt.setString(8, PasswordUtil.hashPassword(password));
            pstmt.setString(9, user.getRole() != null ? user.getRole() : "Registered Citizen");
            pstmt.setString(10, user.getAccountStatus() != null ? user.getAccountStatus() : "Pending Verification");
            pstmt.setString(11, user.getUserId());

            int result = pstmt.executeUpdate();
            return result > 0;
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Find user by email and verify password
     */
    public UserDTO authenticateUser(String email, String password) {
        String sql = "SELECT * FROM users WHERE email = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, email);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                String storedPasswordHash = rs.getString("password");
                if (PasswordUtil.verifyPassword(password, storedPasswordHash)) {
                    return mapResultSetToUserDTO(rs);
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }

        return null;
    }

    /**
     * Find user by email
     */
    public UserDTO findUserByEmail(String email) {
        String sql = "SELECT * FROM users WHERE email = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, email);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                return mapResultSetToUserDTO(rs);
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }

        return null;
    }

    /**
     * Find user by userId
     */
    public UserDTO findUserById(String userId) {
        String sql = "SELECT * FROM users WHERE userId = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, userId);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                return mapResultSetToUserDTO(rs);
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }

        return null;
    }

    /**
     * Update user profile information
     */
    public boolean updateUserProfile(UserDTO user) {
        String sql = "UPDATE users SET firstName = ?, lastName = ?, phoneNumber = ?, municipality = ?, wardNo = ?, province = ? WHERE userId = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, user.getFirstName());
            pstmt.setString(2, user.getLastName());
            pstmt.setString(3, user.getPhoneNumber());
            pstmt.setString(4, user.getMunicipality());
            pstmt.setString(5, user.getWardNo());
            pstmt.setString(6, user.getProvince());
            pstmt.setString(7, user.getUserId());

            int result = pstmt.executeUpdate();
            return result > 0;
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Map ResultSet to UserDTO
     */
    private UserDTO mapResultSetToUserDTO(ResultSet rs) throws SQLException {
        UserDTO user = new UserDTO();
        user.setUserId(rs.getString("userId"));
        user.setFirstName(rs.getString("firstName"));
        user.setLastName(rs.getString("lastName"));
        user.setEmail(rs.getString("email"));
        user.setPhoneNumber(rs.getString("phoneNumber"));
        user.setRole(rs.getString("role"));
        user.setAccountStatus(rs.getString("accountStatus"));
        user.setMunicipality(rs.getString("municipality"));
        user.setWardNo(rs.getString("wardNo"));
        user.setProvince(rs.getString("province"));
        user.setMemberSince(rs.getString("memberSince"));
        return user;
    }
}
