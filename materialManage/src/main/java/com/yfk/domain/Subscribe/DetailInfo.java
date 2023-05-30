package com.yfk.domain.Subscribe;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

/**
 * 视图
 */
@Data
@TableName("detail_info")
public class DetailInfo {
    private Integer id;

    @TableField("plan_id")
    private String planId;

    @TableField("ms_code")
    private Integer msCode;

    @TableField("ms_category")
    private String msCategory;

    @TableField("purchase_sum")
    private Integer purchaseSum;

    @TableField("actual_price")
    private Float actualPrice;

    @TableField("audit_level")
    private Integer auditLevel;

    @TableField("procure_state")
    private Boolean procureState;

    @TableField("depart_no")
    private  String departNo;

    @TableField("depart_name")
    private  String departName;

    private Float fob;

    @TableField("quantity_unti")
    private String quantityUnit;

    @TableField("stock_state")
    private Boolean stockState;

    private String username;

    @TableField("user_id")
    private Integer userId;

    @TableField("procure_date")
    private String procureDate;
}
