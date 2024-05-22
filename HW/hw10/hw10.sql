CREATE TABLE parents AS
  SELECT "abraham" AS parent, "barack" AS child UNION
  SELECT "abraham"          , "clinton"         UNION
  SELECT "delano"           , "herbert"         UNION
  SELECT "fillmore"         , "abraham"         UNION
  SELECT "fillmore"         , "delano"          UNION
  SELECT "fillmore"         , "grover"          UNION
  SELECT "eisenhower"       , "fillmore";

CREATE TABLE dogs AS
  SELECT "abraham" AS name, "long" AS fur, 26 AS height UNION
  SELECT "barack"         , "short"      , 52           UNION
  SELECT "clinton"        , "long"       , 47           UNION
  SELECT "delano"         , "long"       , 46           UNION
  SELECT "eisenhower"     , "short"      , 35           UNION
  SELECT "fillmore"       , "curly"      , 32           UNION
  SELECT "grover"         , "short"      , 28           UNION
  SELECT "herbert"        , "curly"      , 31;

CREATE TABLE sizes AS
  SELECT "toy" AS size, 24 AS min, 28 AS max UNION
  SELECT "mini"       , 28       , 35        UNION
  SELECT "medium"     , 35       , 45        UNION
  SELECT "standard"   , 45       , 60;


-- All dogs with parents ordered by decreasing height of their parent
CREATE TABLE by_parent_height AS
  SELECT p.child
  FROM parents p
  JOIN dogs d ON p.parent = d.name
  ORDER BY d.height DESC;


-- The size of each dog
CREATE TABLE size_of_dogs AS
  SELECT d.name, s.size
  FROM dogs d
  JOIN sizes s ON d.height > s.min AND d.height <= s.max;



-- Filling out this helper table is optional
CREATE TABLE siblings AS
  SELECT p1.child AS sibling1, p2.child AS sibling2
  FROM parents p1
  JOIN parents p2 ON p1.parent = p2.parent AND p1.child < p2.child;

-- Sentences about siblings that are the same size
CREATE TABLE sentences AS
  SELECT 'The two siblings, ' || s.sibling1 || ' and ' || s.sibling2 || ', have the same size: ' || d1.size
  FROM siblings s
  JOIN size_of_dogs d1 ON s.sibling1 = d1.name
  JOIN size_of_dogs d2 ON s.sibling2 = d2.name AND d1.size = d2.size;


-- Height range for each fur type where all of the heights differ by no more than 30% from the average height
CREATE TABLE low_variance AS
  SELECT d.fur,
         MAX(d.height) - MIN(d.height) AS height_range
  FROM dogs d
  JOIN (
    SELECT fur, 
           AVG(height) AS avg_height,
           0.7 * AVG(height) AS min_height,
           1.3 * AVG(height) AS max_height
    FROM dogs
    GROUP BY fur
  ) AS avg_data ON d.fur = avg_data.fur
  WHERE d.height BETWEEN avg_data.min_height AND avg_data.max_height
  GROUP BY d.fur
  HAVING COUNT(*) = (SELECT COUNT(*) FROM dogs WHERE fur = d.fur);

