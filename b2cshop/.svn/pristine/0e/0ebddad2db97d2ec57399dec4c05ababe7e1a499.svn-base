<?php
/**@athor:  mizy
   *@news管理类
   *@2014/4/8 星期二
   */
namespace Admin\Controller;
use Common\Controller\AdminController;

class NewsController extends AdminController {
    public function index($p=1){
		
		//检查登陆
		$this->checkLogin();

		//分页
		$num = M('news')->count();
		$page = new Page($num,12);//每页12条数据
		$showList = $page->show();

		//取出所有news
		$newsList = M(' news ')->page($p,$page->listRows)->order(' visit_times')->select();

		$this->assign('newsList',$newsList);
		$this->assign('showList',$showList);
		$this->display();
    }

	//删除news
	public function deleteThis($id=-1){

		if(M('news')->where(" id = $id ")->delete()){
			$this->ajaxReturn('success');
		}else{
			$this->ajaxReturn('faild');
		}
	}

	//添加news界面
	public function addNews(){

		//check
		$this->checkLogin();

		$this->display();
	}

	//ajax添加news
	public function ajaxAddNews($title,$info,$from,$hot){

		//检测数据
		if($title == "" || $info == ""){
			$this->ajaxReturn('faild');
			exit();
		}

		//存储数据
		$data['title'] = $title;
		$data['hot'] = $hot;
		$data['info'] = $info;
		$data['from'] = $from;
		if(M('news')->add($data)){
			$this->ajaxReturn('success');
		}else{
			$this->ajaxReturn('faild');
		}
	}

	//修改新闻
	public function modNews($id){

		//check
		$this->checkLogin();

		//获取数据
		$where['id'] = $id;
		$news = M('news')->where($where)->find();

		$this->assign('news',$news);
		$this->display();
	}

	//ajax修改新闻
	public function ajaxModNews($id,$title,$info,$from,$hot){

		//检测数据
		if($title == "" || $info == ""){
			$this->ajaxReturn('faild');
			exit();
		}

		//存储数据
		$where['id'] = $id;
		$data['title'] = $title;
		$data['hot'] = $hot;
		$data['info'] = $info;
		$data['from'] = $from;
		if(M('news')->where($where)->save($data)){
			$this->ajaxReturn('success');
		}else{
			$this->ajaxReturn('faild');
		}
	}

}