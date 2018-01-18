DELIMITER $$

DROP PROCEDURE IF EXISTS `vertisy90`.`updateQuestPerform`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE  `vertisy90`.`updateQuestPerform`(IN characterId int, IN key_ VARCHAR(45), in state_ varchar(50))
BEGIN
 INSERT INTO questperform(characterid, key_, state) VALUES(characterid, key_, state_)
 ON DUPLICATE KEY UPDATE key_= key_, state = state_;
END $$

DELIMITER ;


DROP TABLE IF EXISTS `vertisy90`.`questperform`;
CREATE TABLE  `vertisy90`.`questperform` (
  `characterid` int(10) unsigned NOT NULL DEFAULT '0',
  `key_` varchar(45) NOT NULL DEFAULT '',
  `state` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`characterid`,`key_`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;