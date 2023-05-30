<template>
  <div align="center">
    <el-card>
    <div align="left" class="searchBox">
      大类：
      <el-select
        v-model="queryInfo.mbCate"
        placeholder="请选择"
        style="width: 140px"
        @change="handleMb"
      >
        <el-option label="所有" value="0">
        </el-option>
        <el-option
            v-for="mbCategory in mbCategories"
            :key="mbCategory.id"
            :label="mbCategory.mbCategory"
            :value="mbCategory.mbCode">
        </el-option>
      </el-select>
      门类：
      <el-select
        v-model="queryInfo.mmCate"
        placeholder="请选择"
        style="width: 140px;margin-right: 20px"
        @change="handleUpdate"
      >
      <el-option label="所有" value="0">
      </el-option>
      <el-option
          v-for="mmCategory in mmCategories"
          :key="mmCategory.id"
          :label="mmCategory.mmCategory"
          :value="mmCategory.mmCode">
      </el-option>
      </el-select>
      <el-input
          placeholder="请输入物料名称"
          v-model="msCategory"
          clearable
          style="width: 200px;margin-right: 10px"
      >
      </el-input>
      <el-button type="primary" @click="dialogVisible = true">新增</el-button>

      <el-dialog
          title="材料新增"
          :visible.sync="dialogVisible"
          width="800px"
          :before-close="handleDialogClose">
        <el-form ref="materialForm" :model="newMaterialForm" label-width="80px">
          <el-row>
            <el-col :span="8">
              <el-form-item prop="mbCode" label="所属大类">
                <el-select
                    v-model="mbCode"
                    placeholder="请选择大类"
                >
                  <el-option
                      v-for="mbCategory in mbCategories"
                      :key="mbCategory.id"
                      :label="mbCategory.mbCategory"
                      :value="mbCategory.mbCode">
                  </el-option>
                </el-select>
              </el-form-item>
            </el-col>
            <el-col :span="8">
              <el-form-item prop="mmCode" label="所属门类">
                <el-select
                    v-model="newMaterialForm.mmCode"
                    placeholder="请选择门类"
                >
                  <el-option
                      v-for="item in mmCategories"
                      :key="item.id"
                      :label="item.mmCategory"
                      :value="item.mmCode">
                  </el-option>
                </el-select>
              </el-form-item>
            </el-col>
            <el-col :span="8">
              <el-form-item prop="msCategory" label="材料名称">
                <el-input v-model="newMaterialForm.msCategory" placeholder="请输入新增材料名"></el-input>
              </el-form-item>
            </el-col>
          </el-row>
          <el-row>
            <el-col :span="8" style="margin-right: 20px">
              <el-form-item prop="fob" label="单价(元)">
                <el-input v-model="newMaterialForm.fob" aria-placeholder="请输入单价"></el-input>
              </el-form-item>
            </el-col>
            <el-col :span="8">
              <el-form-item prop="quantityUnit" label="单位">
                <el-select v-model="newMaterialForm.quantityUnit">
                  <el-option
                    v-for="item in Units"
                    :key="item.value"
                    :label="item.value"
                    :value="item.value">
                  </el-option>
                </el-select>
              </el-form-item>
            </el-col>
          </el-row>
        </el-form>
        <span slot="footer" class="dialog-footer">
          <el-button @click="dialogVisible = false">取 消</el-button>
          <el-button type="primary" @click="handleNewMaterial">确 定</el-button>
        </span>
      </el-dialog>
    </div>
    <div align="center">
      <el-table
          :data="tableData"
          stripe
          style="width: 100%"
          max-height="450"
      >
        <el-table-column
            align="center"
            prop="id"
            label="序号"
            width="150"
        >
        </el-table-column>
        <el-table-column
            align="center"
            prop="msCode"
            label="材料编号"
            width="200">
        </el-table-column>
        <el-table-column
            align="center"
            prop="mbCategory"
            label="大类"
            width="100">
        </el-table-column>
        <el-table-column
            align="center"
            prop="mmCategory"
            label="门类"
            width="300">
        </el-table-column>
        <el-table-column
            align="center"
            prop="msCategory"
            label="名称"
            width="300">
        </el-table-column>
        <el-table-column
            align="center"
            label="操作"
            width="100">
          <template slot-scope="scope">
            <el-button type="primary" plain @click="handleSubscrib(scope.row)" size="medium">
              采购申请
            </el-button>
          </template>
        </el-table-column>
      </el-table>
    </div>
    <el-divider></el-divider>
    <div>
      <el-pagination
          background
          @size-change="handleSizeChange"
          @current-change="handleCurrentChange"
          :current-page="currentPage"
          :page-sizes="[5, 10, 15, 20]"
          :page-size="pageSize"
          :total="total"
          layout="prev,pager,next"
      >
      </el-pagination>
    </div>
    </el-card>
  </div>
</template>

<script>
import axios from "axios";
export default {
  name: "materialTable",
  data(){
    return{
      queryInfo:{
        mbCate: '0',
        mmCate: '0',
      },
      msCategory: '',
      dialogVisible:false,
      mbCode:"",
      newMaterialForm:{
        mmCode:"",
        msCategory:"",
        fob:"",
        quantityUnit:"",
      },
      Units:[{value:"Kg"},
        {value:"T"},
        {value:"条"},
        {value:"g"}]
    }
  },
  computed:{
    tableData(){
      return this.$store.state.material.materialInfo.tableData
    },
    currentPage(){
      return this.$store.state.material.materialInfo.currentPage
    },
    pageSize(){
      return this.$store.state.material.materialInfo.pageSize
    },
    total(){
      return this.$store.state.material.materialInfo.total
    },
    mbCategories(){
      return this.$store.state.material.Categories.mbCategories
    },
    mmCategories(){
      return this.$store.state.material.Categories.mmCategories
    }
  },
  methods:{
    handleSizeChange(val) {
      this.$store.state.material.materialInfo.pageSize = val
      this.$store.commit("material/getMaterialList",this.queryInfo)
    },
    handleCurrentChange(val) {
      this.$store.state.material.materialInfo.currentPage = val
      this.$store.commit("material/getMaterialList",this.queryInfo)
    },
    handleSubscrib(row) {
      console.log(row)
      this.$router.push("subscribe")
    },
    //查询相关
    handleMb(){
      //更新查询信息
      this.queryInfo.mmCate = "0"
      //更新列表
      this.$store.commit("material/getMaterialList",this.queryInfo)
      //更新门类信息
      this.$store.commit("material/getMmCategories", this.queryInfo.mbCate)
    },
    handleUpdate(){
      //更新列表
      this.$store.commit("material/getMaterialList",this.queryInfo)
    },
    handleDialogClose(done){
      this.$confirm('确认关闭？')
          .then(_ => {
            done();
          })
          .catch(_ => {});
    },
    handleNewMaterial(){
      console.log(this.newMaterialForm)
      const url = "material/newMaterial"
      axios.put(url,this.newMaterialForm).then(
          res => {
            if(res.data.code=="1010") {
              this.$message({
                type: 'success',
                message: res.data.message,
              })
            }else{
              this.$message({
                type: 'error',
                message: res.data.message,
              })
            }
            this.$refs.materialForm.resetFields()
          }).catch(
          error => {
            console.log(error)
      })
      this.dialogVisible = false
    }
  },
  watch:{
    //通过监视属性  提交申请
    msCategory: {
      handler: function (value){
        this.queryInfo.mbCate = "0"
        this.queryInfo.mmCate = "0"
        this.$store.state.material.Categories.mmCategories = []
        if(value == ""){
          this.handleUpdate()
        }else {
          this.$store.commit("material/querySpecific",value)
        }
      }
    },
    mbCode:{
      handler(value){
        //更新查询信息
        this.newMaterialForm.mmCode = ""
        //更新门类信息
        this.$store.commit("material/getMmCategories", value)
      }
    }
  },
  created(){
    this.$store.commit("material/getMaterialList",this.queryInfo)
  }

}
</script>

<style scoped>
  .searchBox{
    margin-left: 100px;
  }

  .el-form{
    align-items: flex-start;
    justify-content: left;
  }
</style>
