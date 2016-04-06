create table sameer_test
(
    eno number,
    ename varchar2(10),
    sal number,
    JN_dt date
)    

desc sameer_test

alter table sameer_test
    add lname varchar2(10)
        
alter table sameer_test
    modify(lname varchar2(20))


/* Remove Column */
    
alter table sameer_test
    drop column lname    
    

/* Rename Column */

alter table sameer_test 
    rename column JN_dt to join_date    
    

/* Rename Table Name */

alter table sameer_test 
    rename to test_sameer    
    
    
desc test_sameer     


/* Remove the Table */ 

drop table test_sameer



insert into sameer_test values(1, 'Sameer', 1000, '10-Jan-2015')

insert into sameer_test values(2, 'Oracle', 2000, '11-Jan-2015')

insert into sameer_test values(3, 'DB2', 3000, '12-Jan-2015')

insert into sameer_test values(4, 'MySql', 4000, '13-Jan-2015')

insert into sameer_test values(5, 'TerraData', 5000, '14-Jan-2015')

insert into sameer_test values(6, 'NoSql', 6000, '15-Jan-2015')

insert into sameer_test values(7, 'MsSql', 7000, '16-Jan-2015')

insert into sameer_test values(8, 'test', 8000, '17-Jan-2015')

insert into sameer_test values(9, null, 9000, '18-Jan-2015')

insert into sameer_test values(10, null, 10000, '19-Jan-2015')

insert into sameer_test values(11, 'Sameer2', 1000, '10-Jan-2015')


commit


select * from sameer_test


select eno, ename, sal from sameer_test


select * from sameer_test 
    where ename='Sameer'
    
    
select * from sameer_test 
    where ename='Sameer' And eno=1   
    
select * from sameer_test 
    where ename='Sameer' or eno=5
        
    
select * from sameer_test
    where sal > 1000
    
select * from sameer_test
    where sal >= 1000    
    
select * from sameer_test
    where sal < 6000    
    
select * from sameer_test
    where sal <= 6000        

select * from sameer_test
    where sal <> 4000        
    
    
select * from sameer_test
    where sal between 2000 and 6000        
    
    
select * from sameer_test
    where sal IN(1000, 3000, 4000)        
    

select * from sameer_test
    where ename IN('Sameer', 'Oracle', 'DB2') 
    
    

select * from sameer_test
    where ename like 'S%'
    
select * from sameer_test
    where ename like '%a%'    
    
select * from sameer_test
    where ename like '__Sq%'    
    
    
select * from sameer_test
    where ename is NULL    
    
select * from sameer_test
    where ename is NOT NULL