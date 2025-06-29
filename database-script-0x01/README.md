# AirBnB Database Schema

## Overview
Complete MySQL database schema for an AirBnB-like platform with users, properties, bookings, payments, reviews, and messaging.

## Quick Setup
mysql -u root -p < airbnb_schema.sql

## Database Structure
- users - Guest, host, and admin accounts
- properties - Property listings with pricing
- bookings - Reservations and booking status
- payments - Payment transactions
- reviews - Property ratings and comments
- messages - User-to-user communication

## Key Features
- UUID primary keys
- Foreign key constraints with CASCADE
- Data validation triggers
- Performance indexes
- Built-in views for common queries
- Business logic enforcement (no host self-booking, no overlapping bookings)

## Sample Usage
USE airbnb_db;
SELECT * FROM property_details;
SELECT * FROM booking_summary;

## Requirements
- MySQL 8.0+ (for UUID() function support)
- Sufficient privileges for database creation