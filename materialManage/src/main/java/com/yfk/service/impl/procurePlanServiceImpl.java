package com.yfk.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.yfk.domain.Subscribe.ProcurePlan;
import com.yfk.mapper.Subscribe.procurePlanMapper;
import com.yfk.service.ProcurePlanService;
import org.springframework.stereotype.Service;

@Service
public class procurePlanServiceImpl extends ServiceImpl<procurePlanMapper, ProcurePlan> implements ProcurePlanService {
}
