package com.snaptheslop.snaptheslop.municipality.model;

import java.util.Objects;

/**
 * Municipality Data Transfer Object (DTO) Represents a municipality in the
 * system.
 *
 * @author Sprint 4 Team
 * @version 1.0
 */
public class Municipality {

    private int id;
    private String name;
    private String district;
    private String province;
    private String contactNumber;
    private String email;
    private String officeAddress;

    /**
     * Default constructor
     */
    public Municipality() {
    }

    /**
     * Constructor with all fields
     *
     * @param id Municipality ID
     * @param name Municipality name
     * @param district District name
     * @param province Province name
     * @param contactNumber Contact number
     * @param email Email address
     * @param officeAddress Office address
     */
    public Municipality(int id, String name, String district, String province,
            String contactNumber, String email, String officeAddress) {
        this.id = id;
        this.name = name;
        this.district = district;
        this.province = province;
        this.contactNumber = contactNumber;
        this.email = email;
        this.officeAddress = officeAddress;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDistrict() {
        return district;
    }

    public void setDistrict(String district) {
        this.district = district;
    }

    public String getProvince() {
        return province;
    }

    public void setProvince(String province) {
        this.province = province;
    }

    public String getContactNumber() {
        return contactNumber;
    }

    public void setContactNumber(String contactNumber) {
        this.contactNumber = contactNumber;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getOfficeAddress() {
        return officeAddress;
    }

    public void setOfficeAddress(String officeAddress) {
        this.officeAddress = officeAddress;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (o == null || getClass() != o.getClass()) {
            return false;
        }
        Municipality that = (Municipality) o;
        return id == that.id
                && Objects.equals(name, that.name)
                && Objects.equals(district, that.district)
                && Objects.equals(province, that.province);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, name, district, province);
    }

    @Override
    public String toString() {
        return "Municipality{"
                + "id=" + id
                + ", name='" + name + '\''
                + ", district='" + district + '\''
                + ", province='" + province + '\''
                + '}';
    }
}
