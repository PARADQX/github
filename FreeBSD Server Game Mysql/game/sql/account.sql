SET FOREIGN_KEY_CHECKS=0;

DROP TABLE IF EXISTS `GameTime`;
CREATE TABLE `GameTime` (
  `UserID` varchar(16) NOT NULL DEFAULT '',
  `paymenttype` tinyint(2) NOT NULL DEFAULT '1',
  `LimitTime` int(11) unsigned DEFAULT '0',
  `LimitDt` datetime DEFAULT '0000-00-00 00:00:00',
  `Scores` int(11) DEFAULT '0',
  PRIMARY KEY (`UserID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `GameTimeIP`;
CREATE TABLE `GameTimeIP` (
  `ipid` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) DEFAULT NULL,
  `ip` varchar(15) NOT NULL DEFAULT '000.000.000.000',
  `startIP` int(11) NOT NULL DEFAULT '0',
  `endIP` int(11) NOT NULL DEFAULT '255',
  `paymenttype` tinyint(2) NOT NULL DEFAULT '1',
  `LimitTime` int(11) NOT NULL DEFAULT '0',
  `LimitDt` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `readme` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`ipid`),
  UNIQUE KEY `ip_uniq` (`ip`,`startIP`,`endIP`),
  KEY `ip_idx` (`ip`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `GameTimeLog`;
CREATE TABLE `GameTimeLog` (
  `login` varchar(16) DEFAULT NULL,
  `type` enum('IP_FREE','FREE','IP_TIME','IP_DAY','TIME','DAY') DEFAULT NULL,
  `logon_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `logout_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `use_time` int(11) unsigned DEFAULT NULL,
  `ip` varchar(15) NOT NULL DEFAULT '000.000.000.000',
  `server` varchar(56) NOT NULL DEFAULT '',
  KEY `login_key` (`login`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `account`;
CREATE TABLE `account` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `login` varchar(16) NOT NULL DEFAULT '' COMMENT 'LOGIN_MAX_LEN=30',
  `password` varchar(42) NOT NULL DEFAULT '' COMMENT 'PASSWD_MAX_LEN=16; default 45 size',
  `social_id` varchar(7) NOT NULL DEFAULT '',
  `email` varchar(100) NOT NULL DEFAULT '',
  `securitycode` varchar(192) NOT NULL DEFAULT '',
  `status` varchar(8) NOT NULL DEFAULT 'OK',
  `availDt` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `create_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `last_play` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `gold_expire` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `silver_expire` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `safebox_expire` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `autoloot_expire` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `fish_mind_expire` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `marriage_fast_expire` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `money_drop_rate_expire` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  
  `real_name` varchar(16) DEFAULT '',
  `question1` varchar(56) DEFAULT NULL,
  `answer1` varchar(56) DEFAULT NULL,
  `question2` varchar(56) DEFAULT NULL,
  `answer2` varchar(56) DEFAULT NULL,
  `cash` int(11) DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `login` (`login`) USING BTREE,
  KEY `social_id` (`social_id`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `block_exception`;
CREATE TABLE `block_exception` (
  `login` varchar(16) NOT NULL DEFAULT ''
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `iptocountry`;
CREATE TABLE `iptocountry` (
  `IP_FROM` varchar(16) DEFAULT NULL,
  `IP_TO` varchar(16) DEFAULT NULL,
  `COUNTRY_NAME` varchar(56) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `string`;
CREATE TABLE `string` (
  `name` varchar(64) NOT NULL DEFAULT '',
  `text` text,
  PRIMARY KEY (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;




INSERT INTO `block_exception` VALUES ('NONE');
INSERT INTO `iptocountry` VALUES ('0.0.0.0', '0.0.0.0', 'NONE');
