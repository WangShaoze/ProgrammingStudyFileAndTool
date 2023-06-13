-- 18_parctice_MySQL

#第10章_创建和管理表
#1. 创建和管理数据库

#1.1 如何创建数据库
SHOW DATABASES;
SHOW TABLES;
-- 方式1:
CREATE DATABASE mytest01; # 创建的此数据库使用的是默认的字符集
#查看创建数据库的结构
SHOW CREATE DATABASE mytest01;
#方式2：显式了指名了要创建的数据库的字符集
CREATE DATABASE mytest02 CHARACTER SET 'gbk';
SHOW CREATE DATABASE mytest02;
#方式3（推荐）：如果要创建的数据库已经存在，则创建不成功，但不会报错
CREATE DATABASE IF NOT EXISTS mytest03 CHARACTER SET 'utf8'; 

#1.2 管理数据库
#查看当前连接中的数据库都有哪些
SHOW DATABASES;

#切换数据库
USE mytest01;
USE atguigudb;

#查看当前数据库中保存的数据表
SHOW TABLES;

#查看当前使用的数据库
SELECT DATABASE() FROM DUAL;

#查看指定数据库下保存的数据表
SHOW TABLES FROM atguigudb;

#1.3 修改数据库
#更改数据库字符集
SHOW CREATE DATABASE mytest01;
ALTER DATABASE mytest01 CHARACTER SET 'utf8';


#1.4 删除数据库
#方式1：如果要删除的数据库存在，则删除成功。如果不存在，则报错
DROP DATABASE mytest3;
SHOW DATABASES;

#方式2：推荐。 如果要删除的数据库存在，则删除成功。如果不存在，则默默结束，不会报错。

DROP DATABASE IF EXISTS mytest03;
SHOW DATABASES;



#2. 如何创建数据表
USE mytest01;
SHOW CREATE DATABASE mytest01;
SHOW TABLES;

#方式1："白手起家"的方式
CREATE TABLE IF NOT EXISTS myemp1(   #需要用户具备创建表的权限。
id INT,
emp_name VARCHAR(15), #使用VARCHAR来定义字符串，必须在使用VARCHAR时指明其长度。
hire_date DATE
);

CREATE TABLE IF NOT EXISTS myemp2
AS 
SELECT employee_id, last_name, salary
FROM atguigudb.`employees`;
SHOW TABLES;

SELECT * FROM myemp2;
DESC myemp2;
#说明1：查询语句中字段的别名，可以作为新创建的表的字段的名称。
#说明2：此时的查询语句可以结构比较丰富，使用前面章节讲过的各种SELECT
CREATE TABLE myemp3
AS 
SELECT e.`employee_id`, e.`first_name`, e.`last_name`, j.`job_id`, j.`job_title`
FROM atguigudb.employees e JOIN atguigudb.jobs j
ON e.`job_id` = j.`job_id`;

SELECT * FROM myemp3;

#练习1：创建一个表employees_copy，实现对employees表的复制，包括表数据
CREATE TABLE employees_copy
AS SELECT * FROM atguigudb.`employees`;
SELECT * FROM employees_copy;

#练习2：创建一个表employees_blank，实现对employees表的复制，不包括表数据
CREATE TABLE employees_blank
AS 
SELECT * FROM atguigudb.employees
WHERE 1=2;

SELECT * FROM employees_blank;

#3. 修改表  --> ALTER TABLE 
DESC myemp1;
-- 3.1 添加一个新的字段
ALTER TABLE myemp1
ADD salary DOUBLE(10, 2); #默认添加到表中的最后一个字段的位置
SELECT * FROM  myemp1;

ALTER TABLE myemp1
ADD phone_number VARCHAR(20) FIRST;

ALTER TABLE myemp1
ADD email VARCHAR(45) AFTER emp_name; 

ALTER TABLE myemp1
ADD gender VARCHAR(1) AFTER id;

# 3.2 修改一个字段：数据类型、长度、默认值（略）
ALTER TABLE myemp1
MODIFY emp_name VARCHAR(25);

ALTER TABLE myemp1
MODIFY gender VARCHAR(2) DEFAULT '男';


# 3.3 重命名一个字段
ALTER TABLE myemp1
CHANGE salary month_salary DOUBLE(10,2);

ALTER TABLE myemp1
CHANGE email my_email DOUBLE(10,2);

# 3.4 删除一个字段
ALTER TABLE myemp1
DROP COLUMN hire_date;

DESC myemp1;

#4. 重命名表
-- 方式1: 
RENAME TABLE myemp1
TO myemp01;

SHOW TABLES;

-- 方式2:
ALTER TABLE myemp01
RENAME TO myemp1;

#5. 删除表
#不光将表结构删除掉，同时表中的数据也删除掉，释放表空间
DROP TABLE IF EXISTS myemp2;
DROP TABLE IF EXISTS myemp12;

#6. 清空表
#清空表，表示清空表中的所有数据，但是表结构保留。
SELECT * FROM myemp3;

TRUNCATE TABLE myemp3;

SELECT * FROM myemp3;

DESC myemp3;

#7. DCL 中 COMMIT 和 ROLLBACK
# COMMIT:提交数据。一旦执行COMMIT，则数据就被永久的保存在了数据库中，意味着数据不可以回滚。
# ROLLBACK:回滚数据。一旦执行ROLLBACK,则可以实现数据的回滚。回滚到最近的一次COMMIT之后。

#8. 对比 TRUNCATE TABLE 和 DELETE FROM 
# 相同点：都可以实现对表中所有数据的删除，同时保留表结构。
# 不同点：
#	TRUNCATE TABLE：一旦执行此操作，表数据全部清除。同时，数据是不可以回滚的。
#	DELETE FROM：一旦执行此操作，表数据可以全部清除（不带WHERE）。同时，数据是可以实现回滚的。

/*
9. DDL 和 DML 的说明
  ① DDL的操作一旦执行，就不可回滚。指令SET autocommit = FALSE对DDL操作失效。(因为在执行完DDL
    操作之后，一定会执行一次COMMIT。而此COMMIT操作不受SET autocommit = FALSE影响的。)
  
  ② DML的操作默认情况，一旦执行，也是不可回滚的。但是，如果在执行DML之前，执行了 
    SET autocommit = FALSE，则执行的DML操作就可以实现回滚。

*/
# 演示：DELETE FROM 
#1)
COMMIT;  -- 提交数据

#2)
SELECT * FROM employees_copy;

#3)
SET autocommit = FALSE;

#4)
DELETE FROM employees_copy;

#3)
SELECT * FROM employees_copy;

#6)
ROLLBACK;  -- 数据回滚

#7)
SELECT * FROM employees_copy;  -- 数据竟然恢复了

# 演示：TRUNCATE TABLE
#1)
COMMIT;
#2)
SELECT *
FROM employees_copy;
#3)
SET autocommit = FALSE;
#4)
TRUNCATE TABLE myemp3;
#5)
SELECT *
FROM myemp3;
#6)
ROLLBACK;  -- 数据回滚
#7)
SELECT *
FROM myemp3;  -- 数据并没有恢复


#######################
#9.测试MySQL8.0的新特性：DDL的原子化

CREATE DATABASE mytest;
SHOW DATABASES;


USE mytest;
CREATE TABLE book1(
book_id INT,
book_name VARCHAR(25)
);


SHOW TABLES;

DROP TABLE book1,book2;  # 没有book2的情况下，删除操作会失败，
-- 但是book1也没有消失，就是因为 MySQL8.0的新特性：DDL的原子化
-- 每一个任务会被原子化，当这个大的任务没有完成的时候，
-- 小的原子任务会回滚其操作

SHOW TABLES;


