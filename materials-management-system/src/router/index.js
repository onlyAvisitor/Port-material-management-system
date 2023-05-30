import Vue from "vue"

import VueRouter from "vue-router";

Vue.use(VueRouter)

//引入组件

//引入页面
import userLogin from "@/pages/userLogin";
import regulatePage from "@/pages/regulatePage";
import materialTable from "@/components/tables/materialTable";
import navigationPage from "@/pages/navigationPage";
import jobInformation from "@/components/tables/jobInformation";
import employeeRegis from "@/functioinInterface/HumanResourcesRelated/employeeRegis";
import personnelChange from "@/functioinInterface/HumanResourcesRelated/personnelChange";
import procureSubmit from "@/functioinInterface/ProcureManage/procureSubmit";
import showProcurePlan from "@/functioinInterface/ProcureManage/showProcurePlan";
import showPlanDetail from "@/functioinInterface/ProcureManage/showPlanDetail";
import showStockInfo from "@/functioinInterface/StockInfo/showStockInfo";
import showShelves from "@/functioinInterface/StockInfo/showShelves";
import inventoryManagement from "@/functioinInterface/StockInfo/inventoryManagement";
import IntoStockInfo from "@/functioinInterface/StockInfo/IntoStockInfo";
import displayInterface from "@/functioinInterface/HomeDisplayInfo/displayInterface";
import announcement from "@/functioinInterface/HomeDisplayInfo/announcement";
import outboundDeclaration from "@/functioinInterface/StockInfo/outboundDeclaration";
import outboundHandle from "@/functioinInterface/StockInfo/outboundHandle";
import outboundConfirm from "@/functioinInterface/StockInfo/outboundConfirm";


//创建一个路由器
export default new VueRouter({
    mode:'history',
    //存放键值对
    routes:[
        //一开始为登陆界面
        {
            name: 'login',
            path: '/login',
            component: userLogin,
        },
        {
            name: 'init',
            path: '/',
            redirect: '/login'
        },
        {
            //主导航界面
            name: 'navigate',
            path: '/navigate',
            component: navigationPage,
            meta:{ title:'首页'},
            children:[
                {
                    name: 'initMain',
                    path: '/',
                    redirect: 'displayInterface',
                },
                {
                    path: 'displayInterface',
                    component: displayInterface,
                },
                {
                    path: 'announcement',
                    component: announcement,
                }
            ]
        },
        {
            //管理界面
            name: 'regulate',
            path: "/regulate",
            component: regulatePage,
            meta:{ title:'管理系统'},
            children:[
                {
                    //默认路径
                    name: 'init',
                    path: '/',
                    redirect: 'showPlanList'
                },
                //物料采购
                {
                    path: "materialList",
                    component: materialTable,
                    meta: { title:'物资信息'},
                },
                {
                    path: "procureSubmit",
                    component: procureSubmit,
                    meta: { title:'采购申请'},
                },
                {
                    path: "showPlanList",
                    component: showProcurePlan,
                    meta: { title:'采购信息'},
                },
                {
                    path: "showPlanDetail",
                    component: showPlanDetail,
                    meta: { title:'计划明细'},
                },
                //人事管理
                {
                    path: "jobInfo",
                    component: jobInformation,
                    meta: { title:'职位信息'},
                },
                {
                    path: "employeeRegis",
                    component: employeeRegis,
                    meta: { title:'员工登记'},
                },
                {
                    path: "personnelChange",
                    component: personnelChange,
                    meta: { title:'职位变迁'},
                },
                //库存管理
                {
                    path: "showStockInfo",
                    component: showStockInfo,
                    meta: { title:'库存信息'},
                },
                {
                    path: "showShelvesList",
                    component: showShelves,
                    meta: { title:'货架详情'},
                },
                {
                    path: "inventoryManagement",
                    component: inventoryManagement,
                    meta: { title:'入库管理'},
                },
                {
                    path: "intoStock",
                    component: IntoStockInfo,
                    meta: { title:'入库登记'},
                },
                {
                    path:"outboundDeclaration",
                    component: outboundDeclaration,
                    meta: { title: '出库申报' },
                },
                {
                    path: "outboundHandle",
                    component: outboundHandle,
                    meta: {title: '出库处理'}
                },
                {
                    path: "outboundConfirm",
                    component: outboundConfirm,
                    meta: { title: '出库确认'},
                }
            ],
        }
    ]
})
