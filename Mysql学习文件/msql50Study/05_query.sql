# 运算符
/*
1.算术运算符+- * /  div % mod   --------> {div 除法运算{取整}，%,mod{求余}}


*/

SELECT 1+2,4-1,5*2,4/2, 100+'12', 7 % 2,9 DIV 2,9 MOD 2 FROM DUAL;

SELECT 100+'Ab'  # 此时的 字符 被看作 0 处理
FROM DUAL;

SELECT 100+NULL  # 此时的 NULL 表示什么都没有,得到的还是null
FROM DUAL;

# 除法默认为浮点型，乘法只有和小数相乘时才是浮点型, 
# 100 DIV 0 结果是null

# 取模运算
SELECT 12%5,9 MOD 4, 12 MOD -5,-12 MOD 5, -12 MOD -5 FROM DUAL;   # 被模数 mod 模数
# 结果的符号只与被模数有关系
