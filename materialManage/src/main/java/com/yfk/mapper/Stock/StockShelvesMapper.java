package com.yfk.mapper.Stock;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.yfk.domain.Stock.StockShelves;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Update;

@Mapper
public interface StockShelvesMapper extends BaseMapper<StockShelves> {
    @Update("Update stock_shelves Set occupied = occupied + #{occupied},ms_code = #{msCode} WHERE id = #{id}")
    Boolean updateIntoShelves(Integer occupied,Integer msCode,String id);

    @Update("Update stock_shelves Set occupied = occupied - #{outNumber} WHERE id = #{id}")
    Boolean updateOutShelves(Integer outNumber,String id);
}
