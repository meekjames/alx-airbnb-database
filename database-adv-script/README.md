# AirBnB Database

A relational database schema for a vacation rental platform supporting users, properties, bookings, payments, reviews, and messaging.

## Schema Overview

### Core Tables
- **User** - Platform users (guests, hosts, admins)
- **Property** - Rental listings with pricing and location
- **Booking** - Reservations linking users to properties
- **Payment** - Financial transactions for bookings
- **Review** - Property ratings and comments
- **Message** - User-to-user communication

### Key Relationships
- Users can be guests (make bookings) or hosts (own properties)
- Properties belong to hosts and can have multiple bookings
- Bookings link guests to properties for specific date ranges
- Payments are tied to individual bookings
- Reviews are left by guests for properties they've booked
- Messages enable communication between any users

## Features

### Data Integrity
- UUID primary keys across all tables
- Foreign key constraints maintain referential integrity
- Enum constraints for status fields and user roles
- Rating validation (1-5 scale)

### Performance
- Indexed primary keys and frequently queried fields
- Optimized for booking searches and user lookups

### Business Logic
- Booking status workflow (pending → confirmed/canceled)
- Multiple payment method support
- Role-based user access (guest/host/admin)
- Timestamped records for audit trails

## Sample Queries

### INNER JOIN - Bookings with User Details
```sql
SELECT b.booking_id, b.start_date, b.end_date, u.first_name, u.last_name
FROM Booking b
INNER JOIN User u ON b.user_id = u.user_id;
```

### LEFT JOIN - Properties with Optional Reviews
```sql
SELECT p.name, p.location, r.rating, r.comment
FROM Property p
LEFT JOIN Review r ON p.property_id = r.property_id;
```

### FULL OUTER JOIN - All Users and Bookings
```sql
SELECT u.first_name, u.last_name, b.booking_id, b.status
FROM User u
FULL OUTER JOIN Booking b ON u.user_id = b.user_id;
```

## Database Constraints

- Email uniqueness across users
- Non-null constraints on essential fields
- Foreign key relationships prevent orphaned records
- Check constraints on rating values
- Enum validation for status and role fields