package com.yfk.common.lang;


import lombok.Getter;

import static com.yfk.common.lang.SystemCodeEnum.SUCCESS;

//统一格式封装 本类只可访问
@Getter
public class Result<T> {
    //操作码
    private final String code;
    //提示消息
    private final String message;
    //请求数据返回  错误则返回NULL
    private final T data;

    //一般构造函数
    private Result(String code, String message, T data) {
        this.code = code;
        this.message = message;
        this.data = data;
    }

    //使用响应码  构造函数
    public Result(SystemCodeEnum systemCode, String message, T data) {
        this.code = systemCode.getCode();
        this.message = message;
        this.data = data;
    }

    public Result(SystemCodeEnum systemCode) {
        this.code = systemCode.getCode();
        this.message = systemCode.getDescription();
        this.data = null;
    }
    //请求成功，且无数据返回
    public static <T> Result<T> Succeed() {
        return new Result<>(SUCCESS.getCode(), SUCCESS.getDescription(), null);
    }

    //请求成功，返回数据，且消息为自定义提示
    public static <T> Result<T> succeed(String message) {
        return new Result<>(SUCCESS.getCode(), message, null);
    }
    //请求成功，返回数据
    public static <T> Result<T> succeed(T data) {
        return new Result<>(SUCCESS.getCode(), SUCCESS.getDescription(), data);
    }

    //请求成功 返回数据和提示
    public static <T> Result<T> succeed(String message, T data) {
        return new Result<>(SUCCESS.getCode(), message, data);
    }

    //请求失败，返回异常信息
    public static <T> Result<T> fail(SystemCodeEnum systemCode) {
        return new Result<>(systemCode.getCode(), systemCode.getDescription(), null);
    }

    //请求失败，返回提示信息
    public static <T> Result<T> fail(SystemCodeEnum systemCode, String message) {
        return new Result<>(systemCode.getCode(), message, null);
    }

    //请求失败 但有部分数据返回
    public static <T> Result<T> fail(SystemCodeEnum systemCode, String message, T data) {
        return new Result<>(systemCode.getCode(), message, data);
    }
}
