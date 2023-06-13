/*
08_parctice_MySQL

# 第06章_多表查询

对查询的优化，提高查询的效率


*/

-- 熟悉数据库表的情况
SHOW TABLES;
/*
	countries            
	departments          
	emp_details_view     
	employees            
	job_grades           
	job_history          
	jobs                 
	locations            
	order                
	regions              
*/
DESCRIBE employees;
DESC departments;
DESC locations;
DESC countries;
DESC emp_details_view;
DESC job_grades;
DESC job_history;

# 查询员工 Abel 工作的城市
SELECT * FROM employees
WHERE last_name = 'Abel';

SELECT * FROM departments
WHERE department_id = 80;

SELECT * FROM locations
WHERE location_id = 2500;

# 这里会出现笛卡儿积错误也称交叉连接错误
SELECT last_name,department_name 
FROM employees, departments;
-- or
SELECT last_name,department_name 
FROM employees CROSS JOIN departments;

# 有n个表,需要n-1个连接条件
SELECT e.last_name,d.department_name 
FROM employees e,departments d
WHERE e.`department_id` = d.`department_id`;

SELECT e.last_name,d.department_name,l.location_id,l.city
FROM employees e,departments d, locations l
WHERE e.`department_id` = d.`department_id`
AND d.`location_id` = l.`location_id`;


/*
多表查询的分类:
角度1: 等值连接 vs 非等值连接
角度2：自连接 vs 非自连接
角度3：内连接 vs 外连接
*/

-- 角度1: 等值连接 vs 非等值连接
-- 等值连接
SELECT e.last_name,d.department_name,l.location_id,l.city
FROM employees e,departments d, locations l
WHERE e.`department_id` = d.`department_id`
AND d.`location_id` = l.`location_id`; 
-- 非等值连接
SELECT * FROM `job_grades`;
SELECT e.last_name,e.salary, jgr.grade_level
FROM employees e, job_grades jgr
WHERE salary BETWEEN jgr.`lowest_sal` AND jgr.`highest_sal`;

-- 角度2：自连接 vs 非自连接
-- ? 查询员工的id 和 姓名, 和 他的 管理者的id 和姓名
SELECT emp.employee_id,emp.last_name,mgr.employee_id mgr_id,mgr.last_name mgr_name
FROM employees AS emp, employees AS mgr
WHERE emp.`manager_id` = mgr.`employee_id`;

-- 角度3：内连接 vs 外连接
/*
内连接: 合并具有同一列的两个以上的表的行, 
	结果集中不包含一个表与另一个表不匹配的行。（共有的部分）

外连接: 两个表在连接过程中除了返回满足连接条件的行以外
	还返回左（或右）表中不满足条件的行 ，这种连接称为左（或右） 外连接。
	没有匹配的行时, 结果表中相应的列为空(NULL)。
如果是左外连接，则连接条件中左边的表也称为 主表 ，右边的表称为 从表 。
如果是右外连接，则连接条件中右边的表也称为 主表 ，左边的表称为 从表 。
 
 外连接分类:
     左外连接
     右外连接
     满外连接
*/

-- 内连接
SELECT e.last_name,d.department_name 
FROM employees e,departments d
WHERE e.`department_id` = d.`department_id`;  # 共有的部分是106条记录
-- SQL99的语法实现---内连接:
SELECT e.last_name,d.department_name 
FROM employees e JOIN departments d
ON e.`department_id` = d.`department_id`;

SELECT e.last_name,d.department_name,l.city
FROM employees e JOIN departments d
ON e.`department_id` = d.`department_id`
JOIN locations l 
ON d.`location_id` = l.`location_id`;

SELECT e.last_name,d.department_name,l.city
FROM employees e INNER JOIN departments d
ON e.`department_id` = d.`department_id`
JOIN locations l 
ON d.`location_id` = l.`location_id`;


-- 外连接
-- 练习查询所有员工的last_name,department_name的信息
SELECT e.last_name,d.department_name
FROM employees e LEFT JOIN departments d 
ON e.`department_id` = d.`department_id`;

-- 左外连接
SELECT e.last_name,d.department_name
FROM employees e LEFT OUTER JOIN departments d 
ON e.`department_id` = d.`department_id`;

-- 右外连接
SELECT e.last_name,d.department_name
FROM employees e RIGHT OUTER JOIN departments d 
ON e.`department_id` = d.`department_id`;

-- 满外连接
SELECT e.last_name,d.department_name
FROM employees e JOIN departments d 
ON e.`department_id` = d.`department_id`;


-- UNION  : 会自动去重
-- UNION ALL :不会去重

-- 7 种 JOIN 的图
-- 内连接: 中图
SELECT e.last_name,d.department_name 
FROM employees e JOIN departments d
ON e.`department_id` = d.`department_id`;
-- 左外连接: 左上图
SELECT e.last_name,d.department_name 
FROM employees e LEFT JOIN departments d
ON e.`department_id` = d.`department_id`;
-- 右外连接: 右上图
SELECT e.last_name,d.department_name 
FROM employees e RIGHT JOIN departments d
ON e.`department_id` = d.`department_id`;
-- 左中图:
SELECT e.last_name,d.department_name 
FROM employees e LEFT JOIN departments d
ON e.`department_id` = d.`department_id`
WHERE d.`department_id` IS NULL;
-- 右中图:
SELECT e.last_name,d.department_name 
FROM employees e RIGHT JOIN departments d
ON e.`department_id` = d.`department_id`
WHERE e.`department_id` IS NULL;

-- 左下图: 满外连接  左上图 UNION ALL 右中图
SELECT e.last_name,d.department_name 
FROM employees e LEFT JOIN departments d
ON e.`department_id` = d.`department_id`
UNION ALL
SELECT e.last_name,d.department_name 
FROM employees e RIGHT JOIN departments d
ON e.`department_id` = d.`department_id`
WHERE e.`department_id` IS NULL;

-- 右下图: 左中图 UNION ALL 右中图
SELECT e.last_name,d.department_name 
FROM employees e LEFT JOIN departments d
ON e.`department_id` = d.`department_id`
WHERE d.`department_id` IS NULL
UNION ALL
SELECT e.last_name,d.department_name 
FROM employees e RIGHT JOIN departments d
ON e.`department_id` = d.`department_id`
WHERE e.`department_id` IS NULL;























