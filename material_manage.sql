/*
 Navicat Premium Data Transfer

 Source Server         : MySQL
 Source Server Type    : MySQL
 Source Server Version : 50720
 Source Host           : localhost:3306
 Source Schema         : material_manage

 Target Server Type    : MySQL
 Target Server Version : 50720
 File Encoding         : 65001

 Date: 30/05/2023 11:50:34
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for depart_info
-- ----------------------------
DROP TABLE IF EXISTS `depart_info`;
CREATE TABLE `depart_info`  (
  `depart_no` varchar(6) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '部门编号',
  `depart_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `depart_describe` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '职能说明',
  PRIMARY KEY (`depart_no`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of depart_info
-- ----------------------------
INSERT INTO `depart_info` VALUES ('000001', '物资采购部', '物资采购计划申报、进行采购');
INSERT INTO `depart_info` VALUES ('000002', '库存管理部', '进行库存管理，盘存报告');
INSERT INTO `depart_info` VALUES ('000003', '市场监察部', '进行物资价格监察，采购账单核实');
INSERT INTO `depart_info` VALUES ('000004', '人事管理部', '进行人事管理，员工登记，职位变迁');
INSERT INTO `depart_info` VALUES ('000005', '办公室', '最高权限，审核各类信息，督察各个部门任务，发布公司计划，根据公司业务情况发布通告');

-- ----------------------------
-- Table structure for job_info
-- ----------------------------
DROP TABLE IF EXISTS `job_info`;
CREATE TABLE `job_info`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '工作编号',
  `depart_no` varchar(6) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '部门编号',
  `job_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '工作名称',
  `power_level` int(11) NOT NULL COMMENT '权限等级',
  `job_describe` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '工作描述',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `depart_no`(`depart_no`) USING BTREE,
  CONSTRAINT `depart_no` FOREIGN KEY (`depart_no`) REFERENCES `depart_info` (`depart_no`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of job_info
-- ----------------------------
INSERT INTO `job_info` VALUES (1, '000001', '物资采购员', 3, '根据公司需要，申请采购相应的物资');
INSERT INTO `job_info` VALUES (2, '000001', '计划审核员', 2, '审核购买申请');
INSERT INTO `job_info` VALUES (3, '000001', '采购部部长', 1, '审核员工提交的采购计划，或者制定公司的月度计划');
INSERT INTO `job_info` VALUES (4, '000002', '入库管理员', 2, '检查物资入库信息');
INSERT INTO `job_info` VALUES (5, '000002', '盘存管理员', 3, '对库存进行定期检查，对物资的损余进行报告修改');
INSERT INTO `job_info` VALUES (6, '000002', '出库检测员', 2, '物资出库时进行审核');
INSERT INTO `job_info` VALUES (7, '000003', '账单审核员', 1, '对公司的各种账单进行审核，发布各种通告');
INSERT INTO `job_info` VALUES (8, '000003', '市场报告员', 1, '根据市场信息，提交相应的报告，供其他部门参考');
INSERT INTO `job_info` VALUES (9, '000004', '员工登记员', 2, '进行员工登记');
INSERT INTO `job_info` VALUES (10, '000002', '仓库管理员', 2, '管理仓库');

-- ----------------------------
-- Table structure for mb_info
-- ----------------------------
DROP TABLE IF EXISTS `mb_info`;
CREATE TABLE `mb_info`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `mb_code` int(11) NOT NULL COMMENT '大类物资编码',
  `mb_category` varchar(15) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '材料类别，名称',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `mb_code`(`mb_code`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mb_info
-- ----------------------------
INSERT INTO `mb_info` VALUES (1, 101, '钢材');
INSERT INTO `mb_info` VALUES (2, 102, '建材');
INSERT INTO `mb_info` VALUES (3, 103, '专用材料');
INSERT INTO `mb_info` VALUES (4, 201, '燃润料');
INSERT INTO `mb_info` VALUES (5, 202, '机电产品');
INSERT INTO `mb_info` VALUES (6, 203, '五金制品');
INSERT INTO `mb_info` VALUES (7, 204, '化工产品');
INSERT INTO `mb_info` VALUES (8, 301, '劳保用品');
INSERT INTO `mb_info` VALUES (9, 302, '工具用具');
INSERT INTO `mb_info` VALUES (10, 401, '陆上机械配件');
INSERT INTO `mb_info` VALUES (11, 402, '水上机械配件');

-- ----------------------------
-- Table structure for mm_info
-- ----------------------------
DROP TABLE IF EXISTS `mm_info`;
CREATE TABLE `mm_info`  (
  `id` int(11) NOT NULL,
  `mm_code` int(255) NOT NULL,
  `mb_code` int(255) NOT NULL,
  `mm_category` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `mb_code`(`mb_code`) USING BTREE,
  INDEX `mm_code`(`mm_code`) USING BTREE,
  CONSTRAINT `mb_code` FOREIGN KEY (`mb_code`) REFERENCES `mb_info` (`mb_code`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mm_info
-- ----------------------------
INSERT INTO `mm_info` VALUES (1, 10101, 101, '型钢');
INSERT INTO `mm_info` VALUES (2, 10102, 101, '钢板和钢带');
INSERT INTO `mm_info` VALUES (3, 10103, 101, '钢管');
INSERT INTO `mm_info` VALUES (4, 10104, 101, '钢轨和附件');
INSERT INTO `mm_info` VALUES (5, 10201, 102, '木材');
INSERT INTO `mm_info` VALUES (6, 10202, 102, '水泥');
INSERT INTO `mm_info` VALUES (7, 10203, 102, '地材');
INSERT INTO `mm_info` VALUES (8, 10204, 102, '掺和料');
INSERT INTO `mm_info` VALUES (9, 10301, 103, '土工合成材料');
INSERT INTO `mm_info` VALUES (10, 10302, 103, '伸缩缝及接缝材料');
INSERT INTO `mm_info` VALUES (11, 20101, 201, '燃料');
INSERT INTO `mm_info` VALUES (12, 20102, 201, '润滑油');
INSERT INTO `mm_info` VALUES (13, 20103, 201, '润滑脂');
INSERT INTO `mm_info` VALUES (14, 20104, 201, '固体润滑剂');
INSERT INTO `mm_info` VALUES (15, 10105, 101, '船用钢板');
INSERT INTO `mm_info` VALUES (16, 10106, 101, '钢丝绳');
INSERT INTO `mm_info` VALUES (17, 10107, 101, '锚');
INSERT INTO `mm_info` VALUES (18, 10108, 101, '系船柱');
INSERT INTO `mm_info` VALUES (19, 10109, 101, '钢板桩');
INSERT INTO `mm_info` VALUES (20, 10110, 101, '生铁');

-- ----------------------------
-- Table structure for ms_info
-- ----------------------------
DROP TABLE IF EXISTS `ms_info`;
CREATE TABLE `ms_info`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ms_code` int(255) NOT NULL,
  `mm_code` int(255) NOT NULL,
  `ms_category` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `quantity_unti` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '单位',
  `fob` float NULL DEFAULT NULL COMMENT '参考单价(元)',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `mm_code`(`mm_code`) USING BTREE,
  INDEX `ms_code`(`ms_code`) USING BTREE,
  INDEX `ms_category`(`ms_category`) USING BTREE,
  CONSTRAINT `mm_code` FOREIGN KEY (`mm_code`) REFERENCES `mm_info` (`mm_code`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ms_info
-- ----------------------------
INSERT INTO `ms_info` VALUES (1, 1010101, 10101, '方钢', 'Kg', 9.8);
INSERT INTO `ms_info` VALUES (2, 1010102, 10101, '扁钢', 'Kg', 10.2);
INSERT INTO `ms_info` VALUES (3, 1010103, 10101, '槽钢', 'Kg', 10.2);
INSERT INTO `ms_info` VALUES (4, 1010201, 10102, '低合金钢板', 'Kg', 11);
INSERT INTO `ms_info` VALUES (5, 1010202, 10102, '普碳钢板', 'Kg', 9);
INSERT INTO `ms_info` VALUES (6, 1010203, 10102, '不锈钢板', 'Kg', 9.8);
INSERT INTO `ms_info` VALUES (7, 1010301, 10103, '焊接钢管', 'Kg', 10.4);
INSERT INTO `ms_info` VALUES (8, 1010302, 10103, '无缝钢管', 'Kg', 12);
INSERT INTO `ms_info` VALUES (9, 1010401, 10104, '轻轨', 'Kg', 9.5);
INSERT INTO `ms_info` VALUES (10, 1010402, 10104, '重轨', 'Kg', 10);
INSERT INTO `ms_info` VALUES (11, 1010403, 10104, '起重轨', 'Kg', 12);
INSERT INTO `ms_info` VALUES (12, 1020101, 10201, '原条', 'T', 8400);
INSERT INTO `ms_info` VALUES (13, 1020102, 10201, '原木', 'T', 9300);
INSERT INTO `ms_info` VALUES (14, 1020103, 10201, '成材', 'T', 1100);
INSERT INTO `ms_info` VALUES (15, 1020201, 10202, '硅酸盐水泥', 'T', 380);
INSERT INTO `ms_info` VALUES (16, 1020202, 10202, '矿渣硅酸盐水泥', 'T', 350);
INSERT INTO `ms_info` VALUES (17, 1020203, 10202, '铝酸盐水泥', 'T', 400);
INSERT INTO `ms_info` VALUES (18, 1020301, 10203, '卵石', 'T', 500);
INSERT INTO `ms_info` VALUES (19, 1020302, 10203, '石粉', 'T', 650);
INSERT INTO `ms_info` VALUES (20, 2010101, 20101, '煤', 'T', 1000);

-- ----------------------------
-- Table structure for plan_detail
-- ----------------------------
DROP TABLE IF EXISTS `plan_detail`;
CREATE TABLE `plan_detail`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `plan_id` varchar(18) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '所属采购计划',
  `ms_code` int(11) NOT NULL COMMENT '申购材料编号',
  `ms_category` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '材料名',
  `purchase_sum` int(255) NOT NULL COMMENT '采购数目',
  `actual_price` float(10, 2) NULL DEFAULT NULL COMMENT '实际单价',
  `audit_level` int(1) NOT NULL COMMENT '审核进度',
  `procure_state` tinyint(4) NOT NULL COMMENT '是否已采购',
  `procure_date` datetime(0) NULL DEFAULT NULL COMMENT '采购日期',
  `user_id` int(11) NULL DEFAULT NULL COMMENT '采购人',
  `depart_no` varchar(6) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '提交部门',
  `supplier_id` int(11) NULL DEFAULT NULL COMMENT '供应商',
  `stock_state` tinyint(4) NOT NULL DEFAULT 0 COMMENT '入库状态',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `mscode`(`ms_code`) USING BTREE,
  INDEX `staffId`(`user_id`) USING BTREE,
  INDEX `ms_category`(`ms_category`) USING BTREE,
  INDEX `plan_id`(`plan_id`) USING BTREE,
  INDEX `depart_no_1`(`depart_no`) USING BTREE,
  INDEX `supplier_id_1`(`supplier_id`) USING BTREE,
  CONSTRAINT `depart_no_1` FOREIGN KEY (`depart_no`) REFERENCES `depart_info` (`depart_no`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ms_category` FOREIGN KEY (`ms_category`) REFERENCES `ms_info` (`ms_category`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `mscode` FOREIGN KEY (`ms_code`) REFERENCES `ms_info` (`ms_code`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `plan_id` FOREIGN KEY (`plan_id`) REFERENCES `procure_plan` (`plan_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `staffId` FOREIGN KEY (`user_id`) REFERENCES `user_info` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `supplier_id_1` FOREIGN KEY (`supplier_id`) REFERENCES `supplier_info` (`supplier_no`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 34 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of plan_detail
-- ----------------------------
INSERT INTO `plan_detail` VALUES (1, 'month2022050201', 1010101, '方钢', 100, 9.86, 1, 1, '2023-05-30 00:00:00', 3, '000001', 1, 1);
INSERT INTO `plan_detail` VALUES (2, 'month2022050201', 1010401, '轻轨', 1000, 9.60, 1, 1, '2022-06-07 00:00:00', 1, '000001', 1, 1);
INSERT INTO `plan_detail` VALUES (3, 'month2022050201', 1010203, '不锈钢板', 1000, 9.90, 1, 1, '2022-06-07 00:00:00', 3, '000001', 1, 1);
INSERT INTO `plan_detail` VALUES (4, 'urgent2022050202', 1010302, '无缝钢管', 1000, NULL, 3, 0, NULL, NULL, '000001', NULL, 0);
INSERT INTO `plan_detail` VALUES (5, 'urgent2022050202', 1010102, '扁钢', 2000, NULL, 3, 0, NULL, NULL, '000001', NULL, 0);
INSERT INTO `plan_detail` VALUES (6, 'urgent2022050202', 2010101, '煤', 200, NULL, 3, 0, NULL, NULL, '000001', NULL, 0);
INSERT INTO `plan_detail` VALUES (7, 'daily2022050203', 1020103, '成材', 1000, 11.20, 1, 1, '2022-05-03 00:00:00', 1, '000001', 1, 0);
INSERT INTO `plan_detail` VALUES (8, 'daily2022050203', 1010201, '低合金钢板', 200, 11.20, 1, 1, '2022-05-09 00:00:00', 1, '000001', 1, 1);
INSERT INTO `plan_detail` VALUES (9, 'daily2022050203', 1010302, '无缝钢管', 100, 10.00, 1, 1, '2022-05-13 00:00:00', 1, '000001', 1, 1);
INSERT INTO `plan_detail` VALUES (10, 'urgent2022050301', 1010103, '槽钢', 1000, NULL, 3, 0, NULL, NULL, '000001', NULL, 0);
INSERT INTO `plan_detail` VALUES (11, 'urgent2022050301', 1010102, '扁钢', 1000, NULL, 3, 0, NULL, NULL, '000001', NULL, 0);
INSERT INTO `plan_detail` VALUES (12, 'daily2022050203', 1010103, '槽钢', 1000, 10.30, 1, 1, '2022-05-03 00:00:00', 1, '000001', 1, 1);
INSERT INTO `plan_detail` VALUES (13, 'daily2022050203', 1020301, '卵石', 1000, 510.00, 1, 1, '2022-05-06 00:00:00', 1, '000001', 1, 0);
INSERT INTO `plan_detail` VALUES (14, 'daily2022050203', 1020102, '原木', 1000, NULL, 1, 0, NULL, NULL, '000004', NULL, 0);
INSERT INTO `plan_detail` VALUES (15, 'daily2022050203', 1010402, '重轨', 2000, 10.20, 1, 1, '2022-05-06 00:00:00', 1, '000001', 1, 1);
INSERT INTO `plan_detail` VALUES (16, 'month2022050901', 1010302, '无缝钢管', 1000, NULL, 1, 0, NULL, NULL, '000001', NULL, 0);
INSERT INTO `plan_detail` VALUES (17, 'month2022050901', 1010103, '槽钢', 1000, NULL, 1, 0, NULL, NULL, '000001', NULL, 0);
INSERT INTO `plan_detail` VALUES (18, 'month2022050901', 1010301, '焊接钢管', 2000, NULL, 3, 0, NULL, NULL, '000001', NULL, 0);
INSERT INTO `plan_detail` VALUES (19, 'urgent2022051301', 1010102, '扁钢', 2000, NULL, 3, 0, NULL, NULL, '000001', NULL, 0);
INSERT INTO `plan_detail` VALUES (20, 'urgent2022051301', 1010103, '槽钢', 2000, NULL, 3, 0, NULL, NULL, '000001', NULL, 0);
INSERT INTO `plan_detail` VALUES (21, 'month2022051302', 1010101, '方钢', 2000, NULL, 3, 0, NULL, NULL, '000001', NULL, 0);
INSERT INTO `plan_detail` VALUES (22, 'month2022051302', 1010102, '扁钢', 2000, NULL, 3, 0, NULL, NULL, '000001', NULL, 0);
INSERT INTO `plan_detail` VALUES (23, 'month2022060701', 1010101, '方钢', 1000, NULL, 1, 0, NULL, NULL, '000001', NULL, 0);
INSERT INTO `plan_detail` VALUES (24, 'month2022060701', 1010102, '扁钢', 1000, NULL, 1, 0, NULL, NULL, '000001', NULL, 0);
INSERT INTO `plan_detail` VALUES (25, 'month2022060701', 1010202, '普碳钢板', 1000, NULL, 1, 0, NULL, NULL, '000001', NULL, 0);
INSERT INTO `plan_detail` VALUES (26, 'urgent2022060702', 1020102, '原木', 100, NULL, 1, 0, NULL, NULL, '000001', NULL, 0);
INSERT INTO `plan_detail` VALUES (27, 'urgent2022060702', 1010402, '重轨', 1000, NULL, 1, 0, NULL, NULL, '000001', NULL, 0);
INSERT INTO `plan_detail` VALUES (28, 'daily2022060703', 1010202, '普碳钢板', 1000, NULL, 1, 0, NULL, NULL, '000001', NULL, 0);
INSERT INTO `plan_detail` VALUES (29, 'daily2022060703', 1010203, '不锈钢板', 1000, NULL, 1, 0, NULL, NULL, '000001', NULL, 0);
INSERT INTO `plan_detail` VALUES (30, 'daily2022060704', 1010102, '扁钢', 1000, NULL, 1, 0, NULL, NULL, '000001', NULL, 0);
INSERT INTO `plan_detail` VALUES (31, 'daily2022060704', 1010101, '方钢', 1000, NULL, 1, 0, NULL, NULL, '000001', NULL, 0);
INSERT INTO `plan_detail` VALUES (32, 'daily2022060704', 1010103, '槽钢', 1000, NULL, 3, 0, NULL, NULL, '000001', NULL, 0);
INSERT INTO `plan_detail` VALUES (33, 'month2023052901', 1010101, '方钢', 1000000, NULL, 2, 0, NULL, NULL, '000002', NULL, 0);

-- ----------------------------
-- Table structure for procure_plan
-- ----------------------------
DROP TABLE IF EXISTS `procure_plan`;
CREATE TABLE `procure_plan`  (
  `plan_id` varchar(18) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '计划编号',
  `release_time` datetime(0) NOT NULL COMMENT '发布时间',
  `plan_class` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '计划类型',
  `user_id` int(11) NOT NULL COMMENT '申报人id',
  `user_name` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '申报人姓名',
  `plan_describe` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '申报说明',
  PRIMARY KEY (`plan_id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE,
  INDEX `user_name`(`user_name`) USING BTREE,
  CONSTRAINT `user_id` FOREIGN KEY (`user_id`) REFERENCES `user_info` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `user_name` FOREIGN KEY (`user_name`) REFERENCES `user_info` (`username`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of procure_plan
-- ----------------------------
INSERT INTO `procure_plan` VALUES ('daily2022050203', '2022-05-02 00:00:00', '日常缺额', 1, '杨阜康', '天气过热，物资消耗快，请求日常补缺，望在20号之前采购完成');
INSERT INTO `procure_plan` VALUES ('daily2022060703', '2022-06-07 00:00:00', '日常缺额', 3, '龚东东', '是');
INSERT INTO `procure_plan` VALUES ('daily2022060704', '2022-06-07 00:00:00', '日常缺额', 1, '杨阜康', 'shang');
INSERT INTO `procure_plan` VALUES ('month2022050201', '2022-05-02 00:00:00', '月度计划', 1, '杨阜康', '22年5月计划');
INSERT INTO `procure_plan` VALUES ('month2022050901', '2022-05-09 00:00:00', '月度计划', 1, '杨阜康', '123123123');
INSERT INTO `procure_plan` VALUES ('month2022051302', '2022-05-13 00:00:00', '月度计划', 1, '杨阜康', 'asdasda');
INSERT INTO `procure_plan` VALUES ('month2022060701', '2022-06-07 00:00:00', '月度计划', 3, '龚东东', '六月月度计划');
INSERT INTO `procure_plan` VALUES ('month2023052901', '2023-05-29 00:00:00', '月度计划', 1, '杨阜康', '急切需求');
INSERT INTO `procure_plan` VALUES ('urgent2022050202', '2022-05-02 00:00:00', '紧急需求', 1, '杨阜康', '由于1号挖机故障，需采购一定量物资弥补缺失');
INSERT INTO `procure_plan` VALUES ('urgent2022050301', '2022-05-03 00:00:00', '紧急需求', 1, '杨阜康', 'test');
INSERT INTO `procure_plan` VALUES ('urgent2022051301', '2022-05-13 00:00:00', '紧急需求', 1, '杨阜康', 'adssa');
INSERT INTO `procure_plan` VALUES ('urgent2022060702', '2022-06-07 00:00:00', '紧急需求', 3, '龚东东', '');

-- ----------------------------
-- Table structure for stock_depot
-- ----------------------------
DROP TABLE IF EXISTS `stock_depot`;
CREATE TABLE `stock_depot`  (
  `id` int(11) NOT NULL COMMENT '仓库id',
  `capacity` int(11) NOT NULL COMMENT '容量',
  `occupied` int(11) NOT NULL COMMENT '已占有容量',
  `mb_code` int(11) NOT NULL COMMENT '所存货物大类',
  `unit` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '容量单位',
  `manager_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `mbCode`(`mb_code`) USING BTREE,
  INDEX `manager_id`(`manager_id`) USING BTREE,
  CONSTRAINT `manager_id` FOREIGN KEY (`manager_id`) REFERENCES `user_info` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `mbCode` FOREIGN KEY (`mb_code`) REFERENCES `mb_info` (`mb_code`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of stock_depot
-- ----------------------------
INSERT INTO `stock_depot` VALUES (1, 100000, 7200, 101, 'KG', 6);
INSERT INTO `stock_depot` VALUES (2, 1000, 0, 102, 'T', 7);
INSERT INTO `stock_depot` VALUES (3, 1000, 0, 103, 'T', 8);
INSERT INTO `stock_depot` VALUES (4, 1000, 0, 201, '桶', 9);
INSERT INTO `stock_depot` VALUES (5, 10000, 0, 202, 'KG', 10);
INSERT INTO `stock_depot` VALUES (6, 10000, 0, 203, '个', 11);
INSERT INTO `stock_depot` VALUES (7, 1000, 0, 204, 'T', 12);

-- ----------------------------
-- Table structure for stock_into_records
-- ----------------------------
DROP TABLE IF EXISTS `stock_into_records`;
CREATE TABLE `stock_into_records`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '记录id',
  `detail_id` int(11) NOT NULL COMMENT '采购单号',
  `generate_time` datetime(0) NOT NULL COMMENT '入库时间',
  `record_id` int(11) NOT NULL COMMENT '入库记录员工',
  `into_sum` int(11) NOT NULL COMMENT '入库数目',
  `ms_code` int(11) NOT NULL COMMENT '入库物资',
  `stock_records` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '记录入库存放的仓库号、货架号、以及存放数目',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `detail_id_1`(`detail_id`) USING BTREE,
  INDEX `ms_code_1`(`ms_code`) USING BTREE,
  INDEX `record_id`(`record_id`) USING BTREE,
  CONSTRAINT `detail_id_1` FOREIGN KEY (`detail_id`) REFERENCES `plan_detail` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ms_code_1` FOREIGN KEY (`ms_code`) REFERENCES `ms_info` (`ms_code`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `record_id` FOREIGN KEY (`record_id`) REFERENCES `user_info` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of stock_into_records
-- ----------------------------
INSERT INTO `stock_into_records` VALUES (2, 15, '2022-05-07 00:00:00', 6, 2000, 1010402, '1,002,100;1,004,1000;1,005,900;');
INSERT INTO `stock_into_records` VALUES (3, 1, '2022-05-07 00:00:00', 1, 100, 1010101, '1,006,100;');
INSERT INTO `stock_into_records` VALUES (4, 12, '2022-05-07 00:00:00', 1, 1000, 1010103, '1,007,1000;');
INSERT INTO `stock_into_records` VALUES (5, 8, '2022-05-09 00:00:00', 1, 200, 1010201, '1,009,200;');
INSERT INTO `stock_into_records` VALUES (6, 9, '2022-05-13 00:00:00', 1, 100, 1010302, '1,011,100;');
INSERT INTO `stock_into_records` VALUES (7, 2, '2022-06-07 00:00:00', 1, 1000, 1010401, '1,006,1000;');
INSERT INTO `stock_into_records` VALUES (8, 3, '2022-06-07 00:00:00', 3, 1000, 1010203, '1,008,1000;');

-- ----------------------------
-- Table structure for stock_out_application
-- ----------------------------
DROP TABLE IF EXISTS `stock_out_application`;
CREATE TABLE `stock_out_application`  (
  `id` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '申请编号',
  `application_time` datetime(0) NOT NULL COMMENT '申请时间',
  `application_user_id` int(11) NOT NULL COMMENT '申请人',
  `ms_code` int(255) NOT NULL COMMENT '材料编号',
  `out_number` int(255) NOT NULL COMMENT '申请量',
  `ms_category` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '材料名称',
  `purpose_of_use` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用途',
  `machine_id` int(11) NULL DEFAULT NULL COMMENT '机器编号',
  `outbound_state` tinyint(4) NOT NULL COMMENT '是否已出库',
  `depart_no` varchar(6) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '申请部门',
  `audit_level` int(11) NOT NULL COMMENT '当前审核等级',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `ms_code_2`(`ms_code`) USING BTREE,
  INDEX `application_user_id`(`application_user_id`) USING BTREE,
  INDEX `depart_no_2`(`depart_no`) USING BTREE,
  CONSTRAINT `application_user_id` FOREIGN KEY (`application_user_id`) REFERENCES `user_info` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `depart_no_2` FOREIGN KEY (`depart_no`) REFERENCES `depart_info` (`depart_no`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ms_code_2` FOREIGN KEY (`ms_code`) REFERENCES `ms_info` (`ms_code`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of stock_out_application
-- ----------------------------
INSERT INTO `stock_out_application` VALUES ('1524291291867574274', '2022-05-11 00:00:00', 1, 1010101, 200, '方钢', 'test', NULL, 1, '000001', 1);
INSERT INTO `stock_out_application` VALUES ('1524291959714017281', '2022-05-11 00:00:00', 1, 1010103, 300, '槽钢', '', NULL, 1, '000001', 1);
INSERT INTO `stock_out_application` VALUES ('1524598241633337346', '2022-05-12 00:00:00', 3, 1010101, 400, '方钢', 'test', NULL, 1, '000001', 1);
INSERT INTO `stock_out_application` VALUES ('1524654851936321538', '2022-05-12 00:00:00', 1, 1010101, 500, '方钢', 'test', NULL, 0, '000001', 3);
INSERT INTO `stock_out_application` VALUES ('1534054128416530433', '2022-06-07 00:00:00', 3, 1010101, 100, '方钢', ' ', NULL, 1, '000001', 1);

-- ----------------------------
-- Table structure for stock_out_records
-- ----------------------------
DROP TABLE IF EXISTS `stock_out_records`;
CREATE TABLE `stock_out_records`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '记录id',
  `application_id` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '对应出库申请号',
  `out_stock_time` datetime(0) NOT NULL COMMENT '出库时间',
  `recorder_id` int(11) NOT NULL COMMENT '出库记录员id',
  `ms_code` int(11) NOT NULL COMMENT '对应物资编号',
  `out_number` int(11) NOT NULL COMMENT '出库数目',
  `stock_records` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '记录出库情况',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `application_id`(`application_id`) USING BTREE,
  INDEX `ms_code_3`(`ms_code`) USING BTREE,
  INDEX `recorder_id`(`recorder_id`) USING BTREE,
  CONSTRAINT `application_id` FOREIGN KEY (`application_id`) REFERENCES `stock_out_application` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ms_code_3` FOREIGN KEY (`ms_code`) REFERENCES `ms_info` (`ms_code`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `recorder_id` FOREIGN KEY (`recorder_id`) REFERENCES `user_info` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of stock_out_records
-- ----------------------------
INSERT INTO `stock_out_records` VALUES (1, '1524291291867574274', '2022-05-12 00:00:00', 3, 1010101, 200, '1号仓库,006号货架,出库100单位;1号仓库,001号货架,出库100单位;');
INSERT INTO `stock_out_records` VALUES (2, '1524291959714017281', '2022-05-12 00:00:00', 3, 1010103, 300, '1号仓库,007号货架,出库300单位;');
INSERT INTO `stock_out_records` VALUES (3, '1524598241633337346', '2022-05-12 00:00:00', 3, 1010101, 400, '1号仓库,001号货架,出库400单位;');
INSERT INTO `stock_out_records` VALUES (4, '1534054128416530433', '2022-06-07 00:00:00', 3, 1010101, 100, '1号仓库,001号货架,出库100单位;');

-- ----------------------------
-- Table structure for stock_shelves
-- ----------------------------
DROP TABLE IF EXISTS `stock_shelves`;
CREATE TABLE `stock_shelves`  (
  `id` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '货架号',
  `depot_id` int(11) NOT NULL COMMENT '所属仓库',
  `capacity` int(11) NOT NULL COMMENT '容量',
  `occupied` int(11) NOT NULL COMMENT '已占有容量',
  `ms_code` int(255) NULL DEFAULT NULL COMMENT '所存货物编号',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `depot_id`(`depot_id`) USING BTREE,
  INDEX `ms_code`(`ms_code`) USING BTREE,
  CONSTRAINT `depot_id` FOREIGN KEY (`depot_id`) REFERENCES `stock_depot` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ms_code` FOREIGN KEY (`ms_code`) REFERENCES `ms_info` (`ms_code`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of stock_shelves
-- ----------------------------
INSERT INTO `stock_shelves` VALUES ('001', 1, 1000, 400, 1010101);
INSERT INTO `stock_shelves` VALUES ('002', 1, 1000, 1000, 1010402);
INSERT INTO `stock_shelves` VALUES ('003', 1, 1000, 900, 1010102);
INSERT INTO `stock_shelves` VALUES ('004', 1, 1000, 1000, 1010402);
INSERT INTO `stock_shelves` VALUES ('005', 1, 1000, 900, 1010402);
INSERT INTO `stock_shelves` VALUES ('006', 1, 1000, 1000, 1010401);
INSERT INTO `stock_shelves` VALUES ('007', 1, 1000, 700, 1010103);
INSERT INTO `stock_shelves` VALUES ('008', 1, 1000, 1000, 1010203);
INSERT INTO `stock_shelves` VALUES ('009', 1, 1000, 200, 1010201);
INSERT INTO `stock_shelves` VALUES ('010', 1, 1000, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('011', 1, 1000, 100, 1010302);
INSERT INTO `stock_shelves` VALUES ('012', 1, 1000, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('013', 1, 1000, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('014', 1, 1000, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('015', 1, 1000, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('016', 1, 1000, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('017', 1, 1000, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('018', 1, 1000, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('019', 1, 1000, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('020', 1, 1000, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('021', 1, 1000, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('022', 1, 1000, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('023', 1, 1000, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('024', 1, 1000, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('025', 1, 1000, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('026', 1, 1000, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('027', 1, 1000, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('028', 1, 1000, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('029', 1, 1000, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('030', 1, 1000, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('031', 1, 1000, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('032', 1, 1000, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('033', 1, 1000, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('034', 1, 1000, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('035', 1, 1000, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('036', 1, 1000, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('037', 1, 1000, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('038', 1, 1000, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('039', 1, 1000, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('040', 1, 1000, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('041', 1, 1000, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('042', 1, 1000, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('043', 1, 1000, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('044', 1, 1000, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('045', 1, 1000, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('046', 1, 1000, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('047', 1, 1000, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('048', 1, 1000, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('049', 1, 1000, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('050', 1, 1000, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('051', 1, 1000, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('052', 1, 1000, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('053', 1, 1000, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('054', 1, 1000, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('055', 1, 1000, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('056', 1, 1000, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('057', 1, 1000, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('058', 1, 1000, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('059', 1, 1000, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('060', 1, 1000, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('061', 1, 1000, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('062', 1, 1000, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('063', 1, 1000, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('064', 1, 1000, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('065', 1, 1000, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('066', 1, 1000, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('067', 1, 1000, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('068', 1, 1000, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('069', 1, 1000, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('070', 1, 1000, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('071', 1, 1000, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('072', 1, 1000, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('073', 1, 1000, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('074', 1, 1000, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('075', 1, 1000, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('076', 1, 1000, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('077', 1, 1000, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('078', 1, 1000, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('079', 1, 1000, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('080', 1, 1000, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('081', 1, 1000, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('082', 1, 1000, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('083', 1, 1000, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('084', 1, 1000, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('085', 1, 1000, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('086', 1, 1000, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('087', 1, 1000, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('088', 1, 1000, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('089', 1, 1000, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('090', 1, 1000, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('091', 1, 1000, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('092', 1, 1000, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('093', 1, 1000, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('094', 1, 1000, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('095', 1, 1000, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('096', 1, 1000, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('097', 1, 1000, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('098', 1, 1000, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('099', 1, 1000, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('100', 1, 1000, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('101', 2, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('102', 2, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('103', 2, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('104', 2, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('105', 2, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('106', 2, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('107', 2, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('108', 2, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('109', 2, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('110', 2, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('111', 2, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('112', 2, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('113', 2, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('114', 2, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('115', 2, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('116', 2, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('117', 2, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('118', 2, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('119', 2, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('120', 2, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('121', 2, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('122', 2, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('123', 2, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('124', 2, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('125', 2, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('126', 2, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('127', 2, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('128', 2, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('129', 2, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('130', 2, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('131', 2, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('132', 2, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('133', 2, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('134', 2, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('135', 2, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('136', 2, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('137', 2, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('138', 2, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('139', 2, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('140', 2, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('141', 2, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('142', 2, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('143', 2, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('144', 2, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('145', 2, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('146', 2, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('147', 2, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('148', 2, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('149', 2, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('150', 2, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('151', 2, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('152', 2, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('153', 2, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('154', 2, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('155', 2, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('156', 2, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('157', 2, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('158', 2, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('159', 2, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('160', 2, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('161', 2, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('162', 2, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('163', 2, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('164', 2, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('165', 2, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('166', 2, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('167', 2, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('168', 2, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('169', 2, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('170', 2, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('171', 2, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('172', 2, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('173', 2, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('174', 2, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('175', 2, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('176', 2, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('177', 2, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('178', 2, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('179', 2, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('180', 2, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('181', 2, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('182', 2, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('183', 2, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('184', 2, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('185', 2, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('186', 2, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('187', 2, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('188', 2, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('189', 2, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('190', 2, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('191', 2, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('192', 2, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('193', 2, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('194', 2, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('195', 2, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('196', 2, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('197', 2, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('198', 2, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('199', 2, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('200', 2, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('201', 3, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('202', 3, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('203', 3, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('204', 3, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('205', 3, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('206', 3, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('207', 3, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('208', 3, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('209', 3, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('210', 3, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('211', 3, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('212', 3, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('213', 3, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('214', 3, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('215', 3, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('216', 3, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('217', 3, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('218', 3, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('219', 3, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('220', 3, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('221', 3, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('222', 3, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('223', 3, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('224', 3, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('225', 3, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('226', 3, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('227', 3, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('228', 3, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('229', 3, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('230', 3, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('231', 3, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('232', 3, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('233', 3, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('234', 3, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('235', 3, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('236', 3, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('237', 3, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('238', 3, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('239', 3, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('240', 3, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('241', 3, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('242', 3, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('243', 3, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('244', 3, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('245', 3, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('246', 3, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('247', 3, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('248', 3, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('249', 3, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('250', 3, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('251', 3, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('252', 3, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('253', 3, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('254', 3, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('255', 3, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('256', 3, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('257', 3, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('258', 3, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('259', 3, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('260', 3, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('261', 3, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('262', 3, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('263', 3, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('264', 3, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('265', 3, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('266', 3, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('267', 3, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('268', 3, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('269', 3, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('270', 3, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('271', 3, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('272', 3, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('273', 3, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('274', 3, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('275', 3, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('276', 3, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('277', 3, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('278', 3, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('279', 3, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('280', 3, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('281', 3, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('282', 3, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('283', 3, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('284', 3, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('285', 3, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('286', 3, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('287', 3, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('288', 3, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('289', 3, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('290', 3, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('291', 3, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('292', 3, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('293', 3, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('294', 3, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('295', 3, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('296', 3, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('297', 3, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('298', 3, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('299', 3, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('300', 3, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('301', 4, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('302', 4, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('303', 4, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('304', 4, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('305', 4, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('306', 4, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('307', 4, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('308', 4, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('309', 4, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('310', 4, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('311', 4, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('312', 4, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('313', 4, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('314', 4, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('315', 4, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('316', 4, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('317', 4, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('318', 4, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('319', 4, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('320', 4, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('321', 4, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('322', 4, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('323', 4, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('324', 4, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('325', 4, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('326', 4, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('327', 4, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('328', 4, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('329', 4, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('330', 4, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('331', 4, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('332', 4, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('333', 4, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('334', 4, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('335', 4, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('336', 4, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('337', 4, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('338', 4, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('339', 4, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('340', 4, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('341', 4, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('342', 4, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('343', 4, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('344', 4, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('345', 4, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('346', 4, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('347', 4, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('348', 4, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('349', 4, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('350', 4, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('351', 4, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('352', 4, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('353', 4, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('354', 4, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('355', 4, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('356', 4, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('357', 4, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('358', 4, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('359', 4, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('360', 4, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('361', 4, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('362', 4, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('363', 4, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('364', 4, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('365', 4, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('366', 4, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('367', 4, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('368', 4, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('369', 4, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('370', 4, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('371', 4, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('372', 4, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('373', 4, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('374', 4, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('375', 4, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('376', 4, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('377', 4, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('378', 4, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('379', 4, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('380', 4, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('381', 4, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('382', 4, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('383', 4, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('384', 4, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('385', 4, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('386', 4, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('387', 4, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('388', 4, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('389', 4, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('390', 4, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('391', 4, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('392', 4, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('393', 4, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('394', 4, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('395', 4, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('396', 4, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('397', 4, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('398', 4, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('399', 4, 10, 0, NULL);
INSERT INTO `stock_shelves` VALUES ('400', 4, 10, 0, NULL);

-- ----------------------------
-- Table structure for supplier_info
-- ----------------------------
DROP TABLE IF EXISTS `supplier_info`;
CREATE TABLE `supplier_info`  (
  `supplier_no` int(11) NOT NULL AUTO_INCREMENT COMMENT '供应商编号',
  `supplier_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '公司名称',
  PRIMARY KEY (`supplier_no`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of supplier_info
-- ----------------------------
INSERT INTO `supplier_info` VALUES (1, '枝江钢铁集团有限公司');

-- ----------------------------
-- Table structure for user_info
-- ----------------------------
DROP TABLE IF EXISTS `user_info`;
CREATE TABLE `user_info`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '员工唯一标识',
  `username` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '员工姓名',
  `password` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '密码，经md5加密后字段',
  `phone` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '员工联系电话',
  `accesstime` date NOT NULL COMMENT '注册时间',
  `valid` tinyint(1) NOT NULL COMMENT '账号是否有效',
  `job_id` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `job_id`(`job_id`) USING BTREE,
  INDEX `username`(`username`) USING BTREE,
  CONSTRAINT `job_id` FOREIGN KEY (`job_id`) REFERENCES `job_info` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_info
-- ----------------------------
INSERT INTO `user_info` VALUES (1, '杨阜康', 'e10adc3949ba59abbe56e057f20f883e', '15635928925', '2022-04-10', 1, 4);
INSERT INTO `user_info` VALUES (2, '曾昊宇', 'dc0fa7df3d07904a09288bd2d2bb5f40', '13329869259', '2022-04-28', 1, 2);
INSERT INTO `user_info` VALUES (3, '龚东东', '2b94e57d80e713935aaad93da21cfc0a', '15129630498', '2022-04-28', 1, 3);
INSERT INTO `user_info` VALUES (4, '李航飞', 'e10adc3949ba59abbe56e057f20f883e', '13720113769', '2022-04-28', 1, 9);
INSERT INTO `user_info` VALUES (5, '张三', 'e10adc3949ba59abbe56e057f20f883e', '13345677676', '2022-04-29', 1, 1);
INSERT INTO `user_info` VALUES (6, '杨一', 'e10adc3949ba59abbe56e057f20f883e', '13345678765', '2022-05-05', 1, 10);
INSERT INTO `user_info` VALUES (7, '杨二', 'e10adc3949ba59abbe56e057f20f883e', '17765248925', '2022-05-05', 1, 10);
INSERT INTO `user_info` VALUES (8, '杨三', 'e10adc3949ba59abbe56e057f20f883e', '18765467726', '2022-05-05', 1, 10);
INSERT INTO `user_info` VALUES (9, '杨思', 'e10adc3949ba59abbe56e057f20f883e', '15643567789', '2022-05-05', 1, 10);
INSERT INTO `user_info` VALUES (10, '杨武', 'e10adc3949ba59abbe56e057f20f883e', '13454578888', '2022-05-05', 1, 10);
INSERT INTO `user_info` VALUES (11, '杨柳', 'e10adc3949ba59abbe56e057f20f883e', '15644567788', '2022-05-05', 1, 10);
INSERT INTO `user_info` VALUES (12, '杨齐', 'e10adc3949ba59abbe56e057f20f883e', '13347457725', '2022-05-05', 1, 10);

-- ----------------------------
-- View structure for depot_view
-- ----------------------------
DROP VIEW IF EXISTS `depot_view`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `depot_view` AS select `stock_depot`.`id` AS `id`,`stock_depot`.`capacity` AS `capacity`,`stock_depot`.`occupied` AS `occupied`,`stock_depot`.`mb_code` AS `mb_code`,`stock_depot`.`unit` AS `unit`,`stock_depot`.`manager_id` AS `manager_id`,`user_info`.`username` AS `username`,`mb_info`.`mb_category` AS `mb_category` from ((`stock_depot` join `user_info` on((`stock_depot`.`manager_id` = `user_info`.`id`))) join `mb_info` on((`stock_depot`.`mb_code` = `mb_info`.`mb_code`)));

-- ----------------------------
-- View structure for detail_info
-- ----------------------------
DROP VIEW IF EXISTS `detail_info`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `detail_info` AS select `plan_detail`.`id` AS `id`,`plan_detail`.`plan_id` AS `plan_id`,`plan_detail`.`ms_code` AS `ms_code`,`plan_detail`.`ms_category` AS `ms_category`,`plan_detail`.`purchase_sum` AS `purchase_sum`,`plan_detail`.`actual_price` AS `actual_price`,`plan_detail`.`audit_level` AS `audit_level`,`plan_detail`.`procure_state` AS `procure_state`,`plan_detail`.`procure_date` AS `procure_date`,`plan_detail`.`user_id` AS `user_id`,`plan_detail`.`depart_no` AS `depart_no`,`plan_detail`.`supplier_id` AS `supplier_id`,`depart_info`.`depart_name` AS `depart_name`,`ms_info`.`fob` AS `fob`,`ms_info`.`quantity_unti` AS `quantity_unti`,`plan_detail`.`stock_state` AS `stock_state`,`user_info`.`username` AS `username` from (((`plan_detail` join `ms_info` on(((`plan_detail`.`ms_category` = `ms_info`.`ms_category`) and (`plan_detail`.`ms_code` = `ms_info`.`ms_code`)))) join `depart_info` on((`plan_detail`.`depart_no` = `depart_info`.`depart_no`))) left join `user_info` on((`plan_detail`.`user_id` = `user_info`.`id`)));

-- ----------------------------
-- View structure for material_view
-- ----------------------------
DROP VIEW IF EXISTS `material_view`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `material_view` AS select `ms_info`.`id` AS `id`,`ms_info`.`ms_code` AS `ms_code`,`mb_info`.`mb_category` AS `mb_category`,`mm_info`.`mm_category` AS `mm_category`,`ms_info`.`ms_category` AS `ms_category`,`ms_info`.`mm_code` AS `mm_code`,`mb_info`.`mb_code` AS `mb_code` from ((`mb_info` join `mm_info` on((`mb_info`.`mb_code` = `mm_info`.`mb_code`))) join `ms_info` on((`mm_info`.`mm_code` = `ms_info`.`mm_code`)));

-- ----------------------------
-- View structure for record_detail_view
-- ----------------------------
DROP VIEW IF EXISTS `record_detail_view`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `record_detail_view` AS select `stock_into_records`.`id` AS `id`,`stock_into_records`.`detail_id` AS `detail_id`,`stock_into_records`.`generate_time` AS `generate_time`,`stock_into_records`.`record_id` AS `record_id`,`stock_into_records`.`into_sum` AS `into_sum`,`stock_into_records`.`ms_code` AS `ms_code`,`stock_into_records`.`stock_records` AS `stock_records`,`plan_detail`.`plan_id` AS `plan_id`,`plan_detail`.`ms_category` AS `ms_category`,`plan_detail`.`actual_price` AS `actual_price`,`plan_detail`.`procure_date` AS `procure_date`,`plan_detail`.`supplier_id` AS `supplier_id`,`supplier_info`.`supplier_name` AS `supplier_name`,`procure_plan`.`plan_class` AS `plan_class`,`mm_info`.`mb_code` AS `mb_code`,`ms_info`.`quantity_unti` AS `quantity_unti`,`plan_detail`.`user_id` AS `user_id` from (((((`stock_into_records` join `plan_detail` on((`stock_into_records`.`detail_id` = `plan_detail`.`id`))) join `supplier_info` on((`plan_detail`.`supplier_id` = `supplier_info`.`supplier_no`))) join `procure_plan` on((`plan_detail`.`plan_id` = `procure_plan`.`plan_id`))) join `ms_info` on(((`plan_detail`.`ms_category` = `ms_info`.`ms_category`) and (`plan_detail`.`ms_code` = `ms_info`.`ms_code`) and (`stock_into_records`.`ms_code` = `ms_info`.`ms_code`)))) join `mm_info` on((`ms_info`.`mm_code` = `mm_info`.`mm_code`)));

-- ----------------------------
-- View structure for record_out_view
-- ----------------------------
DROP VIEW IF EXISTS `record_out_view`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `record_out_view` AS select `stock_out_records`.`id` AS `id`,`stock_out_records`.`application_id` AS `application_id`,`stock_out_records`.`out_stock_time` AS `out_stock_time`,`stock_out_records`.`recorder_id` AS `recorder_id`,`stock_out_records`.`ms_code` AS `ms_code`,`stock_out_records`.`out_number` AS `out_number`,`stock_out_records`.`stock_records` AS `stock_records`,`stock_out_application`.`ms_category` AS `ms_category`,`stock_out_application`.`purpose_of_use` AS `purpose_of_use`,`stock_out_application`.`machine_id` AS `machine_id`,`stock_out_application`.`depart_no` AS `depart_no`,`ms_info`.`quantity_unti` AS `quantity_unti`,`depart_info`.`depart_name` AS `depart_name`,`stock_out_application`.`application_user_id` AS `application_user_id` from (((`stock_out_records` join `stock_out_application` on((`stock_out_records`.`application_id` = `stock_out_application`.`id`))) join `ms_info` on(((`stock_out_application`.`ms_code` = `ms_info`.`ms_code`) and (`stock_out_records`.`ms_code` = `ms_info`.`ms_code`)))) join `depart_info` on((`stock_out_application`.`depart_no` = `depart_info`.`depart_no`)));

-- ----------------------------
-- View structure for shelves_view
-- ----------------------------
DROP VIEW IF EXISTS `shelves_view`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `shelves_view` AS select `stock_shelves`.`id` AS `id`,`stock_shelves`.`depot_id` AS `depot_id`,`stock_shelves`.`capacity` AS `capacity`,`stock_shelves`.`occupied` AS `occupied`,`stock_shelves`.`ms_code` AS `ms_code`,`stock_depot`.`unit` AS `unit`,`stock_depot`.`mb_code` AS `mb_code`,`ms_info`.`ms_category` AS `ms_category` from ((`stock_shelves` join `stock_depot` on((`stock_shelves`.`depot_id` = `stock_depot`.`id`))) left join `ms_info` on((`stock_shelves`.`ms_code` = `ms_info`.`ms_code`)));

-- ----------------------------
-- View structure for user_job
-- ----------------------------
DROP VIEW IF EXISTS `user_job`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `user_job` AS select `user_info`.`id` AS `id`,`user_info`.`username` AS `username`,`user_info`.`password` AS `password`,`user_info`.`phone` AS `phone`,`user_info`.`accesstime` AS `accesstime`,`user_info`.`valid` AS `valid`,`user_info`.`job_id` AS `job_id`,`job_info`.`job_name` AS `job_name`,`job_info`.`power_level` AS `power_level`,`depart_info`.`depart_name` AS `depart_name`,`depart_info`.`depart_no` AS `depart_no` from ((`user_info` join `job_info` on((`user_info`.`job_id` = `job_info`.`id`))) join `depart_info` on((`job_info`.`depart_no` = `depart_info`.`depart_no`)));

SET FOREIGN_KEY_CHECKS = 1;
