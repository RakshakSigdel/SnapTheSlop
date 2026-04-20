package com.snaptheslop.snaptheslop.municipality.model;

import java.util.Objects;

/**
 * Ward Data Transfer Object (DTO) Represents a ward within a municipality.
 *
 * @author Sprint 4 Team
 * @version 1.0
 */
public class Ward {

    private int id;
    private int wardNumber;
    private String wardHead;
    private String contactNumber;
    private String status;
    private int municipalityId;

    /**
     * Default constructor
     */
    public Ward() {
    }

    /**
     * Constructor with all fields
     *
     * @param id Ward ID
     * @param wardNumber Ward number (must be unique per municipality)
     * @param wardHead Name of ward head
     * @param contactNumber Contact number of ward head
     * @param status Ward status (active/inactive)
     * @param municipalityId Associated municipality ID
     */
    public Ward(int id, int wardNumber, String wardHead, String contactNumber, String status, int municipalityId) {
        this.id = id;
        this.wardNumber = wardNumber;
        this.wardHead = wardHead;
        this.contactNumber = contactNumber;
        this.status = status;
        this.municipalityId = municipalityId;
    }

    /**
     * Constructor without ID (for creation)
     *
     * @param wardNumber Ward number
     * @param wardHead Name of ward head
     * @param contactNumber Contact number
     * @param status Ward status
     * @param municipalityId Municipality ID
     */
    public Ward(int wardNumber, String wardHead, String contactNumber, String status, int municipalityId) {
        this.wardNumber = wardNumber;
        this.wardHead = wardHead;
        this.contactNumber = contactNumber;
        this.status = status;
        this.municipalityId = municipalityId;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getWardNumber() {
        return wardNumber;
    }

    public void setWardNumber(int wardNumber) {
        this.wardNumber = wardNumber;
    }

    public String getWardHead() {
        return wardHead;
    }

    public void setWardHead(String wardHead) {
        this.wardHead = wardHead;
    }

    public String getContactNumber() {
        return contactNumber;
    }

    public void setContactNumber(String contactNumber) {
        this.contactNumber = contactNumber;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public int getMunicipalityId() {
        return municipalityId;
    }

    public void setMunicipalityId(int municipalityId) {
        this.municipalityId = municipalityId;
    }

    // equals and hashCode for proper object comparison
    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (o == null || getClass() != o.getClass()) {
            return false;
        }
        Ward ward = (Ward) o;
        return id == ward.id
                && wardNumber == ward.wardNumber
                && municipalityId == ward.municipalityId
                && Objects.equals(wardHead, ward.wardHead)
                && Objects.equals(contactNumber, ward.contactNumber)
                && Objects.equals(status, ward.status);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, wardNumber, wardHead, contactNumber, status, municipalityId);
    }

    @Override
    public String toString() {
        return "Ward{"
                + "id=" + id
                + ", wardNumber=" + wardNumber
                + ", wardHead='" + wardHead + '\''
                + ", contactNumber='" + contactNumber + '\''
                + ", status='" + status + '\''
                + ", municipalityId=" + municipalityId
                + '}';
    }
}
