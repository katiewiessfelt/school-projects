--Lab 2
--Katie Schramm
--October 14, 2020

--Q1: List the first name, last name and salary of the employee(s) whose salary is greater than 50,000 (Order by the salary in descending order)
SELECT fname AS 'First Name', lname AS 'Last Name', salary AS Salary
FROM EMPLOYEE
	WHERE salary>50000.00
	ORDER BY salary DESC

--Q2: List the name and address of employees who work for the department chaired by Franklin Wong
SELECT E.fname AS 'First Name', E.lname AS 'Last Name', E.address AS Address
FROM employee E INNER JOIN department ON dno=dnumber INNER JOIN employee M ON mgrssn=M.ssn
	WHERE M.fname='Franklin' AND M.lname='Wong'

--Q3: List the first name and last name of employees who works on at least one project controlled by the Software department
SELECT DISTINCT fname AS 'First Name', lname AS 'Last Name'
FROM employee INNER JOIN works_on on ssn=essn INNER JOIN project on pno=pnumber INNER JOIN department on dnum=dnumber
	WHERE dname='Software'

--Q4: For every project located in Houston, list the project name, the controlling department name, 
	--and the department manager’s first and last name
SELECT pname AS Project, dname AS Department,fname AS 'First Name', lname AS 'Last Name'
FROM project INNER JOIN department on dnum=dnumber INNER JOIN employee on mgrssn=ssn
	WHERE plocation='Houston'

--Q5: Make a list of all project numbers for projects that involve an employee whose last name is
	--Smith either as a worker or as a manager of the department that controls the project
--need: EMPLOYEE lname=Smith; WORKS_ON essn(FK(ssn)_EMPLOYEE), <pno>
 select distinct p.pnumber
 from project p,department d,employee e, works_on w
 where (p.dnum=d.dnumber and d.mgrssn=e.ssn and e.lname='Smith')
	or ( p.pnumber=w.pno and w.essn=e.ssn and e.lname='Smith'); 

--Q6: For each employee, retrieve the employee’s first and last name and the first and last name of
	--his or her immediate supervisor
SELECT E.fname AS 'Employee First Name', E.lname AS 'Employee Last Name', M.fname AS 'Manager First Name', M.lname AS 'Manager Last Name'
FROM employee E INNER JOIN employee M on M.ssn=E.superssn

--Q7: Show the resulting salaries if every employee working ON the ProductZ project is given a 10%
	--salary cut (The salary column should be displayed as “Decreased Salary” in the result)
SELECT fname AS 'First Name', lname AS 'Last Name', salary*.9 AS 'Decreased Salary'
FROM project INNER JOIN works_on ON pnumber=pno INNER JOIN employee ON essn=ssn
	WHERE pname='ProductZ'

--Q8: List the first name and last name of employees who have two or more dependents
SELECT fname AS 'First Name', lname AS 'Last Name'
FROM dependent INNER JOIN employee ON essn=ssn
	GROUP BY fname, lname HAVING COUNT(essn)>1
	ORDER BY fname ASC

--Q9: Make a list of all department names, all employee names in each department, and all projects
	--each employee works on, ordered by department name, and within each department, ordered alphabetically by an
	--employee’s last name and first name
SELECT dname AS Department, fname AS 'First Name', lname AS 'Last Name', pname AS Project
FROM department INNER JOIN employee ON dnumber=dno INNER JOIN works_on ON essn=ssn INNER JOIN project ON pnumber=pno
	ORDER BY dname

--Q10: List the first name and last name of employees who works on at least two projects
SELECT fname AS 'First Name', lname AS 'Last Name'
FROM employee INNER JOIN works_on ON ssn=essn
	GROUP BY fname, lname
	HAVING COUNT(essn)>1

