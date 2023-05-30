package com.yfk.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.yfk.domain.Subscribe.DetailInfo;
import com.yfk.mapper.Subscribe.DetailInfoMapper;
import com.yfk.service.DetailInfoService;
import org.springframework.stereotype.Service;

@Service
public class DetailInfoServiceImpl extends ServiceImpl<DetailInfoMapper, DetailInfo> implements DetailInfoService {
}
