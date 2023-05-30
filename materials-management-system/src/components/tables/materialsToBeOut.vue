<template>
  <el-card align="center">
    <el-table
      :data="materialToBeOutList"
      stripe
      height="560px"
      style="width: 100%"
    >
      <el-table-column
          align="center"
          prop="id"
          label="编号"
          width="220"
      >
      </el-table-column>
      <el-table-column
          align="center"
          prop="applicationTime"
          label="提交日期"
          width="150">
      </el-table-column>
      <el-table-column
          align="center"
          prop="msCategory"
          label="物料"
          width="100">
      </el-table-column>
      <el-table-column
          align="center"
          prop="outNumber"
          label="数目"
          width="100">
      </el-table-column>
      <el-table-column
          align="center"
          label="库存数目"
          width="100">
        <template slot-scope="scope">
          {{getStockNum(scope.row)}}
          {{scope.row.stockSum}}
        </template>
      </el-table-column>
      <el-table-column
          align="center"
          label="申请人"
          width="100">
        <template slot-scope="scope">
          {{getUsernameById(scope.row)}}
          {{scope.row.applicationUser}}
        </template>
      </el-table-column>
      <el-table-column
          align="center"
          label="申请部门"
          width="150">
        <template slot-scope="scope">
          {{getDepartNameById(scope.row)}}
          {{scope.row.departName}}
        </template>
      </el-table-column>
      <el-table-column
          align="center"
          label="操作"
          width="150">
        <template slot-scope="scope">
          <el-button type="primary" size="small" @click = "outboundConfirm(scope.row)">确认出库</el-button>
        </template>
      </el-table-column>
    </el-table>
  </el-card>
</template>

<script>
import axios from "axios";

export default {
  name: "materialsToBeOut",
  computed:{
    materialToBeOutList(){
      return this.$store.getters["stock/getMaterialsToBeOutList"]
    }
  },
  methods:{
    getUsernameById(application){
      const url = "user/getUsernameById"
      axios.get(url,{
        params:{
          id:application.applicationUserId
        }
      }).then(
          res => {
            this.$set(application,"applicationUser",res.data.data)
          }
      ).catch(
          error => {
            return "记录异常"
          }
      )
    },
    getDepartNameById(application){
      const url = "HRManage/getDepartNameById"
      axios.get(url,{
        params:{
          departNo:application.departNo
        }
      }).then(
          res => {
            this.$set(application,"departName",res.data.data)
          }
      )
    },
    getStockNum(detail){
      const url = "stock/getMsBalance"
      axios.get(url,{
        params:{
          msCode:detail.msCode
        }
      }).then(
          res => {
            this.$set(detail,"stockSum",res.data.data)
          }
      ).catch(
          error => {
            this.$message({
              type:"error",
              message:"请求信息失败",
            })
          }
      )
    },
    outboundConfirm(application){
      localStorage.setItem("application",JSON.stringify(application));
      this.$router.push("/regulate/outboundConfirm")
    }
  },

}
</script>

<style scoped>

</style>
