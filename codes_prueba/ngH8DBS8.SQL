1)SELECT Title FROM Movie WHERE Director = 'Steven Spielberg';
2)SELECT DISTINCT Year FROM Movie JOIN Rating WHERE Stars >= 4 ORDER BY Year asc;
3)SELECT Name FROM Movie JOIN Rating JOIN Reviewer WHERE Title = 'Gone with the Wind';
4)SELECT DISTINCT name,title,stars from Movie natural join Reviewer natural join Rating where name = director;