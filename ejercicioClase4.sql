USE sakila;

SELECT title, special_features
	FROM film f
	WHERE rating="PG-13";

  SELECT DISTINCT `length`
  	FROM film f;

SELECT title, rental_rate, replacement_cost
  FROM film WHERE replacement_cost BETWEEN 20.00 AND 24.00

#SELECT category FROM film f;

SELECT first_name, last_name FROM actor a, film_actor fa , film f
  WHERE a.actor_id = fa.actor_id
	AND fa.film_id = f.film_id
	AND f.title = "ZOOLANDER FICTION";

SELECT a.address, c2.country, c.city FROM store s, address a, city c, country c2
	WHERE s.address_id = a.address_id
	AND a.address_id = 1
	AND c.city_id = a.city_id
	AND c2.country_id = c.country_id;

#select

SELECT f.title, s.first_name FROM inventory i ,film f ,staff s, store s2
  WHERE s2.manager_staff_id = s.staff_id
  AND s2.store_id = 2
  AND i.store_id = i.film_id
  AND i.film_id = f.film_id 
