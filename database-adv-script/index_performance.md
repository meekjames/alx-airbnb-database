# Database Indexing for Performance Optimization

## Overview

This guide covers implementing indexes to optimize query performance in the AirBnB database. Proper indexing significantly improves query execution time for frequently accessed data.

## High-Usage Columns Analysis

### User Table
- email - Used in login queries and uniqueness checks
- role - Filtered in role-based queries
- created_at - Used in date range queries and sorting

### Booking Table
- property_id - JOIN operations with Property table
- user_id - JOIN operations with User table
- start_date, end_date - Date range filtering and availability checks
- status - Filtering by booking status
- created_at - Sorting and date-based queries

### Property Table
- host_id - JOIN operations with User table
- location - Location-based searches
- price_per_night - Price range filtering and sorting
- created_at - Sorting by listing date

## Recommended Indexes

### User Table Indexes
```
CREATE INDEX idx_user_email ON User(email);
CREATE INDEX idx_user_role ON User(role);
CREATE INDEX idx_user_created_at ON User(created_at);
```

### Booking Table Indexes
```
CREATE INDEX idx_booking_property_id ON Booking(property_id);
CREATE INDEX idx_booking_user_id ON Booking(user_id);
CREATE INDEX idx_booking_dates ON Booking(start_date, end_date);
CREATE INDEX idx_booking_status ON Booking(status);
CREATE INDEX idx_booking_created_at ON Booking(created_at);
```

### Property Table Indexes
```
CREATE INDEX idx_property_host_id ON Property(host_id);
CREATE INDEX idx_property_location ON Property(location);
CREATE INDEX idx_property_price ON Property(price_per_night);
CREATE INDEX idx_property_created_at ON Property(created_at);
```

### Composite Indexes
```
CREATE INDEX idx_booking_property_dates ON Booking(property_id, start_date, end_date);
CREATE INDEX idx_booking_user_status ON Booking(user_id, status);
```

## Performance Analysis

### Before Indexing
```
Use EXPLAIN or ANALYZE to measure baseline performance:
EXPLAIN ANALYZE SELECT * FROM Booking WHERE property_id = 'uuid-value';
EXPLAIN ANALYZE SELECT * FROM User WHERE email = 'user@example.com';
```

### After Indexing
Run the same queries to compare performance improvements:
- Reduced execution time
- Lower cost estimates
- Index scan instead of table scan

## Index Types

### Single Column Indexes
- Best for queries filtering on one column
- Minimal storage overhead

### Composite Indexes
- Optimize queries using multiple columns
- Column order matters (most selective first)

### Unique Indexes
- Enforce uniqueness while providing performance benefits
- Already present on primary keys

## Monitoring and Maintenance

### Index Usage Statistics
```
SELECT * FROM pg_stat_user_indexes;
```

### Index Size Monitoring
```
SELECT schemaname, tablename, indexname, pg_size_pretty(pg_relation_size(indexrelid))
FROM pg_stat_user_indexes;
```

### Regular Maintenance
- Monitor index usage patterns
- Drop unused indexes
- Rebuild fragmented indexes
- Update statistics regularly

## Best Practices

1. Index Frequently Queried Columns - Focus on WHERE, JOIN, ORDER BY clauses
2. Avoid Over-Indexing - Each index adds overhead to INSERT/UPDATE operations
3. Use Composite Indexes Wisely - Consider query patterns and column selectivity
4. Monitor Performance - Regular analysis ensures indexes remain effective
5. Consider Storage Trade-offs - Indexes improve read performance but increase storage requirements

## Common Query Patterns

### Property Search
```
SELECT * FROM Property WHERE location = 'City' AND price_per_night BETWEEN 100 AND 200;
```
*Optimized by: idx_property_location, idx_property_price*

### Booking Availability
```
SELECT * FROM Booking WHERE property_id = 'uuid' AND start_date <= '2025-07-15' AND end_date >= '2025-07-10';
```
*Optimized by: idx_booking_property_dates*

### User Booking History
```
SELECT * FROM Booking WHERE user_id = 'uuid' AND status = 'confirmed';
```
*Optimized by: idx_booking_user_status*