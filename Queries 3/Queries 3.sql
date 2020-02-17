--Question 1. What is the name of the person who spent the most (and how much did they spend)?
--Step 1. get all the rows from table tickets
SELECT *
FROM tickets;
--Step 2. join another two tables: purchases and people
SELECT *
FROM tickets, purchases, people
WHERE tickets.purchase_id = purchases.id
AND purchases.person_id = people.id;
--Step 3. specify the searching columns and get the results ordered
SELECT people.name, sum(tickets.price) as spent
FROM tickets, purchases, people
WHERE tickets.purchase_id = purchases.id
AND purchases.person_id = people.id
GROUP BY people.name
ORDER BY spent DESC
LIMIT 1;

--Question 2. Which performance had the highest revenue? (ticket prices are incoming income, thus revenue)
--Step 1. get all the rows from table tickets
SELECT *
FROM tickets;
--Step 2. join the other table: performances
SELECT *
FROM tickets, performances
WHERE tickets.performance_id = performances.id
--Step 3. specify the searching columns and get the results ordered
SELECT performances.id
FROM tickets, performances
WHERE tickets.performance_id = performances.id
GROUP BY performances.id
ORDER BY sum(tickets.price) DESC
LIMIT 1;

--Question 3. Which performance was the most profitable? (profit is revenue - costs.  bands.fee is the cost)
--Step 1. using the SQL scripts in question 2, join another table: bands
SELECT performances.id
FROM tickets, performances, bands
WHERE tickets.performance_id = performances.id
AND performances.band_id = bands.id
GROUP BY performances.id
ORDER BY sum(tickets.price) DESC
LIMIT 1;

--Step 2. modify the grouping by conditions
SELECT performances.id
FROM tickets, performances, bands
WHERE tickets.performance_id = performances.id
AND performances.band_id = bands.id
GROUP BY performances.id
ORDER BY sum(tickets.price)-bands.fee DESC
LIMIT 1;

--Which band was the least profitable for the festival? (note: bands are paid their fee for each performance, hint: dealing with that requires a COUNT(DISTINCT ...) within a group. Look closely at the rows in the group by using ORDER BY, which column might tell you the number of shows?) (If you have trouble with this one, just do as though they are only paid the fee once).
--Step 1. get all the rows of table bands
SELECT *
FROM bands;
--Step 2. join another table: table performances
SELECT *
FROM bands, performances
WHERE bands.id = performances.band_id;
--Step 3. Specify the searching columns, add grouping conditions and ordering conditions
SELECT bands.name, bands.fee*count(DISTINCT performances.id) AS profit
FROM bands, performances
WHERE bands.id = performances.band_id
GROUP BY bands.id
ORDER BY profit
LIMIT 1;

--Questions 5. Which venues were oversold (and what were their capacities)?
--Step 1. get all the rows of table venues
SELECT *
FROM venues;
--Step 2. join another two tables: performances and tickets
SELECT *
FROM venues, performances, tickets
WHERE venues.id = performances.venue_id
AND tickets.performance_id = performances.id;
--Step 3. specify searching columns and add searching conditions,grouping conditions
SELECT DISTINCT venues.name, venues.capacity 
FROM venues, performances, tickets 
WHERE venues.id = performances.venue_id AND tickets.performance_id = performances.id 
GROUP BY performances.id
HAVING count(*) > venues.capacity;

--Question 6. What was the total revenue from ticket sales each month?
--Step 1. get all the rows of table tickets
SELECT *
FROM tickets;
--Step 2. join another table: purchases
SELECT *
FROM tickets, purchases
WHERE tickets.purchase_id = purchases.id;
--Step 3. specify searching columns and grouping conditions;
SELECT sum(tickets.price) as revenue, Month(purchases.date)
FROM tickets, purchases
WHERE tickets.purchase_id = purchases.id
GROUP BY Month(purchases.date);

--Question 7. What was the average purchase total each month?
--Step 1. get all the rows of table tickets
SELECT *
FROM tickets;
--Step 2. join another table: purchases
SELECT *
FROM tickets, purchases
WHERE tickets.purchase_id = purchases.id;
--Step 3. specify searching columns and grouping conditions
SELECT sum(tickets.price)
FROM tickets, purchases
WHERE tickets.purchase_id = purchases.id
GROUP BY purchases.id;
--Step 4. specify the final searching columns and another grouping conditions
SELECT avg(purchase_total), month
FROM
(
	SELECT sum(tickets.price) AS purchase_total, Month(purchases.date) AS month
	FROM tickets, purchases
	WHERE tickets.purchase_id = purchases.id
	GROUP BY purchases.id
) AS count_tickets_prices
GROUP BY month;