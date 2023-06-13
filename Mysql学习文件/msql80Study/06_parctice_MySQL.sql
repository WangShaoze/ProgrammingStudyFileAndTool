/*
06_parctice_MySQL

排序
排序规则:
	使用 ORDER BY 子句排序
	ASC（ascend）: 升序  --- (默认)
	DESC（descend）:降序
	ORDER BY 子句在SELECT语句的结尾。

1.2 单列排序
	SELECT last_name, job_id, department_id, hire_date
	FROM employees
	ORDER BY hire_date;
	
	SELECT last_name, job_id, department_id, hire_date
	FROM employees
	ORDER BY hire_date DESC ;

1.3 多列排序
	SELECT last_name, department_id, salary
	FROM employees
	ORDER BY department_id, salary DESC;

可以使用不在SELECT列表中的列排序。
在对多列进行排序的时候，首先排序的第一列必须有相同的列值，才会对第二列进行排序。如果第
一列数据中所有值都是唯一的，将不再对第二列进行排序。
*/
SELECT last_name,department_id,salary
FROM employees
ORDER BY department_id;

SELECT last_name,department_id,salary
FROM employees
ORDER BY department_id ASC;

SELECT last_name,department_id,salary
FROM employees
ORDER BY department_id DESC;


SELECT last_name, department_id,salary
FROM employees
ORDER BY department_id DESC, salary DESC;

SELECT last_name, department_id,salary
FROM employees
ORDER BY department_id, salary DESC;

SELECT last_name, department_id,salary
FROM employees
ORDER BY department_id DESC, salary;
SELECT last_name, department_id, salary
FROM employees
ORDER BY department_id, salary DESC;


/*

2. 分页
2.1 背景
	背景1：查询返回的记录太多了，查看起来很不方便，怎么样能够实现分页查询呢？
	背景2：表里有 4 条数据，我们只想要显示第 2、3 条数据怎么办呢？
2.2 实现规则
分页原理
	所谓分页显示，就是将数据库中的结果集，一段一段显示出来需要的条件。
	MySQL中使用 LIMIT 实现分页
格式：	
	LIMIT [位置偏移量,] 行数
*/


-- 前10条记录：
SELECT * FROM employees LIMIT 10;
-- 或者
SELECT * FROM employees LIMIT 0,10;

-- 第11至20条记录：
SELECT * FROM employees LIMIT 10,10;

-- 第21至30条记录：
SELECT * FROM employees LIMIT 20,10;

-- 分页显式公式：（当前页数-1）*每页条数，每页条数
-- SELECT * FROM table
-- LIMIT(PageNo. - 1)*PageSize,PageSize;

-- 注意：LIMIT 子句必须放在整个SELECT语句的最后！
-- 使用 LIMIT 的好处
--   约束返回结果的数量可以 减少数据表的网络传输量 ，也可以 提升查询效率 。如果我们知道返回结果只有
--   1 条，就可以使用 LIMIT 1 ，告诉 SELECT 语句只需要返回一条记录即可。这样的好处就是 SELECT 不需
--   要扫描完整的表，只需要检索到一条符合条件的记录即可返回

