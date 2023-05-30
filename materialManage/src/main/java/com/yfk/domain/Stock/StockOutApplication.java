package com.yfk.domain.Stock;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.sql.Date;

@Data
@TableName("stock_out_application")
public class StockOutApplication {
    @TableId(type= IdType.ASSIGN_ID)
    private String id;

    @TableField("application_time")
    private Date applicationTime;

    @TableField("application_user_id")
    private Integer applicationUserId;

    @TableField("ms_code")
    private Integer msCode;

    @TableField("ms_category")
    private String msCategory;

    @TableField("out_number")
    private Integer outNumber;

    @TableField("purpose_of_use")
    private String purposeOfUse;

    @TableField("machine_id")
    private Integer machineId;

    @TableField("outbound_state")
    private Boolean outboundState;

    @TableField("audit_level")
    private Integer auditLevel;

    @TableField("depart_no")
    private String departNo;
}
