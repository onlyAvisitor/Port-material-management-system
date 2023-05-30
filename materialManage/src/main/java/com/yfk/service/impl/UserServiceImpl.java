package com.yfk.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.yfk.domain.User;
import com.yfk.mapper.UserMapper;
import com.yfk.service.UserService;
import org.springframework.stereotype.Service;

/**
 * 接口实现类  需使用Service注解
 */
@Service
public class UserServiceImpl extends ServiceImpl<UserMapper, User> implements UserService {

}
