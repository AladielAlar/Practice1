--1
CREATE VIEW sales_revenue_by_category_qtr AS
SELECT
    c.category_id,
    c.name AS category_name,
    COALESCE(SUM(p.amount), 0) AS total_sales_revenue
FROM
    category c
JOIN
    film_category fc ON c.category_id = fc.category_id
JOIN
    film f ON fc.film_id = f.film_id
JOIN
    inventory i ON f.film_id = i.film_id
JOIN
    rental r ON i.inventory_id = r.inventory_id
JOIN
    payment p ON r.rental_id = p.rental_id
WHERE
    DATE_PART('quarter', p.payment_date) = DATE_PART('quarter', CURRENT_DATE)
GROUP BY
    c.category_id, c.name
HAVING
    COALESCE(SUM(p.amount), 0) > 0;

--2
CREATE OR REPLACE FUNCTION get_sales_revenue_by_category_qtr(current_qtr INT)
RETURNS TABLE (
    category_id INT,
    category_name TEXT,
    total_sales_revenue DECIMAL(10,2)
)
AS $$
BEGIN
    RETURN QUERY
    SELECT
        c.category_id,
        c.name AS category_name,
        COALESCE(SUM(p.amount), 0)::DECIMAL(10,2) AS total_sales_revenue
    FROM
        category c
    JOIN
        film_category fc ON c.category_id = fc.category_id
    JOIN
        film f ON fc.film_id = f.film_id
    JOIN
        inventory i ON f.film_id = i.film_id
    JOIN
        rental r ON i.inventory_id = r.inventory_id
    JOIN
        payment p ON r.rental_id = p.rental_id
    WHERE
        DATE_PART('quarter', p.payment_date) = current_qtr
    GROUP BY
        c.category_id, c.name
    HAVING
        COALESCE(SUM(p.amount), 0) > 0;
END;
$$ LANGUAGE plpgsql;

--i check by SELECT * FROM get_sales_revenue_by_category_qtr(1);

--3
CREATE OR REPLACE PROCEDURE new_movie(IN movie_title VARCHAR(255))
LANGUAGE plpgsql
AS $$
DECLARE
    new_film_id INT;
BEGIN
    SELECT COALESCE(MAX(film_id), 0) + 1 INTO new_film_id FROM film;

    IF NOT EXISTS (SELECT 1 FROM language WHERE name = 'Klingon') THEN
        RAISE EXCEPTION 'Language "Klingon" does not exist.';
    END IF;

    INSERT INTO film (film_id, title, rental_rate, rental_duration, replacement_cost, release_year, language_id)
    VALUES (new_film_id, movie_title, 4.99, 3, 19.99, EXTRACT(YEAR FROM CURRENT_DATE), (SELECT language_id FROM language WHERE name = 'Klingon'));

END;
$$;