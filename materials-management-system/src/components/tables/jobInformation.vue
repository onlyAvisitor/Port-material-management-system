<template>
  <div align="center">
    <el-card>
      <div align="left" class="searchBox">
        所属部门：
        <el-select
            v-model="queryInfo.departNo"
            placeholder="请选择"
            style="width: 140px"
        >
          <el-option label="所有" value="all">
          </el-option>
          <el-option
              v-for="item in departList"
              :key="item.departNo"
              :label="item.departName"
              :value="item.departNo">
          </el-option>
        </el-select>
        所属职位：
        <el-select
          v-model="queryInfo.jobId"
          placeholder="请选择"
          style="width: 140px;margin-right: 20px"
        >
          <el-option label="所有" value="0">
          </el-option>
          <el-option
            v-for="item in jobList"
            :key="item.id"
            :label="item.jobName"
            :value="item.id">
          </el-option>
        </el-select>
      </div>
      <div align="center">
        <el-table
            :data="tableData"
            stripe
            style="width: 100%"
            max-height="450"
        >
          <el-table-column
              align="center"
              prop="id"
              label="员工编号"
              width="100"
          >
          </el-table-column>
          <el-table-column
              align="center"
              prop="username"
              label="姓名"
              width="150">
          </el-table-column>
          <el-table-column
              align="center"
              prop="accessTime"
              label="注册时间"
              width="150">
          </el-table-column>
          <el-table-column
              align="center"
              prop="departNo"
              label="部门编号"
              width="140">
          </el-table-column>
          <el-table-column
              align="center"
              prop="departName"
              label="所属部门"
              width="180">
          </el-table-column>
          <el-table-column
              align="center"
              prop="jobName"
              label="职位名称"
              width="180">
          </el-table-column>
          <el-table-column
              align="center"
              prop="powerLevel"
              label="权限等级"
              width="80">
          </el-table-column>
          <el-table-column
              align="center"
              prop="phone"
              label="联系电话"
              width="150">
          </el-table-column>
        </el-table>
        <el-divider></el-divider>
        <el-pagination
            background
            layout="prev, pager, next"
            :current-page="queryInfo.currentPage"
            @current-change=page
            :total="total">
        </el-pagination>
      </div>
    </el-card>
  </div>
</template>

<script>
export default {
  name: "jobInformation",
  data(){
    return{
      queryInfo:{
        departNo:"all",
        jobId:"0",
        currentPage:1,
      },
    }
  },
  computed:{
    departList(){
      return this.$store.state.HRManage.ListInfo.departList;
    },
    tableData(){
      return this.$store.state.HRManage.ListInfo.userList;
    },
    jobList(){
      return this.$store.state.HRManage.ListInfo.jobList;
    },
    total(){
      return this.$store.state.HRManage.total
    }
  },
  methods:{
    page(currentPage){
      this.queryInfo.currentPage = currentPage
    }
  },
  created() {
    this.$store.commit("HRManage/getDepartments")
    this.$store.commit("HRManage/getUsers",this.queryInfo)
  },
  watch: {
    "queryInfo.departNo": {
      handler(value) {
        this.queryInfo.jobId = "0"
        if (value == "all") {
          this.$store.state.HRManage.ListInfo.jobList = []
        } else {
          this.$store.commit("HRManage/getJobs", value)
        }
        this.$store.commit("HRManage/getUsers", this.queryInfo)
      }
    },
    "queryInfo.jobId": {
      handler() {
        this.$store.commit("HRManage/getUsers", this.queryInfo)
      }
    },
    "queryInfo.currentPage": {
      handler(){
        this.$store.commit("HRManage/getUsers", this.queryInfo)
      }
    }
  }
}
</script>

<style scoped>

</style>
