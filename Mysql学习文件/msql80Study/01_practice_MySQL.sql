/*
第03章_基本的SELECT语句
01_parctice_MySQL
*/

#最基本的SELECT语句： SELECT 字段1,字段2,... FROM 表名  
SELECT 1+1, 3*2;

#dual：伪表
SELECT 1+1, 3*3
FROM DUAL;

# *:表中的所有的字段（或列）
SELECT * FROM `employees`;
SELECT employee_id,last_name,email,salary FROM `employees`;

# 列的别名 as 可以省略不写, 全称:alias
# 列的别名可以使用一对""引起来，不要使用''。
SELECT employee_id AS "员工id",last_name "员工name",email "邮箱",salary "薪资"
FROM `employees`;


# 7. 去除重复行
#查询员工表中一共有哪些部门id呢？
SELECT employee_id FROM employees;
SELECT DISTINCT department_id FROM employees;

#8. 空值参与运算
# 1. 空值：null
# 2. null不等同于0，''，'null'
SELECT * FROM employees;
# 3. 空值参与运算：结果一定也为空。
SELECT last_name "名字",phone_number "号码",salary "月薪",
salary*(1+commission_pct)*12 "年薪"
FROM employees;


#9. 着重号 ``
SELECT * FROM `order`;

#10. 查询常数
SELECT "润盈投资集团" AS "公司", last_name AS "姓名", employee_id AS "员工id",salary "薪水"
FROM employees;

#11.显示表结构  #显示了表中字段的详细信息
DESCRIBE employees;
DESC locations;
DESC departments;

#12.过滤数据
#练习：查询90号部门的员工信息
SELECT * FROM employees
#过滤条件,声明在FROM结构的后面
WHERE department_id = 90;

#练习：查询last_name为'King'的员工信息
SELECT * FROM employees
#过滤条件,声明在FROM结构的后面
WHERE last_name = "King";