package com.yfk.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.yfk.domain.Stock.StockOutApplication;
import com.yfk.mapper.Stock.StockOutApplicationMapper;
import com.yfk.service.StockOutApplicationService;
import org.springframework.stereotype.Service;

@Service
public class StockOutApplicationServiceImpl extends ServiceImpl<StockOutApplicationMapper, StockOutApplication> implements StockOutApplicationService {
}
