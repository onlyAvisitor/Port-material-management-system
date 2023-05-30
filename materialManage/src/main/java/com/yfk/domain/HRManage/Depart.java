package com.yfk.domain.HRManage;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;
import org.springframework.boot.autoconfigure.domain.EntityScan;

@Data
@TableName("depart_info")
@EntityScan
public class Depart {
    @TableId(value = "depart_no",type = IdType.INPUT)
    private String departNo;

    @TableField("depart_name")
    private String departName;

    @TableField("depart_describe")
    private String departDescribe;
}
