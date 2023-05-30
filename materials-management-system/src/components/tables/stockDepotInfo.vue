<template>
  <el-card style="height: 590px">
    <el-table
          :data="depotList"
          stripe
          style="width: 100%"
          height="500"
      >
        <el-table-column
            align="center"
            prop="id"
            label="仓库编号"
            width="100"
        >
        </el-table-column>
        <el-table-column
            align="center"
            prop="mbCategory"
            label="存储种类"
            width="200">
        </el-table-column>
        <el-table-column
            align="center"
            label="库存容量"
            width="200">
          <template slot-scope="scope">
            <el-tag style="width: 100px">{{scope.row.capacity + scope.row.unit}}</el-tag>
          </template>
        </el-table-column>
      <el-table-column
          align="center"
          label="占用状态"
          width="300">
        <template slot-scope="scope">
          <el-progress
            :percentage="getOccupied(scope.row)"
            :format="format"
            :status="getStatus(scope.row)"
          ></el-progress>
        </template>
      </el-table-column>
        <el-table-column
            align="center"
            prop="username"
            label="管理员"
            width="150">
        </el-table-column>
        <el-table-column
            align="center"
            label="库存查看"
            width="200">
          <template slot-scope="scope">
            <el-button type="primary" plain @click="ViewDetails(scope.row.id)" size="medium">
              信息查看
            </el-button>
          </template>
        </el-table-column>
      </el-table>
  </el-card>
</template>

<script>
export default {
  name: "stockDepotInfo",
  computed:{
    depotList(){
      return this.$store.getters["stock/getDepotList"]
    }
  },
  methods:{
    getOccupied(depot){
      return 100*(depot.occupied / depot.capacity).toFixed(2)
    },
    getStatus(depot){
      const occupied = 100*(depot.occupied / depot.capacity).toFixed(2)
      if(occupied<20){
        return 'warning'
      }else if(occupied>90){
        return 'exception'
      }else{
        return ''
      }
    },
    format(percentage) {
      return percentage === 100 ? '满' : `${percentage}%`;
    },
    ViewDetails(depotId){
      //更新货架列表
      localStorage.setItem("depotId",JSON.stringify(depotId))
      //界面跳转
      this.$router.push("showShelvesList")
    }
  },
  created() {
    this.$store.commit("stock/requestDepotList")
  }
}
</script>

<style scoped>

</style>
