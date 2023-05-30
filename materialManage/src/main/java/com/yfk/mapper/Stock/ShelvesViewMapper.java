package com.yfk.mapper.Stock;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.yfk.domain.Stock.ShelvesView;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;

@Mapper
public interface ShelvesViewMapper extends BaseMapper<ShelvesView> {
    @Select("Select * From shelves_view Where occupied < capacity and mb_code=#{mbCode} and (ms_code IS NULL or ms_code = #{msCode})")
    List<ShelvesView> getShelvesByMsCode(Integer mbCode,Integer msCode);
}
