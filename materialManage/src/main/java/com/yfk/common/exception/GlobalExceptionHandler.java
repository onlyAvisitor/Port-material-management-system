package com.yfk.common.exception;

import com.yfk.common.lang.Result;
import com.yfk.common.lang.SystemCodeEnum;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import java.io.IOException;
//全局异常处理类

//后端异常记录日志
@Slf4j
//定义为RestController的异常处理器
@RestControllerAdvice
public class GlobalExceptionHandler {

    /**
     * 处理非法参数异常
     */
    @ResponseStatus(HttpStatus.BAD_REQUEST)
    @ExceptionHandler(value = IllegalArgumentException.class)
    public Result handler(IllegalArgumentException e) throws IOException {
        //输出异常信息
        log.error("Assert异常:-------------->{}", e.getMessage());
        //使用参数异常码返回
        return Result.fail(SystemCodeEnum.ARGUMENT_WRONG, "请求参数错误");
    }
    /**
     * @Validated 校验错误异常处理
     */
    @ResponseStatus(HttpStatus.BAD_REQUEST)
    @ExceptionHandler(value = MethodArgumentNotValidException.class)
    public Result handler(MethodArgumentNotValidException e) throws IOException {
        log.error("实体校验异常:-------------->", e);
        BindingResult bindingResult = e.getBindingResult();
        ObjectError objectError = bindingResult.getAllErrors().stream().findFirst().get();
        return Result.fail(SystemCodeEnum.FAIL_VALID, objectError.getDefaultMessage());
    }

    /**
     * 用运行时异常处理遗漏
     */
    @ResponseStatus(HttpStatus.BAD_REQUEST)
    @ExceptionHandler(value = RuntimeException.class)
    public Result hander(RuntimeException e) {
        log.error("运行时异常-------------------------{}", e);
        return Result.fail(SystemCodeEnum.FAIL_4003, e.getMessage());
    }

    /**
     * 空指针异常
     */
    @ResponseStatus(HttpStatus.BAD_REQUEST)
    @ExceptionHandler(value = NullPointerException.class)
    public Result hander(NullPointerException e) {
        log.error("运行时异常-------------------------{}", e);
        return Result.fail(SystemCodeEnum.FAIL_USER, e.getMessage());
    }
}
