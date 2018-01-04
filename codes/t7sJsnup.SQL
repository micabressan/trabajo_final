4
select m1.title, m2.title, count(a1.name) from casting c1, casting c2, actor a1, actor a2, movie m1, movie m2 where c1.actorid = a1.id and c2.actorid =a2.id and m1.id = c1.movieid and m2.id = c2.movieid and m1.id != m2.id and a1.id = a2.id group by m1.title, m2.title order by count desc;

5
select a1.name, a2.name, count(m1.title) from casting c1, casting c2, actor a1, actor a2, movie m1, movie m2 where c1.actorid = a1.id and c2.actorid =a2.id and m1.id = c1.movieid and m2.id = c2.movieid and m1.id = m2.id and a1.id != a2.id group by a1.name, a2.name order by count desc;