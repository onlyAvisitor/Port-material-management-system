<template>
  <el-card style="height: 590px">
    <OutboundQuery/>
    <el-divider style="margin: 0 0 10px 10px;"></el-divider>
    <el-table
        :data="outboundApplicationsList"
        stripe
        height="350px"
        style="width: 100%"
    >
      <el-table-column
          align="center"
          prop="id"
          label="申请编号"
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
          label="申请部门"
          prop="departNo"
          width="150">
      </el-table-column>
      <el-table-column
          align="center"
          label="申请人"
          prop="applicationUserId"
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
          label="审核操作"
          width="150">
        <template slot-scope="scope">
          <div v-show="getPowerLevel(scope.row)">
            <el-button type="success" size="small" @click="handleAudit(userInfo.powerLevel,scope.row.id)">
              批准
            </el-button>
            <el-button type="danger" size="small" @click = handleAudit(4,scope.row.id)>
              驳回
            </el-button>
          </div>
          <div v-show="!getPowerLevel(scope.row)">
            <span>{{scope.row.audit}}</span>
          </div>
        </template>
      </el-table-column>
      <el-table-column
          align="center"
          label="出库状态"
          width="100">
        <template slot-scope="scope">
          <el-tag size="small" type="success" v-show="scope.row.outboundState">已出库</el-tag>
          <el-tag size="small" type="warning" v-show="!scope.row.outboundState">未出库</el-tag>
        </template>
      </el-table-column>
    </el-table>
  </el-card>
</template>

<script>
import OutboundQuery from "@/components/Query/outboundQuery";
import axios from "axios";
export default {
  name: "outboundList",
  components:{
    OutboundQuery,
  },
  computed:{
    outboundApplicationsList(){
      return this.$store.getters["stock/getOutboundApplicationsList"]
    },
    userInfo(){
      return this.$store.getters["user/getUserInfo"]
    },
  },
  methods:{
    getPowerLevel(detail){
      if(detail.auditLevel === 1){
        detail.audit = "已通过"
      }else if(detail.auditLevel<4){
        detail.audit = "等待下一级审核"
      }else {
        detail.audit = "已被驳回"
      }
      return this.userInfo.powerLevel < detail.auditLevel
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
    handleAudit(auditLevel,applicationId){
      const url = "stock/checkStockOutApplication"
      axios.patch(url,null,{
        params:{
          id:applicationId,
          auditLevel:auditLevel,
        }
      }).then(
          res => {
            this.$message({
              type:"success",
              message:res.data.message
            })
            setTimeout(_=>{
              this.$router.go(0)
            },1000)
          }
      ).catch(
          error => {
            this.$message({
              type:"error",
              message:error
            })
          }
      )
    }
  }
}
</script>

<style scoped>

</style>
