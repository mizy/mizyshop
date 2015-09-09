/**
 * Created by Mizy on 14-9-24.
 */
define(function(require,exports,module){


    function _eval(str){
        if(!!(window.attachEvent && !window.opera)){  //浏览器识别
           return  execScript(str);
        }else{
           return eval(str);
        }

    }

    function CheckForm(form){
        this.result = true;
        this.removeWarning();
        this.checkForm(form);

    }


    CheckForm.prototype.removeWarning = function(){
        $("a").click(function(){
            //去除错误提示
            $('.has-error').each(function(){
                $(this).removeClass('.has-error');
                $(this).find('.help-block').remove();
            });
        });
        $("button").click(function(){
            //去除错误提示
            $('.has-error').each(function(){
                $(this).removeClass('.has-error');
                $(this).find('.help-block').remove();
            });
        });
        //去除提升
        $("input").click(function(){
            $(this).parents('.has-error').removeClass('has-error');
            $(this).parent().find('.help-block').remove();
        })

    };

    CheckForm.prototype.checkForm = function(formObj){
        var _self = this;
        var form = $(formObj);
        var input = $("input[data-check]");
        var x, reg,tip,data_check;

        if(input.length>0){
            for(x =0;x<input.length;x++){

                data_check = _eval($(input[x]).attr('data-check'));
                reg = new RegExp(data_check[0]);
                tip = data_check[1];

                //每条都检查
                if(!reg.test($(input[x]).val())){
                    input[x].focus();
                    $(input[x]).parents('.form-group').addClass('has-error');
                    tip = '<span class="help-block">'+tip+'</span>';
                    $(input[x]).parent().append(tip)
                    _self.result =false;
                }

            }
        }


    };

    CheckForm.prototype.getResult = function(){
        return this.result;
    };
    module.exports = CheckForm;
});