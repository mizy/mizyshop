/**
 * Created by iblovem on 14-4-7.
 * @class login入口
 */
define(function(require, exports, module) {
    var LoginForm = require("./loginForm.js");

    //默认参数
    var ATTRS = {
        loginButton:"#loginButton"

    }

    function Login(opt){
        //构造函数
       this.attrs = $.extend(true,{},ATTRS,opt);
       this.init();
    }

    //初始化
   Login.prototype.init = function(){
       var _self = this;
       _self.addListener();
   };

   //监听函数
   Login.prototype.addListener = function(){
       //登录按钮监听
       $(this.attrs.loginButton).click(function(){
           var form = new LoginForm('#user_name','#password','#verify','./');
           return(form.getResult());
       });
   };

    module.exports = Login;
});



