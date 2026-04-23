package com.snaptheslop.snaptheslop.issue.model;

import java.sql.Timestamp;

/**
 * Issue model — maps to the `issues` table.
 * Sprint 5: Core Issue Lifecycle
 */
public class Issue {

    private int id;
    private String issueId;        // human-readable unique ID e.g. "ISS-001"
    private String title;
    private String description;
    private String category;
    private String status;         // Open | In Progress | Resolved | Rejected
    private String priority;       // Low | Medium | High
    private String imagePath;      // nullable
    private String location;
    private int userId;            // FK → users.id
    private int municipalityId;    // FK → municipalities.id
    private int wardNo;
    private Timestamp createdAt;
    private Timestamp updatedAt;

    // ── Convenience fields populated via JOIN queries ──────────────────────
    private String citizenName;      // firstName + lastName
    private String citizenEmail;
    private String municipalityName;
    private int upvoteCount;

    // ── Constructors ───────────────────────────────────────────────────────

    public Issue() {}

    // ── Getters & Setters ──────────────────────────────────────────────────

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getIssueId() { return issueId; }
    public void setIssueId(String issueId) { this.issueId = issueId; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public String getPriority() { return priority; }
    public void setPriority(String priority) { this.priority = priority; }

    public String getImagePath() { return imagePath; }
    public void setImagePath(String imagePath) { this.imagePath = imagePath; }

    public String getLocation() { return location; }
    public void setLocation(String location) { this.location = location; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public int getMunicipalityId() { return municipalityId; }
    public void setMunicipalityId(int municipalityId) { this.municipalityId = municipalityId; }

    public int getWardNo() { return wardNo; }
    public void setWardNo(int wardNo) { this.wardNo = wardNo; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }

    public Timestamp getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(Timestamp updatedAt) { this.updatedAt = updatedAt; }

    public String getCitizenName() { return citizenName; }
    public void setCitizenName(String citizenName) { this.citizenName = citizenName; }

    public String getCitizenEmail() { return citizenEmail; }
    public void setCitizenEmail(String citizenEmail) { this.citizenEmail = citizenEmail; }

    public String getMunicipalityName() { return municipalityName; }
    public void setMunicipalityName(String municipalityName) { this.municipalityName = municipalityName; }

    public int getUpvoteCount() { return upvoteCount; }
    public void setUpvoteCount(int upvoteCount) { this.upvoteCount = upvoteCount; }

    // ── Helpers ────────────────────────────────────────────────────────────

    /** Returns true if the given next-status is a valid transition from the current status. */
    public boolean isValidTransition(String nextStatus) {
        if (nextStatus == null) return false;
        switch (this.status) {
            case "Open":        return "In Progress".equals(nextStatus)
                                       || "Resolved".equals(nextStatus)
                                       || "Rejected".equals(nextStatus);
            case "In Progress": return "Resolved".equals(nextStatus)    || "Rejected".equals(nextStatus);
            default:            return false; // Resolved / Rejected are terminal
        }
    }

    /** Formatted creation date string for display in JSP (avoids importing java.time in JSP). */
    public String getCreatedAtFormatted() {
        if (createdAt == null) return "";
        java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("MMM dd, yyyy");
        return sdf.format(createdAt);
    }

    /** Short date format e.g. "Oct 11" */
    public String getCreatedAtShort() {
        if (createdAt == null) return "";
        java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("MMM dd");
        return sdf.format(createdAt);
    }
}
