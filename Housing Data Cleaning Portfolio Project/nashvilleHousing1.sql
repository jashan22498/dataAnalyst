create table nashvillehouses (
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

select * from nashvillehouses;
desc nashvillehouses;
truncate table nashvillehouses;


LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Nashville Housing Data.csv"
INTO TABLE nashvillehouses
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

/*
alter table nashvillehouses
rename column ï»¿UniqueID to UniqueID;
*/

/*
select count(*)
from nashvillehouses;

select * from nashvillehouses
where UniqueID = '';
*/

alter table nashvillehouses
modify column UniqueID int;

/*
select count(distinct UniqueID)
from nashvillehouses;
*/

-- primary key = UniqueID
alter table nashvillehouses
add primary key (UniqueID);

/*
select * from nashvillehouses
where ParcelID = '';

select * from nashvillehouses
where LandUse = '';

select distinct LandUse
from nashvillehouses;

select *
from nashvillehouses
where PropertyAddress = '';
*/

update nashvillehouses
set nashvillehouses.PropertyAddress = null
where nashvillehouses.PropertyAddress = '';

/*
select *
from nashvillehouses
where SaleDate = '';

select distinct SaleDate
from nashvillehouses;

select SaleDate, str_to_date(SaleDate, '%M %d, %Y')
from nashvillehouses;
*/

update nashvillehouses
set SaleDate = str_to_date(SaleDate, '%M %d, %Y');

alter table nashvillehouses
modify column SaleDate date;

/*
select *
from nashvillehouses
order by SaleDate;

select * from nashvillehouses
where SalePrice = '';

select SalePrice
from nashvillehouses
where SalePrice like '$%';

select SalePrice, replace(SalePrice, '$', '')
from nashvillehouses
where SalePrice like '$%';
*/

update nashvillehouses
set SalePrice = replace(SalePrice, '$', '')
where SalePrice like '%$%';

/*
select *
from nashvillehouses
where SalePrice like '%,%';
*/

update nashvillehouses
set SalePrice = replace(SalePrice, ',', '')
where SalePrice like '%,%';

/*
select *
from nashvillehouses
where SalePrice like '% %';
*/

update nashvillehouses
set SalePrice = replace(SalePrice, ' ', '')
where SalePrice like '% %';

alter table nashvillehouses
modify column SalePrice int;

/*
-- top 10 selling houses
select * from nashvillehouses
order by SalePrice desc
limit 10;

select * from nashvillehouses
where LegalReference = '';

select * from nashvillehouses
where SoldAsVacant = '';

select distinct SoldAsVacant
from nashvillehouses;
*/

update nashvillehouses
set SoldAsVacant = 'Yes'
where SoldAsVacant = 'Y';

update nashvillehouses
set SoldAsVacant = 'No'
where SoldAsVacant = 'N';

alter table nashvillehouses
modify column SoldAsVacant varchar(3);

/*
select max(length(ParcelID)), min(length(ParcelID))
from nashvillehouses;
*/

alter table nashvillehouses
modify column ParcelID varchar(20);

/*
select max(length(LandUse)), min(length(LandUse))
from nashvillehouses;
*/

alter table nashvillehouses
modify column LandUse varchar(50);

/*
select max(length(PropertyAddress)), min(length(PropertyAddress))
from nashvillehouses;
*/

alter table nashvillehouses
modify column PropertyAddress varchar(50);

/*
select max(length(LegalReference)), min(length(LegalReference))
from nashvillehouses;
*/

alter table nashvillehouses
modify column LegalReference varchar(20);

/*
select *
from nashvillehouses
where OwnerName = '';
*/

update nashvillehouses
set OwnerName = null
where OwnerName = '';

/*
select max(length(OwnerName)), min(length(OwnerName))
from nashvillehouses;
*/

alter table nashvillehouses
modify column OwnerName varchar(100);

/*
select *
from nashvillehouses
where OwnerAddress = '';
*/

update nashvillehouses
set OwnerAddress = null
where OwnerAddress = '';

/*
select max(length(OwnerAddress)), min(length(OwnerAddress))
from nashvillehouses;
*/

alter table nashvillehouses
modify column OwnerAddress varchar(50);

/*
select *
from nashvillehouses
where Acreage = '';
*/

update nashvillehouses
set Acreage = null
where Acreage = '';

alter table nashvillehouses
modify column Acreage double;

/*
select * from nashvillehouses
order by Acreage desc
limit 5;

select *
from nashvillehouses
where TaxDistrict = '';
*/

update nashvillehouses
set TaxDistrict = null
where TaxDistrict = '';

/*
select max(length(TaxDistrict)), min(length(TaxDistrict))
from nashvillehouses;
*/

alter table nashvillehouses
modify column TaxDistrict varchar(30);

/*
select distinct TaxDistrict
from nashvillehouses;

select *
from nashvillehouses
where LandValue = '';
*/

update nashvillehouses
set LandValue = null
where LandValue = '';

/*
select LandValue
from nashvillehouses
where LandValue like '%$%';

select LandValue
from nashvillehouses
where LandValue like '%,%';

select LandValue
from nashvillehouses
where LandValue like '% %';
*/

alter table nashvillehouses
modify column LandValue int;

/*
select *
from nashvillehouses
where BuildingValue = '';
*/

update nashvillehouses
set BuildingValue = null
where BuildingValue = '';

/*
select BuildingValue
from nashvillehouses
where BuildingValue like '%$%';

select BuildingValue
from nashvillehouses
where BuildingValue like '%,%';

select BuildingValue
from nashvillehouses
where BuildingValue like '% %';
*/

alter table nashvillehouses
modify column BuildingValue int;

/*
select *
from nashvillehouses
where TotalValue = '';
*/

update nashvillehouses
set TotalValue = null
where TotalValue = '';

/*
select TotalValue
from nashvillehouses
where TotalValue like '%$%';

select TotalValue
from nashvillehouses
where TotalValue like '%,%';

select TotalValue
from nashvillehouses
where TotalValue like '% %';
*/

alter table nashvillehouses
modify column TotalValue int;

/*
select *
from nashvillehouses
order by TotalValue desc
limit 5;

select *
from nashvillehouses
where YearBuilt = '';
*/

update nashvillehouses
set YearBuilt = null
where YearBuilt = '';

alter table nashvillehouses
modify column YearBuilt int;

/*
select *
from nashvillehouses
where YearBuilt = 2002;

select *
from nashvillehouses
where Bedrooms = '';
*/

update nashvillehouses
set Bedrooms = null
where Bedrooms = '';

alter table nashvillehouses
modify column Bedrooms int;

/*
select *
from nashvillehouses
where Bedrooms = 2 and YearBuilt >= 2015;

select *
from nashvillehouses
where FullBath = '';
*/

update nashvillehouses
set FullBath = null
where FullBath = '';

alter table nashvillehouses
modify column FullBath int;

/*
select *
from nashvillehouses
where HalfBath = '';
*/

update nashvillehouses
set HalfBath = null
where HalfBath = '';

alter table nashvillehouses
modify column HalfBath int;

/*
select *
from nashvillehouses
order by 1;
*/


alter table nashvillehouses
add Street varchar(50);

alter table nashvillehouses
add City varchar(50);

alter table nashvillehouses
add State varchar(50);


update nashvillehouses
set Street = substring_index(OwnerAddress, ',', 1);

select OwnerAddress, Street
from nashvillehouses;

update nashvillehouses
set City = substring_index(OwnerAddress, ',', 2);

select OwnerAddress, Street, City
from nashvillehouses;

update nashvillehouses
set City = substring_index(City, ',', -1);

select State, substring_index(OwnerAddress, ', ', -1)
from nashvillehouses;

update nashvillehouses
set State = substring_index(OwnerAddress, ', ', -1);

select OwnerAddress, char_length(OwnerAddress),
Unit, char_length(Unit),
Street, char_length(Street),
City, char_length(City),
State, char_length(State)
from nashvillehouses;

select City, char_length(City),
substr(City, 2, char_length(City) - 1), char_length(substr(City, 2, char_length(City) - 1))
from nashvillehouses;

update nashvillehouses
set City = substr(City, 2, char_length(City) - 1);

select substring_index('1802  STEWART PL', '  ', -1);

alter table nashvillehouses
add Unit varchar(50) after HalfBath;

update nashvillehouses
set Unit = substring_index(Street, '  ', 1);

update nashvillehouses
set Street = substring_index(Street, '  ', -1);

select *
from nashvillehouses
where Unit = '0';

select max(char_length(Unit)), min(char_length(Unit))
from nashvillehouses;

select *
from nashvillehouses
where char_length(Unit) = 30;

alter table nashvillehouses
drop column Unit;

alter table nashvillehouses
rename column Street to `Unit & Street`;

select distinct City
from nashvillehouses;

select *
from nashvillehouses
where PropertyAddress is not null;

select *
from nashvillehouses
where PropertyAddress = substring_index(OwnerAddress, ',', 2);

select *
from nashvillehouses
where OwnerAddress is null;

select *
from nashvillehouses
where PropertyAddress is null;