package com.yfk.common.dto;

import lombok.Data;

import java.io.Serializable;

@Data
public class regisDto implements Serializable {
    private String username;

    private String password;

    private String phone;

    private Integer jobId;

    private String departId;

    private Integer powerLevel;
}
