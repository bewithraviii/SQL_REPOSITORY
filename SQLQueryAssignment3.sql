select * from Department
select * from Employee




select Department.dept_name, Employee.emp_name, Employee.salary
from Employee
join Department
on Employee.dept_id = Department.dept_id
where Employee.salary IN 
	(
		SELECT MAX(salary)
		from Employee
		group by dept_id
	)
order by Employee.salary DESC;


select Department.dept_name as "Depertment Name"
from Department
inner join Employee 
on Department.dept_id = Employee.dept_id
Group by Department.dept_name
Having COUNT(dept_name) < 3;



select Department.dept_name, COUNT(Employee.emp_name) as "Employ No."
from Department
inner join Employee
on Department.dept_id = Employee.dept_id
Group by Department.dept_name




select Department.dept_name, SUM(Employee.salary) as "Total Salary"
from Department
inner join Employee
on Department.dept_id = Employee.dept_id
Group by Department.dept_name