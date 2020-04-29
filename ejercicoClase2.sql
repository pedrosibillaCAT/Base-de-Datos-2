CREATE database if not exists imdb;
use imdb;

CREATE table if not exists film (
  film_id INT AUTO_INCREMENT,
	title VARCHAR(50),
	description VARCHAR(200),
	release_year INT,
	CONSTRAINT film_pk PRIMARY KEY (film_id)
);

CREATE table if not exists actor(
  actor_id INT AUTO_INCREMENT,
	first_name VARCHAR(30),
	last_name VARCHAR(50),
	CONSTRAINT film_pk PRIMARY KEY (actor_id)
);

CREATE table if not exists film_actor(
  actor_id INT NOT NULL,
	film_id INT NOT NULL,
	CONSTRAINT actor_film_pk PRIMARY KEY (actor_id, film_id)

);

ALTER TABLE film ADD COLUMN last_update DATETIME;

ALTER TABLE film MODIFY last_update DATETIME DEFAULT CURRENT_TIMESTAMP;

ALTER TABLE actor ADD COLUMN last_update DATETIME;

ALTER TABLE actor MODIFY last_update DATETIME DEFAULT CURRENT_TIMESTAMP;

ALTER TABLE actor_film ADD
	CONSTRAINT fk_film FOREIGN KEY (film_id) REFERENCES film (film_id);

ALTER TABLE actor_film ADD
	CONSTRAINT fk_actor FOREIGN KEY (actor_id) REFERENCES actor (actor_id);

INSERT INTO actor
