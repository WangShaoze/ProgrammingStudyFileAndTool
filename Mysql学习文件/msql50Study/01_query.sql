# 显示数据库有那些
SHOW DATABASES;

# 指定使用的数据库
USE companydatabase;

# 显示数据库中所有的表
SHOW TABLES;

# 创建表
CREATE TABLE employee
(NAME VARCHAR(15), id VARCHAR(15), 
age VARCHAR(15), gender VARCHAR(15), 
phone VARCHAR(15));

# 显示表中的数据
SELECT * FROM employee;
# 删除指定表
DROP TABLE employee01;  

SHOW VARIABLES LIKE '%max_connections%';
SET GLOBAL max_connections = 200;

#1、查询数据库各表记录数、数据容量（MB）、索引容量（MB）

SELECT
table_schema AS '数据库',
table_name AS '表名',
table_rows AS '记录数',
TRUNCATE(data_length/1024/1024, 2) AS '数据容量(MB)',
TRUNCATE(index_length/1024/1024, 2) AS '索引容量(MB)'
FROM information_schema.tables
WHERE table_schema='word_kao_yan'
ORDER BY data_length DESC, index_length DESC;

#2、查询各数据库的记录数、数据容量（MB）、索引容量（MB）
SELECT
table_schema AS '数据库',
SUM(table_rows) AS '记录数',
SUM(TRUNCATE(data_length/1024/1024, 2)) AS '数据容量(MB)',
SUM(TRUNCATE(index_length/1024/1024, 2)) AS '索引容量(MB)'
FROM information_schema.tables
GROUP BY table_schema
ORDER BY SUM(data_length) DESC, SUM(index_length) DESC;


# 查询表的结构
DESCRIBE employee;
DESC employee;

# 向表中插入记录
INSERT INTO employee VALUES("xioWang","RY001","19","男","13312527864");
INSERT INTO employee VALUES("xioHua","RY002","19","男","18313632768");
INSERT INTO employee VALUES("xioLin","RY003","19","男","18313452768");
INSERT INTO employee VALUES("xioPin","RY004","19","男","18313689768");
INSERT INTO employee VALUES("xioZhang","RY006","19","男","18793632768");
INSERT INTO employee VALUES("xioHua","RY005","19","男","13345678925");
INSERT INTO employee VALUES("xioPo","RY002","19","男","15453678472");

# 修改表的记录
UPDATE employee SET id='RY007' WHERE NAME='xioPo';
SELECT NAME,id,age,gender,phone FROM employee WHERE id='RY002';

#删除表中指定的记录
#DELETE * FROM all_words WHERE LENGTH(词性)>4;

# 显示表中的数据
SELECT * FROM employee;