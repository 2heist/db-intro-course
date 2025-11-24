-- Сценарій: Реєструємо нового користувача
INSERT INTO users (name, email, phone_number, driver_license_number)
VALUES ('Taras Shevchenko', 'taras.kobzar@lit.ua', '+380991234567', 'UA000001');

-- Сценарій: Купили нову машину (Hyundai Tucson) і поставили її в Києві (location_id=1)
-- Вона відразу доступна (status_id=1)
INSERT INTO car (license_plate, brand, model, year, price_per_hour, location_id, status_id)
VALUES ('KA7777KA', 'Hyundai', 'Tucson', 2024, 200.00, 1, 1);

-- Перевіримо, чи додалися записи
SELECT * FROM users ORDER BY user_id DESC LIMIT 1;
SELECT * FROM car ORDER BY car_id DESC LIMIT 1;

-- Сценарій: Клієнт шукає всі вільні машини (status_id=1) дешевше 200 грн
SELECT brand, model, price_per_hour 
FROM car 
WHERE status_id = 1 AND price_per_hour < 200;

-- Сценарій: Знайти всі поїздки конкретного користувача (наприклад, user_id=1)
SELECT * FROM rent WHERE user_id = 1;

-- Сценарій: Показати тільки Email та Ім'я користувачів з правами серії 'ABC'
SELECT name, email, driver_license_number
FROM users
WHERE driver_license_number LIKE 'ABC%';

-- Сценарій: Користувач змінив номер телефону
-- 1. Перевірка:
SELECT * FROM users WHERE email = 'taras.kobzar@lit.ua';
-- 2. Оновлення:
UPDATE users 
SET phone_number = '+380999999999' 
WHERE email = 'taras.kobzar@lit.ua';

-- Сценарій: Машина поїхала в ремонт. Змінюємо статус на "Maintenance" (id=3)
-- для машини з номером KA0001AA
UPDATE car
SET status_id = 3 
WHERE license_plate = 'KA0001AA';

-- Сценарій: Підняття цін на 10% для всіх машин бренду Tesla
UPDATE car
SET price_per_hour = price_per_hour * 1.10
WHERE brand = 'Tesla';

-- Сценарій: Видаляємо помилковий відгук (наприклад, з рейтингом 1, який лишили помилково)
-- 1. Спочатку знайдемо його ID
SELECT * FROM review WHERE rating = 1;

-- 2. Видаляємо. Хочемо видалити відгуки користувача з user_id=4
DELETE FROM review 
WHERE user_id = 4;

-- Сценарій: Видаляємо машину, яку продали (наприклад, стару Honda Civic)
DELETE FROM car 
WHERE model = 'Civic' AND year < 2020;