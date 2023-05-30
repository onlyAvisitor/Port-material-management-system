package com.yfk.domain.Subscribe;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.sql.Date;

@Data
@TableName("procure_plan")
public class ProcurePlan {
    @TableId(value="plan_id",type = IdType.INPUT)
    private String planId;

    @TableField("release_time")
    private Date releaseTime;

    @TableField("plan_class")
    private String planClass;

    @TableField("user_id")
    private Integer userId;

    @TableField("user_name")
    private String userName;

    @TableField("plan_describe")
    private String planDescribe;

    public ProcurePlan(String planClass,Integer userId,String userName,String describe){
        this.setPlanClass(planClass);
        this.setUserId(userId);
        this.setUserName(userName);
        this.setPlanDescribe(describe);
        this.releaseTime = new Date(System.currentTimeMillis());
    }
    public ProcurePlan() {

    }
}
