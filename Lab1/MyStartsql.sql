
--▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬
DELETE KAA_t where x=1 or x=2 or x=3;
--OR
TRUNCATE TABLE KAA_t;
--▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬

--              TASK 10

create table KAA_t(x number(3),s varchar2(50) primary key);

--              TASK 11

INSERT all 
into KAA_t(x,s) values(1,'a')
into KAA_t(x,s) values(2,'b')
into KAA_t(x,s) values(3,'c')
SELECT * FROM dual;

SELECT * FROM KAA_t;

COMMIT;

--              TASK 12

UPDATE KAA_t set x=10 where s='a' or x=2;

--              TASK 13

SELECT * FROM KAA_t where s='c' or s='b';

SELECT SUM(x),AVG(x),COUNT(*),MAX(x),MIN(x) from KAA_t where x<=11;

--              TASK 14

DELETE KAA_t where x=3;

--              TASK 15

create table KAA_t1(
id number GENERATED ALWAYS AS IDENTITY primary key,
word varchar2(50), 
FOREIGN KEY (word)REFERENCES KAA_t(s));

--              TASK 16

INSERT into KAA_t1(word) values('CHANGED');
INSERT into KAA_t1(word) values('a');
INSERT into KAA_t1(word) values('b');

SELECT * FROM KAA_t1;

--              TASK 17

--внутреннее соединение - соединяются строки, поля которых подходят под условие
SELECT * FROM KAA_t INNER JOIN KAA_t1 on  s = word;
    
--левое внешнее соедниненин - все строки слева от ON и те из другой, где поля равны
SELECT * FROM KAA_t LEFT OUTER JOIN KAA_t1 on  x = id;

--левое внешнее соедниненин - все строки справа от ON и те из другой, где поля равны
SELECT * FROM KAA_t RIGHT OUTER JOIN KAA_t1 on   x = id;
    
--полное внешнее соединение - все строки, cоответствующие условие, и все строки
--двух таблиц
SELECT * FROM KAA_t FULL OUTER JOIN KAA_t1 on  x = id;


DROP TABLE KAA_t;
DROP TABLE KAA_t1;

