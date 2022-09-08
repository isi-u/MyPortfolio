SELECT *
FROM [dbo].[PoliceKillingsUS]


-- this query makes me know the total number of people that was shot.

SELECT DISTINCT(manner_of_death), COUNT(manner_of_death) count_manner_of_death
FROM [dbo].[PoliceKillingsUS]
GROUP BY manner_of_death
HAVING manner_of_death= 'shot' 



/* this clearly shows the number of death by shot which is 2362. */


--another way to write the exact query above but was shot by a gun

SELECT manner_of_death, armed, COUNT(manner_of_death) count_manner_of_death
FROM [dbo].[PoliceKillingsUS]
WHERE manner_of_death = 'shot' AND armed = 'gun'
GROUP BY manner_of_death, armed

/* this clearly shows the number of death by shot with a gun which is 1375. */


-- for recheck
SELECT *
FROM [dbo].[PoliceKillingsUS]


/*this shows the number of police killings that occured on the 4th of July,
which is Americans Independence 2020, with the names of the victims and manner of death
and the arms that was used */


SELECT date, name, manner_of_death, armed
FROM [dbo].[PoliceKillingsUS]
WHERE date = '04/07/15'

/* this shows that four people where shot to death with a gun by the police on the 4th of July 2015*/


--repeating the previous for 2016

SELECT date, name, manner_of_death, armed
FROM [dbo].[PoliceKillingsUS]
WHERE date = '04/07/16'

/* here it can be seen also, that four people where shot, but one of which was a knife,
I can't guess if there are guns that shoots knife or probably a mistake from the dataset*/


-- for recheck
SELECT *
FROM [dbo].[PoliceKillingsUS]

--this shows the victims that were killed, even while they were'nt fleeinng from new york

SELECT date, name, manner_of_death, armed, city, flee
FROM [dbo].[PoliceKillingsUS]
WHERE flee = 'Not fleeing' AND city = 'New York'

/* this shows that from 2016-2017, four people where shot to death and one shot and tasered
by a screw driver, that's so screwed up */


/* to know the total number of people below the age of 33 that
had a positive sign of mental illness from San Francisco */

SELECT date, name, gender, manner_of_death, armed, city, signs_of_mental_illness
FROM [dbo].[PoliceKillingsUS]
WHERE signs_of_mental_illness = 'TRUE' AND city = 'San Francisco' AND age < 33
--this show three people died and a female inclusive


-- for recheck
SELECT *
FROM [dbo].[PoliceKillingsUS]


--the total number of victims that where killed by toy weapon
-- for recheck
SELECT DISTINCT(armed), COUNT (armed) num_of_death_by_toy_weapon
FROM [dbo].[PoliceKillingsUS]
GROUP BY armed
HAVING armed = 'toy weapon'