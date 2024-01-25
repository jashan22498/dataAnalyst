create database covid;
show databases;
use covid;

desc covid.coviddeaths;

-- loading data into coviddeaths
LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/CovidDeaths.csv"
INTO TABLE covid.coviddeaths
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

SHOW VARIABLES LIKE "secure_file_priv";

truncate table coviddeaths;
select * from coviddeaths;

-- data cleaning
update coviddeaths
set continent = null
where continent = '';

select * from coviddeaths
where continent is null;

select * from coviddeaths
where date = '';

update coviddeaths
set date = str_to_date(date, '%m/%d/%Y');

alter table coviddeaths
modify column date date;

alter table coviddeaths
modify column population bigint;

select min(population) as minPop, max(population) as maxPop
from coviddeaths;

update coviddeaths
set total_cases = null
where total_cases = '';

alter table coviddeaths
modify column total_cases int;

update coviddeaths
set new_cases = null
where new_cases = '';

alter table coviddeaths
modify column new_cases int;

update coviddeaths
set new_cases_smoothed = null
where new_cases_smoothed = '';

alter table coviddeaths
modify column new_cases_smoothed double;

update coviddeaths
set total_deaths = null
where total_deaths = '';

alter table coviddeaths
modify column total_deaths int;

update coviddeaths
set new_deaths = null
where new_deaths = '';

alter table coviddeaths
modify column new_deaths int;

update coviddeaths
set new_deaths_smoothed = null
where new_deaths_smoothed = '';

alter table coviddeaths
modify column new_deaths_smoothed double;

update coviddeaths
set coviddeaths.total_cases_per_million = null
where coviddeaths.total_cases_per_million = '';

alter table coviddeaths
modify column total_cases_per_million double;

update coviddeaths
set coviddeaths.new_cases_per_million = null
where coviddeaths.new_cases_per_million = '';

alter table coviddeaths
modify column new_cases_per_million double;

update coviddeaths
set coviddeaths.new_cases_smoothed_per_million = null
where coviddeaths.new_cases_smoothed_per_million = '';

alter table coviddeaths
modify column new_cases_smoothed_per_million double;

update coviddeaths
set total_deaths_per_million = null
where total_deaths_per_million = '';

alter table coviddeaths
modify column total_deaths_per_million double;

update coviddeaths
set new_deaths_per_million = null
where new_deaths_per_million = '';

alter table coviddeaths
modify column new_deaths_per_million double;

update coviddeaths
set new_deaths_smoothed_per_million = null
where new_deaths_smoothed_per_million = '';

alter table coviddeaths
modify column new_deaths_smoothed_per_million double;

update coviddeaths
set reproduction_rate = null
where reproduction_rate = '';

alter table coviddeaths
modify column reproduction_rate double;

update coviddeaths
set icu_patients = null
where icu_patients = '';

alter table coviddeaths
modify column icu_patients int;

update coviddeaths
set icu_patients_per_million = null
where icu_patients_per_million = '';

alter table coviddeaths
modify column icu_patients_per_million double;

update coviddeaths
set hosp_patients = null
where hosp_patients = '';

alter table coviddeaths
modify column hosp_patients int;

update coviddeaths
set hosp_patients_per_million = null
where hosp_patients_per_million = '';

alter table coviddeaths
modify column hosp_patients_per_million double;

update coviddeaths
set coviddeaths.weekly_icu_admissions = null
where coviddeaths.weekly_icu_admissions = '';

alter table coviddeaths
modify column weekly_icu_admissions int;

update coviddeaths
set coviddeaths.weekly_icu_admissions_per_million = null
where coviddeaths.weekly_icu_admissions_per_million = '';

alter table coviddeaths
modify column weekly_icu_admissions_per_million double;

update coviddeaths
set coviddeaths.weekly_hosp_admissions = null
where coviddeaths.weekly_hosp_admissions = '';

alter table coviddeaths
modify column weekly_hosp_admissions int;

update coviddeaths
set coviddeaths.weekly_hosp_admissions_per_million = null
where coviddeaths.weekly_hosp_admissions_per_million = '';

alter table coviddeaths
modify column weekly_hosp_admissions_per_million double;


-- basic queries

desc coviddeaths;
select * from coviddeaths;

select * from coviddeaths
order by 3, 4;

select date, year(date)
from coviddeaths;

select new_cases_smoothed
from coviddeaths
order by 1;

-- primary key
select distinct iso_code, continent, location, date
from coviddeaths;

-- selecting data to be used
select location, date, total_cases, new_cases, total_deaths, population
from coviddeaths
order by 1, 2;

select distinct location
from coviddeaths;

-- looking at total cases vs. total deaths

select location, date, total_cases, total_deaths, total_deaths / total_cases * 100 as DeathPercentage
from coviddeaths
order by 1, 2;

-- shows chances of dying if you contract covid in india
select location, date, total_cases, total_deaths, total_deaths / total_cases * 100 as DeathPercentage
from coviddeaths
where location like 'india' and total_deaths / total_cases * 100 is not null
order by 1, 2;

-- looking at total cases vs. population
select location, date, total_cases, population, total_cases / population * 100 as InfectedPercent
from coviddeaths
where total_cases / population * 100 is not null and location like 'india'
order by 1, 2;


-- looking at countries with the highest infection rates compared to population

select location, count(distinct population)
from coviddeaths
group by location;

select location, population
from coviddeaths
group by location;

-- using group by and agg. function
select location, population, max(total_cases) as HighestInfectionCount, max(total_cases / population * 100) as MaxPercentPopulationInfected
from coviddeaths
group by location
order by 4 desc;

-- using cte and window function
with cte as (
	select location, date, total_cases, population, total_cases / population * 100 as InfectedPercent,
	row_number() over(partition by location order by total_cases / population * 100 desc) as rn
	from coviddeaths
	where total_cases / population * 100 is not null
)
select *
from cte
where rn = 1
order by 5 desc;

-- Showing Countries with the highest Death Count per Population
select location, population, max(total_deaths) as HighestDeathCount, max(total_deaths) / population * 100 as MaxPercentPopulationDied
from coviddeaths
where continent is not null
group by location
order by 4 desc;

select location, max(total_deaths) as TotalDeathCount
from coviddeaths
where continent is not null
group by location
order by 2 desc;

select distinct continent
from coviddeaths;

select *
from coviddeaths
where continent is not null
order by continent, location;


-- Grouping data by Continent
select continent, location, max(total_deaths) as TotalDeathCount
from coviddeaths
where continent is not null
group by continent, location
order by 1, 2;

-- deaths per continent
with deathsPerCont as (
	select continent, location, max(total_deaths) as DeathCount
	from coviddeaths
	where continent is not null
	group by continent, location
)
select continent, sum(DeathCount) as TotalDeathCount
from deathsPerCont
group by continent
order by 2 desc;

with deathsInEurope as(
	select continent, location, max(total_deaths) as DeathCount
	from coviddeaths
	where continent like 'europe'
	group by location
)
select continent, sum(DeathCount) as TDC
from deathsInEurope;


select location, max(total_deaths) as TotalDeathCount
from coviddeaths
where continent is null
group by location
order by 2 desc;

-- global numbers
select * from coviddeaths;

select location, population, max(total_deaths) as TotalDeaths, max(total_cases) as TotalCases,
max(total_deaths) / max(total_cases) * 100 as DeathPercentage
from coviddeaths
where location like 'world';

select distinct date
from coviddeaths;

select date, sum(new_cases) as total_cases, sum(new_deaths) as total_deaths,
sum(new_deaths) / sum(new_cases) * 100 as DeathPercent
from coviddeaths
where continent is not null
group by date
order by 4 desc;

-- global deaths
select sum(new_cases) as total_cases, sum(new_deaths) as total_deaths,
sum(new_deaths) / sum(new_cases) * 100 as DeathPercentage
from coviddeaths
where continent is not null;

create view `Worldly Deaths and Cases` as
select location, population, max(total_deaths) as TotalDeaths, max(total_cases) as TotalCases,
max(total_deaths) / max(total_cases) * 100 as DeathPercentage
from coviddeaths
where location like 'world';