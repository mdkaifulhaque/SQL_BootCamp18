CREATE TABLE employee_data
(
    emp_id INT,
    emp_name VARCHAR(100),
    department VARCHAR(50),
    city VARCHAR(50),
    gender VARCHAR(10),
    age INT,
    salary DECIMAL(10,2),
    experience INT,
    joining_date DATE
);


INSERT INTO employee_data VALUES
(101,'Rahul Sharma','IT','Mumbai','Male',25,45000,2,'2022-05-10'),
(102,'Priya Singh','HR','Delhi','Female',30,52000,5,'2019-08-15'),
(103,'Amit Patel','Finance','Ahmedabad','Male',35,70000,8,'2016-01-20'),
(104,'Sneha Kapoor','IT','Pune','Female',28,60000,4,'2021-03-18'),
(105,'Vikram Mehta','Sales','Mumbai','Male',40,80000,12,'2013-09-25'),
(106,'Anjali Verma','Marketing','Delhi','Female',27,48000,3,'2022-11-01'),
(107,'Karan Malhotra','IT','Bangalore','Male',31,75000,7,'2018-06-30'),
(108,'Neha Joshi','Finance','Mumbai','Female',29,68000,6,'2019-12-10'),
(109,'Arjun Nair','Sales','Chennai','Male',33,72000,9,'2017-04-05'),
(110,'Pooja Shah','HR','Ahmedabad','Female',26,50000,2,'2023-01-12'),
(111,'Rohan Das','Marketing','Kolkata','Male',37,85000,11,'2014-07-14'),
(112,'Kavya Iyer','IT','Chennai','Female',24,42000,1,'2023-06-20');


-- Show all employee details.
SELECT * FROM employee_data;

-- Show only employee name and salary.
SELECT emp_name, salary FROM employee_data;

-- Show employee name, department and city.
SELECT emp_name , department, city FROM employee_data;

-- Show all employees whose department is IT.
SELECT emp_name, department FROM employee_data
WHERE department = 'IT';

-- Show employees whose city is Mumbai.
SELECT emp_name , city FROM employee_data
WHERE city = 'Mumbai';

-- Show employees whose salary is greater than 60000.
SELECT emp_name , salary FROM employee_data
WHERE salary > 60000;

-- Show employees whose age is less than 30.
SELECT emp_name , age FROM employee_data
WHERE age <30;

-- Show employees whose experience is greater than or equal to 5 years.
SELECT emp_name , experience FROM employee_data
WHERE experience >= 5;

-- Show employees whose gender is Female.
SELECT emp_name , gender FROM employee_data
WHERE gender = 'Female';

-- Show employees whose salary is not equal to 50000.
SELECT emp_name, salary FROM employee_data
WHERE salary != 50000;

-- Show employees whose salary is between 50000 and 70000.
SELECT emp_name , salary FROM employee_data
WHERE  salary BETWEEN 50000 AND 70000;

-- Show employees whose age is between 25 and 30.
SELECT emp_name , age FROM employee_data
WHERE age BETWEEN 25 AND 30;

-- Show employees who belong to IT, HR or Finance departments.
SELECT emp_name , department FROM employee_data
WHERE department IN ('IT', 'HR' , 'Finance');

-- Show employees who do NOT belong to the Sales department.
SELECT emp_name , department FROM employee_data
WHERE department NOT IN ('Sales') ;

-- Show employees who work in Mumbai AND belong to IT.
SELECT emp_name ,city,department FROM employee_data
WHERE city = 'Mumbai' 
AND department = 'IT';

-- Show employees who work in Delhi OR Ahmedabad.
SELECT emp_name ,city FROM employee_data
WHERE city = 'Delhi' OR  city = 'Ahmedabad';

-- Show employee name and salary sorted by salary in ascending order.
SELECT emp_name , salary FROM employee_data
ORDER BY salary;

-- Show all employees sorted by age from highest to lowest.
SELECT emp_name , age FROM employee_data
ORDER BY age DESC;

-- Show the first 5 employees after sorting by salary in descending order.
SELECT TOP (5) emp_name,salary FROM employee_data
ORDER BY salary DESC

-- Show all unique departments.
SELECT  DISTINCT department FROM employee_data;

-- Show employee name, salary and a new column Bonus which is salary * 0.10.
SELECT emp_name,salary,
Salary * 0.10 AS Bonus
FROM employee_data;

-- Show employee name, salary and a new column Annual_Salary (salary * 12).
SELECT emp_name,salary,
Salary * 12 AS Annual_Salary
FROM employee_data;

-- Show employee name and salary after adding 5000. Name the column New_Salary.
SELECT emp_name,salary,
Salary + 5000 AS New_Salary
FROM employee_data;

-- Show employees whose names start with 'A'.
SELECT emp_name FROM employee_data
WHERE  emp_name LIKE 'A%';

-- Show employees whose names end with 'a'.
SELECT emp_name FROM employee_data
WHERE  emp_name LIKE '%a';

-- Show employees whose names contain 'an'.
SELECT emp_name FROM employee_data
WHERE  emp_name LIKE '%an%';

-- Show employees whose second letter is 'r'.
SELECT emp_name FROM employee_data
WHERE  emp_name LIKE '_r%';

-- Show employees whose names start with 'P' or 'R'.
SELECT emp_name FROM employee_data
WHERE  emp_name LIKE 'P%' OR  emp_name LIKE 'R%';

-- Show employees whose salary is greater than 50000 AND whose department is IT, sorted by salary from highest to lowest.
SELECT emp_name , salary, department FROM employee_data
WHERE salary > 50000 AND department = 'IT'
ORDER BY salary DESC

-- Show employee name, department, salary and a new column called Tax
-- Tax should be calculated as 5% of salary.
-- Display only employees whose salary is between 50000 and 80000.
-- Sort the result by salary in descending order.

SELECT emp_name,department,salary, 
salary * 0.05 AS Tax
FROM employee_data
WHERE salary BETWEEN 50000 AND 80000
ORDER BY salary DESC;   

