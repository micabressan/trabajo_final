
 select * from sameer_test
 
 select abs(-6) from dual
 
 select round(45.40), round(45.60) from dual
 
 select round(45.956, 2), round(45.924, 2) from dual
 
 select round(45.956, -1), round(45.924, -1) from dual
 
 select round(269.325, -2), round(249.325, -2) from dual
 
 select round(269.325, -1), round(249.325, -2) from dual
 
 
 
 select trunc(45.40), trunc(45.60) from dual
 
 select trunc(45.956, 2), trunc(45.924, 2) from dual
 
 
 
 select sysdate from dual
 
 
 select * from sameer_test

 
 insert into sameer_test values(5, 'To_Date()', 4000, to_date('01-01-2015', 'DD-MM-YYYY')) 
 
 
 select JN_DT, to_char(JN_DT, 'Day, DD-MONTH-YYYY') from sameer_test where JN_DT is not null
 
 select sysdate, to_char(sysdate, 'DD-MM-YYYY') from sameer_test
 
 
 
select JN_DT, to_char(JN_DT, 'Day, IW, DD-MONTH-YYYY : HH:MM:SS:SSSSS') gg from sameer_test where JN_DT is not null


select months_between ('01-JAN-2013', '01-JAN-2012') from dual

select to_char(add_months('11-Jan-2012', 6), 'DD-MON-YYYY') from dual

select to_char(next_day('11-MAR-2013', 'Tuesday'), 'DD-MON-YYYY') from dual

select to_char(last_day('01-MAR-2013'), 'DD-MON-YYYY') from dual



select * from emp

create table st
(
    empno number,
    ename varchar2(20),
    job varchar2(20),
    mgr number,
    hiredate date,
    sal number,
    comm number,
    deptno number
)


insert into st
    select empno, ename, job, mgr, hiredate, sal, comm, deptno from emp 


select empno, ename, sal, deptno, comm, nvl(comm, 20), nvl2(comm, 'Yes', 'No') from st


select nullif('password', 'password'), nullif('password', '1') from dual


select coalesce('1', '2', '3'), coalesce(null, '2', '3'), coalesce(null, null, '3') from dual