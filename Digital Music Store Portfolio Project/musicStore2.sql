-- Q1: Who is the senior most employee based on job title?

-- select * from employee;

select employee_id, first_name, last_name, title, levels
from employee
order by levels desc
limit 1;

/*
Madan Mohan is the senior most employee based on job title
job title = Senior General Manager
job level = L7
*/




-- Q2: Which countries have the most invoices?

/*
select * from invoice;

select count(distinct billing_country)
from invoice;
*/

select billing_country, count(invoice_id) AS invoices
from invoice
group by billing_country
order by 2 desc;

-- Top 3 countries:
-- USA = 131, Canada = 76, Brazil = 61





-- Q3: What are the top 3 values of total invoice per country?

select billing_country, round(sum(total), 2) as 'total invoice'
from invoice
group by billing_country
order by 2 desc
limit 3;

/*
select round(total, 2)
from invoice
order by total desc
limit 3;

update invoice
set total = round(total, 2);

alter table invoice
modify column invoice_id int,
modify column customer_id int,
modify column total double,
modify column invoice_date date;
    
alter table employee
modify column employee_id int,
modify column reports_to int;

alter table employee
modify column hire_date date;
    
alter table employee
add column birth_date date after birthdate;

select birthdate, str_to_date(birthdate, '%d-%m-%Y')
from employee;

select hire_date, str_to_date(hire_date, '%d-%m-%Y')
from employee;

update employee
set birth_date = str_to_date(birthdate, '%d-%m-%Y');

update employee
set hire_date = str_to_date(hire_date, '%d-%m-%Y');

SHOW VARIABLES LIKE 'sql_mode';
set sql_mode='';

alter table employee
drop column birthdate;

update employee
set reports_to = null
where reports_to = '';

select * from employee;

select * from employee
where year(birth_date) = 1947;

select * from employee
where year(hire_date) = 2016;

select * from invoice
where year(invoice_date) = 2017;
*/





/*
Q4: Which city had the best customers, in terms of money spent?
We would like to organize a music promotional fest in the most money making city.
Write a query that returns only one city having the highest sum of invoice totals.
Return both the city name and sum of all invoice totals in that city.
*/

/*
select * from invoice;

select count(distinct billing_city)
from invoice;
*/

select billing_city, round(sum(total), 2) as 'total invoice'
from invoice
group by billing_city
order by 2 desc
limit 1;






/*
Q5: Who is the best customer?
The customer who has spent the maximum amount of money on music will be declared
as the best customer.
Write a query that returns the customer who has spent the most money. 
*/

/*
-- data cleaning in customer
select * from customer;

select * from customer
where customer_id = '' OR support_rep_id = '';

alter table customer
modify column customer_id int,
modify column support_rep_id int;
*/

/*
select count(distinct customer_id)
from invoice;
*/

-- 1. Without joins
select customer_id, round(sum(total), 2) as 'total money spent'
from invoice
group by customer_id
order by 2 desc
limit 1;

select * from customer
where customer_id = 5;

-- 2. using join
select c.customer_id, c.first_name, c.last_name, sum(i.total) as total_invoice
from customer c
join invoice i
on c.customer_id = i.customer_id
group by c.customer_id
order by 4 desc
limit 1;






/*
Q6: Write a query to return the email, first name, last name and genre of all 'Rock' music listeners.
Sort the result alphabetically by email, starting with 'a' or 'A'.


/*
-- data cleaning in genre
alter table genre
modify column genre_id int;
*/


/*
select * from genre;

select genre_id, name
from genre
where name = 'Rock';
-- genre_id = 1 for Rock
*/


/*
-- data cleaning in track
select * from track;

select * from track
where track_id = '' OR album_id = '' OR media_type_id = '' OR genre_id = '' OR milliseconds = '' OR bytes = '' OR unit_price = '';

alter table track
modify column track_id int,
modify column album_id int,
modify column media_type_id int,
modify column genre_id int,
modify column milliseconds int,
modify column bytes int,
modify column unit_price double;
*/


/*
select * from track
where genre_id = 1;

select * from invoice_line;

select distinct invoice_line.invoice_id from invoice_line
where invoice_line.track_id in (select track.track_id
								from track
                                where track.genre_id = 1);
*/


-- 1. using subqueries
select distinct c.email, c.first_name, c.last_name
from invoice i
join customer c
on i.customer_id = c.customer_id
where i.invoice_id in (select distinct invoice_line.invoice_id from invoice_line
					   where invoice_line.track_id in (select track.track_id
													   from track
													   where track.genre_id = 1))
order by 1;                                                       


-- 2. using joins
select distinct c.email, c.first_name, c.last_name, g.name
from track t
join genre g
join invoice_line il
join invoice i
join customer c
on t.genre_id = g.genre_id and t.track_id = il.track_id and il.invoice_id = i.invoice_id and i.customer_id = c.customer_id
where g.name like 'rock'
order by c.email;


-- 3. using joins and subquery
select distinct c.email, c.first_name, c.last_name
from customer c
join invoice i
on c.customer_id = i.customer_id
join invoice_line il
on i.invoice_id = il.invoice_id
where il.track_id in (
	select t.track_id
	from track t
	join genre g
	on t.genre_id = g.genre_id
	where g.name = 'Rock'
)
order by c.email;






/* Q7: We want to give an award to the artist who has written the most rock
music. Write a query that returns the artist name and total track count of
the top 10 'Rock' bands.


/*
-- data cleaning
-- artist
select * from artist;

select * from artist
where artist_id = '';

alter table artist
modify column artist_id int;


-- album
select * from album;

select * from album
where album_id = '' OR artist_id = '';

alter table album
modify column album_id int,
modify column artist_id int;
*/


select a.name, count(t.track_id) as 'total tracks (genre = rock)'
from artist a
join album al
join track t
join genre g
on a.artist_id = al.artist_id and al.album_id = t.album_id and t.genre_id = g.genre_id
where g.name = 'Rock'
group by a.artist_id
order by 2 desc
limit 10;

-- Award Winner = Led Zeppelin





/*
Q8: Write a query to return all the track names having
song length longer than the average song length.
Show the name and milliseconds for each track.
Order the result set by song length with the longest song listed first.
*/

-- select * from track;

select name, milliseconds from track
where milliseconds > (select avg(milliseconds) from track)
order by milliseconds desc;





/*
Q9: Find how much money each customer spent on each artist?
Write a query to return customer name, artist name and total spent.
*/


/*
-- data cleaning in invoice_line
select * from invoice_line;

select * from invoice_line
where invoice_line_id = '' or invoice_id = '' or track_id = '' or unit_price = '' or quantity = '';

alter table invoice_line
modify column invoice_line_id int,
modify column invoice_id int,
modify column track_id int,
modify column unit_price double,
modify column quantity int;
*/


select concat(c.first_name, ' ', c.last_name) as cust_name, a.name as art_name, round(sum(il.unit_price * il.quantity), 2) as 'money spent'
from customer c
join invoice i on c.customer_id = i.customer_id
join invoice_line il on i.invoice_id = il.invoice_id
join track t on il.track_id = t.track_id
join album al on t.album_id = al.album_id
join artist a on a.artist_id = al.artist_id
group by c.customer_id, a.artist_id
order by 1, 3 desc;





/*
Q10: We want to find out the most popular music genre for each country.
Most popular music genre is the genre with the highest number of purchases.
Write a query that returns each country along with the top genre.
For countries where the maximum number of purchases is shared, return all genres.
*/


-- using CTE = Common Table Expression
with genreSales as (
	select i.billing_country, g.name, count(g.name) as total_tracks_sold
	from invoice i
	join invoice_line il
	join track t
	join genre g
	on i.invoice_id = il.invoice_id and il.track_id = t.track_id and t.genre_id = g.genre_id
	group by i.billing_country, g.name
	order by 1, 3 desc
)
select billing_country, name, max(total_tracks_sold)
from genreSales
group by billing_country;


-- using two CTEs
with genreSales as (
	select i.billing_country, g.name, count(g.name) as total_tracks_sold
	from invoice i
	join invoice_line il
	join track t
	join genre g
	on i.invoice_id = il.invoice_id and il.track_id = t.track_id and t.genre_id = g.genre_id
	group by i.billing_country, g.name
), topGenreSales as (
	select gs.billing_country, max(gs.total_tracks_sold) as top_genre_tracks_sold
    from genreSales as gs
    group by gs.billing_country
)
select gs.billing_country, gs.name as top_genre, tgs.top_genre_tracks_sold
from genreSales gs
join topGenreSales tgs
on gs.billing_country = tgs.billing_country
where gs.total_tracks_sold = tgs.top_genre_tracks_sold
order by 1;


-- using Derived Table (subquery in FROM clause)
select t1.billing_country, t1.name, max(t1.total_sales) from (
	select i.billing_country, g.name, count(g.name) as total_sales
	from invoice i
	join invoice_line il
	join track t
	join genre g
	on i.invoice_id = il.invoice_id and il.track_id = t.track_id and t.genre_id = g.genre_id
	group by i.billing_country, g.name
    order by 1, 3 desc) as t1
group by t1.billing_country;


-- using rank() window function
with cte as (
	select i.billing_country, g.name, count(g.name) as total_tracks_sold,
    rank() over(partition by i.billing_country order by count(g.name) desc) as rnk
	from invoice i
	join invoice_line il
	join track t
	join genre g
	on i.invoice_id = il.invoice_id and il.track_id = t.track_id and t.genre_id = g.genre_id
	group by i.billing_country, g.name
)
select billing_country, name, total_tracks_sold
from cte
where rnk = 1;





/*
Q11: Write a query that determines the customer who has spent the most
on music for each country.
Write a query that returns the country along with the top customer and their spending.
For countries where the top amount spent is shared, provide all customers who spent this amount.
*/


-- using cte and order by
with customerSpending as (
	select i.billing_country, concat(c.first_name, ' ', c.last_name) as cust_name, sum(i.total) as totalSpending
    from customer c
    join invoice i
    on c.customer_id = i.customer_id
    group by i.billing_country, c.customer_id
    order by 1, 3 desc
)
select billing_country, cust_name, max(totalSpending) as most_spending_customer
from customerSpending
group by billing_country;


-- using two CTEs
with customerSpending as (
	select i.billing_country, concat(c.first_name, ' ', c.last_name) as cust_name, sum(i.total) as totalSpending
    from customer c
    join invoice i
    on c.customer_id = i.customer_id
    group by i.billing_country, c.customer_id
), top_cust_spending as (
	select cs.billing_country, max(cs.totalSpending) as max_total_Spending
    from customerSpending cs
    group by cs.billing_country
)
select cs.*
from customerSpending cs
join top_cust_spending tcs
on cs.billing_country = tcs.billing_country
where cs.totalSpending = tcs.max_total_spending
order by 1;


-- using window function = rank()
with cte as (
	select i.billing_country, concat(c.first_name, ' ', c.last_name) as cust_name, sum(i.total) as totalSpending,
    rank() over(partition by i.billing_country order by sum(i.total) desc) as rnk
	from customer c
	join invoice i
	on c.customer_id = i.customer_id
	group by i.billing_country, c.customer_id
)
select billing_country, cust_name, totalSpending
from cte
where rnk = 1;