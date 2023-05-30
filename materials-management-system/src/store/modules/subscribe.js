import axios from "axios";
const state = {
    //列表信息
    subscribeItems:[],
    planList:[],
    allPlanList:[],
    procurePlan:{},
    planDetails:[],
    //辅助信息
    Categories:{
        mbCategories:[],
        mmCategories:[],
        msCategories:[],
    },
    suppliers:[],
    purchaseItems:[],
}
const actions = {

}
const mutations = {
    getMbCate(state){
        const url= 'material/mbCategories'
        axios.get(url).then(
            res => {
                state.Categories.mbCategories = res.data.data
            }).catch(error => {
            console.log(error)
        })
    },
    getMmCate(state,mbCate){
        const url = `material/mmCategories/${mbCate}`
        axios.get(url).then(
            res => {
                state.Categories.mmCategories = res.data.data
            }).catch(error => {
            console.log(error)
        })

    },
    getMsCate(state,mmCate){
        const url = `material/msCategories/${mmCate}`
        axios.get(url).then(
            res => {
                state.Categories.msCategories = res.data.data
            }).catch(error => {
            console.log(error)
        })
    },
    getSuppliers(state){
        axios.get('material/suppliers').then(
            res => {
                state.suppliers = res.data.data
            }).catch(error => {
                console.log(error)
        })
    },
    getPlanList(state,queryInfo){
        const url = "subscribe/planList"
        axios.get(url,{
            params:{
                month:queryInfo.month,
                planClass:queryInfo.planClass,
            }
        }).then(
            res =>{
                state.planList = res.data.data
            }
        ).catch(
            error => {
                console.log(error)
            }
        )
    },
    getAllPlanList(state){
        const url = "subscribe/allPlanList"
        axios.get(url).then(
            res =>{
                state.allPlanList = res.data.data
            }
        ).catch(
            error => {
                console.log(error)
            }
        )
    },
    getPlanDetails(state,procurePlan){
        const url = "subscribe/planDetails"
        axios.get(url,{
            params:{
                planId:procurePlan.planId,
            }
        }).then(
            res => {
                state.planDetails = res.data.data
            }
        ).catch(
            error => {
                console.log(error)
            }
        )
    },
    getPurchaseItems(){
        const url="subscribe/purchaseItems"
        axios.get(url).then(
            res => {
                state.purchaseItems = res.data.data
            }
        ).catch(
            error => {
                console.log(error)
            }
        )
    },
}
const getters = {
    getAllPlanList(state) {
        return state.allPlanList
    }
}

export default {
    namespaced:true,
    state,
    actions,
    mutations,
    getters
}
