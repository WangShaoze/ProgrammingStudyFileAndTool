# 导入现有的表数据:
#方式一:source 文件的全路径名
#举例: source d:\develp\mysql_code\employees.sql
#方式2: 利用可视化工具导入

# 最基本的SQL语句 select 字段1,字段2,... from 表名;
SELECT 1+1,2*3;  

SELECT 1+1,2*3
FROM DUAL; # dual: 伪表,没有表明的情况下使用伪表

# 查询表的数据
SELECT * FROM employee;   # 所有字段的所有记录
SELECT NAME,id,gender FROM employee;  # 指定列,字段
#字段的别名  取别名--------》可以使用as 关键字 可以用双引号将别名引起来
SELECT NAME 姓名,id 员工编号,gender AS "性别" FROM employee;   # 给指定的列去一个中文名称
# 取别名{ANSI标准}使用的是双引号

# 去除重复行
SELECT DISTINCT NAME FROM employee;  # 只针对某一列

# 空值参与运算
#空值----》null，参与运算时不等于0
SELECT * FROM employee_work;

# 表名 和 字段名 如果和系统的保留字相同时，需要加上 着重号`name`

#查询常数
SELECT '润盈投资集团',NAME,id,phone FROM employee_work;

# 显示表结构
DESCRIBE employee;
DESC employee_work;

#过滤数据
SELECT * FROM employee_work
#过滤数据
WHERE age<=17;  # 查询年龄为小于等于17的员工

# 查询员工编号为1006的员工信息
SELECT * FROM employee_work 
WHERE id='1006';

# 查询员工姓名为 小Lin 的员工信息
SELECT * FROM employee_work 
WHERE NAME='小Lin';  # 字符串使用单引号 {ANSI标准}

# 涉及的关键字: select from where desc describe distinct


