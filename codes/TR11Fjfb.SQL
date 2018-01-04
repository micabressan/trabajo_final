
/*Character database*/
CREATE TABLE `interrealmstat` (
	`online` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0',
	`starttime` BIGINT(20) UNSIGNED NOT NULL DEFAULT '0',
	`uptime` BIGINT(20) UNSIGNED NOT NULL DEFAULT '0'
)
COLLATE='utf8_general_ci'
ENGINE=InnoDB
ROW_FORMAT=DEFAULT;

/* Hotfix database */
ALTER TABLE `retail_item_bonus_tree_node`  CHANGE COLUMN `Context` `Context` SMALLINT(4) UNSIGNED NULL DEFAULT NULL AFTER `Category`;
ALTER TABLE `retail_item_bonus_tree_node`  CHANGE COLUMN `LinkedCategory` `LinkedCategory` TINYINT(6) UNSIGNED NULL DEFAULT NULL AFTER `ItemBonusEntry`;