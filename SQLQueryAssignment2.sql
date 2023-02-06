create database Retrive



create table salesman
(
	salesman_id int Primary key Not Null,
	name nvarchar(40) Not Null,
	city nvarchar(40) Not Null, 
	commission decimal Not Null,
 )

 create table customer
(
	customer_id int Primary key Not Null,
	cust_name nvarchar(40) Not Null,
	city nvarchar(40) Not Null,
	grade int Not Null, 
	salesman_id int Not Null,
 )


  create table orders
(
	ord_no int Primary key Not Null,
	purch_amt decimal Not Null,
	ord_date date Not Null,
	customer_id int Not Null, 
	salesman_id int Not Null,
 )

 insert into salesman
 values (5001,'James Hoog','New York',0.15),
 (5002,'Nail Knite','Paris',0.13),
 (5005,'Pit Alex','London',0.11),
 (5006,'Mc Lyon','Paris',0.14),
 (5007,'Paul Adam','Rome',0.13),
 (5003,'Lauson','San Jose',0.12);

 insert into customer
 values (3002,'Nick Rimando','New York',100,5001),
 (3007,'Brad Davis','New York',200,5001),
 (3005,'Graham Zusi','California',200,5002),
 (3008,'Julian Green','London',300,5002),
 (3004,'Fabian Johnson','Paris',300,5006),
 (3009,'Geoff Cameron','Berlin',100,5003),
 (3003,'Jozy Altidor','Moscow',200,5007),
 (3001,'Brad Guzan','London',100,5005);

 insert into orders
 values (70001,150.5,'2012-10-05',3005,5002),
 (70009,270.65,'2012-09-10',3001,5005),
 (70002,65.26,'2012-10-05',3002,5001),
 (70004,110.5,'2012-08-17',3009,5003),
 (70007,948.5,'2012-09-10',3005,5002),
 (70005,2400.6,'2012-07-27',3007,5001),
 (70008,5760,'2012-09-10',3002,5001),
 (70010,1983.43,'2012-10-10',3004,5006),
 (70003,2480.4,'2012-10-10',3009,5003),
 (70012,250.45,'2012-06-27',3008,5002),
 (70011,75.29,'2012-08-17',3003,5007),
 (70013,3045.6,'2012-04-25',3002,5001);


Select * from orders;

Select * from salesman;
Select * from customer;



 select salesman.name, customer.cust_name, customer.city  
 from salesman
 INNER JOIN customer
 on salesman.city = customer.city;


 select orders.ord_no, orders.purch_amt, customer.cust_name, customer.city  
 from orders
 INNER JOIN customer
 on (customer.customer_id = orders.customer_id) 
 AND orders.purch_amt BETWEEN 500 AND 2000;



 select salesman.name, customer.cust_name, customer.city, salesman.commission
 from salesman
 INNER JOIN customer
 on salesman.salesman_id = customer.salesman_id;

 update salesman SET commission = 7 where salesman_id = 5001;
 update salesman SET commission = 10 where salesman_id = 5002;
 update salesman SET commission = 15 where salesman_id = 5003;
 update salesman SET commission = 9 where salesman_id = 5007;
 update salesman SET commission = 8 where salesman_id = 5005;
 update salesman SET commission = 11 where salesman_id = 5006;


 select customer.cust_name, customer.city, salesman.commission
 from salesman
 INNER JOIN customer
 on salesman.salesman_id = customer.salesman_id AND salesman.commission > 12;


 select customer.cust_name, customer.city, salesman.name, salesman.city, salesman.commission
 from salesman
 INNER JOIN customer
 on salesman.city <> customer.city AND salesman.commission > 12;


 select orders.ord_no, orders.ord_date, orders.purch_amt, customer.cust_name as "Customer Name", customer.grade, salesman.name as "Salesman", salesman.commission
 from orders, customer, salesman
 where orders.customer_id = customer.customer_id AND orders.salesman_id = salesman.salesman_id;


 select orders.ord_no, orders.purch_amt, orders.ord_date, customer.customer_id, customer.cust_name, customer.city ,customer.grade, salesman.salesman_id, salesman.name, salesman.commission from orders
 inner join customer
 on orders.customer_id = customer.customer_id
 inner join salesman
 on orders.salesman_id = salesman.salesman_id;


 select customer.cust_name, customer.city ,customer.grade, salesman.city, salesman.name
 from customer
 inner join salesman
 on salesman.city = customer.city
 order by customer.customer_id ASC; 


 select customer.cust_name, customer.city ,customer.grade, salesman.city, salesman.name
 from customer
 inner join salesman
 on salesman.city = customer.city AND customer.grade < 300
 order by customer.customer_id ASC; 



 select orders.ord_no, orders.purch_amt, orders.ord_date, customer.cust_name, customer.city 
 from orders 
 inner join customer
 on customer.customer_id = orders.customer_id
 order by orders.ord_date ASC;


 select orders.ord_no, orders.purch_amt, orders.ord_date, customer.cust_name, customer.city , salesman.name ,salesman.commission
 from orders 
 left join customer
 on customer.customer_id = orders.customer_id
 left join salesman
 on salesman.salesman_id = orders.salesman_id


 select customer.cust_name, customer.city , salesman.city as "Salesman City", salesman.name as "Salesman Name"
 from salesman
 right join customer
 on salesman.salesman_id = customer.salesman_id
 ORDER BY salesman.name ASC;


 select orders.ord_no, orders.purch_amt, orders.ord_date, customer.cust_name, customer.city as "Customer City", customer.grade, salesman.name as "Salesman Name"
 from salesman
 left join customer
 on salesman.salesman_id = customer.salesman_id
 left join orders
 on salesman.salesman_id = orders.salesman_id;



 select customer.cust_name, customer.city , customer.grade, salesman.city as "Salesman City", salesman.name as "Salesman Name", orders.ord_no
 from orders
 right join customer
 on orders.customer_id = customer.customer_id
 right join salesman
 on orders.salesman_id = salesman.salesman_id
 AND orders.purch_amt > 2000;


 select customer.cust_name, customer.city , customer.grade, salesman.city as "Salesman City", salesman.name as "Salesman Name", orders.ord_no
 from customer
 right outer join salesman
 on salesman.salesman_id = customer.salesman_id
 left outer join orders
 on orders.customer_id = customer.customer_id
 where orders.purch_amt >= 2000
 AND customer.grade IS NOT NULL;



 select customer.cust_name, customer.city , customer.grade, orders.ord_no, orders.ord_date, orders.purch_amt as "Order Amount"
 from customer
 full outer join orders
 on customer.customer_id = orders.customer_id
 where customer.grade IS NOT NULL;


  select customer.customer_id, customer.cust_name, customer.city as "Customer City", customer.grade, salesman.salesman_id, salesman.name as "Salesman Name", salesman.city as "Salesman City", salesman.commission
  from customer
  cross join salesman
  where salesman.city = customer.city;




SELECT * FROM salesman  
CROSS JOIN  customer  
WHERE salesman.city IS NOT NULL; 



SELECT * FROM salesman  
CROSS JOIN  customer  
WHERE customer.grade IS NOT NULL
AND salesman.city != customer.city; 



