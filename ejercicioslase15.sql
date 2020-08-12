---1 Create a view named list_of_customers, it should contain the following columns:customer id, customer full name, address, zip code, phone, city, country, status (when active column is 1 show it as 'active', otherwise is 'inactive'), store id
CREATE OR REPLACE VIEW list_of_customer as
	SELECT c.customer_id, concat_ws(" ",c.first_name ,c.last_name ) as name, a2.address, a2.postal_code , a2.phone, c2.city, c3.country, s.store_id,
	CASE when c.active = "1" then "activa"
	else "inactive" End as status
	FROM country c3
	inner join city c2 using(country_id)
	inner join address a2 using(city_id)
	inner join store s using(address_id)
	right join customer c using(store_id)

---2 Create a view named film_details, it should contain the following columns: film id, title, description, category, price, length, rating, actors - as a string of all the actors separated by comma. Hint use GROUP_CONCAT

CREATE OR REPLACE VIEW film_details as
	select f.film_id , f.title, c.name, f.replacement_cost as precio, f.description, f.length, f.rating, group_concat(CONCAT_WS(" ", a.first_name , a.last_name ) )
	from film f
	INNER JOIN film_category fc USING (film_id)
	INNER JOIN category c USING (category_id)
	INNER JOIN film_actor fa USING (film_id)
	INNER JOIN actor a USING (actor_id)
	group by f.film_id, c.name 

---3 Create view sales_by_film_category, it should return 'category' and 'total_rental' columns.
CREATE OR REPLACE VIEW sales_by_film_category as
	select c.name, COUNT(r.rental_id ) as 'total_rental'
	from category c
	inner join film_category fc using(category_id)
	inner join film f using (film_id)
	inner join inventory i using(film_id)
	inner join rental r using(inventory_id)
	group by category_id; 


---4 Create a view called actor_information where it should return, actor id, first name, last name and the amount of films he/she acted on.
CREATE OR REPLACE VIEW actor_information as
	select a.actor_id , CONCAT_WS(" ", a.first_name ,a.last_name), count(f.film_id ) as amount_of_film
	from actor a 
	inner join film_actor fa using(actor_id)
	inner join film f using(film_id)
	group by a.actor_id 

