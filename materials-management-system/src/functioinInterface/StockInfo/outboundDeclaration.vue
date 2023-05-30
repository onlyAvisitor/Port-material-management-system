<template>
  <el-tabs v-model="activeName" active-name="first" >
    <el-tab-pane label="申请列表" name="first">
      <OutboundList/>
    </el-tab-pane>
    <el-tab-pane label="出库申请" name="second">
      <OutboundApplication/>
    </el-tab-pane>
  </el-tabs>
</template>

<script>
import OutboundApplication from "@/functioinInterface/StockInfo/outboundApplication";
import OutboundList from "@/functioinInterface/StockInfo/outboundList";
export default {
  name: "outboundDeclaration",
  components: {
    OutboundApplication,OutboundList
  },
  data(){
    return{
      activeName:"first"
    }
  }
}
</script>

<style scoped>

</style>
