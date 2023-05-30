package com.yfk.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.yfk.domain.Stock.IntoRecordsView;
import com.yfk.mapper.Stock.IntoRecordsViewMapper;
import com.yfk.service.IntoRecordsViewService;
import org.springframework.stereotype.Service;

@Service
public class IntoRecordsViewServiceImpl extends ServiceImpl<IntoRecordsViewMapper, IntoRecordsView> implements IntoRecordsViewService {
}
