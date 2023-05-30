package com.yfk.domain.Stock;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

@Data
@TableName("stock_shelves")
public class StockShelves {
    @TableId(type = IdType.INPUT)
    private String id;

    @TableField("depot_id")
    private Integer depotId;

    private Integer capacity;

    private Integer occupied;

    @TableField("ms_code")
    private Integer msCode;

    @TableField(exist = false)
    private Integer sumOccupied;
}
