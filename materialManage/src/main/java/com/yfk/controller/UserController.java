package com.yfk.controller;

import cn.hutool.crypto.SecureUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.yfk.common.lang.Result;
import com.yfk.common.lang.SystemCodeEnum;
import com.yfk.domain.User;
import com.yfk.service.UserService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
/**
 * Rest风格的Controller类
 */
@Slf4j
@RestController
@RequestMapping("/user")
public class UserController {

    @Autowired
    private UserService userService;


    //登录
    @PostMapping({"/login","/",""})
    public Result userLogin(@RequestBody User user) throws IllegalArgumentException{

        User user1 = userService.getOne(new QueryWrapper<User>().eq("username",user.getUsername()));
        //token授权

        //打印日志 以便追踪前台
        log.info("用户登录=============>{}，{}",user.getUsername(),user1.getJobName());
        log.info("密码===========>{}",user.getPassword());

        //登录判断
        if(user1.getPassword().equals(SecureUtil.md5(user.getPassword()))){
            return Result.succeed("登陆成功",user1);
        }else
            return Result.fail(SystemCodeEnum.FAIL_PASS);
    }
    /**
     * 获取用户姓名
     */
    @GetMapping("getUsernameById")
    public Result getUsernameById(@RequestParam("id") Integer id){
       User user = userService.getById(id);
       return Result.succeed("查询成功",user.getUsername());
    }

}
