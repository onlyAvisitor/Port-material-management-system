<template>
  <el-container>
    <el-aside width="205px">
      <leftSideBar/>
    </el-aside>
    <el-container>
      <el-header align="center" style="padding: 0 0 0 0">
        <infoHeader/>
      </el-header>
      <el-main style="border: 2px solid">
        <router-view/>
      </el-main>
    </el-container>
  </el-container>
</template>

<script>
import leftSideBar from "@/components/leftSideBar";
import infoHeader from "@/components/infoHeader"
export default {
  name: "regulatePage",
  components:{
    leftSideBar,infoHeader,
  },
  created() {
    this.$store.commit("user/setUserInfo")
    this.$store.commit("material/getMsList")
  }
}
</script>

<style scoped>
  el-header {
    position: relative;
    width: 100%;
    height: 100px;
    padding: 0 0 0 0;
  }
  el-aside {
    display: block;
    position: absolute;
    left: 0;
    top: 60px;
    bottom: 0;
  }
  el-main {
    position: absolute;
    left: 200px;
    right: 0;
    top: 60px;
    bottom: 0;
    overflow-y: scroll;
  }
</style>
