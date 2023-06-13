-- 20_parctice_MySQL
#第11章_数据处理之增删改
#0. 储备工作
CREATE DATABASE IF NOT EXISTS my_study11 CHARACTER SET 'utf8';
USE my_study11;
SHOW CREATE DATABASE my_study11;
SHOW TABLES FROM my_study11;

CREATE TABLE IF NOT EXISTS emp1(
id INT,
`name` VARCHAR(15),
hire_date DATE,
salary DOUBLE(10,2)
);
SHOW TABLES FROM my_study11;
DESC emp1;
SELECT * FROM emp1;

#1. 添加数据

#方式1：一条一条的添加数据

# ① 没有指明添加的字段
#正确的 ：  #注意：一定要按照声明的字段的先后顺序添加
INSERT INTO emp1 VALUES(
1,'Tom','2000-12-21',3400
)
#错误的
INSERT INTO emp1
VALUES (2,3400,'2000-12-21','Jerry');

SELECT * FROM emp1;

# ② 指明要添加的字段 （推荐）
INSERT INTO emp1(id, salary, hire_date, `name`)
VALUES(2, 3400, '2000-12-21', 'Gikie');
# 说明：没有进行赋值的hire_date 的值为 null
INSERT INTO emp1(id,salary,`name`)
VALUES(3,4500,'shk');

SELECT * FROM emp1;

# ③ 同时插入多条记录 （推荐）
INSERT INTO emp1(id, `name`, hire_date, salary)
VALUES
(4,'Kpoo','2000-12-23',3400),
(5,'liKew','2000-2-1',4300),
(6,'jjonm','2000-1-4',2600),
(7,'ntlw','2000-7-1',3599);

SELECT * FROM emp1;


#方式2：将查询结果插入到表中
INSERT INTO emp1(id, `name`, hire_date, salary)
# 使用查询语句
SELECT employee_id, last_name, hire_date, salary
FROM atguigudb.`employees`
LIMIT 15;
#说明：emp1表中要添加数据的字段的长度不能低于employees表中查询的字段的长度。
# 如果emp1表中要添加数据的字段的长度低于employees表中查询的字段的长度的话，就有添加不成功的风险。
SELECT * FROM emp1;

###########################
#2. 更新数据 （或修改数据）
# UPDATE .... SET .... WHERE ...

# 可以实现批量修改数据的。
UPDATE emp1
SET hire_date = CURDATE()
WHERE id = 3;

SELECT * FROM emp1;

#同时修改一条数据的多个字段
UPDATE emp1
SET `name` = 'shelike', hire_date =  CURDATE(), salary=5000
WHERE id = 3;

SELECT * FROM emp1;

#题目：将表中姓名中包含字符a的提薪20%
UPDATE emp1
SET salary = 200
WHERE `name` LIKE '%a%';

SELECT * FROM emp1;

#修改数据时，是可能存在不成功的情况的。（可能是由于约束的影响造成的）
UPDATE employees
SET department_id = 10000
WHERE employee_id = 102;

##############################
#3. 删除数据 DELETE FROM .... WHERE....
DELETE FROM emp1
WHERE id = 100;

#在删除数据时，也有可能因为约束的影响，导致删除失败
DELETE FROM departments
WHERE department_id = 50;

SELECT * FROM emp1;

#小结：DML操作默认情况下，执行完以后都会自动提交数据。
# 如果希望执行完以后不自动提交数据，则需要使用 SET autocommit = FALSE.


############################
#4. MySQL8的新特性：计算列

CREATE TABLE test1(
a INT,
b INT,
c INT GENERATED ALWAYS AS (a + b) VIRTUAL  #字段c即为计算列
);

CREATE TABLE test01(
a1 INT,
a2 INT,
a3 INT generated always AS (a1+a2) virtual  #字段c即为计算列
);

SELECT * FROM test01;

INSERT INTO test01(a1, a2)
VALUES
(12, 43),
(78, 34),
(89, 10);

SELECT * FROM test01;

UPDATE test01
SET a1=22;


#5.综合案例
# 1、创建数据库test01_library
CREATE DATABASE IF NOT EXISTS test01_library; 
USE test01_library;
SHOW CREATE DATABASE test01_library;

# 2、创建表 books，表结构如下：
/*
字段名 字段说明 数据类型
id 书编号 INT
name 书名 VARCHAR(50)
authors 作者 VARCHAR(100)
price 价格 FLOAT
pubdate 出版日期 YEAR
note 说明 VARCHAR(100)
num 库存 INT
*/

CREATE TABLE books(
id INT,
NAME VARCHAR(50),
AUTHORS VARCHAR(100),
price FLOAT,
pubdate YEAR,
note VARCHAR(100),
num INT
);

# 3、向books表中插入记录
/*
1 Tal of AAA Dickes 23 1995 novel 11
2 EmmaT Jane lura 35 1993 joke 22
3 Story of Jane Jane Tim 40 2001 novel 0
4 Lovey Day George Byron 20 2005 novel 30
5 Old land Honore Blade 30 2010 law 0
6 The Battle Upton Sara 30 1999 medicine 40
7 Rose Hood Richard haggard 28 2008 cartoon 28
*/
DESC books;

# 1）不指定字段名称，插入第一条记录
INSERT INTO books VALUES(1,'Tal of AAA', 'Dickes',23,'1995', 'novel',11);
# 2）指定所有字段名称，插入第二记录
INSERT INTO books (id, NAME, AUTHORS, price, pubdate, note, num)
VALUES(2,'EmmaT', 'Jane lura',35,'1993', 'joke',22);
# 3）同时插入多条记录（剩下的所有记录）
INSERT INTO books (id, NAME, AUTHORS, price, pubdate, note, num)
VALUES
(3, 'Story of Jane', 'Jane Tim', 40, '2001','novel',0),
(4,'Lovey Day', 'George Byron', 20, '2005', 'novel', 30),
(5, 'Old land', 'Honore Blade', 30, '2010', 'law', 0),
(6, 'The Battle', 'Upton Sara', 30, '1999', 'medicine', 40),
(7, 'Rose Hood', 'Richard haggard',28, '2008', 'cartoon', 28);

SELECT * FROM books;


# 4、将小说类型(novel)的书的价格都增加5。
UPDATE books
SET price = price+5
WHERE note = 'novel';

SELECT * FROM books;
# 5、将名称为EmmaT的书的价格改为40，并将说明改为drama。
UPDATE books
SET price = 40, note = 'drama'
WHERE `name`='EmmaT';

SELECT * FROM books;

# 6、删除库存为0的记录。
DELETE FROM books WHERE num=0;

# 7、统计书名中包含a字母的书
SELECT * FROM books WHERE `name` LIKE '%a%';


# 8、统计书名中包含a字母的书的数量和库存总量
SELECT COUNT(*), SUM(num)
FROM books 
WHERE `name` LIKE '%a%';


# 9、找出“novel”类型的书，按照价格降序排列
SELECT * 
FROM books
WHERE note = 'novel'
ORDER BY price DESC;

# 10、查询图书信息，按照库存量降序排列，如果库存量相同的按照note升序排列
SELECT * 
FROM books
ORDER BY num DESC, note ASC;

# 11、按照note分类统计书的数量
SELECT note, COUNT(*) 
FROM books
GROUP BY note;

# 12、按照note分类统计书的库存量，显示库存量超过30本的
SELECT note, SUM(num) AS '库存量'
FROM books
GROUP BY note
HAVING SUM(num) >=30;

# 13、查询所有图书，每页显示5本，显示第二页
SELECT * FROM books
LIMIT 5,5;

# 14、按照note分类统计书的库存量，显示库存量最多的
SELECT note, SUM(num) all_num
FROM books
GROUP BY note
ORDER BY all_num DESC
LIMIT 1;

# 15、查询书名达到10个字符的书，不包括里面的空格
# 16、查询书名和类型，其中note值为novel显示小说，law显示法律，medicine显示医药，cartoon显示卡通，joke显示笑话
# 17、查询书名、库存，其中num值超过30本的，显示滞销，大于0并低于10的，显示畅销，为0的显示需要无货
# 18、统计每一种note的库存量，并合计总量
# 19、统计每一种note的数量，并合计总量
# 20、统计库存量前三名的图书
# 21、找出最早出版的一本书
# 22、找出novel中价格最高的一本书
# 23、找出书名中字数最多的一本书，不含空格