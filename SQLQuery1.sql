select * from portfolio_project..deaths

select * from portfolio_project..vaccination

select location, date, population, total_cases, total_deaths 
from portfolio_project..deaths
where location like '%india'

--Death Percentage in India

select location, date, population, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
from portfolio_project..deaths
where location like '%india'

--Infected Percentage in India

select location, date, population, total_cases, total_deaths, (total_cases/population)*100 as InfectedPercentage,
(total_deaths/total_cases)*100 as DeathPercentage from portfolio_project..deaths
where location like '%india'
order by 1,2

--Highest Infected Rate Compared to Poplation

select location, population, max(total_cases) as HighestInfectedCount, max(total_cases/population)*100 as InfectedPercentage,
max(total_deaths/total_cases)*100 as DeathPercentage from portfolio_project..deaths
group by location, population
order by InfectedPercentage 

--Highest Death Count location wise

select location, max(total_deaths) as HighestDeathCount, max(total_cases/population)*100 as InfectedPercentage,
max(total_deaths/total_cases)*100 as DeathPercentage from portfolio_project..deaths
where continent is not null
group by location
order by HighestDeathCount desc

--Highest DeathCount Continent Wise

select continent, max(total_deaths) as HighestDeathCount
from portfolio_project..deaths
where continent is not null
group by continent
order by HighestDeathCount desc


--Global Numbers

select sum(new_cases) as total_cases , sum(cast(new_deaths as int)) as total_deaths, sum(cast(new_deaths as int))/ sum(new_cases) as DeathPercentage
from portfolio_project..deaths
where continent is not null
order by 1,2
   
-- Joining two tables

select *
from portfolio_project..deaths dea
join portfolio_project..vaccination vac
	on dea.location = vac.location
	and  dea.date = vac.date
where dea.continent is not null

--Total Populations vs Vaccinations

select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
from portfolio_project..deaths dea
join portfolio_project..vaccination vac
	on dea.location = vac.location
	and  dea.date = vac.date
where dea.continent is not null


select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
sum(convert(int,vac.new_vaccinations)) over (partition by dea.location order by dea.location,
dea.date) as RollingVaccination
from portfolio_project..deaths dea
join portfolio_project..vaccination vac
	on dea.location = vac.location
	and  dea.date = vac.date
where dea.continent is not null
order by 2,3






