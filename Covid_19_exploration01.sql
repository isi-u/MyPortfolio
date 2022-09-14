SELECT *
FROM [dbo].[CovidDeath]

--checking the data to be used for exploration

SELECT location, date, total_cases, new_cases, total_deaths, population
FROM [dbo].[CovidDeath]
ORDER BY 1,2


-- lookind at the ratio of total death for total cases
SET ARITHABORT OFF;
SET ANSI_WARNINGS OFF; --This piece of query turns off the error message encountered by a zero division

--CHECKING GENERAL DEATH PERCENTAGE
SELECT location, date, total_cases, total_deaths, (CONVERT(FLOAT, total_deaths))/(CONVERT(FLOAT, total_cases)) * 100 AS Death_Percentage
FROM [dbo].[CovidDeath]
--WHERE location LIKE '%igeria'
ORDER BY 1,2

SELECT location, date, total_cases, total_deaths, (CONVERT(FLOAT, total_deaths))/(CONVERT(FLOAT,total_cases)) * 100 AS Death_Percentage
FROM [dbo].[CovidDeath]
WHERE location LIKE '%igeria'
ORDER BY 1,2
--was checking for my country Nigeria




/* Countries with the highest infection count to population which is the infection rate for all population */

SELECT location, population, MAX(total_cases) Highest_infection_count,
MAX(CONVERT(FLOAT, total_cases)/(population)) * 100 AS Percent_population_infected
FROM [dbo].[CovidDeath]
GROUP BY location, population
ORDER BY Percent_population_infected DESC


--checking for Nigeria
SELECT location, population, MAX(total_cases) Highest_infection_count,
MAX(CONVERT(FLOAT, total_cases)/(population)) * 100 AS Percent_population_infected
FROM [dbo].[CovidDeath]
WHERE location LIKE '%igeria'
GROUP BY location, population
ORDER BY Percent_population_infected 


--for recheck
SELECT *
FROM [dbo].[CovidDeath]


--Countries with highest death count per population


SELECT location, MAX(CAST(total_deaths AS INT)) Total_death_count
FROM [dbo].[CovidDeath]
WHERE continent IS NOT NULL
GROUP BY location
ORDER BY Total_death_count DESC

--This didn't work as intended, this means that this data has been highly mutilated


--total death by continent

SELECT continent, MAX(CAST(total_deaths AS INT)) Total_death_count
FROM [dbo].[CovidDeath]
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY Total_death_count DESC



--GLOBALLY

--CHECKING GENERAL DEATH PERCENTAGE
SELECT  date, SUM(CAST(new_cases AS INT)) Total_cases, SUM(CAST(new_deaths AS INT)) Total_deaths,
(SUM(CAST(new_deaths AS INT))/SUM(CAST(new_cases AS INT))) * 100 AS Global_Death_Percentage
FROM [dbo].[CovidDeath]
WHERE continent IS NOT NULL
GROUP BY date
ORDER BY 1,2


--for recheck
SELECT *
FROM [dbo].[CovidDeath]


--looking at total population vs vaccinations 

SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, SUM(CONVERT(INT,vac.new_vaccinations))
OVER (PARTITION BY dea.location, dea.date) Rolling_count_vaccinated
FROM [dbo].[CovidDeath] dea
JOIN [dbo].[CovidVaccinations] vac
    ON dea.location = vac.location
	AND dea.date= vac.date
WHERE dea.continent IS NOT NULL
ORDER  BY 2,3


--Use CTE 

WITH PopvsVac (continent, location, date, population, new_vaccinations, Rolling_count_vaccinated) 
AS
(
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, SUM(CONVERT(INT,vac.new_vaccinations))
OVER (PARTITION BY dea.location, dea.date) Rolling_count_vaccinated
FROM [dbo].[CovidDeath] dea
JOIN [dbo].[CovidVaccinations] vac
    ON dea.location = vac.location
	AND dea.date= vac.date
WHERE dea.continent IS NOT NULL
--ORDER  BY 2,3
)

SELECT *, (Rolling_count_vaccinated/population)*100 AS Percent_population_vaccinated
FROM PopvsVac
--cte runs


--Creating view for my visualization

CREATE VIEW TotalDeathCount AS
SELECT continent, MAX(CAST(total_deaths AS INT)) Total_death_count
FROM [dbo].[CovidDeath]
WHERE continent IS NOT NULL
GROUP BY continent
--ORDER BY Total_death_count DESC

SELECT *
FROM TotalDeathCount