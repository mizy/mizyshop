/**
 * Created by Mizy on 14-10-10.
 * @class for select dropDown List
 * @author mizy
 */
define(function(require,exports,module){

    var _ATTR = {
        listen:'.matchItem',
        listenType:'click',
        url:'',
        ulId:'#selectTreeUl'
    };

    function SelectTree(attr){
       this.config = $.extend({},_ATTR,attr);
    }

    SelectTree.prototype.init = function(){
        var _self = this;
        _self.addListener();
    };

    SelectTree.prototype.addListener = function(){
        var _self = this;

        //改变值
        $(document).on(_self.config.listenType,_self.config.listen,function(){
            $(_self.config.ulId).show();
            _self.getData($(this).val());
        });
        //选择下拉框数据
        $(document).on('click',_self.config.ulId+" li",function(){
            var value = $(this).attr('data-value');
            $(_self.config.listen).addClass('successBorder');
            $(_self.config.listen).attr('data-id',value);
            $(_self.config.listen).val($(this).text());
            $(_self.config.ulId).hide();
        })

    };

    SelectTree.prototype.getData = function(value){
        var _self = this;
        $.ajax({
            url:_self.config.url,
            data:{query:value},
            type:'post',
            dataType:'json',
            success:function(data){
                var x,
                    html='',dom;
                if($(_self.config.ulId).length>0){
                    dom = $(_self.config.ulId);
                }else{
                    dom = $('<ul class="selectTree" id="'+_self.config.ulId+'" class="selectTreeUl"></ul>');
                }
                for( x in data){
                    html = html+'<li data-id="'+data[x].id+'" >'+data[x].title+'</li>';
                }
                dom.html('');
                dom.append(html);
            }

        })
    };


    module.exports = SelectTree;
});