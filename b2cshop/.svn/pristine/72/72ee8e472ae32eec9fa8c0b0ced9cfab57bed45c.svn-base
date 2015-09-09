<?php
/**@athor:  mizy
   *@首页生成类
   *@2014/3/26 星期三
   */
namespace Admin\Controller;
use Common\Controller\AdminController;
use Think\Controller;

class LoginController extends AdminController {
    public function index(){

		//判断用户是否登录
		if( ( session('?user_name') && session('?user_type') ) ){
			$this->redirect('Status/index');
		}
		
		$this->display();
    }
	
	//登陆函数
	public function login(){

		//是否存在
		if( !isset($_POST['username']) || !isset($_POST['password']) ){
			$this->ajaxReturn('no input');
		}

		//验证用户
		$user=M('mz_user');
		$password = md5($_POST['password']);
		$user_name = $_POST['username'];
		$condition['username'] = $user_name;
		if( !$user_info = $user->where($condition)->find()){
			$this->ajaxReturn('no user');
		}

		if( $password == $user_info['password'] ){
				$data['visit_times'] = intval($user_info['visit_times'])+1;
				if( $user->where(" username = '$user_name' ")->save($data) ){
					session('user_name',$user_name);
                    if($user_info['type']>0){
                        session('user_type',$user_info['type']);
                        session('user_id',$user_info['id']);
                        $this->ajaxReturn('success');
                    }else{
                        $this->ajaxReturn('no permission');
                    }

				}
		}else{
			$this->ajaxReturn('wrong pass');
		}
	}

	//生产验证码
	public function verify(){
		
		//验证码配置
		$config =    array(   
			'imageW'    =>    170,
			'imageH'    =>     45,
			'fontSize'    =>    21,    // 验证码字体大小
			'length'      =>    4,     // 验证码位数
			'useNoise'    =>    false, // 关闭验证码杂点
			'codeSet'   =>   'abcdefghigklmnopqrstuvwxyz',
			'expire'     =>    60,
			'useCurve'   => false
			);

		//验证码输出
		$Verify = new \Think\Verify($config);
		$Verify->entry();
	}

	//判断验证码
	public function check_verify($code,$id=''){

		$verify = new \Think\Verify();
		$this->ajaxReturn($verify->check($code, $id));
	}

	//产生新用户
	public function addNew($username="",$password="",$user_type="0"){

        //判断用户是否有权限
        if(  !session('?username') || session('user_type')!=1  ){
            $this->redirect('Index/index');
        }

		$user=M('mz_user');
		$data['username'] = $username;
		$data['password'] = md5($password);
        $data['create_time'] = date('Y-M-D h:i:s');
		$data['type'] = $user_type;
		if( $user->add($data)){
			echo 'success';
		}else{
			echo "failed";
		}
	}
}