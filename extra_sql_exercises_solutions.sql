--EXTRA SQL PRACTICE
-- What is the average price of a track
SELECT AVG(unitprice) 
FROM Track;
-- Answer: 1.05


-- What's the name of the oldest employee
SELECT firstname, lastname, birthdate 
FROM employee
ORDER BY birthdate
LIMIT 5;
-- Answer: Margaret Park


-- How many hours of content are in the iTunes library?
SELECT SUM(milliseconds)/1000.0/60.0/60.0 
FROM track;
-- Answer: 382


-- How many customers use a yahoo email address
SELECT COUNT(*) 
FROM customer 
WHERE email LIKE "%@yahoo%";
-- Answer: 18


-- How many different countries have been invoiced?
SELECT COUNT(DISTINCT billingcountry) 
FROM invoice;
-- Answer: 24


-- How many customers don't have a State in their customer profiles?
SELECT COUNT(customerid)
FROM customer
WHERE state IS NULL;
-- Answer: 29


-- Which Genre name has the fewest tracks?
SELECT genre.name, COUNT(*) 
FROM genre 
JOIN track 
	ON genre.genreid = track.genreid
GROUP BY genre.name 
ORDER BY COUNT(*) 
LIMIT 10;
-- Answer: Opera


-- What is the most number of tracks on an album? 
SELECT album.title, COUNT(*)
FROM album
JOIN track 
	ON album.albumid = track.albumId
GROUP BY Album.Title
ORDER BY COUNT(*) DESC LIMIT 10;
-- Answer: 57


-- What is the name of the longest R&B/Soul track?
SELECT track.Name, track.milliseconds
FROM track
JOIN genre 
	ON track.genreid = genre.genreid
WHERE genre.name = 'R&B/Soul'
ORDER BY track.milliseconds DESC 
LIMIT 5;
-- Answer: Rehab


-- What are the names of the music videos?  
SELECT t.name
FROM track t
JOIN genre g
	ON t.genreid = g.genreid
JOIN mediatype m 
	ON t.mediatypeid = m.mediatypeid 
WHERE m.name LIKE '%video%' AND
      g.name NOT IN ('Comedy', 'Drama',
      	             'TV Shows', 'Sci Fi & Fantasy',
      	             'Science Fiction');
-- Answer: Band Members Discuss Tracks from "Revelations"












