package com.yfk.domain.Stock;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

@Data
@TableName("stock_depot")
public class StockDepot {
    @TableId(type = IdType.AUTO)
    private Integer id;

    private Integer capacity;

    private Integer occupied;

    @TableField("mb_code")
    private Integer mbCode;

    private String unit;

    @TableField("manager_id")
    private Integer managerId;
}
