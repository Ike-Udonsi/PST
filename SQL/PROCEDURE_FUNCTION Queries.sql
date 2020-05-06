# NON-PARAMETRIC PROCEDURES: 
USE employees;
DROP PROCEDURE IF EXISTS select_employees;

DELIMITER $$
USE employees $$
CREATE PROCEDURE select_employees()
BEGIN
SELECT * FROM employees
LIMIT 1000;
END$$

DELIMITER ;
CALL employees.select_employees();
CALL select_employees();

# Create a procedure that will provide the average salary of all employees.
USE employees;
DROP PROCEDURE IF EXISTS avg_salary;

DELIMITER $$
CREATE PROCEDURE avg_salary() 
BEGIN 
SELECT AVG(salary) FROM salaries; 
END$$ 

DELIMITER ;
CALL avg_salary;
CALL avg_salary();
CALL employees.avg_salary();

# PARAMETRIC PROCEDURES:
USE employees;
DROP PROCEDURE IF EXISTS emp_salary;

DELIMITER $$
USE employees $$
CREATE PROCEDURE emp_salary(IN p_emp_no INTEGER)
BEGIN
SELECT e.first_name, e.last_name, s.salary, s.from_date, s.to_date
FROM employees e
JOIN salaries s ON e.emp_no = s.emp_no
WHERE e.emp_no = p_emp_no;
END $$
DELIMITER ;

CALL employees.emp_salary(11300);

#Procedures with one input parameter can be used with aggregate functions too.

USE employees;
DROP PROCEDURE IF EXISTS emp_avg_salary;

DELIMITER $$
USE employees $$
CREATE PROCEDURE emp_avg_salary(IN p_emp_no INTEGER)
BEGIN
SELECT e.first_name, e.last_name, AVG(s.salary)
FROM employees e
JOIN salaries s ON e.emp_no = s.emp_no
WHERE e.emp_no = p_emp_no;
END $$
DELIMITER ;

CALL employees.emp_avg_salary(11300);

# STORED PROCEDURES WITH AN OUTPUT PARAMETER: 
USE employees;
DROP PROCEDURE IF EXISTS emp_avg_salary_out;

DELIMITER $$
USE employees $$
CREATE PROCEDURE emp_avg_salary_out(IN p_emp_no INTEGER, OUT p_avg_salary DECIMAL(10,2))
BEGIN
SELECT AVG(s.salary)
INTO p_avg_salary
FROM employees e
JOIN salaries s ON e.emp_no = s.emp_no
WHERE e.emp_no = p_emp_no;
END $$
DELIMITER ;

CALL employees.emp_avg_salary_out(11300, @p_avg_salary);
SELECT @p_avg_salary;

# Create a procedure called ‘emp_info’ that uses as parameters the first and 
# the last name of an individual, and returns their employee number.
USE employees;
DROP PROCEDURE IF EXISTS emp_info;

DELIMITER $$
USE employees $$
CREATE PROCEDURE emp_info(IN p_first_name VARCHAR(14), IN p_last_name VARCHAR(16), OUT p_emp_no INTEGER)
BEGIN
SELECT e.emp_no
INTO p_emp_no
FROM employees e
WHERE e.first_name = p_first_name AND e.last_name = p_last_name;
END $$
DELIMITER ;

CALL employees.emp_info('lillian', 'fontet', @p_emp_no);
SELECT @p_emp_no;

#SQL Variables
SET @v_avg_salary = 0;
CALL employees.emp_avg_salary_out(11300, @v_avg_salary);
SELECT @v_avg_salary;

SET @v_emp_no = 0;
CALL employees.emp_info('Aruna', 'Journel', @v_emp_no);
SELECT @v_emp_no;

# User-Defined Functions in MySQL 
USE employees;
DROP FUNCTION IF EXISTS f_emp_avg_salary;

DELIMITER $$
USE employees $$
CREATE FUNCTION f_emp_avg_salary (p_emp_no INTEGER) RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
DECLARE v_avg_salary DECIMAL(10,2);
SELECT AVG(s.salary)
INTO v_avg_salary
FROM employees e
JOIN salaries s ON e.emp_no = s.emp_no
WHERE e.emp_no = p_emp_no;
RETURN v_avg_salary;
END $$
DELIMITER ;

SELECT F_EMP_AVG_SALARY(11300);


# Create a function called ‘emp_info’ that takes for parameters the first and 
# last name of an employee, and returns the salary from the newest contract of that employee.
USE employees;
DROP FUNCTION IF EXISTS emp_info;

DELIMITER $$
USE employees $$
CREATE FUNCTION emp_info (p_first_name VARCHAR(200), p_last_name VARCHAR(200)) RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
DECLARE v_max_from_date DATE;
DECLARE v_salary DECIMAL(10,2);
SELECT MAX(s.from_date)
INTO v_max_from_date
FROM employees e
JOIN salaries s ON e.emp_no = s.emp_no
WHERE e.first_name = p_first_name AND e.last_name = p_last_name;
SELECT s.salary
INTO v_salary
FROM employees e
JOIN salaries s ON e.emp_no = s.emp_no
WHERE e.first_name = p_first_name AND e.last_name = p_last_name AND s.from_date = v_max_from_date;
RETURN v_salary;
END $$
DELIMITER ;

SELECT EMP_INFO('Aruna', 'Journel');

# A function may be included as of the columns inside a SELECT statement.
SET @v_emp_no = 11300;
SELECT 
    emp_no,
    first_name,
    last_name,
    F_EMP_AVG_SALARY(@v_emp_no) AS avg_salary
FROM
    employees
WHERE
    emp_no = @v_emp_no;