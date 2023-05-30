package com.yfk.domain.Stock;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

@Data
@TableName("depot_view")
public class DepotView {
    private Integer id;

    private Integer capacity;

    private Integer occupied;

    @TableField("mb_code")
    private Integer mbCode;

    private String unit;

    @TableField("manager_id")
    private Integer managerId;

    private String username;

    @TableField("mb_category")
    private String mbCategory;
}
