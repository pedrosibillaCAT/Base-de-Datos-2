'''1)
Agregar un nuevo cliente
Para almacenar 1
Para la dirección, use una dirección existente. El que tiene la mayor dirección_id en Estados Unidos'''

INSERT INTO customer (store_id, first_name, last_name, email, address_id, active , last_update)
VALUES(1, 'Pedro', 'pepe', 'pepe@gmail.com',(
SELECT 	MAX(address_id)
from address
JOIN city USING(city_id)
JOIN country USING(country_id)
WHERE country = 'United States') , 1, CURRENT_TIMESTAMP);

'''2)
Agregar un alquiler
Facilite la selección de cualquier título de película. Es decir, debería poder poner mosaico de película en el lugar, y no en la identificación.
No verifique si la película ya está alquilada, solo use cualquiera del inventario, por ejemplo, la que tenga la identificación más alta.
Seleccione cualquier staff_id de la Tienda 2.'''

INSERT INTO rental (inventory_id, customer_id, return_date, staff_id, last_update)
VALUES((SELECT inventory_id
FROM 	inventory
JOIN film USING(film_id)
WHERE title = 'ACADEMY DINOSAUR'
limit 1 ), (SELECT customer_id
FROM customer
limit 1 ) , NULL, (SELECT staff_id
FROM staff
where staff.store_id = 2
limit 1 ), CURRENT_TIMESTAMP);

'''3)
Actualizar el año de la película según la calificación.
Por ejemplo, si la calificación es 'G', la fecha de lanzamiento será '2001'
Puede elegir la asignación entre calificación y año.
Escriba cuantas declaraciones sean necesarias.'''

SET release_year = (case when rating = 'PG' then 2011
                         when rating = 'G' then 2012
                         when rating = 'NC-17' then 2013
                         when rating = 'PG-13' then 2020
                         when rating = 'R' then 2010
                    end) WHERE rating IN ('PG','G','NC-17','PG-13','R');
select * from film f
inner join inventory i using(film_id)
inner join rental r using(inventory_id)
where r.return_date is null
order by r.rental_date desc
limit 1;
UPDATE rental
	SET return_date = CURRENT_TIMESTAMP
	WHERE rental_id = (SELECT * FROM (SELECT max(rental_id) FROM rental WHERE return_date IS NULL) rental);

'''4)
Devolver una película
Escriba las declaraciones y consultas necesarias para los siguientes pasos.
Encuentra una película que aún no haya sido devuelta. Y usa esa identificación de alquiler. Elija el último que se alquiló, por ejemplo.
Usa la identificación para devolver la película.'''


'''5)
Intenta eliminar una película.
Verifique qué sucede, describa qué hacer.
Escriba todas las declaraciones de eliminación necesarias para eliminar por completo la película de la base de datos.'''
--
DELETE FROM film_actor
WHERE film_id=(select film_id from film where title='ACADEMY DINOSAUR');

DELETE FROM film_category
WHERE film_id=(select film_id from film where title='ACADEMY DINOSAUR');

DELETE FROM rental
WHERE inventory_id in (select inventory_id from inventory where inventory_id
					in (select inventory_id from inventory where film_id=(select film_id from film where title='ACADEMY DINOSAUR')));
DELETE FROM inventory
WHERE film_id = (select film_id from film where title='ACADEMY DINOSAUR');

DELETE FROM film
WHERE title='ACADEMY DINOSAUR';

'''6)
Alquilar una película
Encuentre una identificación de inventario que esté disponible para alquilar (disponible en la tienda), elija cualquier película. Guarda esta identificación en alguna parte.
Agregar una entrada de alquiler
Agregar una entrada de pago
Use subconsultas para todo, excepto para la identificación de inventario que se puede usar directamente en las consultas.
'''
set @var = (SELECT max(i.inventory_id)
            FROM inventory i
            INNER JOIN rental USING (inventory_id)
            WHERE inventory_id NOT IN (SELECT inventory_id FROM rental WHERE return_date IS NULL))


INSERT INTO rental
(inventory_id, customer_id, staff_id, rental_date)
SELECT @var as inventory_id, MAX(customer_id), MIN(staff_id),
(SELECT rental_date FROM rental WHERE rental_id = (SELECT MAX(rental_id) FROM rental)) as rental_date
FROM rental;

INSERT INTO payment
(customer_
INSERT INTO payment
(customer_id, staff_id, rental_id, amount, payment_date)
SELECT (SELECT MIN(customer_id) FROM customer WHERE first_name LIKE 'FRANK%') as customer_id,
(SELECT MAX(staff_id) FROM staff) as staff_id,
rental_id,
(SELECT AVG(amount) FROM payment) as amount,
(SELECT rental_date FROM rental WHERE rental_id = @var) as payment_date
FROM rental
WHERE rental_id = @var;
