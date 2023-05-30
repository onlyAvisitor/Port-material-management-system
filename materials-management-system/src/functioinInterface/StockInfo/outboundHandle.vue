<template>
  <el-tabs v-model="activeName" type="border-card" :active-name="activeName">
    <el-tab-pane  name="first">
      <span slot="label">
        <el-badge  size="small" class="item">
          <h4>待出库物资</h4>
        </el-badge>
      </span>
      <MaterialsToBeOut/>
    </el-tab-pane>
    <el-tab-pane name="second">
      <span slot="label">
        <el-badge class="item">
          <h4>出库记录</h4>
        </el-badge>
      </span>
      <OutboundRecords/>
    </el-tab-pane>
  </el-tabs>
</template>

<script>
import MaterialsToBeOut from "@/components/tables/materialsToBeOut";
import OutboundRecords from "@/components/tables/outboundRecords";
export default {
  name: "outboundHandle",
  components:{
    MaterialsToBeOut,OutboundRecords
  },
  data(){
    return{
      activeName:"second",
      isDot:false,
    }
  },
  computed:{
  },
  created() {
    this.$store.commit("stock/requestMaterialsToBeOut")

  }
}
</script>

<style scoped>

</style>
