package com.yfk.domain.Materials;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

@Data
@TableName("mb_info")
public class MbCategory {
    private Integer id;

    @TableField("mb_code")
    private Integer mbCode;

    @TableField("mb_category")
    private String mbCategory;
}
