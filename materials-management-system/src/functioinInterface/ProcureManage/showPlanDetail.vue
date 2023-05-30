<template>
  <div>
      <el-page-header @back="goBack" content="计划明细">
      </el-page-header>
      <div align="center">
        <el-card>
          <el-descriptions title="采购计划" :column="3"  border>
            <el-descriptions-item label="计划编号" label-class-name="planId" content-class-name="planId-content">{{procurePlan.planId}}</el-descriptions-item>
            <el-descriptions-item label="发布时间" label-class-name="releaseTime" content-class-name="releaseTime-content">{{procurePlan.releaseTime}}</el-descriptions-item>
            <el-descriptions-item label="发布人">{{procurePlan.userName}}</el-descriptions-item>
            <el-descriptions-item label="计划说明" label-class-name="planDescribe" :contentStyle="{'text-align': 'left'}">{{procurePlan.planDescribe}}</el-descriptions-item>
          </el-descriptions>
        </el-card>
        <el-card>
          <div slot="header" class="clearfix" >
            <span style="font-size: 20px;font-weight: bold;float: left"><i class="el-icon-s-order"></i>采购条目</span>
          </div>
          <div style="height: 350px;display: flex" class="cab">
            <el-scrollbar style="height:100%;width: 100%" wrap-class="default-scrollbar__wrap">
              <el-table
                  :data="planDetails"
                  stripe
                  style="width: 100%"
              >
                <el-table-column
                    align="center"
                    prop="id"
                    label="序号"
                    width="50"
                >
                </el-table-column>
                <el-table-column
                    align="center"
                    prop="msCode"
                    label="物料编号"
                    width="100">
                </el-table-column>
                <el-table-column
                    align="center"
                    prop="msCategory"
                    label="物料"
                    width="50">
                </el-table-column>
                <el-table-column
                    align="center"
                    prop="purchaseSum"
                    label="申购量"
                    width="80">
                </el-table-column>
                <el-table-column
                    align="center"
                    label="预计单价"
                    width="100">
                  <template slot-scope="scope">
                    {{scope.row.fob+'元/'+scope.row.quantityUnit}}
                  </template>
                </el-table-column>
                <el-table-column
                    align="center"
                    label="预计总值"
                    width="100">
                  <template slot-scope="scope">
                    {{scope.row.fob*scope.row.purchaseSum+'元'}}
                  </template>
                </el-table-column>
                <el-table-column
                    align="center"
                    label="申购部门"
                    prop="departName"
                    width="100">
                </el-table-column>
                <el-table-column
                    align="center"
                    prop="auditLevel"
                    label="审核等级"
                    width="100">
                </el-table-column>
                <el-table-column
                    align="center"
                    label="审核信息"
                    width="200">
                    <template slot-scope="scope">
                      <div v-show="getPowerLevel(scope.row)">
                        <el-button type="primary" plain @click="handleAudit(scope.row,userInfo.powerLevel)" size="medium">
                          批准
                        </el-button>
                        <el-button type="danger" plain @click="handleAudit(scope.row,4)" size="medium">
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
                    label="采购状态"
                    width="100">
                  <template slot-scope="scope">
                    <div v-show="scope.row.procureState">
                      <el-tag type="success">已采购</el-tag>
                    </div>
                    <div v-show="!scope.row.procureState">
                      <el-tag type="warning">未采购</el-tag>
                    </div>
                  </template>
                </el-table-column>
                <el-table-column
                    align="center"
                    label="入库状态"
                    width="100">
                  <template slot-scope="scope">
                    <div v-show="scope.row.stockState">
                      <el-tag type="success">已入库</el-tag>
                    </div>
                    <div v-show="!scope.row.stockState">
                      <el-tag type="warning">未入库</el-tag>
                    </div>
                  </template>
                </el-table-column>
              </el-table>
              <el-card>
                <div slot="header" class="clearfix" >
                  <span style="font-size: 15px;font-weight: bold;color: #3fc1c9  ;float: left">申请加购</span>
                  <el-button
                      style="float: right; padding: 3px 0" type="text"
                      @click="addProcureItem"
                  >增加条目</el-button>
                </div>
                <el-form ref="procureForm" :model="procureDetails" label-width="80px" label-position="right">
                  <div v-for="(detail,index) in procureDetails.formList" :key="index">
                    <el-row>
                      <el-col :span="4">
                        <el-form-item label="材料:" :prop="'formList.'+index+'.msCategory'" style="width: 200px">
                          <el-autocomplete
                              class="inline-input"
                              v-model="detail.msCategory"
                              :fetch-suggestions="querySearch"
                              value-key = 'msCategory'
                              placeholder="采购材料"
                              @select="handleMsCate(index)"
                              size="small"
                          ></el-autocomplete>
                        </el-form-item>
                      </el-col>
                      <el-col :span="4" style="margin-left: 50px">
                        <el-form-item label="数目:">
                          <el-input v-model.number="detail.purchaseSum" size="small" style="width: 100px" @change="handleTotal(index)">
                            <i slot="suffix" style="font-style: normal; margin-right: 5px">{{priceList[index].unit}}</i>
                          </el-input>
                        </el-form-item>
                      </el-col>
                      <el-col :span="6">
                        <el-form-item label="参考单价:" style="margin-left: 50px">
                          <el-input clearable
                                    v-model="priceList[index].fob"
                                    size="small"
                                    style="width: 100px"
                                    suffix-icon="el-icon-money"
                                    disabled>
                            <i slot="suffix" style="font-style: normal; margin-right: 10px">元</i>
                          </el-input>
                        </el-form-item>
                      </el-col>
                      <el-col :span="4" style="margin-left:50px">
                        <el-form-item label="参考总价:">
                          <el-input clearable
                                    v-model="priceList[index].totalPrice"
                                    size="small"
                                    style="width: 200px"
                                    suffix-icon="el-icon-money"
                                    disabled>
                            <i slot="suffix" style="font-style: normal; margin-right: 10px">元</i>
                          </el-input>
                        </el-form-item>
                      </el-col>
                      <el-col :span="2" style="margin-left: 80px">
                        <el-button
                            type="primary"
                            plain icon="el-icon-minus"
                            circle
                            @click="deleteProcureItem(index)"
                            size="mini"
                            style="margin-top: 10px"
                            v-show="procureDetails.formList.length>1">
                        </el-button>
                      </el-col>
                    </el-row>
                  </div>
                  <el-button type="primary" plain @click="addPlanDetails">提交申请</el-button>
                </el-form>
              </el-card>
            </el-scrollbar>
          </div>
        </el-card>
      </div>
  </div>
</template>

<script>
import axios from "axios";

export default {
  name: "showPlanDetail",
  data(){
    return{
      procureDetails: {
        formList:[{
          departNo:"",
          auditLevel:"",
          msCode:"",
          msCategory:"",
          purchaseSum:"",
          procureState: 0,
        }],
      },
      priceList:[
        {fob:0,totalPrice:0,unit:""}
      ],
      userInfo:{},
      procurePlan:{},
    }
  },
  methods: {
    handleAudit(detail,powerLevel){
      const url = "subscribe/planAudit"
      axios.patch(url,null,{
        params:{
          powerLevel:powerLevel,
          detailId:detail.id,
        }
      }).then(
          res => {
            console.log(res)
            this.$store.commit("subscribe/getPlanDetails",this.procurePlan)
          }
      ).catch(
          error => {
            console.log(error)
          }
      )
    },
    getPowerLevel(detail){
      if(detail.auditLevel === 1){
        detail.audit = "已通过"
      }else{
        detail.audit = "等待下一级审核"
      }
      return this.userInfo.powerLevel < detail.auditLevel
    },
    goBack() {
      this.$router.back();
    },
    querySearch(queryString, cb){
      const msCategories = this.msCategories;
      const results = queryString ? msCategories.filter(this.createFilter(queryString)) : msCategories;
      // 调用 callback 返回建议列表的数据
      cb(results);
    },
    createFilter(queryString) {
      return (msCategory) => {
        return (msCategory.msCategory.toLowerCase().indexOf(queryString.toLowerCase()) !== -1);
      };
    },
    handleTotal(index){
      this.priceList[index].totalPrice = this.procureDetails.formList[index].purchaseSum* this.priceList[index].fob
    },
    deleteProcureItem(index){
      this.procureDetails.formList.splice(index,1)
      this.priceList.splice(index,1)
    },
    addProcureItem(){
      this.procureDetails.formList.push({
        departNo:this.userInfo.departNo,
        auditLevel:this.userInfo.powerLevel,
        msCode:"",
        msCategory:"",
        purchaseSum:"",
        procureState: 0,
      })
      this.priceList.push({fob:0,totalPrice:0,unit:""})
    },
    handleMsCate(index){
      for (const item in this.msCategories) {
        if(this.msCategories[item].msCategory === this.procureDetails.formList[index].msCategory){
          console.log(this.msCategories[item])
          this.procureDetails.formList[index].msCode=this.msCategories[item].msCode
          this.priceList[index].fob=this.msCategories[item].fob
          this.priceList[index].unit=this.msCategories[item].quantityUnit
        }
      }
    },
    addPlanDetails(){
      console.log(this.procureDetails.formList)
      const url = "subscribe/addPlanDetails"
      axios.post(url,this.procureDetails.formList,{
        params:{
          planId:this.procurePlan.planId
        }
      },{
        contentType:"application/json"
      }).then(
          res => {
            this.$message({
              message: res.data.message,
              type: 'success',
              center: true,
            })
          }
      ).catch(
          error => {
            console.log(error)
          }
      )
      this.$nextTick(_=>{
        this.$router.go(0)
      })
    },

  },
  computed:{
    msCategories(){
      return this.$store.state.material.Categories.msCategories
    },
    planDetails(){
      return this.$store.state.subscribe.planDetails
    }
  },
  created(){
    this.userInfo = JSON.parse(localStorage.getItem('userInfo'))
    this.procurePlan = JSON.parse(localStorage.getItem(('procurePlan')))
    this.$store.commit("subscribe/getPlanDetails",this.procurePlan)
    this.$store.commit("material/getMsList")
  },
  mounted(){
    //对信息进行初始赋值
    this.procureDetails.formList[0].departNo=this.userInfo.departNo
    this.procureDetails.formList[0].auditLevel=this.userInfo.powerLevel
  }
}
</script>

<style scoped>
.el-card>>>.planId {
  background: #eeeeee;
}
.el-card>>>.planId-content {
  color: #00adb5;
  font-weight: bold;
  font-size: 14px;
  text-align: center;
}
.el-card>>>.releaseTime {
  background: #f5f5f5;
}
.el-card>>>.releaseTime-content {
  color: #71c9ce;
  font-size: 14px;
  text-align: center;
}
.el-card>>>.planDescribe {
  background: #c0ebd7;
}
.el-card>>>.planDescribe-content{
  font-size: 14px;
}
.el-card>>>.default-scrollbar__wrap {
  overflow-x: hidden;
}
</style>
