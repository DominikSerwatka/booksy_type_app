-- 1. USERS
INSERT INTO "users" (id, first_name, last_name, role, email, phone) VALUES
(1, 'Jan', 'Kowalski', 'client', 'jan@example.com', '123456789'),
(2, 'Adam', 'Nowak', 'owner', 'adam@example.com', '987654321'),
(3, 'Kasia', 'Nowak', 'employee', 'kasia@example.com', '555111222'),
(4, 'Marek', 'Zieliński', 'client', 'marek@example.com', '123123123'),
(5, 'Ewa', 'Wiśniewska', 'owner', 'ewa@example.com', '999888777'),
(6, 'Marcin', 'Wójcik', 'employee', 'marcin@example.com', '555222111');

-- 2. BUSINESSES
INSERT INTO "businesses" (id, owner_id, name, description, address, city, postal_code, email) VALUES
(1, 2, 'Salon Beauty', 'Najlepsze usługi kosmetyczne w mieście', 'ul. Kwiatowa 10', 'Warszawa', '00-111', 'salon@example.com'),
(2, 5, 'Barber Shop Deluxe', 'Profesjonalne strzyżenie męskie', 'ul. Długa 5', 'Kraków', '30-222', 'barber@example.com');

-- 3. CATEGORIES
INSERT INTO "categories" (id, name) VALUES
(1, 'Kosmetyka'),
(2, 'Fryzjerstwo'),
(3, 'Manicure');

-- 4. EMPLOYEES
INSERT INTO "employees" (id, business_id, user_id, specialization, bio) VALUES
(1, 1, 3, 'Kosmetolog', 'Specjalistka od zabiegów kosmetycznych'),
(2, 2, 6, 'Fryzjer', 'Specjalista od męskich fryzur');

-- 5. SERVICES
INSERT INTO "services" (id, business_id, name, description, price, duration_minutes) VALUES
(1, 1, 'Zabieg na twarz', 'Profesjonalny zabieg pielęgnacyjny twarzy', 150.00, 60),
(2, 1, 'Manicure hybrydowy', 'Manicure hybrydowy z malowaniem', 80.00, 45),
(3, 2, 'Strzyżenie męskie', 'Fryzura męska z modelowaniem', 50.00, 30);

-- 6. SERVICES_CATEGORIES
INSERT INTO "services_categories" (id, service_id, category_id) VALUES
(1, 1, 1),  -- Zabieg na twarz -> Kosmetyka
(2, 2, 3),  -- Manicure hybrydowy -> Manicure
(3, 3, 2);  -- Strzyżenie męskie -> Fryzjerstwo

-- 7. EMPLOYEES_SERVICES
INSERT INTO "employees_services" (id, employee_id, service_id) VALUES
(1, 1, 1),  -- pracownik(1) -> Zabieg na twarz
(2, 1, 2),  -- pracownik(1) -> Manicure hybrydowy
(3, 2, 3);  -- pracownik(2) -> Strzyżenie męskie

-- 8. SERVICE_WITH_DATE
INSERT INTO "service_with_date" (id, service_id, employee_id, appointment_start_date_time) VALUES
(1, 1, 1, '2025-04-15 10:00:00'),
(2, 1, 1, '2025-04-16 10:00:00'),
(3, 2, 1, '2025-04-15 12:00:00'),
(4, 3, 2, '2025-04-15 14:00:00');

-- 9. APPOINTMENTS
INSERT INTO "appointments" (id, user_id, service_with_date_id, status, notes) VALUES
(1, 1, 1, 'confirmed', 'Pierwsza wizyta'),           -- Jan Kowalski -> Zabieg na twarz (2025-04-15 10:00)
(2, 4, 3, 'pending', 'Oczekuje na potwierdzenie'),    -- Marek -> Manicure (2025-04-15 12:00)
(3, 1, 4, 'cancelled', 'Odwołana z powodu braku czasu'); -- Jan -> Strzyżenie (2025-04-15 14:00)

-- 10. REVIEWS
INSERT INTO "reviews" (id, service_id, user_id, employee_id, rating, comment) VALUES
(1, 1, 1, 1, 5, 'Świetna usługa!'),
(2, 3, 4, 2, 4, 'Dobra jakość, ale mogło być taniej');

-- 11. PAYMENTS
INSERT INTO "payments" (id, appointment_id, amount, status, payment_method, payment_date) VALUES
(1, 1, 150.00, 'paid', 'card', '2025-04-15 10:00:00'),
(2, 2, 80.00, 'pending', 'cash', NULL);

-- 12. NOTIFICATIONS
INSERT INTO "notifications" (id, user_id, content, is_read) VALUES
(1, 1, 'Twoja wizyta została potwierdzona', false),
(2, 4, 'Przypomnienie o zbliżającym się terminie wizyty', false);

-- 13. BUSINESSES_PHOTOS
INSERT INTO "businesses_photos" (id, business_id, photo_data, description) VALUES
(1, 1, NULL, 'Zdjęcie salonu 1'),
(2, 2, NULL, 'Zdjęcie salonu 2');
