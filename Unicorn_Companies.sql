SELECT *
FROM [dbo].[Unicorn_Companies]


-- the top Unicorn companies and the year they were founded

SELECT Company, MAX(Valuation) AS Valuation, Industry, Year_Founded
FROM [dbo].[Unicorn_Companies]
GROUP BY Company, Industry, Year_Founded
ORDER BY Valuation 


-- all the Unicorn companies in the Unitaed States 


SELECT Company, Country, Industry, Valuation, Year_Founded
FROM [dbo].[Unicorn_Companies]
WHERE Country LIKE '%tate%'


--for recheck
SELECT *
FROM [dbo].[Unicorn_Companies]

-- all the Unicorn companies in the Unitaed States that are in the Internet software & services


SELECT Company, Country, Industry, Valuation, Year_Founded, Funding
FROM [dbo].[Unicorn_Companies]
WHERE Country LIKE '%tate%' And Industry = 'Internet software & services'


-- Top unicorn companies with largest funding

SELECT Company, Country, Industry, Funding, Year_Founded
FROM [dbo].[Unicorn_Companies]
WHERE Funding <>'Unknown'
ORDER BY Funding DESC

/* this didn't give me what I needed because the data type is a nuvarchar, which means that
it contains both numeric and variable character, but it still contains the companies and their funding.
this is due to large amount of money, so it's an error from the table*/



--for recheck
SELECT *
FROM [dbo].[Unicorn_Companies]

/* largest mobile & telecommunications industry in the asian continent 
that were founded in 2020 during the lockdown and their valuation */

SELECT Company, Country, Continent, Industry, Valuation, Year_Founded, Funding 
FROM [dbo].[Unicorn_Companies]
WHERE Continent ='Asia' AND Industry = 'Mobile & telecommunications'
ORDER BY Valuation DESC
-- China is the leading Asian country with $7B in Valuation


-- Top new Unicorn companies in the United States that were founded in 2021

SELECT Company, Country, Industry, Valuation, Year_Founded, Funding
FROM [dbo].[Unicorn_Companies]
WHERE Country LIKE '%tate%' And Year_Founded = '2021'

-- Yuga Labs leads with a Valuation of $4B and was founded in 2021, what a speed!



-- all fintech industries in the United states

SELECT Company, Country, Industry, Valuation, Year_Founded, Funding
FROM [dbo].[Unicorn_Companies]
WHERE Country LIKE '%tate%' AND Industry ='Fintech'


--for recheck
SELECT *
FROM [dbo].[Unicorn_Companies]



-- Country with the highest valuation in the Cybersecurity

SELECT Company, Country, Industry, Valuation, Year_Founded, Funding
FROM [dbo].[Unicorn_Companies]
WHERE Industry ='Cybersecurity'


-- company with the highest valuation in artificial intelligence, and country it is located

SELECT Company, Country, Industry, Valuation, Year_Founded, Funding
FROM [dbo].[Unicorn_Companies]
WHERE Industry ='Artificial intelligence'
--Bytedance leads with a market valuation of $180B and is located in China



-- Europes largest fintech company and the year it was founded 
SELECT Company, Country, Industry, Valuation, Year_Founded, Funding
FROM [dbo].[Unicorn_Companies]
WHERE Continent = 'Europe' AND Industry ='Fintech'
--Klama which is a Swedish country leads  with amrket valuation of $46B and funding of $4B


--for recheck
SELECT *
FROM [dbo].[Unicorn_Companies]

-- all health companies in Seoul, Beijing, Palo Alto, Paris, San Francisco

SELECT Company, Country, City, Industry, Valuation, Year_Founded, Funding
FROM [dbo].[Unicorn_Companies]
WHERE City IN ('Seoul', 'Beijing', 'Palo Alto', 'Paris', 'San Francisco') And Industry ='Health'
--Doctolib in France, Paris leads with a market Valuation of $6B and $815M in funding 



--North Americas most valued company

SELECT Company, Continent, Country, City, Industry, Valuation, Year_Founded, Funding
FROM [dbo].[Unicorn_Companies]
WHERE Continent = 'North America'
-- Elon Musk SpaceX is North Americas most valued company


-- Africas largest fintech company

SELECT Company, Continent, Country, City, Industry, Valuation, Year_Founded, Funding
FROM [dbo].[Unicorn_Companies]
WHERE Continent = 'Africa' AND Industry = 'Fintech'
--Flutterwave is Africas most largest fintech company with market valuation of $2B


-- country with the largest Edtech company as industry in valuation

SELECT Company, Continent, Country, City, Industry, Valuation, Year_Founded, Funding
FROM [dbo].[Unicorn_Companies]
WHERE Industry = 'Edtech'
--India has largest Edtech company with valuation of $22B

--for recheck
SELECT *
FROM [dbo].[Unicorn_Companies]


--total count of unicorn founded in the year 2020 during the lockdown

SELECT 
COUNT(*) number_of_unicorn_founded,
Country
FROM [dbo].[Unicorn_Companies]
WHERE Year_Founded='2020' AND Industry = 'Fintech'
GROUP BY Country





