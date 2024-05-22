.read data.sql


CREATE TABLE bluedog AS
  SELECT color, pet
  FROM students
  WHERE color = 'blue' AND pet = 'dog';

CREATE TABLE bluedog_songs AS
  SELECT color, pet, song
  FROM students
  WHERE color = 'blue' AND pet = 'dog';



CREATE TABLE smallest_int_having AS
  SELECT time, smallest
  FROM students
  GROUP BY smallest
  HAVING COUNT(smallest) = 1;


CREATE TABLE matchmaker AS
  SELECT s1.pet AS shared_pet, s1.song AS shared_song, s1.color AS first_person_color, s2.color AS second_person_color
  FROM students AS s1, students AS s2
  WHERE s1.pet = s2.pet AND s1.song = s2.song
    AND s1.time < s2.time;



CREATE TABLE sevens AS
  SELECT s.seven
  FROM students s
  JOIN numbers n ON s.time = n.time
  WHERE n."7" = 'True' AND s.smallest <= 7;


