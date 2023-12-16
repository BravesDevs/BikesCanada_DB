-- DDL SQL for creating tables ---------------------------------------------------------------
CREATE DATABASE IF NOT EXISTS BikesCanada;

USE BikesCanada;

CREATE TABLE customer_type
(
    customer_type_id    VARCHAR(50) NOT NULL PRIMARY KEY,
    customer_type_value VARCHAR(50) NOT NULL,
    discount            INT         NOT NULL
);

CREATE TABLE customer
(
    customer_id   INT         NOT NULL AUTO_INCREMENT,
    first_name    VARCHAR(50) NOT NULL,
    last_name     VARCHAR(50) NOT NULL,
    date_of_birth DATE        NOT NULL,
    address       VARCHAR(50) NOT NULL,
    email         VARCHAR(50) NOT NULL,
    phone         VARCHAR(50) NOT NULL,
    customer_type VARCHAR(50) NOT NULL,
    is_student    BOOLEAN     NOT NULL DEFAULT FALSE,
    PRIMARY KEY (customer_id),
    FOREIGN KEY (customer_type) REFERENCES customer_type (customer_type_id),
    UNIQUE (email),
    UNIQUE (first_name, last_name, date_of_birth, address, email, phone),
    CHECK (email LIKE '%@%.%')
);



CREATE TABLE location
(
    location_id INT AUTO_INCREMENT NOT NULL,
    street      VARCHAR(200)       NOT NULL,
    zip         VARCHAR(50)        NOT NULL,
    city        VARCHAR(50)        NOT NULL,
    province    VARCHAR(50)        NOT NULL,
    PRIMARY KEY (location_id),
    UNIQUE (street, zip, city, province)
);

CREATE TABLE bike_type
(
    bike_type_id    VARCHAR(50) NOT NULL,
    bike_type_value VARCHAR(50) NOT NULL,
    pph             INT         NOT NULL,
    PRIMARY KEY (bike_type_id)
);


CREATE TABLE bikes
(
    bike_model    VARCHAR(50) NOT NULL,
    bike_type     VARCHAR(50) NOT NULL,
    weight        INT         NOT NULL,
    is_child_safe BOOLEAN     NOT NULL,
    is_available  BOOLEAN     NOT NULL,
    bike_location INT         NOT NULL,
    is_maintained BOOLEAN     NOT NULL DEFAULT FALSE,
    PRIMARY KEY (bike_model),
    FOREIGN KEY (bike_type) REFERENCES bike_type (bike_type_id),
    FOREIGN KEY (bike_location) REFERENCES location (location_id)
);


CREATE TABLE booking
(
    id           INT         NOT NULL AUTO_INCREMENT,
    bike_model   VARCHAR(50) NOT NULL,
    customer     INT         NOT NULL,
    pick_up      INT         NOT NULL,
    drop_off     INT,
    pick_time    DATETIME    NOT NULL,
    drop_time    DATETIME,
    booking_date DATETIME    NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (bike_model) REFERENCES bikes (bike_model),
    FOREIGN KEY (customer) REFERENCES customer (customer_id),
    FOREIGN KEY (pick_up) REFERENCES location (location_id),
    FOREIGN KEY (drop_off) REFERENCES location (location_id),
    UNIQUE (bike_model, pick_up, drop_off, pick_time, drop_time)
);


CREATE TABLE billing
(
    id           INT      NOT NULL AUTO_INCREMENT,
    booking_id   INT      NOT NULL,
    bike_usage   INT      NOT NULL,
    total_cost   INT      NOT NULL,
    discount     INT      NOT NULL,
    actual_cost  INT      NOT NULL,
    billing_date DATETIME NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (booking_id) REFERENCES booking (id)
);