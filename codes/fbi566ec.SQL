ALTER TABLE `account`
	CHANGE COLUMN `hasBoost` `hasBoost` TINYINT(1) NOT NULL DEFAULT '0' AFTER `recruiter`;