import Vue from "vue";
import Vuex from "vuex"


import user from "./modules/user"
import material from "@/store/modules/material";
import subscribe from "@/store/modules/subscribe";
import HRManage from "@/store/modules/HRManage";
import stock from "@/store/modules/stock";
//应用Vuex
Vue.use(Vuex)
export default new Vuex.Store({
    modules:{
        user,
        material,
        subscribe,
        HRManage,
        stock
    }
})
