package com.yfk.domain.Stock;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.sql.Date;

@Data
@TableName("stock_out_records")
public class StockOutRecords {
    @TableId(type = IdType.AUTO)
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
}
