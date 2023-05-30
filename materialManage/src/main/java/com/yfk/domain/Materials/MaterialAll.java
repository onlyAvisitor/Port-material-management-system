package com.yfk.domain.Materials;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

@Data
@TableName("material_view")
public class MaterialAll {
    private Integer id;

    @TableField("ms_code")
    private Integer msCode;

    @TableField("mb_code")
    private Integer mbCode;

    @TableField("mm_code")
    private Integer mm_code;

    @TableField("mb_category")
    private String mbCategory;

    @TableField("mm_category")
    private String mmCategory;

    @TableField("ms_category")
    private String msCategory;
}
