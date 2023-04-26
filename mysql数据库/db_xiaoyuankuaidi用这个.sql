/*
 Navicat Premium Data Transfer

 Source Server         : mysql5.6
 Source Server Type    : MySQL
 Source Server Version : 50620
 Source Host           : localhost:3306
 Source Schema         : db_xiaoyuankuaidi

 Target Server Type    : MySQL
 Target Server Version : 50620
 File Encoding         : 65001

 Date: 19/12/2022 16:29:13
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for advice
-- ----------------------------
DROP TABLE IF EXISTS `advice`;
CREATE TABLE `advice`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NULL DEFAULT NULL,
  `ctime` datetime(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0),
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `content` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `phone` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for comment
-- ----------------------------
DROP TABLE IF EXISTS `comment`;
CREATE TABLE `comment`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NULL DEFAULT NULL,
  `sid` int(11) NULL DEFAULT NULL,
  `star` int(11) NULL DEFAULT NULL,
  `content` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `ctime` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for dic
-- ----------------------------
DROP TABLE IF EXISTS `dic`;
CREATE TABLE `dic`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dm` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '代码',
  `dmmc` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '代码名称',
  `dec` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of dic
-- ----------------------------
INSERT INTO `dic` VALUES (1, '1', '订单状态', '订单状态');

-- ----------------------------
-- Table structure for dicitem
-- ----------------------------
DROP TABLE IF EXISTS `dicitem`;
CREATE TABLE `dicitem`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dm` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `dmmc` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `did` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of dicitem
-- ----------------------------
INSERT INTO `dicitem` VALUES (9, '0', '未接单', 1);
INSERT INTO `dicitem` VALUES (10, '1', '已接单', 1);
INSERT INTO `dicitem` VALUES (11, '2', '已取消', 1);
INSERT INTO `dicitem` VALUES (12, '3', '派送中', 1);
INSERT INTO `dicitem` VALUES (13, '4', '已完成', 1);

-- ----------------------------
-- Table structure for notice
-- ----------------------------
DROP TABLE IF EXISTS `notice`;
CREATE TABLE `notice`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `content` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `img` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '0普通  1广告',
  `ctime` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of notice
-- ----------------------------
INSERT INTO `notice` VALUES (1, '快递代拿app上线了', '同学们可以来这里发布任务，也还可以挣点生活费哦', '1671437362697.jpg', '1', '2022-12-19 16:10:11');
INSERT INTO `notice` VALUES (2, '多劳多得，勤奋的人回报多', '按照每单结算，接的单多就赚的多哦！', '1671437454818.jpg', '1', '2022-12-19 16:11:47');
INSERT INTO `notice` VALUES (3, '哈哈哈，好礼活动开始了！', '凡是勤奋的快递小哥，月底奖励200！', '1671437900167.jpg', '0', '2022-12-19 16:18:53');
INSERT INTO `notice` VALUES (4, '心动不如行动，加入我们吧', '来加入我们快递大军，一个神秘的组织哈哈', '1671437962332.jpg', '0', '2022-12-19 16:19:48');

-- ----------------------------
-- Table structure for operation
-- ----------------------------
DROP TABLE IF EXISTS `operation`;
CREATE TABLE `operation`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ctime` datetime(0) NULL DEFAULT NULL,
  `type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `uid` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 43 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of operation
-- ----------------------------
INSERT INTO `operation` VALUES (34, '2022-11-14 16:37:08', '登录', 2);
INSERT INTO `operation` VALUES (35, '2022-12-18 20:53:59', '登录', 2);
INSERT INTO `operation` VALUES (36, '2022-12-19 16:03:51', '登录', 2);
INSERT INTO `operation` VALUES (37, '2022-12-19 16:08:53', '登录', 2);
INSERT INTO `operation` VALUES (38, '2022-12-19 16:10:24', '登录', 2);
INSERT INTO `operation` VALUES (39, '2022-12-19 16:12:08', '登录', 2);
INSERT INTO `operation` VALUES (40, '2022-12-19 16:16:00', '登录', 2);
INSERT INTO `operation` VALUES (41, '2022-12-19 16:18:06', '登录', 2);
INSERT INTO `operation` VALUES (42, '2022-12-19 16:23:40', '登录', 2);

-- ----------------------------
-- Table structure for orders
-- ----------------------------
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NULL DEFAULT NULL COMMENT '客户Id',
  `ctime` datetime(0) NULL DEFAULT NULL,
  `sid` int(11) NULL DEFAULT NULL COMMENT '快递员id',
  `money` int(11) NULL DEFAULT NULL,
  `status` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '0未接  1已结  2取消   3派送   4完成',
  `idnumber` varchar(111) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `sendtime` varchar(111) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `address` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `phone` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of orders
-- ----------------------------
INSERT INTO `orders` VALUES (5, 2, '2022-11-12 10:59:57', 3, 123, '1', '1222', '完完全全无', '奥术大师', '1345656677');
INSERT INTO `orders` VALUES (6, 2, '2022-11-12 11:00:26', 3, 222, '3', '12223', '萨达撒大', '撒飒飒', '18989292');
INSERT INTO `orders` VALUES (7, 2, '2022-11-14 16:37:51', NULL, 20, '0', '111', '2022-11-20  11:00', '11', '11');
INSERT INTO `orders` VALUES (8, 2, '2022-12-19 16:08:00', NULL, 10, '0', '5-2989', '2022-12-19  21:00', '学校门口菜鸟驿站', '13513989192');

-- ----------------------------
-- Table structure for txrecord
-- ----------------------------
DROP TABLE IF EXISTS `txrecord`;
CREATE TABLE `txrecord`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NULL DEFAULT NULL,
  `money` int(11) NULL DEFAULT NULL,
  `cardnum` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `ctime` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of txrecord
-- ----------------------------
INSERT INTO `txrecord` VALUES (5, 3, 222, '1111', '122', '2022-11-12 10:43:21');
INSERT INTO `txrecord` VALUES (6, 3, 1111, '222', '11', '2022-11-12 10:43:35');
INSERT INTO `txrecord` VALUES (7, 2, 2222, NULL, NULL, NULL);
INSERT INTO `txrecord` VALUES (8, 24, 222, '222', '333', '2022-11-12 15:45:44');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `pwd` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `nickname` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `gender` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `avatarurl` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `phone` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `ctime` datetime(0) NULL DEFAULT NULL,
  `type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '0用户  1管理员   2其他',
  `status` int(10) UNSIGNED NULL DEFAULT 0 COMMENT '0整除  1禁用',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 25 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, 'admin', '123456', '管理员', '男', '1663918453630.png', NULL, '2022-11-12 10:05:50', '1', 0);
INSERT INTO `user` VALUES (2, '111', '111', '啊实打实', '男', '1671438290316.jpg', '134455455', '2022-11-12 10:17:26', '0', 0);
INSERT INTO `user` VALUES (3, '222', '222', '是', '女', '1663918453630.png', '1334344434', '2022-11-12 10:17:53', '2', 1);
INSERT INTO `user` VALUES (24, '333', '333', '111', NULL, NULL, NULL, '2022-11-12 14:48:39', '2', 0);

-- ----------------------------
-- Table structure for userinfo
-- ----------------------------
DROP TABLE IF EXISTS `userinfo`;
CREATE TABLE `userinfo`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NULL DEFAULT NULL,
  `money` int(11) NULL DEFAULT NULL,
  `idnumber` varchar(111) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `card` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `studentcard` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of userinfo
-- ----------------------------
INSERT INTO `userinfo` VALUES (1, 3, 111, '11222', '1111', '1663918453630.png');
INSERT INTO `userinfo` VALUES (2, 2, 212, NULL, NULL, NULL);
INSERT INTO `userinfo` VALUES (3, 24, 333, '111', '12221', '1668235715117.png');

SET FOREIGN_KEY_CHECKS = 1;
