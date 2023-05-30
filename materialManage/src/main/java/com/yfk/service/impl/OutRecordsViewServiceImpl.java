package com.yfk.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.yfk.domain.Stock.OutRecordsView;
import com.yfk.mapper.Stock.OutRecordsViewMapper;
import com.yfk.service.OutRecordsViewService;
import org.springframework.stereotype.Service;

@Service
public class OutRecordsViewServiceImpl extends ServiceImpl<OutRecordsViewMapper, OutRecordsView> implements OutRecordsViewService {
}
