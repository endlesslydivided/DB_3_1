ALTER DATABASE OPEN;
--              TASK 1
select name,open_mode from v$pdbs; 

--              TASK 2 
select INSTANCE_NAME from v$instance;

--              TASK 3
select * from PRODUCT_COMPONENT_VERSION;

--              TASK 4 
-- ORACLE DATABASE CONFIGURATION ASSISTANT;

--              TASK 5 
select name,open_mode from v$pdbs;

--              TASK 6 
CREATE TABLESPACE TS_KAA
DATAFILE 'D:\app\divided\Tablespaces\KAA_PDB\TS_KAA.dbf' 
size 7M
REUSE AUTOEXTEND ON NEXT 5M 
MAXSIZE 20M
LOGGING
ONLINE;
commit;
DROP TABLESPACE TS_KAA INCLUDING CONTENTS AND DATAFILES;

select TABLESPACE_NAME, BLOCK_SIZE, MAX_SIZE from sys.dba_tablespaces order by tablespace_name;

CREATE TEMPORARY TABLESPACE TS_KAA_TEMP_1
TEMPFILE 'D:\app\divided\Tablespaces\KAA_PDB\TS_KAA_TEMP.dbf' size 5M
REUSE AUTOEXTEND ON NEXT 3M 
MAXSIZE 30M;
commit;

DROP TABLESPACE TS_KAA_TEMP_1 INCLUDING CONTENTS AND DATAFILES;

create role RL_KAA;
commit;

drop role RL_KAA;

grant create session, create any table, create any view, create any procedure,ALTER ANY SEQUENCE,CREATE SEQUENCE, create any view  to RL_KAA;
grant  create  view to RL_KAA;
grant drop any table, drop any view, drop any procedure to RL_KAA;
commit;


create profile PF_KAA limit
password_life_time 180 -- кол-во дней жизни пароля
sessions_per_user 3 -- кол-во сессий для пользователя
FAILED_LOGIN_ATTEMPTS 7 -- кол-во попыток входа
PASSWORD_LOCK_TIME 1 -- кол-во дней блокировки после ошибки
PASSWORD_Reuse_time 10 -- через сколько дней можно повторить пароль
password_grace_time default -- кол-во дней предупреждения о смене пароля
connect_time 180 -- время соединения
idle_time 30; -- простой
commit;

drop profile PF_KAA;

create user U1_KAA_PDB identified by 1234
default tablespace TS_KAA quota unlimited on TS_KAA
profile PF_KAA
account unlock;

drop user U1_KAA_PDB CASCADE;

grant RL_kaa to U1_KAA_PDB;
commit;


select GRANTEE, PRIVILEGE from DBA_SYS_PRIVS where GRANTEE='U1_KAA_PDB'; 

commit;

--              TASK 7 
DROP table U1KAATABLE

CREATE TABLE U1KAATABLE(
id number GENERATED ALWAYS AS IDENTITY primary key,
word varchar2(50)
);

INSERT into U1KAATABLE(word) values('CHANGED');
INSERT into U1KAATABLE(word) values('a');
INSERT into U1KAATABLE(word) values('b');
commit;
SELECT * FROM U1KAATABLE;
--              TASK 8
select * from DBA_USERS; 
select * from DBA_TABLESPACES; 
select * from DBA_DATA_FILES;   
select * from DBA_TEMP_FILES;  
select * from DBA_ROLES;
select * from DBA_ROLE_PRIVS t1 inner join DBA_SYS_PRIVS t2 on t1.GRANTED_ROLE = t2.GRANTEE where t1.GRANTEE='U1_KAA_PDB'; 

select * from DBA_PROFILES; 
--              TASK 9

create user C##KAA identified by 1234
account unlock;

--              TASK 10
grant create session to  C##KAA;

select * from v$session where USERNAME is not null;

select PRIVILEGE from USER_SYS_PRIVS; 


