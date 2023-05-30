package com.yfk.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.yfk.common.dto.IntoStockDto;
import com.yfk.common.dto.OutStockDto;
import com.yfk.domain.Stock.StockShelves;

import java.util.List;

public interface StockShelvesService extends IService<StockShelves> {
    Boolean setIntoShelves(List<IntoStockDto> intoStockDtoList,Integer msCode);
    Boolean setOutShelves(List<OutStockDto> outStockDtoList);
}
