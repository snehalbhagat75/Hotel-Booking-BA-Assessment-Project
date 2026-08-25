
schema_sql = """-- Normalized hotel booking schema
CREATE TABLE customers (
    customer_id INTEGER PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    customer_segment VARCHAR(20) NOT NULL,
    customer_signup_date DATE NOT NULL,
    customer_home_city VARCHAR(100) NOT NULL,
    customer_loyalty_tier VARCHAR(20) NOT NULL
);

CREATE TABLE properties (
    property_id INTEGER PRIMARY KEY,
    property_name VARCHAR(150) NOT NULL,
    property_city VARCHAR(100) NOT NULL,
    property_star_rating INTEGER NOT NULL CHECK (property_star_rating BETWEEN 1 AND 5),
    property_type VARCHAR(30) NOT NULL,
    property_total_rooms INTEGER NOT NULL CHECK (property_total_rooms > 0),
    CONSTRAINT uq_property_name_city UNIQUE (property_name, property_city)
);

CREATE TABLE bookings (
    booking_id INTEGER PRIMARY KEY,
    customer_id INTEGER NOT NULL,
    property_id INTEGER NOT NULL,
    booking_date DATE NOT NULL,
    checkin_date DATE NOT NULL,
    checkout_date DATE NOT NULL,
    room_type VARCHAR(50) NOT NULL,
    num_rooms INTEGER NOT NULL CHECK (num_rooms > 0),
    nights INTEGER NOT NULL CHECK (nights > 0),
    booking_channel VARCHAR(30) NOT NULL,
    adr DECIMAL(12,2) NOT NULL CHECK (adr >= 0),
    discount_amount DECIMAL(12,2) NOT NULL CHECK (discount_amount >= 0),
    coupon_code VARCHAR(50) NOT NULL,
    total_amount DECIMAL(14,2) NOT NULL CHECK (total_amount >= 0),
    payment_method VARCHAR(50) NOT NULL,
    booking_status VARCHAR(20) NOT NULL,
    CONSTRAINT fk_booking_customer FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id),
    CONSTRAINT fk_booking_property FOREIGN KEY (property_id)
        REFERENCES properties(property_id),
    CONSTRAINT chk_valid_stay CHECK (checkout_date > checkin_date)
);

CREATE TABLE reviews (
    booking_id INTEGER PRIMARY KEY,
    review_rating DECIMAL(4,2) NOT NULL CHECK (review_rating > 0),
    review_date DATE NOT NULL,
    CONSTRAINT fk_review_booking FOREIGN KEY (booking_id)
        REFERENCES bookings(booking_id)
);

CREATE INDEX idx_properties_city
ON properties(property_city);

CREATE INDEX idx_bookings_customer_checkin
ON bookings(customer_id, checkin_date);
"""
