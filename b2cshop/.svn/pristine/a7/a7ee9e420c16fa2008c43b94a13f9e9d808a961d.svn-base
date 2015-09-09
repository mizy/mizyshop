<?php
/**
 * Created by PhpStorm.
 * User: Mizy
 * Date: 14-9-25
 * Time: 下午9:35
 */
namespace Admin\Controller;
use Common\Controller\AdminController;

class BrandController extends AdminController {

    //判断用户是否登录
    public function index(){

        $this->checkLogin();

        $brand = M('mz_brand')->select();

        for($i = 0;$i<Count($brand);$i++){
            $where['brand'] = $brand[$i]['id'];
            $num = M('mz_item')->where($where)->count();
            $brand[$i]['num'] = $num;
        }

        $this->assign("brandList",$brand);
        $this->display();
    }

    //添加Class
    public function addBrand(){
        $this->checkLogin();

        $this->display();
    }

    public  function addBrandForm(){

        //检查
        if(I('title','')!=''&&I('order','')!=''){
            $data['title'] = I('title');
            $data['order'] = I('order');

            //添加子类目
            if( M('mz_brand')->add($data)){
                $this->ajaxReturn("success");
            }else{
                $this->ajaxReturn('failed,insert error');
            }
        }else{
            $this->ajaxReturn('no param::'.I('title').I('order').I('classId'));
        }
    }

    //修改类目
    public  function  modBrand(){
        $this->checkLogin();

        //检索存在的类目
        $where['id']=I('id');
        $brand = M('mz_brand')->where($where)->find();

        $this->assign('brand',$brand);
        $this->display();
    }

    //修改类目表单
    public  function  modBrandForm(){
        //检查
        if(I('title','')!=''&&I('order','')!=''&&I('id','')!=''){

            $data['title'] = I('title');
            $data['order'] = I('order');

            // //添加子类目
            $id['id'] = I('id');
            if(M('mz_brand')->where($id)->save($data)){
                $this->ajaxReturn("success");
            }else{
                $this->ajaxReturn('failed,insert to father class error');
            }
        }else{
            $this->ajaxReturn("no input");
        }
    }

    //删除
    public function deleteThis(){
        $id = I('id','null');

        if(M('mz_brand')->where("id = $id")->delete()){
            $this->ajaxReturn('success');
        }else{
            $this->ajaxReturn('wrong!delete failed::'.$id);
        }
    }
}