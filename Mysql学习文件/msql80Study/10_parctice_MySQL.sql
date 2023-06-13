/*
10_parctice_MySQL
多表查询-1
【题目】
# 1.显示所有员工的姓名，部门号和部门名称。
# 2.查询90号部门员工的job_id和90号部门的location_id
# 3.选择所有有奖金的员工的 last_name , department_name , location_id , city
# 4.选择city在Toronto工作的员工的 last_name , job_id , department_id , department_name
# 5.查询员工所在的部门名称、部门地址、姓名、工作、工资，其中员工所在部门的部门名称为’Executive’
# 6.选择指定员工的姓名，员工号，以及他的管理者的姓名和员工号，结果类似于下面的格式
-- employees Emp# manager Mgr#
-- kochhar 101 king 100
# 7.查询哪些部门没有员工
# 8. 查询哪个城市没有部门
# 9. 查询部门名为 Sales 或 IT 的员工信息

*/

# 1.显示所有员工的姓名，部门号和部门名称。
SELECT e.last_name,d.department_id, d.department_name 
FROM employees e LEFT JOIN departments d
ON e.`department_id` = d.`department_id`;

# 2.查询90号部门员工的job_id和90号部门的location_id
SELECT e.last_name,e.`job_id`
FROM employees e JOIN departments d
ON e.`department_id` = d.`department_id`
WHERE e.`department_id` = 90;

SELECT job_id,location_id
FROM employees e,departments d
WHERE e.`department_id`=d.`department_id` AND e.`department_id`=90;

DESC employees;
DESC departments;
DESC locations;

# 3.选择所有有奖金的员工的 last_name , department_name , location_id , city
SELECT e.last_name,d.department_name , l.location_id , l.city
FROM employees e LEFT JOIN departments d
ON d.`department_id` = e.`department_id` 
LEFT JOIN locations l
ON l.`location_id` = d.`location_id`
WHERE e.commission_pct IS NOT NULL;

# 4.选择city在Toronto工作的员工的 last_name , job_id , department_id , department_name
SELECT e.last_name , e.job_id , d.department_id , d.department_name
FROM employees e JOIN departments d
ON e.`department_id` = d.`department_id`
JOIN locations l
ON l.`location_id` = d.`location_id` AND l.`city` = 'Toronto';

SELECT e.last_name , e.job_id , e.department_id , d.department_name
FROM employees e, departments d, locations l
WHERE e.`department_id` = d.`department_id`
AND d.`location_id` = l.`location_id`
AND city = 'Toronto';

# 5.查询员工所在的部门名称、部门地址、姓名、工作、工资，其中员工所在部门的部门名称为’Executive’
SELECT d.department_name, l.street_address, e.last_name,e.job_id,e.salary
FROM departments d JOIN employees e JOIN locations l
ON d.`department_id` = e.`department_id` AND d.`location_id` = l.`location_id`
WHERE d.`department_name` = 'Executive';

# 6.选择指定员工的姓名，员工号，以及他的管理者的姓名和员工号，结果类似于下面的格式
-- employees Emp# manager Mgr#
-- kochhar   101   king   100
SELECT emp.last_name "employees", emp.employee_id "Emp#", mgr.last_name "manager", mgr.employee_id "Mgr#"
FROM employees emp LEFT JOIN employees mgr
ON emp.manager_id = mgr.employee_id;

# 7.查询哪些部门没有员工
SELECT d.`department_id`, d.`department_name`
FROM departments d LEFT JOIN employees l
ON l.`department_id` = d.`department_id` 
WHERE l.`department_id` IS NULL;

#方式2：
SELECT department_id
FROM departments d
WHERE NOT EXISTS (
	SELECT *
	FROM employees e
	WHERE e.`department_id` = d.`department_id`
)

# 8. 查询哪个城市没有部门
SELECT city
FROM locations l LEFT JOIN departments d
ON l.location_id = d.`location_id`
WHERE d.`department_id` IS NULL;

# 9. 查询部门名为 Sales 或 IT 的员工信息
SELECT e.`employee_id`, e.`last_name`, e.`department_id`
FROM employees e JOIN departments d
ON e.`department_id` = d.`department_id`
WHERE d.`department_name` IN ('Sales', 'IT');

SELECT employee_id,last_name,department_name
FROM employees e,departments d
WHERE e.department_id = d.`department_id`
AND d.`department_name` IN ('Sales','IT');

