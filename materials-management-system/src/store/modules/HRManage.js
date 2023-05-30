import axios from "axios";

const state = {
    ListInfo:{
        departList:[],
        jobList:[],
        userList:[],
    },
    allUsers:[],
    queryUser:{

    },
    total:0,
}
const actions = {

}
const mutations = {
    getDepartments(state){
        const url = "HRManage/departments"
        axios.get(url).then(
            res => {
                state.ListInfo.departList = res.data.data
            }).catch(
            error => {
                console.log(error)
            })
    },
    getJobs(state,depart){
        const url = "HRManage/jobs"
        axios.get(url,{
            params:{
                departNo:depart,
            },
            }).then(
                res => {
                    state.ListInfo.jobList = res.data.data
                }).catch(
                error => {
                    console.log(error)
        })
    },
    getUsers(state,queryInfo){
        const url = "HRManage/users"
        axios.get(url,{
            params:{
                departNo: queryInfo.departNo,
                jobId: queryInfo.jobId,
                currentPage: queryInfo.currentPage
            }}).then(
                res => {
                    state.ListInfo.userList = res.data.data.records
                    state.total = res.data.data.total
                }).catch(
                error =>{
                    console.log(error)
        })
    },
    getAllUsers(state){
        const url = "HRManage/getAllUsers"
        axios.get(url).then(
            res => {
                state.allUsers = res.data.data
            }).catch(
            error => {
                console.log(error)
            }
        )
    },
    queryUsers(state,jobId){
        const url = "HRManage/usersByJob"
        axios.get(url,{
            params:{
                jobId:jobId
            }}).then(
                res => {
                    state.ListInfo.userList = res.data.data
                }).catch(
                error => {
                    console.log(error)
        })
    },
    queryUser(state,queryInfo){
        const url = "HRManage/user"
        axios.get(url,{
            params:{
                departId:queryInfo.departId,
                jobId:queryInfo.jobId,
                username:queryInfo.username,
            }}).then(
                res => {
                    state.queryUser = res.data.data
                }).catch(
                error => {
                    console.log(error)
        })
    }
}

const getters = {
    getAllUsers(state) {
        return state.allUsers
    }
}

export default {
    namespaced:true,
    state,
    actions,
    mutations,
    getters
}
