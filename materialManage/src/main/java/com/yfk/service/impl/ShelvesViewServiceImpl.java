package com.yfk.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.yfk.domain.Stock.ShelvesView;
import com.yfk.mapper.Stock.ShelvesViewMapper;
import com.yfk.service.ShelvesViewService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ShelvesViewServiceImpl extends ServiceImpl<ShelvesViewMapper, ShelvesView> implements ShelvesViewService {
    @Autowired
    ShelvesViewMapper shelvesViewMapper;
    @Override
    public List<ShelvesView> getShelvesByMsCode(Integer mbCode, Integer msCode) {
        return shelvesViewMapper.getShelvesByMsCode(mbCode,msCode);
    }
}
