define(function(require,exports,module){

    var CheckForm = require('./checkForm');
    require('./lib/jquery.form.min.js');

    function Register(obj){
        this.attr = obj;
        this.form = $(obj.form);
        this._init();
    }

    Register.prototype._init = function(){
        var _self = this;
        //监听
        _self.form.on('submit',function(){
            if(_self.getResult()){
                _self.submit();
            }
            return false;
        });

        //点击清除
        _self.form.find('input').on('click',function(){

        })
    };

    //检测表单
    Register.prototype.getResult = function(){
        var checkForm = new CheckForm(this.form);

           var pwd = $('#pwd').val();
           var pwd2 = $('#pwd2').val();
           if(checkForm.getResult()){
               if(pwd == pwd2){
                   return true;
               }else{
                   $('#pwd').after('<span class="help-block">密码不匹配</span>');
                   $('#pwd').parents('.form-group').addClass('has-error');
                   return false;
               }
           }else{
               return false;
           }

    };

    //提交
    Register.prototype.submit = function(){
        var _self = this;
        _self.form.ajaxSubmit({
            success:function(data){
                if(data == 'success'){
                    _self.form.find('#registerButton').text('注册成功。。。即将返回首页');
                    setTimeout(function(){
                        location.href = '/'
                    },1500)
                }else{
                   $('#registerButton').append('<span class="help-block">'+data+'</span>');
                }
            }
        })
    };

    module.exports = Register;
});