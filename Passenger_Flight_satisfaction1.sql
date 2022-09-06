--this selects  the entire table

SELECT*
FROM dbo.airline_passenger_satisfaction


-- gender specific count of travel type 

SELECT Gender, Type_of_Travel, COUNT(Type_of_Travel) Type_of_Travel_count
FROM dbo.airline_passenger_satisfaction
GROUP BY Type_of_Travel, Gender
ORDER BY Type_of_Travel_count DESC



-- Total count of customer types


SELECT Customer_Type, COUNT(Customer_Type) Customer_Type_Count
FROM dbo.airline_passenger_satisfaction
GROUP BY Customer_Type
ORDER BY Customer_Type_Count DESC
/* the results gotten here, clearly shows that there are more returning customers than first timers, 
clearly there's more old customers than new ones*/


-- for recheck
SELECT*
FROM dbo.airline_passenger_satisfaction


--sum of travel type for each group using a temp table or cte

WITH Travel_Type_Count AS (
SELECT Gender, Type_of_Travel, COUNT(Type_of_Travel) Type_of_Travel_count
FROM dbo.airline_passenger_satisfaction
GROUP BY  Type_of_Travel, Gender
)
SELECT Type_of_Travel, SUM(Type_of_Travel_count) Sum_Travel_type 
FROM Travel_Type_Count
GROUP BY Type_of_Travel
 

 
-- for recheck
SELECT*
FROM dbo.airline_passenger_satisfaction



--gender specific travel by class


SELECT Gender, Class, COUNT(Class) Class_count
FROM dbo.airline_passenger_satisfaction
GROUP BY Class, Gender
ORDER BY Class_count DESC
/* It is certain that female are most dominant in all the class as they posses a greater passenger count to the men. */

-- total sum of travels by class for both gender using a temp table or with clause or cte

WITH Travel_Class_Count AS (
SELECT Gender, Class, COUNT(Class) Class_count
FROM dbo.airline_passenger_satisfaction
GROUP BY Class, Gender
--ORDER BY Class_count DESC
)

SELECT Class, SUM(Class_count) Class_sum 
FROM Travel_Class_Count
GROUP BY Class
ORDER BY Class_sum  DESC

/* with these, it is seen that a greater number of the passengers fly the business class, 
followed by the economy and the economy plus takes the least*/

-- for recheck
SELECT*
FROM dbo.airline_passenger_satisfaction


-- using the partition by to group the type of travel and class, gender by the gender count


SELECT Type_of_Travel, Class, Gender, 
COUNT(Gender) OVER (PARTITION BY Gender) AS Total_Gender
FROM dbo.airline_passenger_satisfaction

/* the partition by helps to know the exact number or count of gender that took a personal travel type
which was economy, business and economy plus also it makes us the know the exact number or 
count of gender that took a business travel type which was economy, business and economy plus.*/


-- for recheck
SELECT*
FROM dbo.airline_passenger_satisfaction


-- This helps to determine the average flight distance by class

-- for satisfied passengers
SELECT  Class, Type_of_Travel, AVG(Flight_Distance) Average_Flight_Distance
FROM dbo.airline_passenger_satisfaction
WHERE Satisfaction = 'Satisfied'
GROUP BY Class, Type_of_Travel

-- for Neutral or Dissatisfied passengers
SELECT  Class, Type_of_Travel, AVG(Flight_Distance) Average_Flight_Distance
FROM dbo.airline_passenger_satisfaction
WHERE Satisfaction = 'Neutral or Dissatisfied'
GROUP BY Class, Type_of_Travel

--for all the passengers
SELECT  Class, Type_of_Travel, AVG(Flight_Distance) Average_Flight_Distance
FROM dbo.airline_passenger_satisfaction
--WHERE Satisfaction = 'Neutral or Dissatisfied'
GROUP BY Class, Type_of_Travel

/* This helps buttress the point above that the business 
class is the most flown ticket */



-- to know the class and the type of travel taken  by the maximum aged people


SELECT Class,Type_of_Travel, MAX(Age) Maximum_Age
FROM dbo.airline_passenger_satisfaction
GROUP BY Class, Type_of_Travel
HAVING MAX(Age) >= 69
ORDER BY  MAX(Age) DESC
