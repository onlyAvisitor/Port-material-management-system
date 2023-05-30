package com.yfk.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.yfk.domain.Materials.MmCategory;
import com.yfk.mapper.Materials.MmCategoryMapper;
import com.yfk.service.MmCategoryService;
import org.springframework.stereotype.Service;

@Service
public class MmCategoryServiceImpl extends ServiceImpl<MmCategoryMapper, MmCategory> implements MmCategoryService{
}
