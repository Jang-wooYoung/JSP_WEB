/*
Navicat MySQL Data Transfer

Source Server         : 로컬
Source Server Version : 50562
Source Host           : localhost:3306
Source Database       : jsp_web

Target Server Type    : MYSQL
Target Server Version : 50562
File Encoding         : 65001

Date: 2022-11-01 14:52:53
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for board_comment_tb
-- ----------------------------
DROP TABLE IF EXISTS `board_comment_tb`;
CREATE TABLE `board_comment_tb` (
  `COMMENT_UID` varchar(255) CHARACTER SET utf8 NOT NULL,
  `BOARD_UID` varchar(255) CHARACTER SET utf8 NOT NULL,
  `DATA_UID` varchar(255) CHARACTER SET utf8 NOT NULL,
  `USER_ID` varchar(255) CHARACTER SET utf8 NOT NULL,
  `USER_NAME` varchar(255) CHARACTER SET utf8 NOT NULL,
  `USER_NICKNAME` varchar(255) CHARACTER SET utf8 NOT NULL,
  `COMMENT_CONTENT` longtext CHARACTER SET utf8 NOT NULL,
  `COMMENT_IDX` int(11) NOT NULL,
  `COMMENT_STATE` int(1) NOT NULL,
  `REGISTER_DT` datetime NOT NULL,
  PRIMARY KEY (`COMMENT_UID`)
) ENGINE=InnoDB DEFAULT CHARSET=euckr;

-- ----------------------------
-- Table structure for board_data_tb
-- ----------------------------
DROP TABLE IF EXISTS `board_data_tb`;
CREATE TABLE `board_data_tb` (
  `DATA_UID` varchar(255) CHARACTER SET utf8 NOT NULL,
  `BOARD_UID` varchar(255) CHARACTER SET utf8 NOT NULL,
  `DATA_TITLE` varchar(255) CHARACTER SET utf8 NOT NULL,
  `DATA_CONTENT` longtext CHARACTER SET utf8 NOT NULL,
  `DATA_STATE` int(1) NOT NULL,
  `DATA_IDX` int(11) NOT NULL,
  `USER_ID` varchar(255) CHARACTER SET utf8 NOT NULL,
  `USER_NAME` varchar(255) CHARACTER SET utf8 NOT NULL,
  `USER_NICKNAME` varchar(255) CHARACTER SET utf8 NOT NULL,
  `REGISTER_DT` datetime NOT NULL,
  `MODIFY_DT` datetime DEFAULT NULL,
  `VIEW_COUNT` int(11) DEFAULT NULL,
  `TMPFIELD1` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `TMPFIELD2` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `TMPFIELD3` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `TMPFIELD4` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `TMPFIELD5` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  PRIMARY KEY (`DATA_UID`)
) ENGINE=InnoDB DEFAULT CHARSET=euckr;

-- ----------------------------
-- Table structure for board_file_tb
-- ----------------------------
DROP TABLE IF EXISTS `board_file_tb`;
CREATE TABLE `board_file_tb` (
  `FILE_UID` varchar(255) CHARACTER SET utf8 NOT NULL,
  `BOARD_UID` varchar(255) CHARACTER SET utf8 NOT NULL,
  `DATA_UID` varchar(255) CHARACTER SET utf8 NOT NULL,
  `FILE_MASK` varchar(255) CHARACTER SET utf8 NOT NULL,
  `FILE_NAME` varchar(255) CHARACTER SET utf8 NOT NULL,
  `FILE_SIZE` bigint(20) NOT NULL,
  `FILE_STATE` int(1) NOT NULL,
  `REGISTER_DT` datetime NOT NULL,
  `TMPFIELD1` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `TMPFIELD2` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `TMPFIELD3` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  PRIMARY KEY (`FILE_UID`)
) ENGINE=InnoDB DEFAULT CHARSET=euckr;

-- ----------------------------
-- Table structure for user_tb
-- ----------------------------
DROP TABLE IF EXISTS `user_tb`;
CREATE TABLE `user_tb` (
  `USER_UID` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `USER_ID` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `USER_PASSWORD` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `USER_NAME` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `USER_NICKNAME` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `USER_PHONE` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `USER_LEVEL` int(1) NOT NULL,
  `USER_EMAIL` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `USER_STATE` int(1) NOT NULL,
  `REGISTER_DT` datetime NOT NULL,
  `MODIFY_DT` datetime DEFAULT NULL,
  `USER_TMPFIELD1` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `USER_TMPFIELD2` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `USER_TMPFIELD3` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `USER_TMPFIELD4` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `USER_TMPFIELD5` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`USER_UID`)
) ENGINE=InnoDB DEFAULT CHARSET=euckr;
SET FOREIGN_KEY_CHECKS=1;
