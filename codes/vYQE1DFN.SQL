Oracle native dbms_crypto
 
DBMS_CRYPTO.HASH(UTL_RAW.CAST_TO_RAW(DBMS_RANDOM.STRING('P',20)),4)            
--------------------------------------------------------------------------------
A06315122C00FAF3D1BCAD9F4735297F1E67BF1DB5AC13BEC26E64775A6E10E5               
 
Elapsed: 00:00:00.08
 
DBMS_CRYPTO.HASH(UTL_RAW.CAST_TO_RAW(DBMS_RANDOM.STRING('P',20)),4)            
--------------------------------------------------------------------------------
FBE2E47AB94654780C5BC038B710EDF44DBB64070FE03BA0572ACD418F89760D               
 
Elapsed: 00:00:00.00
 
DBMS_CRYPTO.HASH(UTL_RAW.CAST_TO_RAW(DBMS_RANDOM.STRING('P',20)),4)            
--------------------------------------------------------------------------------
17C080A4BED0156A7BBC907038CD8E1571F1475472936C14A256B33DE9006FA6               
 
Elapsed: 00:00:00.00
sha256 package from github.com
 
SHA256.ENCRYPT(DBMS_RANDOM.STRING('P',20))                                     
--------------------------------------------------------------------------------
1f69b3e7021920f100bbed97d8c1048cd513574504b8af2f7dd62628b11f5e5b               
 
Elapsed: 00:00:00.04
 
SHA256.ENCRYPT(DBMS_RANDOM.STRING('P',20))                                     
--------------------------------------------------------------------------------
bc5f7fc505241f9f3b4b2fe6e1c4495523edfc55fa760568bb00200dc671c29b               
 
Elapsed: 00:00:00.00
 
SHA256.ENCRYPT(DBMS_RANDOM.STRING('P',20))                                     
--------------------------------------------------------------------------------
d6276667c847d8b9dbaffdc26446fb9dae9602c19b2083d8cba0ac680a9cb397               
 
Elapsed: 00:00:00.01
java implementation
 
SHAVAL(DBMS_RANDOM.STRING('P',20))                                             
--------------------------------------------------------------------------------
7086435626b2d77054ed6e42fa1c88090f3485ba194fec875ba2260c4bffdc8d               
 
Elapsed: 00:00:01.35
 
SHAVAL(DBMS_RANDOM.STRING('P',20))                                             
--------------------------------------------------------------------------------
5f71bfaffd6b237eaddc64ae048f874a19759c54a3f2906a106cc4747e75cc65               
 
Elapsed: 00:00:00.00
 
SHAVAL(DBMS_RANDOM.STRING('P',20))                                             
--------------------------------------------------------------------------------
60127e8b1148e6ff9f4ebca102b762e8b4c34487c920af7cc7b0092f4a73b081               
 
Elapsed: 00:00:00.00