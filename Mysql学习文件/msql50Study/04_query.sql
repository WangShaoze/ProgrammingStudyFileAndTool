SELECT * FROM employee_work;

# 计算 employee_work 员工表的的工资栏
SELECT 
NAME AS "姓名",
salary AS "月薪", 
work_month AS "工月", 
salary*IFNULL(work_month,0) AS "工资" 
FROM employee_work;