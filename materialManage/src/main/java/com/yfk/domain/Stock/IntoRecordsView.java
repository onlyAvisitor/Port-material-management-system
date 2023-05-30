package com.yfk.domain.Stock;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.sql.Date;

@Data
@TableName("record_detail_view")
public class IntoRecordsView {
    private Integer id;

    @TableField("detail_id")
    private Integer detailId;

    @TableField("generate_time")
    private Date generateTime;

    @TableField("record_id")
    private Integer recordId;

    @TableField("into_sum")
    private Integer intoSum;

    @TableField("ms_code")
    private Integer msCode;

    @TableField("stock_records")
    private String stockRecords;

    @TableField("plan_id")
    private String planId;

    @TableField("ms_category")
    private String msCategory;

    @TableField("actual_price")
    private Float actualPrice;

    @TableField("procure_date")
    private Date procureDate;

    @TableField("supplier_id")
    private Integer supplierId;

    @TableField("supplier_name")
    private String supplierName;

    @TableField("plan_class")
    private String planClass;

    @TableField("mb_code")
    private Integer mbCode;

    @TableField("quantity_unti")
    private String unit;

    @TableField("user_id")
    private Integer userId;
}
