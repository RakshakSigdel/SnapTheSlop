package com.snaptheslop.snaptheslop.user.model.dao;

import com.snaptheslop.snaptheslop.config.DBConnection;
import com.snaptheslop.snaptheslop.municipality.MunicipalityDAO;
import com.snaptheslop.snaptheslop.user.model.UserDTO;
import com.snaptheslop.snaptheslop.security.PasswordUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class UserDAO {

    private static final Logger LOGGER = Logger.getLogger(UserDAO.class.getName());

    private final MunicipalityDAO municipalityDAO = new MunicipalityDAO();

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
            pstmt.setString(10, user.getAccountStatus() != null ? user.getAccountStatus() : "Active");
            pstmt.setString(11, user.getUserId());

            int result = pstmt.executeUpdate();
            return result > 0;
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Error registering user", e);
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
            LOGGER.log(Level.SEVERE, "Error authenticating user by email", e);
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
            LOGGER.log(Level.SEVERE, "Error finding user by email", e);
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
            LOGGER.log(Level.SEVERE, "Error finding user by userId", e);
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
            LOGGER.log(Level.SEVERE, "Error updating user profile", e);
            return false;
        }
    }

    /**
     * Update account status for a user (active/inactive)
     */
    public boolean updateUserAccountStatus(String userId, String accountStatus) {
        if (userId == null || userId.trim().isEmpty()) {
            return false;
        }
        if (accountStatus == null || accountStatus.trim().isEmpty()) {
            return false;
        }

        String normalizedStatus = accountStatus.trim().toLowerCase();
        if (!"active".equals(normalizedStatus) && !"inactive".equals(normalizedStatus)) {
            return false;
        }

        String sql = "UPDATE users SET accountStatus = ? WHERE userId = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, "active".equals(normalizedStatus) ? "Active" : "Inactive");
            pstmt.setString(2, userId.trim());

            int result = pstmt.executeUpdate();
            return result > 0;
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Error updating account status", e);
            return false;
        }
    }

    /**
     * Delete user by userId
     */
    public boolean deleteUserByUserId(String userId) {
        if (userId == null || userId.trim().isEmpty()) {
            return false;
        }

        String sql = "DELETE FROM users WHERE userId = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, userId.trim());
            int result = pstmt.executeUpdate();
            return result > 0;
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Error deleting user with userId: " + userId, e);
            return false;
        }
    }

    /**
     * Get all users for admin listing
     */
    public List<UserDTO> getAllUsers() {
        List<UserDTO> users = new ArrayList<>();
        String sql = "SELECT * FROM users ORDER BY createdAt DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                users.add(mapResultSetToUserDTO(rs));
            }
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Error fetching all users", e);
        }

        return users;
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
        String municipalityName = rs.getString("municipality");
        user.setMunicipality(municipalityName);
        try {
            Integer municipalityId = municipalityName == null ? null : municipalityDAO.findMunicipalityIdByName(municipalityName);
            user.setMunicipalityId(municipalityId != null ? municipalityId : -1);
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.WARNING, "Unable to resolve municipalityId for user " + rs.getString("userId"), e);
            user.setMunicipalityId(-1);
        }
        user.setWardNo(rs.getString("wardNo"));
        user.setProvince(rs.getString("province"));
        user.setMemberSince(rs.getString("memberSince"));
        return user;
    }
}
