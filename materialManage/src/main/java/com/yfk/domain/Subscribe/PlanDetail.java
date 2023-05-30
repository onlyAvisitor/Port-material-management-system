package com.yfk.domain.Subscribe;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.sql.Date;

@Data
@TableName("plan_detail")
public class PlanDetail {
    @TableId(type= IdType.AUTO)
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
    private boolean procureState;

    @TableField("procure_date")
    private Date procureDate;

    @TableField("user_id")
    private Integer userId;

    @TableField("depart_no")
    private String departNo;

    @TableField("supplier_id")
    private Integer supplierId;

    @TableField("stock_state")
    private Boolean stockState;
}
