package com.yfk.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.yfk.domain.HRManage.UserRegis;
import com.yfk.mapper.HRManage.UserRegisMapper;
import com.yfk.service.UserRegisService;
import org.springframework.stereotype.Service;

@Service
public class UserRegisServiceImpl extends ServiceImpl<UserRegisMapper, UserRegis> implements UserRegisService {
}
