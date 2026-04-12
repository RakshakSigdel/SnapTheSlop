-- Create database
CREATE DATABASE IF NOT EXISTS snaptheslop;
USE snaptheslop;

-- Create users table
CREATE TABLE IF NOT EXISTS users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    userId VARCHAR(50) UNIQUE NOT NULL,
    firstName VARCHAR(100) NOT NULL,
    lastName VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    phoneNumber VARCHAR(20),
    password VARCHAR(255) NOT NULL,
    municipality VARCHAR(150),
    wardNo VARCHAR(50),
    province VARCHAR(100),
    role VARCHAR(50) DEFAULT 'Registered Citizen',
    accountStatus VARCHAR(50) DEFAULT 'Pending Verification',
    memberSince DATETIME DEFAULT CURRENT_TIMESTAMP,
    createdAt DATETIME DEFAULT CURRENT_TIMESTAMP,
    updatedAt DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_email (email),
    INDEX idx_userId (userId)
);

-- Create issues table (for citizen reporting)
CREATE TABLE IF NOT EXISTS issues (
    id INT PRIMARY KEY AUTO_INCREMENT,
    issueId VARCHAR(50) UNIQUE NOT NULL,
    userId VARCHAR(50) NOT NULL,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    category VARCHAR(100),
    location VARCHAR(255),
    latitude DECIMAL(10, 8),
    longitude DECIMAL(11, 8),
    status VARCHAR(50) DEFAULT 'Open',
    priority VARCHAR(50) DEFAULT 'Medium',
    imageUrl VARCHAR(500),
    createdAt DATETIME DEFAULT CURRENT_TIMESTAMP,
    updatedAt DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (userId) REFERENCES users(userId),
    INDEX idx_status (status),
    INDEX idx_category (category)
);

-- Create comments table
CREATE TABLE IF NOT EXISTS comments (
    id INT PRIMARY KEY AUTO_INCREMENT,
    commentId VARCHAR(50) UNIQUE NOT NULL,
    issueId VARCHAR(50) NOT NULL,
    userId VARCHAR(50) NOT NULL,
    comment TEXT NOT NULL,
    createdAt DATETIME DEFAULT CURRENT_TIMESTAMP,
    updatedAt DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (issueId) REFERENCES issues(issueId),
    FOREIGN KEY (userId) REFERENCES users(userId)
);

-- Create upvotes table
CREATE TABLE IF NOT EXISTS upvotes (
    id INT PRIMARY KEY AUTO_INCREMENT,
    issueId VARCHAR(50) NOT NULL,
    userId VARCHAR(50) NOT NULL,
    createdAt DATETIME DEFAULT CURRENT_TIMESTAMP,
    UNIQUE KEY unique_upvote (issueId, userId),
    FOREIGN KEY (issueId) REFERENCES issues(issueId),
    FOREIGN KEY (userId) REFERENCES users(userId)
);

-- Create admin actions log table
CREATE TABLE IF NOT EXISTS admin_actions (
    id INT PRIMARY KEY AUTO_INCREMENT,
    actionId VARCHAR(50) UNIQUE NOT NULL,
    adminId VARCHAR(50) NOT NULL,
    targetId VARCHAR(50),
    actionType VARCHAR(100),
    description TEXT,
    createdAt DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (adminId) REFERENCES users(userId)
);
