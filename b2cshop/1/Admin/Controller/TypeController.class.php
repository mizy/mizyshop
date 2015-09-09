<?php
/**@athor:  mizy
   *@分类访问
   *@2014/3/29 星期六
   */
namespace Home\Controller;
use Think\Controller;

class TypeController extends Controller {
    //分类函数

    public function index($id,$p=1){
        if($id=="")
            $this->redirect('Index/');

        $type_id=$id;
        $job_info=M('job_info');
       
		$num=$job_info->where(" job_btype = $type_id ")->count();//总数据量
		$page=new page($num,12);//每页12条数据
		$showList = $page->show();

        $type_list=$job_info->page($p,$Page->listRows)->where(" job_btype = $id ")->select();//当前页面的数据
        $type_name=M('job_type')->where(" type_id=$type_id ")->select();
        
		$this->assign("title",$type_name[0]['type_name'].'--职位百科');//设置title
		$this->assign('job_list',$type_list);
		$this->assign('showList',$showList);
		echo $showList;
		$this->display();
    }
    //搜索函数
    public function search($query,$p=1){
        if($query=="")
            $this->redirect("Index/");
		
        $query=trim($query);//模糊查询
		$search['job_name'] = array('like',"%$query%");
        $search['job_will']=array('like',"%$query%");
        $job_info=M('job_info');
        
		$num=$job_info->where($search)->count();//数据总数
		$page=new page($num,12);//传入分页,12条数据
		$showList = $page->show();

        $job_list=$job_info->page($p,$Page->listRows)->field("job_id,job_name")->where($search)->select();//取出当前分页数据
        $this->assign('title',"搜索结果--".$query);
		$this->assign("job_list",$job_list);
        $this->assign("showList",$showList);
		$this->display("Type/index");
        
    }

  
}