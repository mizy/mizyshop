/**
 * For admin module
 * Created by iblovem on 14-4-7.
 */

//导航栏赋予样式
( $(document).ready(function(){
    //删除按钮
    $(document).on('click','a.del_btn',function(){
        $(this).parent().remove();
    });

    //导航显示
    var i="";
    var data = $('body').attr('data-id').split('|');
    for(i = 0; i <= data.length; i++){
        $('#'+data[i]).addClass('active');
    }

    //tab显示
    $('.tab a[role=tab]').click(function (e) {
        e.preventDefault();
        $(this).tab('show')
    });

    //色块切换
    $('.ul_btn_value').each(function(){
        var parent = $(this).parent();
        var value = $(this).val();
        $(parent).find('[data-value='+value+']').addClass('btn-primary');
    });
    $('.ul_btn li').click(function(e){
        e.preventDefault();
        $(this).parent().find('.btn-primary').removeClass('btn-primary');
        $(this).addClass('btn-primary');
        var value = $(this).attr('data-value');
        $(this).parent().find('input.ul_btn_value').val(value);
    })

}));

//删除节点函数,要求爷爷节点要有删除的id赋值
function deleteNode(div,control){
    if( !confirm("确定删除？")){
        return false;
    }

    var url = control||"./deleteThis";
    var node = $(div).parent().parent();
    var id = node.attr('data-id');
    $.ajax({
        url:url,
        type: 'post',
        data:{ id:id },
        success:function(data){
            if(data=='success'){
                node.html('<p class="text-center text-success">删除成功...</p>');
                node.fadeOut(1200);
                node.fadeOut(1200,function(){
                    node.remove();
                });

               // alert('删除成功');
            }else{
                alert('删除失败('+data+')');
            }
        }
    })
}

//提交表单,传入控制器
function submitForm(url){
    if($('#title').val()=="" || $('#title').val() == 'undefind' ){
        alert('请输入title');
        return false;
    }

    if(!$('#info').val()){
        alert('请输入详情');
        return false;
    }

	var id = $('#id').val()||"";
    var title = $('#title').val();
    var image_url = $('#image_url').val()||"";
    var price = $('#price').val() || "";
    var info = UE.getEditor('editor').getContent()||"";
    var hot = $('#hot').val()||0;
    var class0 = $('#class').val()||"";
    var from = $('#from').val()||"";

    $.ajax({
        url:url,
        type:'post',
        data:{title:title,image_url:image_url,price:price,info:info,hot:hot,id:id,class:class0,from:from},
        success:function(status){
            if(status=='success'){
                alert('成功');
                return true;
            }else{
                alert('保存失败');
                return false;
            }
        }
    });
    return false;
}

//ajax上传图片
function ajaxUploadImg(div,img,callback){
    div = div||$('form');
    var image = img|| "image";
    var options={
        url :'./uploadImg?image='+image+'&t='+Math.random(),
        type:'post',
        encAttr: 'multipart/form-data',
        success : function(msg) {
            if(msg != 'failed'){
                var image_show = document.getElementById('image_show');
                try{
                    image_show.innerHTML = '<img src="' + msg + '" alt="image" style="height:100px;width:auto" />';
                    $('#image_url').val(msg);
                    return true;
                }catch (e){
                	try{
                		 callback(msg);
                		 return true;
                		}catch(e){
                   			return false;
                		}

                }
            }
        },
        error: function(XmlHttpRequest, textStatus, errorThrown){
            alert(XmlHttpRequest +textStatus+ errorThrown);
        }
    };

    
        div.ajaxSubmit(options);
    
    return false;
}
