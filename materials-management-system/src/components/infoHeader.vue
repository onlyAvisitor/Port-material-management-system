<template>
  <el-menu
      class="el-menu-demo"
      mode="horizontal"
      background-color="#e3fdfd"
      text-color="#3e4149"
      active-text-color="#ffd04b">
    <div align="center"style="float: left">
      <el-breadcrumb separator-class="el-icon-arrow-right" style="margin-top:20px;margin-left: 20px">
        <el-breadcrumb-item
          v-for="(item,index) in breadList"
          :key="index"
          :to="{ path: item.path }">
          {{ item.meta.title }}
        </el-breadcrumb-item>
      </el-breadcrumb>
    </div>
    <div style="float: right">
      <el-dropdown style="margin-top: 13px;float:right;" @command="createQuest">
        <span class="el-dropdown-link">
        <el-avatar :src="avatarUrl" style="margin-right:50px;float: right"></el-avatar>
        </span>
        <el-dropdown-menu slot="dropdown">
          <el-dropdown-item command="selfCenter">个人中心</el-dropdown-item>
          <el-dropdown-item command="signOut">退出登录</el-dropdown-item>
          <el-dropdown-item command="notification">消息通知</el-dropdown-item>
        </el-dropdown-menu>
      </el-dropdown>
      <el-image :src="require('@/assets/img/tipBanner.png')" style="margin-top: 5px;margin-right: 10px"></el-image>
    </div>
  </el-menu>
</template>

<script>
export default {
  name: "infoHeader",
  data(){
    return {
      userInfo:{},
      avatarUrl:"https://img0.baidu.com/it/u=3524086258,727431468&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=500",
      breadList:[],
    }
  },
  watch:{
    $route(){
      this.getBreadcrumb();
    }
  },
  methods:{
    createQuest(questType){
      if(questType==="signOut"){
        this.handleQuit()
      }else if(questType==="selfCenter"){

      }else if(questType==="notification"){

      }
    },
    handleQuit(){
      this.$confirm('是否退出登录?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        localStorage.removeItem("userInfo")
        this.$router.push("/")
      }).catch(() => {
        this.$message({
          type: 'info',
          message: '已取消'
        });
      });
    },
    isHome(route) {
      return route.name === "navigate";
    },
    getBreadcrumb() {
      let matched = this.$route.matched;
      //如果不是首页
      if (!this.isHome(matched[0])) {
        matched = [{ path: "/navigate", meta: { title: "首页" } }].concat(matched);
      }
      this.breadList = matched;
    }
  },
  created() {
    this.userInfo = JSON.parse(localStorage.getItem("userInfo"))
    this.getBreadcrumb()
  }
}
</script>

<style scoped>

</style>
