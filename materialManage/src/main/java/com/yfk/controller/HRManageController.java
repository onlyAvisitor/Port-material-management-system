package com.yfk.controller;

import cn.hutool.crypto.SecureUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.yfk.common.dto.regisDto;
import com.yfk.common.lang.Result;
import com.yfk.common.lang.SystemCodeEnum;
import com.yfk.domain.HRManage.Depart;
import com.yfk.domain.HRManage.Job;
import com.yfk.domain.HRManage.UserRegis;
import com.yfk.domain.User;
import com.yfk.domain.UserInfo;
import com.yfk.service.*;
import lombok.extern.slf4j.Slf4j;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@Slf4j
@RequestMapping("HRManage")
public class HRManageController {
    @Autowired
    DepartService departService;

    @Autowired
    JobService jobService;

    @Autowired
    UserService userService;

    @Autowired
    UserInfoService userInfoService;

    @Autowired
    UserRegisService userRegisService;
    //部门列表
    @GetMapping("/departments")
    public Result getDepartments(){
        List<Depart> departList = departService.list();
        return Result.succeed(departList);
    }
    //工作列表
    @GetMapping("jobs")
    public Result getJobsbyDepartNo(@RequestParam("departNo") String departNo){
        QueryWrapper wrapper = new QueryWrapper<Job>();
        wrapper.eq("depart_no",departNo);
        List<Job> jobList = jobService.list(wrapper);
        return Result.succeed(jobList);
    }
    //用户列表
    @GetMapping("/users")
    public Result getUsers(@RequestParam("departNo") String departNo, @RequestParam("jobId") Integer jobId,
                           @RequestParam("currentPage") Integer currentPage){
        QueryWrapper wrapper = new QueryWrapper<User>();
        //部门条件
        if(departNo.equals("all")){
            log.info("部门查询------->所有部门");
        }else{
            wrapper.eq("depart_no",departNo);
            log.info("部门查询------>部门编号:{}",departNo);
        }
        //职位条件
        if(jobId != 0){
            wrapper.eq("job_id",jobId);
        }
        //在职员工
        wrapper.eq("valid",1);
        IPage page =new Page(currentPage,10);
        IPage userList = userInfoService.page(page,wrapper);
        return Result.succeed(userList);
    }
    @GetMapping("getAllUsers")
    public Result getAllUsers(){
        QueryWrapper wrapper = new QueryWrapper<User>();
        //在职员工
        wrapper.orderByDesc("accessTime");
        wrapper.eq("valid",1);
        List<User> userList = userService.list(wrapper);
        return Result.succeed(userList);
    }
    //根据jobId得到用户列表
    @GetMapping("/usersByJob")
    public Result getUsersByJob(@Param("jobId") Integer jobId){
        QueryWrapper wrapper = new QueryWrapper<UserInfo>();
        wrapper.eq("job_id",jobId);
        List<UserInfo> userInfoList = userInfoService.list(wrapper);
        return Result.succeed(userInfoList);
    }
    @GetMapping("/user")
    public Result getUser(@RequestParam("departId") String departId,@RequestParam("jobId") Integer jobId,@RequestParam("username") String username){
        QueryWrapper wrapper = new QueryWrapper<UserInfo>();
        if(departId != null){
            wrapper.eq("depart_no",departId);
        }
        if(jobId != null){
            wrapper.eq("job_id",jobId);
        }
        if(username != null){
            wrapper.eq("username",username);
        }
        UserInfo userInfo = userInfoService.getOne(wrapper);
        return Result.succeed(userInfo);
    }
    //用户注册
    @PutMapping("/employeeRegis")
    public Result employeeRegis(@RequestBody regisDto user){
        UserRegis userRegis = new UserRegis(user.getUsername(), SecureUtil.md5(user.getPassword()),user.getPhone(),user.getJobId());
        boolean result = userRegisService.save(userRegis);
        if(result) {
            return Result.succeed("登记成功");
        }else
            return Result.fail(SystemCodeEnum.FAILURE);
    }
    //员工职位变迁
    @PatchMapping("/jobChange")
    public Result jobChange(@Param("userId") Integer userId,@Param("jobId") Integer jobId){
        UpdateWrapper wrapper = new UpdateWrapper<UserRegis>();
        wrapper.eq("id",userId);
        wrapper.set("job_id",jobId);
        boolean result = userRegisService.update(wrapper);
        if(result)
            return Result.succeed("职位变更成功!");
        else
            return Result.fail(SystemCodeEnum.FAILURE,"职位变更失败，请检查请求信息");
    }

    @GetMapping("getDepartNameById")
    public Result getDepartNameById(@RequestParam("departNo") String departNo){
        QueryWrapper wrapper = new QueryWrapper<Depart>();
        wrapper.eq("depart_no",departNo);
        Depart depart = departService.getOne(wrapper);
        return Result.succeed("",depart.getDepartName());
    }
}
