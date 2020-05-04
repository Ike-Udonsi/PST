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

