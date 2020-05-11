"""
1.
"""
SELECT f.title, f.rating
FROM film f
WHERE f.`length` <= ALL (SELECT `length`
                      FROM film f2
                     WHERE f2.film_id <> f.film_id )

"""
2.
"""
SELECT f.title
FROM film f
WHERE f.`length` < ALL (SELECT `length`
                      FROM film f2
                     WHERE f2.film_id <> f.film_id )

"""
3.
"""
SELECT c.first_name,
   c.last_name,
   c.email,
   a.address,
 (SELECT MIN(amount)
 FROM payment p
 WHERE c.customer_id = p.customer_id ) AS min_amount
FROM customer c, address a
WHERE a.address_id = c.address_id

"""
4.
"""
SELECT  c.first_name,
 c.last_name,
 c.email,
 (SELECT MIN(amount)
 FROM payment p1
 WHERE c.customer_id = p1.customer_id ) AS min_amount,
 (SELECT MAX(amount)
 FROM payment p2
 WHERE c.customer_id = p2.customer_id ) AS max_amount
FROM customer c
ORDER BY min_amount
