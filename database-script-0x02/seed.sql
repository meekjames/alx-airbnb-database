-- AirBnB Database - Sample Data Seeding Script
-- This script populates the database with realistic sample data

USE airbnb_db;

-- Disable foreign key checks temporarily for easier insertion
SET FOREIGN_KEY_CHECKS = 0;

-- ========================================
-- 1. SEED USERS TABLE
-- ========================================

INSERT INTO users (user_id, first_name, last_name, email, password_hash, phone_number, role) VALUES
-- Hosts
('550e8400-e29b-41d4-a716-446655440001', 'Sarah', 'Johnson', 'sarah.johnson@email.com', SHA2('password123', 256), '+1-555-0101', 'host'),
('550e8400-e29b-41d4-a716-446655440002', 'Michael', 'Chen', 'michael.chen@email.com', SHA2('password123', 256), '+1-555-0102', 'host'),
('550e8400-e29b-41d4-a716-446655440003', 'Emma', 'Rodriguez', 'emma.rodriguez@email.com', SHA2('password123', 256), '+1-555-0103', 'host'),
('550e8400-e29b-41d4-a716-446655440004', 'David', 'Wilson', 'david.wilson@email.com', SHA2('password123', 256), '+1-555-0104', 'host'),
('550e8400-e29b-41d4-a716-446655440005', 'Lisa', 'Thompson', 'lisa.thompson@email.com', SHA2('password123', 256), '+1-555-0105', 'host'),

-- Guests
('550e8400-e29b-41d4-a716-446655440006', 'John', 'Smith', 'john.smith@email.com', SHA2('password123', 256), '+1-555-0106', 'guest'),
('550e8400-e29b-41d4-a716-446655440007', 'Amanda', 'Davis', 'amanda.davis@email.com', SHA2('password123', 256), '+1-555-0107', 'guest'),
('550e8400-e29b-41d4-a716-446655440008', 'Robert', 'Brown', 'robert.brown@email.com', SHA2('password123', 256), '+1-555-0108', 'guest'),
('550e8400-e29b-41d4-a716-446655440009', 'Jennifer', 'Martinez', 'jennifer.martinez@email.com', SHA2('password123', 256), '+1-555-0109', 'guest'),
('550e8400-e29b-41d4-a716-446655440010', 'Chris', 'Anderson', 'chris.anderson@email.com', SHA2('password123', 256), '+1-555-0110', 'guest'),
('550e8400-e29b-41d4-a716-446655440011', 'Maria', 'Garcia', 'maria.garcia@email.com', SHA2('password123', 256), '+1-555-0111', 'guest'),
('550e8400-e29b-41d4-a716-446655440012', 'James', 'Taylor', 'james.taylor@email.com', SHA2('password123', 256), '+1-555-0112', 'guest'),

-- Admins
('550e8400-e29b-41d4-a716-446655440013', 'Admin', 'User', 'admin@airbnb.com', SHA2('admin123', 256), '+1-555-0113', 'admin'),
('550e8400-e29b-41d4-a716-446655440014', 'Support', 'Team', 'support@airbnb.com', SHA2('support123', 256), '+1-555-0114', 'admin');

-- ========================================
-- 2. SEED PROPERTIES TABLE
-- ========================================

INSERT INTO properties (property_id, host_id, name, description, location, price_per_night, created_at) VALUES
-- Sarah's Properties
('660e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440001', 'Cozy Downtown Apartment', 'Beautiful 2-bedroom apartment in the heart of downtown. Walking distance to restaurants, shops, and public transportation. Perfect for business travelers and tourists alike.', 'New York, NY', 150.00, '2024-01-15 10:30:00'),
('660e8400-e29b-41d4-a716-446655440002', '550e8400-e29b-41d4-a716-446655440001', 'Luxury Penthouse Suite', 'Stunning penthouse with panoramic city views, modern amenities, and rooftop access. Ideal for special occasions and luxury getaways.', 'New York, NY', 450.00, '2024-01-20 14:15:00'),

-- Michael's Properties
('660e8400-e29b-41d4-a716-446655440003', '550e8400-e29b-41d4-a716-446655440002', 'Beach House Paradise', 'Oceanfront property with private beach access, 3 bedrooms, full kitchen, and outdoor deck. Perfect for family vacations and romantic retreats.', 'Malibu, CA', 320.00, '2024-02-01 09:45:00'),
('660e8400-e29b-41d4-a716-446655440004', '550e8400-e29b-41d4-a716-446655440002', 'Mountain Cabin Retreat', 'Rustic cabin nestled in the mountains with hiking trails, fireplace, and stunning natural views. Great for outdoor enthusiasts.', 'Aspen, CO', 200.00, '2024-02-10 16:20:00'),
-- Emma's Properties
('660e8400-e29b-41d4-a716-446655440005', '550e8400-e29b-41d4-a716-446655440003', 'Historic Brownstone', 'Charming historic brownstone in trendy neighborhood. Original architecture with modern updates. Close to museums and galleries.', 'Boston, MA', 180.00, '2024-02-15 11:00:00'),
('660e8400-e29b-41d4-a716-446655440006', '550e8400-e29b-41d4-a716-446655440003', 'Modern Studio Loft', 'Sleek studio loft with floor-to-ceiling windows, contemporary furnishings, and city skyline views. Perfect for solo travelers.', 'Chicago, IL', 120.00, '2024-02-20 13:30:00'),

-- David's Properties
('660e8400-e29b-41d4-a716-446655440007', '550e8400-e29b-41d4-a716-446655440004', 'Lakefront Cottage', 'Peaceful cottage on pristine lake with private dock, canoe, and fishing equipment. Ideal for nature lovers and families.', 'Lake Tahoe, CA', 250.00, '2024-03-01 08:15:00'),
('660e8400-e29b-41d4-a716-446655440008', '550e8400-e29b-41d4-a716-446655440004', 'Urban Garden House', 'Unique house with beautiful garden in urban setting. Eco-friendly features and organic garden. Great for environmentally conscious guests.', 'Portland, OR', 160.00, '2024-03-05 12:45:00'),

-- Lisa's Properties
('660e8400-e29b-41d4-a716-446655440009', '550e8400-e29b-41d4-a716-446655440005', 'Desert Villa Oasis', 'Luxurious desert villa with pool, spa, and mountain views. Modern southwestern architecture with premium amenities.', 'Scottsdale, AZ', 380.00, '2024-03-10 15:20:00'),
('660e8400-e29b-41d4-a716-446655440010', '550e8400-e29b-41d4-a716-446655440005', 'Wine Country Estate', 'Elegant estate in wine country with vineyard views, wine cellar, and gourmet kitchen. Perfect for wine enthusiasts and groups.', 'Napa Valley, CA', 500.00, '2024-03-15 10:00:00');

-- ========================================
-- 3. SEED BOOKINGS TABLE
-- ========================================

INSERT INTO bookings (booking_id, property_id, user_id, start_date, end_date, total_price, status, created_at) VALUES
-- Confirmed Bookings (Past and Current)
('770e8400-e29b-41d4-a716-446655440001', '660e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440006', '2024-12-01', '2024-12-05', 600.00, 'confirmed', '2024-11-15 09:30:00'),
('770e8400-e29b-41d4-a716-446655440002', '660e8400-e29b-41d4-a716-446655440003', '550e8400-e29b-41d4-a716-446655440007', '2024-12-10', '2024-12-17', 2240.00, 'confirmed', '2024-11-20 14:15:00'),
('770e8400-e29b-41d4-a716-446655440003', '660e8400-e29b-41d4-a716-446655440005', '550e8400-e29b-41d4-a716-446655440008', '2024-12-15', '2024-12-18', 540.00, 'confirmed', '2024-11-25 16:45:00'),
('770e8400-e29b-41d4-a716-446655440004', '660e8400-e29b-41d4-a716-446655440007', '550e8400-e29b-41d4-a716-446655440009', '2024-12-20', '2024-12-25', 1250.00, 'confirmed', '2024-12-01 11:20:00'),

-- Future Bookings (Confirmed)
('770e8400-e29b-41d4-a716-446655440005', '660e8400-e29b-41d4-a716-446655440002', '550e8400-e29b-41d4-a716-446655440010', '2025-07-15', '2025-07-18', 1350.00, 'confirmed', '2025-06-20 10:30:00'),
('770e8400-e29b-41d4-a716-446655440006', '660e8400-e29b-41d4-a716-446655440004', '550e8400-e29b-41d4-a716-446655440011', '2025-08-01', '2025-08-07', 1200.00, 'confirmed', '2025-06-25 13:45:00'),
('770e8400-e29b-41d4-a716-446655440007', '660e8400-e29b-41d4-a716-446655440009', '550e8400-e29b-41d4-a716-446655440012', '2025-08-10', '2025-08-15', 1900.00, 'confirmed', '2025-06-28 15:20:00'),

-- Pending Bookings
('770e8400-e29b-41d4-a716-446655440008', '660e8400-e29b-41d4-a716-446655440006', '550e8400-e29b-41d4-a716-446655440006', '2025-09-01', '2025-09-05', 480.00, 'pending', '2025-06-29 08:15:00'),
('770e8400-e29b-41d4-a716-446655440009', '660e8400-e29b-41d4-a716-446655440008', '550e8400-e29b-41d4-a716-446655440007', '2025-09-10', '2025-09-14', 640.00, 'pending', '2025-06-29 12:30:00'),

-- Canceled Bookings
('770e8400-e29b-41d4-a716-446655440010', '660e8400-e29b-41d4-a716-446655440010', '550e8400-e29b-41d4-a716-446655440008', '2025-07-01', '2025-07-05', 2000.00, 'canceled', '2025-06-15 14:00:00');
-- ========================================
-- 4. SEED PAYMENTS TABLE
-- ========================================

INSERT INTO payments (payment_id, booking_id, amount, payment_date, payment_method) VALUES
-- Payments for Confirmed Bookings
('880e8400-e29b-41d4-a716-446655440001', '770e8400-e29b-41d4-a716-446655440001', 600.00, '2024-11-15 09:35:00', 'credit_card'),
('880e8400-e29b-41d4-a716-446655440002', '770e8400-e29b-41d4-a716-446655440002', 2240.00, '2024-11-20 14:20:00', 'stripe'),
('880e8400-e29b-41d4-a716-446655440003', '770e8400-e29b-41d4-a716-446655440003', 540.00, '2024-11-25 16:50:00', 'paypal'),
('880e8400-e29b-41d4-a716-446655440004', '770e8400-e29b-41d4-a716-446655440004', 1250.00, '2024-12-01 11:25:00', 'credit_card'),
('880e8400-e29b-41d4-a716-446655440005', '770e8400-e29b-41d4-a716-446655440005', 1350.00, '2025-06-20 10:35:00', 'stripe'),
('880e8400-e29b-41d4-a716-446655440006', '770e8400-e29b-41d4-a716-446655440006', 1200.00, '2025-06-25 13:50:00', 'credit_card'),
('880e8400-e29b-41d4-a716-446655440007', '770e8400-e29b-41d4-a716-446655440007', 1900.00, '2025-06-28 15:25:00', 'paypal');

-- ========================================
-- 5. SEED REVIEWS TABLE
-- ========================================

INSERT INTO reviews (review_id, property_id, user_id, rating, comment, created_at) VALUES
-- Reviews for completed stays
('990e8400-e29b-41d4-a716-446655440001', '660e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440006', 5, 'Absolutely perfect location! The apartment was clean, comfortable, and exactly as described. Sarah was an excellent host and very responsive. Would definitely stay here again!', '2024-12-06 10:15:00'),

('990e8400-e29b-41d4-a716-446655440002', '660e8400-e29b-41d4-a716-446655440003', '550e8400-e29b-41d4-a716-446655440007', 4, 'Beautiful beach house with amazing ocean views! The private beach access was incredible. Only minor issue was the WiFi could be stronger, but overall a fantastic vacation rental.', '2024-12-18 14:30:00'),

('990e8400-e29b-41d4-a716-446655440003', '660e8400-e29b-41d4-a716-446655440005', '550e8400-e29b-41d4-a716-446655440008', 5, 'The historic brownstone was charming and full of character. Emma provided excellent recommendations for local restaurants and attractions. The location was perfect for exploring the city.', '2024-12-19 09:45:00'),

('990e8400-e29b-41d4-a716-446655440004', '660e8400-e29b-41d4-a716-446655440007', '550e8400-e29b-41d4-a716-446655440009', 5, 'What a peaceful retreat! The lakefront cottage exceeded our expectations. We loved using the canoe and fishing equipment. David was very accommodating and the property was spotless.', '2024-12-26 16:20:00'),

('990e8400-e29b-41d4-a716-446655440005', '660e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440010', 4, 'Great downtown location with easy access to everything. The apartment was well-equipped and comfortable. Would recommend for business trips or city exploration.', '2024-11-10 11:30:00'),

('990e8400-e29b-41d4-a716-446655440006', '660e8400-e29b-41d4-a716-446655440003', '550e8400-e29b-41d4-a716-446655440011', 5, 'Dream beach vacation! The house was beautiful and the private beach was amazing. Michael was a great host and provided everything we needed for a perfect stay.', '2024-10-15 13:45:00'),

('990e8400-e29b-41d4-a716-446655440007', '660e8400-e29b-41d4-a716-446655440004', '550e8400-e29b-41d4-a716-446655440012', 4, 'Cozy mountain cabin perfect for our hiking trip. The fireplace was wonderful after long days on the trails. Great location for outdoor activities.', '2024-09-20 15:10:00'),

('990e8400-e29b-41d4-a716-446655440008', '660e8400-e29b-41d4-a716-446655440002', '550e8400-e29b-41d4-a716-446655440006', 5, 'Luxury at its finest! The penthouse views were breathtaking and the amenities were top-notch. Perfect for our anniversary celebration.', '2024-08-25 12:00:00');

-- ========================================
-- 6. SEED MESSAGES TABLE
-- ========================================
INSERT INTO messages (message_id, sender_id, recipient_id, message_body, sent_at) VALUES
-- Pre-booking inquiries
('aa0e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440006', '550e8400-e29b-41d4-a716-446655440001', 'Hi Sarah! I\'m interested in booking your downtown apartment for December 1-5. Is it available? Also, is parking included?', '2024-11-14 15:30:00'),
('aa0e8400-e29b-41d4-a716-446655440002', '550e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440006', 'Hi John! Yes, the apartment is available for those dates. Parking is included in a secure garage. I\'ll send you the booking details shortly!', '2024-11-14 16:15:00'),

-- Check-in instructions
('aa0e8400-e29b-41d4-a716-446655440003', '550e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440006', 'Your check-in is tomorrow! The key code is 4567. Apartment is on the 3rd floor, #3B. Let me know if you need anything during your stay!', '2024-11-30 18:45:00'),
('aa0e8400-e29b-41d4-a716-446655440004', '550e8400-e29b-41d4-a716-446655440006', '550e8400-e29b-41d4-a716-446655440001', 'Thank you! Just arrived and the apartment is perfect. Really appreciate the welcome basket and local recommendations!', '2024-12-01 20:30:00'),

-- Beach house communication
('aa0e8400-e29b-41d4-a716-446655440005', '550e8400-e29b-41d4-a716-446655440007', '550e8400-e29b-41d4-a716-446655440002', 'Hi Michael! We\'re so excited about our beach house stay next week. Any tips for the best local restaurants?', '2024-12-03 14:20:00'),
('aa0e8400-e29b-41d4-a716-446655440006', '550e8400-e29b-41d4-a716-446655440002', '550e8400-e29b-41d4-a716-446655440007', 'Hi Amanda! For seafood, try Neptune\'s Table (2 blocks away). For casual dining, Malibu Kitchen has great burgers. Both are walking distance!', '2024-12-03 15:45:00'),

-- Booking confirmation messages
('aa0e8400-e29b-41d4-a716-446655440007', '550e8400-e29b-41d4-a716-446655440008', '550e8400-e29b-41d4-a716-446655440003', 'Hello Emma! Just confirmed my booking for the historic brownstone. Can\'t wait to explore Boston! Any must-see attractions nearby?', '2024-11-25 17:30:00'),
('aa0e8400-e29b-41d4-a716-446655440008', '550e8400-e29b-41d4-a716-446655440003', '550e8400-e29b-41d4-a716-446655440008', 'Hi Robert! Welcome to Boston! The Freedom Trail starts just 3 blocks from the house. Also check out the Isabella Stewart Gardner Museum - it\'s amazing!', '2024-11-25 18:15:00'),

-- Host-to-guest follow-up
('aa0e8400-e29b-41d4-a716-446655440009', '550e8400-e29b-41d4-a716-446655440004', '550e8400-e29b-41d4-a716-446655440009', 'Hi Jennifer! Hope you\'re enjoying the lakefront cottage. The weather looks perfect for kayaking this weekend. Don\'t forget the life jackets are in the shed!', '2024-12-22 10:00:00'),
('aa0e8400-e29b-41d4-a716-446655440010', '550e8400-e29b-41d4-a716-446655440009', '550e8400-e29b-41d4-a716-446655440004', 'Thank you David! We\'ve been having an amazing time. The lake is beautiful and we caught some fish yesterday. This place is truly special!', '2024-12-22 19:30:00'),

-- Admin communications
('aa0e8400-e29b-41d4-a716-446655440011', '550e8400-e29b-41d4-a716-446655440013', '550e8400-e29b-41d4-a716-446655440001', 'Hi Sarah! Your property listings are performing well. Consider adding more photos to increase bookings. Let us know if you need any assistance!', '2025-01-15 09:00:00'),
('aa0e8400-e29b-41d4-a716-446655440012', '550e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440013', 'Thanks for the tip! I\'ll work on getting professional photos taken this week. Really appreciate the platform support!', '2025-01-15 14:30:00');

-- Re-enable foreign key checks
SET FOREIGN_KEY_CHECKS = 1;

-- ========================================
-- 7. VERIFICATION QUERIES
-- ========================================
-- Display summary of seeded data
SELECT 'Users' as Table_Name, COUNT(*) as Record_Count FROM users
UNION ALL
SELECT 'Properties', COUNT(*) FROM properties
UNION ALL
SELECT 'Bookings', COUNT(*) FROM bookings
UNION ALL
SELECT 'Payments', COUNT(*) FROM payments
UNION ALL
SELECT 'Reviews', COUNT(*) FROM reviews
UNION ALL
SELECT 'Messages', COUNT(*) FROM messages;

-- Show booking statistics by status
SELECT status, COUNT(*) as booking_count, SUM(total_price) as total_revenue
FROM bookings 
GROUP BY status;

-- Show property ratings
SELECT p.name, AVG(r.rating) as avg_rating, COUNT(r.rating) as review_count
FROM properties p
LEFT JOIN reviews r ON p.property_id = r.property_id
GROUP BY p.property_id, p.name
ORDER BY avg_rating DESC;

PRINT 'Sample data has been successfully inserted into the AirBnB database!';