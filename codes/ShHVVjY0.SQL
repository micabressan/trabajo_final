#1 Find the film title and category name of all films in which SANDRA PECK acted
#Order the results by title, descending (use ORDER BY title DESC at the end of the query)
SELECT film.title, category.name FROM film 
    INNER JOIN film_category ON film.film_id = film_category.film_id 
    INNER JOIN category ON film_category.category_id = category.category_id
    INNER JOIN film_actor ON film.film_id = film_actor.film_id
    INNER JOIN actor ON film_actor.actor_id = actor.actor_id
    WHERE actor.first_name = 'SANDRA' AND actor.last_name = 'PECK'
    ORDER BY title DESC;


#2 We want to find out how many of each category of film each actor has started in so return a table with actor's id, actor's first name, actor's last name, category name and the count
#of the number of films that the actor was in which were in that category. Order the results by category name ascending. (Please pay attention that there may be many actors with the same last names, and also there may be few actors with the exact same first names and last names)
SELECT a.actor_id, a.first_name, a.last_name, c.name, COUNT(c.name)
    FROM actor a 
    INNER JOIN film_actor fa ON a.actor_id = fa.actor_id
    INNER JOIN film f ON fa.film_id = f.film_id
    INNER JOIN film_category fc ON f.film_id = fc.film_id
    INNER JOIN category c ON fc.category_id=c.category_id
    GROUP BY a.actor_id, c.name
    ORDER by a.actor_id, c.name ASC;




#3 Find the first name, last name and total combined film length of Action films for every actor whose last name starts with 'B'.
#That is the result should list the names of actors and the total lenght of Action films they have been in.(Your query should also list those actors whose last names start with 'B', but never acted in an Action film.)


SELECT T1.first_name, T1.last_name, T2.total
FROM 
    (SELECT a.first_name, a.last_name, a.actor_id
     FROM actor a
     WHERE a.last_name LIKE  'B%') 
    AS T1
LEFT JOIN 
    (SELECT a.first_name, a.last_name, a.actor_id, SUM( f.length ) AS total, c.name
    FROM actor a, film_actor fa, film f, film_category fc, category c
    WHERE c.category_id = fc.category_id
    AND fc.film_id = f.film_id
    AND a.actor_id = fa.actor_id
    AND fa.film_id = f.film_id
    AND c.name =  'action'
    GROUP BY a.actor_id) 
    AS T2 
ON T1.actor_id = T2.actor_id;

#4 Find the first name and last name of all actors who have never been in an Action film that has a length of more than 100 minutes.
SELECT a.first_name, a.last_name
FROM actor a
WHERE a.actor_id NOT IN 
    (SELECT a.actor_id
    FROM film f
    INNER JOIN film_category fc ON f.film_id = fc.film_id
    INNER JOIN category c ON fc.category_id = c.category_id
    INNER JOIN film_actor fa ON f.film_id = fa.film_id
    INNER JOIN actor a ON fa.actor_id = a.actor_id
    WHERE c.name =  'action'
    AND f.length >  '100'
    GROUP BY f.title);



#5 Find the film title of all films which feature both KIRSTEN PALTROW and WARREN NOLTE
#Order the results by title, descending (use ORDER BY title DESC at the end of the query)
#Warning, this is a tricky one and while the syntax is all things you know, you have to think oustide
#the box a bit to figure out how to get a table that shows pairs of actors in movies
SELECT T1.title, T1.first_name, T1.last_name, T2.first_name, T2.last_name FROM

(SELECT film.title, actor.first_name, actor.last_name 
    FROM actor INNER JOIN film_actor ON actor.actor_id = film_actor.actor_id
    INNER JOIN film ON film_actor.film_id = film.film_id
    WHERE actor.first_name = 'KIRSTEN' AND actor.last_name='PALTROW') as T1

INNER JOIN

(SELECT film.title, actor.first_name, actor.last_name 
    FROM actor INNER JOIN film_actor ON actor.actor_id = film_actor.actor_id
    INNER JOIN film ON film_actor.film_id = film.film_id
    WHERE actor.first_name = 'WARREN' AND actor.last_name='NOLTE') as T2

ON T1.title = T2.title;