<template>
    <el-card class="box-card" style="width: 900px;margin-left: 150px;height: 500px">
      <div slot="header" class="clearfix">
        <span style="font-size: 20px">员工信息</span>
      </div>
      <el-descriptions class="margin-top" :column="3" size="medium" border>
        <el-descriptions-item>
          <template slot="label">
            <i class="el-icon-user"></i>
            姓名
          </template>
          {{userInfo.username}}
        </el-descriptions-item>
        <el-descriptions-item>
          <template slot="label">
            <i class="el-icon-mobile-phone"></i>
            手机号
          </template>
          {{userInfo.phone}}
        </el-descriptions-item>
        <el-descriptions-item>
          <template slot="label">
            <i class="el-icon-location-outline"></i>
            部门
          </template>
          <el-tag effect="plain" type="success">{{userInfo.departName}}</el-tag>
        </el-descriptions-item>
        <el-descriptions-item>
          <template slot="label">
            <i class="el-icon-tickets"></i>
            职位
          </template>
          <el-tag>{{userInfo.jobName}}</el-tag>
        </el-descriptions-item>
        <el-descriptions-item>
          <template slot="label">
            <i class="el-icon-office-building"></i>
            注册时间
          </template>
          {{userInfo.accessTime}}
        </el-descriptions-item>
      </el-descriptions>
      <el-collapse v-model="activeName" accordion style="margin-top: 40px">
        <el-collapse-item title="职位变更" name="1">
          <el-form
            ref="userUpdateForm"
            :model="userUpdateForm"
            label-position="right"
            label-width="60px"
          >
              <el-row>
                <el-col :span="8">
                  <el-form-item prop="departId" label="部门:" >
                    <el-select  placeholder="部门选择" v-model="userUpdateForm.departId">
                      <el-option
                          v-for="item in departList"
                          :key="item.departNo"
                          :label="item.departName"
                          :value="item.departNo"
                      ></el-option>
                    </el-select>
                  </el-form-item>
                </el-col>
                <el-col :span="8">
                  <el-form-item prop="jobId" label="职位:">
                    <el-select  placeholder="职位" v-model="userUpdateForm.jobId">
                      <el-option
                          v-for="item in jobList"
                          :key="item.id"
                          :label="item.jobName"
                          :value="item.id"
                      >
                      </el-option>
                    </el-select>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item style="margin-top: 7px">
                    <el-button type="primary" plain @click = updateUser>确认更改</el-button>
                  </el-form-item>
                </el-col>
            </el-row>
          </el-form>
        </el-collapse-item>
      </el-collapse>
    </el-card>
</template>

<script>
import axios from "axios";
export default {
  name: "userInfoCard",
  data(){
    return{
      activeName:'1',
      userUpdateForm:{
        departId:"",
        jobId:"",
        userId:"",
      },
    }
  },
  computed:{
    userInfo(){
      return this.$store.state.HRManage.queryUser
    },
    departList(){
      return this.$store.state.HRManage.ListInfo.departList
    },
    jobList(){
      return this.$store.state.HRManage.ListInfo.jobList
    },
  },
  watch:{
    "userUpdateForm.departId":{
      handler(value){
        this.userUpdateForm.jobId = ""
        if (value == "") {
          this.$store.state.HRManage.ListInfo.jobList = []
        } else {
          this.$store.commit("HRManage/getJobs",value)
        }
      }
    },
    "userQueryForm.jobId":{
      handler(value){
        if (value == "") {
          this.$store.state.HRManage.ListInfo.userList = []
        } else {
          this.$store.commit("HRManage/queryUsers",value)
        }
      }
    }
  },
  methods:{
    updateUser(){
      const url = "HRManage/jobChange"
      axios.patch(url,null,{
        params:{
          jobId: this.userUpdateForm.jobId,
          userId:this.userInfo.id,
        }}).then(
            res => {
              if(res.data.code == "1010"){
                this.$alert(`${res.data.message}`, '消息提示', {
                  confirmButtonText: '确定',
                  callback: action => {
                    this.$message({
                      type: 'success',
                      message: `已确认`,
                    });
                    //刷新界面
                    this.$router.go(0)
                  }
                })
              }else{
                this.$alert(`${res.data.message}`, '消息提示', {
                  confirmButtonText: '确定',
                  callback: action => {
                    this.$message({
                      type: 'error',
                      message: `已确认`,
                    });
                    //刷新界面
                    this.$router.go(0)
                  }
                })
              }
            }).catch(
            error => {
              console.log("非法请求")
      })
    }
  }
}
</script>

<style scoped>
.el-form{
  align-items: flex-start;
  justify-content: left;
}
</style>
