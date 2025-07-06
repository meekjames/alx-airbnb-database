# Booking Table Partitioning Performance Analysis

## Overview
Implementation of table partitioning on the `bookings` table using PostgreSQL's range partitioning by `start_date` to optimize query performance on large datasets.

## Implementation
- **File**: `partitioning.sql`
- **Strategy**: Range partitioning by `start_date` (yearly partitions)
- **Partitions**: 2023, 2024, 2025, 2026

## Performance Testing

### Test Queries
```sql
-- Date range query
EXPLAIN ANALYZE
SELECT * FROM bookings 
WHERE start_date BETWEEN '2024-01-01' AND '2024-12-31';

-- Multi-filter query
EXPLAIN ANALYZE
SELECT booking_id, property_id, total_price 
FROM bookings 
WHERE start_date >= '2024-06-01' AND status = 'confirmed';

-- Count by date range
EXPLAIN ANALYZE
SELECT COUNT(*) FROM bookings 
WHERE start_date BETWEEN '2024-01-01' AND '2024-03-31';
```

## Expected Improvements
- **Partition pruning**: Only relevant partitions scanned
- **Reduced I/O**: Lower disk operations for date-based queries
- **Faster execution**: Improved performance for date range filters
- **Better concurrency**: Smaller partition locks

## Monitoring
```sql
-- Check partition pruning
EXPLAIN (ANALYZE, BUFFERS) 
SELECT * FROM bookings WHERE start_date = '2024-06-15';

-- Monitor partition sizes
SELECT tablename, pg_size_pretty(pg_total_relation_size(tablename)) as size
FROM pg_tables WHERE tablename LIKE 'bookings%';
```

## Maintenance
```sql
-- Add new partition
CREATE TABLE bookings_2027 PARTITION OF bookings
    FOR VALUES FROM ('2027-01-01') TO ('2028-01-01');

-- Drop old partition
DROP TABLE bookings_2023;
```

## Best Practices
- Include `start_date` in WHERE clauses for optimal partition pruning
- Use date ranges aligned with partition boundaries
- Monitor execution plans to verify partition pruning effectiveness