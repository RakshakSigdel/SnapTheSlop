package com.snaptheslop.snaptheslop.admin.model.dao;

import com.snaptheslop.snaptheslop.admin.model.MunicipalityDTO;
import com.snaptheslop.snaptheslop.config.DBConnection;
import com.snaptheslop.snaptheslop.security.PasswordUtil;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

public class AdminDAO {

  /**
   * Register a new municipality and create municipal head admin account
   */
  public boolean registerMunicipality(MunicipalityDTO municipality) {
    Connection conn = null;
    try {
      conn = DBConnection.getConnection();
      conn.setAutoCommit(false); // Start transaction

      // Step 1: Insert municipality
      String municipalitySQL =
        "INSERT INTO municipalities (name, district, province, contact_number, email, office_address) VALUES (?, ?, ?, ?, ?, ?)";
      PreparedStatement municipalityStmt = conn.prepareStatement(
        municipalitySQL,
        Statement.RETURN_GENERATED_KEYS
      );

      municipalityStmt.setString(1, municipality.getName());
      municipalityStmt.setString(
        2,
        municipality.getDistrict() != null ? municipality.getDistrict() : ""
      );
      municipalityStmt.setString(
        3,
        municipality.getProvince() != null ? municipality.getProvince() : ""
      );
      municipalityStmt.setString(
        4,
        municipality.getContactNumber() != null
          ? municipality.getContactNumber()
          : ""
      );
      municipalityStmt.setString(5, municipality.getAdminEmail());
      municipalityStmt.setString(
        6,
        municipality.getOfficeAddress() != null
          ? municipality.getOfficeAddress()
          : ""
      );

      int result = municipalityStmt.executeUpdate();

      if (result <= 0) {
        conn.rollback();
        return false;
      }

      // Get the generated municipality ID
      ResultSet generatedKeys = municipalityStmt.getGeneratedKeys();
      int municipalityId = 0;
      if (generatedKeys.next()) {
        municipalityId = generatedKeys.getInt(1);
      }

      // Step 2: Create municipal head user account
      String userId =
        "MUNHEAD-" +
        municipalityId +
        "-" +
        UUID.randomUUID().toString().substring(0, 8).toUpperCase();

      String userSQL =
        "INSERT INTO users (userId, firstName, lastName, email, phoneNumber, password, role, accountStatus, municipality, wardNo, province) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
      PreparedStatement userStmt = conn.prepareStatement(userSQL);

      userStmt.setString(1, userId);
      userStmt.setString(2, municipality.getAdminFirstName());
      userStmt.setString(3, municipality.getAdminLastName());
      userStmt.setString(4, municipality.getAdminEmail());
      userStmt.setString(5, municipality.getAdminPhone());
      userStmt.setString(
        6,
        PasswordUtil.hashPassword(municipality.getAdminPassword())
      );
      userStmt.setString(7, "Municipal Head");
      userStmt.setString(8, "Verified Account");
      userStmt.setString(9, municipality.getName());
      userStmt.setString(10, "N/A");
      userStmt.setString(
        11,
        municipality.getProvince() != null ? municipality.getProvince() : ""
      );

      result = userStmt.executeUpdate();

      if (result <= 0) {
        conn.rollback();
        return false;
      }

      // Commit transaction
      conn.commit();
      System.out.println(
        "DEBUG: Municipality registered successfully - " +
          municipality.getName() +
          " (ID: " +
          municipalityId +
          ")"
      );
      return true;
    } catch (SQLException | ClassNotFoundException e) {
      try {
        if (conn != null) {
          conn.rollback();
        }
      } catch (SQLException rollbackEx) {
        rollbackEx.printStackTrace();
      }
      e.printStackTrace();
      return false;
    } finally {
      try {
        if (conn != null) {
          conn.setAutoCommit(true);
          conn.close();
        }
      } catch (SQLException e) {
        e.printStackTrace();
      }
    }
  }

  /**
   * Get all municipalities
   */
  public List<MunicipalityDTO> getAllMunicipalities() {
    List<MunicipalityDTO> municipalities = new ArrayList<>();
    String sql = "SELECT * FROM municipalities";

    try (
      Connection conn = DBConnection.getConnection();
      Statement stmt = conn.createStatement();
      ResultSet rs = stmt.executeQuery(sql)
    ) {
      while (rs.next()) {
        MunicipalityDTO municipality = new MunicipalityDTO();
        municipality.setId(rs.getInt("id"));
        municipality.setName(rs.getString("name"));
        municipality.setDistrict(rs.getString("district"));
        municipality.setProvince(rs.getString("province"));
        municipality.setContactNumber(rs.getString("contact_number"));
        municipality.setEmail(rs.getString("email"));
        municipality.setOfficeAddress(rs.getString("office_address"));
        municipalities.add(municipality);
      }
    } catch (SQLException | ClassNotFoundException e) {
      e.printStackTrace();
    }

    return municipalities;
  }

  /**
   * Get municipality by ID
   */
  public MunicipalityDTO getMunicipalityById(int id) {
    String sql = "SELECT * FROM municipalities WHERE id = ?";

    try (
      Connection conn = DBConnection.getConnection();
      PreparedStatement pstmt = conn.prepareStatement(sql)
    ) {
      pstmt.setInt(1, id);
      ResultSet rs = pstmt.executeQuery();

      if (rs.next()) {
        MunicipalityDTO municipality = new MunicipalityDTO();
        municipality.setId(rs.getInt("id"));
        municipality.setName(rs.getString("name"));
        municipality.setDistrict(rs.getString("district"));
        municipality.setProvince(rs.getString("province"));
        municipality.setContactNumber(rs.getString("contact_number"));
        municipality.setEmail(rs.getString("email"));
        municipality.setOfficeAddress(rs.getString("office_address"));
        return municipality;
      }
    } catch (SQLException | ClassNotFoundException e) {
      e.printStackTrace();
    }

    return null;
  }

  /**
   * Get municipality by name
   */
  public MunicipalityDTO getMunicipalityByName(String name) {
    String sql = "SELECT * FROM municipalities WHERE name = ?";

    try (
      Connection conn = DBConnection.getConnection();
      PreparedStatement pstmt = conn.prepareStatement(sql)
    ) {
      pstmt.setString(1, name);
      ResultSet rs = pstmt.executeQuery();

      if (rs.next()) {
        MunicipalityDTO municipality = new MunicipalityDTO();
        municipality.setId(rs.getInt("id"));
        municipality.setName(rs.getString("name"));
        municipality.setDistrict(rs.getString("district"));
        municipality.setProvince(rs.getString("province"));
        municipality.setContactNumber(rs.getString("contact_number"));
        municipality.setEmail(rs.getString("email"));
        municipality.setOfficeAddress(rs.getString("office_address"));
        return municipality;
      }
    } catch (SQLException | ClassNotFoundException e) {
      e.printStackTrace();
    }

    return null;
  }

  /**
   * Delete municipality
   */
  public boolean deleteMunicipality(int id) {
    String sql = "DELETE FROM municipalities WHERE id = ?";

    try (
      Connection conn = DBConnection.getConnection();
      PreparedStatement pstmt = conn.prepareStatement(sql)
    ) {
      pstmt.setInt(1, id);
      int result = pstmt.executeUpdate();
      return result > 0;
    } catch (SQLException | ClassNotFoundException e) {
      e.printStackTrace();
      return false;
    }
  }

  /**
   * Check if municipality email already exists
   */
  public boolean municipalityEmailExists(String email) {
    String sql = "SELECT id FROM municipalities WHERE email = ?";

    try (
      Connection conn = DBConnection.getConnection();
      PreparedStatement pstmt = conn.prepareStatement(sql)
    ) {
      pstmt.setString(1, email);
      ResultSet rs = pstmt.executeQuery();
      return rs.next();
    } catch (SQLException | ClassNotFoundException e) {
      e.printStackTrace();
      return false;
    }
  }
}
