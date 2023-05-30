<template>
  <el-tabs type="border-card">
    <el-tab-pane label="库存状态">
      <StockDepotInfo></StockDepotInfo>
    </el-tab-pane>
    <el-tab-pane label="盘存登记">
    </el-tab-pane>
  </el-tabs>
</template>

<script>
import StockDepotInfo from "@/components/tables/stockDepotInfo";
export default {
  name: "showStockInfo",
  components:{ StockDepotInfo, },
}
</script>

<style scoped>

</style>
