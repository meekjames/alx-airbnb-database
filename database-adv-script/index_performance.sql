-- Database Indexes for Performance Optimization

-- User Table Indexes
CREATE INDEX idx_user_email ON User(email);
CREATE INDEX idx_user_role ON User(role);
CREATE INDEX idx_user_created_at ON User(created_at);

-- Booking Table Indexes
CREATE INDEX idx_booking_property_id ON Booking(property_id);
CREATE INDEX idx_booking_user_id ON Booking(user_id);
CREATE INDEX idx_booking_dates ON Booking(start_date, end_date);
CREATE INDEX idx_booking_status ON Booking(status);
CREATE INDEX idx_booking_created_at ON Booking(created_at);

-- Property Table Indexes
CREATE INDEX idx_property_host_id ON Property(host_id);
CREATE INDEX idx_property_location ON Property(location);
CREATE INDEX idx_property_price ON Property(price_per_night);
CREATE INDEX idx_property_created_at ON Property(created_at);

-- Composite Indexes for Complex Queries
CREATE INDEX idx_booking_property_dates ON Booking(property_id, start_date, end_date);
CREATE INDEX idx_booking_user_status ON Booking(user_id, status);
CREATE INDEX idx_property_location_price ON Property(location, price_per_night);

-- Performance Measurement Queries

-- Before Index: Measure baseline performance
EXPLAIN ANALYZE SELECT * FROM Booking WHERE property_id = 'sample-uuid-here';
EXPLAIN ANALYZE SELECT * FROM User WHERE email = 'user@example.com';
EXPLAIN ANALYZE SELECT * FROM Property WHERE location = 'New York' AND price_per_night BETWEEN 100 AND 200;

-- After Index: Measure improved performance
EXPLAIN ANALYZE SELECT * FROM Booking WHERE property_id = 'sample-uuid-here';
EXPLAIN ANALYZE SELECT * FROM User WHERE email = 'user@example.com';
EXPLAIN ANALYZE SELECT * FROM Property WHERE location = 'New York' AND price_per_night BETWEEN 100 AND 200;

-- Complex Query Performance Tests
EXPLAIN ANALYZE 
SELECT p.name, p.location, COUNT(b.booking_id) as booking_count
FROM Property p
LEFT JOIN Booking b ON p.property_id = b.property_id
WHERE p.location = 'San Francisco'
GROUP BY p.property_id, p.name, p.location
ORDER BY booking_count DESC;

EXPLAIN ANALYZE
SELECT u.first_name, u.last_name, b.start_date, b.end_date, p.name
FROM User u
JOIN Booking b ON u.user_id = b.user_id
JOIN Property p ON b.property_id = p.property_id
WHERE b.status = 'confirmed'
AND b.start_date >= '2025-01-01'
ORDER BY b.start_date;