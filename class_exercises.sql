-- SELECT *
-- FROM album
-- LIMIT 10; 


-- Exercise #1

-- What are the genres in the database?
-- SELECT *
-- FROM genre;

-- What are the customer names that are from California?
-- SELECT FirstName, LastName, State
-- FROM Customer
-- WHERE State = 'CA';


-- Exercise #2

-- SELECT COUNT(*)
-- FROM track
-- WHERE milliseconds > 60*1000*10

-- SELECT count(*)
-- FROM invoice
-- WHERE invoicedate > '2010-01-01' 
-- 	AND invoicedate < '2010-02-01';

-- SELECT count(*)
-- FROM invoice
-- WHERE invoicedate BETWEEN '2010-01-01' 
-- 	AND '2010-02-01';


-- SELECT count(*)
-- FROM track
-- WHERE composer IS NULL;

-- SELECT count(DISTINCT title)
-- FROM album;

-- SELECT count(DISTINCT albumId)
-- FROM album;


-- Exercise #3

-- What are the 5 longest tracks?
-- SELECT * 
-- FROM track
-- order by milliseconds DESC
-- LIMIT 5;


-- R.E.M. has collaborated with a couple artists, can
-- you find which artists they've collaborate with?
-- SELECT *
-- FROM artist
-- WHERE name like '%R.E.M%' AND name != 'R.E.M.';


-- How many love songs are there?
-- SELECT COUNT(name)
-- FROM track
-- WHERE name like '%love%';

-- But this finds words like glove and rollover

-- SELECT COUNT(name)
-- FROM track
-- WHERE name like '% love%' OR
-- 	name LIKE 'love%' OR
-- 	name like '%loving%';


-- Exercise #4

-- SELECT COUNT(*)
-- FROM track
-- JOIN genre
-- 	ON track.genreid = genre.genreid 
-- WHERE genre.name LIKE '%rock%' OR 
-- 	genre.name LIKE '%alternative%'; 


-- SELECT track.name, track.milliseconds, mediatype.name
-- FROM track
-- JOIN mediatype
-- 	ON track.mediatypeid = mediatype.mediatypeid
-- WHERE mediatype.name LIKE '%audio%'
-- ORDER BY track.milliseconds DESC
-- LIMIT 5;

-- SELECT COUNT(*)
-- FROM track
-- JOIN album
-- 	ON track.albumID = album.albumID
-- JOIN artist
-- 	ON album.artistID = artist.artistID
-- WHERE artist.name LIKE '%R.E.M.%'

-- What state does R.E.M. sell the most tracks in?


-- How many playlists contain Dazed and Confused

-- SELECT *
-- FROM playlist
-- JOIN playlisttrack
-- ON playlist.playlistid = playlisttrack.playlistid
-- JOIN track
-- ON playlisttrack.trackid = track.trackid
-- WHERE track.name = 'Dazed And Confused'

-- How many time was album Big Ones sold?
-- SELECT count(*)
-- FROM invoiceline
-- JOIN track
-- ON invoiceline.trackid = track.trackid
-- JOIN album
-- ON track.albumid = album.albumid
-- WHERE album.title = "Big Ones";

-- Exercise #5

-- What was the sales total for Jan 2010
-- SELECT SUM(TOTAL)
-- FROM invoice
-- WHERE invoicedate > '2010-01-01' AND
-- 	invoicedate < '2010-02-01';

-- What is the average length of a song by R.E.M.?
-- SELECT AVG(milliseconds/1000. / 60.) AS minutes
-- FROM track t
-- JOIN album a
-- 	ON t.albumID = a.albumID
-- JOIN artist art
-- 	ON a.artistID = art.artistID
-- WHERE art.name LIKE '%R.E.M.%'

-- Exercise #6

-- SELECT art.name, count(t.trackid) as n_tracks
-- FROM track t
-- JOIN album a
-- 	ON t.albumID = a.albumID
-- JOIN artist art
-- 	ON a.artistID = art.artistID
-- GROUP BY 1 
-- -- The same can be done using GROUP BY art.name
-- ORDER BY n_tracks DESC
-- LIMIT 5


SELECT album.title, SUM(track.milliseconds/1000./60.) as minutes
FROM album
JOIN track
	ON album.albumid = track.albumid
JOIN mediatype
	ON track.mediatypeid = mediatype.mediatypeid
WHERE mediatype.name LIKE '%audio%'
GROUP BY album.title
ORDER BY minutes DESC
LIMIT 5