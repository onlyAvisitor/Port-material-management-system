package com.yfk.domain.Materials;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;


@Data
@TableName("supplier_info")
public class Supplier {
    @TableId(value = "supplier_no",type = IdType.AUTO)
    private Integer supplierCode;

    @TableField("supplier_name")
    private String supplierName;
}
