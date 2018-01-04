-- INSERT
-- User with MEMBER_ID = 1 adds movie with MOVIE_ID = 10 as offered

INSERT INTO list_entry(NOTES, MOVIE_ID, MEMBER_ID, STATUS_ID)
VALUES('notes on movie', 10, 1, 1)

-- DELETE
-- User with MEMBER_ID = 1 removes movie with MOVIE_ID = 10 from his/her offered list

DELETE from list_entry
WHERE MEMBER_ID = 1
AND STATUS_ID = 1
AND MOVIE_ID = 10

-- SELECT
-- Showing all the MEMBER_ID of all users offering the movie with MOVIE_ID = 10

SELECT MEMBER_ID 
FROM list_entry
WHERE MOVIE_ID = 10
AND STATUS_ID = 1

-- UPDATE
-- Movie with MOVIE_ID = 10 has just been given a higher classification by the Australian Classification -- Review Board

UPDATE movie
SET CLASSIFICATION = 'R'
WHERE MOVIE_ID = 10