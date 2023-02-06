

create table Department
(
dept_id int primary key NOT NULL,
dept_name nvarchar(40) NOT NULL
)

create table Employee
(
emp_id int primary key NOT NULL,
dept_id int NOT NULL,
mngr_id int NOT NULL,
emp_name nvarchar(40) NOT NULL,
salary int NOT NULL
)