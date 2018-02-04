CREATE TABLE IF NOT EXISTS `region_history` (
  `id` int(11) NOT NULL,
  `playerID` int(11) NOT NULL,
  `minX` int(11) NOT NULL,
  `minY` int(11) NOT NULL,
  `minZ` int(11) NOT NULL,
  `maxX` int(11) NOT NULL,
  `maxY` int(11) NOT NULL,
  `maxZ` int(11) NOT NULL,
  `time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `regionID` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

ALTER TABLE `region_history`
  ADD PRIMARY KEY (`id`);