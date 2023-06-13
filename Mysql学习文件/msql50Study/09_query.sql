SELECT * FROM departments;
SELECT * FROM `dept_emp`;
SELECT * FROM `dept_manager`;
SELECT * FROM `employees`;
SELECT * FROM `salaries`;
SELECT * FROM `titles`;

SELECT emp_no,salary
FROM salaries 
WHERE salary>110000 OR salary<10000;

SELECT emp_no,salary
FROM salaries 
WHERE salary NOT BETWEEN 10000 AND 130000;


SELECT emp_no
FROM dept_manager
WHERE dept_no = "d004" OR dept_no = "d007";
# or
SELECT emp_no
FROM dept_manager
WHERE dept_no IN("d004","d007");

SELECT emp_no,salary
FROM salaries 
WHERE salary IS NULL;
# or
SELECT emp_no,salary
FROM salaries
WHERE salary IS NULL;