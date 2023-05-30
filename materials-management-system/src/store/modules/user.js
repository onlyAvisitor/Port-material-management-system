const state = {
    userinfo:{},
}
const actions = {

}
const mutations = {
    userLogin(state,loginData) {
        state.userinfo = loginData.data
        localStorage.setItem('userInfo',JSON.stringify(state.userinfo))
    },
    setUserInfo(state){
        state.userinfo = JSON.parse(localStorage.getItem("userInfo"))
    }
}

const getters = {
    getUserInfo(state){
        return state.userinfo
    }
}

export default {
    namespaced:true,
    state,
    actions,
    mutations,
    getters
}
