-- CREATE DATABASE FOR AN EVENTS CATERING MANAGEMENT SYSTEM (ECMS)
create database ECMS;

-- USE THE DATABASE
use ECMS;

-- CLIENTS TABLE
CREATE TABLE Clients (
    client_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(15) NOT NULL,
    address TEXT
);

-- EVENTS TABLE
CREATE TABLE Events (
    event_id INT AUTO_INCREMENT PRIMARY KEY,
    client_id INT NOT NULL,
    event_date DATE NOT NULL,
    event_time TIME NOT NULL,
    location VARCHAR(100) NOT NULL,
    number_of_guests INT,
    status ENUM('Scheduled', 'Completed', 'Cancelled') DEFAULT 'Scheduled',
    FOREIGN KEY (client_id) REFERENCES Clients(client_id)
);

-- MENUS TABLE
CREATE TABLE Menus (
    menu_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    price_per_guest DECIMAL(10,2) NOT NULL
);

-- MENU ITEMS TABLE
CREATE TABLE Menu_Items (
    item_id INT AUTO_INCREMENT PRIMARY KEY,
    menu_id INT NOT NULL,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    is_vegetarian BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (menu_id) REFERENCES Menus(menu_id)
);

-- CHEFS TABLE
CREATE TABLE Chefs (
    chef_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    specialty VARCHAR(100),
    phone VARCHAR(15) UNIQUE,
    hire_date DATE NOT NULL
);

-- EVENT_CHEFS TABLE 
CREATE TABLE Event_Chefs (
    event_id INT NOT NULL,
    chef_id INT NOT NULL,
    PRIMARY KEY (event_id, chef_id),
    FOREIGN KEY (event_id) REFERENCES Events(event_id),
    FOREIGN KEY (chef_id) REFERENCES Chefs(chef_id)
);

-- INVOICES TABLE
CREATE TABLE Invoices (
    invoice_id INT AUTO_INCREMENT PRIMARY KEY,
    event_id INT NOT NULL,
    issue_date DATE NOT NULL,
    total_amount DECIMAL(10,2) NOT NULL,
    due_date DATE NOT NULL,
    FOREIGN KEY (event_id) REFERENCES Events(event_id)
);

-- PAYMENTS TABLE
CREATE TABLE Payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    invoice_id INT NOT NULL,
    payment_date DATE NOT NULL,
    amount_paid DECIMAL(10,2) NOT NULL,
    method ENUM('Cash', 'Card', 'Online', 'Bank Transfer') NOT NULL,
    FOREIGN KEY (invoice_id) REFERENCES Invoices(invoice_id)
);

