USE albums_db;

SELECT 
    COUNT(artist), COUNT(id)
FROM
    albums;

-- 3a. Has 31 rows.

SELECT 
    artist
FROM
    albums;
SELECT 
    COUNT(DISTINCT artist)
FROM
    albums;

-- 3b. Has 23 unique artist names.  Note COUNT can't be separated by a space before ().  Can use AS 'label' to return it labeled with a title that makes mores sense.
SHOW tables;
SHOW CREATE TABLE albums;
SELECT 
    *
FROM
    albums;
-- 3c. The primary key for the albums table is called id.

SELECT 
    release_date
FROM
    albums;
SELECT 
    MAX(release_date)
FROM
    albums;
SELECT 
    MIN(release_date)
FROM
    albums;

-- 3d. Oldest release date is 1967.  Most recent release date is 2011.
-- You may want to return all the info in just the year and/or alias it so that returns the column with a name makes sense

SELECT 
    'Pink Floyd'
FROM
    albums;
SELECT 
    name, artist
FROM
    albums;
SELECT 
    name
FROM
    albums
WHERE
    artist = 'Pink Floyd';

-- 4a. Pink Floyd albums are "The Dark Side of the Moon" and "The Wall".

SELECT 
    release_date
FROM
    albums
WHERE
    name = 'Sgt. Pepper\'s Lonely Hearts Club Band';

-- 4b. Year of release date was 1967
-- You can add double quotations or an extra single qutation before the apostrophe to escape the apostrophe

SELECT 
    *
FROM
    albums;

SELECT 
    genre
FROM
    albums
WHERE
    name = 'Nevermind';

-- 4c. Nevermind's genre is Grunge, Alternative rock.

SELECT 
    name
FROM
    albums
WHERE
    release_date BETWEEN 1990 AND 2000;

-- 4d. 90's albums are The Bodyguard, Jagged Little Pill, Come On Over, Falling into You, Let's Talk About Love, 1, Dangerous, The Immaculate Collection, Titanic: Music from the Motion Picture, Metallica, Nevermind, Supernatural

SELECT 
    name
FROM
    albums
WHERE
    sales < 20;

-- 4e. Albums with less than 20 mil sales are Grease: The Original Soundtrack from the Motion Picture, Bad, Sgt. Peper's Lonely Hearts Club Band, Diry Dancing, Let's Talk About Love, Dangerous, The Immaculate Collection, Abbey Road, Born in the U.S.A., Brothers in Arms, Titanic: Music form the Motion Picture, Nevermind, and The Wall.

SELECT 
    name
FROM
    albums
WHERE
    genre = 'Rock';

-- 4f. Albums where the genre is just Rock are Sgt. Pepper's Lonely Hearts Club Band, 1, Abbey Road, Born in the U.S.A., and Supernatural

SELECT 
    name
FROM
    albums
WHERE
    FIND_IN_SET('rock', `genre`);

-- 4f. Albums where the genre has Rock are Their Greatest Hits (1971-1975), Sgt. Pepper's Lonely Hearts Club Band, Hotel California, 1, Dangerous, Abbey Road, Born in the U.S.A., Brothers in Arms, Supernatural
-- Can also use SELECT name, genre FROM albums WHERE genre LIKE '%Rock$'; but it includes things like soft rock, which is too broad.
-- Here's what somewhere is did.  SELECT
   /* name, genre
FROM
    albums
WHERE
    genre = ‘Rock’
		or genre LIKE ‘Rock,%’
        or genre LIKE ‘%, Rock, %’
        or genre LIKE ‘%, Rock’;*/