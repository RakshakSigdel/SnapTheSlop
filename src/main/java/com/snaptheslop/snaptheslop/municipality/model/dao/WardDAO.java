package com.snaptheslop.snaptheslop.municipality.model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import com.snaptheslop.snaptheslop.config.DBConnection;
import com.snaptheslop.snaptheslop.municipality.model.Ward;

/**
 * Ward Data Access Object (DAO) Handles all database operations for Ward
 * entity.
 *
 * @author Sprint 4 Team
 * @version 1.0
 */
public class WardDAO {

    private static final Logger LOGGER = Logger.getLogger(WardDAO.class.getName());

    /**
     * Creates a new ward in the database
     *
     * @param ward Ward object to be created
     * @return true if ward was created successfully, false otherwise
     * @throws SQLException if database error occurs
     * @throws ClassNotFoundException if database driver not found
     * @throws IllegalArgumentException if ward is null or invalid
     */
    public boolean createWard(Ward ward) throws SQLException, ClassNotFoundException {
        if (ward == null) {
            throw new IllegalArgumentException("Ward object cannot be null");
        }

        String sql = "INSERT INTO wards (ward_number, ward_head, contact_number, status, municipality_id) VALUES (?, ?, ?, ?, ?)";

        try (Connection connection = DBConnection.getConnection(); PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, ward.getWardNumber());
            statement.setString(2, ward.getWardHead());
            statement.setString(3, ward.getContactNumber());
            statement.setString(4, ward.getStatus() == null ? "active" : ward.getStatus());
            statement.setInt(5, ward.getMunicipalityId());

            int result = statement.executeUpdate();
            LOGGER.log(Level.INFO, "Ward created successfully with ward_number: " + ward.getWardNumber());
            return result > 0;

        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error creating ward: " + e.getMessage(), e);
            throw e;
        }
    }

    /**
     * Retrieves all wards for a specific municipality
     *
     * @param municipalityId Municipality ID
     * @return List of wards belonging to the municipality
     * @throws SQLException if database error occurs
     * @throws ClassNotFoundException if database driver not found
     * @throws IllegalArgumentException if municipalityId is invalid
     */
    public List<Ward> getWardsByMunicipalityId(int municipalityId) throws SQLException, ClassNotFoundException {
        if (municipalityId <= 0) {
            throw new IllegalArgumentException("Municipality ID must be positive");
        }

        String sql = "SELECT * FROM wards WHERE municipality_id = ? ORDER BY ward_number ASC";
        List<Ward> wards = new ArrayList<>();

        try (Connection connection = DBConnection.getConnection(); PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, municipalityId);

            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    wards.add(mapRow(resultSet));
                }
            }
            LOGGER.log(Level.INFO, "Retrieved " + wards.size() + " wards for municipality: " + municipalityId);

        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error retrieving wards for municipality " + municipalityId + ": " + e.getMessage(), e);
            throw e;
        }

        return wards;
    }

    /**
     * Finds a ward by its ID
     *
     * @param id Ward ID
     * @return Ward object if found, null otherwise
     * @throws SQLException if database error occurs
     * @throws ClassNotFoundException if database driver not found
     * @throws IllegalArgumentException if id is invalid
     */
    public Ward findById(int id) throws SQLException, ClassNotFoundException {
        if (id <= 0) {
            throw new IllegalArgumentException("Ward ID must be positive");
        }

        String sql = "SELECT * FROM wards WHERE id = ?";

        try (Connection connection = DBConnection.getConnection(); PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, id);

            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    LOGGER.log(Level.INFO, "Ward found with ID: " + id);
                    return mapRow(resultSet);
                }
            }

            LOGGER.log(Level.WARNING, "Ward not found with ID: " + id);
            return null;

        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error finding ward by ID " + id + ": " + e.getMessage(), e);
            throw e;
        }
    }

    /**
     * Checks if a ward with specific number exists in a municipality
     *
     * @param municipalityId Municipality ID
     * @param wardNumber Ward number
     * @return true if ward exists, false otherwise
     * @throws SQLException if database error occurs
     * @throws ClassNotFoundException if database driver not found
     * @throws IllegalArgumentException if parameters are invalid
     */
    public boolean existsWard(int municipalityId, int wardNumber) throws SQLException, ClassNotFoundException {
        if (municipalityId <= 0) {
            throw new IllegalArgumentException("Municipality ID must be positive");
        }
        if (wardNumber <= 0) {
            throw new IllegalArgumentException("Ward number must be positive");
        }

        String sql = "SELECT 1 FROM wards WHERE municipality_id = ? AND ward_number = ? LIMIT 1";

        try (Connection connection = DBConnection.getConnection(); PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, municipalityId);
            statement.setInt(2, wardNumber);

            try (ResultSet resultSet = statement.executeQuery()) {
                return resultSet.next();
            }

        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error checking ward existence: " + e.getMessage(), e);
            throw e;
        }
    }

    /**
     * Updates an existing ward
     *
     * @param ward Ward object with updated data
     * @return true if ward was updated successfully, false otherwise
     * @throws SQLException if database error occurs
     * @throws ClassNotFoundException if database driver not found
     * @throws IllegalArgumentException if ward is null or invalid
     */
    public boolean updateWard(Ward ward) throws SQLException, ClassNotFoundException {
        if (ward == null) {
            throw new IllegalArgumentException("Ward object cannot be null");
        }
        if (ward.getId() <= 0) {
            throw new IllegalArgumentException("Ward ID must be positive");
        }

        String sql = "UPDATE wards SET ward_number = ?, ward_head = ?, contact_number = ?, status = ? WHERE id = ?";

        try (Connection connection = DBConnection.getConnection(); PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, ward.getWardNumber());
            statement.setString(2, ward.getWardHead());
            statement.setString(3, ward.getContactNumber());
            statement.setString(4, ward.getStatus() == null ? "active" : ward.getStatus());
            statement.setInt(5, ward.getId());

            int result = statement.executeUpdate();
            LOGGER.log(Level.INFO, "Ward updated successfully with ID: " + ward.getId());
            return result > 0;

        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error updating ward with ID " + ward.getId() + ": " + e.getMessage(), e);
            throw e;
        }
    }

    /**
     * Deletes a ward from the database
     *
     * @param id Ward ID to delete
     * @return true if ward was deleted successfully, false otherwise
     * @throws SQLException if database error occurs
     * @throws ClassNotFoundException if database driver not found
     * @throws IllegalArgumentException if id is invalid
     */
    public boolean deleteWard(int id) throws SQLException, ClassNotFoundException {
        if (id <= 0) {
            throw new IllegalArgumentException("Ward ID must be positive");
        }

        String sql = "DELETE FROM wards WHERE id = ?";

        try (Connection connection = DBConnection.getConnection(); PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, id);
            int result = statement.executeUpdate();

            if (result > 0) {
                LOGGER.log(Level.INFO, "Ward deleted successfully with ID: " + id);
            } else {
                LOGGER.log(Level.WARNING, "No ward found to delete with ID: " + id);
            }

            return result > 0;

        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error deleting ward with ID " + id + ": " + e.getMessage(), e);
            throw e;
        }
    }

    /**
     * Maps a database result set row to a Ward object
     *
     * @param resultSet ResultSet from database query
     * @return Ward object populated with data from the result set
     * @throws SQLException if database error occurs
     */
    private Ward mapRow(ResultSet resultSet) throws SQLException {
        Ward ward = new Ward();
        ward.setId(resultSet.getInt("id"));
        ward.setWardNumber(resultSet.getInt("ward_number"));
        ward.setWardHead(resultSet.getString("ward_head"));
        ward.setContactNumber(resultSet.getString("contact_number"));
        ward.setStatus(resultSet.getString("status"));
        ward.setMunicipalityId(resultSet.getInt("municipality_id"));
        return ward;
    }
}
