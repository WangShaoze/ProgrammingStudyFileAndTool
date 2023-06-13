CREATE DATABASE IF NOT EXISTS stock_db_test CHARACTER SET 'utf8';

`stock_db_hu_shen_a``stock000025`

CREATE TABLE IF NOT EXISTS stock000025 CHARACTER SET 'utf8' AS SELECT * FROM stock_db_hu_shen_a.stock000025;

SELECT COUNT(*) FROM stock000025 WHERE 日期 = '2023-04-15';

SELECT * FROM employees;

DESC employees;


SELECT 股票名称, 股票代码,收盘, 成交量,日期,
t1.min_point AS '最低', t1.max_point AS '最高', 
(1-(收盘-t1.min_point)/(t1.max_point-t1.min_point))*100 '得分',
t2.avg_num_five AS '五日均量',
CASE WHEN 成交量/t2.avg_num_five>=3.0 THEN '成交量异常放大'
ELSE '未异常' END '成交量情况'
FROM stock000025,(
		SELECT MIN(t.最低) min_point,MAX(t.最高) max_point
		FROM (
			SELECT 最低,最高
			FROM stock000025
			ORDER BY 日期 DESC
			LIMIT 220
			) t
		  ) t1,(
			SELECT ROUND(AVG(t.num)) avg_num_five 
			FROM (
				SELECT 成交量 num 
				FROM stock000025 
				ORDER BY 日期 DESC 
				LIMIT 5
				) t
			) t2		  
ORDER BY 日期 DESC 
LIMIT 1; 


SELECT 股票名称, 股票代码,收盘, 成交量,日期,t1.min_point AS '最低', t1.max_point AS '最高', (1-(收盘-t1.min_point)/(t1.max_point-t1.min_point))*100 '得分',t2.avg_num_five AS '五日均量',
CASE WHEN 成交量/t2.avg_num_five >=2.0 THEN '成交量异常放大'
ELSE '未异常' END '成交量情况'
FROM stock603324,(
		SELECT MIN(t.最低) min_point,MAX(t.最高) max_point
		FROM (
			SELECT 最低,最高
			FROM stock603324
			ORDER BY 日期 DESC
			LIMIT 220
			) t
		  ) t1,(SELECT ROUND(AVG(t.num)) avg_num_five FROM (SELECT 成交量 num FROM stock603324 ORDER BY 日期 DESC LIMIT 5) t) t2		  
ORDER BY 日期 DESC 
LIMIT 1; 



SELECT 股票名称, 股票代码,收盘, 成交量,日期,t1.min_point AS '最低', t1.max_point AS '最高', (1-(收盘-t1.min_point)/(t1.max_point-t1.min_point))*100 '得分',t2.avg_num_five AS '五日均量',
CASE WHEN 成交量/t2.avg_num_five >=2.0 THEN CONCAT('成交量', ROUND(成交量/t2.avg_num_five,3),'倍:','成交量异常放大') ELSE CONCAT('成交量',ROUND(成交量/t2.avg_num_five, 3),'倍:','未异常') END '成交量情况'
FROM stock603690,(SELECT MIN(t.最低) min_point,MAX(t.最高) max_point FROM (SELECT 最低,最高 FROM stock603690 ORDER BY 日期 DESC LIMIT 220) t) t1,(SELECT ROUND(AVG(t.num)) avg_num_five FROM (SELECT 成交量 num FROM stock603690 ORDER BY 日期 DESC LIMIT 5) t) t2		  
ORDER BY 日期 DESC LIMIT 1; 


SELECT 股票名称, 股票代码,收盘, 成交量,日期,t1.min_point AS '最低', t1.max_point AS '最高', (1-(收盘-t1.min_point)/(t1.max_point-t1.min_point))*100 '得分',t2.avg_num_five AS '五日均量',
CASE WHEN 成交量/t2.avg_num_five >=2.0 THEN CONCAT('成交量', ROUND(成交量/t2.avg_num_five,3),'倍:','成交量异常放大') ELSE CONCAT('成交量',ROUND(成交量/t2.avg_num_five, 3),'倍:','未异常') END '成交量情况'
FROM stock002756,(SELECT MIN(t.最低) min_point,MAX(t.最高) max_point FROM (SELECT 最低,最高 FROM stock002756 ORDER BY 日期 DESC LIMIT 220) t) t1,(SELECT ROUND(AVG(t.num)) avg_num_five FROM (SELECT 成交量 num FROM stock002756 ORDER BY 日期 DESC LIMIT 5) t) t2		  
ORDER BY 日期 DESC LIMIT 1; 

SELECT 股票名称, 股票代码,收盘, 成交量,日期,
t1.min_point AS '最低', t1.max_point AS '最高', 
(1-(收盘-t1.min_point)/(t1.max_point-t1.min_point))*100 '得分',
t2.avg_num_five AS '五日均量',
CASE WHEN 成交量/t2.avg_num_five>=3.0 
	THEN CONCAT('成交量', ROUND(成交量/t2.avg_num_five,3),'倍:','成交量异常放大') 
	ELSE CONCAT('成交量',ROUND(成交量/t2.avg_num_five, 3),'倍:','未异常') 
	END '成交量情况'
FROM stock000025,(
		SELECT MIN(t.最低) min_point,MAX(t.最高) max_point
		FROM (
			SELECT 最低,最高
			FROM stock000025
			ORDER BY 日期 DESC
			LIMIT 220
			) t
		  ) t1,(
			SELECT ROUND(AVG(t.num)) avg_num_five 
			FROM (
				SELECT 成交量 num 
				FROM stock000025 
				ORDER BY 日期 DESC 
				LIMIT 5
				) t
			) t2		  
ORDER BY 日期 DESC 
LIMIT 1; 


SELECT 股票名称, 股票代码,收盘,日期,成交量,t2.avg_num_five AS '五日均量',
CASE 
 WHEN 成交量/t2.avg_num_five>5 THEN '放巨量'
 WHEN 成交量/t2.avg_num_five>=3 AND 成交量/t2.avg_num_five<=5 THEN '异常放大'
 CONCAT('成交量', ROUND(成交量/t2.avg_num_five,3),'倍:','异常放大')
 ELSE '未出现异常' END '成交量情况'
FROM stock000025,(
		SELECT ROUND(AVG(t.num)) avg_num_five 
		FROM (
			SELECT 成交量 num 
			FROM stock000025 
			ORDER BY 日期 DESC 
			LIMIT 5
			) t
		  ) t2
ORDER BY 日期 DESC
LIMIT 1;


DESC stock002756;


SELECT 股票名称, 股票代码,收盘,日期,成交量,最高,最低
FROM stock002756;

SELECT MAX(最高) max_point,MIN(最低) min_point
FROM (
	SELECT 最高,最低
	FROM stock002756
	ORDER BY 日期 DESC
	LIMIT 220
	) t;


SELECT 日期,股票名称, 股票代码,收盘,t1.max_point AS '最高', t1.min_point AS '最低',
(1-(收盘-t1.min_point)/(t1.max_point-t1.min_point))*100 AS '得分',
成交量, t2.avg_five_volume AS '5日均量', ROUND(成交量/t2.avg_five_volume, 3) AS '比率',
CASE WHEN ROUND(成交量/t2.avg_five_volume, 3) > 5.0 THEN CONCAT('比率:',(ROUND(成交量/t2.avg_five_volume, 3)), '倍，放巨量')
     WHEN ROUND(成交量/t2.avg_five_volume, 3) > 3.0 THEN CONCAT('比率:',(ROUND(成交量/t2.avg_five_volume, 3)), '倍，异常放量')
     WHEN ROUND(成交量/t2.avg_five_volume, 3) > 2.5 THEN CONCAT('比率:',(ROUND(成交量/t2.avg_five_volume, 3)), '倍，放轻量')
     ELSE CONCAT('比率:',(ROUND(成交量/t2.avg_five_volume, 3)), '倍，没有异常') END '成交量的情况'
FROM stock002756,(
			SELECT MAX(最高) max_point,MIN(最低) min_point
			FROM (
				SELECT 最高,最低
				FROM stock002756
				ORDER BY 日期 DESC
				LIMIT 220
				) t
			) t1,
			(
				SELECT AVG(成交量) avg_five_volume
				FROM (
				SELECT 成交量
				FROM stock002756
				ORDER BY 日期 DESC
				LIMIT 5
				) t			
			) t2
ORDER BY 日期 DESC
LIMIT 1;


SELECT 日期,股票名称, 股票代码,收盘,t1.max_point AS '最高', t1.min_point AS '最低', (1-(收盘-t1.min_point)/(t1.max_point-t1.min_point))*100 AS '得分', 成交量, t2.avg_five_volume AS '5日均量', ROUND(成交量/t2.avg_five_volume, 3) AS '比率', CASE WHEN ROUND(成交量/t2.avg_five_volume, 3) > 5.0 THEN CONCAT('比率:',(ROUND(成交量/t2.avg_five_volume, 3)), '倍，放巨量') WHEN ROUND(成交量/t2.avg_five_volume, 3) > 3.0 THEN CONCAT('比率:',(ROUND(成交量/t2.avg_five_volume, 3)), '倍，异常放量') WHEN ROUND(成交量/t2.avg_five_volume, 3) > 2.5 THEN CONCAT('比率:',(ROUND(成交量/t2.avg_five_volume, 3)), '倍，放轻量') ELSE CONCAT('比率:',(ROUND(成交量/t2.avg_five_volume, 3)), '倍，没有异常') END '成交量的情况' FROM stock688488,(SELECT MAX(最高) max_point,MIN(最低) min_point FROM (SELECT 最高,最低 FROM stock688488 ORDER BY 日期 DESC LIMIT 220) t) t1,(SELECT AVG(成交量) avg_five_volume FROM (SELECT 成交量 FROM stock688488 ORDER BY 日期 DESC LIMIT 5 ) t ) t2 ORDER BY 日期 DESC LIMIT 1;


SELECT 日期,股票名称, 股票代码,收盘,最高,最低 
FROM stock002756 
ORDER BY 日期 DESC;

SELECT 日期,股票名称, 股票代码,收盘,最高,最低,ROUND(REPLACE(涨跌幅, '%', ''), 2) AS 涨幅
FROM stock002756 
ORDER BY ROUND(REPLACE(涨跌幅, '%', ''), 2) DESC;

/*
涨停的条件是: 当日涨幅大于9.90%，
查找最近60日内的涨幅数据，判断涨幅数据判断涨幅大于5%的比率                                               
*/

SELECT 股票代码 AS `code`, 涨跌幅 zhang_fu,CASE WHEN ROUND(REPLACE(涨跌幅, '%', ''), 2)>=9.98 THEN '涨停' ELSE '今天没有涨停' END zhang_fu_case
FROM stock002158
ORDER BY 日期 DESC LIMIT 1;