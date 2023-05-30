# **港口物资管理系统**
**************
## **1.文件说明**
1. <font color="aqua">*materialManage*</font>为后端服务器文件，采用SpringBoot架构.
2. <font color="aqua">*materials-management-system*</font>为前端文件，在Node.js下使用Vue.js 2进行运行.
3. <font color="aqua">*material_manage.sql*</font>为数据库脚本文件，使用数据库为Mysql，版本为mysql-5.7.20-winx64.
4. 本系统采用的java_jdk版本为1.8.
## **2.项目前端**
>**配置**
>1. <font color="#C0D9D9">**端口号：8080**
>2. **代码组件风格：element-ui，awesome图标包**
>3. **信息交互：axios**

>**运行**
>1. **安装Node.js，本系统采用的版本为14.17.4**
>2. **在终端运行 *npm install -g @vue/cli* 安装Vue脚手架**
>3. **运行 *npm install* 安装所需依赖包**
>4. **终端输入命令 *npm run serve*即可在本地运行项目前端**

## **3.项目后端**
>**配置**
>1. **java版本：java1.8**
>2. **包管理器：Maven**
>3. **Redis版本：3.0.504，本地服务运行即可**
>4. **端口：5000**
>5. **数据库及日志配置请见 *application.yml***
>6. **项目依赖包请见 *pom.xml***

>**运行**
>1. **下载安装对应的java版本以及数据库版本，运行数据库脚本文件生成对应的数据库**
>2. **修改 *application.yml* 中的数据库配置为你本地数据库**
>3. **使用Maven管理器下载对应依赖包**
>4. **运行项目即可**