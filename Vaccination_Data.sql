USE [PortfolioProject];

/*filename: Focusing on Vaccination Data
description: 
*/

SELECT * FROM [PortfolioProject]..CovidVaccinations;


/* Looking at Total Population vs Vacciantions

-- we did a rolling count per country, 
	where there a certain number of people vaccinated for a certain number of new vaccination cases

-- we then check how many people from the population actually vaccinated
*/
SELECT 
	c_dea.continent, 
	c_dea.location,
	c_dea.date,
	c_dea.population,
	c_vac.new_vaccinations,

SUM(CAST(COALESCE(c_vac.new_vaccinations, 0) AS bigint))
OVER (PARTITION BY c_dea.location
	ORDER BY c_dea.location, c_dea.date) as rolling_people_vaccinated

FROM [PortfolioProject]..CovidDeaths as c_dea
JOIN [PortfolioProject]..CovidVaccinations as c_vac
ON c_dea.location = c_vac.location 
	AND c_dea.date = c_vac.date

WHERE c_dea.continent IS NOT NULL
ORDER BY 2, 3;



