<template>
  <div align="center">
    <el-tabs type="border-card">
      <el-tab-pane label="采购计划" style="height: 590px">
        <el-card align="left" style="width: 1200px">
        计划类型:
        <el-select v-model="queryInfo.planClass" style="width: 200px">
          <el-option
              v-for="type in procureTypes"
              :key="type.value"
              :label="type.value"
              :value="type.value"
          >
          </el-option>
        </el-select>
        日期:
        <el-date-picker
            v-model="queryInfo.month"
            type="month"
            format="yyyy 年 MM 月"
            placeholder="选择月"
            :clearable="false"
        >
        </el-date-picker>
      </el-card>
        <el-table
            :data="planList"
            stripe
            style="width: 100%"
            height="450"
        >
          <el-table-column
              align="center"
              prop="planId"
              label="计划编号"
              width="200"
          >
          </el-table-column>
          <el-table-column
              align="center"
              prop="releaseTime"
              label="发布时间"
              width="250">
          </el-table-column>
          <el-table-column
              align="center"
              prop="planClass"
              label="计划类型"
              width="200">
          </el-table-column>
          <el-table-column
              align="center"
              prop="userName"
              label="发布人"
              width="150">
          </el-table-column>
          <el-table-column
              align="center"
              label="操作"
              width="200">
            <template slot-scope="scope">
              <el-button type="primary" plain @click="handleDetail(scope.row)" size="medium">
                计划明细
              </el-button>
            </template>
          </el-table-column>
        </el-table>
      </el-tab-pane>
      <el-tab-pane label="待购物资" name="first" style="height: 590px">
        <el-card>
          <div style="height: 550px;display: flex" class="cab">
            <el-scrollbar style="height:100%;width: 100%" wrap-class="default-scrollbar__wrap">
              <el-table
                  :data="purchaseItems"
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
                    prop="msCode"
                    label="物料编号"
                    width="150">
                </el-table-column>
                <el-table-column
                    align="center"
                    prop="msCategory"
                    label="物料"
                    width="150">
                </el-table-column>
                <el-table-column
                    align="center"
                    prop="purchaseSum"
                    label="申购量"
                    width="100">
                </el-table-column>
                <el-table-column
                    align="center"
                    label="预计单价"
                    width="150">
                  <template slot-scope="scope">
                    {{scope.row.fob+'元/'+scope.row.quantityUnit}}
                  </template>
                </el-table-column>
                <el-table-column
                    align="center"
                    label="预计总值"
                    width="200">
                  <template slot-scope="scope">
                    {{scope.row.fob*scope.row.purchaseSum+'元'}}
                  </template>
                </el-table-column>
                <el-table-column
                    align="center"
                    label="申购部门"
                    prop="departName"
                    width="150">
                </el-table-column>
                <el-table-column
                    align="center"
                    label="采购信息提交"
                    width="150">
                  <template slot-scope="scope">
                    <el-button plain @click="purchaseFinish(scope.row)">信息填写</el-button>
                  </template>
                </el-table-column>
              </el-table>
            </el-scrollbar>
          </div>
        </el-card>
      </el-tab-pane>
    </el-tabs>
    <el-dialog title="采购信息填写" :visible.sync="dialogFormVisible">
      <el-form :model="detailForm" label-position="right" label-width="80px">
        <el-card>
          <el-descriptions class="margin-top" :column="3" size="medium" border>
            <el-descriptions-item label="单号">{{detailForm.id}}</el-descriptions-item>
            <el-descriptions-item label="计划编号">{{row.planId}}</el-descriptions-item>
            <el-descriptions-item label="采购人"><el-tag size="medium">{{userInfo.username}}</el-tag></el-descriptions-item>
            <el-descriptions-item label="材料">
              {{row.msCategory}}
            </el-descriptions-item>
            <el-descriptions-item label="申请部门">
              <el-tag size="small">{{ row.departName }}</el-tag>
            </el-descriptions-item>
            <el-descriptions-item label="采购日期">{{new Date().toLocaleDateString()}}</el-descriptions-item>
          </el-descriptions>
          <el-row style="margin-top: 30px">
            <el-col :span="8">
            <el-form-item label="实际单价:">
              <el-input v-model="detailForm.actualPrice" placeholder="实际价格" size="mini" autocomplete="off">
                <i slot="suffix" style="font-style: normal; margin-right: 10px">元</i>
              </el-input>
            </el-form-item>
            </el-col>
            <el-col :span="8">
              <el-form-item label="供应公司" style="margin-left: 40px">
                <el-autocomplete
                    class="inline-input"
                    v-model="detailForm.supplierName"
                    :fetch-suggestions="querySearch"
                    value-key = 'supplierName'
                    placeholder=供应商
                    @select="handleSupplier"
                    size="small"
                    style="width: 200px"
                ></el-autocomplete>
              </el-form-item>
            </el-col>
          </el-row>
        </el-card>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="dialogFormVisible = false">取 消</el-button>
        <el-button type="primary" @click="purchaseInfoSubmit">确 定</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import axios from "axios";
export default {
  name: "showProcurePlan",
  data(){
    return{
      dialogFormVisible:false,
      procureTypes:[
        {
          value:"所有",
        },
        {
          value: '月度计划',
        },{
          value: '紧急需求',
        },{
          value: '日常缺额'
        }],
      queryInfo: {
        planClass: "所有",
        month:new Date(),
      },
      row:{},
      detailForm:{
        id:"",
        actualPrice:"",
        userId:"",
        supplierId:"",
        supplierName:"",
      },
      userInfo:{},
    }
  },
  watch:{
    queryInfo:{
      deep:true,
      handler(){
        this.$store.commit("subscribe/getPlanList",this.queryInfo)
      }
    }
  },
  computed:{
    planList(){
      return this.$store.state.subscribe.planList
    },
    purchaseItems(){
      return this.$store.state.subscribe.purchaseItems
    },
    suppliers(){
      return this.$store.state.subscribe.suppliers
    }
  },
  methods:{
    handleDetail(procurePlan){
      //存储
      localStorage.setItem("procurePlan",JSON.stringify(procurePlan))
      this.$router.push("/regulate/showPlanDetail")
    },
    purchaseFinish(detail){
      this.detailForm.userId = this.userInfo.id
      this.detailForm.id = detail.id
      this.row = detail
      this.dialogFormVisible = true
    },
    querySearch(queryString, cb){
      const suppliers = this.suppliers;
      const results = queryString ? suppliers.filter(this.createFilter(queryString)) : suppliers;
      // 调用 callback 返回建议列表的数据
      cb(results);
    },
    createFilter(queryString) {
      return (supplier) => {
        return (supplier.supplierName.toLowerCase().indexOf(queryString.toLowerCase()) !== -1);
      };
    },
    handleSupplier(){
      for (const index in this.suppliers) {
        if(this.suppliers[index].supplierName === this.detailForm.supplierName){
          this.detailForm.supplierId = this.suppliers[index].supplierCode
        }
      }
    },
    purchaseInfoSubmit(){
      const url = "subscribe/purchaseInfoSubmit"
      axios.patch(url,null,{
        params:{
          detailId: this.detailForm.id,
          supplierId: this.detailForm.supplierId,
          actualPrice: this.detailForm.actualPrice,
          userId: this.userInfo.id
        }
      }).then(
          res => {
            this.$message({
              message: res.data.message,
              type: 'success',
              center: true,
            })
            this.$nextTick(_=>{
              this.dialogFormVisible = false
              this.$store.commit("subscribe/getPurchaseItems")
            })
          }
      ).catch(
          error => {
            console.log(error)
          }
      )
    }
  },
  created(){
    //数据请求
    this.$store.commit("subscribe/getPlanList",this.queryInfo)
    this.$store.commit("subscribe/getPurchaseItems")
    this.userInfo = JSON.parse(localStorage.getItem('userInfo'))
    this.$store.commit("subscribe/getSuppliers")
  }
}
</script>

<style scoped>
.el-card>>>.default-scrollbar__wrap {
  overflow-x: hidden;
}
</style>
