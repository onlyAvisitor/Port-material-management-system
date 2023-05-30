<template>
  <el-form
      ref="userQueryForm"
      :model="userQueryForm"
      label-position="right"
      label-width="60px"
  >
    <el-row>
      <el-col :span="6" style="margin-right: 20px">
        <el-form-item prop="departId" label="部门:" >
          <el-select size="small"  placeholder="部门选择" v-model="userQueryForm.departId">
            <el-option
                v-for="item in departList"
                :key="item.departNo"
                :label="item.departName"
                :value="item.departNo"
            ></el-option>
          </el-select>
        </el-form-item>
      </el-col>
      <el-col :span="6" style="margin-right: 20px">
        <el-form-item prop="jobId" label="职位:">
          <el-select size="small" placeholder="职位" v-model="userQueryForm.jobId">
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
        <el-form-item prop="username" label="姓名:">
          <el-select size="small" placeholder="职位" v-model="userQueryForm.username">
            <el-option
                v-for="item in userList"
                :key="item.id"
                :label="item.username"
                :value="item.username"
            >
            </el-option>
          </el-select>
        </el-form-item>
      </el-col>
      <el-col :span="3" style="margin-top: 7px">
        <el-button type="primary" plain @click = "queryUser" size="small">查询</el-button>
      </el-col>
    </el-row>
  </el-form>
</template>

<script>
export default {
  name: "userQuery",
  data(){
    return{
      userQueryForm:{
        departId:"",
        jobId:"",
        username:"",
      },
      inline:true,
    }
  },
  computed:{
    departList(){
      return this.$store.state.HRManage.ListInfo.departList
    },
    jobList(){
        return this.$store.state.HRManage.ListInfo.jobList
    },
    userList(){
        return this.$store.state.HRManage.ListInfo.userList
    }
  },
  methods:{
    queryUser(){
      this.$store.commit("HRManage/queryUser",this.userQueryForm)
    }
  },
  watch:{
    "userQueryForm.departId":{
      handler(value){
        this.userQueryForm.jobId = ""
        this.userQueryForm.username = ""
        if (value == "") {
          this.$store.state.HRManage.ListInfo.jobList = []
        } else {
          this.$store.commit("HRManage/getJobs",value)
        }
      }
    },
    "userQueryForm.jobId":{
      handler(value){
        this.userQueryForm.username = ""
        if (value == "") {
          this.$store.state.HRManage.ListInfo.userList = []
        } else {
          this.$store.commit("HRManage/queryUsers",value)
        }
      }
    }
  },
  created() {
    this.$store.commit("HRManage/getDepartments")
  }
}
</script>

<style scoped>
.el-form{
  align-items: flex-start;
  justify-content: left;
}
</style>
