<?php
/**@author:  mizy
   *@首页生成类
   *@2014/3/26 星期三
   */
namespace Home\Controller;
use Common\Controller\SiteController;

class IndexController extends SiteController {
	
    public function index(){

		$this->getSite();
		
		//提取幻灯
        $where['name'] = array('like','slider%');
		$slider = M('mz_info')->where($where)->select();

        //正中的推荐hot=2
        $classHot2 = M('mz_class')->where('hot=2')->find();
        $where['class'] = $classHot2['id'];
        $imgHot2 = M('mz_class_info')->where($where)->find();
        $classHot2['url'] = $imgHot2['url'];
        $classHot2['desc'] = $imgHot2['title'];

        //推荐内容模块
        $classHot = M('mz_class')->where('hot=1')->select();
        for($i = 0;$i<Count($classHot);$i++){
            $where['class'] = $classHot[$i]['id'];
            $imgHot = M('mz_class_info')->order('id desc')->where($where)->select();
            $classHot[$i]['img'] = $imgHot;
        }

       if(!session('fuchuang')){
           $this->assign('fuchuang',1);
           session('fuchuang',1);
       }else{
           $this->assign('fuchuang',0);
       }
         $this->assign('classHot',$classHot);
        $this->assign('classHot2',$classHot2);
        $this->assign('slider',$slider);
		$this->display();
    }

	//联系我们
	public function ContactUs(){
		
		$this->getSite();
	
		$contactUs = M('view')->where("id = 6")->find();

		$this->assign('contactUs',$contactUs);
		$this->index();
	}

	//about us
	public function AboutUs(){
		//检查login
		$this->getSite();

		$aboutUs = M('view')->where("id = 5")->find();

		$this->assign('aboutUs',$aboutUs);
		$this->display();
	}

    //search
    public function search($search='',$p=1){
        $this->getSite();

        $query=" title like '%$search%'";

        $num = M('mz_item')->where($query)->count();
        $page = new \Org\Util\Page($num,20);//每页20条数据
        $showList = $page->show();

        $itemList = M('mz_item')->where($query)->page($p,$page->listRows)->select();

        for($i=0;$i<Count($itemList);$i++){
            $whereItem = '';
            $whereItem['item'] = $itemList[$i]['id'];
            $whereItem['type'] = 'desc';
            $itemList[$i]['img'] = M('mz_item_info')->where($whereItem)->find();
        }

        $this->assign('itemNum',$num);
        $this->assign('showList',$showList);
        $this->assign('itemList',$itemList);
        $this->display();
    }

}