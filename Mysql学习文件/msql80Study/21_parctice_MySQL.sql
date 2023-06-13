-- 21_parctice_MySQL 
-- 第11章_数据处理之增删改


# 练习1
#1. 创建数据库 dbtest11
CREATE DATABASE IF NOT EXISTS dbtest11 CHARACTER SET 'utf8';

#2. 运行以下脚本创建表 my_employees
USE dbtest11;
CREATE TABLE my_employees(
id INT(10),
first_name VARCHAR(10),
last_name VARCHAR(10),
userid VARCHAR(10),
salary DOUBLE(10,2)
);
CREATE TABLE users(
id INT,
userid VARCHAR(10),
department_id INT
);
#3. 显示表 my_employees 的结构
DESC my_employees;
DESC users;
#4. 向 my_employees 表中插入下列数据
/*
ID FIRST_NAME LAST_NAME USERID SALARY
1 patel Ralph Rpatel 895
2 Dancs Betty Bdancs 860
3 Biri Ben Bbiri 1100
4 Newman Chad Cnewman 750
5 Ropeburn Audrey Aropebur 1550
*/
-- 方式一:
INSERT INTO my_employees(ID,FIRST_NAME,LAST_NAME,USERID,SALARY)
VALUES
(1,'patel','Ralph','Rpatel',895),
(2,'Dancs','Betty','Bdancs',860),
(3,'Biri','Ben','Bbiri',1100),
(4,'Newman','Chad','Cnewman',750),
(5,'Ropeburn','Audrey','Aropebur',1550);

-- 方式2:
INSERT INTO my_employees
SELECT 1,'patel','Ralph','Rpatel',895 UNION ALL
SELECT 2,'Dancs','Betty','Bdancs',860 UNION ALL
SELECT 3,'Biri','Ben','Bbiri',1100 UNION ALL
SELECT 4,'Newman','Chad','Cnewman',750 UNION ALL
SELECT 5,'Ropeburn','Audrey','Aropebur',1550;

SELECT * FROM my_employees;

#5. 向users表中插入数据
/*
id uerid department_id
1 Rpatel 10
2 Bdancs 10
3 Bbiri 20
4 Cnewman 30
5 Aropebur 40
*/
INSERT INTO users(id,userid,department_id)
VALUES
(1,'Rpatel',10),
(2,'Bdancs',10),
(3,'Bbiri',20),
(4,'Cnewman',30),
(5,'Aropebur',40);

-- 方式2:
INSERT INTO users
SELECT 1,'Rpatel',10 UNION ALL 
SELECT 1,'Bdancs',10 UNION ALL
SELECT 1,'Bbiri',10 UNION ALL
SELECT 1,'Cnewman',10 UNION ALL
SELECT 1,'Aropebur',10;

SELECT * FROM users;

#6. 将3号员工的last_name修改为“drelxer”
UPDATE my_employees
SET last_name = 'drelxer'
WHERE id = 3;

SELECT * FROM my_employees;

#7. 将所有工资少于900的员工的工资修改为1000
UPDATE my_employees
SET salary = 1000
WHERE salary <900;

SELECT * FROM my_employees;

#8. 将userid为 Bbiri 的 users表和 my_employees 表的记录全部删除
DELETE e,u
FROM users u JOIN my_employees e
ON u.`userid` = e.`userid`
WHERE u.`userid` = 'Bbiri';

SELECT * FROM users;
SELECT * FROM my_employees;

#9. 删除 my_employees、users 表所有数据
DELETE FROM my_employees;
DELETE FROM users;

#10. 检查所作的修正
SELECT * FROM users;
SELECT * FROM my_employees;

#11. 清空表my_employees
TRUNCATE TABLE my_employees;

DESC my_employees;


#######################
-- 练习2
# 1. 使用现有数据库dbtest11
# 2. 创建表格pet
/*
字段名 字段说明 数据类型
name 宠物名称 VARCHAR(20)
owner 宠物主人 VARCHAR(20)
species 种类 VARCHAR(20)
sex 性别 CHAR(1)
birth 出生日期 YEAR
death 死亡日期 YEAR
*/
CREATE TABLE IF NOT EXISTS pet(
NAME VARCHAR(20),
OWNER VARCHAR(20),
species VARCHAR(20),
sex CHAR(1),
birth YEAR,
death YEAR
);

SELECT * FROM pet;
# 3. 添加记录
/*
name    owner   species  sex  birth death
Fluffy  harold  Cat 	 f    2003   2010
Claws   gwen    Cat 	 m    2004
Buffy      	Dog  	 f    2009
Fang    benny 	Dog   	 m    2000
bowser  diane 	Dog      m    2003   2009
Chirpy      	Bird     f    2008
*/
INSERT INTO pet
VALUES('Fluffy','harold','Cat','f','2003','2010');

INSERT INTO pet(NAME,    OWNER,   species,  sex,  birth)
VALUES('Claws',   'gwen',    'Cat', 	 'm',    '2004');

INSERT INTO pet(NAME,   species,  sex,  birth)
VALUES('Buffy','Dog','f','2009');

INSERT INTO pet
VALUES('bowser','diane','Dog','m','2003','2009');

INSERT INTO pet(NAME,   species,  sex,  birth)
VALUES('Chirpy','Bird','f','2008');

SELECT * FROM pet;

# 4. 添加字段:主人的生日owner_birth DATE类型。
ALTER TABLE pet
ADD owner_birth DATE;

SELECT * FROM pet;

# 5. 将名称为Claws的猫的主人改为 kevin
UPDATE pet
SET OWNER = 'kevin'
WHERE NAME = 'Claws';

SELECT * FROM pet;

# 6. 将没有死的狗的主人改为duck
UPDATE pet
SET OWNER = 'duck'
WHERE species = 'Dog' AND death IS NULL;

SELECT * FROM pet;

# 7. 查询没有主人的宠物的名字；
SELECT `name`
FROM pet
WHERE OWNER IS NULL;

# 8. 查询已经死了的cat的姓名，主人，以及去世时间；

SELECT NAME, OWNER, death
FROM pet
WHERE species = 'Cat' AND death IS NOT NULL;

# 9. 删除已经死亡的狗
DELETE FROM pet
WHERE species = 'Dog' AND death IS NOT NULL;
# 10. 查询所有宠物信息
SELECT * FROM pet;


#####################
# 练习3
# 1. 使用已有的数据库 dbtest11
USE dbtest11;
# 2. 创建表 employee ，并添加记录
CREATE TABLE IF NOT EXISTS employee(
id INT,
NAME VARCHAR(10),
sex ENUM('男','女'),
tel VARCHAR(15),
addr VARCHAR(50),
salary DOUBLE(7, 2)
);

DESC employee;
-- 添加信息
INSERT INTO employee(id,`name`,sex,tel,addr,salary)VALUES
(10001,'张一一','男','13456789000','山东青岛',1001.58),
(10002,'刘小红','女','13454319000','河北保定',1201.21),
(10003,'李四','男','0751-1234567','广东佛山',1004.11),
(10004,'刘小强','男','0755-5555555','广东深圳',1501.23),
(10005,'王艳','男','020-1232133','广东广州',1405.16);

SELECT * FROM employee;

# 3. 查询出薪资在1200~1300之间的员工信息。
SELECT * FROM employee
WHERE salary >= 1200 AND salary <= 1300;

SELECT * FROM employee
WHERE salary BETWEEN 1200 AND 1300;

# 4. 查询出姓“刘”的员工的工号，姓名，家庭住址。
SELECT id,`name`,addr
FROM employee
WHERE NAME LIKE '刘%';

# 5. 将“ 李四 ”的家庭住址改为“ 广东韶关 ”
UPDATE employee
SET addr = '广东韶关'
WHERE NAME = '李四';

SELECT * FROM employee;

# 6. 查询出名字中带“小”的员工
SELECT * FROM employee
WHERE NAME LIKE '%小%';
