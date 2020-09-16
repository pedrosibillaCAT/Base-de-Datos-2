--1
SELECT * FROM address a2 
inner join city c using (city_id)
inner join country c2 using (country_id )
WHERE a2.postal_code in ('18743', '93896', '77948', '45844', '53628')
ORDER BY c.city_id, c2.country_id, a2.address_id 
--Esta query lo que hace es seleccionar los datos de la tabla address, city, country y luego los filtra por portal_code y devuelve los datos que tengan esos portal_code
SELECT * FROM address a2 
inner join city c using (city_id)
inner join country c2 using (country_id )
WHERE a2.postal_code NOT in ('18743', '93896', '77948', '45844', '53628')
ORDER BY c.city_id, c2.country_id, a2.address_id 
--Esta query selecciona todos los datos de la trabla address, city, country y los filtra atravez del portal_code y excluye los datos que tengan esos portal_code
CREATE INDEX postalCode 
ON address(postal_code);
--crea un index portalCode en la tabla de address


--2
SELECT a.first_name 
FROM actor a 
inner join film_actor fa using(actor_id)
inner join film f using(film_id)
-----------------------------------
SELECT a.last_name
FROM actor a 
inner join film_actor fa using(actor_id)
inner join film f using(film_id)
--una busca todos los datos que tenga el primer nombre y la segunda todo lo que tenga apellido solo muetra un dato.


--3
SELECT title, description from film where description LIKE "%drama%";

SELECT title, description from film_text where MATCH(title, description) AGAINST('drama');

--La diferencia entre ellos puede deberse al segundo que usa un índice de texto completo
