package com.snaptheslop.snaptheslop.admin.model.dao;

import com.snaptheslop.snaptheslop.municipality.model.Municipality;
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
  public boolean registerMunicipality(Municipality municipality) {
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
      userStmt.setString(8, "Active");
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
  public List<Municipality> getAllMunicipalities() {
    List<Municipality> municipalities = new ArrayList<>();
    String sql =
      "SELECT m.id, m.name, m.district, m.province, m.contact_number, m.email, m.office_address, " +
      "COUNT(DISTINCT w.id) AS ward_count, " +
      "MAX(CASE WHEN UPPER(TRIM(u.role)) = 'MUNICIPAL HEAD' THEN u.email END) AS admin_email, " +
      "MAX(CASE WHEN UPPER(TRIM(u.role)) = 'MUNICIPAL HEAD' THEN u.accountStatus END) AS admin_status " +
      "FROM municipalities m " +
      "LEFT JOIN wards w ON w.municipality_id = m.id " +
      "LEFT JOIN users u ON u.municipality = m.name " +
      "GROUP BY m.id, m.name, m.district, m.province, m.contact_number, m.email, m.office_address " +
      "ORDER BY m.name";

    try (
      Connection conn = DBConnection.getConnection();
      Statement stmt = conn.createStatement();
      ResultSet rs = stmt.executeQuery(sql)
    ) {
      while (rs.next()) {
        Municipality municipality = new Municipality();
        municipality.setId(rs.getInt("id"));
        municipality.setName(rs.getString("name"));
        municipality.setDistrict(rs.getString("district"));
        municipality.setProvince(rs.getString("province"));
        municipality.setContactNumber(rs.getString("contact_number"));
        municipality.setEmail(rs.getString("email"));
        municipality.setOfficeAddress(rs.getString("office_address"));
        municipality.setWardCount(rs.getInt("ward_count"));
        municipality.setAdminEmail(rs.getString("admin_email"));

        String adminStatus = rs.getString("admin_status");
        municipality.setStatus(
          adminStatus != null && !adminStatus.trim().isEmpty()
            ? adminStatus
            : "Pending"
        );
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
  public Municipality getMunicipalityById(int id) {
    String sql =
      "SELECT m.id, m.name, m.district, m.province, m.contact_number, m.email, m.office_address, " +
      "COUNT(DISTINCT w.id) AS ward_count, " +
      "MAX(CASE WHEN UPPER(TRIM(u.role)) = 'MUNICIPAL HEAD' THEN u.firstName END) AS admin_first_name, " +
      "MAX(CASE WHEN UPPER(TRIM(u.role)) = 'MUNICIPAL HEAD' THEN u.lastName END) AS admin_last_name, " +
      "MAX(CASE WHEN UPPER(TRIM(u.role)) = 'MUNICIPAL HEAD' THEN u.email END) AS admin_email, " +
      "MAX(CASE WHEN UPPER(TRIM(u.role)) = 'MUNICIPAL HEAD' THEN u.phoneNumber END) AS admin_phone, " +
      "MAX(CASE WHEN UPPER(TRIM(u.role)) = 'MUNICIPAL HEAD' THEN u.accountStatus END) AS admin_status " +
      "FROM municipalities m " +
      "LEFT JOIN wards w ON w.municipality_id = m.id " +
      "LEFT JOIN users u ON u.municipality = m.name " +
      "WHERE m.id = ? " +
      "GROUP BY m.id, m.name, m.district, m.province, m.contact_number, m.email, m.office_address";

    try (
      Connection conn = DBConnection.getConnection();
      PreparedStatement pstmt = conn.prepareStatement(sql)
    ) {
      pstmt.setInt(1, id);
      ResultSet rs = pstmt.executeQuery();

      if (rs.next()) {
        Municipality municipality = new Municipality();
        municipality.setId(rs.getInt("id"));
        municipality.setName(rs.getString("name"));
        municipality.setOldName(rs.getString("name"));
        municipality.setDistrict(rs.getString("district"));
        municipality.setProvince(rs.getString("province"));
        municipality.setContactNumber(rs.getString("contact_number"));
        municipality.setEmail(rs.getString("email"));
        municipality.setOfficeAddress(rs.getString("office_address"));
        municipality.setWardCount(rs.getInt("ward_count"));
        municipality.setAdminFirstName(rs.getString("admin_first_name"));
        municipality.setAdminLastName(rs.getString("admin_last_name"));
        municipality.setAdminEmail(rs.getString("admin_email"));
        municipality.setAdminPhone(rs.getString("admin_phone"));

        String adminStatus = rs.getString("admin_status");
        municipality.setStatus(
          adminStatus != null && !adminStatus.trim().isEmpty()
            ? adminStatus
            : "Pending"
        );
        return municipality;
      }
    } catch (SQLException | ClassNotFoundException e) {
      e.printStackTrace();
    }

    return null;
  }

  public boolean updateMunicipalityAndAdmin(Municipality municipality) {
    Connection conn = null;
    try {
      conn = DBConnection.getConnection();
      conn.setAutoCommit(false);

      String updateMunicipalitySql =
        "UPDATE municipalities SET name = ?, district = ?, province = ?, contact_number = ?, email = ?, office_address = ? WHERE id = ?";
      try (PreparedStatement municipalityStmt = conn.prepareStatement(
        updateMunicipalitySql
      )) {
        municipalityStmt.setString(1, municipality.getName());
        municipalityStmt.setString(2, municipality.getDistrict());
        municipalityStmt.setString(3, municipality.getProvince());
        municipalityStmt.setString(4, municipality.getContactNumber());
        municipalityStmt.setString(5, municipality.getAdminEmail());
        municipalityStmt.setString(6, municipality.getOfficeAddress());
        municipalityStmt.setInt(7, municipality.getId());

        if (municipalityStmt.executeUpdate() <= 0) {
          conn.rollback();
          return false;
        }
      }

      String oldName = municipality.getOldName();
      if (oldName != null && !oldName.trim().isEmpty()) {
        String updateAdminSql =
          "UPDATE users SET firstName = ?, lastName = ?, email = ?, phoneNumber = ?, municipality = ?, province = ?, accountStatus = ? " +
          "WHERE municipality = ? AND UPPER(TRIM(role)) = 'MUNICIPAL HEAD'";

        try (PreparedStatement adminStmt = conn.prepareStatement(updateAdminSql)) {
          adminStmt.setString(1, municipality.getAdminFirstName());
          adminStmt.setString(2, municipality.getAdminLastName());
          adminStmt.setString(3, municipality.getAdminEmail());
          adminStmt.setString(4, municipality.getAdminPhone());
          adminStmt.setString(5, municipality.getName());
          adminStmt.setString(6, municipality.getProvince());
          adminStmt.setString(
            7,
            municipality.getStatus() != null ? municipality.getStatus() : "Active"
          );
          adminStmt.setString(8, oldName);
          adminStmt.executeUpdate();
        }
      }

      conn.commit();
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

  public boolean resetMunicipalityAdminPassword(int municipalityId, String hashedPassword) {
    String municipalityNameSql = "SELECT name FROM municipalities WHERE id = ?";
    String updatePasswordSql =
      "UPDATE users SET password = ? WHERE municipality = ? AND UPPER(TRIM(role)) = 'MUNICIPAL HEAD'";

    try (
      Connection conn = DBConnection.getConnection();
      PreparedStatement municipalityStmt = conn.prepareStatement(
        municipalityNameSql
      )
    ) {
      municipalityStmt.setInt(1, municipalityId);
      ResultSet rs = municipalityStmt.executeQuery();
      if (!rs.next()) {
        return false;
      }

      String municipalityName = rs.getString("name");
      try (PreparedStatement updateStmt = conn.prepareStatement(updatePasswordSql)) {
        updateStmt.setString(1, hashedPassword);
        updateStmt.setString(2, municipalityName);
        return updateStmt.executeUpdate() > 0;
      }
    } catch (SQLException | ClassNotFoundException e) {
      e.printStackTrace();
      return false;
    }
  }

  public boolean disableMunicipalityAdmin(int municipalityId) {
    String municipalityNameSql = "SELECT name FROM municipalities WHERE id = ?";
    String disableSql =
      "UPDATE users SET accountStatus = 'Disabled' WHERE municipality = ? AND UPPER(TRIM(role)) = 'MUNICIPAL HEAD'";

    try (
      Connection conn = DBConnection.getConnection();
      PreparedStatement municipalityStmt = conn.prepareStatement(
        municipalityNameSql
      )
    ) {
      municipalityStmt.setInt(1, municipalityId);
      ResultSet rs = municipalityStmt.executeQuery();
      if (!rs.next()) {
        return false;
      }

      String municipalityName = rs.getString("name");
      try (PreparedStatement disableStmt = conn.prepareStatement(disableSql)) {
        disableStmt.setString(1, municipalityName);
        return disableStmt.executeUpdate() > 0;
      }
    } catch (SQLException | ClassNotFoundException e) {
      e.printStackTrace();
      return false;
    }
  }

  /**
   * Get municipality by name
   */
  public Municipality getMunicipalityByName(String name) {
    String sql = "SELECT * FROM municipalities WHERE name = ?";

    try (
      Connection conn = DBConnection.getConnection();
      PreparedStatement pstmt = conn.prepareStatement(sql)
    ) {
      pstmt.setString(1, name);
      ResultSet rs = pstmt.executeQuery();

      if (rs.next()) {
        Municipality municipality = new Municipality();
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
