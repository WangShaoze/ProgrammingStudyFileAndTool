/*
14_parctice_MySQ
聚合函数

什么是聚合函数？
聚合函数作用于一组数据，并对一组数据返回一个值。

聚合函数类型
AVG()
SUM()
MAX()
MIN()
COUNT()

聚合函数语法:
1.1 AVG和SUM函数
可以对数值型数据使用AVG 和 SUM 函数。

1.2 MIN和MAX函数
可以对任意数据类型的数据使用 MIN 和 MAX 函数。

1.3 COUNT函数
COUNT(*)返回表中记录总数，适用于任意数据类型。

*/

# 1.1 AVG和SUM函数 可以对数值型数据使用AVG 和 SUM 函数。
SELECT AVG(salary), MAX(salary), MIN(salary),SUM(salary) 
FROM employees 
WHERE job_id LIKE '%REP%';

# 1.2 MIN和MAX函数 可以对任意数据类型的数据使用 MIN 和 MAX 函数。
SELECT MAX(last_name),MIN(last_name),MAX(hire_date),MIN(hire_date)
FROM employees;

# 1.3 COUNT函数 COUNT(*)返回表中记录总数，适用于任意数据类型。
SELECT COUNT(salary),COUNT(job_id),COUNT(commission_pct),COUNT(*), COUNT(1), COUNT(1*salary)
FROM employees;

SELECT AVG(salary), SUM(salary)/COUNT(salary),
AVG(commission_pct), SUM(commission_pct)/COUNT(commission_pct),
SUM(commission_pct)/107
FROM employees;

SELECT COUNT(commission_pct)
FROM employees;  # 35  说明: COUNT(expr) 返回expr不为空的记录总数。

#需求：查询公司中平均奖金率
#错误的！
SELECT AVG(commission_pct)
FROM employees;

#正确的：
SELECT SUM(commission_pct)/COUNT(IFNULL(commission_pct, 0)),
AVG(IFNULL(commission_pct,0))
FROM employees;


#如果计算表中有多少条记录，如何实现？
#方式1：COUNT(*)
#方式2：COUNT(1)
#方式3：COUNT(具体字段) : 不一定对！

# 如何需要统计表中的记录数，使用COUNT(*)、COUNT(1)、COUNT(具体字段) 
# 哪个效率更高呢？
# 答:
# 如果使用的是MyISAM 存储引擎，则三者效率相同，都是O(1)
# 如果使用的是InnoDB 存储引擎，则三者效率：COUNT(*) = COUNT(1)> COUNT(字段)


#其他：方差、标准差、中位数


# 2 group by
# 2.1 基本使用

# 可以使用GROUP BY子句将表中的数据分成若干组
# 明确：WHERE一定放在FROM后面
# 在SELECT列表中所有未包含在组函数中的列都应该包含在 GROUP BY子句中
# 包含在 GROUP BY 子句中的列不必包含在SELECT 列表中
SELECT department_id, AVG(salary)
FROM employees
GROUP BY department_id;

# 2.2 使用多个列分组

SELECT department_id dpt_id, job_id, AVG(salary)
FROM employees
GROUP BY dpt_id, job_id;

# 使用 WITH ROLLUP 关键字之后，在所有查询出的分组记录之后增加一条记录，
# 该记录计算查询出的所有记录的总和，即统计记录数量。
SELECT department_id,AVG(salary)
FROM employees
WHERE department_id IS NOT NULL
GROUP BY department_id WITH ROLLUP;
# 注意：
# 当使用ROLLUP时，不能同时使用ORDER BY子句进行结果排序，
# 即ROLLUP和ORDER BY是互相排斥的。

# 3. HAVING
# 3.1 基本使用
/*
过滤分组：HAVING子句
1. 行已经被分组。
2. 使用了聚合函数。
3. 满足HAVING 子句中条件的分组将被显示。
4. HAVING 不能单独使用，必须要跟 GROUP BY 一起使用。

*/
SELECT department_id,MAX(salary)
FROM employees
GROUP BY department_id
HAVING MAX(salary) > 10000;

# 非法使用聚合函数 ： 不能在 WHERE 子句中使用聚合函数。如下：
SELECT department_id,MAX(salary)
FROM employees
WHERE MAX(salary) > 10000
GROUP BY department_id;
/*
错误代码： 1111
Invalid use of group function
*/

/*
对比 WHERE 和 HAVING ?
区别1：WHERE 可以直接使用表中的字段作为筛选条件，但不能使用分组中的计算函数作为筛选条件；
HAVING 必须要与 GROUP BY 配合使用，可以把分组计算的函数和分组字段作为筛选条件。
这决定了，在需要对数据进行分组统计的时候，HAVING 可以完成 WHERE 不能完成的任务。

区别2：如果需要通过连接从关联表中获取需要的数据，WHERE 是先筛选后连接，而 HAVING 是先连接
后筛选。 这一点，就决定了在关联查询中，WHERE 比 HAVING 更高效。

总结: 
WHERE 先筛选数据再关联，执行效率高 不能使用分组中的计算函数进行筛选
HAVING 可以使用分组中的计算函数 在最后的结果集中进行筛选，执行效率较低

开发中的选择：
WHERE 和 HAVING 也不是互相排斥的，我们可以在一个查询里面同时使用 WHERE 和 HAVING。包含分组
统计函数的条件用 HAVING，普通条件用 WHERE。这样，我们就既利用了 WHERE 条件的高效快速，又发
挥了 HAVING 可以使用包含分组统计函数的查询条件的优点。当数据量特别大的时候，运行效率会有很
大的差别。

*/


/*
4. SELECT的执行过程

4.1 查询的结构
#方式1：
SELECT ...,....,...
FROM ...,...,....
WHERE 多表的连接条件
AND 不包含组函数的过滤条件
GROUP BY ...,...
HAVING 包含组函数的过滤条件
ORDER BY ... ASC/DESC
LIMIT ...,...


#方式2：
SELECT ...,....,...
FROM ... JOIN ...
ON 多表的连接条件
JOIN ...
ON ...
WHERE 不包含组函数的过滤条件
AND/OR 不包含组函数的过滤条件
GROUP BY ...,...
HAVING 包含组函数的过滤条件
ORDER BY ... ASC/DESC
LIMIT ...,...

#其中：
#（1）from：从哪些表中筛选
#（2）on：关联多表查询时，去除笛卡尔积
#（3）where：从表中筛选的条件
#（4）group by：分组依据
#（5）having：在统计结果中再次筛选
#（6）order by：排序
#（7）limit：分页


4.2 SELECT执行顺序
你需要记住 SELECT 查询时的两个顺序：
1. 关键字的顺序是不能颠倒的：
SELECT ... FROM ... WHERE ... GROUP BY ... HAVING ... ORDER BY ... LIMIT...

2.SELECT 语句的执行顺序（在 MySQL 和 Oracle 中，SELECT 执行顺序基本相同）：
FROM -> WHERE -> GROUP BY -> HAVING -> SELECT 的字段 -> DISTINCT -> ORDER BY -> LIMIT
*/




