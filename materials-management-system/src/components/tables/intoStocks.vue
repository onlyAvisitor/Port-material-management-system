<template>
  <el-card>
    <el-table
          :data="intoStocks"
          stripe
          style="width: 100%"
      >
        <el-table-column
            align="center"
            prop="id"
            label="单号"
            width="100"
        >
        </el-table-column>
        <el-table-column
            align="center"
            prop="planId"
            label="所属计划"
            width="150">
        </el-table-column>
        <el-table-column
            align="center"
            prop="msCategory"
            label="物料"
            width="100">
        </el-table-column>
        <el-table-column
            align="center"
            prop="purchaseSum"
            label="数目"
            width="100">
        </el-table-column>
        <el-table-column
            align="center"
            label="预计单价/实际单价"
            width="150">
          <template slot-scope="scope">
            {{scope.row.fob + "元/" + scope.row.actualPrice + "元"}}
          </template>
        </el-table-column>
        <el-table-column
            align="center"
            label="总价"
            width="150">
          <template slot-scope="scope">
            {{scope.row.actualPrice * scope.row.purchaseSum + "元"}}
          </template>
        </el-table-column>
        <el-table-column
            align="center"
            label="采购人"
            prop="username"
            width="150">
        </el-table-column>
      <el-table-column
          align="center"
          label="提交日期"
          width="150">
        <template slot-scope="scope">
          <el-tag>{{scope.row.procureDate}}</el-tag>
        </template>
      </el-table-column>
        <el-table-column
            align="center"
            label="信息提交"
            width="150">
          <template slot-scope="scope">
            <el-button plain @click="IntoStockInfoSubmit(scope.row)">入库信息提交</el-button>
          </template>
        </el-table-column>
      </el-table>
  </el-card>
</template>

<script>
export default {
  name: "intoStocks",
  data(){
    return{

    }
  },
  computed:{
    intoStocks(){
      return this.$store.getters["stock/getIntoStocks"]
    }
  },
  methods:{
    IntoStockInfoSubmit(intoStockItem){
      localStorage.setItem("intoStockItem",JSON.stringify(intoStockItem))
      this.$router.push("intoStock")
    }
  },
  created() {
    this.$store.commit("stock/requestIntoStocks")
  }
}
</script>

<style scoped>

</style>
