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

INSERT INTO car_location (city, address) VALUES
('Kyiv', 'Maidan Nezalezhnosti'),
('Kyiv', 'KPI Campus, Politekhnichna 16'),
('Kyiv', 'Central Railway Station'),
('Lviv', 'Rynok Square');

INSERT INTO car_status (status_name) VALUES
('Available'), 
('Rented'), 
('Maintenance'), 
('Reserved');

INSERT INTO users (name, email, phone_number, driver_license_number) VALUES
('Ivan Petrenko', 'ivan.p@example.com', '+380501112233', 'ABC123456'),
('Oksana Boiko', 'oksana.b@example.com', '+380679998877', 'XYZ987654'),
('Mykola Kholod', 'mykola.k@kpi.ua', '+380635554433', 'KPI000111'),
('Dmytro Bondar', 'dbondar@test.com', '+380991234567', 'QWE555666');

INSERT INTO car (license_plate, brand, model, year, price_per_hour, location_id, status_id) VALUES
('KA0001AA', 'Toyota', 'Camry', 2022, 150.00, 1, 1), 
('KA0002BB', 'Ford', 'Focus', 2020, 100.00, 3, 2),   
('BC1234EE', 'Tesla', 'Model 3', 2023, 250.00, 4, 1), 
('AI5555HX', 'Honda', 'Civic', 2019, 90.00, 2, 3),    
('AA9999II', 'BMW', 'X5', 2021, 500.00, 1, 1);       

INSERT INTO rent (start_time, end_time, total_cost, status, user_id, car_id) VALUES
('2025-11-01 10:00:00', '2025-11-01 12:00:00', 300.00, 'completed', 1, 1),
('2025-11-02 14:00:00', NULL, NULL, 'active', 3, 2),
('2025-11-03 09:00:00', '2025-11-03 09:30:00', 125.00, 'completed', 2, 3),
('2025-11-04 18:00:00', '2025-11-04 18:45:00', 75.00, 'completed', 4, 4);

INSERT INTO payment (amount, payment_method, status, rent_id) VALUES
(300.00, 'Credit Card', 'success', 1),
(125.00, 'Apple Pay', 'success', 3),
(75.00, 'Cash', 'success', 4);

INSERT INTO review (rating, comment, user_id, car_id) VALUES
(5, 'Чудова машина, чиста і швидка!', 1, 1),
(4, 'Все ок, але дорого.', 2, 3),
(1, 'Брудно в салоні', 4, 4);
