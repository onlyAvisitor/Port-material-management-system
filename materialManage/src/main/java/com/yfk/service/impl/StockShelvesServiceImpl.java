package com.yfk.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.yfk.common.dto.IntoStockDto;
import com.yfk.common.dto.OutStockDto;
import com.yfk.domain.Stock.StockShelves;
import com.yfk.mapper.Stock.StockShelvesMapper;
import com.yfk.service.StockShelvesService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class StockShelvesServiceImpl extends ServiceImpl<StockShelvesMapper,StockShelves> implements StockShelvesService {
    @Autowired
    StockShelvesMapper stockShelvesMapper;

    @Override
    public Boolean setIntoShelves(List<IntoStockDto> intoStockDtoList,Integer msCode) {
        for (IntoStockDto intoStockItem:intoStockDtoList) {
            if(!stockShelvesMapper.updateIntoShelves(intoStockItem.getOccupied(),msCode,intoStockItem.getShelvesId()))
                return false;
        }
        return true;
    }
    @Override
    public Boolean setOutShelves(List<OutStockDto> outStockDtoList) {
        for (OutStockDto outStockItem:outStockDtoList) {
            if(!stockShelvesMapper.updateOutShelves(outStockItem.getOutNumber(),outStockItem.getShelvesId()))
                return false;
        }
        return true;
    }
}
