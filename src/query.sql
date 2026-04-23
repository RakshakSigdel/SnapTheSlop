-- ============================================================
-- Drop & Create Database
-- ============================================================
DROP DATABASE IF EXISTS snaptheslop;

CREATE DATABASE snaptheslop;

USE snaptheslop;

-- ============================================================
-- Municipalities Table
-- ============================================================
CREATE TABLE
    municipalities (
        id INT AUTO_INCREMENT PRIMARY KEY,
        name VARCHAR(100) NOT NULL,
        district VARCHAR(100),
        province VARCHAR(100),
        contact_number VARCHAR(20),
        email VARCHAR(100),
        office_address TEXT
    );

-- ============================================================
-- Wards Table
-- ============================================================
CREATE TABLE
    wards (
        id INT AUTO_INCREMENT PRIMARY KEY,
        ward_number INT NOT NULL,
        ward_head VARCHAR(100),
        contact_number VARCHAR(20),
        status VARCHAR(20) NOT NULL DEFAULT 'active',
        municipality_id INT NOT NULL,
        CONSTRAINT fk_ward_municipality FOREIGN KEY (municipality_id) REFERENCES municipalities (id) ON DELETE CASCADE,
        CONSTRAINT uq_ward_number_per_municipality UNIQUE (municipality_id, ward_number),
        INDEX idx_municipality_id (municipality_id)
    );

-- ============================================================
-- Users Table
-- ============================================================
CREATE TABLE
    users (
        id INT AUTO_INCREMENT PRIMARY KEY,
        userId VARCHAR(100) NOT NULL UNIQUE,
        firstName VARCHAR(100) NOT NULL,
        lastName VARCHAR(100) NOT NULL,
        email VARCHAR(100) NOT NULL UNIQUE,
        phoneNumber VARCHAR(20),
        password VARCHAR(255) NOT NULL,
        role VARCHAR(50) NOT NULL DEFAULT 'Registered Citizen',
        accountStatus VARCHAR(50) NOT NULL DEFAULT 'Active',
        municipality VARCHAR(100),
        wardNo VARCHAR(50),
        province VARCHAR(100),
        memberSince TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
    );

-- ============================================================
-- Issues Table
-- ============================================================
CREATE TABLE
    issues (
        id INT AUTO_INCREMENT PRIMARY KEY,
        issueId VARCHAR(100) NOT NULL UNIQUE,
        title VARCHAR(200) NOT NULL,
        description TEXT NOT NULL,
        category VARCHAR(50),
        status VARCHAR(50) DEFAULT 'Open',
        priority VARCHAR(20) DEFAULT 'Medium',
        imagePath VARCHAR(500),
        location VARCHAR(200),
        userId INT NOT NULL,
        municipality_id INT NOT NULL,
        ward_no INT NOT NULL,
        createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
        CONSTRAINT fk_issue_user FOREIGN KEY (userId) REFERENCES users (id) ON DELETE CASCADE,
        CONSTRAINT fk_issue_municipality FOREIGN KEY (municipality_id) REFERENCES municipalities (id) ON DELETE RESTRICT,
        INDEX idx_status (status),
        INDEX idx_category (category),
        INDEX idx_userId (userId),
        INDEX idx_issue_municipality (municipality_id),
        INDEX idx_issue_ward (ward_no)
    );

-- ============================================================
-- Upvotes Table
-- ============================================================
CREATE TABLE
    upvotes (
        id INT AUTO_INCREMENT PRIMARY KEY,
        issueId INT NOT NULL,
        userId INT NOT NULL,
        createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        CONSTRAINT fk_upvote_issue FOREIGN KEY (issueId) REFERENCES issues (id) ON DELETE CASCADE,
        CONSTRAINT fk_upvote_user FOREIGN KEY (userId) REFERENCES users (id) ON DELETE CASCADE,
        CONSTRAINT uq_upvote UNIQUE (issueId, userId),
        INDEX idx_issueId (issueId),
        INDEX idx_userId (userId)
    );

-- ============================================================
-- Comments Table
-- ============================================================
CREATE TABLE
    comments (
        id INT AUTO_INCREMENT PRIMARY KEY,
        commentId VARCHAR(100) NOT NULL UNIQUE,
        issueId INT NOT NULL,
        userId INT NOT NULL,
        content TEXT NOT NULL,
        createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
        CONSTRAINT fk_comment_issue FOREIGN KEY (issueId) REFERENCES issues (id) ON DELETE CASCADE,
        CONSTRAINT fk_comment_user FOREIGN KEY (userId) REFERENCES users (id) ON DELETE CASCADE,
        INDEX idx_issueId (issueId),
        INDEX idx_userId (userId)
    );

-- ============================================================
-- Notifications Table
-- ============================================================
CREATE TABLE
    notifications (
        id INT AUTO_INCREMENT PRIMARY KEY,
        audience ENUM ('CITIZEN', 'MUNICIPALITY') NOT NULL,
        user_id INT NULL,
        municipality_id INT NULL,
        issue_id INT NULL,
        type VARCHAR(50) NOT NULL,
        title VARCHAR(200) NOT NULL,
        message TEXT NOT NULL,
        is_read TINYINT(1) NOT NULL DEFAULT 0,
        event_key VARCHAR(255) NULL,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        CONSTRAINT fk_notification_user FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE,
        CONSTRAINT fk_notification_municipality FOREIGN KEY (municipality_id) REFERENCES municipalities (id) ON DELETE CASCADE,
        CONSTRAINT fk_notification_issue FOREIGN KEY (issue_id) REFERENCES issues (id) ON DELETE CASCADE,
        UNIQUE KEY uq_notification_event (event_key),
        INDEX idx_notification_audience_user (audience, user_id),
        INDEX idx_notification_audience_municipality (audience, municipality_id),
        INDEX idx_notification_created_at (created_at)
    );

-- ============================================================
-- Seed: Super Admin User
-- ============================================================
-- Default Credentials:
-- Email: superadmin@system.local
-- Password: admin123
-- ============================================================
INSERT INTO
    users (
        userId,
        firstName,
        lastName,
        email,
        phoneNumber,
        password,
        role,
        accountStatus,
        municipality,
        wardNo,
        province,
        memberSince
    )
VALUES
    (
        'ADMIN-001',
        'Super',
        'Admin',
        'superadmin@system.local',
        NULL,
        'S4H4hhggAOVIWUkBym6GHvxf5pVCUD7gHtunDfvFBaGdI0gv9rME1JFeA76c0pXA',
        'Super Admin',
        'Active',
        'System',
        'N/A',
        'System',
        CURRENT_TIMESTAMP
    );

-- ============================================================
-- Migration: Add Municipality and Ward Support to Issues
-- Description: Adds municipality_id and ward_no columns to issues table
--              and ensures unique ward numbering per municipality
-- ============================================================


-- Add UNIQUE constraint to wards table

-- ALTER TABLE wards ADD CONSTRAINT uq_ward_number_per_municipality UNIQUE (municipality_id, ward_number);
-- -- Add new columns and constraints to issues table
-- ALTER TABLE issues
-- ADD COLUMN IF NOT EXISTS municipality_id INT NOT NULL,
-- ADD COLUMN IF NOT EXISTS ward_no INT NOT NULL,
-- ADD CONSTRAINT fk_issue_municipality FOREIGN KEY (municipality_id) REFERENCES municipalities (id) ON DELETE RESTRICT,
-- ADD INDEX idx_issue_municipality (municipality_id),
-- ADD INDEX idx_issue_ward (ward_no);
-- -- Normalize user account status to active/inactive model
-- ALTER TABLE users MODIFY COLUMN accountStatus VARCHAR(50) NOT NULL DEFAULT 'Active';
-- UPDATE users
-- SET
--     accountStatus = 'Active'
-- WHERE
--     accountStatus IS NULL
--     OR LOWER(TRIM(accountStatus)) IN (
--         'verified account',
--         'pending verification',
--         'verified',
--         'enabled'
--     );