CREATE TABLE car_location (
    location_id SERIAL PRIMARY KEY,
    city VARCHAR(100) NOT NULL,
    address VARCHAR(200) NOT NULL
);

CREATE TABLE car_status (
    status_id SERIAL PRIMARY KEY,
    status_name VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    phone_number VARCHAR(20) NOT NULL,
    driver_license_number VARCHAR(50) NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE car (
    car_id SERIAL PRIMARY KEY,
    license_plate VARCHAR(20) NOT NULL UNIQUE,
    brand VARCHAR(50) NOT NULL,
    model VARCHAR(50) NOT NULL,
    year INTEGER CHECK (year > 1900),
    price_per_hour DECIMAL(10, 2) NOT NULL CHECK (price_per_hour > 0),
    location_id INTEGER REFERENCES car_location(location_id) ON DELETE SET NULL,
    status_id INTEGER REFERENCES car_status(status_id) ON DELETE RESTRICT
);

CREATE TABLE rent (
    rent_id SERIAL PRIMARY KEY,
    start_time TIMESTAMP NOT NULL,
    end_time TIMESTAMP,
    total_cost DECIMAL(10, 2),
    status VARCHAR(20) DEFAULT 'active',
    user_id INTEGER NOT NULL REFERENCES users(user_id) ON DELETE CASCADE,
    car_id INTEGER NOT NULL REFERENCES car(car_id) ON DELETE CASCADE
);

CREATE TABLE payment (
    payment_id SERIAL PRIMARY KEY,
    amount DECIMAL(10, 2) NOT NULL CHECK (amount > 0),
    payment_method VARCHAR(50) NOT NULL,
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(20) DEFAULT 'success',
    rent_id INTEGER NOT NULL REFERENCES rent(rent_id) ON DELETE CASCADE
);

CREATE TABLE review (
    review_id SERIAL PRIMARY KEY,
    rating INTEGER NOT NULL CHECK (rating >= 1 AND rating <= 5),
    comment TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    user_id INTEGER REFERENCES users(user_id) ON DELETE SET NULL,
    car_id INTEGER REFERENCES car(car_id) ON DELETE CASCADE
);