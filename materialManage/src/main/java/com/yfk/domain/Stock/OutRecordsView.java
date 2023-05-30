package com.yfk.domain.Stock;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.sql.Date;

@Data
@TableName("record_out_view")
public class OutRecordsView {
    private Integer id;

    @TableField("application_id")
    private String applicationId;

    @TableField("out_stock_time")
    private Date outStockTime;

    @TableField("recorder_id")
    private Integer recorderId;

    @TableField("out_number")
    private Integer outNumber;

    @TableField("ms_code")
    private Integer msCode;

    @TableField("stock_records")
    private String stockRecords;

    @TableField("ms_category")
    private String msCategory;

    @TableField("purpose_of_use")
    private String purposeOfUse;

    @TableField("machine_id")
    private Integer machineId;

    @TableField("depart_no")
    private String departNo;

    @TableField("depart_name")
    private String departName;

    @TableField("quantity_unti")
    private String quantityUnit;

    @TableField("application_user_id")
    private Integer applicationUserId;
}
