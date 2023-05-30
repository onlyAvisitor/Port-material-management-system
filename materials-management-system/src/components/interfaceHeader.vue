<template>
  <el-menu
      class="headerMenu"
      mode="horizontal"
      background-color="#364f6b"
      text-color="#f5f5f5"
      active-text-color="#3fc1c9"
      default-active="displayInterface"
      router
  >
    <el-menu-item index="displayInterface">首页</el-menu-item>
    <el-menu-item index="/regulate">管理系统</el-menu-item>
    <el-menu-item index="announcement">通知信息</el-menu-item>
    <div style="float: right">
      <span style="font-size: 20px;float: right;margin-top: 15px;margin-right: 20px;color: #a1eafb">{{userInfo.username}}</span>
      <el-dropdown style="margin-top: 10px;float:right;" @command="createQuest">
        <span class="el-dropdown-link">
        <el-avatar :src="avatarUrl" style="margin-right:5px;float: right"></el-avatar>
        </span>
        <el-dropdown-menu slot="dropdown">
          <el-dropdown-item command="selfCenter">个人中心</el-dropdown-item>
          <el-dropdown-item command="signOut">退出登录</el-dropdown-item>
          <el-dropdown-item command="notification">消息通知</el-dropdown-item>
        </el-dropdown-menu>
      </el-dropdown>
      <el-image :src="require('@/assets/img/welcomeBanner.png')" style="margin-top: 5px;margin-right: 30px"></el-image>
    </div>
  </el-menu>
</template>

<script>
export default {
  name: "interfaceHeader",
  data(){
    return {
      avatarUrl:"https://img0.baidu.com/it/u=3524086258,727431468&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=500",
      userInfo:{},
    }
  },
  methods: {
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
  },
  created(){
    this.userInfo = JSON.parse(localStorage.getItem("userInfo"))
  }
}
</script>

<style scoped>
  .headerMenu{
    width: 100%;
    align-content: center;
  }
  el-menu{
    font-family: "PingFang SC";
  }
</style>
