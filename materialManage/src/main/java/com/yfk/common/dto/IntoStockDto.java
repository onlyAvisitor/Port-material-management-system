package com.yfk.common.dto;

import lombok.Data;

import java.io.Serializable;

@Data
public class IntoStockDto implements Serializable {
    //所属仓库
    private Integer depotId;
    //货架编号
    private String shelvesId;
    //本次占用数目
    private Integer occupied;
}
