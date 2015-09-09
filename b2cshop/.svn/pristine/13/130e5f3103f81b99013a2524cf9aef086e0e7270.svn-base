<?php
/**
 * @class 网站状态
 * @User: Mizy
 * @Date: 14-9-24
 * @Time: 上午12:01
 */

namespace Admin\Controller;
use Common\Controller\AdminController;

class StatusController extends AdminController {
    public function index(){

        $this->checkLogin();
        $this->display();
    }

    //删除用户
    public function deleteThis($id=0){

        $user_name = $id;
        if(M('user')->where("user_name = '$user_name' ")->delete()){
            $this->ajaxReturn('success');
        }else{
            $this->ajaxReturn('faild');
        }
    }

    //添加用户界面
    public function addUser(){
        $this->display();
    }

    //ajax添加用户
    public function ajaxAddUser($user_name,$password,$user_type){

        if($user_name == "" || $password == ""){
            $this->ajaxReturn('faild');
        }

        $data['user_name'] = $user_name;
        $data['user_password'] = md5($password);
        $data['user_type'] = $user_type;
        if(M('user')->add($data)){
            $this->ajaxReturn('success');
        }else{
            $this->ajaxReturn('faild');
        }
    }
}