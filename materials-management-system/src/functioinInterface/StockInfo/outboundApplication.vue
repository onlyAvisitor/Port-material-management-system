<template>
  <el-card style="height: 590px">
    <el-descriptions class="margin-top" title="申请信息" :column="3" border size="mini">
      <el-descriptions-item>
        <template slot="label">
          <i class="el-icon-user"></i>
          部门
        </template>
        {{userInfo.departName}}
      </el-descriptions-item>
      <el-descriptions-item>
        <template slot="label">
          <i class="el-icon-mobile-phone"></i>
          申请人
        </template>
        {{userInfo.username}}
      </el-descriptions-item>
      <el-descriptions-item>
        <template slot="label">
          <i class="el-icon-location-outline"></i>
          申请日期
        </template>
        <el-date-picker
            v-model="outBoundDetails.submitDate"
            type="date"
            readonly
            style="border: white"
            size="mini"
        >
        </el-date-picker>
      </el-descriptions-item>
    </el-descriptions>
    <el-card style="margin-top: 10px" align="center">
      <div slot="header" class="clearfix">
        <span style="font-size: 16px;color: #003472;font-weight: bold">申请物资</span>
        <el-button style="float: right; padding: 3px 0" type="text" @click="addOutboundItem">
          新增条目<i class="el-icon-plus"></i>
        </el-button>
      </div>
      <div style="height: 300px;display: flex" class="cab">
        <el-scrollbar style="height:100%;width: 100%" wrap-class="default-scrollbar__wrap">
          <el-form ref="procureForm" :model="outBoundDetails" style="width: 100%">
            <div v-for="(detail,index) in outBoundDetails.formList" :key="index">
              <el-row align="center">
                <el-col :span="22">
                  <el-descriptions class="margin-top" :column="column" border size="small">
                    <el-descriptions-item>
                      <template slot="label">
                        序号
                      </template>
                      {{index + 1}}
                    </el-descriptions-item>
                    <el-descriptions-item>
                      <template slot="label">
                        材料
                      </template>
                      <el-autocomplete
                          class="inline-input"
                          v-model="detail.msCategory"
                          :fetch-suggestions="querySearch"
                          value-key = 'msCategory'
                          placeholder="请输入材料名"
                          style="width: 120px"
                          @select="handleMsCate(index)"
                          size="mini"
                      ></el-autocomplete>
                    </el-descriptions-item>
                    <el-descriptions-item>
                      <template slot="label">
                        数目
                      </template>
                      <el-input
                          v-model.number="detail.outNumber"
                          size="mini"
                          suffix-icon="el-icon-money"
                          style="width: 100px"
                      >
                        <i slot="suffix" style="font-style: normal; margin-right: 5px">{{materialInfoList[index].unit}}</i>
                      </el-input>
                    </el-descriptions-item>
                    <el-descriptions-item>
                      <template slot="label">
                        余量
                      </template>
                      <el-input
                          v-model="materialInfoList[index].inventoryBalance"
                          size="mini"
                          style="width: 100px"
                          suffix-icon="el-icon-money"
                          disabled>
                        <i slot="suffix" style="font-style: normal; margin-right: 10px">{{materialInfoList[index].unit}}</i>
                      </el-input>
                    </el-descriptions-item>
                    <el-descriptions-item>
                      <template slot="label">
                        用途
                      </template>
                      <el-input
                          clearable
                          v-model="detail.purposeOfUse"
                          size="mini"
                          style="width: 150px"
                      >
                      </el-input>
                    </el-descriptions-item>
                    <el-descriptions-item v-if="column==6">
                      <template slot="label">
                        挖机
                      </template>
                      <el-select size="mini" v-model="detail.machineId" style="width: 100px">
                        <el-option
                            v-for="item in machineList"
                            :key="item.id"
                            :label="item.name"
                            :value="item.id"
                        ></el-option>
                      </el-select>
                    </el-descriptions-item>
                 </el-descriptions>
                </el-col>
                <el-col :span="2">
                  <el-button
                  type="primary"
                  plain icon="el-icon-minus"
                  circle
                  @click="deleteProcureItem(index)"
                  size="mini"
                  style="margin-top: 14px"
                  v-show="outBoundDetails.formList.length>1">
                  </el-button>
                </el-col>
              </el-row>
            </div>
          </el-form>
        </el-scrollbar>
      </div>
      <el-button plain type="primary" size="mini" @click="submitOutbound">提交申请</el-button>
    </el-card>
  </el-card>
</template>

<script>
import axios from "axios";
export default {
  name: "outboundApplication",
  data(){
    return{
      column:5,
      outBoundDetails:{
        submitDate:new Date(),
        departNo:"",
        applicationUserId:"",
        auditLevel:"",
        formList:[{
          msCode:"",
          msCategory:"",
          outNumber:"",
          outboundState:0,
          //用途
          purposeOfUse:"",
          //若为生产部门，则应加上挖机id
          machineId:"",
      }]},
      materialInfoList:[{
        unit:"",
        inventoryBalance:"",
      }],
      machineList:[{
        id:"1",
        name:"智能装船机"
      }],
    }
  },
  methods:{
    deleteProcureItem(index){
      this.outBoundDetails.formList.splice(index,1)
      this.materialInfoList.splice(index,1)
    },
    addOutboundItem(){
      this.outBoundDetails.formList.push({
        msCode:"",
        msCategory:"",
        outNumber:"",
        outboundState:0,

        //用途
        purposeOfUse:"",
        //若为生产部门，则应加上挖机id
        machineId:"",
      })
      this.materialInfoList.push({
        unit:"",
        inventoryBalance:"",
      })
    },
    handleMsCate(index){
      const url = "stock/getMsBalance"
      for (const item in this.msCategories) {
        if(this.msCategories[item].msCategory === this.outBoundDetails.formList[index].msCategory){
          this.outBoundDetails.formList[index].msCode=this.msCategories[item].msCode
          axios.get(url,{
            params:{
              msCode:this.msCategories[item].msCode
            }
          }).then(
              res => {
                this.materialInfoList[index].inventoryBalance = res.data.data
              }
          ).catch(
              error => {
                this.$message({
                  type:"error",
                  message:"请求信息失败",
                })
              }
          )
          this.materialInfoList[index].unit=this.msCategories[item].quantityUnit
          break
        }
      }
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
    setOutboundDetails(){
      this.outBoundDetails.departNo = this.userInfo.departNo
      this.outBoundDetails.applicationUserId = this.userInfo.id
      this.outBoundDetails.auditLevel = this.userInfo.powerLevel
      return
    },
    submitOutbound(){
      this.setOutboundDetails()
      console.log(this.outBoundDetails)
      const url = "stock/stockOutApplication"
      axios.post(url,this.outBoundDetails.formList,{
        params:{
          submitDate:this.outBoundDetails.submitDate,
          departNo:this.outBoundDetails.departNo,
          auditLevel:this.outBoundDetails.auditLevel,
          applicationUserId:this.outBoundDetails.applicationUserId
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

          }
      )
    }
  },
  computed:{
    userInfo(){
      return this.$store.getters["user/getUserInfo"]
    },
    msCategories(){
      return this.$store.state.material.Categories.msCategories
    }
  },
  mounted() {
    if(this.userInfo.departName==="生产部") {
      this.column = 6
    }else{
      this.column = 5
    }
  }
}
</script>

<style scoped>

label{
  margin-top: 20px;
}
.el-card>>>.default-scrollbar__wrap {
  overflow-x: hidden;
}
</style>
