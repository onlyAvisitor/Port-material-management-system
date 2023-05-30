package com.yfk.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.yfk.domain.Stock.StockIntoRecords;
import com.yfk.mapper.Stock.StockIntoRecordsMapper;
import com.yfk.service.StockIntoRecordsService;
import org.springframework.stereotype.Service;

@Service
public class StockIntoRecordsServiceImpl extends ServiceImpl<StockIntoRecordsMapper, StockIntoRecords> implements StockIntoRecordsService {
}
