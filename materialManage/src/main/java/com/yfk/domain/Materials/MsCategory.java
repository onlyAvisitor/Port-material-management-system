package com.yfk.domain.Materials;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

@Data
@TableName("ms_info")
public class MsCategory {
    @TableId(type = IdType.AUTO)
    private Integer id;

    @TableField("ms_code")
    private Integer msCode;

    @TableField("mm_code")
    private Integer mmCode;

    @TableField("ms_category")
    private String msCategory;

    @TableField("quantity_unti")
    private String quantityUnit;

    private Float fob;
}
