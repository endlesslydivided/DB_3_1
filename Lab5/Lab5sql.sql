ALTER DATABASE OPEN;

--sys_to_KAA_PDB
--              TASK 1
select tablespace_name, contents from DBA_TABLESPACES;
--              TASK 2
create tablespace KAA_QDATA
  datafile 'D:\app\divided\Tablespaces\KAA_PDB\KAA_QDATA5.dbf'
  size 10 M
  offline;
  
alter tablespace KAA_QDATA online;

DROP TABLESPACE KAA_QDATA INCLUDING CONTENTS AND DATAFILES; 

create role myrole;
grant create session,
      create table, 
      create view, 
      create procedure,
      drop any table,
      drop any view,
      drop any procedure to myrole;    
grant create session to myrole;
commit;

create profile myprofile limit
    password_life_time 180      --кол-во дней жизни пароля
    sessions_per_user 3         --кол-во сессий для юзера
    failed_login_attempts 7     --кол-во попыток ввода
    password_lock_time 1        --кол-во дней блока после ошибок
    password_reuse_time 10      --через скок дней можно повторить пароль
    password_grace_time default --кол-во дней предупрежд.о смене пароля
    connect_time 180            --время соед (мин)
    idle_time 30 ;  
    
create user KAA identified by 1234
default tablespace KAA_QDATA quota unlimited on KAA_QDATA
profile myprofile
account unlock;

alter user KAA quota 2m on KAA_QDATA;
grant myrole to KAA;

-- KAA_to_KAA_PDB

create table KAA_T1(
id number(15) PRIMARY KEY,
name varchar2(10))
tablespace KAA_QDATA;

DROP TABLE KAA_T1

insert into KAA_T1 values(1, 'A');
insert into KAA_T1 values(2, 'B');
insert into KAA_T1 values(3, 'C');

SELECT * FROM KAA_T1;

--              TASK 3
select segment_name, segment_type from DBA_SEGMENTS where tablespace_name='KAA_QDATA';

--              TASK 4
--(удалить таблицу)
drop table KAA_T1;
--(список сегментов)
select * from DBA_SEGMENTS where tablespace_name='KAA_QDATA';
--(запрос к представление)
select * from user_recyclebin;

--              TASK 5
flashback table KAA_T1 to before drop;

--              TASK 6
BEGIN
  FOR k IN 4..10004
  LOOP
    insert into KAA_T1 values(k, 'A');
  END LOOP;
END;
commit;

SELECT * FROM KAA_T1 order by id;

--              TASK 7

select extent_id, blocks, bytes from DBA_EXTENTS where SEGMENT_NAME='KAA_T1';

--              TASK 8

--▬▬▬
DROP TABLESPACE KAA_QDATA INCLUDING CONTENTS AND DATAFILES;
--▬▬▬   

--              TASK 9
--sys_to_KAA_PDB
SELECT group#, sequence#, bytes, members, status, first_change# FROM V$LOG;

--              TASK 10
SELECT group#, sequence#, bytes, members, status, first_change# FROM V$LOG;

--              TASK 11

ALTER SYSTEM SWITCH LOGFILE; 15:30:25
SELECT * FROM V$LOG;

--              TASK 12

alter database add logfile group 4 'D:\app\divided\Logfiles\REDO040.LOG' 
size 50m blocksize 512;
alter database add logfile member 'D:\app\divided\Logfiles\REDO041.LOG'  to group 4;
alter database add logfile member 'D:\app\divided\Logfiles\REDO042.LOG'  to group 4;
commit;

SELECT group#, sequence#, bytes, members, status, first_change# FROM V$LOG;

--              TASK 13

alter database clear logfile group 4;
alter database drop logfile group 4;
SELECT group#, sequence#, bytes, members, status, first_change# FROM V$LOG;
commit;

--              TASK 14

SELECT NAME, LOG_MODE FROM V$DATABASE;
SELECT INSTANCE_NAME, ARCHIVER, ACTIVE_STATE FROM V$INSTANCE;

--              TASK 15
ALTER SYSTEM SWITCH LOGFILE;
SELECT NAME, FIRST_CHANGE#, NEXT_CHANGE# FROM V$ARCHIVED_LOG;

--              TASK 16
--sql plus
--connect /as sysdba
--shutdown immediate;
--startup mount;
--alter database archivelog;
--archive log list;
--alter database open;

--              TASK 17
ALTER SYSTEM SET LOG_ARCHIVE_DEST_1 ='LOCATION=D:\app\divided\oradata\orcl\archive'
ALTER SYSTEM SWITCH LOGFILE;
SELECT NAME, FIRST_CHANGE#, NEXT_CHANGE# FROM V$ARCHIVED_LOG;
--              TASK 18

--shutdown immediate;
--startup mount;
--alter database noarchivelog;
--select name, log_mode from v$database;
--alter database open;

--              TASK 19

select name from v$controlfile;

--              TASK 20
show parameter control;

--              TASK 21
ALTER DATABASE BACKUP CONTROLFILE TO TRACE;
show parameter spfile ;

--              TASK 22

CREATE PFILE='user_pf.ora' FROM SPFILE;
--D:\app\USER\product\11.2.0\dbhome_2\database

--              TASK 23
SELECT * FROM V$PWFILE_USERS;
show parameter remote_login_passwordfile;

--              TASK 24
SELECT * FROM V$DIAG_INFO;

--              TASK 25
--D:\app\divided\diag\rdbms\orcl\orcl\alert
--              TASK 26
--        Удалить все файлы


