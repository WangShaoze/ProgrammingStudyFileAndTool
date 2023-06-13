/*
09_parctice_MySQL

练习: 7种 JOIN 的实现
*/

SELECT * FROM employees;
SELECT * FROM departments;
SELECT * FROM locations;

-- 中图
SELECT e.`department_id`, d.`department_id`,d.`department_name`
FROM employees e JOIN departments d
ON d.`department_id` = e.`department_id`;

-- 左上图
SELECT e.`department_id`, d.`department_id`,d.`department_name`
FROM employees e LEFT JOIN departments d
ON d.`department_id` = e.`department_id`;

-- 右上图
SELECT e.`department_id`, d.`department_id`,d.`department_name`
FROM employees e RIGHT JOIN departments d
ON d.`department_id` = e.`department_id`;

-- 左中图
SELECT e.`department_id`, d.`department_id`,d.`department_name`
FROM employees e LEFT JOIN departments d
ON d.`department_id` = e.`department_id`
WHERE d.`department_id` IS NULL;

-- 右中图
SELECT e.`department_id`, d.`department_id`,d.`department_name`
FROM employees e RIGHT JOIN departments d
ON d.`department_id` = e.`department_id`
WHERE e.`department_id` IS NULL;

-- 左下图
SELECT e.`department_id`, d.`department_id`,d.`department_name`
FROM employees e RIGHT JOIN departments d
ON d.`department_id` = e.`department_id`
UNION ALL
SELECT e.`department_id`, d.`department_id`,d.`department_name`
FROM employees e LEFT JOIN departments d
ON d.`department_id` = e.`department_id`
WHERE d.`department_id` IS NULL;

-- 右下图
SELECT e.`department_id`, d.`department_id`,d.`department_name`
FROM employees e LEFT JOIN departments d
ON d.`department_id` = e.`department_id`
WHERE d.`department_id` IS NULL
UNION ALL
SELECT e.`department_id`, d.`department_id`,d.`department_name`
FROM employees e RIGHT JOIN departments d
ON d.`department_id` = e.`department_id`
WHERE e.`department_id` IS NULL;

-- SQL99语法新特性:
-- 1.自然连接
-- 原来的写法:
SELECT e.last_name, d.department_id,d.department_name
FROM employees e JOIN departments d
ON d.`department_id` = e.`department_id`
AND d.`manager_id` = e.`manager_id`;
-- 新的写法；
SELECT e.last_name, d.department_id,d.department_name
FROM employees e NATURAL JOIN departments d;

-- 2.USING的使用,很好，但是不适用自连接的情况
-- 原来的写法
SELECT e.last_name, d.department_id,d.department_name
FROM employees e JOIN departments d
ON d.`department_id` = e.`department_id`;
-- 使用using
SELECT e.last_name, d.department_id,d.department_name
FROM employees e JOIN departments d
USING(department_id);

SELECT e.last_name, d.department_id,d.department_name
FROM employees e JOIN departments d
USING(manager_id);


