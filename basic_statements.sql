USE fruits_db;

SELECT *
FROM fruits;

SELECT 
    name, quantity
FROM
    fruits;

SELECT 1+1;

SELECT *
FROM fruits
WHERE name = 'apple';

/* Used for multiple 
line comments*/

SELECT 1 + 1 AS two;

SELECT 
    id,
    name AS low_quantity_fruit,
    quantity AS inventory
FROM fruits
WHERE quantity < 4;

