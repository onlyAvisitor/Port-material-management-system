<template>
  <el-card>
    <RecordsQuery></RecordsQuery>
    <el-table
        :data="intoStockRecords"
        border fit
        height="450px"
        style="width: 100%">
      <el-table-column type="expand" align="center">
        <template slot-scope="props" align="center">
          <el-divider></el-divider>
          <el-descriptions class="margin-top" :column="4" style="margin-left: 100px;width: 1000px" border>
            <el-descriptions-item label="入库记录号">{{props.row.id}}</el-descriptions-item>
            <el-descriptions-item label="采购单号">{{props.row.detailId}}</el-descriptions-item>
            <el-descriptions-item label="所属计划">{{props.row.planId}}</el-descriptions-item>
            <el-descriptions-item label="入库物资">
              <el-tag size="small">{{props.row.msCategory}}</el-tag>
            </el-descriptions-item>
            <el-descriptions-item label="入库数目">{{props.row.intoSum+props.row.unit}}</el-descriptions-item>
            <el-descriptions-item label="供应商">{{props.row.supplierName}}</el-descriptions-item>
            <el-descriptions-item label="单价">{{props.row.actualPrice+"元/"+props.row.unit}}</el-descriptions-item>
            <el-descriptions-item label="总价">{{ (props.row.actualPrice*props.row.intoSum)+"元"}}</el-descriptions-item>
            <el-descriptions-item label="记录员">
              {{getUsername(props.row,"recorderName")}}
              {{props.row.recorderName}}
            </el-descriptions-item>
            <el-descriptions-item label="入库时间">{{props.row.generateTime}}</el-descriptions-item>
            <el-descriptions-item label="采购员">
              {{getUsername(props.row,"purchaserName")}}
              {{props.row.purchaserName}}
            </el-descriptions-item>
            <el-descriptions-item label="采购时间">{{props.row.procureDate}}</el-descriptions-item>
            <el-descriptions-item label="入库信息">
              {{setDescribe(props.row)}}
              {{props.row.recordsDescribe}}
            </el-descriptions-item>
          </el-descriptions>
          <el-divider></el-divider>
        </template>
      </el-table-column>
      <el-table-column
          align="center"
          label="记录编号"
          width="100"
          prop="id">
      </el-table-column>
      <el-table-column
          align="center"
          label="入库物资"
          width="150"
          prop="msCategory">
        <template slot-scope="scope">
          <el-tag size="mini"  style="width: 70px;">{{scope.row.msCategory}}</el-tag>
        </template>
      </el-table-column>
      <el-table-column
          align="center"
          width="230"
          label="入库时间"
          prop="generateTime">
      </el-table-column>
      <el-table-column
          align="center"
          label="入库量"
          width="150"
          >
        <template slot-scope="scope">
          <el-tag size="mini" type="success" style="width: 70px;">{{scope.row.intoSum+scope.row.unit}}</el-tag>
        </template>
      </el-table-column>
      <el-table-column
          align="center"
          width="150"
          label="所属计划"
          prop="planId">
      </el-table-column>
      <el-table-column
          align="center"
          width="200"
          label="采购单号"
          prop="detailId">
      </el-table-column>
      <el-table-column
          align="center"
          width="180"
          label="入库员工"
          >
        <template slot-scope="scope">
          {{getUsername(scope.row,"recorderName")}}
          {{scope.row.recorderName}}
        </template>
      </el-table-column>
    </el-table>
  </el-card>
</template>

<script>
import axios from "axios";
import RecordsQuery from "@/components/Query/recordsQuery";
export default {
  name: "intoStockRecords",
  components:{
    RecordsQuery
  },
  data(){
    return{

    }
  },
  computed:{
    intoStockRecords(){
      return this.$store.getters["stock/getIntoStockRecords"]
    }
  },
  methods:{
    setDescribe(record){
      let recordsDescribe=""
      let recordsArr = record.stockRecords.split(";")
      recordsArr.pop()
      for (const index in recordsArr) {
        let detailArr = recordsArr[index].split(",")
        recordsDescribe += detailArr[0]+"号仓库，"+detailArr[1] + "号货架,装入" + detailArr[2] +"单位；"
      }
      this.$set(record,"recordsDescribe",recordsDescribe)
    },
    getUsername(record,key){
      let Id = ""
      if(key === "purchaserName"){
        Id = record.userId
      }else{
        Id = record.recordId
      }
      const url = "user/getUsernameById"
      axios.get(url,{
        params:{
          id:Id
        }
      }).then(
          res => {
            this.$set(record,key,res.data.data)
          }
      ).catch(
          error => {
            return "记录异常"
          }
      )
    }
  }
}
</script>

<style scoped>
.el-form{
  align-items: flex-start;
  justify-content: left;
}
</style>
