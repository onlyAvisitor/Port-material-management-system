package com.yfk.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.yfk.domain.UserInfo;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface UserInfoMapper extends BaseMapper<UserInfo> {
}
