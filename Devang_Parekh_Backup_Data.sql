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