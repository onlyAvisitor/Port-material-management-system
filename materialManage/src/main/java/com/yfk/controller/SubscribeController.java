package com.yfk.controller;

import cn.hutool.core.date.DateUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.yfk.common.lang.Result;
import com.yfk.common.lang.SystemCodeEnum;
import com.yfk.domain.Subscribe.DetailInfo;
import com.yfk.domain.Subscribe.PlanDetail;
import com.yfk.domain.Subscribe.ProcurePlan;
import com.yfk.service.DetailInfoService;
import com.yfk.service.PlanDetailService;
import com.yfk.service.ProcurePlanService;
import lombok.extern.slf4j.Slf4j;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.sql.Date;
import java.util.List;


@Slf4j
@RestController
@RequestMapping("/subscribe")
public class SubscribeController {
    @Autowired
    PlanDetailService planDetailService;
    @Autowired
    ProcurePlanService procurePlanService;
    @Autowired
    DetailInfoService detailInfoService;
    //审核批准/驳回
    @PatchMapping("planAudit")
    public Result orderRatify(@Param("detailId")Integer detailId,@Param("powerLevel") Integer powerLevel){
        UpdateWrapper wrapper = new UpdateWrapper<PlanDetail>();
        wrapper.eq("id",detailId);
        wrapper.set("audit_level",powerLevel);
        boolean result = planDetailService.update(wrapper);
        if(result){
            return Result.succeed("");
        }else{
            return Result.fail(SystemCodeEnum.FAILURE);
        }
    }

    /**
     *
     * @param planDetailList
     * @param planClass
     * @param userName
     * @param userId
     * @param describe
     * @return
     */
    @PostMapping("/planSubmit")
    public Result planSubmit(@RequestBody List<PlanDetail> planDetailList,
    @RequestParam("planClass") String planClass,@RequestParam("userName") String userName,
    @RequestParam("userId") Integer userId,@RequestParam("describe") String describe){
        //采购计划
        ProcurePlan procurePlan = new ProcurePlan(planClass,userId,userName,describe);
        //判断计划类型
        String today = DateUtil.today().replace("-","");
        QueryWrapper wrapper = new QueryWrapper<ProcurePlan>();
        wrapper.like("plan_id",today);
        int total = procurePlanService.count(wrapper);
        String planHeader="";
        if(planClass.equals("月度计划")){
            planHeader="month";
        }else if(planClass.equals("日常缺额")){
            planHeader="daily";
        }else if(planClass.equals("紧急需求")){
            planHeader="urgent";
        }else{
            return Result.fail(SystemCodeEnum.FAILURE,"请求计划类型错误");
        }
        String planId = planHeader+today+String.format("%02d",total+1);
        procurePlan.setPlanId(planId);
        //计划明细
        for (PlanDetail planDetail:planDetailList) {
            planDetail.setPlanId(planId);
        }
        //表结构更新
        //计划插入
        boolean result = procurePlanService.save(procurePlan);
        if(result){
            planDetailService.saveBatch(planDetailList);
        }
        return Result.succeed("您的申购计划已提交，审核进度请查看审核信息");
    }

    /**
     *
     * @param month
     * @param planClass
     * @return
     */
    @GetMapping("/planList")
    public Result getPlanList(@RequestParam("month") String month, @RequestParam("planClass") String planClass){
        //时间格式转化
        java.util.Date dateTime = DateUtil.parse(month);
        String date = DateUtil.formatDate(dateTime);
        QueryWrapper wrapper = new QueryWrapper<ProcurePlan>();
        if(!planClass.equals("所有")){
            wrapper.eq("plan_class",planClass);
        }
        String planId = date.substring(0,7).replace("-","");
        wrapper.like("plan_id",planId);
        List<ProcurePlan> procurePlanList = procurePlanService.list(wrapper);
        return Result.succeed(procurePlanList);
    }
    @GetMapping("/allPlanList")
    public Result getAllPlanList(){
        //时间格式转化
        QueryWrapper wrapper = new QueryWrapper<ProcurePlan>();
        wrapper.orderByDesc("release_time");
        List<ProcurePlan> allPlanList = procurePlanService.list(wrapper);
        return Result.succeed(allPlanList);
    }
    /**
     * 计划明细
     */
    @GetMapping("planDetails")
    public Result getPlanDetails(@RequestParam("planId") String planId){
        QueryWrapper wrapper = new QueryWrapper<DetailInfo>();
        wrapper.eq("plan_id",planId);
        List<PlanDetail> planDetails = detailInfoService.list(wrapper);
        return Result.succeed(planDetails);
    }

    /**
     * 追加
     * @param planDetails
     * @param planId
     * @return
     */
    @PostMapping("addPlanDetails")
    public Result addPlanDetails(@RequestBody List<PlanDetail> planDetails,@RequestParam("planId") String planId){
        for (PlanDetail planDetail:planDetails) {
            planDetail.setPlanId(planId);
        }
        planDetailService.saveBatch(planDetails);
        return Result.succeed("您的申请已提交，请耐心等待审核");
    }
    /**
     * 待采购物资列表
     */
    @GetMapping("purchaseItems")
    public Result getPurchaseItems(){
        QueryWrapper wrapper = new QueryWrapper<DetailInfo>();

        wrapper.eq("audit_level",1);
        wrapper.eq("procure_state",false);

        List<DetailInfo> detailInfoList = detailInfoService.list(wrapper);
        wrapper.clear();
        return Result.succeed(detailInfoList);
    }

    /**
     *
     * @param detailId
     * @param userId
     * @param supplierId
     * @param actualPrice
     * @return
     */
    @PatchMapping("/purchaseInfoSubmit")
    public Result UpdatePurchaseInfo(
        @RequestParam("detailId") Integer detailId,@RequestParam("userId") Integer userId,
        @RequestParam("supplierId") Integer supplierId,@RequestParam("actualPrice") Float actualPrice){
        UpdateWrapper wrapper = new UpdateWrapper<PlanDetail>();
        wrapper.eq("id",detailId);
        wrapper.set("user_id",userId);
        wrapper.set("actual_price",actualPrice);
        wrapper.set("supplier_id",supplierId);
        wrapper.set("procure_state",true);
        wrapper.set("procure_date",new Date(System.currentTimeMillis()));

        boolean result = planDetailService.update(wrapper);
        if(result)
            return Result.succeed("采购信息已提交！");
        else
            return Result.fail(SystemCodeEnum.FAILURE,"采购信息提交失败");
    }
}
