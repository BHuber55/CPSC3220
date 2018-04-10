-- Question 1
SELECT last_name, first_name, email
FROM customer
ORDER BY last_name;

-- Question 2
SELECT last_name, first_name, email
FROM customer
WHERE active=0
ORDER BY last_name;

-- Question 3
SELECT c.last_name, c.first_name, a.address, a.district, a.phone
FROM customer c, address a
WHERE c.address_id=a.address_id;

-- Question 4
SELECT c.last_name, c.first_name, a.address, a.district, a.phone, ci.city, co.country, a.postal_code
FROM customer c, address a, city ci, country co
WHERE c.active=0
	AND c.address_id=a.address_id 
	AND a.city_id=ci.city_id
	AND ci.country_id=co.country_id;

-- Question 5
INSERT INTO film (film_id, title, description, release_year, language_id, original_language_id, rental_duration, rental_rate, length, replacement_cost, rating, special_features)
VALUES(1001, '1st Grade FBI Agent', 'An undercover FBI agent must pretend to be a 1st grade teacher to catch the bad guy', 2014, 2, null, 5, 4.99, 123, 20.99, 'PG-13', 'Trailers');

SELECT f.title, f.description
FROM film f, language l
WHERE f.language_id=l.language_id AND l.name!='English';

-- Question 6
SELECT f.title, f.rental_rate, l.name
FROM film f, film_category fc, category c, language l
WHERE f.film_id=fc.film_id
	AND fc.category_id=c.category_id
    AND c.name='Sci-Fi';

-- Question 7
SELECT  COUNT(DISTINCT f.title) AS count
FROM film f, category c, film_category fc
WHERE f.film_id=fc.film_id AND fc.category_id=c.category_id AND c.name='Action';

-- Question 8
SELECT  COUNT(f.title) AS count
FROM film f, category c, film_category fc
WHERE f.film_id=fc.film_id AND fc.category_id=c.category_id AND c.name='Action';

-- Question 9
SELECT title, length
FROM film WHERE replacement_cost BETWEEN 15 AND 23;

-- Question 10
SELECT  f.title
FROM film f, category c, film_category fc
WHERE f.film_id=fc.film_id AND fc.category_id=c.category_id AND c.name='Action' AND (f.rating='PG-13' OR f.rating='R' OR f.rating='NC-17');

-- Question 11
SELECT  AVG(f.length) as Average
FROM film f, category c, film_category fc
WHERE f.film_id=fc.film_id AND fc.category_id=c.category_id AND c.name='Children';

-- Question 12
SELECT a.last_name, a.first_name, f.title
FROM actor a, film f, film_category fc, category c, film_actor fa
WHERE f.film_id=fc.film_id AND fc.category_id=c.category_id AND f.film_id=fa.film_id AND fa.actor_id=a.actor_id AND (c.name='Family' OR c.name='Foreign' OR c.name='Horror')
ORDER BY a.last_name;

-- Question 13 -- broken.
SELECT a.last_name, a.first_name, f.title, c.name as Category
FROM actor a, film f, film_category fc, category c, film_actor fa
WHERE f.film_id=fc.film_id AND fc.category_id=c.category_id AND f.film_id=fa.film_id AND fa.actor_id=a.actor_id AND (c.name='Family' OR  c.name='Horror')
ORDER BY a.last_name;

-- Question 14
-- so for each time the actor appears.. we pull his id, we pull the film id of the film he is in, we pull what inventory id, then pull the customer id of the guy who rented it, then we pull that info from the customer.
SELECT DISTINCT c.last_name, c.email
FROM actor a, film_actor fa, inventory i, rental r, customer c
WHERE ((a.first_name='NICK' AND a.last_name='WAHLBERG') OR (a.first_name='MATTHEW' AND a.last_name='JOHANSSON') OR (a.first_name='RITA' AND a.last_name='REYNOLDS'))
	AND a.actor_id = fa.actor_id
    AND fa.film_id = i.film_id
    AND i.inventory_id = r.inventory_id
    AND r.customer_id = c.customer_id
ORDER BY c.last_name;