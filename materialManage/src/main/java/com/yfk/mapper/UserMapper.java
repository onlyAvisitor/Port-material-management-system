package com.yfk.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.yfk.domain.User;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface UserMapper extends BaseMapper<User> {
}
