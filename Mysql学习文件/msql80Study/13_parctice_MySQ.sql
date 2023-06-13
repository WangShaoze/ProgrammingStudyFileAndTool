/*
13_parctice_MySQ

单行函数的课后练习
# 1.显示系统时间(注：日期+时间)
# 2.查询员工号，姓名，工资，以及工资提高百分之20%后的结果（new salary）
# 3.将员工的姓名按首字母排序，并写出姓名的长度（length）
# 4.查询员工id,last_name,salary，并作为一个列输出，别名为OUT_PUT
# 5.查询公司各员工工作的年数、工作的天数，并按工作年数的降序排序
# 6.查询员工姓名，hire_date , department_id，满足以下条件：雇用时间在1997年之后，department_id
为80 或 90 或110, commission_pct不为空
# 7.查询公司中入职超过10000天的员工姓名、入职时间
# 8.做一个查询，产生下面的结果
<last_name> earns <salary> monthly but wants <salary*3>
# 9.使用case-when，按照下面的条件：

*/

# 1.显示系统时间(注：日期+时间)
SELECT NOW(),SYSDATE(),CURRENT_TIMESTAMP(), LOCALTIME(),LOCALTIMESTAMP() FROM DUAL;

# 2.查询员工号，姓名，工资，以及工资提高百分之20%后的结果（new salary）
SELECT employee_id,last_name,salary, salary*(1+0.2) 'new salary'
FROM employees;

# 3.将员工的姓名按首字母排序，并写出姓名的长度（length）
SELECT last_name,LENGTH(last_name) 'name_length'
FROM employees
# order by length(last_name);
ORDER BY last_name ASC;

# 4.查询员工id,last_name,salary，并作为一个列输出，别名为OUT_PUT
SELECT CONCAT(employee_id,last_name,salary) 'OUT_PUT'
FROM employees;

# 5.查询公司各员工工作的年数、工作的天数，并按工作年数的降序排序
# 方式1:
SELECT last_name, hire_date, DATEDIFF(NOW(),hire_date)/365 'worked_years',DATEDIFF(NOW(),hire_date) 'worked_days' 
FROM employees
ORDER BY worked_years DESC;
# 方式2:
SELECT last_name, hire_date, (TO_DAYS(NOW())-TO_DAYS(hire_date))/365 'worked_years',TO_DAYS(NOW())-TO_DAYS(hire_date) 'worked_days' 
FROM employees
ORDER BY worked_years DESC;

# 6.查询员工姓名，hire_date , department_id，
# 满足以下条件：雇用时间在1997年之后，department_id为80 或 90 或110,
#  commission_pct不为空

SELECT last_name,hire_date,department_id
FROM employees
WHERE department_id IN(80,90,110) AND commission_pct IS NOT NULL 
# and hire_date >= '1997-01-01';  # 存在隐士转换
# and date_format(hire_date, '%Y-%m-%d') >= '1997-01-01'; #格式化: 日期--->字符串
# and date_format(hire_date, '%Y') >= '1997';
AND hire_date >= STR_TO_DATE('19970101', '%Y%m%d'); # 格式解析: 字符串-----> 日期

# 7.查询公司中入职超过10000天的员工姓名、入职时间
SELECT last_name, hire_date
FROM employees
WHERE DATEDIFF(NOW(),hire_date) >= 10000;

# 8.做一个查询，产生下面的结果 命名为: Dream Salary
# <last_name> earns <salary> monthly but wants <salary*3>
SELECT CONCAT(last_name, ' earns ', salary, ' monthly but wants ', salary*3) AS 'Dream Salary'
FROM employees;
# 9.使用case-when，按照下面的条件：
/*
job     grade
AD_PRES  A
ST_MAN   B
IT_PROG  C
SA_REP   D
ST_CLERK E
*/

SELECT last_name 'Last_name', job_id 'Job_id', CASE job_id 
						WHEN 'AD_PRES' THEN 'A'
						WHEN 'ST_MAN' THEN 'B'
						WHEN 'IT_PROG' THEN 'C'
						WHEN 'SA_REP' THEN 'D'
						WHEN 'ST_CLERK' THEN 'E'
						ELSE 'undefined' END 'Grade'
FROM employees;
						




