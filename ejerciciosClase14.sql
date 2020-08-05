1)SELECT CONCAT(first_name, '', last_name), address, city
  FROM customer c2
  JOIN address using(address_id)
  JOIN city c3 using(city_id)
  JOIN country c4 using(country_id)
WHERE country like '%Argentina%'


2)
SELECT f.title, l.name,
		CASE WHEN f.rating = 'G' THEN 'All ages admitted.'
		WHEN f.rating = 'PG' THEN 'Some material may not be suitable for children.'
		WHEN f.rating = 'PG-13' THEN 'Some material may be inappropriate for children under 13.'
		WHEN f.rating = 'R' THEN 'Under 17 requires accompanying parent or adult guardian.'
		WHEN f.rating = 'NC-17' THEN 'No one 17 and under admitted.' END  AS 'Rating'
FROM film f
inner join `language` l using(language_id)


3)
SELECT a.first_name, a.last_name, f.title, f.release_year
FROM film_actor fa
INNER JOIN actor a
 ON fa.actor_id = a.actor_id
INNER JOIN film f
 ON fa.film_id = f.film_id ;


4)
SELECT f.title, CONCAT(c.first_name,'',c.last_name)AS 'customer',rental_date,
case WHEN r.return_date IS NULL THEN 'NO'
     WHEN r.return_date = r.return_date THEN 'YES' END AS 'RETURNED'
FROM film f
JOIN inventory i using(film_id)
JOIN rental r  using(inventory_id)
JOIN customer c using(customer_id)
WHERE r.rental_date BETWEEN 2005-05 AND 2005-06;

5)
SELECT CAST("2017-08-29" AS DATE);

SELECT CONVERT("2017-08-29", DATE);

6)...
