package com.yfk.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.yfk.domain.Stock.StockDepot;
import com.yfk.mapper.Stock.StockDepotMapper;
import com.yfk.service.StockDepotService;
import org.springframework.stereotype.Service;

@Service
public class StockDepotServiceImpl extends ServiceImpl<StockDepotMapper, StockDepot> implements StockDepotService {
}
