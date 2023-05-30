<template>
  <el-card>
    <el-form
        ref="userQueryForm"
        :model="recordsQueryForm"
        label-position="left"
        label-width="80px"
        style="float: left"

    >
      <el-row>
        <el-col :span="6">
          <el-form-item prop="mbCode" label="物资类型:" >
            <el-select   v-model="recordsQueryForm.mbCode" size="mini" style="width: 100px;">
              <el-option label="所有" value="all">
              </el-option>
              <el-option
                  v-for="item in mbCategories"
                  :key="item.mbCode"
                  :label="item.mbCategory"
                  :value="item.mbCode"
              ></el-option>
            </el-select>
          </el-form-item>
        </el-col>
        <el-col :span="6" style="margin-left: 100px">
          <el-form-item prop="month" label="入库时间:" style="width: 100px;">
            <el-date-picker
                v-model="recordsQueryForm.month"
                type="month"
                format="yyyy 年 MM 月"
                placeholder="选择月"
                :clearable="false"
                size="mini"
            >
            </el-date-picker>
          </el-form-item>
        </el-col>
      </el-row>
    </el-form>
  </el-card>
</template>

<script>
export default {
  name: "recordsQuery",
  data(){
    return {
      recordsQueryForm:{
        month:new Date(),
        mbCode:"all",
      }
    }
  },
  computed:{
    mbCategories(){
      return this.$store.state.material.Categories.mbCategories
    },
  },
  watch:{
    recordsQueryForm:{
      deep:true,
      handler(){
        this.$store.commit("stock/requestIntoRecords",this.recordsQueryForm)
      }
    }
  },
  created() {
    this.$store.commit("material/getMbCategories")
    this.$store.commit("stock/requestIntoRecords",this.recordsQueryForm)
  }
}
</script>

<style scoped>
.el-form{
  align-items: flex-start;
  justify-content: left;
}
</style>
