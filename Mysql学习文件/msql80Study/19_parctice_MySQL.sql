-- 19_parctice_MySQL
-- 第10章_创建和管理表的课后练习

--         第一个练习
#1. 创建数据库test01_office,指明字符集为utf8。并在此数据库下执行下述操作
CREATE DATABASE test01_office CHARACTER SET 'utf8';
SHOW CREATE DATABASE test01_office;

USE test01_office;
#2. 创建表dept01
/*
字段 类型
id INT(7)
NAME VARCHAR(25)
*/
CREATE TABLE IF NOT EXISTS dept01(
id INT(7),
NAME VARCHAR(25)
);

DESC dept01;


#3. 将表departments中的数据插入新表dept02中
CREATE TABLE dept02
AS 
SELECT * FROM atguigudb.`departments`;

SELECT * FROM dept02;

#4. 创建表emp01
/*
字段 类型
id INT(7)
first_name VARCHAR (25)
last_name VARCHAR(25)
dept_id INT(7)
*/

CREATE TABLE IF NOT EXISTS emp01(
id INT(7),
first_name VARCHAR (25),
last_name VARCHAR(25),
dept_id INT(7)
);

DESC emp01;

#5. 将列last_name的长度增加到50
ALTER TABLE emp01
MODIFY last_name VARCHAR(50);

DESC emp01;

#6. 根据表employees创建emp02
CREATE TABLE emp02
AS 
SELECT * FROM atguigudb.`employees`;

SELECT * FROM emp02;

DESC emp02;

#7. 删除表emp01
SHOW TABLES FROM test01_office;
DROP TABLE emp01,emp02,dept02;

#8. 将表emp02重命名为emp01
RENAME TABLE emp02 TO emp01;
SHOW TABLES FROM test01_office; # alter table emp02 rename to emp01;

#9.在表dept02和emp01中添加新列test_column，并检查所作的操作
ALTER TABLE emp01 ADD test_column VARCHAR(10);
ALTER TABLE dept02 ADD test_column VARCHAR(10);
DESC emp01;
DESC dept02;

#10.直接删除表emp01中的列 department_id
ALTER TABLE emp01
DROP COLUMN department_id;
DESC emp01;



#############################
--               第二个练习
# 1、创建数据库 test02_market
CREATE DATABASE IF NOT EXISTS test02_market;
SHOW CREATE DATABASE test02_market;

# 2、创建数据表 customers
/*
字段名 数据类型
c_num int
c_name varchar(50)
c_contact varchar(50)
c_city varchar(50)
c_birth date
*/

USE test02_market;

CREATE TABLE IF NOT EXISTS customers(
c_num INT,
c_name VARCHAR(50),
c_contact VARCHAR(50),
c_city VARCHAR(50),
c_birth DATE
);

DESC customers;

# 3、将 c_contact 字段移动到 c_birth 字段后面
ALTER TABLE customers MODIFY c_contact VARCHAR(50) AFTER c_birth;
DESC customers;

# 4、将 c_name 字段数据类型改为 varchar(70)
ALTER TABLE customers MODIFY c_name VARCHAR(70); 
DESC customers;

# 5、将c_contact字段改名为c_phone
ALTER TABLE customers CHANGE c_contact c_phone VARCHAR(50);
DESC customers;

# 6、增加c_gender字段到c_name后面，数据类型为char(1)
ALTER TABLE customers ADD c_gender CHAR(1) AFTER c_name;
DESC customers;

# 7、将表名改为customers_info
ALTER TABLE customers RENAME TO customers_info;
DESC customers_info;


# 8、删除字段c_city
ALTER TABLE customers_info 
DROP COLUMN c_city;
DESC customers_info;


######################################
--              第三个练习
# 1、创建数据库test03_company
CREATE DATABASE IF NOT EXISTS test03_company;
SHOW CREATE DATABASE test03_company;
# 2、创建表offices
/*
字段名 数据类型
officeCode int
city varchar(30)
address varchar(50)
country varchar(50)
postalCode varchar(25)
*/
CREATE TABLE offices(
officeCode INT,
city VARCHAR(30),
address VARCHAR(50),
country VARCHAR(50),
postalCode VARCHAR(25)
);

DESC offices;

# 3、创建表employees
/*
字段名 数据类型
empNum int
lastName varchar(50)
firstName varchar(50)
mobile varchar(25)
code int
jobTitle varchar(50)
birth date
note varchar(255)
sex varchar(5)
*/
CREATE TABLE IF NOT EXISTS employees(
empNum INT,
lastName VARCHAR(50),
firstName VARCHAR(50),
mobile VARCHAR(25),
CODE INT,
jobTitle VARCHAR(50),
birth DATE,
note VARCHAR(255),
sex VARCHAR(5)
);

DESC employees;

# 4、将表employees的mobile字段修改到code字段后面
ALTER TABLE employees MODIFY mobile VARCHAR(25) AFTER `code`;
DESC employees;

# 5、将表 employees 的 birth 字段改名为 birthday
ALTER TABLE employees CHANGE birth birthday DATE;
DESC employees;

# 6、修改 sex 字段，数据类型为char(1)
ALTER TABLE employees MODIFY sex CHAR(1);
DESC employees;

# 7、删除字段 note
ALTER TABLE employees 
DROP COLUMN note;
DESC employees;


# 8、增加字段名 favoriate_activity ，数据类型为 varchar(100)
ALTER TABLE employees ADD favoriate_activity VARCHAR(100);
DESC employees;

# 9、将表 employees 的名称修改为 employees_info
ALTER TABLE employees RENAME TO employees_info;
SHOW TABLES;
