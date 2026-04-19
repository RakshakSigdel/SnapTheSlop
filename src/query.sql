-- ============================================================
-- Drop & Create Database
-- ============================================================
DROP DATABASE IF EXISTS snaptheslop;
CREATE DATABASE snaptheslop;
USE snaptheslop;

-- ============================================================
-- Municipalities Table
-- ============================================================
CREATE TABLE municipalities (
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
CREATE TABLE wards (
    id INT AUTO_INCREMENT PRIMARY KEY,
    ward_number INT NOT NULL,
    ward_head VARCHAR(100),
    contact_number VARCHAR(20),
    status VARCHAR(20) NOT NULL DEFAULT 'active',
    municipality_id INT NOT NULL,
    CONSTRAINT fk_ward_municipality FOREIGN KEY (municipality_id) REFERENCES municipalities (id) ON DELETE CASCADE
);

-- ============================================================
-- Users Table
-- ============================================================
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    userId VARCHAR(100) NOT NULL UNIQUE,
    firstName VARCHAR(100) NOT NULL,
    lastName VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phoneNumber VARCHAR(20),
    password VARCHAR(255) NOT NULL,
    role VARCHAR(50) NOT NULL DEFAULT 'Registered Citizen',
    accountStatus VARCHAR(50) NOT NULL DEFAULT 'Verified Account',
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
CREATE TABLE issues (
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
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_issue_user FOREIGN KEY (userId) REFERENCES users (id) ON DELETE CASCADE,
    INDEX idx_status (status),
    INDEX idx_category (category),
    INDEX idx_userId (userId)
);

-- ============================================================
-- Upvotes Table
-- ============================================================
CREATE TABLE upvotes (
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
CREATE TABLE comments (
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
-- Seed: Super Admin User
-- ============================================================
-- Default Credentials:
-- Email: superadmin@system.local
-- Password: admin123
-- ============================================================
INSERT INTO users (userId, firstName, lastName, email, phoneNumber, password, role, accountStatus, municipality, wardNo, province, memberSince)
VALUES ('ADMIN-001', 'Super', 'Admin', 'superadmin@system.local', NULL, 'S4H4hhggAOVIWUkBym6GHvxf5pVCUD7gHtunDfvFBaGdI0gv9rME1JFeA76c0pXA', 'Super Admin', 'Verified Account', 'System', 'N/A', 'System', CURRENT_TIMESTAMP);
