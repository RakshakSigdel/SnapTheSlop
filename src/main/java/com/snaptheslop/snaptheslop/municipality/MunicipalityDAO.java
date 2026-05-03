package com.snaptheslop.snaptheslop.municipality;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import com.snaptheslop.snaptheslop.config.DBConnection;
import com.snaptheslop.snaptheslop.municipality.model.Municipality;

/**
 * Municipality Data Access Object (DAO) Handles all database operations for
 * Municipality entity.
 *
 * @author Sprint 4 Team
 * @version 1.0
 */
public class MunicipalityDAO {

    private static final Logger LOGGER = Logger.getLogger(MunicipalityDAO.class.getName());

    /**
     * Retrieves all municipalities
     *
     * @return List of all municipalities
     * @throws SQLException if database error occurs
     * @throws ClassNotFoundException if database driver not found
     */
    public List<Municipality> getAllMunicipalities() throws SQLException, ClassNotFoundException {
        String sql = "SELECT * FROM municipalities ORDER BY name ASC";
        List<Municipality> municipalities = new ArrayList<>();

        try (Connection connection = DBConnection.getConnection(); PreparedStatement statement = connection.prepareStatement(sql); ResultSet resultSet = statement.executeQuery()) {

            while (resultSet.next()) {
                municipalities.add(mapRow(resultSet));
            }
            LOGGER.log(Level.INFO, "Retrieved " + municipalities.size() + " municipalities");

        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error retrieving municipalities: " + e.getMessage(), e);
            throw e;
        }

        return municipalities;
    }

    /**
     * Finds a municipality by ID
     *
     * @param id Municipality ID
     * @return Municipality object if found, null otherwise
     * @throws SQLException if database error occurs
     * @throws ClassNotFoundException if database driver not found
     * @throws IllegalArgumentException if id is invalid
     */
    public Municipality findById(int id) throws SQLException, ClassNotFoundException {
        if (id <= 0) {
            throw new IllegalArgumentException("Municipality ID must be positive");
        }

        String sql = "SELECT * FROM municipalities WHERE id = ?";

        try (Connection connection = DBConnection.getConnection(); PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, id);

            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    LOGGER.log(Level.INFO, "Municipality found with ID: " + id);
                    return mapRow(resultSet);
                }
            }

            LOGGER.log(Level.WARNING, "Municipality not found with ID: " + id);
            return null;

        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error finding municipality by ID " + id + ": " + e.getMessage(), e);
            throw e;
        }
    }

    /**
     * Finds municipality ID by municipality name (case-insensitive)
     *
     * @param name Municipality name
     * @return Municipality ID if found, null otherwise
     * @throws SQLException if database error occurs
     * @throws ClassNotFoundException if database driver not found
     */
    public Integer findMunicipalityIdByName(String name) throws SQLException, ClassNotFoundException {
        if (name == null || name.trim().isEmpty()) {
            return null;
        }

        String sql = "SELECT id FROM municipalities WHERE LOWER(name) = LOWER(?) LIMIT 1";

        try (Connection connection = DBConnection.getConnection(); PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, name.trim());

            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    return resultSet.getInt("id");
                }
            }

            String normalizedName = normalizeMunicipalityName(name);
            String strippedInputName = stripMunicipalityQualifiers(normalizedName);
            String fallbackSql = "SELECT id, name FROM municipalities";
            Integer matchedId = null;
            boolean ambiguousMatch = false;
            try (PreparedStatement fallbackStatement = connection.prepareStatement(fallbackSql);
                    ResultSet fallbackResultSet = fallbackStatement.executeQuery()) {
                while (fallbackResultSet.next()) {
                    String dbName = fallbackResultSet.getString("name");
                    String normalizedDbName = normalizeMunicipalityName(dbName);
                    String strippedDbName = stripMunicipalityQualifiers(normalizedDbName);

                    boolean match = normalizedName.equals(normalizedDbName)
                            || normalizedDbName.startsWith(normalizedName)
                            || normalizedName.startsWith(normalizedDbName)
                            || strippedInputName.equals(strippedDbName)
                            || (!strippedInputName.isEmpty() && strippedDbName.startsWith(strippedInputName));

                    if (match) {
                        int currentId = fallbackResultSet.getInt("id");
                        if (matchedId == null) {
                            matchedId = currentId;
                        } else if (!matchedId.equals(currentId)) {
                            ambiguousMatch = true;
                            break;
                        }
                    }
                }
            }

            if (ambiguousMatch) {
                LOGGER.log(Level.WARNING, "Ambiguous municipality match for name: {0}", name);
                return null;
            }
            return matchedId;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error finding municipality by name '" + name + "': " + e.getMessage(), e);
            throw e;
        }
    }

    private String normalizeMunicipalityName(String value) {
        if (value == null) {
            return "";
        }
        return value.trim().toLowerCase()
                .replaceAll("[^a-z0-9]", "");
    }

    private String stripMunicipalityQualifiers(String normalizedValue) {
        if (normalizedValue == null || normalizedValue.isEmpty()) {
            return "";
        }

        return normalizedValue
                .replace("submetropolitancity", "")
                .replace("metropolitancity", "")
                .replace("ruralmunicipality", "")
                .replace("municipality", "")
                .replace("nagarpalika", "")
                .replace("gaunpalika", "")
                .trim();
    }

    /**
     * Creates a new municipality
     *
     * @param municipality Municipality object to be created
     * @return true if municipality was created successfully, false otherwise
     * @throws SQLException if database error occurs
     * @throws ClassNotFoundException if database driver not found
     * @throws IllegalArgumentException if municipality is null or invalid
     */
    public boolean createMunicipality(Municipality municipality) throws SQLException, ClassNotFoundException {
        if (municipality == null) {
            throw new IllegalArgumentException("Municipality object cannot be null");
        }

        String sql = "INSERT INTO municipalities (name, district, province, contact_number, email, office_address) "
                + "VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection connection = DBConnection.getConnection(); PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, municipality.getName());
            statement.setString(2, municipality.getDistrict());
            statement.setString(3, municipality.getProvince());
            statement.setString(4, municipality.getContactNumber());
            statement.setString(5, municipality.getEmail());
            statement.setString(6, municipality.getOfficeAddress());

            int result = statement.executeUpdate();
            LOGGER.log(Level.INFO, "Municipality created successfully: " + municipality.getName());
            return result > 0;

        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error creating municipality: " + e.getMessage(), e);
            throw e;
        }
    }

    /**
     * Updates an existing municipality
     *
     * @param municipality Municipality object with updated data
     * @return true if municipality was updated successfully, false otherwise
     * @throws SQLException if database error occurs
     * @throws ClassNotFoundException if database driver not found
     * @throws IllegalArgumentException if municipality is null or invalid
     */
    public boolean updateMunicipality(Municipality municipality) throws SQLException, ClassNotFoundException {
        if (municipality == null) {
            throw new IllegalArgumentException("Municipality object cannot be null");
        }
        if (municipality.getId() <= 0) {
            throw new IllegalArgumentException("Municipality ID must be positive");
        }

        String sql = "UPDATE municipalities SET name = ?, district = ?, province = ?, "
                + "contact_number = ?, email = ?, office_address = ? WHERE id = ?";

        try (Connection connection = DBConnection.getConnection(); PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, municipality.getName());
            statement.setString(2, municipality.getDistrict());
            statement.setString(3, municipality.getProvince());
            statement.setString(4, municipality.getContactNumber());
            statement.setString(5, municipality.getEmail());
            statement.setString(6, municipality.getOfficeAddress());
            statement.setInt(7, municipality.getId());

            int result = statement.executeUpdate();
            LOGGER.log(Level.INFO, "Municipality updated successfully: " + municipality.getName());
            return result > 0;

        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error updating municipality with ID " + municipality.getId() + ": " + e.getMessage(), e);
            throw e;
        }
    }

    /**
     * Deletes a municipality
     *
     * @param id Municipality ID to delete
     * @return true if municipality was deleted successfully, false otherwise
     * @throws SQLException if database error occurs
     * @throws ClassNotFoundException if database driver not found
     * @throws IllegalArgumentException if id is invalid
     */
    public boolean deleteMunicipality(int id) throws SQLException, ClassNotFoundException {
        if (id <= 0) {
            throw new IllegalArgumentException("Municipality ID must be positive");
        }

        String sql = "DELETE FROM municipalities WHERE id = ?";

        try (Connection connection = DBConnection.getConnection(); PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, id);
            int result = statement.executeUpdate();

            if (result > 0) {
                LOGGER.log(Level.INFO, "Municipality deleted successfully with ID: " + id);
            } else {
                LOGGER.log(Level.WARNING, "No municipality found to delete with ID: " + id);
            }

            return result > 0;

        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error deleting municipality with ID " + id + ": " + e.getMessage(), e);
            throw e;
        }
    }

    /**
     * Maps a database result set row to a Municipality object
     *
     * @param resultSet ResultSet from database query
     * @return Municipality object populated with data from the result set
     * @throws SQLException if database error occurs
     */
    private Municipality mapRow(ResultSet resultSet) throws SQLException {
        Municipality municipality = new Municipality();
        municipality.setId(resultSet.getInt("id"));
        municipality.setName(resultSet.getString("name"));
        municipality.setDistrict(resultSet.getString("district"));
        municipality.setProvince(resultSet.getString("province"));
        municipality.setContactNumber(resultSet.getString("contact_number"));
        municipality.setEmail(resultSet.getString("email"));
        municipality.setOfficeAddress(resultSet.getString("office_address"));
        return municipality;
    }
}
