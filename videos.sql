drop table videos;
create table videos (
  id serial8 primary key,
  title varchar(255),
  url varchar(1000),
  description varchar(1000),
  genre varchar(255),
  year varchar(4)
);