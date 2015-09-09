<?php
/**@athor:  mizy
   *@admin信息类
   *@2014/4/8 星期二
   */
namespace Common\Controller;
use Think\Controller;

class AdminController extends Controller {
	
	//判断用户是否登录
	public function checkLogin(){
		if( !session('?user_name') || !session('?user_type')  ){
			$this->redirect( 'Login/index' );
		}

        $site_name = M('mz_info')->where('name = "site_name"')->find();
        $this->assign('site_name',$site_name['content']);
		$this->assign('user_name',session('user_name'));
		$this->assign('user_type',session('user_type'));
    }

	public function ajaxImgUpload($domain='img',$name = 'image'){

		$config = array(    
			'maxSize'    =>    3145728,    
			'savePath'   =>    './class/',
			'exts'       =>    array('jpg','bmp', 'gif', 'png', 'jpeg'),
			'autoSub'    =>    true,    
			'subName'    =>    array('date','Ymd'),
			'rootPath'      =>     './'.$domain.'/'
			);
		
		  $upload = new \Think\Upload($config,'Sae');// 实例化上传类  


		  // 上传文件     
		  $info   =   $upload->upload();

			  if(!$info) {
				  // 上传错误提示错误信息        
				  $this->ajaxReturn('failed');
				}else{
					// 上传成功
					$url = "http://b2cshop-".$domain.".stor.sinaapp.com/".$info[$name]['savepath'].$info[$name]['savename'];
                    $data = array(
                        'status' => 'success',
                        'url'    => $url
                    );
					$this->ajaxReturn($data);
					
				}
	
	}


    //上传图片
    public function upload(){
        $config = array(
            'maxSize'    =>    3145728,
            'savePath'   =>    './product/',
            'exts'       =>    array('jpg', 'gif', 'png', 'jpeg','bmp'),
            'autoSub'    =>    true,
            'subName'    =>    array('date','Ymd'),
            'rootPath'      =>     './img/'
        );

        $upload = new \Think\Upload($config,'Sae');// 实例化上传类


        // 上传文件
        $info   =   $upload->upload();

        if(!$info) {
            // 上传错误提示错误信息
            //return ('failed upload：'.$upload->getError());
            return '';
        }else{
            return $info;
        }
    }

    //

}