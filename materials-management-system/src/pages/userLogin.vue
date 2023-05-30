<template>
  <div class="body-container">
    <div class="container" id="container">
      <div>
        <!-- 注册 -->
        <div class="form-container sign-up-container">
          <form action="#">
            <h1>注册账户</h1>
            <input type="text" placeholder="username" />
            <input type="email" placeholder="Email" />
            <input type="password" placeholder="Password" />
            <div class="btn-grad">注册账号</div>
          </form>
        </div>
        <div class="form-container sign-in-container">
          <!--    登录     -->
          <form action="#">
            <h1>登录</h1>
            <input type="text" v-model="loginForm.username" placeholder="username" />
            <input type="password" v-model="loginForm.password" placeholder="password" />
            <a href="#">忘记密码?</a>
            <div class="btn-grad" @click="userLogin">登录</div>
          </form>
        </div>
      </div>
      <!--界面跳转-->
      <div>
        <div class="overlay-container">
          <div class="overlay">
            <div class="overlay-panel overlay-left">
              <h1>加入我们</h1>
              <p>
                Start from where you left
              </p>
              <div class="btn-grad" id="signIn"  @click="toLogin">登录</div>
            </div>
            <div class="overlay-panel overlay-right">
              <h1>欢迎来到物资管理</h1>
              <p>创建一个账号？</p>
              <div class="btn-grad" id="signUp" @click="toRegister">注册</div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import axios from "axios";
export default {
  name: "userLogin",
  data() {
    return{
      loginForm:{
        username:"",
        password:"",
      }
    }
  },
  methods: {
    //页面控制
    toRegister(){
      const container = document.getElementById('container');
      container.classList.add('right-panel-active');
    },
    toLogin(){
      const container = document.getElementById('container');
      container.classList.remove('right-panel-active');
    },

    //登录逻辑
    userLogin(){
        axios.post("user/login", this.loginForm).then(
              res => {
                /**
                 * 登陆成功
                 */
                if(res.data.code == "1010") {
                  this.$store.commit("user/userLogin", res.data)
                  this.$router.push("/navigate")
                }else{
                  this.$alert(`登陆失败:${res.data.message}`, '消息提示', {
                    confirmButtonText: '确定',
                    callback: action => {
                      this.$message({
                        type: 'success',
                        message: `已确认`,
                      });
                      //刷新界面
                      this.$router.go(0)
                    }
                  })
                }

          }).catch(error => {
            console.log(error)
            return false
        })
    }
  }
}
</script>

<style scoped>
  @import "../assets/css/style.css";
</style>
