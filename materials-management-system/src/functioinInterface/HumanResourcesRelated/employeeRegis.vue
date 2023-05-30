<template>
  <el-row>
    <el-col :span="16" style="margin-left: 200px">
      <el-form ref="form" :model="regisForm" label-width="80px">
        <el-form-item label="员工姓名" prop="username">
          <el-input v-model="regisForm.username" placeholder="注册员工姓名" clearable></el-input>
        </el-form-item>
        <el-form-item label="用户密码" prop="password">
          <el-input v-model="regisForm.password" placeholder="请输入密码" clearable show-password></el-input>
        </el-form-item>
        <el-form-item label="职位信息">
          <el-col :span="6" style="margin-right: 20px">
            <el-form-item prop="departId">
              <el-select  placeholder="部门选择" v-model="regisForm.departId">
                <el-option
                  v-for="item in departList"
                  :key="item.departNo"
                  :label="item.departName"
                  :value="item.departNo"
                ></el-option>
              </el-select>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item prop="jobId">
              <el-select  placeholder="职位" v-model="regisForm.jobId">
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
            <el-form-item label="权限等级" prop="powerLevel">
              <el-input v-model="regisForm.powerLevel" disabled></el-input>
            </el-form-item>
          </el-col>
        </el-form-item>
        <el-form-item label="联系电话" prop="phone">
          <el-input v-model="regisForm.phone" clearable></el-input>
        </el-form-item>
        <el-form-item style="margin-left: 120px">
          <el-button type="primary" @click = regisSubmit>提交申请</el-button>
          <el-button>取消</el-button>
        </el-form-item>
      </el-form>
    </el-col>
    <el-col :span="4"></el-col>
  </el-row>
</template>

<script>
import axios from "axios";
export default {
  name: "employeeRegis",
  data(){
    return{
      regisForm:{
        username:"",
        password:"",
        phone:"",
        jobId:"",
        departId:"",
        powerLevel:"",
      },
    }
  },
  watch:{
    "regisForm.departId":{
      handler(value){
        this.regisForm.jobId = ""
        if (value == "") {
          this.$store.state.HRManage.ListInfo.jobList = []
        } else {
          this.$store.commit("HRManage/getJobs",value)
        }
      }
    },
    "regisForm.jobId":{
      handler(value){
        if(value !== "") {
          for (const index in this.jobList) {
            if (this.jobList[index].id == value) {
              this.regisForm.powerLevel = this.jobList[index].powerLevel
            }
          }
        }
      }
    }
  },
  computed:{
    jobList(){
      return this.$store.state.HRManage.ListInfo.jobList
    },
    departList() {
      return this.$store.state.HRManage.ListInfo.departList;
    }
  },
  created(){
    this.$store.commit("HRManage/getDepartments")
  },
  methods:{
    regisSubmit(){
      const url = "HRManage/employeeRegis"
      axios.put(url,this.regisForm).then(
          res=> {
            this.$message({
              message: res.data.message,
              type: 'success',
              center: true,
            })
            this.$nextTick(this.$router.go(0))
          }).catch(
          error => {
            this.$message({
              message: error.data.message,
              type: 'error',
              center: true,
            })
          }
      )
      this.$nextTick(() => {
        this.$refs.form.resetFields()
      })
    }
  }
}
</script>

<style scoped>
  .el-form{
    align-items: flex-start;
    justify-content: left;
    margin-top: 100px;
  }
</style>
