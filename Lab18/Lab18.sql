--            TASK 1
create table Lab18(
id number(15) PRIMARY KEY,
text varchar2(20),
date_value date)
tablespace users;

DROP TABLE Lab18;

SELECT * FROM Lab18;

spool 'D:\ALEX\STUDY\5SEM_3COURSE\Базы данных - 3 курс\Готовые лабораторные работы\Lab18\export.txt';
select * from Lab18; 
spool off;