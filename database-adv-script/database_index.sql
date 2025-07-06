CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_users_user_id ON users(user_id);

CREATE INDEX idx_bookings_user_id ON bookings(user_id);
CREATE INDEX idx_bookings_property_id ON bookings(property_id);
CREATE INDEX idx_bookings_status ON bookings(status);
CREATE INDEX idx_bookings_start_date ON bookings(start_date);

CREATE INDEX idx_properties_host_id ON properties(host_id);
CREATE INDEX idx_properties_location ON properties(location);
CREATE INDEX idx_properties_price ON properties(pricepernight);

EXPLAIN ANALYZE
SELECT 
    b.booking_id,
    b.start_date,
    b.status,
    u.first_name,
    u.email,
    p.name AS property_name,
    p.location
FROM bookings b
INNER JOIN users u ON b.user_id = u.user_id
INNER JOIN properties p ON b.property_id = p.property_id
WHERE 
    b.status = 'confirmed'
    AND b.start_date BETWEEN '2024-06-01' AND '2024-06-30'
    AND u.email ILIKE 'alice@example.com%'
    AND p.location = 'Nairobi';