<?php
/**@athor:  mizy
   *@user生成类
   *@2014/3/26 星期三
   */

namespace Admin\Controller;
use Common\Controller\AdminController;
use Common\Controller\MailController;

class UserController extends AdminController {
    public function index($p=1){

		$this->checkLogin();
        $q = I('get.query','');
        //输出用户query的
        $this->assign('query',$q);

        if($q!=''){
            $query['username'] = array('like','%'.$q.'%');
            //取出query用户
            $num = M('mz_designer')->where($query)->count();
            $page = new \Org\Util\Page($num,20);//每页20条数据
            $showList = $page->show();
            $userList = M('mz_user')->page($p,$page->listRows)->where($query)->select();
        }else{
            //取出所有用户
            $num = M('mz_designer')->count();
            $page = new \Org\Util\Page($num,20);//每页20条数据
            $showList = $page->show();
            $userList = M('mz_user')->page($p,$page->listRows)->select();
        }

        $this->assign('showList',$showList);
		$this->assign('userList',$userList);
		$this->display();
    }

	//删除用户
	public function deleteThis(){

        $id = I('id','');
		if( M('mz_user')->where("id = '$id'")->delete()){
			$this->ajaxReturn('success');
		}else{
			$this->ajaxReturn('failed');
		}
	}

	//添加用户界面
	public function addUser(){
        $this->checkLogin();
		$this->display();
	}

    //发送信息界面
    public function message(){
        $this->checkLogin();

        $this->display();
    }

    //处理表单
    public  function  messageForm(){

        if(I('title','') != ''&& I('mailto','')!='' && I('','')!=''){
            $title = I('title','');
            $mailTo = I('mailto','');
            $content = I('editorValue','');
            $mail = new MailController();
            $result = true;
            $mailList = M('mz_user')->where('email !=""  And type =0 ')->field('email')->select();
            $mail->sendMail($mailList,$title,$mailTo,$content);
            $this->ajaxReturn($result);
        }else{
            $this->ajaxReturn(I('title','').I('mailto','').I('editorValue',''));
        }

    }

    //修改用户信息
    public  function  modUser(){
        $this->checkLogin();

        $id['id'] = I('id');
        $user = M('mz_user')->where($id)->find();

        $this->assign('user',$user);
        $this->display();

    }

    //修改表单提交页面
    public function  modUserForm(){

        $this->checkLogin();

        if(I('param.id','') == "" ){

            $this->redirect('Index/index');
        }

        $id['id'] = I('id');
        $this->assign('id',$id['id']);
        $data['type'] = I('user_type');
        $data['nick_name'] = I('nick_name','');
        $data['sex'] = I('sex');
        $data['email'] =  I('email');
        $data['phone'] = I('phone');

        if(M('mz_user')->where($id)->save($data)){
            $this->assign('tip','<h1 class="text-success">修改成功</h1>');
        }else{
            $this->assign('tip','<h1 class="text-danger">修改失败</h1>');
        }

        $this->display();

    }

	//ajax添加用户
	public function addUserForm(){

        $this->checkLogin();

		if(I('param.username','') == "" || I('param.password','') == ""){

            $this->redirect('Index/index');
		}

		$data['username'] = I('username');
		$data['password'] = md5(I('password'));
		$data['type'] = I('user_type');
        $data['nick_name'] = I('nick_name','');
        $data['sex'] = I('sex','0');
        $data['email'] =  I('email','');
        $data['phone'] = I('phone','');

		if(M('mz_user')->add($data)){
			$this->assign('tip','<h1 class="text-success">添加成功</h1>');
		}else{
            $this->assign('tip','<h1 class="text-danger">添加失败,用户已存在</h1>');
		}

        $this->display();
	}
}