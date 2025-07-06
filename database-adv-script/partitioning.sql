ALTER TABLE bookings RENAME TO bookings_old;

CREATE TABLE bookings (
    booking_id UUID PRIMARY KEY,
    property_id UUID NOT NULL,
    user_id UUID NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL(10,2) NOT NULL,
    status VARCHAR(20) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (property_id) REFERENCES properties(property_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
) PARTITION BY RANGE (start_date);

CREATE TABLE bookings_2023 PARTITION OF bookings
    FOR VALUES FROM ('2023-01-01') TO ('2024-01-01');

CREATE TABLE bookings_2024 PARTITION OF bookings
    FOR VALUES FROM ('2024-01-01') TO ('2025-01-01');

CREATE TABLE bookings_2025 PARTITION OF bookings
    FOR VALUES FROM ('2025-01-01') TO ('2026-01-01');

CREATE TABLE bookings_2026 PARTITION OF bookings
    FOR VALUES FROM ('2026-01-01') TO ('2027-01-01');

CREATE INDEX idx_bookings_property_id ON bookings (property_id);
CREATE INDEX idx_bookings_user_id ON bookings (user_id);
CREATE INDEX idx_bookings_status ON bookings (status);
CREATE INDEX idx_bookings_date_range ON bookings (start_date, end_date);

INSERT INTO bookings SELECT * FROM bookings_old;

ANALYZE bookings;