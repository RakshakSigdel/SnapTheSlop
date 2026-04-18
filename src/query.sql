-- ============================================================
-- Drop & Create Database
-- ============================================================
DROP
DATABASE IF EXISTS snaptheslop;
CREATE
DATABASE snaptheslop;
USE
snaptheslop;

-- ============================================================
-- Municipalities
-- ============================================================
CREATE TABLE municipalities
(
    id             INT AUTO_INCREMENT PRIMARY KEY,
    name           VARCHAR(100) NOT NULL,
    district       VARCHAR(100) NOT NULL,
    province       VARCHAR(100) NOT NULL,
    contact_number VARCHAR(20),
    email          VARCHAR(100),
    office_address TEXT
);

-- ============================================================
-- Wards
-- ============================================================
CREATE TABLE wards
(
    id              INT AUTO_INCREMENT PRIMARY KEY,
    ward_number     INT         NOT NULL,
    ward_head       VARCHAR(100),
    contact_number  VARCHAR(20),
    status          VARCHAR(20) NOT NULL DEFAULT 'active',
    municipality_id INT         NOT NULL,

    CONSTRAINT fk_ward_municipality
        FOREIGN KEY (municipality_id) REFERENCES municipalities (id)
            ON DELETE CASCADE
);

-- ============================================================
-- Users
-- ============================================================
CREATE TABLE users
(
    id              INT AUTO_INCREMENT PRIMARY KEY,
    full_name       VARCHAR(100) NOT NULL,
    email           VARCHAR(100) NOT NULL UNIQUE,
    phone           VARCHAR(20),
    password_hash   VARCHAR(255) NOT NULL,
    role            VARCHAR(20)  NOT NULL DEFAULT 'citizen',
    status          VARCHAR(20)  NOT NULL DEFAULT 'active',
    created_at      TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    municipality_id INT NULL,

    CONSTRAINT fk_user_municipality
        FOREIGN KEY (municipality_id) REFERENCES municipalities (id)
            ON DELETE SET NULL,

    CONSTRAINT chk_role
        CHECK (role IN ('superadmin', 'municipal_head', 'citizen'))
);

-- Only one municipal head per municipality
CREATE UNIQUE INDEX uq_one_head_per_municipality
    ON users (municipality_id, role);

-- ============================================================
-- Issues
-- ============================================================
CREATE TABLE issues
(
    id          INT AUTO_INCREMENT PRIMARY KEY,
    title       VARCHAR(200) NOT NULL,
    description TEXT         NOT NULL,
    category    VARCHAR(50)  NOT NULL,
    status      VARCHAR(20)  NOT NULL DEFAULT 'open',
    priority    VARCHAR(20)  NOT NULL DEFAULT 'medium',
    image_path  VARCHAR(500),
    is_spam     BOOLEAN      NOT NULL DEFAULT FALSE,
    created_at  TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at  TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    user_id     INT          NOT NULL,
    ward_id     INT          NOT NULL,

    CONSTRAINT fk_issue_user
        FOREIGN KEY (user_id) REFERENCES users (id)
            ON DELETE CASCADE,

    CONSTRAINT fk_issue_ward
        FOREIGN KEY (ward_id) REFERENCES wards (id)
            ON DELETE CASCADE,

    CONSTRAINT chk_status
        CHECK (status IN ('open', 'in_progress', 'resolved', 'rejected')),

    CONSTRAINT chk_priority
        CHECK (priority IN ('low', 'medium', 'high'))
);

-- ============================================================
-- Upvotes
-- ============================================================
CREATE TABLE upvotes
(
    id       INT AUTO_INCREMENT PRIMARY KEY,
    issue_id INT NOT NULL,
    user_id  INT NOT NULL,

    CONSTRAINT fk_upvote_issue
        FOREIGN KEY (issue_id) REFERENCES issues (id)
            ON DELETE CASCADE,

    CONSTRAINT fk_upvote_user
        FOREIGN KEY (user_id) REFERENCES users (id)
            ON DELETE CASCADE,

    CONSTRAINT uq_upvote UNIQUE (issue_id, user_id)
);

-- ============================================================
-- Seed: Super Admin
-- ============================================================
INSERT INTO users (full_name, email, phone, password_hash, role, municipality_id)
VALUES ('Super Admin',
        'superadmin@system.local',
        NULL,
        '$2b$12$replacethiswitharealhashedpasswordbeforedeployment',
        'superadmin',
        NULL);