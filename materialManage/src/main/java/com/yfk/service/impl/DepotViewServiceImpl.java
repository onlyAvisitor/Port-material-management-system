package com.yfk.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.yfk.domain.Stock.DepotView;
import com.yfk.mapper.Stock.DepotViewMapper;
import com.yfk.service.DepotViewService;
import org.springframework.stereotype.Service;

@Service
public class DepotViewServiceImpl extends ServiceImpl<DepotViewMapper, DepotView> implements DepotViewService {
}
