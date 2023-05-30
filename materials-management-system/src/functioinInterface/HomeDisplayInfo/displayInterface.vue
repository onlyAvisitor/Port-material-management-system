<template>
  <div>
    <el-row>
      <el-col :span="20" class="portImgInfo" align="center">
        <el-carousel :interval="4000" type="card" height="300px">
          <el-carousel-item v-for="item in imgList" :key="item.id">
            <el-image :src="item.src"></el-image>
          </el-carousel-item>
        </el-carousel>
      </el-col>
    </el-row>
    <el-row :gutter="20">
      <el-col :span="14" align="center" class="purchasePlanInfo">
        <div>
          <el-card style="background: radial-gradient(circle,#ffffff,#f8f4e6,#e9e4d4,#dcd3b2);height: 400px">
            <div slot="header" class="clearfix">
              <span style="float: left;font-size: 14px;font-weight: bold">采购计划</span>
              <el-button @click="checkIntoStockRecords" style="float: right; padding: 3px 0;text-decoration:underline;" type="text">更多...</el-button>
            </div>
            <div v-for="(item,index) in PlanList.slice(0,10)" :key="item.planId">
              <el-row>
                <h5 style="float: left" @click="checkIntoStockRecords">
                  {{ (index+1)+"、"+item.planClass+"发布"}}
                </h5>
                <h5 style="float: right">{{"发布人："+item.userName+" "+item.releaseTime}}</h5>
              </el-row>
            </div>
          </el-card>
          <el-card style="margin-top:20px;background: radial-gradient(circle,#ffffff,#fbfaf5,#f3f3f3,#f3f3f2,#e0f0e9);height: 400px">
            <div slot="header" class="clearfix">
              <span style="float: left;font-size: 14px;font-weight: bold">员工入职</span>
              <el-button @click="checkOutStockRecords" style="float: right; padding: 3px 0;text-decoration:underline;" type="text">更多...</el-button>
            </div>
            <el-divider></el-divider>
            <div v-for="(item,index) in UserList.slice(0,10)" :key="item.id">
              <el-row>
                <h5 style="float: left" @click="checkOutStockRecords">
                  {{ (index+1)+"."+item.username+"任职"+item.jobName+",部门："+item.departName}}
                </h5>
                <h5 style="float: right">{{item.accessTime}}</h5>
              </el-row>
            </div>
          </el-card>
        </div>
      </el-col>
      <el-col :span="6" align="center">
        <div>
          <el-card style="background: radial-gradient(circle,#ffffff,#f8f4e6,#ede4cd,#e9e4d4);height: 400px">
            <div slot="header" class="clearfix">
              <span style="float: left;font-size: 14px;font-weight: bold">入库信息</span>
              <el-button @click="checkIntoStockRecords" style="float: right; padding: 3px 0;text-decoration:underline;" type="text">更多...</el-button>
            </div>
            <div v-for="(item,index) in IntoStockRecords.slice(0,10)" :key="item.id">
              <el-row>
                <span style="float: left" @click="checkIntoStockRecords">
                  {{ (index+1)+"、"+item.intoSum+item.unit+item.msCategory+"已入库"}}
                </span>
                <span style="float: right">{{item.generateTime}}</span>
              </el-row>
            </div>
          </el-card>
          <el-card style="margin-top:20px;background: radial-gradient(circle,#ffffff,#fbfaf5,#f3f3f3,#f3f3f2,#e5e4e6);height: 400px">
            <div slot="header" class="clearfix">
              <span style="float: left;font-size: 14px;font-weight: bold">出库信息</span>
              <el-button @click="checkOutStockRecords" style="float: right; padding: 3px 0;text-decoration:underline;" type="text">更多...</el-button>
            </div>
            <div v-for="(item,index) in OutStockRecords.slice(0,10)" :key="item.id">
              <el-row>
                <span style="float: left" @click="checkOutStockRecords">
                  {{ (index+1)+"."+item.outNumber+item.quantityUnit+item.msCategory+"已出库，被"+item.departName+"取走"}}
                </span>
                <span style="float: right">{{item.outStockTime}}</span>
              </el-row>
            </div>
          </el-card>
        </div>
      </el-col>
    </el-row>
  </div>
</template>

<script>
export default {
  name: "displayInterface",
  data(){
    return {
      imgList: [
        {id: 1, src: require('@/assets/img/port_1.jpg')},
        {id: 2, src: require('@/assets/img/port_2.jpg')},
        {id: 3, src: require('@/assets/img/port_3.jpg')},
        {id: 4, src: require('@/assets/img/port_4.jpg')}
      ],
    }
  },
  computed:{
    IntoStockRecords(){
      return this.$store.getters["stock/getAllIntoStockRecords"]
    },
    OutStockRecords(){
      return this.$store.getters["stock/getAllOutStockRecords"]
    },
    PlanList(){
      return this.$store.getters["subscribe/getAllPlanList"]
    },
    UserList(){
      return this.$store.getters["HRManage/getAllUsers"]
    }
  },
  methods:{
    checkIntoStockRecords(){
      this.$router.push("/regulate/inventoryManagement")
    },
    checkOutStockRecords(){
      this.$router.push("/regulate/outboundHandle")
    }
  },
  created() {
    this.$store.commit("stock/requestAllIntoRecords")
    this.$store.commit("stock/requestAllOutRecords")
    this.$store.commit("subscribe/getAllPlanList")
    this.$store.commit("HRManage/getAllUsers")
  }
}
</script>

<style scoped>
.portImgInfo{
  margin-left: 120px;
  height:300px;
}
.el-carousel__item h3 {
  color: #475669;
  font-size: 14px;
  opacity: 0.75;
  line-height: 200px;
  margin: 0;
}

.el-carousel__item:nth-child(2n) {
  background-color: #99a9bf;
}

.el-carousel__item:nth-child(2n+1) {
  background-color: #d3dce6;
}
.default-scrollbar__wrap {
  overflow-x: hidden;
}
.purchasePlanInfo{
  margin-left: 120px;
}
span:hover{
  text-decoration: underline;
}
h5:hover{
  text-decoration: underline;
}
</style>
