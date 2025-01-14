SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for item_proto
-- ----------------------------
DROP TABLE IF EXISTS `item_proto`;
CREATE TABLE `item_proto`  (
  `vnum` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `name` varbinary(24) NOT NULL DEFAULT 'Noname',
  `locale_name` varbinary(64) NOT NULL DEFAULT 'Noname',
  `type` tinyint(2) NOT NULL DEFAULT 0,
  `subtype` tinyint(2) NOT NULL DEFAULT 0,
  `weight` tinyint(3) NULL DEFAULT 0,
  `size` tinyint(3) NULL DEFAULT 0,
  `antiflag` int(11) UNSIGNED NULL DEFAULT 0,
  `flag` int(11) UNSIGNED NULL DEFAULT 0,
  `wearflag` int(11) UNSIGNED NULL DEFAULT 0,
  `immuneflag` set('PARA','CURSE','STUN','SLEEP','SLOW','POISON','TERROR') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `gold` int(11) NULL DEFAULT 0,
  `shop_buy_price` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `refined_vnum` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `refine_set` smallint(11) UNSIGNED NOT NULL DEFAULT 0,
  `refine_set2` smallint(5) UNSIGNED NOT NULL DEFAULT 0,
  `magic_pct` tinyint(4) NOT NULL DEFAULT 0,
  `limittype0` tinyint(4) NULL DEFAULT 0,
  `limitvalue0` int(11) NULL DEFAULT 0,
  `limittype1` tinyint(4) NULL DEFAULT 0,
  `limitvalue1` int(11) NULL DEFAULT 0,
  `applytype0` tinyint(4) NULL DEFAULT 0,
  `applyvalue0` int(11) NULL DEFAULT 0,
  `applytype1` tinyint(4) NULL DEFAULT 0,
  `applyvalue1` int(11) NULL DEFAULT 0,
  `applytype2` tinyint(4) NULL DEFAULT 0,
  `applyvalue2` int(11) NULL DEFAULT 0,
  `applytype3` tinyint(4) NULL DEFAULT 0,
  `applyvalue3` int(11) NULL DEFAULT 0,
  `value0` int(11) NULL DEFAULT 0,
  `value1` int(11) NULL DEFAULT 0,
  `value2` int(11) NULL DEFAULT 0,
  `value3` int(11) NULL DEFAULT 0,
  `value4` int(11) NULL DEFAULT 0,
  `value5` int(11) NULL DEFAULT 0,
  `socket0` tinyint(4) NULL DEFAULT -1,
  `socket1` tinyint(4) NULL DEFAULT -1,
  `socket2` tinyint(4) NULL DEFAULT -1,
  `socket3` tinyint(4) NULL DEFAULT -1,
  `socket4` tinyint(4) NULL DEFAULT -1,
  `socket5` tinyint(4) NULL DEFAULT -1,
  `specular` tinyint(4) NOT NULL DEFAULT 0,
  `socket_pct` tinyint(4) NOT NULL DEFAULT 0,
  `addon_type` smallint(6) NOT NULL DEFAULT 0,
  PRIMARY KEY (`vnum`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;
