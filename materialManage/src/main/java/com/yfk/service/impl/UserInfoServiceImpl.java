package com.yfk.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.yfk.domain.UserInfo;
import com.yfk.mapper.UserInfoMapper;
import com.yfk.service.UserInfoService;
import org.springframework.stereotype.Service;

@Service
public class UserInfoServiceImpl extends ServiceImpl<UserInfoMapper, UserInfo> implements UserInfoService {
}
