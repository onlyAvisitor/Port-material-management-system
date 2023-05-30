package com.yfk.domain;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.sql.Date;

/**
 * 实体类
 */

@Data
@TableName("user_job")
public class User {
    private Integer id;

    private String username;

    private  String password;

    private String phone;

    @TableField("accessTime")
    private Date accessTime;

    private boolean valid;

    @TableField("job_id")
    private Integer jobId;

    @TableField("job_name")
    private String jobName;

    @TableField("power_level")
    private Integer powerLevel;

    @TableField("depart_no")
    private String departNo;

    @TableField("depart_name")
    private String departName;

}
