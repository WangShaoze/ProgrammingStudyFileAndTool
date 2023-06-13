-- 16_parctice_MySQ 子查询

-- 需求: 谁的工资比Abel 高?

-- way1:
SELECT salary 
FROM employees
WHERE last_name = 'Abel';

SELECT last_name,salary
FROM employees
WHERE salary>11000;

-- way2:自连接
SELECT e2.`last_name`, e2.`salary`
FROM employees e1, employees e2
WHERE e1.`last_name` = 'Abel' 
AND e2.`salary` > e1.`salary`;

-- way3: 子查询
SELECT last_name, salary
FROM employees
WHERE salary > (
		SELECT salary 
		FROM employees
		WHERE last_name = 'Abel'
		);
	
-- 称谓规范: 外查询（主查询） 和 内查询（子查询）
/*
子查询（内查询）在主查询之前一次执行完成。
子查询的结果被主查询（外查询）使用 。
注意事项
	子查询要包含在括号内
	将子查询放在比较条件的右侧
	单行操作符对应单行子查询，多行操作符对应多行子查询
*/
		

/*子查询的分类
角度1：内查询返回的结果的条目数
	单行查询 vs 多行查询
角度2：内查询是否被执行多次
	相关子查询 vs 不相关子查询
	例如: 查询工资大于本部门平均工资的员工?
	例如：查询工资大于本公司平均工资的员工？
*/		
	

-- 单行:
-- 题目：查询工资大于149号员工工资的员工的信息
SELECT * FROM employees
WHERE salary > (
		SELECT salary FROM employees
		WHERE employee_id = 149
		);	

-- 题目：返回job_id与141号员工相同，salary比143号员工多的员工姓名，job_id和工资
SELECT last_name, job_id, salary
FROM employees
WHERE job_id = (
	SELECT job_id FROM employees
	WHERE employee_id = 141
	) AND salary >(
			SELECT salary FROM employees
			WHERE employee_id = 143	
			);
	
-- 题目：返回公司工资最少的员工的last_name,job_id和salary
SELECT last_name, job_id, salary
FROM employees
WHERE salary = (
		SELECT MIN(salary) FROM employees
		);
		
-- 题目：查询与141号或174号员工的manager_id和department_id相同的其他员工的employee_id，manager_id，department_id
-- 实现方式1：不成对比较
SELECT employee_id, manager_id, department_id
FROM employees
WHERE manager_id IN (
			SELECT manager_id FROM employees WHERE employee_id IN(141, 174)
			)
AND department_id IN (
			SELECT department_id FROM employees WHERE employee_id IN(141, 174)
			)
AND employee_id NOT IN (141, 174);

-- 实现方式2: 成对比较
SELECT employee_id, manager_id, department_id
FROM employees
WHERE (manager_id, department_id) IN (
					SELECT manager_id, department_id FROM employees WHERE employee_id IN (141, 174)
					)
AND employee_id NOT IN (141, 174);


-- 题目：查询最低工资大于50号部门最低工资的部门id和其最低工资

SELECT department_id, MIN(salary)
FROM employees
GROUP BY department_id
HAVING MIN(salary) > (
			SELECT MIN(salary) 
			FROM employees
			WHERE department_id = 50
			);

# 首先执行子查询。
# 向主查询中的HAVING 子句返回结果

-- 2.4 CASE中的子查询
-- 在CASE表达式中使用单列子查询：
-- 题目：显式员工的employee_id,last_name和location。其中，若员工department_id与location_id为1800
-- 的department_id相同，则location为’Canada’，其余则为’USA’。

SELECT employee_id,last_name,(CASE department_id 
				WHEN (SELECT department_id 
					FROM departments 
					WHERE location_id = 1800) THEN 'Canada'
				ELSE 'USA' END) AS location
FROM employees;	


-- 2.5 子查询中的空值问题
SELECT last_name, job_id
FROM employees
WHERE job_id = (
		SELECT job_id 
		FROM employees
		WHERE last_name = 'Haas'
		);  # 如果子查询的结果为空，则主查询的结果也为空

-- 2.5 非法使用子查询
SELECT employee_id, last_name
FROM employees
WHERE salary = (
		SELECT MIN(salary)
		FROM employees
		GROUP BY department_id   
		);  # 子查询的返回结果不止一个时，主查询的条件不可以使用 = ，而是使用 in


/*
3. 多行子查询
也称为集合比较子查询
内查询返回多行
使用多行比较操作符

操作符 含义
IN 等于列表中的任意一个
ANY 需要和单行比较操作符一起使用，和子查询返回的某一个值比较
ALL 需要和单行比较操作符一起使用，和子查询返回的所有值比较
SOME 实际上是ANY的别名，作用相同，一般常使用ANY

*/

-- 题目：返回其它job_id中比job_id为‘IT_PROG’部门任一工资低的员工的员工号、姓名、job_id 以及salary
SELECT employee_id,last_name, job_id, salary
FROM employees
WHERE salary < ANY (
			SELECT salary 
			FROM employees
			WHERE job_id = 'IT_PROG'
			)
AND job_id <> 'IT_PROG'; 

-- 题目：返回其它job_id中比job_id为‘IT_PROG’部门所有工资都低的员工的员工号、姓名、job_id以及salary
SELECT employee_id,last_name, job_id, salary
FROM employees
WHERE salary < ALL (
			SELECT salary 
			FROM employees
			WHERE job_id = 'IT_PROG'
			)
AND job_id <> 'IT_PROG'; 

-- 题目：查询平均工资最低的部门id
# 方式一: 
SELECT department_id
FROM employees
GROUP BY department_id 
HAVING AVG(salary) = (
			SELECT MIN(avg_sal)
			FROM (
				SELECT AVG(salary) avg_sal
				FROM employees
				GROUP BY department_id
				) t_dept_avg_sal
			);

-- 方式二:
SELECT department_id
FROM employees
GROUP BY department_id 
HAVING AVG(salary) = (
			SELECT AVG(salary) avg_sal
			FROM employees
			GROUP BY department_id
			ORDER BY avg_sal ASC
			LIMIT 0,1
			);

-- 方式三:
SELECT department_id
FROM employees
GROUP BY department_id 
HAVING AVG(salary) <= ALL (
			SELECT AVG(salary) avg_sal
			FROM employees
			GROUP BY department_id
			);
			
# 3.3 空值问题
SELECT last_name
FROM employees
WHERE department_id NOT IN (
			SELECT manager_id 
			FROM employees
			);


# 4. 相关子查询
/*
说明：子查询中使用主查询中的列

如果子查询的执行依赖于外部查询，通常情况下都是因为子查询中的表用到了外部的表，并进行了条件
关联，因此每执行一次外部查询，子查询都要重新计算一次，这样的子查询就称之为 关联子查询 。

*/


-- 题目：查询员工中工资大于本部门平均工资的员工的last_name,salary和其department_id
-- 方式一：相关子查询
SELECT last_name,salary,department_id
FROM employees `outer`
WHERE salary > (
		SELECT AVG(salary)
		FROM employees
		WHERE department_id = outer.department_id 
		);
		
-- 方式二：在 FROM 中使用子查询
SELECT last_name,salary,e1.department_id
FROM employees e1, (
			SELECT AVG(salary) avg_sal, department_id
			FROM employees
			GROUP BY department_id
			) e2
WHERE e1.`department_id` = e2.`department_id` AND e1.`salary` > e2.`avg_sal`;


-- 在ORDER BY 中使用子查询：
-- 题目：查询员工的id,salary,按照department_name 排序

SELECT employee_id, salary
FROM employees e
ORDER BY (
	SELECT department_name
	FROM departments d
	WHERE e.`department_id` = d.`department_id`
	);

-- 题目：若employees表中employee_id与job_history表中employee_id相同的数目不小于2，
-- 输出这些相同id的员工的employee_id,last_name和其job_id

SELECT employee_id, last_name, job_id
FROM employees e
WHERE 2 <= (
		SELECT COUNT(*)
		FROM job_history j
		WHERE e.`employee_id` = j.`employee_id`
		);

/*
4.3 EXISTS 与 NOT EXISTS关键字
关联子查询通常也会和 EXISTS操作符一起来使用，用来检查在子查询中是否存在满足条件的行。
如果在子查询中不存在满足条件的行：
	条件返回 FALSE
	继续在子查询中查找
如果在子查询中存在满足条件的行：
	不在子查询中继续查找
	条件返回 TRUE

NOT EXISTS关键字表示如果不存在某种条件，则返回TRUE，否则返回FALSE。
	
*/

-- 题目：查询公司管理者的employee_id，last_name，job_id，department_id信息
# 方式一:相关子查询
SELECT employee_id,last_name,job_id,department_id
FROM employees e1
WHERE EXISTS (
		SELECT * 
		FROM employees e2
		WHERE e1.`employee_id` = e2.`manager_id`
		);
# 方式二：自连接
SELECT DISTINCT e1.employee_id,e1.last_name,e1.job_id,e1.department_id
FROM employees e1 JOIN employees e2
ON e1.`employee_id` = e2.`manager_id`;

# 方式三: 子查询
SELECT employee_id,last_name,job_id,department_id
FROM employees
WHERE employee_id IN (
			SELECT DISTINCT manager_id
			FROM employees
			);
			

-- 题目：查询departments表中，不存在于employees表中的部门的department_id和department_name
-- 方式1:
SELECT d.department_id,d.department_name
FROM employees e RIGHT JOIN departments d
ON e.`department_id` = d.`department_id`
WHERE e.`department_id` IS NULL;

-- 方式二:
SELECT department_id,department_name
FROM departments d
WHERE NOT EXISTS (
		SELECT *
		FROM employees e
		WHERE d.`department_id` = e.`department_id`
		);


