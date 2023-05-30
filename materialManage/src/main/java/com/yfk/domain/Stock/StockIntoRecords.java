package com.yfk.domain.Stock;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.sql.Date;

@Data
@TableName("stock_into_records")
public class StockIntoRecords {
    @TableId(type = IdType.AUTO)
    private Integer id;

    @TableField("detail_id")
    private Integer detailId;

    @TableField("generate_time")
    private Date generateTime;

    @TableField("record_id")
    private Integer recordId;

    @TableField("into_sum")
    private Integer intoSum;

    @TableField("ms_code")
    private Integer msCode;

    @TableField("stock_records")
    private String stockRecords;

    public StockIntoRecords(Integer detailId,Integer recordId,Integer intoSum,Integer msCode,String stockRecords){
        this.setDetailId(detailId);
        this.setRecordId(recordId);
        this.setIntoSum(intoSum);
        this.setMsCode(msCode);
        this.setStockRecords(stockRecords);
        this.setGenerateTime(new Date(System.currentTimeMillis()));
    }
    public StockIntoRecords(){

    }
}
