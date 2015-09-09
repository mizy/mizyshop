/**
 * Created by Mizy on 14-10-10.
 */
define(function(require,exports,module){

    var SelectTree = require('selectTree');
    var CheckForm = require('checkForm');

    var ATTRS = {
        mod:false,
        submitForm:'#addMatchForm',
        info:false
    };
    function AddMatch(config){
        this.attr= $.extend({},ATTRS,config);
        this.item_data = '';
        this.imgData = [];
        this.imgModInfo = '';

    }

    AddMatch.prototype.init = function(){
      this.addListener();
      this.showData();
    };

    //回显
    AddMatch.prototype.showData = function(){
        var _self = this;
        var value = $('#itemCan').attr('data-value');

        value = value.split('_');
        var x,html='';
        for( x in value){
            var id  = value[x];
            $.ajax({
                url:'/Admin/Product/getItem/?id='+id,
                dataType:'json',
                success:function(data){
                    var text = data['title'];
                    var id = data['id'];
                    if(_self.attr.info){
                        html = '<li class=" list-group-item matchItem"  data-id="'+ id +'"><span>'+
                            ' '+ text+'&nbsp;&nbsp;&nbsp;  ID:'+id+'</span></li>';
                    }else{
                        html  = '<li class=" list-group-item matchItem"  data-id="'+ id +'"><span>'+
                            ' '+ text+'&nbsp;&nbsp;&nbsp;  ID:'+id+'</span><a href="#" class="del_btn pull-right">删除</a> </li>';
                    }
                    $('ul#itemCan').append(html);
                }
            });
        }

    };

    AddMatch.prototype.addListener = function(){
        var _self = this;

        //select2动态查询
        $('#itemSelect').select2({
            placeholder:'搜索商品名称或ID',
            allowClear: true,
            ajax:{
                url:"/Admin/Product/searchItem/",
                dataType:'json',
                data:function(term,page){
                    if(term==''){
                        return {query:'default'}
                    }
                    return{query:term}
                },
                results:function(data,page){
                    var each;
                    for( each in data){
                        data[each].text = data[each].title;
                    }
                    return {results:data}
                }
            },
            initSelection: function(element, callback) {
                var id=$(element).val();
                if (id!=="") {
                    $.ajax("/Admin/Product/getItem/?id="+id, {
                        dataType: "json"
                    }).done(function(data) {
                        data['text'] = data['title'];
                        callback(data); });
                }
            }
        });

        //继续添加按钮
        $('#add_match_gone').click(function(){
            var id = $('#itemSelect').val();
            var text = $('#s2id_itemSelect').find('.select2-chosen').text();
            var html = ' <li class=" list-group-item matchItem"  data-id="'+ id +'"><span>'+
                ' '+ text+'&nbsp;&nbsp;&nbsp;  ID:'+id+'</span><a href="#" class="del_btn pull-right">删除</a> </li>';
            $('#itemCan').append(html);
        });

        //删除
        $(document).on('click','a.del_btn',function(){
            $(this).parent().remove();
        });
        //图片删除
        $(document).on('click','a.img_delete_btn',function(){
            $(this).parent().addClass('hide');
        });

        //保存按钮
        $('#add_btn').click(function(){
            var checkForm = new CheckForm(_self.attr.submitForm);
            if(checkForm.getResult()){
                _self.saveForm();
            }
        });

        //添加函数
        $('#add_img').click(function(){
            $(this).before('<div class="col-sm-10 hotImg clear col-sm-offset-2">'
                +                   '<input  type="file" class="form-control file" name="hotImg">'
                +                    '<input type="hidden" value="" class="imgValue" name="hotImgValue" >'
                +                     '<input type="text" placeholder="描述" class="form-control hotImgDesc" >'
                +               '</div>')

        });

        //点击上传
        $(document).on('change','input.file',function(){
            var _this = this;

            $(_self.attr.submitForm).ajaxSubmit({
                url:'/Admin/Product/ajaxImgUpload',
                data:{name:'hotImg'},
                success:function(data){
                    if(data.status == 'success'){
                        var img = $(_this).parent().find('.input_img');
                        if(img.length<1){
                            $(_this).before('<img src="'+data.url+'" class="input_img" />')
                        }else{
                            img[0].src = data.url;
                        }
                        $(_this).parent().find('.imgValue').val(data.url);

                    }else{
                        alert('wrong!'+data);
                    }
                }
            })
        });
        //下拉框添加
       /* var selectT = new SelectTree({
            listenType:'change',
            url:'/Admin/Product/getItem/'
        });
        selectT.init();*/
    };

    //表单检测处理
    AddMatch.prototype.saveForm = function(){
        var _self = this;
        var item_data = '';
        $('.matchItem').each(function(index,obj){
            if($(obj).attr('data-id')!=''){
                if(index ==0){
                    item_data = $(obj).attr('data-id');
                }else{
                    item_data = item_data+'_'+$(obj).attr('data-id');
                }
            }
        });
        _self.item_data = item_data;

        //图片
        var data = [];
        $('.hotImg').each(function(index,obj){
            var dom = $(obj);
            if(dom.find('.imgValue').val() != ''){
                data[index] = {};
                data[index].url = dom.find('.imgValue').val();
                data[index].title = dom.find('.hotImgDesc').val();
            }
        });
        _self.imgData = JSON.stringify(data);

        //修改图片
        if(_self.attr.mod==true){
            var imgModInfo = {};
            $(".modImg").each(function(index,obj){
                var dom = $(obj);
                imgModInfo[index] = {};
                imgModInfo[index].id = dom.attr('data-id');
                imgModInfo[index].title =  dom.find('.hotImgDesc').val();
                if(!dom.hasClass('hide')){
                    imgModInfo[index].delete = 'false';
                }else{
                    imgModInfo[index].delete = 'true';
                }
            });
            imgModInfo = JSON.stringify(imgModInfo);
            _self.imgModInfo = imgModInfo;
        }
        _self.submitForm();

    };

    //提交表单
    AddMatch.prototype.submitForm = function(){
        var _self = this;
        $(_self.attr.submitForm).ajaxSubmit({
            data:{item_data:_self.item_data,imgData:_self.imgData,imgModInfo:_self.attr.imgModInfo},
            type:'post',
            success:function(data){
                if(data=='success'){
                    $('#add_btn').text('保存成功');
                    setTimeout(function(){
                        location.href = '/Admin/Product/match.html'
                    },1000);
                }else{
                    alert('wrong!:::'+data);
                }
            }
        });
        $('#add_btn').text('保存中......');

    };


    module.exports = AddMatch;
});