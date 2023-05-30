package com.yfk.domain.HRManage;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.sql.Date;

/**
* 用作员工登记
* */
@TableName("user_info")
@Data
public class UserRegis {
    @TableId(type = IdType.AUTO)
    private Integer id;

    private String username;

    private String password;

    private String phone;

    private boolean valid;

    @TableField("accesstime")
    private Date accessTime;

    @TableField("job_Id")
    private Integer jobId;

    public UserRegis(String username,String password,String phone,Integer jobId){
        this.username = username;
        this.jobId = jobId;
        this.password = password;
        this.phone = phone;

        /**
         * 自动生成
         */
        this.accessTime = new Date(System.currentTimeMillis());
        this.valid = true;
    }
}
