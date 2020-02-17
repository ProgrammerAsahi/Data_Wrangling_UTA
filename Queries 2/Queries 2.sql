--Question 1. What are the names of the bands that perform in the BMI venue?
-- Step 1. find the id of the venue named "BMI". The answer is 5.
SELECT id
FROM venues
WHERE name = "BMI"；
--Step 2. find the performances that have performed in "BMI"
SELECT *
FROM performances
WHERE venue_id = 5;
--Step 3. join the two tables: band and performances, with the connection of band_id in common
SELECT *
FROM performances
JOIN bands
ON performances.band_id = bands.id
WHERE venue_id = 5;
--Step 4. Change the searching target to band name
SELECT bands.name
FROM performances
JOIN bands
ON performances.band_id = bands.id
WHERE venue_id = 5
ORDER BY bands.name;

--Question 2. Who purchased ticket number TA9875424?
--Step 1. find the row in table tickets that contain ticketnum TA9875424.
SELECT *
FROM tickets
WHERE ticketnum = 'TA9875424';
--Step 2. join the two tables: tickets and purchases, with the connection of purchase_id in common, to find out the specific transaction
SELECT *
FROM tickets
JOIN purchases
ON purchases.id = tickets.purchase_id
WHERE ticketnum = 'TA9875424';
--Step 3. join the third table: people, with the connection of person_id in common
SELECT *
FROM tickets
JOIN purchases
ON purchases.id = tickets.purchase_id
JOIN people
ON purchases.person_id = people.id
WHERE ticketnum = 'TA9875424';
--Step 4. Change the searching target to people's name
SELECT people.name
FROM tickets
JOIN purchases
ON purchases.id = tickets.purchase_id
JOIN people
ON purchases.person_id = people.id
WHERE ticketnum = 'TA9875424';

--Question 3.When was the first ticket to a performance at the venue BMI purchased?
--Step 1. find the row in table venues that venue's name is "BMI"
SELECT *
FROM venues
WHERE venues.name = "BMI";
--Step 2. join the two tables: performances and venues, with the connection of venue_id in common, to find the performances at BMI.
SELECT *
FROM venues
JOIN performances
ON venues.id = performances.venue_id
WHERE venues.name = "BMI";
--Step 3. join the third table: tickets, with the connection of performance_id in common, to find the tickets that related to the performances at BMI.
SELECT *
FROM venues
JOIN performances
ON venues.id = performances.venue_id
JOIN tickets
ON tickets.performance_id = performances.id
WHERE venues.name = "BMI";
--Step 4. join the fourth table, purchases, with the connection of purchase_id, to find all the purchasing records related to the performances at BMI.
SELECT *
FROM venues
JOIN performances
ON venues.id = performances.venue_id
JOIN tickets
ON tickets.performance_id = performances.id
JOIN purchases
ON tickets.purchase_id = purchases.id
WHERE venues.name = "BMI";
--Step 5. Get the result ordered, by using purchasing date; and change the searching target to purchasing date.
SELECT purchases.date
FROM venues
JOIN performances
ON venues.id = performances.venue_id
JOIN tickets
ON tickets.performance_id = performances.id
JOIN purchases
ON tickets.purchase_id = purchases.id
WHERE venues.name = "BMI"
ORDER BY purchases.date;
--Step 6. Get the first date, which is the answer.
SELECT purchases.date
FROM venues
JOIN performances
ON venues.id = performances.venue_id
JOIN tickets
ON tickets.performance_id = performances.id
JOIN purchases
ON tickets.purchase_id = purchases.id
WHERE venues.name = "BMI"
ORDER BY purchases.date
LIMIT 1;

--Question 4.When is the first show (band name, venue name and start time) that Domhog Kiwter has a ticket to? 
--Step 1. find the row of Domhog Kiwter in people table
SELECT *
FROM people
WHERE people.name = "Domhog Kiwter";
--Step 2. join the second table: purchases, with the connection of person_id in common, to find the transaction records related to Domhog Kiwter
SELECT *
FROM people, purchases
WHERE people.name = "Domhog Kiwter"
AND people.id = purchases.person_id;
--Step 3. join the third table: tickets, with the connection of purchase_id in common, to find all the tickets that have purchased by Domhog Kiwter.
SELECT *
FROM people, purchases, tickets
WHERE people.name = "Domhog Kiwter"
AND people.id = purchases.person_id
AND tickets.purchase_id = purchases.id;
-- Step 4. join the fourth table: performances, with the connection of performance_id in common, to find all the performances that Domhog Kiwter has viewed
SELECT *
FROM people, purchases, tickets, performances
WHERE people.name = "Domhog Kiwter"
AND people.id = purchases.person_id
AND tickets.purchase_id = purchases.id
AND performances.id = tickets.performance_id;
-- Step 5. join the fifth and sixth table: bands and venues, with the connection of band_id and venue_id in common respectively, to find the band name and venue name
SELECT *
FROM people, purchases, tickets, performances, bands, venues
WHERE people.name = "Domhog Kiwter"
AND people.id = purchases.person_id
AND tickets.purchase_id = purchases.id
AND performances.id = tickets.performance_id
AND bands.id = performances.band_id
AND venues.id = performances.venue_id;
-- Step 6.get the result ordered, by using the start time of performances, specify the searching targets, and limit the result to first one
SELECT bands.name, venues.name, performances.start
FROM people, purchases, tickets, performances, bands, venues
WHERE people.name = "Domhog Kiwter"
AND people.id = purchases.person_id
AND tickets.purchase_id = purchases.id
AND performances.id = tickets.performance_id
AND bands.id = performances.band_id
AND venues.id = performances.venue_id
ORDER BY performances.start
LIMIT 1;

--Question 5.Which band that performed at the AMD venue had the highest fee?
--Step 1. find the row of AMD venue in table venues
SELECT *
FROM venues
WHERE venues.name = "AMD";
--Step 2. join the second table: performances, to acquire the data of performances at AMD
SELECT *
FROM venues, performances
WHERE venues.name = "AMD"
AND venues.id = performances.venue_id;
--Step 3. join the third table: bands, to get the related band name
SELECT *
FROM venues, performances, bands
WHERE venues.name = "AMD"
AND venues.id = performances.venue_id
AND bands.id = performances.band_id;
--Step 3. Get the result ordered descendly, by using band fee, and change the searching target to band name
SELECT bands.name
FROM venues, performances, bands
WHERE venues.name = "AMD"
AND venues.id = performances.venue_id
AND bands.id = performances.band_id
ORDER BY bands.fee DESC
LIMIT 1;