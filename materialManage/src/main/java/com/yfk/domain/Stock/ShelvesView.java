package com.yfk.domain.Stock;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

@Data
@TableName("shelves_view")
public class ShelvesView {
    private String id;

    @TableField("depot_id")
    private Integer depotId;

    private Integer capacity;

    private Integer occupied;

    @TableField("ms_code")
    private Integer msCode;

    @TableField("mb_code")
    private Integer mbCode;

    @TableField("ms_category")
    private String msCategory;

    private String unit;
}
