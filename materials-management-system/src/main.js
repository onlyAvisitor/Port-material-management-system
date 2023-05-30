import Vue from 'vue'
import App from './App.vue'

//引入Vuex中的store
import store from "./store"

//引入路由
import router from "./router"

//引入font-awesome图标包
import 'font-awesome/css/font-awesome.min.css'

//引入elementui组件库
import ElementUI from 'element-ui';
//axios配置
import axios from 'axios'
axios.defaults.baseURL = 'http://localhost:5000'
Vue.prototype.axios = axios

Vue.use(ElementUI);
import 'element-ui/lib/theme-chalk/index.css';

Vue.config.productionTip = false

new Vue({
  render: h => h(App),
  store,
  router,
}).$mount('#app')
