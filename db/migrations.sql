CREATE DATABASE ga_wdi_dragons_db;
\c ga_wdi_dragons_db

CREATE TABLE students (id SERIAL PRIMARY KEY, name VARCHAR(255), email VARCHAR(255));

CREATE TABLE users (id SERIAL PRIMARY KEY, user_name VARCHAR(255), user_email VARCHAR(255), password_digest VARCHAR(255), is_admin BOOLEAN);
\dt
