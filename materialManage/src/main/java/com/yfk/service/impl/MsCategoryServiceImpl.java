package com.yfk.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.yfk.domain.Materials.MsCategory;
import com.yfk.mapper.Materials.MsCategoryMapper;
import com.yfk.service.MsCategoryService;
import org.springframework.stereotype.Service;

@Service
public class MsCategoryServiceImpl extends ServiceImpl<MsCategoryMapper, MsCategory> implements MsCategoryService {
}
