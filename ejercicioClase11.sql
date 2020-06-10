"4) Encuentra todos los títulos de películas que no están en el inventario"
"con not in"
SELECT 	f.title
FROM 	film f
WHERE 	f.film_id NOT IN (SELECT i3.film_id FROM inventory i3 );

"con inner"
SELECT *
FROM film f
LEFT OUTER JOIN inventory i ON f.film_id = i.film_id
where inventory_id IS NULL;

"5)Encuentra todas las películas que están en el inventario pero que nunca se alquilaron"

"not in"
SELECT f.title
  FROM film f
INNER JOIN inventory i USING (film_id)
WHERE i.inventory_id NOT IN(SELECT inventory_id FROM rental r2);

"left JOIN"
SELECT f.title
  FROM film f
INNER JOIN inventory i USING (film_id)
  LEFT JOIN rental r USING (inventory_id)
WHERE rental_id is NULL;

"6) Genere un informe con:
nombre del cliente (nombre, apellido), identificación de la tienda, título de la película,
cuando la película fue alquilada y devuelta para cada uno de estos clientes
ordenar por store_id, apellido del cliente"

SELECT c.first_name, c.last_name, c.store_id, r.rental_date, r.return_date
  FROM customer c
INNER JOIN rental r USING (customer_id)
INNER JOIN inventory i USING (inventory_id)
INNER JOIN film f USING (film_id)
ORDER BY c.last_name, c.store_id

"7) Mostrar ventas por tienda (dinero de películas alquiladas)
muestre la ciudad, el país, la información del gerente y las ventas totales (dinero) de la tienda
(opcional) Use concat para mostrar la ciudad y el país y el nombre y apellido del administrador"

SELECT COUNT(amount), store.store_id, CONCAT(city, ", ", country), CONCAT(first_name," ", last_name)
FROM 	payment
INNER JOIN rental USING(rental_id)
INNER JOIN inventory USING(inventory_id)
INNER JOIN store USING(store_id)
INNER JOIN address USING(address_id)
INNER JOIN city USING(city_id)
INNER JOIN country USING(country_id),
where staff.staff_id = store.manager_staff_id
GROUP BY store_id;

"8)¿Qué actor ha aparecido en la mayoría de las películas?"

SELECT concat(a.first_name," ", a.last_name )as actor , count(*) as peliculas from actor a
INNER JOIN film_actor USING (actor_id)
INNER JOIN film using(film_id)
GROUP BY a.actor_id
HAVING peliculas = (SELECT MAX(counted) FROM
(    SELECT COUNT(*) AS counted
      FROM actor
      INNER JOIN film_actor USING (actor_id)
	    INNER JOIN film USING(film_id)
      GROUP BY actor.actor_id
)as counts);
