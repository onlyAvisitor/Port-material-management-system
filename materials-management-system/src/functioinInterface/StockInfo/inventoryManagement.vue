<template>
  <el-tabs type="border-card">
    <el-tab-pane label="入库记录" style="height: 590px">
      <IntoStockRecords></IntoStockRecords>
    </el-tab-pane>
    <el-tab-pane label="待入库物资" style="height: 590px">
      <IntoStocks></IntoStocks>
    </el-tab-pane>
  </el-tabs>
</template>

<script>
import IntoStocks from "@/components/tables/intoStocks";
import IntoStockRecords from "@/components/tables/intoStockRecords";
export default {
  name: "inventoryManagement",
  components:{
    IntoStocks,IntoStockRecords
  },
  created() {
    this.$store.commit("stock/requestIntoStocks")
  }
}
</script>

<style scoped>

</style>
