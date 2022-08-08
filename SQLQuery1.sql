Select *
From PortfolioProject..CovidDeaths$
WHERE continent is not null
Order by 3,4

--Select *
--From PortfolioProject..CovidVaccinations$

--Looking at TOTAL CASES vs TOTAL DEATHS
Select location, date, total_cases,total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
From PortfolioProject..CovidDeaths$
Where location = 'Australia'
Order By 1,2

--Looking at TOTAL CASES vs POPULATION
--Showing what percentage of population got Covid

Select location,date,population, total_cases, (total_cases/population)*100 as TotalcasesPercentage
From PortfolioProject..CovidDeaths$
--Where location = 'Australia'
ORDER BY 1,2

--Looking at countries with highest infection rate compared to population
Select location,population, MAX(total_cases) AS HighestInfectionCount , MAX((total_cases/population))*100 AS PercentagePopulationInfected
FROM PortfolioProject..CovidDeaths$
GROUP BY location, population
ORDER BY PercentagePopulationInfected DESC

--Showing countries with highest death count per population
SELECT location,MAX(CAST(total_deaths AS INT)) AS TotalDeathCount
FROM PortfolioProject..CovidDeaths$
GROUP BY location
ORDER BY TotalDeathCount DESC
-- After running the above queries, locations such as Asia, Europe and Lower middle income appeared which they shouldn't as they are not countries but continent.
--so we have to put WHERE continent IS NOT NULL. We have to go back and put WHERE continent IS NOT NULL to all above queries. 

SELECT location,MAX(CAST(total_deaths AS INT)) AS TotalDeathCount
FROM PortfolioProject..CovidDeaths$
WHERE continent IS NOT NULL
GROUP BY location
ORDER BY TotalDeathCount DESC

--Let's break things down by continent
SELECT location,MAX(CAST(total_deaths AS INT)) AS TotalDeathCount
FROM PortfolioProject..CovidDeaths$
WHERE continent IS NULL and location not like '%income%' and location not like '%national%'
GROUP BY location
ORDER BY TotalDeathCount DESC

SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
FROM PortfolioProject..CovidDeaths$  dea
JOIN PortfolioProject..CovidVaccinations$  vac
	ON dea.location = vac.location
	and dea.date = vac.date
WHERE dea.continent IS NOT NULL
ORDER BY 2,3