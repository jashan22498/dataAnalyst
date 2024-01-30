create table usa_housing (
	UniqueID text,
    ParcelID text,
    LandUse text,
    PropertyAddress text,
    SaleDate text,
    SalePrice text,
    LegalReference text,
    SoldAsVacant text,
    OwnerName text,
    OwnerAddress text,
    Acreage text,
    TaxDistrict text,
    LandValue text,
    BuildingValue text,
    TotalValue text,
    YearBuilt text,
    Bedrooms text,
    FullBath text,
    HalfBath text
);

LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Nashville Housing Data.csv"
INTO TABLE usa_housing
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

select * from usa_housing;

alter table usa_housing
modify column UniqueID int;

update usa_housing
set usa_housing.PropertyAddress = null
where usa_housing.PropertyAddress = '';

-- Standardize Date Format
update usa_housing
set SaleDate = str_to_date(SaleDate, '%M %d, %Y');

alter table usa_housing
modify column SaleDate date;

-- Populate Propery Address Data
select *
from usa_housing
where PropertyAddress is null;

select distinct ParcelID
from nashvillehouses;

select u1.ParcelID, u1.PropertyAddress, u2.PropertyAddress
from usa_housing u1
join usa_housing u2
on u1.ParcelID = u2.ParcelID
and u1.PropertyAddress is not null and u2.PropertyAddress is null
order by 1;

-- Fetch Address and City from Property Address
alter table usa_housing
modify column PropertyAddress varchar(50);

select PropertyAddress
from usa_housing;

select PropertyAddress,
substr(PropertyAddress, 1, locate(',', PropertyAddress) - 1) as P_Address,
substring(PropertyAddress, locate(',', PropertyAddress) + 1) as P_City
from usa_housing;

alter table usa_housing
add P_Address varchar(50) after PropertyAddress;

alter table usa_housing
add P_City varchar(50) after P_Address;

update usa_housing
set P_Address = substr(PropertyAddress, 1, locate(',', PropertyAddress) - 1);

update usa_housing
set P_City = substring(PropertyAddress, locate(',', PropertyAddress) + 1);

select PropertyAddress, P_Address, P_City
from usa_housing;

-- fetch unit and street, city, state from Owner Address
alter table usa_housing
modify column OwnerAddress varchar(50);

select OwnerAddress
from usa_housing;

select OwnerAddress,
substr(OwnerAddress, 1, locate(',', OwnerAddress) - 1),
substr(OwnerAddress, locate(',', OwnerAddress) + 2)
from usa_housing;

alter table usa_housing
add O_Address varchar(50) after OwnerAddress;

alter table usa_housing
add O_City varchar(50) after O_Address;

alter table usa_housing
add O_State varchar(50) after O_City;

update usa_housing
set O_Address = substr(OwnerAddress, 1, locate(',', OwnerAddress) - 1);

update usa_housing
set O_City = substr(OwnerAddress, locate(',', OwnerAddress) + 2);

select OwnerAddress, O_Address, O_City
from usa_housing;

update usa_housing
set O_State = substr(O_City, locate(',', O_City) + 2);

select OwnerAddress, O_Address, O_City, O_State
from usa_housing;

update usa_housing
set O_City = substr(O_City, 1, locate(',', O_City) - 1);

select OwnerAddress, O_Address, O_City, O_State
from usa_housing;