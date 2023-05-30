<template>
  <el-card>
    <label style="font-size: 14px;color: #f9906f;margin-left: 100px">出库时间:</label>
    <el-date-picker
        v-model="outTime"
        type="month"
        format="yyyy 年 MM 月"
        placeholder="选择月"
        :clearable="false"
        size="mini"
    >
    </el-date-picker>
    <el-table
        :data="outStockRecords"
        stripe
        border
        align="center"
        height="500px"
        style="width: 100%"
    >
      <el-table-column type="expand">
        <template slot-scope="props" align="center">
          <el-divider></el-divider>
          <el-descriptions class="margin-top" :column="4" style="margin-left:80px;width: 1000px" border>
            <el-descriptions-item label="出库记录号">{{props.row.id}}</el-descriptions-item>
            <el-descriptions-item label="申请单号">{{props.row.applicationId}}</el-descriptions-item>
            <el-descriptions-item label="出库负责人">
              {{getUsername(props.row,"recorderName")}}
              {{props.row.recorderName}}
            </el-descriptions-item>
            <el-descriptions-item label="申请人">
              {{getUsername(props.row,"applicationUser")}}
              {{props.row.applicationUser}}
            </el-descriptions-item>
            <el-descriptions-item label="出库物资">
              <el-tag size="small">{{props.row.msCategory}}</el-tag>
            </el-descriptions-item>
            <el-descriptions-item label="出库数目">
              <el-tag size="small" type="success">{{props.row.outNumber+props.row.quantityUnit}}</el-tag>
            </el-descriptions-item>
            <el-descriptions-item label="部门">
              <el-tag size="small" type="warning">{{props.row.departName}}</el-tag>
            </el-descriptions-item>
            <el-descriptions-item label="用途">
              {{props.row.purposeOfUse}}
            </el-descriptions-item>
            <el-descriptions-item label="出库明细">
              {{props.row.stockRecords}}
            </el-descriptions-item>
          </el-descriptions>
          <el-divider></el-divider>
        </template>
      </el-table-column>
      <el-table-column
          align="center"
          prop="id"
          label="记录编号"
          width="100"
      >
      </el-table-column>
      <el-table-column
          align="center"
          prop="applicationId"
          label="申请编号"
          width="300">
      </el-table-column>
      <el-table-column
          align="center"
          label="出库物资"
          width="150">
        <template slot-scope="scope">
          <el-tag type="primary" size="small">{{scope.row.msCategory}}</el-tag>
        </template>
      </el-table-column>
      <el-table-column
          align="center"
          label="出库数目"
          width="150">
        <template slot-scope="scope">
          {{scope.row.outNumber+scope.row.quantityUnit}}
        </template>
      </el-table-column>
      <el-table-column
          align="center"
          label="物资去向"
          width="300">
        <template slot-scope="scope">
          <el-tag size="small" type="warning">{{scope.row.departName}}</el-tag>
        </template>
      </el-table-column>
      <el-table-column
          align="center"
          label="出库时间"
          prop="outStockTime"
          width="100">
      </el-table-column>
    </el-table>
  </el-card>
</template>

<script>
import axios from "axios";

export default {
  name: "outboundRecords",
  data(){
    return{
      outTime:new Date()
    }
  },
  watch:{
    outTime:{
      handler(){
        this.$store.commit("stock/requestOutStockRecords",this.outTime)
      }
    }
  },
  computed:{
    outStockRecords(){
      return this.$store.getters["stock/getOutStockRecords"]
    }
  },
  methods:{
    getUsername(record,key){
      let Id = ""
      if(key === "applicationUser"){
        Id = record.applicationUserId
      }else{
        Id = record.recorderId
      }
      const url = "user/getUsernameById"
      axios.get(url,{
        params:{
          id:Id
        }
      }).then(
          res => {
            this.$set(record,key,res.data.data)
          }
      ).catch(
          error => {
            return "记录异常"
          }
      )
    }
  },
  created() {
    this.$store.commit("stock/requestOutStockRecords",this.outTime)
  }
}
</script>

<style scoped>

</style>
