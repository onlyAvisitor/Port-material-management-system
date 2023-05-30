package com.yfk.mapper.HRManage;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.yfk.domain.HRManage.Depart;
import org.apache.ibatis.annotations.Mapper;
import org.mybatis.spring.annotation.MapperScan;

@Mapper
public interface DepartMapper extends BaseMapper<Depart> {
}
