package com.yfk.common.dto;

import lombok.Data;

@Data
public class OutStockDto {
    //所属仓库
    private Integer depotId;
    //货架编号
    private String shelvesId;
    //出库量
    private Integer outNumber;
}
