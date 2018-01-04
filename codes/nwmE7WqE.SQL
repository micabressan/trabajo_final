db=> create table test (login text, pwd chkpass);
CREATE TABLE
db=> insert into test values ('test','password');
INSERT 0 1
db=> select * from test;
 login |      pwd
-------+----------------
 test  | :tdo0P9yxNTGrU
(1 row)
db=> select * from test where login = 'test' and pwd='password';
 login |      pwd
-------+----------------
 test  | :tdo0P9yxNTGrU
(1 row)

db=> select * from test where login = 'test' and pwd='pass';
 login | pwd
-------+-----
(0 rows)
db=> select * from test where login = 'test' and pwd='password1sfhds';
 login |      pwd
-------+----------------
 test  | :tdo0P9yxNTGrU
(1 row)