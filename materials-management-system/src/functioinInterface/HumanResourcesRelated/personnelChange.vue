<template>
  <el-tabs v-model="activeName" @tab-click="handleClick" type="border-card">
    <el-tab-pane name="Job_change">
      <span slot="label"><i class="fa fa-user-plus"></i>职位变迁</span>
      <UserQuery></UserQuery>
      <userInfoCard></userInfoCard>
    </el-tab-pane>
    <el-tab-pane name="Resignation">
      <span slot="label"><i class="fa fa-user-times"></i>离职处理</span>
    </el-tab-pane>
  </el-tabs>
</template>

<script>
import UserQuery from "@/components/Query/userQuery";
import UserInfoCard from "@/components/Card/userInfoCard";
export default {
  name: "personnelChange",
  components:{
    UserInfoCard,
    UserQuery
  },
  data() {
    return {
      activeName: "Job_change",

    }
  },
  methods:{
    handleClick(tab, event) {
      console.log(tab, event);
    }
  }
}
</script>

<style scoped>

</style>
