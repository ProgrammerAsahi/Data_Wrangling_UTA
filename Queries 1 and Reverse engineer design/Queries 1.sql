--Answers for Question 1
SELECT fee
FROM bands 
WHERE name = 'Cut Copy';

--Answers for Question 2
SELECT price
FROM tickets 
WHERE ticketnum = 'TA2080128';

--Answers for Question 3
SELECT id 
FROM venues 
WHERE capacity > 2000;

--Answers for Question 4
--Step1. Get person_id of Domhog Kiwter, which is 71
SELECT id 
FROM people 
WHERE name = 'Domhog Kiwter';
--Step2. Get the date from purchases table, using the person_id
SELECT date 
FROM purchases 
WHERE person_id = 71;

--Answers for Question 5
--Step1. Get the venue_id of all the venues that have capacity greater than 2000, which is 3
SELECT id 
FROM venues 
WHERE capacity > 2000;
--Step2. Get all the band_id that held performances at the venue with id 3
--The result is a list: (11,16,22,23,30,48,11,55,22,16,55,23,30,100,108,48)
SELECT band_id 
FROM performances 
WHERE venue_id = 3;
--Step3. Find all the band name with those band_id in the above list
SELECT name 
FROM bands 
WHERE id IN(11,16,22,23,30,48,11,55,22,16,55,23,30,100,108,48)
order by name;