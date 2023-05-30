package com.yfk.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.yfk.domain.HRManage.Depart;
import com.yfk.mapper.HRManage.DepartMapper;
import com.yfk.service.DepartService;
import org.springframework.stereotype.Service;

@Service
public class DepartServiceImpl extends ServiceImpl<DepartMapper, Depart> implements DepartService{
}
