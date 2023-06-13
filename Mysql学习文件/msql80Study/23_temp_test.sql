SELECT DISTINCT 股票名称,股票代码, (SELECT COUNT(*) FROM stock688314) AS 记录数 FROM stock688314;


SELECT TO_DAYS(NOW()) - TO_DAYS('2010-02-03') FROM DUAL;

SELECT DISTINCT 日期,股票名称,股票代码 FROM stock000610;
SELECT COUNT(*) FROM stock000610 WHERE 1=1;
SELECT COUNT(*) FROM (SELECT FROM stock000610) t;
DESC stock000610;

SELECT DISTINCT 日期,股票名称,股票代码,开盘,收盘,涨跌额,涨跌幅,最低,最高,成交量,成交额, 换手率 FROM stock000610;

SELECT COUNT(*) FROM (SELECT DISTINCT 日期,股票名称,股票代码,开盘,收盘,涨跌额,涨跌幅,最低,最高,成交量,成交额, 换手率 FROM stock000610) t;

CREATE DATABASE IF NOT EXISTS stock_db_hu_shen_A CHARACTER SET 'utf8';
USE stock_db_hu_shen_A;

CREATE TABLE IF NOT EXISTS stock000610
AS
SELECT DISTINCT 日期,股票名称,股票代码,开盘,收盘,涨跌额,涨跌幅,最低,最高,成交量,成交额, 换手率 FROM stock_db.stock000610 ORDER BY 日期 DESC;

SHOW TABLES;
SELECT * FROM stock000610;
SELECT COUNT(*) FROM stock000610;

DROP TABLE stock000610;

USE stock_db_hu_shen_A;
USE stock_db;
SELECT * FROM stock601949;
SELECT COUNT(*) FROM stock601949;

SELECT * FROM stock002095;
SELECT COUNT(*) FROM stock002095;

INSERT INTO stock002095 VALUES();

DESC stock002095;

CREATE TABLE tkp1(日期 DATE);
INSERT INTO tkp1 VALUES(NOW());
SELECT * FROM tkp1;

INSERT INTO stock603617 VALUES(NOW(),'君禾股份','603617','8.07','8.56','0.5','6.2%','8.05','8.68','91424','7713.16','2.39%');
SELECT * FROM stock603617 ORDER BY 日期 DESC;