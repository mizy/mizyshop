define(function(require,exports,module){
   var CheckForm = require('checkForm');
    function AddProduct(){
    }

    AddProduct.prototype.init = function(){
        var _self = this;
        _self.addListener();
    };

    //监听函数
    AddProduct.prototype.addListener = function(){
        var _self = this;

        //根据类型显示不同的其它属性
        $('select#pd_category').on('change',function(e){
            e.preventDefault();
            var id = $('#pd_category').val();
            $('.ot_tab').hide();
            switch (id){
                case '0':$('#ot_fushi').show();break;
                case '1':$('#ot_peijian').show();break;
                case '2':$('#ot_jiafang').show();break;
            }
        });

        //添加条目
        $(document).on('click','a.add_size_btn',function(){
            $(this).before('<input class="form-control size_input" type="text"  placeholder="" value="" />');
        });
        $(document).on('click','a.add_color_btn',function(){
            $(this).before(
                '<div  class="col-sm-4  clear col-sm-offset-2 addImg">' +
                    '<input class="form-control file" name="color" type="file" />' +
                '<input class="form-control img_desc" type="text"  placeholder="描述"   />' +
                '<input type="hidden" class="imgValue" value="">' +
                    '<a class="del_btn">删除</a>' +
                    '</div>')
        });
        $(document).on('click','a.add_desc_btn',function(){
            $(this).before('<div  class="col-sm-4  clear col-sm-offset-2 addImg">' +
                '<input class="form-control file" name="desc" type="file" />' +
                '<input class="form-control img_desc" type="text"  placeholder="描述" value="" />' +
                '<input type="hidden" class="imgValue" value="">' +
                '<a class="del_btn">删除</a> '+
                '</div>'

            );
        });

        //点击上传图片
        $(document).on('change','input.file',function(){
            var _self = this;
            var text0 =  $(_self).parent().find('a').text();
            $(_self).parent().find('a').text('上传中。。。');
            $('#addProductForm').ajaxSubmit({
                url:'/Admin/Class/ajaxImgUpload',
                data:{name:$(_self).attr('name')},
                success:function(data){
                    if(data.status == 'success'){
                        var img = $(_self).parent().find('.input_img');
                        if(img.length<1){
                            $(_self).before('<img src="'+data.url+'" class="input_img" />')
                        }else{
                            img[0].src = data.url;
                        }
                        $(_self).parent().find('.imgValue').val(data.url);

                        $(_self).parent().find('a').text(text0);
                    }else{
                        alert('wrong!'+data);
                    }
                }
            })
        });


        //提交表单
        $('#add_btn').click(function(){
            var checkForm = new CheckForm('#addProductForm');
            if(checkForm.getResult()){
                _self.submitForm()
            }
        });

    };

    //表单提交
    AddProduct.prototype.submitForm = function(){
        var size='',desc='',data='',category='';
        var module = $('#pd_category').val();

        //图片信息传递上去
        //主要图片商品描述
        var itemImg = [];
        $('div#phototab .addImg').each(function(index,obj){
            itemImg[index] = {};
            itemImg[index]['url'] = $(obj).find('.imgValue').val();
            itemImg[index]['title'] = $(obj).find('.img_desc').val();
        });
        itemImg = JSON.stringify(itemImg);

        switch (module){
            case '0':
                var imgDesc = [];
                //商品尺寸
                $('div#ot_fushi .size_input').each(function(index,obj){
                    if(obj.value!=''){
                        if(index==0){
                            size = obj.value;
                        }else{
                            size = size + '_'+ obj.value ;
                        }
                    }
                });
                //商品描述
                $('div#ot_fushi .addImg').each(function(index,obj){
                    imgDesc[index] = {};
                    imgDesc[index]['url'] = $(obj).find('.imgValue').val();
                    imgDesc[index]['title'] = $(obj).find('.img_desc').val();
                });
                imgDesc = JSON.stringify(imgDesc);
                data = {size:size,imgDesc:imgDesc,itemImg:itemImg};
                break;
            case '1':
                //商品尺寸
                $('div#ot_peijian .size_input').each(function(index,obj){
                    if(obj.value!=''){
                        if(index==0){
                            category = obj.value;
                        }else{
                            category = category + '_'+ obj.value ;
                        }
                    }
                });
                data = {size:category,itemImg:itemImg};
                break;

            case '2':
                //商品尺寸
                $('div#ot_jiafang .size_input').each(function(index,obj){
                    if(obj.value!=''){
                        if(index==0){
                            size = obj.value;
                        }else{
                            size = size + '_'+ obj.value ;
                        }
                    }
                });

                //商品描述
                $('div#ot_jiafang .addImg').each(function(index,obj){
                    imgDesc[index] = {};
                    imgDesc[index]['url'] = $(obj).find('.imgValue').val();
                    imgDesc[index]['title'] = $(obj).find('.img_desc').val();
                });
                data = {size:size,imgDesc:imgDesc,itemImg:itemImg};
                break;
        }

        $('#add_btn').text('上传中。。。')
        $('#addProductForm').ajaxSubmit({
            type:'post',
            data:data,
            success:function(data){
                if(data == 'success'){
                    $('#add_btn').text('添加成功，即将返回。。。')
                    setTimeout(function(){
                        window.location.href = "/Admin/Product/index.html"
                    },1000)
                }else{
                    $('#add_btn').text('保存失败，请刷新重试：'+'data');

                }
            }
        })
    };

    module.exports = AddProduct;

})