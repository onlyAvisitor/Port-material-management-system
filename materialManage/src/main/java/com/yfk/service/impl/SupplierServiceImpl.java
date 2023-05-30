package com.yfk.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.yfk.domain.Materials.Supplier;
import com.yfk.mapper.Materials.SupplierMapper;
import com.yfk.service.SupplierService;
import org.springframework.stereotype.Service;

@Service
public class SupplierServiceImpl extends ServiceImpl<SupplierMapper, Supplier> implements SupplierService {
}
