USE jobFeeds;

ALTER TABLE `feeds`
  ADD COLUMN `tm_id` VARCHAR(10) NULL DEFAULT NULL AFTER `filename`;

DELIMITER $$

DROP PROCEDURE IF EXISTS `create_feed`$$
CREATE PROCEDURE `create_feed`(
  OUT _return INT(10) unsigned,
  IN _name VARCHAR(255),
  IN _affid INT(10) UNSIGNED,
  IN _cost FLOAT,
  IN _fn VARCHAR(255),
  IN _tm VARCHAR(10),
  IN _url VARCHAR(255),
  IN _active BOOLEAN
)
BEGIN
  INSERT INTO jobFeeds.feeds (
      `name`,
      `affid`,
      `cost`,
      `filename`,
      `tm_id`,
      `url`,
      `active`
    ) VALUES(
      _name,
      _affid,
      _cost,
      _fn,
      _tm,
      _url,
      _active
    );

  SELECT LAST_INSERT_ID() INTO _return;
END$$


DROP PROCEDURE IF EXISTS `update_feed`$$
CREATE PROCEDURE `update_feed`(
  IN _ID INT(10) unsigned,
  IN _name VARCHAR(255),
  IN _affid INT(10) unsigned,
  IN _cost FLOAT,
  IN _fn VARCHAR(255),
  IN _tm VARCHAR(10),
  IN _url VARCHAR(255),
  IN _active BOOLEAN
)
BEGIN
  UPDATE jobFeeds.feeds f
  SET 
    f.`name` = _name,
    f.`affid` = affid,
    f.`cost` = _cost,
    f.`filename` = _fn,
    f.`tm_id` = _tm,
    f.`url` = _url,
    f.`active` = _active
  WHERE f.ID = _ID;
END$$

DELIMITER ;