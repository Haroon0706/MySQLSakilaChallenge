USE sakila;
SHOW TABLES;
DESCRIBE actor;
SELECT * FROM actor;

DESCRIBE actor_info;
SELECT * FROM actor_info;

DESCRIBE address;
SELECT * FROM address;

DESCRIBE category;
SELECT * FROM category;

DESCRIBE city;
SELECT * FROM city;

DESCRIBE country;
SELECT * FROM country;

DESCRIBE customer;
SELECT * FROM customer;

DESCRIBE customer_list;
SELECT * FROM customer_list;

DESCRIBE film;
SELECT * FROM film;

DESCRIBE film_actor;
SELECT * FROM film_actor;

DESCRIBE film_category;
SELECT * FROM film_category;

DESCRIBE film_list;
SELECT * FROM film_list;

DESCRIBE film_text;
SELECT * FROM film_text;

DESCRIBE inventory;
SELECT * FROM inventory;

DESCRIBE language;
SELECT * FROM language;

DESCRIBE nicer_but_slower_film_list;
SELECT * FROM nicer_but_slower_film_list;

DESCRIBE payment;
SELECT * FROM payment;

DESCRIBE rental;
SELECT * FROM rental;

DESCRIBE sales_by_film_category;
SELECT * FROM sales_by_film_category;

DESCRIBE sales_by_store;
SELECT * FROM sales_by_store;

DESCRIBE staff;
SELECT * FROM staff;

DESCRIBE staff_list;
SELECT * FROM staff_list;

DESCRIBE store;
SELECT * FROM store;



#List all actors.
SELECT first_name, last_name FROM actor ORDER BY first_name ASC;

#Find the surname of the actor with the forename 'John'.
SELECT first_name, last_name FROM actor WHERE first_name = "John";

#Find all actors with surname 'Neeson'.
SELECT first_name, last_name FROM actor WHERE last_name = "Neeson";

#Find all actors with ID numbers divisible by 10.
SELECT actor_id, first_name, last_name FROM actor_info WHERE actor_id%10 = 0;

#What is the description of the movie with an ID of 100?
SELECT film_id, title, description FROM film WHERE film_id = 100 LIMIT 1;

#Find every R-rated movie.
SELECT title, rating FROM film WHERE rating = "R" ORDER BY title ASC;

#Find every non-R-rated movie.
SELECT title, rating FROM film WHERE rating != "R" ORDER BY title ASC;

#Find the ten shortest movies.
SELECT title, length FROM film 
WHERE length IS NOT NULL
ORDER BY length ASC LIMIT 10;

#Find the movies with the longest runtime, without using LIMIT.
SELECT title, length FROM film
WHERE length IS NOT NULL
ORDER BY length DESC;

#Find all movies that have deleted scenes.
SELECT title FROM film
WHERE special_features IS NOT NULL
AND special_features LIKE "%Deleted Scenes%";

#Using HAVING, reverse-alphabetically list the last names that are not repeated.
SELECT last_name, COUNT(last_name) FROM actor
GROUP BY last_name 
HAVING COUNT(last_name)=1
ORDER BY last_name DESC;

#Using HAVING, list the last names that appear more than once, from highest to lowest frequency.
SELECT last_name, COUNT(last_name) as frequency FROM actor
GROUP BY last_name
HAVING COUNT(last_name) > 1 
ORDER BY frequency DESC;

#Which actor has appeared in the most films?
SELECT a.first_name, a.last_name, COUNT(fa.film_id) as frequency FROM actor a
JOIN film_actor fa ON a.actor_id=fa.actor_id
GROUP BY a.first_name
ORDER BY frequency DESC LIMIT 1;

#When is 'Academy Dinosaur' due?
SELECT f.title, MAX(r.return_date) as M FROM inventory i
JOIN rental r ON r.inventory_id=i.inventory_id
JOIN film f ON f.film_id=i.film_id
WHERE f.title = "Academy Dinosaur"
GROUP BY i.inventory_id
ORDER BY M DESC;

#What is the average runtime of all films?
SELECT AVG(length) FROM film;

#List the average runtime for every film category.
SELECT fl.category, AVG(fl.length) FROM film_list fl
JOIN film_category fc ON fl.FID=fc.film_id
GROUP BY fl.category
ORDER BY fl.category ASC;

#List all movies featuring a robot.
SELECT title, description FROM film_list
WHERE DESCRIPTION IS NOT NULL
AND description LIKE "%robot%";

#How many movies were released in 2010?
SELECT COUNT(release_year) FROM film
WHERE release_year=2010;

#Find the titles of all the horror movies.
CREATE VIEW listed_film_categories 
AS
	SELECT fl.title, fl.category FROM film_list fl
	JOIN film_category fc ON fl.FID=fc.film_id;

SELECT * FROM listed_film_categories;

SELECT title, category FROM listed_film_categories
WHERE category = "Horror";

#OR can use
SELECT title, category FROM film_list
WHERE category = "Horror";

#List the full name of the staff member with the ID of 2.
SELECT first_name, last_name FROM staff
WHERE staff_id = 2; 
 
#List all the movies that Fred Costner has appeared in.
SELECT title, actors FROM film_list
WHERE actors LIKE "%Fred Costner%";

#How many distinct countries are there?
SELECT DISTINCT COUNT(country) FROM country;

#List the name of every language in reverse-alphabetical order.
SELECT name FROM language
WHERE name IS NOT NULL
ORDER BY name DESC; 

#List the full names of every actor whose surname ends with '-son' in alphabetical order by their forename.
SELECT first_name, last_name FROM actor
WHERE last_name LIKE "%son"
ORDER BY first_name ASC;

#Which category contains the most films?
SELECT COUNT(title), category FROM film_list
GROUP BY category LIMIT 1;

