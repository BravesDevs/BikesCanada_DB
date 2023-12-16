-- Trigger to generate billing

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

-- Query total booking of each bike type on a date

-- Procedure based
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

CALL total_bookings('2023-12-13');
DROP PROCEDURE IF EXISTS total_bookings;

-- Query based

SELECT bt.bike_type_value,
        COUNT(*) AS total_bookings
FROM booking b
            INNER JOIN bikes bk ON b.bike_model = bk.bike_model
            INNER JOIN bike_type bt ON bk.bike_type = bt.bike_type_id
WHERE CAST(b.booking_date AS DATE) = CAST('2023-12-13' AS DATE)
GROUP BY bt.bike_type_value;