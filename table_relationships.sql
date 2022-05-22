use bookfile;

create table customers( 
id int auto_increment primary key,
first_name varchar(100), 
last_name varchar(100),
email varchar(100)
);

create table orders(
id int auto_increment primary key,
order_date date,
amount decimal(8,2),
customer_id int,
foreign key(customer_id) references customers(id)
);

INSERT INTO customers (first_name, last_name, email) 
VALUES ('Boy', 'George', 'george@gmail.com'),
       ('George', 'Michael', 'gm@gmail.com'),
       ('David', 'Bowie', 'david@gmail.com'),
       ('Blue', 'Steele', 'blue@gmail.com'),
       ('Bette', 'Davis', 'bette@aol.com');
       
INSERT INTO orders (order_date, amount, customer_id)
VALUES ('2016/02/10', 99.99, 1),
       ('2017/11/11', 35.50, 1),
       ('2014/12/12', 800.67, 2),
       ('2015/01/03', 12.50, 2),
       ('1999/04/11', 450.25, 5);

select * from customers;
select * from orders;

select * from orders where customer_id=
(
select id from customers
where last_name='George'
);	

select * from customers, orders
where
customers.id = orders.customer_id;

select * from customers
join orders
on customers.id=orders.customer_id;

select first_name, last_name, sum(amount) as total_spent
from customers
join orders
on customers.id = orders.customer_id
group by orders.customer_id
order by total_spent desc;

select first_name,last_name,order_date, amount 
from customers
left join orders
on customers.id=orders.customer_id;

select first_name, last_name, ifnull(sum(amount), 0) as total_spent
from customers
left join orders
on customers.id = orders.customer_id
group by customers.id
order by sum(amount) desc;

select * from customers
right join orders
on customers.id=orders.customer_id;

create table students (
id int auto_increment primary key,
first_name varchar(100)
);

create table papers(
title varchar(100),
grade int,
student_id int,
foreign key (student_id) references students(id)
on delete cascade);

INSERT INTO students (first_name) VALUES 
('Caleb'), 
('Samantha'), 
('Raj'), 
('Carlos'), 
('Lisa');
 
INSERT INTO papers (student_id, title, grade ) VALUES
(1, 'My First Book Report', 60),
(1, 'My Second Book Report', 75),
(2, 'Russian Lit Through The Ages', 94),
(2, 'De Montaigne and The Art of The Essay', 98),
(4, 'Borges and Magical Realism', 89);

select first_name, title, grade
from students
join papers
on students.id=papers.student_id
order by grade desc;

select first_name, title, grade
from students
left join papers
on students.id=papers.student_id;

select first_name, ifnull(title,'Missing'), ifnull(grade,0)
from students
left join papers
on students.id=papers.student_id;

select first_name,  ifnull(avg(grade),0) as average,
case
when avg(grade) is null then 'Failing'
when avg(grade) >=75 then 'Passing'
else 'Failing'
end as passing_status
from students
left join papers
on students.id=papers.student_id
group by students.id
order by average desc;

create table reviewers (
id int auto_increment primary key,
first_name varchar(100),
last_name varchar(100)
);

create table series(
id int auto_increment primary key,
title varchar(100),
released_year year(4),
genre varchar(100)
);

create table reviews(
id int auto_increment primary key,
rating decimal(2,1),
series_id int,
reviewer_id int,
foreign key (series_id) references series(id),
foreign key (reviewer_id) references reviewers(id)
);

INSERT INTO series (title, released_year, genre) VALUES
    ('Archer', 2009, 'Animation'),
    ('Arrested Development', 2003, 'Comedy'),
    ("Bob's Burgers", 2011, 'Animation'),
    ('Bojack Horseman', 2014, 'Animation'),
    ("Breaking Bad", 2008, 'Drama'),
    ('Curb Your Enthusiasm', 2000, 'Comedy'),
    ("Fargo", 2014, 'Drama'),
    ('Freaks and Geeks', 1999, 'Comedy'),
    ('General Hospital', 1963, 'Drama'),
    ('Halt and Catch Fire', 2014, 'Drama'),
    ('Malcolm In The Middle', 2000, 'Comedy'),
    ('Pushing Daisies', 2007, 'Comedy'),
    ('Seinfeld', 1989, 'Comedy'),
    ('Stranger Things', 2016, 'Drama');
 
 
INSERT INTO reviewers (first_name, last_name) VALUES
    ('Thomas', 'Stoneman'),
    ('Wyatt', 'Skaggs'),
    ('Kimbra', 'Masters'),
    ('Domingo', 'Cortes'),
    ('Colt', 'Steele'),
    ('Pinkie', 'Petit'),
    ('Marlon', 'Crafford');
    
 
INSERT INTO reviews(series_id, reviewer_id, rating) VALUES
    (1,1,8.0),(1,2,7.5),(1,3,8.5),(1,4,7.7),(1,5,8.9),
    (2,1,8.1),(2,4,6.0),(2,3,8.0),(2,6,8.4),(2,5,9.9),
    (3,1,7.0),(3,6,7.5),(3,4,8.0),(3,3,7.1),(3,5,8.0),
    (4,1,7.5),(4,3,7.8),(4,4,8.3),(4,2,7.6),(4,5,8.5),
    (5,1,9.5),(5,3,9.0),(5,4,9.1),(5,2,9.3),(5,5,9.9),
    (6,2,6.5),(6,3,7.8),(6,4,8.8),(6,2,8.4),(6,5,9.1),
    (7,2,9.1),(7,5,9.7),
    (8,4,8.5),(8,2,7.8),(8,6,8.8),(8,5,9.3),
    (9,2,5.5),(9,3,6.8),(9,4,5.8),(9,6,4.3),(9,5,4.5),
    (10,5,9.9),
    (13,3,8.0),(13,4,7.2),
    (14,2,8.5),(14,3,8.9),(14,4,8.9);
    
select title, rating from series
join reviews
on series.id=reviews.series_id
order by title;

select title, avg(rating) as avg_rating from series
join reviews
on series.id=reviews.series_id
group by series_id
order by avg_rating;

select first_name, last_name, rating 
from reviewers
join reviews
on reviewers.id=reviews.reviewer_id;

select title as unreviewed_series
from series
left join reviews
on series.id=reviews.series_id
where rating is null;

select genre, avg(rating) as avg_rating
from series
join reviews
on series.id=reviews.series_id
group by genre;

select
first_name,last_name,count(rating) as count, ifnull(Min(rating),0) as Min, ifnull(Max(rating),0) as Max, ifnull(avg(rating),0) as Avg,
if(count(rating)>0, 'Active', 'Inactive') as Status
from reviewers
left join reviews
on reviewers.id=reviews.reviewer_id
group by reviewers.id;

select title, rating, concat(first_name, ' ', last_name) as reviewer
from reviewers 
inner join reviews
on reviewers.id=reviews.reviewer_id
inner join series
on series.id=reviews.series_id;

create table users (
id int auto_increment primary key,
username varchar(255) unique not null,
created_at timestamp default now()
);

create table photos (
id int auto_increment primary key,
image_url varchar(255) not null,
user_id int not null,
created_at timestamp default now(),
foreign key (user_id) references users(id));

create table comments (
id int auto_increment primary key,
comment_text varchar(255) not null,
user_id int not null,
photo_id int not null,
created_at timestamp default now(),
foreign key (user_id) references users(id),
foreign key (photo_id) references photos(id)
);

create table Likes (
user_id int not null,
photo_id int not null,
created_at timestamp default now(),
foreign key (user_id) references users(id),
foreign key (photo_id) references photos(id),
PRIMARY KEY(user_id, photo_id)
);

create table follows(
follower_id int not null,
followee_id int not null,
created_at timestamp default now(),
foreign key (follower_id) references users(id),
foreign key (followee_id) references photos(id),
PRIMARY KEY(follower_id, followee_id)
);

CREATE TABLE tags (
  id INTEGER AUTO_INCREMENT PRIMARY KEY,
  tag_name VARCHAR(255) UNIQUE,
  created_at TIMESTAMP DEFAULT NOW()
);
CREATE TABLE photo_tags (
    photo_id INTEGER NOT NULL,
    tag_id INTEGER NOT NULL,
    FOREIGN KEY(photo_id) REFERENCES photos(id),
    FOREIGN KEY(tag_id) REFERENCES tags(id),
    PRIMARY KEY(photo_id, tag_id)
);

drop table users,photos,comments,likes, follows, tags, photo_tags;
drop database bookfile;