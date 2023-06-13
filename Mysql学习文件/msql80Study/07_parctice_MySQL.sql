/*
07_parctice_MySQL

第05章_排序与分页 练习
题目：
答案：
	1. 查询员工的姓名和部门号和年薪，按年薪降序 按姓名升序显示
	2. 选择工资不在 8000 到 17000 的员工的姓名和工资，按工资降序，显示第21到40位置的数据
	3. 查询邮箱中包含 e 的员工信息，并先按邮箱的字节数降序，再按部门号升序
*/


#1. 查询员工的姓名和部门号和年薪，按年薪降序,按姓名升序显示
SELECT last_name,department_id,salary*(1+IFNULL(commission_pct, 0))*12 AS "anuual_salary" 
FROM employees
ORDER BY anuual_salary DESC,last_name ASC;

#2. 选择工资不在 8000 到 17000 的员工的姓名和工资，按工资降序，显示第21到40位置的数据
SELECT last_name,salary
FROM employees
WHERE NOT salary BETWEEN 8000 AND 17000
ORDER BY salary DESC
LIMIT 20,20;


#3. 查询邮箱中包含 e 的员工信息，并先按邮箱的字节数降序，再按部门号升序
SELECT * FROM employees
# where email like '%e%'
WHERE email REGEXP '[e]'
ORDER BY LENGTH(email) DESC,department_id ASC;



