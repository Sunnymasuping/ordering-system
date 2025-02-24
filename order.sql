/*
 Navicat Premium Data Transfer

 Source Server         : mysql
 Source Server Type    : MySQL
 Source Server Version : 80100
 Source Host           : localhost:3306
 Source Schema         : order

 Target Server Type    : MySQL
 Target Server Version : 80100
 File Encoding         : 65001

 Date: 22/02/2025 18:34:55
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin`  (
  `aid` int NOT NULL AUTO_INCREMENT,
  `apwd` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `aname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `aphone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `aaddress` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`aid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES (1, '123', 'csy', '1234567890', 'Address1');
INSERT INTO `admin` VALUES (2, '456', 'zrj', '0987654321', 'Address2');
INSERT INTO `admin` VALUES (3, '789', 'lt', '1122334455', 'Address3');

-- ----------------------------
-- Table structure for customer
-- ----------------------------
DROP TABLE IF EXISTS `customer`;
CREATE TABLE `customer`  (
  `cid` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `cpwd` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `cname` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `csex` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `cbirth` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `cphone` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `cstatus` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`cid`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of customer
-- ----------------------------
INSERT INTO `customer` VALUES ('C001', 'Abc123', '张三', '女', '1990-01-02', '12345678922', '已通过');
INSERT INTO `customer` VALUES ('C002', 'Xyz456', '李嘻嘻', '女', '1992-05-15', '12345678929', '已通过');
INSERT INTO `customer` VALUES ('C003', 'Mno789', '王五', '男', '1992-03-24', '12345678903', '已通过');
INSERT INTO `customer` VALUES ('C004', 'Pqr321', '赵六', '男', '1988-05-20', '12345678904', '已通过');
INSERT INTO `customer` VALUES ('C005', 'Def456', '钱七', '女', '1995-09-30', '12345678905', '已通过');
INSERT INTO `customer` VALUES ('C006', 'Ghi789', '孙八', '女', '1991-12-12', '12345678906', '已通过');
INSERT INTO `customer` VALUES ('C007', 'Jkl321', '周九', '男', '1993-03-04', '12345678907', '已通过');
INSERT INTO `customer` VALUES ('C009', 'Pqr987', '郑十一', '男', '1994-11-15', '12345678909', '待审核');
INSERT INTO `customer` VALUES ('C010', 'Stu123', '王十二', '女', '1992-06-18', '12345678910', '待审核');
INSERT INTO `customer` VALUES ('C011', 'Vwx456', '刘十三', '男', '1990-10-30', '12345678911', '已通过');

-- ----------------------------
-- Table structure for dish
-- ----------------------------
DROP TABLE IF EXISTS `dish`;
CREATE TABLE `dish`  (
  `dishId` int NOT NULL AUTO_INCREMENT,
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `specification` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `dishName` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `picture` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `price` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `sale` int NULL DEFAULT NULL,
  PRIMARY KEY (`dishId`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of dish
-- ----------------------------
INSERT INTO `dish` VALUES (1, '炒菜', '甜', '番茄炒蛋', '/assets/番茄炒蛋.jpg', '12', 22);
INSERT INTO `dish` VALUES (2, '炒菜', '微辣', '鱼香肉丝', '/assets/鱼香肉丝.jpg', '20', 19);
INSERT INTO `dish` VALUES (3, '水煮', '微辣', '酸菜鱼', '/assets/酸菜鱼.jpg', '20', 8);
INSERT INTO `dish` VALUES (4, '炒菜', '微甜', '地三鲜', '/assets/1.jpg', '12', 29);
INSERT INTO `dish` VALUES (5, '炒菜', '辣', '尖椒兔肉', '/assets/尖椒兔肉.jpg', '25', 11);
INSERT INTO `dish` VALUES (6, '凉菜', '微辣', '泡椒翅尖', '/assets/泡椒翅尖.jpg', '18', 15);
INSERT INTO `dish` VALUES (7, '炒菜', '辣', '爆炒鳝肉', '/assets/爆炒鳝肉.jpg', '28', 10);
INSERT INTO `dish` VALUES (8, '红烧', '微辣', '红烧狮子头', '/assets/红烧狮子头.jpg', '25', 12);
INSERT INTO `dish` VALUES (9, '凉菜', '不辣', '蒜蓉凉粉', '/assets/蒜蓉凉粉.jpg', '12', 8);
INSERT INTO `dish` VALUES (10, '红烧', '微辣', '虎皮凤爪', '/assets/虎皮凤爪.jpg', '18', 21);
INSERT INTO `dish` VALUES (11, '炒菜', '辣', '辣子鸡丁', '/assets/辣子鸡丁.jpg', '22', 13);
INSERT INTO `dish` VALUES (12, '凉菜', '微辣', '酸萝卜', '/assets/酸萝卜.jpg', '3', 15);
INSERT INTO `dish` VALUES (13, '凉菜', '微辣', '青椒皮蛋', '/assets/青椒皮蛋.jpg', '20', 17);

-- ----------------------------
-- Table structure for orderform
-- ----------------------------
DROP TABLE IF EXISTS `orderform`;
CREATE TABLE `orderform`  (
  `oid` int NOT NULL AUTO_INCREMENT,
  `ocontent` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `createtime` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `overtime` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `ostatus` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `sum` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `cid` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `way` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`oid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 24 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of orderform
-- ----------------------------
INSERT INTO `orderform` VALUES (1, '番茄炒蛋', '2024-06-30 10:00:00', '2024-06-30 10:20:00', '已完成', '多放一双筷子', '12', 'C001', '堂食');
INSERT INTO `orderform` VALUES (2, '鱼香肉丝', '2024-07-01 11:00:00', '2024-07-01 11:20:00', '已取消', '', '20', 'C001', '打包');
INSERT INTO `orderform` VALUES (3, '酸菜鱼', '2024-07-01 12:20:00', '2024-07-01 12:30:00', '已完成', '', '20', 'C003', '堂食');
INSERT INTO `orderform` VALUES (4, '地三鲜', '2024-07-01 12:00:00', '2024-07-05 13:29:31', '已完成', '', '12', 'C004', '打包');
INSERT INTO `orderform` VALUES (5, '尖椒兔肉', '2024-07-01 14:00:00', '2024-07-01 14:20:00', '已完成', '', '25', 'C005', '堂食');
INSERT INTO `orderform` VALUES (6, '泡椒翅尖', '2024-07-02 15:00:00', '2024-07-02 15:20:00', '已完成', '少辣椒', '18', 'C006', '打包');
INSERT INTO `orderform` VALUES (7, '爆炒鳝肉', '2024-07-02 16:00:00', '2024-07-02 16:20:00', '已完成', '少辣椒', '28', 'C007', '堂食');
INSERT INTO `orderform` VALUES (8, '红烧狮子头', '2024-07-02 10:00:00', '2024-07-02 10:20:00', '已完成', '', '25', 'C008', '打包');
INSERT INTO `orderform` VALUES (9, '蒜蓉凉粉', '2024-07-02 11:00:00', '2024-07-02 11:20:00', '已完成', '', '12', 'C009', '堂食');
INSERT INTO `orderform` VALUES (10, '虎皮凤爪', '2024-07-02 14:00:00', '2024-07-02 14:20:00', '已完成', '多放葱', '18', 'C012', '打包');
INSERT INTO `orderform` VALUES (11, '辣子鸡丁', '2024-07-02 15:00:00', '2024-07-02 15:20:00', '已完成', '少辣', '22', 'C013', '堂食');
INSERT INTO `orderform` VALUES (12, '酸萝卜', '2024-07-03 10:00:00', '2024-07-03 10:20:00', '已完成', '', '3', 'C003', '打包');
INSERT INTO `orderform` VALUES (13, '青椒皮蛋', '2024-07-03 11:00:00', '2024-07-03 11:20:00', '已完成', '', '20', 'C001', '堂食');
INSERT INTO `orderform` VALUES (14, '青椒皮蛋', '2024-07-03 12:00:00', '2024-07-03 12:21:00', '已完成', '不放香菜', '20', 'C003', '打包');
INSERT INTO `orderform` VALUES (15, '红烧狮子头', '2024-07-03 13:00:00', '2024-07-03 13:27:00', '已完成', '不要味精', '25', 'C003', '堂食');
INSERT INTO `orderform` VALUES (16, '地三鲜/青椒皮蛋', '2024-07-04 14:00:00', '2024-07-04 14:27:00', '已完成', '不要鸡精味精', '32', 'C001', '打包');
INSERT INTO `orderform` VALUES (17, '地三鲜/鱼香肉丝', '2024-07-04 15:00:00', '2024-07-04 15:28:00', '已取消', '少放糖', '32', 'C001', '堂食');
INSERT INTO `orderform` VALUES (18, '番茄炒蛋/辣子鸡丁', '2024-07-04 16:00:00', '2024-07-04 16:29:00', '已取消', '', '37', 'C001', '打包');
INSERT INTO `orderform` VALUES (19, '虎皮凤爪1/尖椒兔肉2', '2024-07-04 16:00:00', '2024-07-04 14:23:34', '已完成', '', '33', 'C002', '打包');
INSERT INTO `orderform` VALUES (20, '番茄炒蛋', '2024-07-04 16:00:00', '2024-07-04 16:21:00', '已完成', '', '12', 'C001', '打包');
INSERT INTO `orderform` VALUES (21, '鱼香肉丝/番茄炒蛋', '2024-07-04 14:21:17', '2024-07-04 14:22:24', '已支付', '', '32', 'C001', '堂食');
INSERT INTO `orderform` VALUES (22, '蒜蓉凉粉/泡椒翅尖', '2024-07-04 14:32:49', '2024-07-04 15:39:46', '已支付', '少辣', '30', 'C002', '打包');
INSERT INTO `orderform` VALUES (23, '鱼香肉丝/番茄炒蛋', '2024-07-04 15:38:08', '2024-07-04 15:39:34', '已支付', '', '52', 'C002', '堂食');

-- ----------------------------
-- Table structure for picture
-- ----------------------------
DROP TABLE IF EXISTS `picture`;
CREATE TABLE `picture`  (
  `picid` int NOT NULL AUTO_INCREMENT,
  `picname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `number` int NULL DEFAULT NULL,
  PRIMARY KEY (`picid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of picture
-- ----------------------------
INSERT INTO `picture` VALUES (1, 'Pic1', '/assets/Pic1.jpg', 1);
INSERT INTO `picture` VALUES (2, 'Picture3', '/assets/Picture3.jpg', 3);
INSERT INTO `picture` VALUES (3, 'Picture4', '/assets/Picture4.jpg', 4);
INSERT INTO `picture` VALUES (4, '好好吃的', '/assets/好好吃的.jpg', 2);

-- ----------------------------
-- Table structure for reply
-- ----------------------------
DROP TABLE IF EXISTS `reply`;
CREATE TABLE `reply`  (
  `pid` int NOT NULL AUTO_INCREMENT,
  `pcontent` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `ptime` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `cid` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `aid` int NULL DEFAULT NULL,
  `rid` int NULL DEFAULT NULL,
  PRIMARY KEY (`pid`) USING BTREE,
  INDEX `reply_ibfk_1`(`cid` ASC) USING BTREE,
  INDEX `fk_rid`(`rid` ASC) USING BTREE,
  INDEX `fk_reply_admin`(`aid` ASC) USING BTREE,
  CONSTRAINT `fk_reply_admin` FOREIGN KEY (`aid`) REFERENCES `admin` (`aid`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_rid` FOREIGN KEY (`rid`) REFERENCES `review` (`rid`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `reply_ibfk_1` FOREIGN KEY (`cid`) REFERENCES `customer` (`cid`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of reply
-- ----------------------------
INSERT INTO `reply` VALUES (1, '我也觉得', '2024-06-23', 'C002', NULL, 1);
INSERT INTO `reply` VALUES (2, '我们已经与厨师进行沟通，保证下次能做出让您满意的食物', '2024-06-24', NULL, 1, 5);
INSERT INTO `reply` VALUES (4, '不好吃', '2024-06-26', 'C004', NULL, 5);
INSERT INTO `reply` VALUES (5, '而且还很咸', '2024-06-26', 'C001', NULL, 5);
INSERT INTO `reply` VALUES (6, '是的是的', '2024-06-26', 'C001', NULL, 1);
INSERT INTO `reply` VALUES (7, '我觉得挺好吃的呀', '2024-06-26', 'C001', NULL, 4);
INSERT INTO `reply` VALUES (8, 'qqq', '2024-06-26', 'C001', NULL, 5);
INSERT INTO `reply` VALUES (9, '感谢您的好评！祝您生活愉快~~', '2024-06-27', NULL, 1, 1);
INSERT INTO `reply` VALUES (12, '感谢支持！', '2024-06-27', NULL, 1, 3);
INSERT INTO `reply` VALUES (13, '感谢支持', '2024-06-27', NULL, 1, 8);
INSERT INTO `reply` VALUES (15, '感谢支持', '2024-07-03', NULL, NULL, 7);

-- ----------------------------
-- Table structure for review
-- ----------------------------
DROP TABLE IF EXISTS `review`;
CREATE TABLE `review`  (
  `rid` int NOT NULL AUTO_INCREMENT,
  `rscore` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `rcontent` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `rtime` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `cid` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`rid`) USING BTREE,
  INDEX `cid`(`cid` ASC) USING BTREE,
  CONSTRAINT `review_ibfk_1` FOREIGN KEY (`cid`) REFERENCES `customer` (`cid`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of review
-- ----------------------------
INSERT INTO `review` VALUES (1, '100', '鱼香肉丝很好吃', '2024-06-23', 'C001');
INSERT INTO `review` VALUES (2, '75', '红烧肉不错', '2024-06-24', 'C001');
INSERT INTO `review` VALUES (3, '75', '麻婆豆腐很美味', '2024-06-25', 'C001');
INSERT INTO `review` VALUES (4, '50', '宫保鸡丁一般', '2024-06-25', 'C002');
INSERT INTO `review` VALUES (5, '25', '水煮鱼很辣', '2024-06-24', 'C002');
INSERT INTO `review` VALUES (6, '0', '1', '2024-06-25', 'C001');
INSERT INTO `review` VALUES (7, '75', '很好吃', '2024-06-25', 'C001');
INSERT INTO `review` VALUES (8, '50', '好吃', '2024-06-26', 'C001');
INSERT INTO `review` VALUES (9, '75', '还不错', '2024-07-05', 'C001');

SET FOREIGN_KEY_CHECKS = 1;
