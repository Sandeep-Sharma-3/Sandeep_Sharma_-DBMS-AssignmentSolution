drop database if exists TravelOnTheGo;
create database TravelOnTheGo;
use TravelOnTheGo;

drop table if exists passenger;
create table passenger (
	passenger_name varchar(20),
    category varchar(10),
    gender varchar(10),
    boarding_city varchar(20),
    destination_city varchar(20),
    distance int,
    bus_type varchar(10)
);

drop table if exists price;
create table price (
	bus_type varchar(10),
    distance int,
    price int
);

insert into passenger values ('Sejal', 'AC', 'F', 'Bengaluru', 'Chennai', 350, 'Sleeper');
insert into passenger values ('Anmol', 'Non-AC', 'M', 'Mumbai', 'Hyderabad', 700, 'Sitting');
insert into passenger values ('Pallavi', 'AC', 'F', 'Panaji', 'Bengaluru', 600, 'Sleeper');
insert into passenger values ('Khusboo', 'AC', 'F', 'Chennai', 'Mumbai', '1500', 'Sleeper');
insert into passenger values ('Udit', 'Non-AC', 'M', 'Trivandrum', 'Panaji', 1000, 'Sleeper');
insert into passenger values ('Ankur', 'AC', 'M', 'Nagpur', 'Hyderabad', 500, 'Sitting');
insert into passenger values ('Hemant', 'Non-AC', 'M', 'Panaji', 'Mumbai', 700, 'Sleeper');
insert into passenger values ('Manish', 'Non-AC', 'M', 'Hyderabad', 'Bengaluru', 500, 'Sitting');
insert into passenger values ('Piyush', 'AC', 'M', 'Pune', 'Nagpur', 700, 'Sitting');

insert into price values ('Sleeper', 350, 770);
insert into price values ('Sleeper', 500, 1100);
insert into price values ('Sleeper', 600, 1320);
insert into price values ('Sleeper', 700, 1540);
insert into price values ('Sleeper', 1000, 2200);
insert into price values ('Sleeper', 1500, 2700);
insert into price values ('Sitting', 500, 620);
insert into price values ('Sitting', 600, 744);
insert into price values ('Sitting', 700, 868);
insert into price values ('Sitting', 1000, 1240);
insert into price values ('Sitting', 1200, 1488);
insert into price values ('Sitting', 1500, 1860);

#3) How many females and how many male passengers travelled for a minimum distance of 600 KM s?
###two ways of doing this###
select Gender, count(passenger_name) as 'Distance atleast 600 KMs' from (select * from passenger where distance >= 600) as gender_distance group by Gender;
#or#
select Gender, count(passenger_name) as 'Distance atleast 600 KMs' from passenger where distance >= 600 group by gender;

#4) Find the minimum ticket price for Sleeper Bus.
select Bus_Type, price as Min_Price from price having bus_type = 'Sleeper' and min(price);

#5) Select passenger names whose names start with character 'S'
select Passenger_Name from passenger where passenger_name like 'S%' or 's%';

#6) Calculate price charged for each passenger displaying Passenger name, Boarding City, Destination City, Bus_Type, Price in the output
select passenger_name, boarding_city, destination_city, passenger.bus_type, price from passenger, price where passenger.bus_type = price.bus_type and passenger.distance = price.distance;

#7) What are the passenger name/s and his/her ticket price who travelled in the Sitting bus for a distance of 1000 KM s
select Passenger_Name, Price from passenger as pa, price as pr where pa.bus_type = pr.bus_type and pa.distance = pr.distance and pa.bus_type = 'sitting' and pa.distance = 1000;
#There is no one in this category

#8) What will be the Sitting and Sleeper bus charge for Pallavi to travel from Bangalore to Panaji?
select bus_type, price from price where distance in (select distance from passenger where (boarding_city = 'Bengaluru' and destination_city = 'Panaji') or (boarding_city = 'Panaji' and destination_city = 'Bengaluru'));

#9) List the distances from the "Passenger" table which are unique (non-repeated distances) in descending order.
select distinct(distance) as Distances from passenger order by distance desc;

#10) Display the passenger name and percentage of distance travelled by that passenger from the total distance travelled by all passengers without using user variables
select passenger_name, distance*100/(select sum(distance) from passenger) as Distance_Percentage from passenger;

#11) Display the distance, price in three categories in table Price
#a) Expensive if the cost is more than 1000
#b) Average Cost if the cost is less than 1000 and greater than 500
#c) Cheap otherwise
select *, 
case
	when price > 1000 then "Expensive"
	when price > 500 then "Average Cost"
    else "Cheap"
end as Category
from price;