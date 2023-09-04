CREATE TYPE cat_color AS ENUM (
    'black',
    'white',
    'black & white',
    'red',
    'red & white',
    'red & black & white'
);

CREATE TABLE cats (
    name varchar,
    color cat_color,
    tail_length int,
    whiskers_length int,
    PRIMARY KEY (name)
);

INSERT INTO cats (name, color, tail_length, whiskers_length) VALUES
('Tihon', 'red & white', 15, 12),
('Marfa', 'black & white', 13, 11),
('Asya', 'black', 10, 10),
('Amur', 'black & white', 20, 11),
('Hustav', 'red & white', 12, 12),
('Dina', 'black & white', 17, 12),
('Gass', 'red & white', 15, 13),
('Vika', 'black', 14, 10),
('Clod', 'red & white', 12, 15),
('Neo', 'red', 11, 13),
('Nord', 'red & black & white', 19, 12),
('Kelly', 'red & white', 26, 11),
('Ost', 'white', 14, 12),
('Tayson', 'red & white', 18, 13),
('Lesya', 'black & white', 12, 15),
('Foma', 'black', 15, 18),
('Odett', 'red & white', 17, 13),
('Cesar', 'black & white', 18, 14),
('Shurik', 'red & white', 17, 13),
('Flora', 'black & white', 12, 15),
('Tara', 'red & white', 17, 12),
('Yasha', 'red & white', 18, 12),
('Chlo', 'black', 14, 13),
('Snow', 'white', 19, 14),
('Sam', 'black & white', 15, 15),
('Ula', 'red & white', 16, 14),
('Nemo', 'red & white', 17, 13)
;

CREATE TABLE cat_colors_info (
    color cat_color UNIQUE,
    count int
);

CREATE TABLE cats_stat (
    tail_length_mean numeric,
    tail_length_median numeric,
    tail_length_mode integer[],
    whiskers_length_mean numeric,
    whiskers_length_median numeric,
    whiskers_length_mode integer[]
);

-- task 1
insert into cat_colors_info (color, count) select color, count(*) from cats group by color order by color asc;

-- task 2
insert into cats_stat (tail_length_mean, tail_length_median, tail_length_mode, whiskers_length_mean, whiskers_length_median, whiskers_length_mode)
values (
    (select round(avg(tail_length), 1) from cats),
    (select percentile_cont(0.5) within group (order by tail_length) from cats),
    (select ARRAY (with modes as (select tail_length as tlen, count(tail_length) as clen from cats group by tail_length order by count(tail_length) desc) select tlen from modes where clen = (select max(clen) from modes) order by tlen asc)),
    (select round(avg(whiskers_length), 1) from cats),
    (select percentile_cont(0.5) within group (order by whiskers_length) from cats),
    (select ARRAY (with modes as (select whiskers_length as wlen, count(whiskers_length) as clen from cats group by whiskers_length order by count(whiskers_length) desc) select wlen from modes where clen = (select max(clen) from modes) order by wlen asc))
);