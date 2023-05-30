package com.yfk.controller;

import cn.hutool.core.date.DateUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.yfk.common.dto.IntoStockDto;
import com.yfk.common.dto.OutStockDto;
import com.yfk.common.lang.Result;
import com.yfk.common.lang.SystemCodeEnum;
import com.yfk.domain.Stock.*;
import com.yfk.domain.Subscribe.DetailInfo;
import com.yfk.domain.Subscribe.PlanDetail;
import com.yfk.service.*;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.Date;
import java.util.List;

@Slf4j
@RestController
@RequestMapping("/stock")
public class StockController {
    @Autowired
    StockOutRecordsService stockOutRecordsService;
    @Autowired
    DepotViewService depotViewService;

    @Autowired
    ShelvesViewService shelvesViewService;

    @Autowired
    DetailInfoService detailInfoService;

    @Autowired
    StockShelvesService stockShelvesService;

    @Autowired
    StockDepotService stockDepotService;

    @Autowired
    StockIntoRecordsService stockIntoRecordsService;

    @Autowired
    PlanDetailService planDetailService;

    @Autowired
    IntoRecordsViewService intoRecordsViewService;

    @Autowired
    StockOutApplicationService stockOutApplicationService;

    @Autowired
    OutRecordsViewService outRecordsViewService;
    /**
     * 获取仓库信息
     */
    @GetMapping("depotList")
    public Result getDepotList(){
        List<DepotView> depotViewList = depotViewService.list();
        return Result.succeed(depotViewList);
    }

    /**
     * 获取货架信息
     */
    @GetMapping("shelvesList")
    public Result getShelvesList(@RequestParam("depotId") Integer depotId){
        QueryWrapper wrapper = new QueryWrapper<ShelvesView>();
        wrapper.eq("depot_id",depotId);
        wrapper.orderByAsc("id");
        List<ShelvesView> shelvesViewList = shelvesViewService.list(wrapper);
        return Result.succeed(shelvesViewList);
    }
    /**
     * 获取待入库物资列表
     */
    @GetMapping("intoStocks")
    public Result getIntoStocks(){
        QueryWrapper wrapper = new QueryWrapper<DetailInfo>();
        //未入库
        wrapper.eq("stock_state",false);
        //已采购
        wrapper.eq("procure_state",true);

        List<DetailInfo> intoStocks = detailInfoService.list(wrapper);

        wrapper.clear();
        return Result.succeed(intoStocks);
    }
    /**
     * 可用货架
     */
    @GetMapping("/getShelvesByMsCode")
    public Result getShelvesByMsCode(@RequestParam("msCode") Integer msCode){
        Integer mbCode = msCode/10000;
        //查询存放该大类货物的货架区，且货架为空或存放对应货物
        List<ShelvesView> shelvesList = shelvesViewService.getShelvesByMsCode(mbCode,msCode);
        return Result.succeed(shelvesList);
    }
    /**
     *存放特定货物货架，用于出库
     */
    @GetMapping("/getShelvesEqMsCode")
    public Result getShelvesEqMsCode(@RequestParam("msCode") Integer msCode){
        QueryWrapper wrapper = new QueryWrapper<ShelvesView>();
        wrapper.eq("ms_code",msCode);
        //查询存放该大类货物的货架区，且货架为空或存放对应货物
        List<ShelvesView> shelvesList = shelvesViewService.list(wrapper);
        return Result.succeed(shelvesList);
    }
    /**
     * 物资入库 需要生成入库记录
     * 修改计划明细入库状态
     * 修改货架状态
     * 生成入账单 交由财务部查看审核
     */
    @PostMapping("dealIntoStocks")
    public Result dealIntoStocks(@RequestBody List<IntoStockDto> intoStockDtoList,
    @RequestParam("msCode") Integer msCode,@RequestParam("detailId") Integer detailId,
    @RequestParam("intoSum") Integer intoSum,@RequestParam("userId") Integer userId){
        //修改货架
        stockShelvesService.setIntoShelves(intoStockDtoList,msCode);
        //更新仓库
        UpdateStockDepot();
        //修改计划明细表
        UpdateWrapper updateWrapper = new UpdateWrapper<PlanDetail>();
        updateWrapper.eq("id",detailId);
        updateWrapper.set("stock_state",true);
        planDetailService.update(updateWrapper);
        //生成入库记录
        String records = "";
        for (IntoStockDto intoStockItem:intoStockDtoList) {
            records = records + intoStockItem.getDepotId() + ","+ intoStockItem.getShelvesId() +"," +intoStockItem.getOccupied()+";";
        }
        StockIntoRecords stockIntoRecords = new StockIntoRecords(detailId,userId,intoSum,msCode,records);
        if(stockIntoRecordsService.save(stockIntoRecords)) {
            /**
             * 生成账务信息
             */
            return Result.succeed("物资入库成功！");
        }
        return Result.fail(SystemCodeEnum.FAILURE);
    }

    /**
     * 更新库存信息
     */
    public void UpdateStockDepot(){
        List<StockDepot> stockDepots = stockDepotService.list();
        for(StockDepot stockDepot:stockDepots){
            //获得该仓库库存信息
            QueryWrapper queryWrapper = new QueryWrapper<StockShelves>();
            queryWrapper.select("sum(occupied) as sumOccupied");
            queryWrapper.eq("depot_id",stockDepot.getId());
            StockShelves stockShelves = stockShelvesService.getOne(queryWrapper);
            if(stockShelves!=null) {
                //更新库存
                UpdateWrapper updateWrapper = new UpdateWrapper<StockDepot>();
                updateWrapper.eq("id", stockDepot.getId());
                updateWrapper.set("occupied", stockShelves.getSumOccupied());
                stockDepotService.update(updateWrapper);
            }
        }
    }
    /**
     * 更新货架
     */
    public void UpdateStockShelves(List<OutStockDto> outStockDtoList){
        List<StockShelves> stockShelvesList = stockShelvesService.list();
        for(OutStockDto outStock:outStockDtoList){
            //若货架为空，清除掉物资标记
            QueryWrapper queryWrapper = new QueryWrapper<StockShelves>();
            queryWrapper.eq("id",outStock.getShelvesId());
            StockShelves shelves = stockShelvesService.getOne(queryWrapper);
            if(shelves.getOccupied() == 0){
                UpdateWrapper updateWrapper = new UpdateWrapper<StockShelves>();
                updateWrapper.eq("id",shelves.getId());
                updateWrapper.set("ms_code",null);
                stockShelvesService.update(updateWrapper);
            }
        }
    }
    /**
     * 入库记录
     * @param month
     * @param mbCode
     * @return
     */
    @GetMapping("intoStockRecords")
    public Result getIntoStockRecords(@RequestParam("month") String month,@RequestParam("mbCode") String mbCode){
        //时间格式转化
        java.util.Date dateTime = DateUtil.parse(month);
        String date = DateUtil.formatDate(dateTime);
        date = date.substring(0,7);
        QueryWrapper wrapper = new QueryWrapper<IntoRecordsView>();
        wrapper.like("generate_time",date);
        if(!mbCode.equals("all")){
            wrapper.like("mb_code",mbCode);
        }
        wrapper.orderByDesc("generate_time");
        List<IntoRecordsView> intoRecords = intoRecordsViewService.list(wrapper);

        return Result.succeed(intoRecords);
    }
    @GetMapping("allIntoStockRecords")
    public Result getAllIntoStockRecords(){
        QueryWrapper wrapper = new QueryWrapper<IntoRecordsView>();
        wrapper.orderByDesc("generate_time");
        List<IntoRecordsView> intoRecords = intoRecordsViewService.list(wrapper);
        return Result.succeed(intoRecords);
    }

    /**
     * 查看物资库存量
     * @param msCode
     * @return
     */
    @GetMapping("getMsBalance")
    public Result getMsBalanceByMsCode(@RequestParam("msCode") Integer msCode){
        QueryWrapper wrapper = new QueryWrapper<StockShelves>();
        wrapper.eq("ms_code",msCode);
        wrapper.select("sum(occupied) as sumOccupied");
        StockShelves stockShelves = stockShelvesService.getOne(wrapper);
        if(stockShelves == null){
            return Result.succeed("",0);
        }
        return Result.succeed("",stockShelves.getSumOccupied());
    }

    /**
     * 提交出库申请
     * @param stockOutApplications
     * @param submitDate
     * @param departNo
     * @param applicationUserId
     * @param auditLevel
     * @return
     */
    @PostMapping("stockOutApplication")
    public Result dealStockOutApplication(@RequestBody List<StockOutApplication> stockOutApplications,
        @RequestParam("submitDate") String submitDate,@RequestParam("departNo") String departNo,
        @RequestParam("applicationUserId") Integer applicationUserId,
        @RequestParam("auditLevel") Integer auditLevel){
        Date date = DateUtil.parse(submitDate);
        java.sql.Date applicationTime = new java.sql.Date(date.getTime());
        for (StockOutApplication stockOutApplication:stockOutApplications){
            stockOutApplication.setDepartNo(departNo);
            stockOutApplication.setApplicationUserId(applicationUserId);
            stockOutApplication.setApplicationTime(applicationTime);
            stockOutApplication.setAuditLevel(auditLevel);
        }
        stockOutApplicationService.saveBatch(stockOutApplications);
        return Result.succeed("申请已提交");
    }

    /**
     * 获取出库申请列表
     * @param auditState
     * @param submitTime
     * @return
     */
    @GetMapping("getStockOutApplications")
    public Result getStockOutApplications(@RequestParam("auditState") Integer auditState,@RequestParam("submitTime") String submitTime){
        java.util.Date dateTime = DateUtil.parse(submitTime);
        String date = DateUtil.formatDate(dateTime);
        date = date.substring(0,7);
        QueryWrapper wrapper = new QueryWrapper<StockOutApplication>();
        if(auditState == 1){//未审核
            wrapper.gt("audit_level",1);
        }else if(auditState == 2){//已审核
            wrapper.eq("audit_level",1);
        }
        wrapper.like("application_time",date);
        List<StockOutApplication> stockOutApplications = stockOutApplicationService.list(wrapper);
        return Result.succeed(stockOutApplications);
    }

    /**
     * 出库审核
     * @param id
     * @param auditLevel
     * @return
     */
    @PatchMapping("checkStockOutApplication")
    public Result checkStockOutApplication(@RequestParam("id") String id,@RequestParam("auditLevel") Integer auditLevel){
        UpdateWrapper wrapper = new UpdateWrapper<StockOutApplication>();
        wrapper.eq("id",id);
        wrapper.set("audit_level",auditLevel);
        stockOutApplicationService.update(wrapper);
        if(auditLevel == 1) {
            return Result.succeed("申请" + id + "已通过审核");
        }else if(auditLevel == 2){
            return Result.succeed("申请" + id + "已通过初次审核");
        }else{
            return Result.succeed("申请" + id + "已驳回");
        }
    }

    /**
     * 获取待出库物资列表
     * @return
     */
    @GetMapping("getMaterialsToBeOut")
    public Result getMaterialsToBeOutList(){
        QueryWrapper wrapper = new QueryWrapper<StockOutApplication>();
        wrapper.eq("audit_level",1);
        wrapper.eq("outbound_state",false);

        List<StockOutApplication> stockOutApplications = stockOutApplicationService.list(wrapper);
        return Result.succeed(stockOutApplications);
    }

    /**
     * 出库信息处理，生成出库记录  更新货架以及对应仓库，更新出库申请状态
     * @param outStockDtoList
     * @param applicationId
     * @param outNumber
     * @param msCode
     * @param handlerId
     * @return
     */
    @PostMapping("dealOutStockInfo")
    public Result dealOutStockInfo(@RequestBody List<OutStockDto> outStockDtoList,@RequestParam("applicationId") String applicationId,
    @RequestParam("outNumber") Integer outNumber,@RequestParam("msCode") Integer msCode,@RequestParam("handlerId") Integer handlerId){
        //出库设置
        stockShelvesService.setOutShelves(outStockDtoList);
        //更新货架
        UpdateStockShelves(outStockDtoList);
        //更新仓库
        UpdateStockDepot();
        //更新出库申请表
        UpdateWrapper wrapper = new UpdateWrapper<StockOutApplication>();
        wrapper.eq("id",applicationId);
        wrapper.set("outbound_state",true);
        stockOutApplicationService.update(wrapper);
        String records = "";
        for (OutStockDto outStockItem:outStockDtoList) {
            records = records + outStockItem.getDepotId() + "号仓库,"+ outStockItem.getShelvesId() +"号货架,出库" +outStockItem.getOutNumber()+"单位;";
        }
        //生成出库记录
        StockOutRecords record = new StockOutRecords();
        record.setMsCode(msCode);
        record.setApplicationId(applicationId);
        record.setOutStockTime(new java.sql.Date(System.currentTimeMillis()));
        record.setOutNumber(outNumber);
        record.setRecorderId(handlerId);
        record.setStockRecords(records);
        if(stockOutRecordsService.save(record)){
            return Result.succeed("出库信息提交成功");
        }
        return Result.fail(SystemCodeEnum.FAILURE,"信息提交失败");
    }
    /**
     * 获取出库记录
     */
    @GetMapping("getOutStockRecords")
    public Result getOutStockRecords(@RequestParam("outTime") String outTime){
        java.util.Date dateTime = DateUtil.parse(outTime);
        String date = DateUtil.formatDate(dateTime);
        date = date.substring(0,7);
        QueryWrapper wrapper = new QueryWrapper<OutRecordsView>();
        wrapper.like("out_stock_time",date);
        List<OutRecordsView>  outRecordsViews= outRecordsViewService.list(wrapper);
        return Result.succeed(outRecordsViews);
    }
    @GetMapping("getAllOutStockRecords")
    public Result getOutStockRecords(){
        QueryWrapper wrapper = new QueryWrapper<OutRecordsView>();
        wrapper.orderByDesc("out_stock_time");
        List<OutRecordsView>  outRecordsViews= outRecordsViewService.list();
        return Result.succeed(outRecordsViews);
    }
}
