SELECT 
    first_name, last_name
FROM
    employees;
    
SELECT 
    *
FROM
    employees;
    
SELECT 
    dept_no
FROM
    departments;
    
SELECT 
    *
FROM
    departments;

SELECT 
    *
FROM
    employees
WHERE
    first_name = 'Denis';
    
SELECT 
    *
FROM
    employees
WHERE
    first_name = 'Elvis' AND gender = 'M';
    
SELECT 
    *
FROM
    employees
WHERE
    first_name = '' OR 1 = 1;SELECT 
    *
FROM
    employees
WHERE
    first_name = 'kellie'
        OR first_name = 'Aruna';

SELECT 
    *
FROM
    employees
WHERE
    last_name = 'Denis'
        AND (gender = 'M' OR gender = 'F');
    
SELECT 
    *
FROM
    employees
WHERE
    gender = 'F'
        AND (first_name = 'Kellie'
        OR first_name = 'Aruna');
        
SELECT 
    *
FROM
    employees
WHERE
    first_name NOT IN ('John' , 'Mark', 'Jacob');
    
SELECT 
    *
FROM
    employees
WHERE
    first_name LIKE ('Mar%')
        AND hire_date LIKE ('%2000%');
        
SELECT 
    *
FROM
    employees
WHERE
    emp_no LIKE ('1000_');
    
SELECT 
    *
FROM
    employees
WHERE
    hire_date LIKE ('%2000%');
        
SELECT 
    *
FROM
    employees
WHERE
    first_name LIKE ('%jack%');

SELECT 
    *
FROM
    employees
WHERE
    hire_date NOT BETWEEN '1990-01-01' AND '2000-01-01';

SELECT 
    *
FROM
    salaries
WHERE
    salary BETWEEN '60000' AND '70000';

SELECT 
    *
FROM
    employees
WHERE
    first_name IS NOT NULL;
    
SELECT 
    *
FROM
    employees
WHERE
    hire_date >= '2000-01-01'
        AND gender = 'F';
    
SELECT 
    *
FROM
    salaries
WHERE
    salary > '150000';

SELECT DISTINCT
    hire_date
FROM
    employees;

SELECT 
    COUNT(salary)
FROM
    salaries;
SELECT 
    COUNT(emp_no)
FROM
    employees;
SELECT 
    COUNT(DISTINCT first_name)
FROM
    employees;
SELECT 
    COUNT(salary)
FROM
    salaries
WHERE
    salary >= '100000';
SELECT 
    COUNT(*)
FROM
    dept_manager;

SELECT 
    *
FROM
    employees
ORDER BY hire_date DESC;
SELECT 
    first_name
FROM
    employees
GROUP BY first_name;

SELECT DISTINCT
    first_name
FROM
    employees;
SELECT 
    first_name, COUNT(first_name) AS names_count
FROM
    employees
GROUP BY first_name
ORDER BY names_count ASC;

SELECT 
    salary, COUNT(salary) AS emps_with_same_salary
FROM
    salaries
WHERE
    salary >= '80000'
GROUP BY salary
ORDER BY salary ASC;
SELECT 
    first_name, COUNT(first_name) AS names_count
FROM
    employees
GROUP BY first_name
HAVING COUNT(first_name) > 250
ORDER BY names_count ASC;

SELECT 
    *
FROM
    salaries;

SELECT 
    AVG(salary)
FROM
    salaries;
    
SELECT 
    emp_no, AVG(salary) AS Average_Salary
FROM
    salaries
GROUP BY emp_no
HAVING AVG(salary) > 120000
ORDER BY Average_Salary;

SELECT 
    first_name, COUNT(first_name) AS names_count
FROM
    employees
WHERE
    hire_date > '1999-01-01'
GROUP BY first_name
HAVING COUNT(first_name) < 200
ORDER BY first_name ASC;

SELECT 
    emp_no
FROM
    dept_emp
WHERE
    from_date > '2000-01-01'
GROUP BY emp_no
HAVING COUNT(from_date) > 1
ORDER BY emp_no;

SELECT 
    COUNT(DISTINCT dept_no)
FROM
    dept_emp;
    
SELECT 
    SUM(salary)
FROM
    salaries
WHERE
    from_date > '1997-01-01';
    
SELECT 
    MAX(emp_no)
FROM
    employees;

DROP TABLE IF EXISTS departments_dup;

CREATE TABLE departments_dup (
    dept_no CHAR(4) NULL,
    dept_name VARCHAR(40) NULL
);

INSERT INTO departments_dup
(dept_no, dept_name)SELECT * FROM departments;

INSERT INTO departments_dup (dept_name) VALUES ('Public Relations');

DELETE FROM departments_dup 
WHERE
    dept_no = 'd002';
INSERT INTO departments_dup(dept_no) VALUES ('d010'), ('d011');


DROP TABLE IF EXISTS dept_manager_dup;
CREATE TABLE dept_manager_dup (
    emp_no INT(11) NOT NULL,
    dept_no CHAR(4) NULL,
    from_date DATE NOT NULL,
    to_date DATE NULL
);

INSERT INTO dept_manager_dup select * from dept_manager;

INSERT INTO dept_manager_dup (emp_no, from_date) VALUES (999904, '2017-01-01'),(999905, '2017-01-01'),(999906, '2017-01-01'), (999907, '2017-01-01');

DELETE FROM dept_manager_dup 
WHERE
    dept_no = 'd001';
    
SELECT 
    *
FROM
    dept_manager_dup
ORDER BY dept_no;

SELECT 
    *
FROM
    departments_dup
ORDER BY dept_no;

SELECT 
    m.dept_no, m.emp_no, d.dept_name
FROM
    dept_manager_dup m
        INNER JOIN
    departments_dup d ON m.dept_no = d.dept_no
ORDER BY m.dept_no;

SELECT 
    e.emp_no, e.first_name, e.last_name, m.dept_no, e.hire_date
FROM
    employees e
        INNER JOIN
    dept_manager_dup m ON e.emp_no = m.emp_no
ORDER BY e.emp_no;

SELECT 
    m.dept_no, m.emp_no, d.dept_name
FROM
    dept_manager_dup m
        LEFT JOIN
    departments_dup d ON m.dept_no = d.dept_no
ORDER BY m.dept_no;

SELECT 
    d.dept_no, m.emp_no, d.dept_name
FROM
    departments_dup d
        LEFT JOIN
    dept_manager_dup m ON m.dept_no = d.dept_no
WHERE
    dept_name = 'production'
ORDER BY d.dept_no;

SELECT 
    e.emp_no, e.first_name, e.last_name, m.dept_no, m.from_date
FROM
    employees e
        LEFT JOIN
    dept_manager_dup m ON e.emp_no = m.emp_no
WHERE
    last_name = 'Markovitch'
ORDER BY m.dept_no DESC , m.emp_no;

SELECT 
    d.dept_no, m.emp_no, d.dept_name
FROM
    dept_manager_dup m
        RIGHT JOIN
    departments_dup d ON m.dept_no = d.dept_no
ORDER BY dept_no;

SELECT 
    d.dept_no, m.emp_no, d.dept_name
FROM
    departments_dup d,
    dept_manager_dup m
WHERE
    m.dept_no = d.dept_no
ORDER BY d.dept_no;

SELECT 
    e.emp_no, e.first_name, e.last_name, m.dept_no, e.hire_date
FROM
    employees e,
    dept_manager_dup m
WHERE
    e.emp_no = m.emp_no
ORDER BY m.dept_no DESC , m.emp_no;

SELECT @@GLOBAL .sql_mode;

# Query to prevent Error Code 1055
SET @@global.sql_mode := replace(@@global.sql_mode, 'ONLY_FULL_GROUP_BY', '');

SELECT @@GLOBAL .sql_mode;

SELECT 
    e.emp_no, e.first_name, e.last_name, t.title, e.hire_date
FROM
    employees e,
    titles t
WHERE
    e.emp_no = t.emp_no
        AND first_name = 'Margareta'
        AND last_name = 'Markovitch'
ORDER BY e.emp_no DESC , t.title;

SELECT 
    e.emp_no, e.first_name, e.last_name, t.title, e.hire_date
FROM
    employees e
        JOIN
    titles t ON e.emp_no = t.emp_no
WHERE
    first_name = 'Margareta'
        AND last_name = 'Markovitch'
ORDER BY e.emp_no DESC , t.title;

SELECT 
    dm.*, d.*
FROM
    dept_manager dm
        CROSS JOIN
    departments d
ORDER BY dm.emp_no , d.dept_no;

SELECT 
    dm.*, d.*
FROM
    departments d
        CROSS JOIN
    dept_manager dm
WHERE
    d.dept_no <> dm.dept_no
ORDER BY dm.emp_no , d.dept_no;

SELECT 
    e.*, d.*
FROM
    departments d
        CROSS JOIN
    dept_manager dm
        JOIN
    employees e ON dm.emp_no = e.emp_no
WHERE
    d.dept_no <> dm.dept_no
ORDER BY dm.emp_no , d.dept_no;

SELECT 
    dm.*, d.*
FROM
    dept_manager dm
        CROSS JOIN
    departments d
WHERE
    d.dept_no = 'd009'
ORDER BY dm.emp_no;

SELECT 
    e.*, d.*
FROM
    employees e
        CROSS JOIN
    departments d
WHERE
    e.emp_no < '10011'
ORDER BY e.emp_no , d.dept_name;

SELECT 
    e.gender, AVG(s.salary) AS average_salary
FROM
    employees e
        JOIN
    salaries s ON e.emp_no = s.emp_no
GROUP BY gender;

SELECT 
    e.first_name,
    e.last_name,
    e.hire_date,
    dm.from_date,
    d.dept_name
FROM
    employees e
        JOIN
    dept_manager dm ON e.emp_no = dm.emp_no
        JOIN
    departments d ON dm.dept_no = d.dept_no;
    
SELECT 
    e.first_name,
    e.last_name,
    e.hire_date,
    t.title,
    dm.from_date,
    d.dept_name
FROM
    employees e
        JOIN
    titles t ON e.emp_no = t.emp_no
        JOIN
    dept_manager dm ON t.emp_no = dm.emp_no
        JOIN
    departments d ON dm.dept_no = d.dept_no
WHERE
    t.title = 'Manager'
ORDER BY e.first_name;

SELECT 
    d.dept_name, AVG(s.salary) AS average_salary
FROM
    departments d
        JOIN
    dept_manager dm ON d.dept_no = dm.dept_no
        JOIN
    salaries s ON dm.emp_no = s.emp_no
GROUP BY d.dept_name
ORDER BY average_salary DESC;

SELECT 
    d.dept_name, AVG(s.salary) AS average_salary
FROM
    departments d
        JOIN
    dept_manager dm ON d.dept_no = dm.dept_no
        JOIN
    salaries s ON dm.emp_no = s.emp_no
GROUP BY d.dept_name
HAVING average_salary > 60000
ORDER BY average_salary DESC;

SELECT 
    e.gender, COUNT(e.gender) AS number_of_managers
FROM
    employees e
        JOIN
    titles t ON e.emp_no = t.emp_no
WHERE
    title = 'Manager'
GROUP BY e.gender;

SELECT 
    e.gender, COUNT(dm.emp_no) AS number_of_managers
FROM
    employees e
        JOIN
    dept_manager dm ON e.emp_no = dm.emp_no
GROUP BY e.gender;

DROP TABLE IF EXISTS employees_dup;

CREATE TABLE employees_dup (
    emp_no INT(11),
    birth_date DATE,
    first_name VARCHAR(14),
    last_name VARCHAR(16),
    gender ENUM('M', 'F'),
    hire_date DATE
);

INSERT INTO employees_dup
SELECT
	e.*
FROM
	employees e
LIMIT 20;

SELECT 
    *
FROM
    employees_dup;
    
INSERT INTO employees_dup VALUES
('10001', '1953-09-02', 'Georgi', 'Facello', 'M', '1986-06-26');

SELECT 
    e.emp_no,
    e.first_name,
    e.last_name,
    NULL AS dept_no,
    NULL AS from_date
FROM
    employees_dup e
WHERE
    e.emp_no = 10001 
UNION ALL SELECT 
    NULL AS emp_no,
    NULL AS first_name,
    NULL AS last_name,
    dm.dept_no,
    dm.from_date
FROM
    dept_manager dm;
    
SELECT 
    e.emp_no,
    e.first_name,
    e.last_name,
    NULL AS dept_no,
    NULL AS from_date
FROM
    employees_dup e
WHERE
    e.emp_no = 10001 
UNION SELECT 
    NULL AS emp_no,
    NULL AS first_name,
    NULL AS last_name,
    dm.dept_no,
    dm.from_date
FROM
    dept_manager dm;
    
SELECT 
    *
FROM
    (SELECT 
        e.emp_no,
            e.first_name,
            e.last_name,
            NULL AS dept_no,
            NULL AS from_date
    FROM
        employees e
    WHERE
        last_name = 'Denis' UNION SELECT 
        NULL AS emp_no,
            NULL AS first_name,
            NULL AS last_name,
            dm.dept_no,
            dm.from_date
    FROM
        dept_manager dm) AS a
ORDER BY - a.emp_no DESC;

SELECT 
    e.first_name, e.last_name
FROM
    employees e
WHERE
    e.emp_no IN (SELECT 
            dm.emp_no
        FROM
            dept_manager dm);
            
SELECT 
    e.first_name, e.last_name
FROM
    employees e
        JOIN
    dept_manager dm ON e.emp_no = dm.emp_no;
    
SELECT 
    *
FROM
    dept_manager
WHERE
    emp_no IN (SELECT 
            emp_no
        FROM
            employees
        WHERE
            hire_date BETWEEN '1990-01-01' AND '1995-01-01');
            
SELECT 
    *
FROM
    employees e
WHERE
    e.emp_no IN (SELECT 
            dm.emp_no
        FROM
            dept_manager dm
        WHERE
            hire_date BETWEEN '1990-01-01' AND '1995-01-01');

SELECT 
    e.first_name, e.last_name
FROM
    employees e
WHERE
    EXISTS( SELECT 
            *
        FROM
            dept_manager dm
        WHERE
            e.emp_no = dm.emp_no)
ORDER BY e.emp_no;


SELECT 
    *
FROM
    employees e
WHERE
    EXISTS( SELECT 
            *
        FROM
            titles t
        WHERE
            t.emp_no = e.emp_no
                AND title = 'Assistant Engineer');

SELECT 
    A.*
FROM
    (SELECT 
        e.emp_no AS employee_ID,
            MIN(d.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110022) AS manager_ID
    FROM
        employees e
    JOIN dept_emp d ON e.emp_no = d.emp_no
    WHERE
        e.emp_no <= 10020
    GROUP BY e.emp_no
    ORDER BY e.emp_no) AS A 
UNION SELECT 
    B.*
FROM
    (SELECT 
        e.emp_no AS employee_ID,
            MIN(d.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110039) AS manager_ID
    FROM
        employees e
    JOIN dept_emp d ON e.emp_no = d.emp_no
    WHERE
        e.emp_no >= 10021
    GROUP BY e.emp_no
    ORDER BY e.emp_no
    LIMIT 20) AS B;
    
    
   
DROP TABLE IF EXISTS emp_manager;

CREATE TABLE emp_manager (
    emp_no INT(11) NOT NULL,
    dept_no CHAR(4) NULL,
    manager_no INT(11) NOT NULL
);



INSERT INTO emp_manager SELECT U.* from (SELECT A.* FROM 
(SELECT 
        e.emp_no AS emp_no,
            MIN(d.dept_no) AS dept_no,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110022) AS manager_no
    FROM
        employees e
    JOIN dept_emp d ON e.emp_no = d.emp_no
    WHERE
        e.emp_no <= 10020
    GROUP BY e.emp_no
    ORDER BY e.emp_no) AS A 
UNION SELECT 
    B.*
FROM
    (SELECT 
        e.emp_no AS emp_no,
            MIN(d.dept_no) AS dept_no,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110039) AS manager_no
    FROM
        employees e
    JOIN dept_emp d ON e.emp_no = d.emp_no
    WHERE
        e.emp_no >= 10021
    GROUP BY e.emp_no
    ORDER BY e.emp_no
    LIMIT 20) AS B
UNION SELECT 
    C.*
FROM
    (SELECT 
        e.emp_no AS emp_no,
            MIN(d.dept_no) AS dept_no,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110039) AS manager_no
    FROM
        employees e
    JOIN dept_emp d ON e.emp_no = d.emp_no
    WHERE
        e.emp_no = 110022
    GROUP BY e.emp_no
    ORDER BY e.emp_no) AS C
UNION SELECT 
	D.* 
FROM
    (SELECT 
        e.emp_no AS emp_no,
            MIN(d.dept_no) AS dept_no,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110022) AS manager_no
    FROM
        employees e
    JOIN dept_emp d ON e.emp_no = d.emp_no
    WHERE
        e.emp_no = 110039
    GROUP BY e.emp_no
    ORDER BY e.emp_no) AS D) AS U ;

SELECT 
    *
FROM
    emp_manager;

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
    
SELECT 
    emp_no,
    first_name,
    last_name,
    CASE
        WHEN gender = 'M' THEN 'Male'
        ELSE 'Female'
    END AS gender
FROM
    employees;
    
SELECT 
    emp_no,
    first_name,
    last_name,
    CASE gender
        WHEN 'M' THEN 'Male'
        ELSE 'Female'
    END AS gender
FROM
    employees;
    
    
SELECT 
    e.emp_no,
    e.first_name,
    e.last_name,
    CASE
        WHEN dm.emp_no IS NOT NULL THEN 'Manager'
        ELSE 'Employee'
    END AS is_manager
FROM
    employees e
        LEFT JOIN
    dept_manager dm ON dm.emp_no = e.emp_no
WHERE
    e.emp_no > 109990;

SELECT 
    emp_no,
    first_name,
    last_name,
    IF(gender = 'M', 'Male', 'Female') AS gender
FROM
    employees;
    
SELECT 
    dm.emp_no,
    e.first_name,
    e.last_name,
    MAX(s.salary) - MIN(s.salary) AS salary_difference,
    CASE
        WHEN MAX(s.salary) - MIN(s.salary) > 30000 THEN 'Salary was raised by more than $30,000'
        WHEN MAX(s.salary) - MIN(s.salary) BETWEEN 20000 AND 30000 THEN 'Salary was raised by more than $20,000 but less than $30,000'
        ELSE 'Salary was raised by less than $20,000'
    END AS salary_increase
FROM
    dept_manager dm
        JOIN
    employees e ON e.emp_no = dm.emp_no
        JOIN
    salaries s ON s.emp_no = dm.emp_no
GROUP BY s.emp_no;

SELECT 
    dm.emp_no,
    e.first_name,
    e.last_name,
    MAX(s.salary) - MIN(s.salary) AS salary_difference,
    CASE
         WHEN MAX(s.salary) - MIN(s.salary) > 30000 THEN 'Salary was raised by more than $30,000'
        ELSE 'Salary was NOT raised by more than $30,000'
    END AS salary_raise
FROM
    dept_manager dm
        JOIN
    employees e ON e.emp_no = dm.emp_no
        JOIN
    salaries s ON s.emp_no = dm.emp_no
GROUP BY s.emp_no;



SELECT 
    dm.emp_no,
    e.first_name,
    e.last_name,
    MAX(s.salary) - MIN(s.salary) AS salary_difference,
    IF (MAX(s.salary) - MIN(s.salary) > 30000, 'Salary was raised by more than $30,000', 'Salary was NOT raised by more than $30,000')
	AS salary_raise
FROM
    dept_manager dm
        JOIN
    employees e ON e.emp_no = dm.emp_no
        JOIN
    salaries s ON s.emp_no = dm.emp_no
GROUP BY s.emp_no;

SELECT 
    e.emp_no,
    e.first_name,
    e.last_name,
    CASE
        WHEN de.to_date = '9999-01-01' THEN 'Is still employed'
        ELSE 'Not an employee anymore'
    END AS current_employee
FROM
    employees e
        LEFT JOIN
    dept_emp de ON de.emp_no = e.emp_no
ORDER BY de.emp_no
LIMIT 100;

SELECT
    e.emp_no,
    e.first_name,
    e.last_name,
    CASE
        WHEN MAX(de.to_date) > SYSDATE() THEN 'Is still employed'
        ELSE 'Not an employee anymore'
    END AS current_employee
FROM
    employees e
        JOIN
    dept_emp de ON de.emp_no = e.emp_no
GROUP BY de.emp_no
LIMIT 100;

SELECT SYSDATE() AS CurrentDateTime;