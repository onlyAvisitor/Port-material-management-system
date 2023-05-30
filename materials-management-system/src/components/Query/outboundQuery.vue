<template>
  <el-card>
    <el-form
        ref="outboundQueryForm"
        :model="queryInfo"
        label-position="left"
        label-width="80px"
        style="float: left"
    >
      <el-row>
        <el-col :span="6">
          <el-form-item prop="auditState" label="审核状态:" >
            <el-select   v-model="queryInfo.auditState" size="mini" style="width: 100px;">
              <el-option
                  v-for="item in auditList"
                  :key="item.id"
                  :label="item.label"
                  :value="item.id"
              ></el-option>
            </el-select>
          </el-form-item>
        </el-col>
        <el-col :span="6" style="margin-left: 100px">
          <el-form-item prop="month" label="申请时间:" style="width: 100px;">
            <el-date-picker
                v-model="queryInfo.dateTime"
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
  name: "outboundQuery",
  data(){
    return {
      queryInfo:{
        auditState:1,
        dateTime:new Date(),
      },
      auditList:[
        {
          id: 0,
          label: "全部",
        },
        {
          id: 1,
          label: "未通过",
        },
        {
          id: 2,
          label: "已审核",
      }],
    }
  },
  watch:{
    queryInfo:{
      deep:true,
      handler(){
        this.$store.commit("stock/requestOutboundApplicationsList",this.queryInfo)
      }
    }
  },
  mounted() {
    this.$store.commit("stock/requestOutboundApplicationsList",this.queryInfo)
  }
}
</script>

<style scoped>
.el-form{
  align-items: flex-start;
  justify-content: left;
}
</style>
