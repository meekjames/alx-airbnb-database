-- AirBnB Database Schema - Data Definition Language (DDL)
-- This script creates the complete database schema for the AirBnB platform

-- ========================================
-- 1. CREATE DATABASE
-- ========================================

CREATE DATABASE IF NOT EXISTS airbnb_db;
USE airbnb_db;

-- ========================================
-- 2. CREATE TABLES
-- ========================================

-- Users Table
-- Stores information about all users (guests, hosts, admins)
CREATE TABLE users (
    user_id CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    phone_number VARCHAR(20) NULL,
    role ENUM('guest', 'host', 'admin') NOT NULL DEFAULT 'guest',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    -- Constraints
    CONSTRAINT chk_email_format CHECK (email REGEXP '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$'),
    CONSTRAINT chk_phone_format CHECK (phone_number IS NULL OR phone_number REGEXP '^[+]?[0-9\s\-\(\)]{10,15}$')
);

-- Properties Table
-- Stores property listings information
CREATE TABLE properties (
    property_id CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    host_id CHAR(36) NOT NULL,
    name VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    location VARCHAR(255) NOT NULL,
    price_per_night DECIMAL(10,2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    -- Foreign Key Constraints
    CONSTRAINT fk_properties_host FOREIGN KEY (host_id) REFERENCES users(user_id) ON DELETE CASCADE ON UPDATE CASCADE,
    
    -- Check Constraints
    CONSTRAINT chk_price_positive CHECK (price_per_night > 0),
    CONSTRAINT chk_name_not_empty CHECK (TRIM(name) != ''),
    CONSTRAINT chk_description_not_empty CHECK (TRIM(description) != ''),
    CONSTRAINT chk_location_not_empty CHECK (TRIM(location) != '')
);

-- Bookings Table
-- Stores booking/reservation information
CREATE TABLE bookings (
    booking_id CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    property_id CHAR(36) NOT NULL,
    user_id CHAR(36) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL(10,2) NOT NULL,
    status ENUM('pending', 'confirmed', 'canceled') NOT NULL DEFAULT 'pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    -- Foreign Key Constraints
    CONSTRAINT fk_bookings_property FOREIGN KEY (property_id) REFERENCES properties(property_id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_bookings_user FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE ON UPDATE CASCADE,
    
    -- Check Constraints
    CONSTRAINT chk_booking_dates CHECK (end_date > start_date),
    CONSTRAINT chk_booking_future CHECK (start_date >= CURDATE()),
    CONSTRAINT chk_total_price_positive CHECK (total_price > 0)
);

-- Payments Table
-- Stores payment transaction information
CREATE TABLE payments (
    payment_id CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    booking_id CHAR(36) NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    payment_method ENUM('credit_card', 'paypal', 'stripe') NOT NULL,
    
    -- Foreign Key Constraints
    CONSTRAINT fk_payments_booking FOREIGN KEY (booking_id) REFERENCES bookings(booking_id) ON DELETE CASCADE ON UPDATE CASCADE,
    
    -- Check Constraints
    CONSTRAINT chk_payment_amount_positive CHECK (amount > 0)
);

-- Reviews Table
-- Stores property reviews and ratings
CREATE TABLE reviews (
    review_id CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    property_id CHAR(36) NOT NULL,
    user_id CHAR(36) NOT NULL,
    rating INTEGER NOT NULL,
    comment TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    -- Foreign Key Constraints
    CONSTRAINT fk_reviews_property FOREIGN KEY (property_id) REFERENCES properties(property_id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_reviews_user FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE ON UPDATE CASCADE,
    
    -- Check Constraints
    CONSTRAINT chk_rating_range CHECK (rating >= 1 AND rating <= 5),
    CONSTRAINT chk_comment_not_empty CHECK (TRIM(comment) != ''),
    
    -- Unique Constraint (one review per user per property)
    CONSTRAINT uk_user_property_review UNIQUE (user_id, property_id)
);

-- Messages Table
-- Stores communication between users
CREATE TABLE messages (
    message_id CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    sender_id CHAR(36) NOT NULL,
    recipient_id CHAR(36) NOT NULL,
    message_body TEXT NOT NULL,
    sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    -- Foreign Key Constraints
    CONSTRAINT fk_messages_sender FOREIGN KEY (sender_id) REFERENCES users(user_id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_messages_recipient FOREIGN KEY (recipient_id) REFERENCES users(user_id) ON DELETE CASCADE ON UPDATE CASCADE,
    
    -- Check Constraints
    CONSTRAINT chk_message_not_empty CHECK (TRIM(message_body) != ''),
    CONSTRAINT chk_different_users CHECK (sender_id != recipient_id)
);

-- ========================================
-- 3. CREATE INDEXES FOR PERFORMANCE
-- ========================================

-- Users Table Indexes
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_users_role ON users(role);
CREATE INDEX idx_users_created_at ON users(created_at);

-- Properties Table Indexes
CREATE INDEX idx_properties_host_id ON properties(host_id);
CREATE INDEX idx_properties_location ON properties(location);
CREATE INDEX idx_properties_price ON properties(price_per_night);
CREATE INDEX idx_properties_created_at ON properties(created_at);

-- Bookings Table Indexes
CREATE INDEX idx_bookings_property_id ON bookings(property_id);
CREATE INDEX idx_bookings_user_id ON bookings(user_id);
CREATE INDEX idx_bookings_status ON bookings(status);
CREATE INDEX idx_bookings_dates ON bookings(start_date, end_date);
CREATE INDEX idx_bookings_created_at ON bookings(created_at);

-- Payments Table Indexes
CREATE INDEX idx_payments_booking_id ON payments(booking_id);
CREATE INDEX idx_payments_method ON payments(payment_method);
CREATE INDEX idx_payments_date ON payments(payment_date);

-- Reviews Table Indexes
CREATE INDEX idx_reviews_property_id ON reviews(property_id);
CREATE INDEX idx_reviews_user_id ON reviews(user_id);
CREATE INDEX idx_reviews_rating ON reviews(rating);
CREATE INDEX idx_reviews_created_at ON reviews(created_at);

-- Messages Table Indexes
CREATE INDEX idx_messages_sender_id ON messages(sender_id);
CREATE INDEX idx_messages_recipient_id ON messages(recipient_id);
CREATE INDEX idx_messages_sent_at ON messages(sent_at);

-- ========================================
-- 4. CREATE VIEWS FOR COMMON QUERIES
-- ========================================

-- View for Property Details with Host Information
CREATE VIEW property_details AS
SELECT 
    p.property_id,
    p.name AS property_name,
    p.description,
    p.location,
    p.price_per_night,
    p.created_at AS property_created_at,
    u.first_name AS host_first_name,
    u.last_name AS host_last_name,
    u.email AS host_email,
    u.phone_number AS host_phone
FROM properties p
JOIN users u ON p.host_id = u.user_id
WHERE u.role = 'host';
-- View for Booking Summary
CREATE VIEW booking_summary AS
SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status,
    p.name AS property_name,
    p.location AS property_location,
    CONCAT(u.first_name, ' ', u.last_name) AS guest_name,
    u.email AS guest_email,
    DATEDIFF(b.end_date, b.start_date) AS nights_booked
FROM bookings b
JOIN properties p ON b.property_id = p.property_id
JOIN users u ON b.user_id = u.user_id;

-- View for Property Reviews with User Information
CREATE VIEW property_reviews AS
SELECT 
    r.review_id,
    r.rating,
    r.comment,
    r.created_at AS review_date,
    p.name AS property_name,
    CONCAT(u.first_name, ' ', u.last_name) AS reviewer_name
FROM reviews r
JOIN properties p ON r.property_id = p.property_id
JOIN users u ON r.user_id = u.user_id;

-- ========================================
-- 5. CREATE TRIGGERS FOR DATA INTEGRITY
-- ========================================

-- Trigger to prevent hosts from booking their own properties
DELIMITER //
CREATE TRIGGER prevent_host_booking
BEFORE INSERT ON bookings
FOR EACH ROW
BEGIN
    DECLARE host_id_check CHAR(36);
    
    SELECT host_id INTO host_id_check
    FROM properties 
    WHERE property_id = NEW.property_id;
    
    IF host_id_check = NEW.user_id THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Hosts cannot book their own properties';
    END IF;
END//
DELIMITER ;

-- Trigger to prevent overlapping bookings
DELIMITER //
CREATE TRIGGER prevent_overlapping_bookings
BEFORE INSERT ON bookings
FOR EACH ROW
BEGIN
    DECLARE booking_count INT;
    
    SELECT COUNT(*) INTO booking_count
    FROM bookings
    WHERE property_id = NEW.property_id
    AND status IN ('pending', 'confirmed')
    AND ((NEW.start_date BETWEEN start_date AND end_date)
         OR (NEW.end_date BETWEEN start_date AND end_date)
         OR (start_date BETWEEN NEW.start_date AND NEW.end_date));
    
    IF booking_count > 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Property is already booked for the selected dates';
    END IF;
END//
DELIMITER ;

-- ========================================
-- 6. GRANT PERMISSIONS (OPTIONAL)
-- ========================================

-- Create application user with limited permissions
-- CREATE USER 'airbnb_app'@'localhost' IDENTIFIED BY 'secure_password';
-- GRANT SELECT, INSERT, UPDATE, DELETE ON airbnb_db.* TO 'airbnb_app'@'localhost';
-- FLUSH PRIVILEGES;

-- ========================================
-- 7. SAMPLE DATA INSERTION (FOR TESTING)
-- ========================================

-- Insert sample users
INSERT INTO users (user_id, first_name, last_name, email, password_hash, phone_number, role) VALUES
(UUID(), 'John', 'Doe', 'john.doe@email.com', SHA2('password123', 256), '+1234567890', 'host'),
(UUID(), 'Jane', 'Smith', 'jane.smith@email.com', SHA2('password456', 256), '+0987654321', 'guest'),
(UUID(), 'Admin', 'User', 'admin@airbnb.com', SHA2('admin123', 256), '+1122334455', 'admin');

-- Show tables to verify creation
SHOW TABLES;