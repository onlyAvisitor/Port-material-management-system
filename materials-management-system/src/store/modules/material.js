import axios from "axios";

const state = {
    //表格信息
    materialInfo:{
        tableData:[],
        currentPage:1,
        pageSize:10,
        total:0
    },
    //物资类别信息
    Categories:{
        mbCategories:[],
        mmCategories:[],
        msCategories:[],
    },
    //请求物资信息:
    queryCate:{
        mbCategory:'all',
        mmCategory:'all',
    }

}
const actions = {

}
const mutations = {
    getMaterialList(state,queryInfo) {
        const url_1 = 'material/list'
        axios.get(url_1,{
            params:{
                currentPage:state.materialInfo.currentPage,
                pageSize:state.materialInfo.pageSize,
                mbCateId:queryInfo.mbCate,
                mmCateId:queryInfo.mmCate,
            }
        }).then(
            res => {
                state.materialInfo.total = res.data.data.total
                state.materialInfo.tableData = res.data.data.records
            }).catch(error => {
            console.log(error)
        })
        //请求大类信息
        const url_2 = 'material/mbCategories'
        axios.get(url_2).then(
            res => {
                state.Categories.mbCategories = res.data.data
            }).catch(error => {
            console.log(error)
        })
    },
    getMbCategories(state){
        const url = 'material/mbCategories'
        axios.get(url).then(
            res => {
                state.Categories.mbCategories = res.data.data
            }).catch(error => {
            console.log(error)
        })
    },
    getMmCategories(state,mbCate){
        if(mbCate == "0"){
            state.Categories.mmCategories = []
        }else {
            const url = `material/mmCategories/${mbCate}`
            axios.get(url).then(
                res => {
                    state.Categories.mmCategories = res.data.data
                }).catch(error => {
                console.log(error)
            })
        }
    },
    //查找具体物资
    querySpecific(state,msCate){
        const url = `material/msCate/${msCate}/${state.materialInfo.currentPage}/${state.materialInfo.pageSize}`
        axios.get(url).then(
            res => {
                state.materialInfo.total = res.data.data.total
                state.materialInfo.tableData = res.data.data.records
            }).catch(error => {
            console.log(error)
        })
    },
    getMsList(state){
        const url = "material/msList"
        axios.get(url).then(
            res => {
                state.Categories.msCategories = res.data.data
            })
    }
}

const getters = {

}

export default {
    namespaced:true,
    state,
    actions,
    mutations,
    getters
}
