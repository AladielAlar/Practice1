--1)
CREATE USER rentaluser WITH PASSWORD 'rentalpassword';

--2)
GRANT SELECT ON TABLE customer TO rentaluser;

SELECT * FROM customer;

--3)
CREATE ROLE rental;

GRANT rental TO rentaluser;

--4)
GRANT INSERT, UPDATE ON TABLE rental TO rental;

INSERT INTO rental (rental_id, rental_date, inventory_id, customer_id, return_date, staff_id, last_update)
VALUES (-1, '2005-05-21 22:53:30+03', 888, 130, '2005-05-24 22:04:30+03', 1, '2017-02-15 20:30:53+02');

UPDATE rental SET rental_id = (0) WHERE rental_id = -1;

--5)
REVOKE INSERT ON TABLE rental FROM rental;

INSERT INTO rental (rental_id, rental_date, inventory_id, customer_id, return_date, staff_id, last_update)
VALUES (-2, '2006-05-21 22:53:30+03', 999, 130, '2005-05-24 22:04:30+03', 1, '2017-02-15 20:30:53+02');

--6)
CREATE ROLE client_Alex_Grey;

GRANT SELECT ON TABLE rental TO client_Alex_Grey;
GRANT SELECT ON TABLE payment TO client_Alex_Grey;

ALTER ROLE client_Alex_Grey SET search_path TO rental;

SET ROLE client_Alex_Grey;
SELECT * FROM rental WHERE customer_id = 278;
SELECT * FROM payment WHERE customer_id = 278;
