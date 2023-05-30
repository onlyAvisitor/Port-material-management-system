package com.yfk.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.yfk.domain.Materials.MbCategory;
import com.yfk.mapper.Materials.MbCategoryMapper;
import com.yfk.service.MbCategoryService;
import org.springframework.stereotype.Service;

@Service
public class MbCategoryServiceImpl extends ServiceImpl<MbCategoryMapper, MbCategory> implements MbCategoryService {
}
