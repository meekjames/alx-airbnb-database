# 📈 Query Optimization Report

## 🎯 Objective

This report outlines the optimization process applied to a complex SQL query that retrieves complete booking details, including user, property, and payment data, in the context of the Airbnb database schema.

---

## 📝 Initial Query

The original query retrieved:

- Booking information
- Associated user (guest) details
- Property details
- Related payment records

```sql
SELECT
    b.booking_id, b.start_date, b.end_date, b.status, b.total_price,
    u.user_id, u.first_name, u.last_name, u.email,
    p.property_id, p.name AS property_name, p.location, p.pricepernight,
    pay.payment_id, pay.amount, pay.payment_method, pay.payment_date
FROM bookings b
LEFT JOIN users u ON b.user_id = u.user_id
LEFT JOIN properties p ON b.property_id = p.property_id
LEFT JOIN payments pay ON b.booking_id = pay.booking_id;
```

---

## 🧪 Performance Analysis (Using `EXPLAIN ANALYZE`)

Using `EXPLAIN ANALYZE`, I observed the following inefficiencies:

- **Sequential scans** on `bookings`, `users`, and `properties`.
- **Nested loop joins** processing many rows unnecessarily.
- Lack of indexes on commonly joined foreign keys.

---

## ⚙️ Optimization Steps

### ✅ 1. Replaced `LEFT JOIN` with `INNER JOIN`

Since every booking must have a user and a property, I changed:

```sql
LEFT JOIN users ...  →  INNER JOIN users ...
LEFT JOIN properties ... →  INNER JOIN properties ...
```

> `LEFT JOIN` was kept only for `payments`, in case payment records are optional.

### ✅ 2. Added Strategic Indexes

Created indexes on foreign keys and commonly queried columns to enable efficient index scans:

```sql
CREATE INDEX idx_bookings_user_id ON bookings(user_id);
CREATE INDEX idx_bookings_property_id ON bookings(property_id);
CREATE INDEX idx_payments_booking_id ON payments(booking_id);
```

### ✅ 3. Selected Only Required Columns

Avoided using `SELECT *` to minimize the amount of data transferred and improve performance.

---

## ✅ Refactored Optimized Query

```sql
SELECT
    b.booking_id, b.start_date, b.end_date, b.status, b.total_price,
    u.user_id, u.first_name, u.last_name, u.email,
    p.property_id, p.name AS property_name, p.location, p.pricepernight,
    pay.payment_id, pay.amount, pay.payment_method, pay.payment_date
FROM bookings b
INNER JOIN users u ON b.user_id = u.user_id
INNER JOIN properties p ON b.property_id = p.property_id
LEFT JOIN payments pay ON b.booking_id = pay.booking_id;
```

---

## 📊 Result

After optimization:

- **Execution time was significantly reduced**
- **Index scans replaced full table scans**
- **Joins processed fewer rows**