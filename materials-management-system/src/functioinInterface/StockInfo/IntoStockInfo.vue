<template>
  <div align="center">
    <el-card>
      <div slot="header" class="clearfix">
        <span style="font-size: 20px;font-weight: bold;float: left"><i class="fa fa-reorder"></i> 采购信息</span>
        <el-descriptions class="margin-top" :column="3"  border>
          <el-descriptions-item>
            <template slot="label">
              <i class="el-icon-user"></i>
              单号
            </template>
            {{IntoStockItem.id}}
          </el-descriptions-item>
          <el-descriptions-item>
            <template slot="label">
              <i class="el-icon-mobile-phone"></i>
              所属计划
            </template>
            {{ IntoStockItem.planId }}
          </el-descriptions-item>
          <el-descriptions-item>
            <template slot="label">
              <i class="el-icon-location-outline"></i>
              采购物资
            </template>
            {{IntoStockItem.msCategory}}
          </el-descriptions-item>
          <el-descriptions-item>
            <template slot="label">
              <i class="el-icon-tickets"></i>
              采购量
            </template>
            {{IntoStockItem.purchaseSum+IntoStockItem.quantityUnit}}
          </el-descriptions-item>
          <el-descriptions-item>
            <template slot="label">
              <i class="el-icon-office-building"></i>
              总花费
            </template>
            <el-tag size="small">{{IntoStockItem.actualPrice*IntoStockItem.purchaseSum+"元"}}</el-tag>
          </el-descriptions-item>
          <el-descriptions-item>
            <template slot="label">
              <i class="el-icon-office-building"></i>
              采购人
            </template>
            {{IntoStockItem.username}}
          </el-descriptions-item>
        </el-descriptions>
      </div>
    </el-card>
    <el-card>
      <div slot="header" class="clearfix">
        <span style="font-size: 20px;font-weight: bold;float: left"><i class="fa fa-th"></i> 入库选择</span>
        <el-tag
            style="float: left; margin-left: 20px; padding: 3px 0"
            type="warning"
            :disable-transitions="true"
            v-show="this.total-this.checkedSum>0">
          {{"仍有"+ (this.total-this.checkedSum)+IntoStockItem.quantityUnit+"未安排入库" }}
        </el-tag>
        <el-tag
            style="float: left; margin-left: 20px; padding: 3px 0"
            type="success"
            :disable-transitions="true"
            v-show="!(this.total-this.checkedSum>0)">
          {{"已全部安排入库!" }}
        </el-tag>
      </div>
      <div style="height: 300px;display: flex" class="cab">
        <el-scrollbar style="height:100%;width: 100%" wrap-class="default-scrollbar__wrap">
          <el-row>
            <h4 style="float: left;color: #a8d8ea">请选择货架号:</h4>
          </el-row>
          <el-checkbox-group v-model="checkedShelves" :max="max">
            <div align="left">
              <el-checkbox-button v-for="item in availableShelves"
                                  :key="item.id"
                                  :label="item"
                                  name="box"
                                  style="margin-top: 10px;margin-right: 5px"
              >{{item.id}}</el-checkbox-button>
            </div>
          </el-checkbox-group>
        </el-scrollbar>
      </div>
      <el-button style="margin-top: 10px" @click="intoStockSubmit">入库</el-button>
    </el-card>
  </div>
</template>

<script>
import axios from "axios";
export default {
  name: "IntoStockInfo",
  data(){
    return {
      IntoStockItem:{},
      checkedShelves:[],
      itemChecked:false,
      checkedSum:0,
      total:0,
      max:100,
      intoShelvesInfo:[],
      userInfo:{},
    }
  },
  computed:{
    availableShelves(){
      return this.$store.getters["stock/getAvailableShelves"]
    }
  },
  watch:{
    checkedShelves:{
      deep:true,
      handler(){
        let total = this.total
        const shelves = this.checkedShelves
        this.checkedSum = 0
        for (const index in shelves) {//遍历选中的货架  并安排放入的值
          const remain = shelves[index].capacity - shelves[index].occupied
          if(remain >= total){//该货架可装下所有货物
            this.checkedSum += total
            total = 0
            break
          }else{
            total = total - remain
            this.checkedSum += remain
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
  methods:{
    intoStockSubmit(){
      let total = this.IntoStockItem.purchaseSum
      for (const index in this.checkedShelves) {
        const remain = this.checkedShelves[index].capacity - this.checkedShelves[index].occupied
        if(remain >= total){//该货架可装下所有货物
          const item = {
            shelvesId:this.checkedShelves[index].id,
            occupied:total,
            depotId:this.checkedShelves[index].depotId
          }
          this.intoShelvesInfo.push(item)
          break
        }else{//该货架装不下所有货物
          const item = {
            shelvesId:this.checkedShelves[index].id,
            occupied:remain,
            depotId:this.checkedShelves[index].depotId
          }
          this.intoShelvesInfo.push(item)
          total -= remain
        }
      }
      console.log(this.intoShelvesInfo)
      const url = "stock/dealIntoStocks"
      axios.post(url,this.intoShelvesInfo,{
        params:{
          detailId:this.IntoStockItem.id,
          msCode:this.IntoStockItem.msCode,
          userId:this.userInfo.id,
          intoSum:this.IntoStockItem.purchaseSum,
        }
      }).then(
          res => {
            if(res.data.code === "1010") {
              this.$message({
                message:res.data.message,
                type:'success'
              })
              setTimeout(_=>{
                this.$router.push("/regulate/inventoryManagement")
              },1000)
            }else{
              this.$message({
                message:res.data.message,
                type:'error'
              })
              setTimeout(_=>{
                this.$router.go(0)
              })
            }
          }
      ).catch(
          error => {
            console.log(error)
          }
      )
    }
  },
  created() {
    //请求入库物资单号
    this.IntoStockItem = JSON.parse(localStorage.getItem("intoStockItem"))
    this.userInfo = JSON.parse(localStorage.getItem("userInfo"))
    //请求货架信息
    this.total=this.IntoStockItem.purchaseSum
    this.$store.commit("stock/requestIntoStocksByMsCate",this.IntoStockItem.msCode)
  }
}
</script>

<style scoped>
.el-card>>>.default-scrollbar__wrap {
  overflow-x: hidden;
}
</style>
