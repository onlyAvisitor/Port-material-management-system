<template>
  <el-card>
    <div slot="header" class="clearfix">
      <span>{{ depotId + "号仓库货架状态"}}</span>
    </div>
    <el-table
        :data="shelvesList"
        stripe
        style="width: 100%"
        height="450"
        align="center"
    >
      <el-table-column
          align="center"
          prop="id"
          label="货架号"
          width="200"
      >
      </el-table-column>
      <el-table-column
          align="center"
          label="总容量"
          width="150">
        <template slot-scope="scope">
          <el-tag style="width: 100px">{{scope.row.capacity+scope.row.unit}}</el-tag>
        </template>
      </el-table-column>
      <el-table-column
          align="center"
          label="当前占有"
          width="150">
        <template slot-scope="scope">
          <el-tag style="width: 100px" type="success" v-show="scope.row.occupied>0">{{scope.row.occupied + scope.row.unit}}</el-tag>
          <el-tag style="width: 100px" type="info" v-show="scope.row.occupied === 0">{{scope.row.occupied + scope.row.unit}}</el-tag>
        </template>
      </el-table-column>
      <el-table-column
          align="center"
          prop="msCode"
          label="物资编号"
          width="150">
      </el-table-column>
      <el-table-column
          align="center"
          prop="msCategory"
          label="物资"
          width="150">
      </el-table-column>
      <el-table-column
          align="center"
          label="存放状态"
          width="250">
        <template slot-scope="scope">
          <el-progress
              class="progress-square"
              :percentage="getOccupied(scope.row)"
              :color="getColor(scope.row)"
              :text-inside="true"
              :stroke-width="24"
          ></el-progress>
        </template>
      </el-table-column>
    </el-table>
  </el-card>
</template>

<script>
export default {
  name: "showShelves",
  data(){
    return {
      depotId:"",
    }
  },
  computed:{
    shelvesList(){
      return this.$store.getters["stock/getShelvesList"]
    },
  },
  methods:{
    getOccupied(shelves){
      return 100*(shelves.occupied/shelves.capacity).toFixed(2)
    },
    getColor(shelves){
      const occupied = 100*(shelves.occupied / shelves.capacity).toFixed(2)
      if(occupied<10){
        return '#70f3ff'
      }else if(occupied>=90&&occupied<=100){
        return '#00bc12'
      }else{
        return '#ffa400'
      }
    },
  },
  created() {
    this.depotId = JSON.parse(localStorage.getItem("depotId"))
    this.$store.commit("stock/requestShelvesList",this.depotId)
  }
}
</script>

<style scoped>

</style>
