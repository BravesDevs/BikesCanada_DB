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

-- INSERTS DATA INTO FILES ---------------------------------------------------------------
INSERT INTO BikesCanada.customer_type (customer_type_id, customer_type_value, discount)
VALUES ('adult', 'Adult', 5);
INSERT INTO BikesCanada.customer_type (customer_type_id, customer_type_value, discount)
VALUES ('child', 'Child', 10);
INSERT INTO BikesCanada.customer_type (customer_type_id, customer_type_value, discount)
VALUES ('senior', 'Senior', 13);


INSERT INTO BikesCanada.customer (customer_id, first_name, last_name, date_of_birth, address, email, phone,
                                  customer_type, is_student)
VALUES (1, 'Devang', 'MP', '1999-10-24', '20, Weber St, University Avenue', 'devangmp@gov.ca', '2233448987', 'adult',
        1);
INSERT INTO BikesCanada.customer (customer_id, first_name, last_name, date_of_birth, address, email, phone,
                                  customer_type, is_student)
VALUES (2, 'Rebecca', 'B', '1999-10-26', '31, King St, Waterloo', 'rebecca.br@google.com', '1232345675', 'adult', 0);
INSERT INTO BikesCanada.customer (customer_id, first_name, last_name, date_of_birth, address, email, phone,
                                  customer_type, is_student)
VALUES (3, 'Tyler', 'White', '2013-08-05', '121, Linden Drive, Cambridge', 'tyler@apple.com', '8787987876', 'child', 1);
INSERT INTO BikesCanada.customer (customer_id, first_name, last_name, date_of_birth, address, email, phone,
                                  customer_type, is_student)
VALUES (4, 'Hiren', 'C', '1997-06-09', '21, Queen Street, Kitchener', 'hiren@gmail.com', '1234323458', 'adult', 0);
INSERT INTO BikesCanada.customer (customer_id, first_name, last_name, date_of_birth, address, email, phone,
                                  customer_type, is_student)
VALUES (5, 'Sunny', 'T', '1995-02-19', '36, Fairway Park, Kitchener', 'sunny@yahoo.com', '1298787657', 'adult', 1);
INSERT INTO BikesCanada.customer (customer_id, first_name, last_name, date_of_birth, address, email, phone,
                                  customer_type, is_student)
VALUES (6, 'Elaine', 'Ma', '1998-08-11', '21, Sunrise Condos', 'elaine@uwaterloo.ca', '9897837481', 'adult', 0);


INSERT INTO BikesCanada.bike_type (bike_type_id, bike_type_value, pph)
VALUES ('EV', 'Electronic Vehicle', 12);
INSERT INTO BikesCanada.bike_type (bike_type_id, bike_type_value, pph)
VALUES ('HYBRID', 'Hybrid Bike', 14);
INSERT INTO BikesCanada.bike_type (bike_type_id, bike_type_value, pph)
VALUES ('MOUNTAIN', 'Mountain Bike', 7);
INSERT INTO BikesCanada.bike_type (bike_type_id, bike_type_value, pph)
VALUES ('ROAD', 'Road', 5);


INSERT INTO BikesCanada.bikes (bike_model, bike_type, weight, is_child_safe, is_available, bike_location, is_maintained)
VALUES ('BMX101', 'MOUNTAIN', 18, 1, 0, 4, 1);
INSERT INTO BikesCanada.bikes (bike_model, bike_type, weight, is_child_safe, is_available, bike_location, is_maintained)
VALUES ('EV101', 'EV', 23, 0, 1, 1, 1);
INSERT INTO BikesCanada.bikes (bike_model, bike_type, weight, is_child_safe, is_available, bike_location, is_maintained)
VALUES ('HY101', 'HYBRID', 24, 0, 1, 4, 1);
INSERT INTO BikesCanada.bikes (bike_model, bike_type, weight, is_child_safe, is_available, bike_location, is_maintained)
VALUES ('RD101', 'ROAD', 16, 1, 1, 2, 1);


INSERT INTO BikesCanada.location (location_id, street, zip, city, province)
VALUES (3, '200 University Ave W', 'N2L 3G1', 'Waterloo', 'Ontario');
INSERT INTO BikesCanada.location (location_id, street, zip, city, province)
VALUES (4, '299 Doon Valley Dr', 'N2G 4M4', 'Kitchener', 'Ontario');
INSERT INTO BikesCanada.location (location_id, street, zip, city, province)
VALUES (1, '51 Breithaupt St', 'N2H 5G5', 'Kitchener', 'Ontario');
INSERT INTO BikesCanada.location (location_id, street, zip, city, province)
VALUES (2, '55 King St W', 'N2G 1A1', 'Kitchener', 'Ontario');


INSERT INTO BikesCanada.booking (id, bike_model, customer, pick_up, drop_off, pick_time, drop_time, booking_date)
VALUES (1, 'BMX101', 1, 4, 4, '2023-12-13 16:42:54', '2023-12-13 20:00:11', '2023-12-13 16:42:54');
INSERT INTO BikesCanada.booking (id, bike_model, customer, pick_up, drop_off, pick_time, drop_time, booking_date)
VALUES (2, 'RD101', 3, 2, 4, '2023-12-13 16:45:18', '2023-12-13 21:10:05', '2023-12-13 16:45:18');
INSERT INTO BikesCanada.booking (id, bike_model, customer, pick_up, drop_off, pick_time, drop_time, booking_date)
VALUES (3, 'RD101', 3, 2, 1, '2023-12-13 17:26:18', '2023-12-13 22:26:30', '2023-12-13 17:26:18');


INSERT INTO BikesCanada.billing (id, booking_id, bike_usage, total_cost, discount, actual_cost, billing_date)
VALUES (1, 1, 3, 21, 1, 20, '2023-12-13 17:10:17');
INSERT INTO BikesCanada.billing (id, booking_id, bike_usage, total_cost, discount, actual_cost, billing_date)
VALUES (2, 2, 4, 20, 2, 18, '2023-12-13 17:10:17');
INSERT INTO BikesCanada.billing (id, booking_id, bike_usage, total_cost, discount, actual_cost, billing_date)
VALUES (3, 3, 5, 25, 3, 22, '2023-12-13 17:26:36');
-- --------------------------------------------------------------------------------------------------------

-- Procedure for placing booking ---------------------------------------------------------------
CREATE PROCEDURE place_booking(
    IN p_bike_model VARCHAR(50),
    IN p_customer_id INT,
    IN p_pick_up INT)
BEGIN
    DECLARE _is_available BOOLEAN;
    DECLARE _is_child_safe BOOLEAN;
    DECLARE _is_maintained BOOLEAN;
    DECLARE _bike_location INT;
    DECLARE _customer_type VARCHAR(50);

    SELECT COUNT(*)
    INTO _is_available
    FROM bikes
    WHERE bike_model = p_bike_model;

    IF _is_available = 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Bike does not exist';
    END IF;

    SELECT is_available, is_child_safe, bike_location, is_maintained
    INTO _is_available, _is_child_safe, _bike_location, _is_maintained
    FROM bikes
    WHERE bike_model = p_bike_model;

    IF _is_available = FALSE THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Bike is not available';
    END IF;

    IF _is_maintained = FALSE THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Bike is not maintained';
    END IF;

    IF _bike_location != p_pick_up THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Bike is not available at this location';
    END IF;

    SELECT customer_type
    INTO _customer_type
    FROM customer
    WHERE customer_id = p_customer_id;

    IF _is_child_safe = 0 AND _customer_type = 'child' THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Bike is not child safe';
    END IF;

    INSERT INTO booking (bike_model, customer, pick_up, pick_time, booking_date)
    VALUES (p_bike_model, p_customer_id, p_pick_up, NOW(), NOW());

    UPDATE bikes
    SET is_available = 0
    WHERE bike_model = p_bike_model;

    SELECT FOUND_ROWS() AS booking_id;
END;
USE BikesCanada;
DROP PROCEDURE IF EXISTS place_booking;
CALL place_booking('EV101', 1, 1);
-- --------------------------------------------------------------------------------------------------------

-- Procedure for dropping off bike ---------------------------------------------------------------
CREATE PROCEDURE return_bike(
    IN p_booking_id INT,
    IN p_drop_off INT)

BEGIN

    DECLARE _booking_count INT;

    SELECT COUNT(*)
    INTO _booking_count
    FROM booking
    WHERE id = p_booking_id;

    IF _booking_count = 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Booking does not exist';
    END IF;

    UPDATE booking
    SET drop_off  = p_drop_off,
        drop_time = NOW()
    WHERE id = p_booking_id;

    UPDATE bikes
    SET is_available  = 1,
        bike_location = p_drop_off
    WHERE bike_model = (SELECT bike_model FROM booking WHERE id = p_booking_id);

END;
CALL return_bike(8, 4);
-- --------------------------------------------------------------------------------------------------------

-- Trigger for generating billing ---------------------------------------------------------------
DELIMITER //
CREATE TRIGGER update_billing
    AFTER UPDATE
    ON booking
    FOR EACH ROW
BEGIN
    DECLARE _bike_usage INT DEFAULT 0;
    DECLARE _total_cost INT;
    DECLARE _discount INT;
    DECLARE _actual_cost INT;

    IF OLD.pick_time IS NOT NULL AND new.drop_time IS NOT NULL AND new.drop_time > OLD.pick_time THEN
        SET _bike_usage = TIMESTAMPDIFF(HOUR, OLD.pick_time, new.drop_time);
    END IF;

    SET _total_cost = _bike_usage * (SELECT pph
                                     FROM bike_type
                                     WHERE bike_type_id = (SELECT bike_type
                                                           FROM bikes
                                                           WHERE bike_model = OLD.bike_model));

    SET _discount = _total_cost * (SELECT discount / 100
                                   FROM customer_type
                                   WHERE customer_type_id = (SELECT customer_type
                                                             FROM customer
                                                             WHERE customer_id = OLD.customer));

    SET _actual_cost = _total_cost - _discount;

    INSERT INTO billing (booking_id, bike_usage, total_cost, discount, actual_cost, billing_date)
    VALUES (OLD.id, _bike_usage, _total_cost, _discount, _actual_cost, NOW());
END //
DELIMITER ;
-- --------------------------------------------------------------------------------------------------------

-- How many customers who booked bikes from given location are students? ------------------------------------
CREATE PROCEDURE student_customers(IN p_pick_up INT)
BEGIN
    SELECT c.first_name, c.last_name, c.email, c.phone
    FROM customer c
             INNER JOIN booking b ON c.customer_id = b.customer
    WHERE b.pick_up = p_pick_up
      AND c.is_student = 1;
END;

CALL student_customers(2);
DROP PROCEDURE IF EXISTS student_customers;
-- --------------------------------------------------------------------------------------------------------

-- Based on given bike model return the usage of the bike? ------------------------------------
CREATE PROCEDURE bike_usage(IN p_bike_model VARCHAR(50))
BEGIN

    SELECT b.bike_model,
           l.street,
           l.city,
           COUNT(*) AS pick_count
    FROM booking b
             INNER JOIN location l ON b.pick_up = l.location_id
    WHERE b.bike_model = p_bike_model
    GROUP BY b.bike_model, l.street, l.city;
END;

CALL bike_usage('RD101');
DROP PROCEDURE IF EXISTS bike_usage;
-- --------------------------------------------------------------------------------------------------------


-- Based on given date return the customer with highest actual cost of all locations? ------------------------------------
CREATE PROCEDURE highest_billing_customer(IN date_at DATETIME)
BEGIN
    SELECT l.city,
           l.street,
           c.customer_id,
           c.first_name,
           c.last_name,
           c.email,
           c.phone,
           SUM(bill.actual_cost) AS total_cost
    FROM customer c
             INNER JOIN booking b ON c.customer_id = b.customer
             INNER JOIN billing bill ON b.id = bill.booking_id
             INNER JOIN location l ON b.pick_up = l.location_id
    WHERE CAST(bill.billing_date AS DATE) = CAST(date_at AS DATE)
    GROUP BY l.city, l.street,
             c.customer_id, c.first_name, c.last_name, c.email, c.phone
    ORDER BY total_cost
            DESC;
END;

CALL highest_billing_customer('2023-12-13 17:00:23');
DROP PROCEDURE IF EXISTS highest_billing_customer;
-- --------------------------------------------------------------------------------------------------------

-- On insert date get total bookings of bike of particular type. ------------------------------------
CREATE PROCEDURE total_bookings(IN date DATE)
BEGIN
    SELECT bt.bike_type_value,
           COUNT(*) AS total_bookings
    FROM booking b
             INNER JOIN bikes bk ON b.bike_model = bk.bike_model
             INNER JOIN bike_type bt ON bk.bike_type = bt.bike_type_id
    WHERE CAST(b.booking_date AS DATE) = CAST(date AS DATE)
    GROUP BY bt.bike_type_value;
END;

CALL total_bookings('2023-12-15');
DROP PROCEDURE IF EXISTS total_bookings;
-- --------------------------------------------------------------------------------------------------------

-- On given location and date return the end location of the bike trips Order reverse. ------------------------------------
CREATE PROCEDURE bike_trip(IN p_pick_up INT, IN p_date DATE)
BEGIN
    SELECT l.city,
           l.street,
           COUNT(*) AS total_trips
    FROM booking b
             INNER JOIN location l ON b.drop_off = l.location_id
    WHERE b.pick_up = p_pick_up
      AND CAST(b.booking_date AS DATE) = CAST(p_date AS DATE)
    GROUP BY l.city, l.street
    ORDER BY total_trips DESC;
END;

CALL bike_trip(2, '2023-12-13');
DROP PROCEDURE IF EXISTS bike_trip;
-- --------------------------------------------------------------------------------------------------------