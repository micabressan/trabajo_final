SQL> select sha256.encrypt(dbms_random.string('P', 20)) from dual;
 
SHA256.ENCRYPT(DBMS_RANDOM.STRING('P',20))
--------------------------------------------------------------------------------
8eb51cc3dc6da838b5bfbc9ff450457a3e3dae7653cd69b889ec2d69f6bfdce1
 
Elapsed: 00:00:00.01
SQL> select sha256.encrypt(dbms_random.string('P', 20)) from dual;
 
SHA256.ENCRYPT(DBMS_RANDOM.STRING('P',20))
--------------------------------------------------------------------------------
484a49f201adbf3b9a4cbd7ce8ca64f3ef344062cfba061d1b2ce148d4ef6a8b
 
Elapsed: 00:00:00.01
SQL> select sha256.encrypt(dbms_random.string('P', 20)) from dual;
 
SHA256.ENCRYPT(DBMS_RANDOM.STRING('P',20))
--------------------------------------------------------------------------------
705a86b798141e2ffafe1adb8131816d99542830aed73a7614a444d8fa3aff82
 
Elapsed: 00:00:00.02
SQL> select sha256.encrypt(dbms_random.string('P', 20)) from dual;
 
SHA256.ENCRYPT(DBMS_RANDOM.STRING('P',20))
--------------------------------------------------------------------------------
dec3766ce5113bb11cb0483f36f8bbfd5188281faabbb60e62ea2c35bb4fedd7
 
Elapsed: 00:00:00.02
SQL> select sha256.encrypt(dbms_random.string('P', 20)) from dual;
 
SHA256.ENCRYPT(DBMS_RANDOM.STRING('P',20))
--------------------------------------------------------------------------------
89d90803e3831f1ad7d8223b85c3ad012cd16e83f936adc82722d91d94ad4c0f
 
Elapsed: 00:00:00.01
SQL>
SQL>
SQL> select dbms_crypto.hash(utl_raw.cast_to_raw(dbms_random.string('P', 20)), 4) from dual;
 
DBMS_CRYPTO.HASH(UTL_RAW.CAST_TO_RAW(DBMS_RANDOM.STRING('P',20)),4)
--------------------------------------------------------------------------------
832B7E906D2FC021C32F10309560F9661E4E58D0AC96B6F2CEB62EFDA8D9AD38
 
Elapsed: 00:00:00.01
SQL> select dbms_crypto.hash(utl_raw.cast_to_raw(dbms_random.string('P', 20)), 4) from dual;
 
DBMS_CRYPTO.HASH(UTL_RAW.CAST_TO_RAW(DBMS_RANDOM.STRING('P',20)),4)
--------------------------------------------------------------------------------
111076EB133AF0EEF45B97D12DE98E205F99BB206DE4FD7AE9B4ED849FBDE656
 
Elapsed: 00:00:00.00
SQL> select dbms_crypto.hash(utl_raw.cast_to_raw(dbms_random.string('P', 20)), 4) from dual;
 
DBMS_CRYPTO.HASH(UTL_RAW.CAST_TO_RAW(DBMS_RANDOM.STRING('P',20)),4)
--------------------------------------------------------------------------------
F32EF5577275453476B6C9CEA73E10FE01E8E67D5866ED361419C371C4716EB4
 
Elapsed: 00:00:00.00
SQL> select dbms_crypto.hash(utl_raw.cast_to_raw(dbms_random.string('P', 20)), 4) from dual;
 
DBMS_CRYPTO.HASH(UTL_RAW.CAST_TO_RAW(DBMS_RANDOM.STRING('P',20)),4)
--------------------------------------------------------------------------------
7AF0C913DC5718AEB352CA3C7B6A1A824D51D7B49119E7E68EB0F6EF8FDBAC32
 
Elapsed: 00:00:00.00
SQL> select dbms_crypto.hash(utl_raw.cast_to_raw(dbms_random.string('P', 20)), 4) from dual;
 
DBMS_CRYPTO.HASH(UTL_RAW.CAST_TO_RAW(DBMS_RANDOM.STRING('P',20)),4)
--------------------------------------------------------------------------------
859B9CCA1BF06B624A06211D22238A8BD7C50AE75C5D83B057D8F489F7A94CCD
 
Elapsed: 00:00:00.00