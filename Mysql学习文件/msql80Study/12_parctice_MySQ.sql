/*

12_parctice_MySQ
单行函数

*/

# 1.1 数学基本运算 （一）
SELECT ABS(-11),ABS(12),SIGN(-23),SIGN(43),PI(),CEIL(32.01),CEIL(-32.01),CEILING(32.01),CEILING(-43.3),
FLOOR(32.01),FLOOR(-43.23),MOD(12,5) 
FROM DUAL;
# 取随机数，中间设置的数字是随机数的种子，用于确保生成的随机数是相同的
SELECT RAND(), RAND(), RAND(10), RAND(10),RAND(-1),RAND(-1)
FROM DUAL;
# 保留小数的位数，使用 round() 和 TRUNCATE() 
SELECT ROUND(12.335), ROUND(12.356,2),ROUND(12.335,1),ROUND(12.335,-1)
FROM DUAL;
# TRUNCATE()  在使用的时候不会四舍五入是直接截断
SELECT TRUNCATE(12.335, 2), TRUNCATE(12.335, 1), TRUNCATE(12.335,-1)
FROM DUAL;

# RADIANS(角度数),DEGREES(弧度) 实现角度与弧度的相互转换
SELECT RADIANS(60),RADIANS(30),RADIANS(1),DEGREES(2*PI()),DEGREES(RADIANS(90))
FROM DUAL;

# 1.2 三角函数
SELECT
SIN(RADIANS(30)),DEGREES(ASIN(1)),TAN(RADIANS(45)),DEGREES(ATAN(1)),DEGREES(ATAN2(1,1)
)
FROM DUAL;

SELECT SIN(RADIANS(30)), DEGREES(ASIN(1)),TAN(RADIANS(45)),DEGREES(ATAN(1)),DEGREES(ATAN2(1,1))
FROM DUAL;

# 1.3 幂运算
SELECT POW(2,3),POWER(2,3)
FROM DUAL;
# EXP(X) 返回e的X次方，其中e是一个常数，2.718281828459045
SELECT EXP(1),EXP(2)
FROM DUAL;
# LN(X)，LOG(X) 返回以e为底的X的对数，当X <= 0 时，返回的结果为NULL
SELECT LN(EXP(1)),LN(1),LOG(EXP(1)),LOG(POW(EXP(1),2))
FROM DUAL;
# 返回以10为底的X的对数，当X <= 0 时，返回的结果为NULL
SELECT LOG10(10),LOG10(POW(10,2))
FROM DUAL;
# 返回以2为底的X的对数，当X <= 0 时，返回NULL
SELECT LOG2(2),LOG2(POW(2,2))
FROM DUAL;

# 1.4 进制间的转换
# BIN(x) 返回x的二进制编码
# HEX(x) 返回x的十六进制编码
# OCT(x) 返回x的八进制编码
# CONV(x,f1,f2) 返回f1进制数变成f2进制数

SELECT BIN(10),BIN(2),HEX(1),HEX(10),HEX(11),HEX(12),HEX(13),HEX(16),
OCT(0), OCT(1), OCT(7),OCT(8),OCT(9)
FROM DUAL;

SELECT CONV(9, 10, 8)
FROM DUAL;

# 2.1 字符串函数
# ASCII(S) 返回字符串S中的第一个字符的ASCII码值
SELECT ASCII('a'),ASCII('z'),
ASCII('A'), ASCII('Z')
FROM DUAL;
#CHAR_LENGTH(s) 返回字符串s的字符数。作用与CHARACTER_LENGTH(s)相同
SELECT CHAR_LENGTH('nihao'),CHARACTER_LENGTH('nihao'),
CHAR_LENGTH('你好'),CHARACTER_LENGTH('你好')
FROM DUAL;

# LENGTH(s) 返回字符串s的字节数，和字符集有关
SELECT LENGTH('hello'),LENGTH('你好')
FROM DUAL;

# CONCAT(s1,s2,......,sn) 连接s1,s2,......,sn为一个字符串
SELECT CONCAT('hello',',','world')
FROM DUAL;

SELECT CONCAT('hello','数据库','world')
FROM DUAL;

# CONCAT_WS(x,s1,s2,......,sn) 同CONCAT(s1,s2,...)函数，但是每个字符串之间要加上x
SELECT CONCAT_WS('，', '它','是','一只','小狗')
FROM DUAL;

# INSERT(str, idx, len,replacestr)
# 将字符串str从第idx位置开始，len个字符长的子串替换为字符串replacestr
SELECT INSERT('ni_hao_hello_world', 3,4,'goddod'), 
INSERT('ni_hao_hello_world', 3,0,'goddod')  # 只是插入，没有替换原来的任何字符
FROM DUAL;

# REPLACE(str, a, b) 用字符串b替换字符串str中所有出现的字符串a
SELECT REPLACE('can you give me your pen?',' ','-')
FROM DUAL;

# UPPER(s) 或 UCASE(s) 将字符串s的所有字母转成大写字母
# LOWER(s) 或LCASE(s) 将字符串s的所有字母转成小写字母
SELECT UPPER('you'),UCASE('are'),LOWER('Mood'),LCASE('MOON')
FROM DUAL;

# LEFT(str,n) 返回字符串str最左边的n个字符
# RIGHT(str,n) 返回字符串str最右边的n个字符
SELECT LEFT('option',1),RIGHT('option',1),LEFT('option',3),RIGHT('option',3)
FROM DUAL;

# LPAD(str, len, pad) 用字符串pad对str最左边进行填充，直到str的长度为len个字符
# RPAD(str ,len, pad) 用字符串pad对str最右边进行填充，直到str的长度为len个字符
SELECT LPAD('hello', 10, '-'),RPAD('hello',10,'-')
FROM DUAL;

/*
LTRIM(s) 去掉字符串s左侧的空格
RTRIM(s) 去掉字符串s右侧的空格
TRIM(s) 去掉字符串s开始与结尾的空格
TRIM(s1 FROM s) 去掉字符串s开始与结尾的s1
TRIM(LEADING s1
FROM s)
去掉字符串s开始处的s1
TRIM(TRAILING s1
FROM s)
去掉字符串s结尾处的s1
*/

SELECT TRIM('  -hello-              '),
LTRIM('  -hello-              '),RTRIM('  -hello-              '),
TRIM('l' FROM 'llhellol'),
TRIM('o' FROM 'ooollhello')
FROM DUAL;

SELECT 
TRIM(LEADING 'ni' FROM 'nihao世界'),TRIM(TRAILING '---' FROM 'can you---')
FROM DUAL;

# REPEAT(str, n) 返回str重复n次的结果
SELECT REPEAT('ha',3) FROM DUAL;

# SPACE(n) 返回n个空格
SELECT CONCAT('nihao', SPACE(5),'hello world') FROM DUAL;

# STRCMP(s1,s2) 比较字符串s1,s2的ASCII码值的大小
SELECT STRCMP('abc', 'abe') FROM DUAL;

# SUBSTR(s,index,len)
# 返回从字符串s的index位置其len个字符，作用与SUBSTRING(s,n,len)、MID(s,n,len)相同
SELECT SUBSTR('can you give me you pen?',5, 10),SUBSTRING('can you give me you pen?',5, 10),MID('can you give me you pen?',5, 10)
FROM DUAL;

# LOCATE(substr,str)
# 返回字符串substr在字符串str中首次出现的位置，作用于POSITION(substr IN str)、INSTR(str,substr)相同。未找到，返回0

SELECT LOCATE('lo','hello world'),
POSITION('lo' IN 'hello world'),
INSTR('hello world', 'lo')
FROM DUAL;

# ELT(m,s1,s2,…,sn)
# 返回指定位置的字符串，如果m=1，则返回s1，如果m=2，则返回s2，如果m=n，则返回sn
SELECT ELT(2, 'ni','ho','ki','pl') FROM DUAL;

# FIELD(s,s1,s2,…,sn) 返回字符串s在字符串列表中第一次出现的位置
SELECT FIELD('ko', 'lo','ji','ko','ge','ko') FROM DUAL;

# FIND_IN_SET(s1,s2)
# 返回字符串s1在字符串s2中出现的位置。其中，字符串s2是一个以逗号分隔的字符串
SELECT FIND_IN_SET('si','ko,si,mo,si,li,si') FROM DUAL;

# REVERSE(s) 返回s反转后的字符串
SELECT REVERSE('妈妈爱我') FROM DUAL;

# NULLIF(value1,value2)
# 比较两个字符串，如果value1与value2相等，则返回NULL，否则返回value1
SELECT NULLIF('kopo','kopl'),NULLIF('koko', 'koko') FROM DUAL;


# 3.日期和时间函数

# 3.1获取当前的日期和时间
SELECT CURDATE(), CURRENT_DATE(),  #返回当前日期，只包含年、月、日
CURTIME(),CURRENT_TIME(), # 返回当前时间，只包含时、分、秒
NOW(),SYSDATE(),CURRENT_TIMESTAMP(),LOCALTIME(),LOCALTIMESTAMP(), # 返回日期和时间
UTC_DATE(), # 返回现在世界的标准日期
UTC_TIME() # 返回现在世界的标准时间
FROM DUAL;

# 3.2获取当前日期与时间戳的转换
SELECT UNIX_TIMESTAMP(),UNIX_TIMESTAMP('2023-03-21 21:12:55'), # 将日期和时间转化为时间戳
FROM_UNIXTIME('1679404375') # 将时间戳转化为日期
FROM DUAL;

# 3.3 获取月份、星期、星期数、天数等函数
SELECT YEAR('2023-03-21'),MONTH('2023-03-21'),DAY('2023-03-21'),
HOUR('2023-03-21 21:12:55'),MINUTE('2023-03-21 21:12:55'),SECOND('2023-03-21 21:12:55'),
MONTHNAME('2023-03-21 21:12:55'),DAYNAME('2023-03-21 21:12:55'),WEEKDAY('2023-03-21 21:12:55'),
QUARTER('2023-03-21 21:12:55'),
WEEK('2023-03-21 21:12:55'),WEEKOFYEAR('2023-03-21 21:12:55'),
DAYOFYEAR('2023-03-21 21:12:55'),DAYOFMONTH('2023-03-21 21:12:55'),DAYOFWEEK('2023-03-21 21:12:55')
FROM DUAL;

# 3.4 抽取出时间中的特定的部分
SELECT 
EXTRACT(MINUTE FROM NOW()), # 返回指定日期中特定的部分，type指定返回的值
EXTRACT(YEAR FROM NOW()),
EXTRACT(WEEK FROM NOW()),
EXTRACT(MICROSECOND FROM '2023-03-21 21:12:55')
FROM DUAL;

SELECT EXTRACT(MINUTE FROM NOW()),EXTRACT( WEEK FROM NOW()),
EXTRACT( QUARTER FROM NOW()),EXTRACT( MINUTE_SECOND FROM NOW())
FROM DUAL;

# 3.5 时间和秒钟转换的函数
SELECT TIME_TO_SEC(NOW()),SEC_TO_TIME('75554')
FROM DUAL;

# 3.6 计算日期和时间的函数
# 日期和时间做加法
SELECT 
DATE_ADD('2023-03-21 21:12:55', INTERVAL '1_1' MINUTE_SECOND) AS col1,
ADDDATE('2023-03-21 21:12:55', INTERVAL '1_1' MINUTE_SECOND) AS col2,
DATE_ADD(NOW(), INTERVAL -1 YEAR) AS col3,
ADDDATE(NOW(), INTERVAL '1_1' DAY_HOUR) AS col4
FROM DUAL;
#日期和时间做减法
SELECT DATE_SUB(NOW(), INTERVAL 30 DAY),
SUBDATE(NOW(), INTERVAL 8192 DAY)
FROM DUAL;

#两个时间加减
SELECT NOW(),ADDTIME(NOW(), '45'),ADDTIME(NOW(), '12:10:11'),SUBTIME(NOW(), '10'),
DATEDIFF(NOW(), '2000-10-25 02:30:42'),
TIMEDIFF('10:25:10', '11:25:10')
FROM DUAL;

SELECT FROM_DAYS(366),LAST_DAY(NOW()), MAKEDATE('2015',32),MAKETIME('12','14','56'),
PERIOD_ADD(20210102010102,10)
FROM DUAL;

SHOW TABLES;
SELECT * FROM employees;

# 计算入职超过 10000 day 的 人
SELECT COUNT(*) AS num 
FROM employees WHERE TO_DAYS(NOW())-TO_DAYS(hire_date) >=10000;

# 3.7 日期的格式化与解析
/*
函数 			用法
DATE_FORMAT(date,fmt) 按照字符串fmt格式化日期date值
TIME_FORMAT(time,fmt) 按照字符串fmt格式化时间time值
GET_FORMAT(date_type,format_type) 返回日期字符串的显示格式
STR_TO_DATE(str, fmt) 按照字符串fmt对str进行解析，解析为一个日期
*/

SELECT DATE_FORMAT(NOW(), '%Y-%m-%d %H:%i:%S'), # 对日期进行格式化
TIME_FORMAT(NOW(), '%H:%i:%S'), # 对时间进行格式化
STR_TO_DATE('20000918','%Y%m%d'),  # 将给定的str解析为日期
GET_FORMAT(DATE, 'USA') #返回日期字符串的显示格式
FROM DUAL;


SELECT 
DATE_FORMAT(NOW(), GET_FORMAT(DATE, 'USA')),
DATE_FORMAT(NOW(), GET_FORMAT(DATETIME, 'USA')),
DATE_FORMAT(NOW(), GET_FORMAT(DATE, 'EUR')),
DATE_FORMAT(NOW(), GET_FORMAT(DATETIME, 'EUR'))
FROM DUAL;


# 4.1流程控制函数:也称流程处理函数可以根据不同的条件，
# 执行不同的处理流程，可以在SQL语句中实现不同的条件选择。
# MySQL中的流程处理函数主要包括IF()、IFNULL()和CASE()函数。
SELECT IF(1>0, '正确','错误') FROM DUAL;  # 条件成立返回的是第一个结果，
# 否则返回第二个结果

SELECT IFNULL(NULL, 'hello world'),IFNULL(1, 'hello world') FROM DUAL; # 判断第一个值是否为null，
# 是null返回的是第二个值，不是null就直接返回

SELECT CASE
	WHEN 1>0
	THEN '1>0'
	WHEN 2>0
	THEN '2>0'
	ELSE '3>0'
	END
FROM DUAL; # 相当于 if ... else if ...else...

SELECT employee_id,salary, CASE WHEN salary >= 15000 THEN '高薪'
				WHEN salary >= 10000 THEN '潜力股'
				WHEN salary >= 8000 THEN '屌丝'
				ELSE '草根' END '薪资段位'
FROM employees;

SELECT CASE WHEN 1>0 THEN 'yes' WHEN 1<= 0 THEN 'no' ELSE 'unknown' END;

SELECT CASE WHEN 1 < 0 THEN 'yes' WHEN 1 = 0 THEN 'no' ELSE 'unknown' END;

SELECT CASE 1
	WHEN 1 THEN '我是1'
	WHEN 2 THEN '我是2'
	ELSE 'who are you?'
END FROM DUAL;  # 相当于java中的swich case语句

SELECT CASE 1 WHEN 0 THEN 0 WHEN 1 THEN 1 ELSE -1 END;

SELECT CASE -1 WHEN 0 THEN 0 WHEN 1 THEN 1 ELSE -1 END;

SELECT CASE 0 WHEN 0 THEN 0 WHEN 1 THEN 1 ELSE -1 END;

SELECT employee_id, 12*salary*(1+IFNULL(commission_pct,0)) AS 'annul_salary'
FROM employees;

SELECT last_name, job_id, salary, CASE job_id
				WHEN 'IT_PROG' THEN 1.10*salary
				WHEN 'ST_CLERK' THEN 1.15*salary
				WHEN 'SA_REP' THEN 1.20*salary
				ELSE salary END 'REVISED_SALARY'
FROM employees;

/*
练习：查询部门号为 10,20, 30 的员工信息, 若部门号为 10, 则打印其工资的 1.1 倍, 
20 号部门, 则打印其工资的 1.2 倍, 30 号部门打印其工资的 1.3 倍数。
*/

SELECT last_name, department_id,salary,CASE department_id
					WHEN 10 THEN 1.10*salary
					WHEN 20 THEN 1.20*salary
					WHEN 30 THEN 1.30*salary
					ELSE salary END 'revised_salary'
FROM employees;


# 5.加密与解密函数
/*
加密与解密函数主要用于对数据库中的数据进行加密和解密处理，以防止数据被他人窃取。
这些函数在保证数据库安全时非常有用。

PASSWORD(str) 返回字符串str的加密版本，41位长的字符串。加密结果 不可逆 ，常用于用户的密码加密
MD5(str) 返回字符串str的md5加密后的值，也是一种加密方式。若参数为NULL，则会返回NULL
SHA(str) 从原明文密码str计算并返回加密后的密码字符串，当参数为NULL时，返回NULL。 SHA加密算法比MD5更加安全 。
ENCODE(value,password_seed) 返回使用password_seed作为加密密码加密value
DECODE(value,password_seed) 返回使用password_seed作为加密密码解密value
 可以看到，ENCODE(value,password_seed)函数与DECODE(value,password_seed)函数互为反函数。

*/
SELECT PASSWORD('mysql') FROM DUAL;
SELECT PASSWORD('mysql'), PASSWORD(NULL);
SELECT MD5('123');
SELECT SHA('not7850momo');
SELECT ENCODE('mysql', '256');
SELECT DECODE(ENCODE('mysql', 'mysql'), '256');


# 6. MySQL信息函数
# MySQL中内置了一些可以查询MySQL信息的函数，这些函数主要用于帮助数据库开发或运维人员更好地
# 对数据库进行维护工作。

SELECT 
VERSION(), # 返回当前MySQL的版本号
CONNECTION_ID(), # 返回当前MySQL服务器的连接数
SCHEMA(),DATABASE(), # 返回MySQL命令行当前所在的数据库
USER(),CURRENT_USER(), SYSTEM_USER(), SESSION_USER(), # 返回当前连接MySQL的用户名，返回结果格式为“主机名@用户名”
CHARSET('ABC'), # 返回字符串value自变量的字符集
COLLATION('ABC'); # 返回字符串value的比较规则

/*
7.MySQL中有些函数无法对其进行具体的分类，但是这些函数在MySQL的开发和运维过程中也是不容忽视
的。

*/
# 7.1返回对数字value进行格式化后的结果数据。n表示 四舍五入 后保留到小数点后n位
SELECT FORMAT('4566.45866',2), FORMAT('4566.45866',3),FORMAT('4566.45866',0),
FORMAT('4566.45866',-1)
FROM DUAL; # 如果n的值小于或者等于0，则只保留整数部分

# 7.2 将value的值进行不同进制之间的转换
SELECT CONV(1010, 2, 10),CONV(1010, 2, 10), CONV(45, 10, 2),CONV(45, 10, 8),CONV(45, 10, 16),CONV(NULL, 10, 2)
FROM DUAL;

SELECT INET_ATON('192.168.1.100'); #将以点分隔的IP地址转化为一个数字
# 以“192.168.1.100”为例，计算方式为192乘以256的3次方，加上168乘以256的2次方，
# 加上1乘以256，再加上100。

SELECT BENCHMARK(100000, MD5('mysql')); # 将表达式expr重复执行n次。用于测试MySQL处理expr表达式所耗费的时间

SELECT CHARSET('mysql'), CHARSET(CONVERT('mysql' USING 'utf8')); 
SELECT CHARSET('mysql'), CHARSET(CONVERT('mysql' USING 'utf8'));
#将value所使用的字符编码修改为char_code

