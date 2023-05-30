package com.yfk.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.yfk.domain.Stock.ShelvesView;

import java.util.List;

public interface ShelvesViewService extends IService<ShelvesView> {
    List<ShelvesView> getShelvesByMsCode(Integer mbCode,Integer msCode);
}
