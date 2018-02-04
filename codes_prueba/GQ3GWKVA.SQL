DELIMITER $$
CREATE FUNCTION TCPGR_GETJSONPRICE(json TEXT, search_key VARCHAR(255)) RETURNS text
DETERMINISTIC
BEGIN
DECLARE price VARCHAR(10);
DECLARE price_pos INT; 
DECLARE price_pad VARCHAR(8); 
SET price_pos = INSTR(json,'{"id":"16","value":"'); 
SET price_pos = price_pos + 20; 
SET price_pad = SUBSTRING(json,price_pos,8); 
SET price = SUBSTRING_INDEX(price_pad, '"', 1);
RETURN(price); 
END $$
DELIMITER ;