-- covidvaccinations
-- loading data into covidvaccinations

select * from covidvaccinations;
truncate table covid.covidvaccinations;
desc covid.covidvaccinations;

LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/CovidVaccinations.csv"
INTO TABLE covid.covidvaccinations
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

update covidvaccinations
set continent = null
where continent = '';

update covidvaccinations
set date = str_to_date(date, '%m/%d/%Y');

alter table covidvaccinations
modify column date date;

update covidvaccinations
set total_tests = null
where total_tests = '';

alter table covidvaccinations
modify column total_tests bigint;

select min(total_tests), max(total_tests)
from covidvaccinations;

update covidvaccinations
set new_tests = null
where new_tests = '';

alter table covidvaccinations
modify column new_tests int;

update covidvaccinations
set covidvaccinations.total_tests_per_thousand = null
where covidvaccinations.total_tests_per_thousand = '';

alter table covidvaccinations
modify column total_tests_per_thousand double;

update covidvaccinations
set covidvaccinations.new_tests_per_thousand = null
where covidvaccinations.new_tests_per_thousand = '';

alter table covidvaccinations
modify column new_tests_per_thousand double;

update covidvaccinations
set covidvaccinations.new_tests_smoothed = null
where covidvaccinations.new_tests_smoothed = '';

alter table covidvaccinations
modify column new_tests_smoothed int;

update covidvaccinations
set covidvaccinations.new_tests_smoothed_per_thousand = null
where covidvaccinations.new_tests_smoothed_per_thousand = '';

alter table covidvaccinations
modify column new_tests_smoothed_per_thousand double;

update covidvaccinations
set covidvaccinations.positive_rate = null
where covidvaccinations.positive_rate = '';

alter table covidvaccinations
modify column positive_rate double;

update covidvaccinations
set covidvaccinations.tests_per_case = null
where covidvaccinations.tests_per_case = '';

alter table covidvaccinations
modify column tests_per_case double;

select distinct tests_units
from covidvaccinations;

update covidvaccinations
set tests_units = null
where tests_units = '';

update covidvaccinations
set covidvaccinations.total_vaccinations = null
where covidvaccinations.total_vaccinations = '';

alter table covidvaccinations
modify column total_vaccinations bigint;

update covidvaccinations
set covidvaccinations.people_vaccinated = null
where covidvaccinations.people_vaccinated = '';

alter table covidvaccinations
modify column people_vaccinated bigint;

select distinct positive_rate
from covidvaccinations;

update covidvaccinations
set covidvaccinations.people_fully_vaccinated = null
where covidvaccinations.people_fully_vaccinated = '';

alter table covidvaccinations
modify column people_fully_vaccinated bigint;

update covidvaccinations
set covidvaccinations.total_boosters = null
where covidvaccinations.total_boosters = '';

alter table covidvaccinations
modify column total_boosters bigint;

update covidvaccinations
set covidvaccinations.new_vaccinations = null
where covidvaccinations.new_vaccinations = '';

alter table covidvaccinations
modify column new_vaccinations int;

update covidvaccinations
set covidvaccinations.new_vaccinations_smoothed = null
where covidvaccinations.new_vaccinations_smoothed = '';

alter table covidvaccinations
modify column new_vaccinations_smoothed int;

update covidvaccinations
set covidvaccinations.total_vaccinations_per_hundred = null
where covidvaccinations.total_vaccinations_per_hundred = '';

alter table covidvaccinations
modify column total_vaccinations_per_hundred double;

update covidvaccinations
set covidvaccinations.people_vaccinated_per_hundred = null
where covidvaccinations.people_vaccinated_per_hundred = '';

alter table covidvaccinations
modify column people_vaccinated_per_hundred double;

update covidvaccinations
set covidvaccinations.people_fully_vaccinated_per_hundred = null
where covidvaccinations.people_fully_vaccinated_per_hundred = '';

alter table covidvaccinations
modify column people_fully_vaccinated_per_hundred double;

update covidvaccinations
set covidvaccinations.total_boosters_per_hundred = null
where covidvaccinations.total_boosters_per_hundred = '';

alter table covidvaccinations
modify column total_boosters_per_hundred double;

update covidvaccinations
set covidvaccinations.new_vaccinations_smoothed_per_million = null
where covidvaccinations.new_vaccinations_smoothed_per_million = '';

alter table covidvaccinations
modify column new_vaccinations_smoothed_per_million int;

update covidvaccinations
set covidvaccinations.new_people_vaccinated_smoothed = null
where covidvaccinations.new_people_vaccinated_smoothed = '';

alter table covidvaccinations
modify column new_people_vaccinated_smoothed int;

update covidvaccinations
set covidvaccinations.new_people_vaccinated_smoothed_per_hundred = null
where covidvaccinations.new_people_vaccinated_smoothed_per_hundred = '';

alter table covidvaccinations
modify column new_people_vaccinated_smoothed_per_hundred double;

update covidvaccinations
set covidvaccinations.stringency_index = null
where covidvaccinations.stringency_index = '';

alter table covidvaccinations
modify column stringency_index double;

update covidvaccinations
set covidvaccinations.population_density = null
where covidvaccinations.population_density = '';

alter table covidvaccinations
modify column population_density double;

update covidvaccinations
set covidvaccinations.median_age = null
where covidvaccinations.median_age = '';

alter table covidvaccinations
modify column median_age double;

update covidvaccinations
set covidvaccinations.aged_65_older = null
where covidvaccinations.aged_65_older = '';

alter table covidvaccinations
modify column aged_65_older double;

update covidvaccinations
set covidvaccinations.aged_70_older = null
where covidvaccinations.aged_70_older = '';

alter table covidvaccinations
modify column aged_70_older double;

update covidvaccinations
set covidvaccinations.gdp_per_capita = null
where covidvaccinations.gdp_per_capita = '';

alter table covidvaccinations
modify column gdp_per_capita double;

update covidvaccinations
set covidvaccinations.extreme_poverty = null
where covidvaccinations.extreme_poverty = '';

alter table covidvaccinations
modify column extreme_poverty double;

update covidvaccinations
set covidvaccinations.cardiovasc_death_rate = null
where covidvaccinations.cardiovasc_death_rate = '';

alter table covidvaccinations
modify column cardiovasc_death_rate double;

update covidvaccinations
set covidvaccinations.diabetes_prevalence = null
where covidvaccinations.diabetes_prevalence = '';

alter table covidvaccinations
modify column diabetes_prevalence double;

update covidvaccinations
set covidvaccinations.female_smokers = null
where covidvaccinations.female_smokers = '';

alter table covidvaccinations
modify column female_smokers double;

update covidvaccinations
set covidvaccinations.male_smokers = null
where covidvaccinations.male_smokers = '';

alter table covidvaccinations
modify column male_smokers double;

update covidvaccinations
set covidvaccinations.female_smokers = null
where covidvaccinations.female_smokers = '';

alter table covidvaccinations
modify column female_smokers double;

update covidvaccinations
set covidvaccinations.handwashing_facilities = null
where covidvaccinations.handwashing_facilities = '';

alter table covidvaccinations
modify column handwashing_facilities double;

update covidvaccinations
set covidvaccinations.hospital_beds_per_thousand = null
where covidvaccinations.hospital_beds_per_thousand = '';

alter table covidvaccinations
modify column hospital_beds_per_thousand double;

update covidvaccinations
set covidvaccinations.life_expectancy = null
where covidvaccinations.life_expectancy = '';

alter table covidvaccinations
modify column life_expectancy double;

update covidvaccinations
set covidvaccinations.human_development_index = null
where covidvaccinations.human_development_index = '';

alter table covidvaccinations
modify column human_development_index double;

update covidvaccinations
set covidvaccinations.excess_mortality_cumulative_absolute = null
where covidvaccinations.excess_mortality_cumulative_absolute = '';

alter table covidvaccinations
modify column excess_mortality_cumulative_absolute double;

update covidvaccinations
set covidvaccinations.excess_mortality_cumulative = null
where covidvaccinations.excess_mortality_cumulative = '';

alter table covidvaccinations
modify column excess_mortality_cumulative double;

update covidvaccinations
set covidvaccinations.excess_mortality = null
where covidvaccinations.excess_mortality = '';

alter table covidvaccinations
modify column excess_mortality double;

update covidvaccinations
set covidvaccinations.excess_mortality_cumulative_per_million = null
where covidvaccinations.excess_mortality_cumulative_per_million = '';

alter table covidvaccinations
modify column excess_mortality_cumulative_per_million double;

-- basic queries
select * from covidvaccinations;

-- primary key in covidvaccinations
select distinct location, date
from covidvaccinations;

-- join deaths and vaccinations data
select *
from coviddeaths cd
join covidvaccinations cv
on cd.location = cv.location
and cd.date = cv.date;

-- looking at population vs. vaccinations

-- global numbers
-- how much people atleast got first dose of vaccination globally
select cd.location, cd.population, max(cv.total_vaccinations) as totalDosesOperated, max(cv.people_vaccinated) as PeopleVaccinated,
max(cv.people_vaccinated) / cd.population * 100 PeopleVaccinatedPercentage
from coviddeaths cd
join covidvaccinations cv
on cd.location = cv.location
and cd.date = cv.date
where cd.location like 'world';

select distinct location
from coviddeaths;

-- low-income countries
-- at least first dose given
select cd.location, cd.population, max(cv.people_vaccinated) as PeopleVaccinated,
max(cv.people_vaccinated) / cd.population * 100 PeopleVaccinatedPercentage
from coviddeaths cd
join covidvaccinations cv
on cd.location = cv.location
and cd.date = cv.date
where cd.location like 'low income';

-- running new vaccines
with Population_vs_Vaccinations (Continent, Location, Date, Population, New_Vaccinations, Cum_New_Vaccinations)
as (
	select cd.continent, cd.location, cd.date, cd.population, cv.new_vaccinations,
	sum(cv.new_vaccinations)
	over(partition by cv.continent, cv.location
		 order by cv.date
		 rows between unbounded preceding and current row) as cumulative_new_vaccinations
	from coviddeaths cd
	join covidvaccinations cv
	on cd.location = cv.location
	and cd.date = cv.date
	where cd.continent is not null
)
select Continent, Location, Population, max(Cum_New_Vaccinations) as Total_New_Vaccines,
max(Cum_New_Vaccinations)/ Population * 100
from Population_vs_Vaccinations
group by Continent, Location
order by 1, 2;


-- assuming all new vaccines are used for population (new_vaccines = more_people_vaccinated)
with Population_vs_Vaccinations (Continent, Location, Date, Population, PeopleVaccinated, RollingPeopleVaccinated)
as (
	select cd.continent, cd.location, cd.date, cd.population, cv.new_vaccinations,
	sum(cv.new_vaccinations)
	over(partition by cv.continent, cv.location
		 order by cv.date
		 rows between unbounded preceding and current row) as cumulative_new_vaccinations
	from coviddeaths cd
	join covidvaccinations cv
	on cd.location = cv.location
	and cd.date = cv.date
	where cd.continent is not null
)
select *, RollingPeopleVaccinated / Population * 100 `Percent People Vaccinated`
from Population_vs_Vaccinations
order by 2, 3;

-- total vaccines per country
select cd.continent, cd.location, cd.population, max(cv.total_vaccinations) as 'total doses'
from coviddeaths cd
join covidvaccinations cv
on cd.location = cv.location
and cd.date = cv.date
where cd.continent is not null
group by cd.location
order by 1, 2, 3;

-- Temp Table
drop table if exists `% People Vaccinated`;
create table `% People Vaccinated` (
	Continent text,
    Location text,
    Date date,
    Population bigint,
    New_Vaccinations bigint,
    RollingPeopleVaccinated bigint
);

insert into `% People Vaccinated`
select cd.continent, cd.location, cd.date, cd.population, cv.new_vaccinations,
sum(cv.new_vaccinations)
over(partition by cv.continent, cv.location
     order by cv.date)
from coviddeaths cd
join covidvaccinations cv
on cd.location = cv.location
and cd.date = cv.date
where cd.continent is not null;

select *, RollingPeopleVaccinated / Population * 100
from `% People Vaccinated`
order by 1, 2, 3;


-- Creating Views to Store Data for later Visualizations

drop view if exists `People Vaccinated by Country and Date`;
create view `People Vaccinated by Country and Date` as 
select cd.continent as Continent, cd.location as Location, cd.date as Date, cd.population as Population, 
cv.new_vaccinations as `New Vaccinations`,
sum(cv.new_vaccinations)
over(partition by cv.continent, cv.location
	 order by cv.date
	 rows between unbounded preceding and current row) as `Rolling People Vaccinated`
from coviddeaths cd
join covidvaccinations cv
on cd.location = cv.location
and cd.date = cv.date
where cd.continent is not null;


drop view if exists `Population Vaccinated Globally`;
create view `Population Vaccinated Globally` as
select cd.location as Location, cd.population as Population, max(cv.total_vaccinations) as `Total Doses Operated`,
max(cv.people_vaccinated) as `Total People Vaccinated`,
max(cv.people_vaccinated) / cd.population * 100 as `% People Vaccinated`
from coviddeaths cd
join covidvaccinations cv
on cd.location = cv.location
and cd.date = cv.date
where cd.location like 'world';

drop view if exists `Vaccination in Low Income Nations`;
create view `Vaccination in Low Income Nations` as
select cd.location Location, cd.population Population, max(cv.total_vaccinations) 'Total Doses Administered',
max(cv.people_vaccinated) as `Total People Vaccinated`,
max(cv.people_vaccinated) / cd.population * 100 `% Population Vaccinated`
from coviddeaths cd
join covidvaccinations cv
on cd.location = cv.location
and cd.date = cv.date
where cd.location like 'low income';