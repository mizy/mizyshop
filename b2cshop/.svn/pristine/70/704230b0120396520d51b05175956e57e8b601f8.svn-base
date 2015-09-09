<?php
/**@author:  mizy
 *@Class Module Manager
 *@2014/10/1 星期二
 */
namespace Admin\Controller;
use Common\Controller\AdminController;

class ModuleController extends AdminController {
    public function index(){
        $this->checkLogin();
        $module = M('mz_module')->select();

        $this->assign('moduleList',$module);
        $this->display();
    }

    public  function  addModule(){
        $this->checkLogin();
        $this->display();
    }

    public function addModuleForm(){
        $data['title'] = I('title','');
        $data['name'] = I('name','');
        if(M('mz_module')->add($data)){
            $this->ajaxReturn('success');
        }else{
            $this->ajaxReturn('failed'.$data['title'].'-'.$data['name']);
        }
    }

    //删除
    public  function deleteThis(){

        $id = I('id','');
        if( M('mz_module')->where("id = $id")->delete()){
            $this->ajaxReturn('success');
        }else{
            $this->ajaxReturn('failed');
        }
    }
    public  function deleteProperty($id){

        $id = I('id','');
        $pt = M('mz_module_info')->where("id = '$id'")->find();
        $m_id = $pt['father'];

        if( M('mz_module_info')->where("id = '$id'")->delete()){

            $num = M('mz_module')->where("id = ".$m_id )->find();
            $num['num'] = $num['num']-1;
            M('mz_module')->where("id = ".$m_id )->save($num);

            $this->ajaxReturn('success');
        }else{
            $this->ajaxReturn('failed');
        }
    }

    public  function getProperty($id){
        $this->checkLogin();
        //查询

        $where['id'] = I('id','');
        $father = M('mz_module')->where($where)->find();
        $property = M('mz_module_info')->where("father = $id")->select();

        $this->assign('father',$father['title']);
        $this->assign('id',$id);
        $this->assign('propertyList',$property);
        $this->display();
    }

    //添加属性
    public function addProperty($id){
        $this->checkLogin();

        $where['id'] = I('id','');
        $father = M('mz_module')->where($where)->find();

        $this->assign('father',$father['title']);
        $this->assign('id',$id);
        $this->display();
    }

    //添加属性表单
    public function addPropertyForm(){
        $data['title'] = I('title','');
        $data['name'] = I('name','');
        $data['hot'] = I('hot','');
        $data['father'] = I('id','');
        $data['class'] = I('class','');

        if(M('mz_module_info')->add($data)){
            $num = M('mz_module')->where("id = ".$data['father'] )->find();
            $num['num'] = $num['num']+1;
            M('mz_module')->where("id = ".$data['father'] )->save($num);

            $this->ajaxReturn('success');
        }else{
            $this->ajaxReturn('failed');
        }

    }

    //添加属性
    public function modProperty($id){
        $this->checkLogin();

        $where['id'] = I('id','');
        $property = M('mz_module_info')->where($where)->find();

        $this->assign('property',$property);
        $this->assign('id',$id);
        $this->display();
    }

    //修改属性表单
    public function modPropertyForm(){
        $data['title'] = I('title','');
        $data['name'] = I('name','');
        $data['hot'] = I('hot','');
        $data['class'] = I('class','');
        $where['id']  = I('id','');

        if(M('mz_module_info')->where($where)->save($data)){
            $this->ajaxReturn('success');
        }else{
            $this->ajaxReturn('failed');
        }

    }
    /*
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
*/
}
?>