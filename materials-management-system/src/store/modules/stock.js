import axios from "axios";
const state = {
    depotList:[],
    shelvesList:[],
    intoStocks:[],
    depotId:"",
    availableShelves:[],
    intoStockRecords:[],
    allIntoStockRecords:[],
    //出库申请列表
    outboundApplicationsList:[],
    MaterialsToBeOutList:[],
    //出库用货架列表
    outShelvesList:[],
    outStockRecords:[],
    allOutStockRecords:[],
}
const actions = {

}
const mutations = {
    requestDepotList(state) {
        const  url = "stock/depotList"
        axios.get(url).then(
            res => {
                state.depotList = res.data.data
            }
        ).catch(
            error => {
                console.log(error)
            }
        )
    },
    requestShelvesList(state,depotId){
        const url = "stock/shelvesList"
        state.depotId = depotId
        axios.get(url,{
            params:{
                depotId:depotId,
            }
        }).then(
            res => {
                state.shelvesList = res.data.data
            }
        ).catch(
            error => {
                console.log(error)
            }
        )
    },
    requestIntoStocks(state) {
        const url = "stock/intoStocks"
        axios.get(url).then(
            res => {
                state.intoStocks = res.data.data
            }
        ).catch(
            error => {
                console.log(error)
            }
        )
    },
    requestIntoStocksByMsCate(state,msCode){
        const url = "stock/getShelvesByMsCode"
        axios.get(url,{
            params:{
                msCode:msCode
            }
        }).then(
            res => {
                state.availableShelves = res.data.data
            }
        ).catch(
            error => {
                console.log(error)
            }
        )
    },
    requestIntoRecords(state,queryInfo){
        const url = "stock/intoStockRecords"
        axios.get(url,{
            params:{
                month:queryInfo.month,
                mbCode:queryInfo.mbCode
            }
        }).then(
            res => {
                state.intoStockRecords = res.data.data
            }
        )
    },
    requestAllIntoRecords(state){
        const url = "stock/allIntoStockRecords"
        axios.get(url,{
        }).then(
            res => {
                state.allIntoStockRecords = res.data.data
            }
        )
    },
    requestAllOutRecords(state){
        const url = "stock/getAllOutStockRecords"
        axios.get(url,{
        }).then(
            res => {
                state.allOutStockRecords = res.data.data
            }
        )
    },
    requestOutboundApplicationsList(state,queryInfo){
        const url = "stock/getStockOutApplications"
        axios.get(url,{
            params:{
                auditState:queryInfo.auditState,
                submitTime:queryInfo.dateTime
            }
        }).then(
            res => {
                state.outboundApplicationsList = res.data.data
            }
        ).catch(
            error => {
                console.log(error)
            }
        )
    },
    requestMaterialsToBeOut(state){
        const url = "stock/getMaterialsToBeOut"
        axios.get(url).then(
            res => {
                state.MaterialsToBeOutList = res.data.data
            }
        ).catch(
            error => {
                console.log(error)
            }
        )
    },
    requestShelvesByMsCode(state,msCode){
        const url = "stock/getShelvesEqMsCode"
        axios.get(url,{
            params:{
                msCode:msCode
            }
        }).then(
            res => {
                state.outShelvesList = res.data.data
            }
        ).catch(
            error => {
                console.log(error)
            }
        )
    },
    requestOutStockRecords(state,outTime){
        const url = "stock/getOutStockRecords"
        axios.get(url,{
            params:{
                outTime:outTime,
            }
        }).then(
            res=> {
                state.outStockRecords = res.data.data
            }
        ).catch(
            error => {
                console.log(error)
            }
        )
    }
}

const getters = {
    getOutStockRecords(state){
        return state.outStockRecords
    },
    getOutShelvesList(state){
        return state.outShelvesList
    },
    getDepotList(state){
        return state.depotList
    },
    getShelvesList(state){
        return state.shelvesList
    },
    getIntoStocks(state){
        return state.intoStocks
    },
    getAvailableShelves(state){
        return state.availableShelves
    },
    getIntoStockRecords(state){
        return state.intoStockRecords
    },
    getOutboundApplicationsList(state){
        return state.outboundApplicationsList
    },
    getMaterialsToBeOutList(state){
        return state.MaterialsToBeOutList
    },
    getAllIntoStockRecords(state){
        return state.allIntoStockRecords
    },
    getAllOutStockRecords(state){
        return state.allOutStockRecords
    }
}

export default {
    namespaced:true,
    state,
    actions,
    mutations,
    getters
}
