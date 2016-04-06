SET @lPC               = '%';                       /* percent sign character */
SET @lBS               = '\\';                      /* one backslash when selected and in LIKE test */
SET @lBS2              = CONCAT(@lBS, @lBS);        /* two backslash */
SET @lLikePCLit        = '\%';                   /* LIKE test with no escape gives a literal percent character */ 

SET @LikePCPCLit       = CONCAT('%', @lLikePCLit);      /* LIKE test - wildcard - anything ending with a literal percent sign */
SET @ALikeAPCWild      = 'a%';                          /* LIKE Test - anything starting with an 'a' */
SET @LikeAPCB          = CONCAT('a', @lPC, 'b');        /* LIKE Test - anything starting 'a' and ending 'b' */ 
SET @LikeABSLitBNoEsc  = CONCAT('a', @lBS, @lBS, 'b');  /* LIKE test - exact match of 'a\b' */
SET @LikeABSLitBEsc    = CONCAT('a', @lBS, 'b');        /* LIKE test - exact match of 'a\b' escaped */
SET @LikeAPCLitBNoEsc  = CONCAT('a', @lLikePCLit, 'b'); /* LIKE test - exact match of 'a%b' - no wildcard! */
SET @LikeAPCLitBEsc    = CONCAT('a', @lPC, 'b');        /* LIKE test - exact match of 'a%b' - escaped! */

SET @targetAQB         = 'aqb';          /* 'aqb' - an ordinary string to match */ 
SET @targetAPCB        = 'a%b';          /* 'a%b' - a literal percent sign in a string to match - fun */ 
SET @targetABSB        = 'a\\b';         /* 'a\b' - as literal backslash in a string to match  - fun */ 

SELECT @lBS AS atOneBackSlash,  
       @lBS2 AS atTwoBackSlash,
       @LikePCLit AS atLikePCLit,
       @targetAQB AS atAQB,
       @targetAPCB AS atApcB,
       @targetABSB AS atAbsB,
       /* Now let us start on the `LIKE` tests */
       /* */
       /* Wildcard matches */
       @targetAQB   LIKE @LikeAPCB AS `aqb LIKE a% - True`,
       @targetAPCB  LIKE @LikeAPCB AS `a%b LIKE a% - True`,
       @targetABSB  LIKE @likeAPCB AS `a\b LIKE a% - True`,
       /* */
       /* Unescaped Exact matches */
       @targetAQB   LIKE 'aqb'        AS `UnEsc: aqb LIKE aqb - True`,
       @targetAPCB  LIKE @LikeAPCLitBNoEsc AS `UnEsc:  a%b LIKE a\%b - True`,
       @targetABSB  LIKE @likeABSLitBNoEsc AS `UnEsc: a\b LIKE a\\\\b - True`,
       /* Not Escaped Exact matches */
       @targetAQB   LIKE 'aqb'            AS `UnEsc: aqb LIKE aqb  - True`,
       @targetAPCB  LIKE @LikeAPCLitBEsc  AS `UnEsc:  a%b LIKE a%b - True - as wildcard!`,
       @targetABSB  LIKE @likeABSLitBEsc  AS `UnEsc: a\b LIKE a\\b - False`,
       /* Escaped Exact matches */
       @targetAQB   LIKE 'aqb'            ESCAPE '!' AS `Esc: aqb LIKE aqb - True`,
       @targetAPCB  LIKE @LikeAPCLitBEsc  ESCAPE '!' AS `Esc:  a%b LIKE a%b - True`,
       @targetABSB  LIKE @likeABSLitBEsc  ESCAPE '!' AS `Esc: a\b LIKE a\\b - True`,
       '';