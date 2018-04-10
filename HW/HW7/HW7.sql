# Question 1
SELECT last_name, first_name, address, district, postal_code
FROM customer c
LEFT JOIN address a ON c.address_id=a.address_id;

# Question 2
SELECT address, district, city
FROM city c
RIGHT JOIN address a ON a.city_id=c.city_id;

# Question 3
SELECT address, district, city, country
FROM city c
LEFT JOIN address a ON a.city_id=c.city_id
RIGHT JOIN country co ON c.country_id=co.country_id;

# Question 4
SELECT f.title, f.rental_rate, l.name
FROM film f
INNER JOIN language l ON f.language_id=l.language_id
INNER JOIN film_category fc ON f.film_id=fc.film_id
INNER JOIN category c ON fc.category_id=c.category_id
WHERE c.name='Action' or c.name='Comedy';


# Question 5
SELECT f.title, f.description, c.name as Category
FROM film f
INNER JOIN film_category fc ON f.film_id=fc.film_id
INNER JOIN category c ON fc.category_id=c.category_id;