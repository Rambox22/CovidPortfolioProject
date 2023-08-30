SELECT *
FROM ['Covid Death 1Mar2021-2Mar2023$']


--SELECT *
--FROM ['Covid Vaccine Data1Mar2021-2Mar$']
--Order BY 3,4 

--select the data that we are gonna use

SELECT location, date, total_cases, new_cases, total_deaths
FROM ['Covid Death 1Mar2021-2Mar2023$']
order by 1,2

--looking at total cases vs total deaths

SELECT location, date, total_cases, new_cases, total_deaths , (CONVERT(float, total_deaths) / NULLIF(CONVERT(float, total_cases), 0))*100 as DeathPercentage
FROM ['Covid Death 1Mar2021-2Mar2023$']

order by 3,5


--Looking at the countries with the highest rate

SELECT location, population_density, MAX(total_cases) as HighestInfectionCount, MAX(total_cases/population_density)*100 as PercentagePopulationInfected

from ['Covid Death 1Mar2021-2Mar2023$']

Group by location, population_density
order by PercentagePopulationInfected DESC


--Break down things by continent

Select location, MAX(cast(total_deaths as int)) as totaldeathcount
from ['Covid Death 1Mar2021-2Mar2023$']
where continent is not null
Group by location 
order by totaldeathcount DESC

--join command

SELECT dea.continent, dea.location, dea.date, dea.population_density, vac.new_vaccinations
, SUM(CONVERT(int , vac.new_vaccinations)) OVER (Partition by dea.location order by dea.location, dea.Date) as RollingPeopleVaccinated
FROM ['Covid Death 1Mar2021-2Mar2023$'] as dea

JOIN ['Covid Vaccine Data1Mar2021-2Mar$'] as vac
on dea.location = vac.location
and dea.date = vac.date
order by 1,2,3




