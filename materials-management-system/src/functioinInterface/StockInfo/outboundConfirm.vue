<template>
  <div>
    <el-page-header @back="goBack" content="出库确认">
    </el-page-header>
    <el-card align="center">
      <el-descriptions class="margin-top" title="待入库条目" :column="3" size="small" border>
        <el-descriptions-item>
          <template slot="label">
            编号
          </template>
          {{ application.id }}
        </el-descriptions-item>
        <el-descriptions-item>
          <template slot="label">
            <i class="el-icon-time"></i>
            提交时间
          </template>
          {{ application.applicationTime}}
        </el-descriptions-item>
        <el-descriptions-item>
          <template slot="label">
            <i class="el-icon-location-outline"></i>
            申请部门
          </template>
          <el-tag type="warning" size="small">{{application.departName}}</el-tag>
        </el-descriptions-item>
        <el-descriptions-item>
          <template slot="label">
            <i class="el-icon-user"></i>
            申请人
          </template>
          <el-tag type="success" size="small">{{application.applicationUser}}</el-tag>
        </el-descriptions-item>
        <el-descriptions-item>
          <template slot="label">
            <i class="el-icon-tickets"></i>
            材料
          </template>
          <el-tag size="small">{{ application.msCategory }}</el-tag>
        </el-descriptions-item>
        <el-descriptions-item>
          <template slot="label">
            <i class="el-icon-office-building"></i>
            出库量
          </template>
          {{ application.outNumber }}
        </el-descriptions-item>
      </el-descriptions>
      <el-card>
        <div slot="header" class="clearfix">
          <span style="font-size: 15px;font-weight: bold;float: left">请选择货架</span>
          <el-tag
              style="float: left; margin-left: 20px; padding: 3px 0"
              type="warning"
              size="small"
              :disable-transitions="true"
              v-show="this.total-this.checkedSum>0">
            {{"仍需"+ (this.total-this.checkedSum)+"单位"+this.application.msCategory }}
          </el-tag>
          <el-tag
              style="float: left; margin-left: 20px; padding: 3px 0"
              type="success"
              size="small"
              :disable-transitions="true"
              v-show="!(this.total-this.checkedSum>0)">
            已选择完毕
          </el-tag>
        </div>
        <div style="height: 300px;display: flex" class="cab">
          <el-scrollbar style="height:100%;width: 100%" wrap-class="default-scrollbar__wrap">
            <el-checkbox-group v-model="checkedShelves" :max="max">
              <div align="left">
                <el-checkbox-button v-for="item in outShelvesList"
                                    :key="item.id"
                                    :label="item"
                                    name="box"
                                    style="margin-top: 10px;margin-right: 20px"
                >{{item.id}}</el-checkbox-button>
              </div>
            </el-checkbox-group>
          </el-scrollbar>
        </div>
      </el-card>
      <el-button style="margin-top: 20px" type="primary" plain @click = "handleOutbound">确认出库</el-button>
    </el-card>
  </div>
</template>

<script>
import axios from "axios";

export default {
  name: "outboundConfirm",
  data(){
    return {
      application:{},
      checkedSum:0,
      total:0,
      max:1000,
      checkedShelves:[],
      outShelvesInfo:[],
    }
  },
  watch:{
    /**
     * 监视选中货架，提取货物
     */
    checkedShelves:{
      deep:true,
      handler(){
        let total = this.total
        const shelves = this.checkedShelves
        this.checkedSum = 0
        for (const index in shelves) {//遍历选中的货架  并安排放入的值
          const occupied = shelves[index].occupied
          if(occupied >= total){//该货架便可取下所有货物
            this.checkedSum += total
            total = 0
            break
          }else{
            total = total - occupied
            this.checkedSum += occupied
          }
        }
        if(total === 0){
          this.max = shelves.length
        }else {
          this.max = shelves.length+1
        }
      }
    }
  },
  computed:{
    outShelvesList(){
      return this.$store.getters["stock/getOutShelvesList"]
    },
    userInfo(){
      return this.$store.getters["user/getUserInfo"]
    }
  },
  methods:{
    goBack() {
      this.$router.back()
    },
    /**
     * 出库信息提交   后端需根据信息生成出库记录
     */
    handleOutbound(){
      let total = this.application.outNumber
      for (const index in this.checkedShelves) {
        const occupied = this.checkedShelves[index].occupied
        if(occupied >= total){//该货架可以取出所有货物
          const item = {
            shelvesId:this.checkedShelves[index].id,
            outNumber:total,
            depotId:this.checkedShelves[index].depotId
          }
          this.outShelvesInfo.push(item)
          break
        }else{//该货架取不出所需货物量
          const item = {
            shelvesId:this.checkedShelves[index].id,
            outNumber:occupied,
            depotId:this.checkedShelves[index].depotId
          }
          this.outShelvesInfo.push(item)
          total -= occupied
        }
      }
      const url = "stock/dealOutStockInfo"
      axios.post(url,this.outShelvesInfo,{
        params:{
          applicationId:this.application.id,
          handlerId:this.userInfo.id,
          msCode:this.application.msCode,
          outNumber:this.application.outNumber
        }
      }).then(
          res => {
            if(res.data.code === "1010" ){
              this.$message({
                type:"success",
                message:res.data.message
              })
            }else{
              this.$message({
                type:"error",
                message:res.data.message
              })
            }
            setTimeout(_=>{
              this.$router.back()
            },500)
          }
      ).catch(
          error => {
            this.$message({
              type:"error",
              message:error,
            })
            setTimeout(_=>{
              this.$router.back()
            },500)
          }
      )
    }
  },
  created() {
    this.application = JSON.parse(localStorage.getItem("application"))
    this.total = this.application.outNumber
    this.$store.commit("stock/requestShelvesByMsCode",this.application.msCode)
  }
}
</script>

<style scoped>
.el-card>>>.default-scrollbar__wrap {
  overflow-x: hidden;
}
</style>
