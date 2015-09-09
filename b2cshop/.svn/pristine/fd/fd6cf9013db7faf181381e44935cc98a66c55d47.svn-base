<?php
/**@athor:  mizy
   *@site生成类
   *@2014/3/26 星期三
   */
namespace Admin\Controller;
use Common\Controller\AdminController;

class SettingController extends AdminController {
    public function index(){

		$this->checkLogin();

		$where["name"] = 'site_name';

		//取出site
		$site = M('mz_info')->where($where)->find();
		$this->assign('site',$site);
		$this->display();
    }



	//ajax更改site
	public function ajaxSettingForm($content,$desc,$id,$logo,$name){
		if($name == "" || $id == ""){
			$this->ajaxReturn('failed');
		}

		$data['content'] = $content;
		$data['desc'] = $desc;
		$data['logo'] = $logo;

		$where['name'] = 'site_name';

		if(M('mz_info')->where($where)->save($data)>=0){
			$this->ajaxReturn('success');
		}else{
			$this->ajaxReturn('failed');
		}
	}

    public function slider(){
        $this->checkLogin();

        $img1 = M('mz_info')->where("name = 'slider1'")->find();
        $img2 = M('mz_info')->where("name = 'slider2'")->find();
        $img3 = M('mz_info')->where("name = 'slider3'")->find();
        $img4 = M('mz_info')->where("name = 'slider4'")->find();
        $img5 = M('mz_info')->where("name = 'slider5'")->find();

        $this->assign('img1',$img1);
        $this->assign('img2',$img2);
        $this->assign('img3',$img3);
        $this->assign('img4',$img4);
        $this->assign('img5',$img5);
        $this->display();
    }

    //ajax幻灯片
    public function ajaxSliderForm($imgData=''){
        if($imgData==''){
            $this->ajaxReturn('failed');
        }

        $imgData = json_decode($imgData,true);

        for($i=0;$i<Count($imgData);$i++){
            $where['id'] = $imgData[$i]['id'];
            $data['content'] = $imgData[$i]['content'];
            $data['logo'] = $imgData[$i]['url'];
            M('mz_info')->where($where)->save($data);
        }
        $this->ajaxReturn('success');
    }

	//contact us
	public function contactUs(){

		//检查login
		$this->checkLogin();
		$contactUs = M('view')->where("id = 6")->find();

		$this->assign('contactUs',$contactUs);

		$this->display();
	}

	//about us
	public function aboutUs(){

		//检查login
		$this->checkLogin();

		$aboutUs = M('view')->where("id = 5")->find();

		$this->assign('aboutUs',$aboutUs);
		$this->display();
	}

	//ajaxmod
	public function ajaxModAboutUs($info){

		$data['info'] = $info;
		$where['title'] = 'About Us';
		if( M('view')->where($where)->save($data)){
			$this->ajaxReturn('success');
		}else{
			$this->ajaxReturn('faild');
		}

	}

	//ajaxmod
	public function ajaxModcontactUs($info){

		$data['info'] = $info;
		$where['title'] = 'Contact Us';
		if( M('view')->where($where)->save($data)){
			$this->ajaxReturn('success');
		}else{
			$this->ajaxReturn('faild');
		}

	}


}