/* SQL Bootcamp - Class Examples*/


-- Exercise #1
-- What are the genres in the database? 
SELECT * 
FROM genre 
LIMIT 10000;
--- Answer:
-- 1|Rock
-- 2|Jazz
-- 3|Metal
-- 4|Alternative & Punk
-- 5|Rock And Roll
-- 6|Blues
-- 7|Latin
-- 8|Reggae
-- 9|Pop
-- 10|Soundtrack
-- 11|Bossa Nova
-- 12|Easy Listening
-- 13|Heavy Metal
-- 14|R&B/Soul
-- 15|Electronica/Dance
-- 16|World
-- 17|Hip Hop/Rap
-- 18|Science Fiction
-- 19|TV Shows
-- 20|Sci Fi & Fantasy
-- 21|Drama
-- 22|Comedy
-- 23|Alternative
-- 24|Classical
-- 25|Opera
-- 26|Scottish Bagpipe


-- What are the customer names that are 
-- from California?
SELECT firstname, lastname, state
FROM customer
WHERE state = 'CA';
-- Answer:
-- Frank|Harris|CA
-- Tim|Goyer|CA
-- Dan|Miller|CA


-- Exercise #2
-- How many songs are longer than 10 minutes?
SELECT COUNT(*)
FROM track 
WHERE milliseconds > 10 * 60 * 1000;
-- Answer: 260


-- How many invoices were there in 
-- January 2010? 
SELECT COUNT(*) 
FROM invoice 
WHERE invoicedate BETWEEN '2010-01-01' 
      AND '2010-02-01';
-- Answer: 7


-- How many tracks have NULL composer?
SELECT COUNT(*)
FROM track
WHERE composer IS NULL;
-- Answer: 978


-- How many distinct album titles are there?  
SELECT COUNT(DISTINCT title) 
FROM album;
-- Answer: 347


-- How many distinct album ids?  
SELECT COUNT(DISTINCT albumid) 
FROM album;
-- Answer: 348


-- Exercise #3
-- What are the 5 longest tracks?
SELECT name, milliseconds/1000./60.
FROM track
ORDER BY milliseconds DESC
LIMIT 10;
-- Answer:
	-- Occupation / Precipice|88.1158833333333
	-- Through a Looking Glass|84.8139666666667
	-- Greetings from Earth, Pt. 1|49.3382166666667
	-- The Man With Nine Lives|49.2833
	-- Battlestar Galactica, Pt. 2|49.2680166666667
	-- Battlestar Galactica, Pt. 1|49.2117
	-- Murder On the Rising Star|48.9315666666667
	-- Battlestar Galactica, Pt. 3|48.7967
	-- Take the Celestra|48.7946166666667
	-- Fire In Space|48.77655


-- R.E.M. has collaborated with a couple 
-- artists, can you find which artists 
-- they’ve collaborated with?
SELECT *
FROM artist
WHERE name LIKE '%R.E.M.%';
-- Answer:
	-- 122,"R.E.M. Feat. Kate Pearson"
	-- 123,"R.E.M. Feat. KRS-One"
	-- 124,R.E.M.


-- How many ‘Love’ songs are there?
-- Option 1:
SELECT COUNT(*)
FROM track
WHERE name LIKE '%love%';
-- Answer: 114


-- Option 2:
SELECT COUNT(*)
FROM track
WHERE name LIKE 'love%' OR name LIKE '% love%' OR 
       name LIKE '%loving%';


-- Table Examples
-- Create a new table from scratch
CREATE TABLE IF NOT EXISTS favorite_songs (
    id INTEGER PRIMARY KEY,
    title TEXT,
    seconds INTEGER
);

-- Create table from a query
CREATE TABLE IF NOT EXISTS favorite_tracks AS 
	SELECT * 
	FROM track 
	WHERE genreid=1;


-- Insert values into the table
INSERT INTO favorite_songs (id, title, seconds)
    VALUES (0, 'Call Me Maybe', 260);


-- Insert multiple values into the table
INSERT INTO favorite_songs (id, title, seconds)
    VALUES (1, 'Thriller', 250), 
           (2, 'Roar', 240),
           (3, 'What Does the Fox Say', 300);


-- Drop the tables you created
DROP TABLE IF EXISTS favorite_songs;
DROP TABLE IF EXISTS favorite_tracks;


-- Exercise #4
-- How many tracks are rock or alternative?
SELECT COUNT(*) 
FROM track
JOIN genre
	ON track.genreid = genre.genreid
WHERE genre.name LIKE '%rock%' OR 
      genre.name LIKE '%alternative%';

SELECT COUNT(*) 
FROM track
JOIN genre
	ON track.genreid = genre.genreid
WHERE genre.name IN ('Rock', 'Alternative', 
	                 'Rock And Roll', 
	                 'Alternative & Punk');
-- Answer: 1681


-- What are the 5 longest songs?
SELECT track.name, track.milliseconds/1000./60., 
       mediatype.name
FROM track
JOIN mediatype 
 	ON track.mediatypeid = mediatype.mediatypeid
WHERE mediatype.name LIKE '%audio%'
ORDER BY track.milliseconds DESC
LIMIT 6;
-- Dazed And Confused|26.87215|MPEG audio file
-- Space Truckin'|19.9349|MPEG audio file
-- Dazed And Confused|18.6122333333333|MPEG audio file
-- We've Got To Get Together/Jingo|17.8337833333333|MPEG audio file
-- Funky Piano|15.57985|MPEG audio file
-- Going Down / Highway Star|15.2276333333333|MPEG audio file


-- How many tracks are performed by R.E.M.?
SELECT COUNT(*)
FROM track
  JOIN album ON track.albumid = album.albumid
  JOIN artist ON album.artistid = artist.artistid
WHERE artist.name LIKE '%R.E.M.%' ;
-- Answer: 52


-- Exercise #5
-- What was the sales total for January 2010? 
SELECT SUM(total)
FROM invoice
WHERE invoicedate >= '2010-01-01' AND
	  invoicedate < '2010-02-01';
-- Answer 52.62


-- What is the average length of a song 
-- by R.E.M.?  
SELECT AVG(t.milliseconds/60./1000.) AS minutes
FROM artist ar
JOIN album al
    ON ar.artistid= al.artistid
JOIN track t
    ON al.albumid = t.albumid
WHERE ar.name LIKE '%R.E.M.%';
-- Answer:
--  Minutes         
--  ----------------
--  4.04347884615385 


-- Exercise #6
-- Which Artists have the most tracks?
SELECT ar.name, COUNT(*) 
FROM track t
JOIN album al
    ON t.albumid=al.albumid
JOIN artist ar
    ON al.artistid = ar.artistid
GROUP BY ar.name
ORDER BY COUNT(*) DESC
LIMIT 5;
-- Answer:
	-- "Iron Maiden",213
	-- U2,135
	-- "Led Zeppelin",114
	-- Metallica,112
	-- "Deep Purple",92


-- What is the album title 
-- of the album with the longest playing time?
SELECT ar.name, al.title, 
       SUM(t.milliseconds)/60000.0 AS minutes
FROM track t
JOIN album al
    ON t.albumid=al.albumid
JOIN artist ar
    ON al.artistid = ar.artistid
GROUP BY ar.name, al.title
ORDER BY minutes DESC
LIMIT 5;
-- Answer:
-- Name        Title           minutes   
-- ----------  --------------  ----------
-- Lost        Lost, Season 3  1177.7597 
-- Battlestar  Battlestar Gal  1170.22973
-- Lost        Lost, Season 1  1080.9156 
-- Lost        Lost, Season 2  1054.82718
-- Heroes      Heroes, Season  996.3378  


-- Bonus Question - How do the results change 
-- if you omit videos from the query
SELECT ar.name, al.title, 
       SUM(t.milliseconds)/60000.0 AS minutes
FROM track t
JOIN album al
    ON t.albumid=al.albumid
JOIN artist ar
    ON al.artistid = ar.artistid
JOIN mediatype m
    ON t.mediatypeid = m.mediatypeid
WHERE m.name NOT LIKE '%video%'
GROUP BY ar.name, al.title
ORDER BY minutes DESC
LIMIT 5;
-- Answer:
-- Name           Title          minutes         
-- -------------  -------------  ----------------
-- Lenny Kravitz  Greatest Hits  251.095516666667
-- Eric Clapton   Unplugged      135.221266666667
-- Chico Buarque  Minha Histori  131.260716666667
-- Iron Maiden    Live After De  97.1309333333333
-- U2             Instant Karma  85.5814333333333