USE [PortfolioProject];

SELECT * FROM CovidDeaths;
SELECT * FROM CovidVaccinations;

SELECT location, date, population, total_cases, new_cases, total_deaths
FROM CovidDeaths;


/*Looking at Total Cases vs Total Deaths:
	-- for a certain number of cases there are certain number of deaths, showed in percentage;
		therefore shows likelihood of passing away if you contract covid now*/

SELECT location, 
	date, 
	total_cases, 
	total_deaths, 
	(total_deaths/NULLIF(total_cases, 0)) * 100 as death_percentage
FROM CovidDeaths
WHERE location like '%south africa%';


/*Looking at Total cases vs population:
	--	shows what percentage of population got covid
*/

SELECT location, 
	date, 
	population, 
	total_cases, 
	(total_cases/NULLIF(population, 0)) * 100 as percentage_of_population_infected
FROM CovidDeaths
WHERE location like '%south africa%';


/*Looking at countries with highest infection rate compared to population*/
SELECT location, 
	date, 
	population, 
	MAX(total_cases) as highest_infection_count, 
	(MAX(total_cases)/NULLIF(population, 0)) * 100 as percentage_of_population_infected
FROM CovidDeaths
WHERE location like '%south africa%'
GROUP BY location, date, population;


/*Showing countries with highest death count per population*/
SELECT location, 
	date, 
	population, 
	MAX(cast(total_deaths as int)) as total_death_count 
FROM CovidDeaths
WHERE location like '%south africa%'
GROUP BY location, date, population;


/*showing by continents for drill down*/
SELECT continent, 
	date, 
	population, 
	MAX(cast(total_deaths as int)) as total_death_count 
FROM CovidDeaths
--WHERE location like '%south africa%'
WHERE continent IS NOT NULL
GROUP BY continent, date, population;


/*exploring global numbers*/
SELECT date,
	SUM(new_cases),
	SUM(CAST(new_deaths as int)),
	SUM(CAST(new_deaths as int))/SUM(new_cases) * 100 as deathPercentage
FROM CovidDeaths
WHERE continent IS NOT NULL
GROUP BY date;

