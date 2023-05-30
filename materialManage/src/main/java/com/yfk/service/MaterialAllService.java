package com.yfk.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.IService;
import com.yfk.domain.Materials.MaterialAll;

/**
 * 材料列表接口
 */
public interface MaterialAllService extends IService<MaterialAll> {
    //分页查询
    IPage<MaterialAll> getPage(int currentPage, int pageSize);
}
