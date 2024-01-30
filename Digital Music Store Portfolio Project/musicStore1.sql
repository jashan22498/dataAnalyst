create database music;
use music;
show databases;
show tables;

create table employee (
	employee_id text,
    last_name text,
    first_name text,
    title text,
    reports_to text,
    levels text,
    birthdate text,
    hire_date text,
    address text,
    city text,
    state text,
    country text,
    postal_code text,
    phone text,
    fax text,
    email text
);

select * from employee;

select * from employee
where levels = 'L1';

create table album (
	album_id text,
    title text,
    artist_id text
);

select * from album;

select * from album
where album_id = 10;


create table track (
	track_id text,
    name text,
    album_id text,
    media_type_id text,genre_id text,
    composer text,
    milliseconds text,
    bytes text,
    unit_price text
);

select * from track;
truncate table track;

load data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/track.csv'
into table playlist_track
fields terminated by ','
enclosed by '"'
lines terminated by '\r\n'
ignore 1 lines;

select album_id, sum(bytes)
from track
group by album_id
order by sum(bytes) desc;

select a.title, sum(t.bytes)
from album a
join track t
on a.album_id = t.album_id
group by a.title
order by sum(bytes) desc;

create table artist (
	artist_id text,
    name text
);

select * from artist;

create table customer (
	customer_id text,
    first_name text,
    last_name text,
    company text,
    address text,
    city text,
    state text,
    country text,
    postal_code text,
    phone text,
    fax text,
    email text,
    support_rep_id text
);

select * from customer;

select count(*) from customer
where company = '';

create table genre (
	genre_id text,
    name text
);

select * from genre;

create table invoice (
	invoice_id text,
    customer_id text,
    invoice_date text,
    billing_address text,
    billing_city text,
    billing_state text,
    billing_country text,
    billing_postal_code text,
    total text
);

select * from invoice;

create table invoice_line (
	invoice_line_id text,
    invoice_id text,
    track_id text,
    unit_price text,
    quantity text
);

select * from invoice_line;

drop table invoice_line_id;

create table media_type (
	media_type_id text,
    name text
);

select * from media_type;

create table playlist (
	playlist_id text,
    name text
);

select * from playlist;


create table playlist_track (
	playlist_id text,
    track_id text
);

select * from playlist_track;