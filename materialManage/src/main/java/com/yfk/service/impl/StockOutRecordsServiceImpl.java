package com.yfk.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.yfk.domain.Stock.StockOutRecords;
import com.yfk.mapper.Stock.StockOutRecordsMapper;
import com.yfk.service.StockOutRecordsService;
import org.springframework.stereotype.Service;

@Service
public class StockOutRecordsServiceImpl extends ServiceImpl<StockOutRecordsMapper, StockOutRecords> implements StockOutRecordsService {
}
