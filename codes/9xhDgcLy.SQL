SELECT MOVIE_TITLE FROM movie
NATURAL JOIN list_entry
WHERE list_entry.MEMBER_ID = 1 AND list_entry.STATUS_ID = 1