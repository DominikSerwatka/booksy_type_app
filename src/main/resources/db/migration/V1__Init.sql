CREATE TABLE "users" (
  "id" integer PRIMARY KEY,
  "first_name" varchar(255),
  "last_name" varchar(255),
  "role" varchar(50),
  "email" varchar(255) UNIQUE,
  "phone" varchar(50)
);

CREATE TABLE "businesses" (
  "id" integer PRIMARY KEY,
  "owner_id" integer,
  "name" varchar(255),
  "description" varchar(1000),
  "address" varchar(255),
  "city" varchar(100),
  "postal_code" varchar(20),
  "email" varchar(255)
);

CREATE TABLE "services" (
  "id" integer PRIMARY KEY,
  "business_id" integer,
  "name" varchar(255),
  "description" varchar(1000),
  "price" decimal,
  "duration_minutes" integer
);

CREATE TABLE "service_with_date" (
  "id" integer PRIMARY KEY,
  "service_id" integer,
  "employee_id" integer,
  "appointment_start_date_time" timestamp
);

CREATE TABLE "appointments" (
  "id" integer PRIMARY KEY,
  "user_id" integer,
  "service_with_date_id" integer,
  "status" varchar(50),
  "notes" varchar(1000)
);

CREATE TABLE "reviews" (
  "id" integer PRIMARY KEY,
  "service_id" integer,
  "user_id" integer,
  "employee_id" integer,
  "rating" integer,
  "comment" varchar(1000)
);

CREATE TABLE "categories" (
  "id" integer PRIMARY KEY,
  "name" varchar(255)
);

CREATE TABLE "services_categories" (
  "id" integer PRIMARY KEY,
  "service_id" integer,
  "category_id" integer
);

CREATE TABLE "payments" (
  "id" integer PRIMARY KEY,
  "appointment_id" integer,
  "amount" decimal,
  "status" varchar(50),
  "payment_method" varchar(50),
  "payment_date" timestamp
);

CREATE TABLE "employees" (
  "id" integer PRIMARY KEY,
  "business_id" integer,
  "user_id" integer,
  "specialization" varchar(255),
  "bio" varchar(1000)
);

CREATE TABLE "notifications" (
  "id" integer PRIMARY KEY,
  "user_id" integer,
  "content" varchar(1000),
  "is_read" boolean
);

CREATE TABLE "businesses_photos" (
  "id" integer PRIMARY KEY,
  "business_id" integer,
  "photo_data" bytea,
  "description" varchar(1000)
);

CREATE TABLE "employees_services" (
  "id" integer PRIMARY KEY,
  "employee_id" integer,
  "service_id" integer
);

-- RELACJE

ALTER TABLE "businesses"
  ADD FOREIGN KEY ("owner_id") REFERENCES "users" ("id");

ALTER TABLE "services"
  ADD FOREIGN KEY ("business_id") REFERENCES "businesses" ("id");

ALTER TABLE "service_with_date"
  ADD FOREIGN KEY ("service_id") REFERENCES "services" ("id");

ALTER TABLE "service_with_date"
  ADD FOREIGN KEY ("employee_id") REFERENCES "employees" ("id");

ALTER TABLE "appointments"
  ADD FOREIGN KEY ("user_id") REFERENCES "users" ("id");

ALTER TABLE "appointments"
  ADD FOREIGN KEY ("service_with_date_id") REFERENCES "service_with_date" ("id");

ALTER TABLE "reviews"
  ADD FOREIGN KEY ("service_id") REFERENCES "services" ("id");

ALTER TABLE "reviews"
  ADD FOREIGN KEY ("user_id") REFERENCES "users" ("id");

ALTER TABLE "reviews"
  ADD FOREIGN KEY ("employee_id") REFERENCES "employees" ("id");

ALTER TABLE "services_categories"
  ADD FOREIGN KEY ("service_id") REFERENCES "services" ("id");

ALTER TABLE "services_categories"
  ADD FOREIGN KEY ("category_id") REFERENCES "categories" ("id");

ALTER TABLE "payments"
  ADD FOREIGN KEY ("appointment_id") REFERENCES "appointments" ("id");

ALTER TABLE "employees"
  ADD FOREIGN KEY ("business_id") REFERENCES "businesses" ("id");

ALTER TABLE "employees"
  ADD FOREIGN KEY ("user_id") REFERENCES "users" ("id");

ALTER TABLE "notifications"
  ADD FOREIGN KEY ("user_id") REFERENCES "users" ("id");

ALTER TABLE "businesses_photos"
  ADD FOREIGN KEY ("business_id") REFERENCES "businesses" ("id");

ALTER TABLE "employees_services"
  ADD FOREIGN KEY ("employee_id") REFERENCES "employees" ("id");

ALTER TABLE "employees_services"
  ADD FOREIGN KEY ("service_id") REFERENCES "services" ("id");
