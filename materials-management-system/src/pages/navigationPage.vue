<template>
  <div style="background:#e3f9fd">
    <el-row class="naviMenu">
      <el-col :span="24">
        <div class="grid-content bg-purple-dark">
          <interfaceHeader/>
        </div>
      </el-col>
    </el-row>
    <div style="height: 900px;background: radial-gradient(circle,#ffffff,#f0f0f4,#e9f1f6,#f0fcff,#e3f9fd)">
      <el-scrollbar style="height: 100%" wrap-class="default-scrollbar__wrap">
        <router-view/>
        <div>
          <el-card align="center" style="background: #d6ecf0;height: 200px;margin-bottom: 0">
            <div style="margin-top: 40px">
            <h4 style="color: white">@whut Yang Fukang</h4>
            <span style="color: white">2022 年 5 月 12 日</span>
            </div>
          </el-card>
        </div>
      </el-scrollbar>
    </div>

  </div>

</template>

<script>
import interfaceHeader from "@/components/interfaceHeader";
export default {
  name: "navigationPage",
  components: {interfaceHeader},
  data(){
    return {
    }
  },
  methods: {

  },
  created(){
    this.$store.commit("user/setUserInfo")
  }
}
</script>

<style scoped lang="css">
  .el-row {
    margin-bottom: 20px;
    &:last-child {
       margin-bottom: 0;
     }
  }
  .bg-purple {
    background: #d3dce6;
  }
  .bg-purple-light {
    background: #e5e9f2;
  }
  .el-col {
    border-radius: 4px;
  }
  .grid-content {
    border-radius: 4px;
    min-height: 36px;
  }
  .row-bg {
    padding: 10px 0;
    background-color: #f9fafc;
  }
  .portImgInfo{
    margin-left: 120px;
    height:300px;
  }
  .el-carousel__item h3 {
    color: #475669;
    font-size: 14px;
    opacity: 0.75;
    line-height: 200px;
    margin: 0;
  }

  .el-carousel__item:nth-child(2n) {
    background-color: #99a9bf;
  }

  .el-carousel__item:nth-child(2n+1) {
    background-color: #d3dce6;
  }
  .default-scrollbar__wrap {
    overflow-x: hidden;
  }
  .purchasePlanInfo{
    margin-left: 120px;
  }
  .el-card>>>.default-scrollbar__wrap{
    overflow-x: hidden;
  }
</style>
