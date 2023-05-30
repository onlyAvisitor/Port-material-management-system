package com.yfk.common.lang;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum SystemCodeEnum {
    /**
     * 凡是调用成功，都应该使用这个响应码
     */
    SUCCESS("1010", "操作成功"),

    /**
     * 通用失败响应码，尽量避免直接使用
     */
    FAILURE("1000", "失败"),

    /**
     * 入参问题相关响应码
     */
    ARGUMENT_WRONG("10011", "参数错误"),
    ARGUMENT_MISSING("10012", "参数缺失"),
    SIGN_WORNG("10013", "请求签名错误"),
    REQUEST_METHOD_NOT_SUPPPORTED("10014", "请求方法不支持"),

    FAIL_VALID("1111", "实体校验错误"),
    FAIL_PASS("1001", "密码错误"),

    /**
     * 权限相关响应码
     */
    FAIL_4001("4001", "未认证"),
    FAIL_4003("4003", "无权限"),
    FAIL_USER("4004", "用户不存在"),
    NEED_LOGIN("10021", "未登录或登录状态失效"),
    NO_PERMISSION("10022", "没有权限"),

    SERVER_INNER_ERROR("50000", "服务内部错误"),

    /**
     * 任何时候都不应该手动设置成这个响应码，仅可由{@link GlobalExceptionHandler}等类设置
     */
    UNKNOWN_ERROR("99999", "未知异常");

    private final String code;
    private final String description;
}

