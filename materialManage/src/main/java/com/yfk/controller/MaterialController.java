package com.yfk.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.yfk.common.lang.Result;
import com.yfk.common.lang.SystemCodeEnum;
import com.yfk.domain.Materials.*;
import com.yfk.service.*;
import lombok.extern.slf4j.Slf4j;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;


@Slf4j
@RestController
@RequestMapping("/material")
public class MaterialController {
    @Autowired
    MaterialAllService materialAllService;
    @Autowired
    MbCategoryService mbCategoryService;
    @Autowired
    MmCategoryService mmCategoryService;
    @Autowired
    MsCategoryService msCategoryService;
    @Autowired
    SupplierService supplierService;


    //初始化列表查询
    @GetMapping("/list")
    public Result materialList(@Param("currentPage") Integer currentPage, @Param("pageSize") Integer pageSize
    , @Param("mbCateId") Integer mbCateId, @Param("mmCateId") Integer mmCateId){
        if(currentPage == null || currentPage < 1) currentPage = 1;
        //log.info("物资列表请求=============>第{}页，每页{}条  {}  {}", currentPage, pageSize, mbCate, mmCate);
        QueryWrapper wrapper = new QueryWrapper<MaterialAll>();
        //处理数据
        if(mbCateId != 0){
            wrapper.eq("mb_code",mbCateId);
            if(mmCateId != 0)
                wrapper.eq("mm_code",mmCateId);
        }
        IPage page =new Page(currentPage,pageSize);
        IPage materialListData = materialAllService.page(page,wrapper);
        return Result.succeed(materialListData);
    }
    //材料列表模糊查询
    @GetMapping("/msCate/{msCategory}/{currentPage}/{pageSize}")
    public Result specificMsCategory(@PathVariable String msCategory, @PathVariable Integer currentPage,
                                     @PathVariable Integer pageSize){
        if(currentPage == null || currentPage < 1) currentPage = 1;
        log.info("物资查询=============>第{}页，每页{}条  模糊查询参数:{}", currentPage, pageSize, msCategory);
        QueryWrapper wrapper = new QueryWrapper<MaterialAll>();
        wrapper.like("ms_category",msCategory);
        IPage page =new Page(currentPage,pageSize);
        IPage materialListData = materialAllService.page(page,wrapper);
        return Result.succeed(materialListData);
    }
    //大类查询
    @GetMapping("/mbCategories")
    public Result mbCategories(){
        List<MbCategory> mbCategories = mbCategoryService.list();
        return Result.succeed(mbCategories);
    }
    //门类查询
    @GetMapping("/mmCategories/{mbCate}")
    public Result mmCategories(@PathVariable String mbCate){

        //门类信息
        QueryWrapper wrapper = new QueryWrapper<MmCategory>();
        wrapper.eq("mb_code",mbCate);
        List<MmCategory> mmCategories = mmCategoryService.list(wrapper);
        return Result.succeed(mmCategories);
    }
    //材料查询
    @GetMapping("/msCategories/{mmCate}")
    public Result getMsCategories(@PathVariable String mmCate){
        //获得门类对应编码
        QueryWrapper wrapper = new QueryWrapper<MmCategory>();
        wrapper.eq("mm_category",mmCate);
        MmCategory mmCategory = mmCategoryService.getOne(wrapper);
        wrapper.clear();

        //材料列表
        wrapper = new QueryWrapper<MsCategory>();
        wrapper.eq("mm_code",mmCategory.getMmCode());
        List<MsCategory> msCategories = msCategoryService.list(wrapper);
        return Result.succeed(msCategories);
    }
    //供应商查询
    @GetMapping("/suppliers")
    public Result getSuppliers(){
        List<Supplier> suppliers = supplierService.list();
        return Result.succeed(suppliers);
    }

    //材料注册
    @PutMapping("newMaterial")
    public Result addMaterial(@RequestBody MsCategory msCategory){
        //生成编号
        QueryWrapper wrapper = new QueryWrapper<MsCategory>();
        wrapper.eq("mm_code",msCategory.getMmCode());
        int total = msCategoryService.count(wrapper);
        msCategory.setMsCode(total+1+msCategory.getMmCode()*100);
        boolean result = msCategoryService.save(msCategory);
        if(result)
            return Result.succeed("材料添加成功");
        else
            return Result.fail(SystemCodeEnum.FAILURE,"材料添加失败");
    }

    @GetMapping("/msList")
    public Result getMsList(){
        return Result.succeed(msCategoryService.list());
    }
}
