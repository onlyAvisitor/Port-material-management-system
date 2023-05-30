package com.yfk.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.yfk.domain.Subscribe.PlanDetail;
import com.yfk.mapper.Subscribe.planDetailMapper;
import com.yfk.service.PlanDetailService;
import org.springframework.stereotype.Service;

@Service
public class planDetailServiceImpl extends ServiceImpl<planDetailMapper, PlanDetail> implements PlanDetailService {
}
