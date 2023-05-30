package com.yfk.domain.Materials;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

@Data
@TableName("mm_info")
public class MmCategory {
    private Integer id;

    @TableField("mm_code")
    private Integer mmCode;

    @TableField("mb_code")
    private Integer mbCode;

    @TableField("mm_Category")
    private String mmCategory;
}
