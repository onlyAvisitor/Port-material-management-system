package com.yfk.service.impl;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.yfk.domain.Materials.MaterialAll;
import com.yfk.mapper.Materials.MaterialAllMapper;
import com.yfk.service.MaterialAllService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * 接口实现类  需使用Service注解
 */
@Service
public class MatarialAllServiceImpl extends ServiceImpl<MaterialAllMapper, MaterialAll> implements MaterialAllService {
    @Autowired
    MaterialAllMapper materialAllMapper;
    @Override
    public IPage<MaterialAll> getPage(int currentPage, int pageSize) {
        IPage page = new Page(currentPage,pageSize);
        materialAllMapper.selectPage(page,null);
        return page;
    }
}
