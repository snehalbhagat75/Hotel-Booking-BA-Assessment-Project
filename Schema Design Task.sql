USE hotel_bookings;


-- ============================================================
-- CREATE TABLE
-- ============================================================

CREATE TABLE `hotel_bookings (2)` (

    -- Primary Key
    booking_id INT NOT NULL AUTO_INCREMENT,

    -- Customer Information
    customer_id INT NOT NULL,
    customer_name VARCHAR(100) NOT NULL,
    customer_email VARCHAR(150),

    -- Property Information
    property_id INT NOT NULL,
    property_name VARCHAR(150) NOT NULL,
    property_city VARCHAR(100) NOT NULL,
    property_star_rating DECIMAL(2,1),

    -- Booking Information
    booking_date DATE NOT NULL,
    checkin_date DATE NOT NULL,
    checkout_date DATE NOT NULL,

    -- Stay Information
    num_rooms INT NOT NULL,
    nights INT NOT NULL,

    -- Financial Information
    adr DECIMAL(10,2),
    discount_amount DECIMAL(10,2),
    total_amount DECIMAL(12,2),

    -- Review Information
    review_date DATE,
    review_rating DECIMAL(2,1),

    -- ========================================================
    -- PRIMARY KEY
    -- ========================================================
    CONSTRAINT pk_hotel_bookings
        PRIMARY KEY (booking_id),

    -- ========================================================
    -- CHECK CONSTRAINT 1
    -- Footnote 1: checkout must be after checkin
    -- ========================================================
    CONSTRAINT chk_valid_stay
        CHECK (checkout_date > checkin_date),

    -- ========================================================
    -- CHECK CONSTRAINT 2
    -- Rooms and nights must be positive
    -- ========================================================
    CONSTRAINT chk_positive_stay
        CHECK (num_rooms > 0 AND nights > 0),

    -- Additional validation
    CONSTRAINT chk_positive_amount
        CHECK (
            adr >= 0
            AND discount_amount >= 0
            AND total_amount >= 0
        ),

    CONSTRAINT chk_valid_review
        CHECK (
            review_rating IS NULL
            OR review_rating BETWEEN 1 AND 5
        ),

    CONSTRAINT chk_valid_star_rating
        CHECK (
            property_star_rating IS NULL
            OR property_star_rating BETWEEN 1 AND 5
        )
);


-- ============================================================
-- CREATE INDEX
-- ============================================================

CREATE INDEX idx_customer_id
ON `hotel_bookings (2)` (customer_id);