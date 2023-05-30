<template>
  <el-row>
    <el-col>
      <el-menu
          :default-active="$route.path.substring(10)"
          class="leftMenu"
          background-color="#393e46"
          text-color="#eeeeee"
          router
          unique-opened
          active-text-color="#00adb5">
        <el-submenu index="1">
          <template slot="title">
            <i class="fa fa-ship"> </i>
            <span>采购管理</span>
          </template>
          <el-menu-item-group>
            <template slot="title">物资申购</template>
              <el-menu-item index="procureSubmit">采购申请</el-menu-item>
              <el-menu-item index="showPlanList">采购信息</el-menu-item>
          </el-menu-item-group>
        </el-submenu>
        <el-menu-item index="materialList">
          <i class="fa fa-file-text"></i>
          物资信息
        </el-menu-item>
        <el-submenu index="2">
          <template slot="title">
            <i class="fa fa-users"></i>
            <span> 人事管理</span>
          </template>
          <el-menu-item-group>
            <template slot="title">员工管理</template>
            <el-menu-item index="employeeRegis">员工登记</el-menu-item>
            <el-menu-item index="personnelChange">人事变动</el-menu-item>
          </el-menu-item-group>
          <el-menu-item-group>
            <template slot="title">部门信息</template>
            <el-menu-item index="jobInfo">职位信息</el-menu-item>
            <el-menu-item index="2-4">部门分工</el-menu-item>
          </el-menu-item-group>
        </el-submenu>
        <el-submenu index="3">
          <template slot="title">
            <i class="fa fa-cubes"> </i>
            <span>库存管理</span>
          </template>
          <el-menu-item-group>
            <template slot="title">库存信息</template>
            <el-menu-item index="showStockInfo">仓库信息</el-menu-item>
          </el-menu-item-group>
          <el-menu-item-group>
            <template slot="title">物资流调</template>
            <el-menu-item index="inventoryManagement">入库管理</el-menu-item>
            <el-submenu index="materialList">
              <template slot="title">
                <span>出库相关</span>
              </template>
              <el-menu-item index="outboundDeclaration">出库申请</el-menu-item>
              <el-menu-item index="outboundHandle">出库处理</el-menu-item>
            </el-submenu>
          </el-menu-item-group>
        </el-submenu>
        <el-menu-item index="4">
          <i class="fa fa-money"></i>
          <span slot="title">账单信息</span>
        </el-menu-item>
      </el-menu>
    </el-col>
  </el-row>
</template>

<script>
export default {
  name: "leftSideBar",
  methods:{
  }
}
</script>

<style scoped>
  .leftMenu{
    height: 100vh;
    width: 205px;
  }
</style>
