
-- 1- Write an SQL query to report the second highest salary from the Employee table. If there is no second highest salary, the query should report null.

SELECT max(Salary) AS SecondHighestSalary 
FROM Employee 
WHERE Salary NOT IN (SELECT max(Salary) FROM Employee);

-- 2 Write an SQL query to find the employees who earn more than their managers. Return the result table in any order.

SELECT
  a.Name AS "Employee"
FROM Employee AS a, Employee AS b
WHERE 
  a.ManagerID = b.id
  AND a.Salary > b.Salary;
  
/* 3- Write an SQL query to find employees who have the highest salary in each of the departments.

Return the result table in any order. */

SELECT 
  Department,e.name AS Employee,
  e.salary AS Salary 
FROM employee e,
(
    SELECT d.id department_id,
      d.name AS Department,
      max(e.salary) AS max 
    FROM department d left JOIN employee e 
    ON  d.id=e.departmentId 
    GROUP BY d.id
) AS MaxSalaries 
WHERE e.departmentId=department_id 
AND e.salary = max;

/* 4- Write an SQL query to report the IDs of all the employees with missing information. The information of an employee is missing if:

* The employee's name is missing, or
* The employee's salary is missing.

Return the result table ordered by employee_id in ascending order. */

SELECT u.Employee_id
FROM
    (
        SELECT * FROM Employees LEFT JOIN Salaries USING(employee_id)
        UNION
        SELECT * FROM Employees RIGHT JOIN Salaries USING(employee_id)
    ) AS u
WHERE u.name IS NULL OR u.salary IS NULL
ORDER BY u.Employee_id;


/* 5- A single number is a number that appeared only once in the MyNumbers table. Write an SQL query to report the largest single number. 
If there is no single number, report null. */

SELECT
    MAX(num) AS num
FROM
    (SELECT
        num
    FROM
        MyNumbers
    GROUP BY num
    HAVING COUNT(num) = 1) AS t;
    
/* 6- Write an SQL query to report the names of all the salespersons who did not have any orders related to the company with the name "RED".

Return the result table in any order. */ 
 
SELECT name
FROM SalesPerson
WHERE sales_id NOT IN (
  SELECT sales_id
    FROM Orders
      LEFT JOIN Company
        USING(com_id)
  WHERE name = "RED"
);
