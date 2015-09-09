/**
 * 密码登录类 返回true or false
 * @param username 用户名选择器
 * @param password 密码选择器
 * @param verify 验证码选择器
 * @constructor 赋值
 */
define(function(require, exports, module) {
    var ApplyForm = function(username,password,verify,url){
        this.url = url;
        this.userNode = $(username);
        this.passNode = $(password);
        this.verifyNode = $(verify);
        this.username = $(username).val();
        this.password = $(password).val();
        this.verify = $(verify).val();
        this.status = "";
        this.removeWarning() ;
    };

    //检测表单为空
    ApplyForm.prototype.checkForm=function(){
        if(this.username == "" || this.username ==null){
            this.status = '0';return false;
        }
        if(this.password == "" || this.password ==null){
            this.status = '1'; return false;
        }
        if(this.verify == "" || this.verify ==null){
            this.status = '2';return false;
        }
        this.status = 'success';
        return true;
    };

    //检测验证码
    ApplyForm.prototype.checkVerify=function(){
        var _self = this;
        $.ajax({
            url:_self.url+'check_verify',
            type:'post',
            data:{code:_self.verify},
            success:function(data){
                if(data){
                    _self.checkPassword();
                    return true;
                }else{
                    _self.status='wrongVerify';
                    _self.getStatus();
                    return false;
                };
            }
        });

    };

    //检测密码正确
    ApplyForm.prototype.checkPassword=function(){
        var _self = this;
        $.ajax({
            url:_self.url+'login',
            type:'post',
            data:{username:_self.username,password:_self.password},
            success:function(data){
                if(data == 'success'){
                    var url = location.href;
                    if(url.indexOf('back_url')){
                        window.location.href = '/Home/Login/back'
                    }else{
                        window.location.reload();
                    }
                    return true;
                }else{
                    _self.status = 'wrongPassword';
                    _self.getStatus();
                    return false;
                };
            }
        });

    };

    //去除提示
    ApplyForm.prototype.removeWarning=function(){
        $("form input").focus(function(){
            $(this).parent().removeClass('has-warning');
            $(this).parent().parent().find('.tips').text("");
        })
    }


    //返回结果
    ApplyForm.prototype.getResult=function(){
        var _self = this;
        if( _self.checkForm() ){
            _self.checkVerify();
        }else{
            return _self.getStatus();
        }
        return false;

    };

    //获得异常状态
    ApplyForm.prototype.getStatus=function(){
        switch (this.status){
            case '0': this.userNode.parent().addClass('has-warning');return false;
            case '1': this.passNode.parent().addClass('has-warning');return false;
            case '2': this.verifyNode.parent().addClass('has-warning');return false;
            case 'wrongVerify':
                this.verifyNode.parent().addClass('has-warning');
                this.verifyNode.parent().parent().find('.tips').text('验证码错误');
                return false;
            case 'wrongPassword':
                this.passNode.parent().addClass('has-warning');
                $('#verifyCode')[0].src +="?m="+Math.random();
                this.passNode.parent().parent().find('.tips').text('用户名或密码错误');
                return false;
            default : return true;
        }

    };
    module.exports = ApplyForm;
})