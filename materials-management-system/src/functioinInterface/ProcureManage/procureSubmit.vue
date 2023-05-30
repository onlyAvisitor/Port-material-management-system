<template>
  <div align="center">
    <el-card class="box-card">
      <el-form ref="planForm" :model="planForm" label-width="90px" label-position="right">
        <el-row>
          <el-col :span="8">
            <el-form-item prop="planClass" label="计划类型：">
              <el-select v-model="planForm.planClass" style="width: 200px">
                <el-option
                    v-for="type in procureTypes"
                    :key="type.value"
                    :label="type.value"
                    :value="type.value"
                >
                </el-option>
              </el-select>
            </el-form-item>
          </el-col>
          <el-col :span="6" style="margin-left: 300px">
            <el-form-item  label="申报人：" style="margin-top: 5px">
              <el-tag>{{userInfo.username}}</el-tag>
            </el-form-item>
          </el-col>
        </el-row>
          <el-form-item prop="describe" label="申报说明：">
            <el-input
                type="textarea"
                v-model="planForm.describe"
                maxlength="200"
                style="width:1100px"
            ></el-input>
          </el-form-item>
      </el-form>
    </el-card>
    <el-card align="center">
      <div slot="header" class="clearfix">
        <span style="font-size: 16px">采购明细</span>
        <el-button style="float: right; padding: 3px 0" type="text" @click="addProcureItem">新增条目</el-button>
      </div>
      <div style="height: 280px;display: flex" class="cab">
        <el-scrollbar style="height:100%;width: 100%" wrap-class="default-scrollbar__wrap">
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
          </el-form>
        </el-scrollbar>
      </div>
    </el-card>
    <el-button type="success" plain style="margin-top: 20px" @click="planSubmit">
      提交<i class="el-icon-upload el-icon--right"></i>
    </el-button>
  </div>
</template>

<script>
import axios from "axios";
export default {
  name: "procureSubmit",
  data(){
    return{
      procureTypes:[
        {
          value: '月度计划',
        },{
          value: '紧急需求',
        },{
          value: '日常缺额'
      }],
      planForm:{
        planClass:"",
        userName:"",
        userId:"",
        describe:"",
      },
      userInfo:{},
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
      ]
    }
  },
  computed:{
    msCategories(){
      return this.$store.state.material.Categories.msCategories
    }
  },
  methods:{
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
    handleMsCate(index){
      for (const item in this.msCategories) {
        if(this.msCategories[item].msCategory === this.procureDetails.formList[index].msCategory){
          this.procureDetails.formList[index].msCode=this.msCategories[item].msCode
          this.priceList[index].fob=this.msCategories[item].fob
          this.priceList[index].unit=this.msCategories[item].quantityUnit
        }
      }
    },
    handleTotal(index){
      this.priceList[index].totalPrice = this.procureDetails.formList[index].purchaseSum* this.priceList[index].fob
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
    deleteProcureItem(index){
      this.procureDetails.formList.splice(index,1)
      this.priceList.splice(index,1)
    },
    planSubmit(){
      const url="subscribe/planSubmit"
      axios.post(url,this.procureDetails.formList,{
        params: {
            planClass: this.planForm.planClass,
            userName: this.planForm.userName,
            userId: this.planForm.userId,
            describe: this.planForm.describe,
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
            }).catch(
            error =>{
              console.log(error)
            }
      )
      this.$nextTick(_=>{
        this.$refs.procureForm.resetFields()
        this.$refs.planForm.resetFields()
      })
    }
  },
  created() {
    //初始化用户信息
    this.userInfo = JSON.parse(localStorage.getItem('userInfo'))
    this.$store.commit("material/getMsList")
  },
  mounted(){
    //对信息进行初始赋值
    this.planForm.userId = this.userInfo.id
    this.planForm.userName = this.userInfo.username
    this.procureDetails.formList[0].departNo=this.userInfo.departNo
    this.procureDetails.formList[0].auditLevel=this.userInfo.powerLevel
  }
}
</script>

<style scoped>
.el-form{
  align-items: flex-start;
  justify-content: left;
}
 label{
   margin-top: 20px;
 }
.el-card>>>.default-scrollbar__wrap {
  overflow-x: hidden;
}
</style>
