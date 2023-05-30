package com.yfk.domain.HRManage;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;
import org.springframework.boot.autoconfigure.domain.EntityScan;

@Data
@TableName("job_info")
@EntityScan
public class Job {
    @TableId(type = IdType.AUTO)
    private Integer id;

    @TableField("depart_no")
    private String departNo;

    @TableField("job_name")
    private String jobName;

    @TableField("power_level")
    private String powerLevel;

    @TableField("job_describe")
    private String jobDescribe;
}
