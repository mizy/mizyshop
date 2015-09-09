<?php
/**@author:  mizy
 *@首页生成类
 *@2014/3/26 星期三
 */
namespace Home\Controller;
use Common\Controller\SiteController;
use Common\Controller\ClassManagerController;
class LoginController extends SiteController {

    public function index( ){

        $this->getSite();

        if(session('?user_name')&&session('?user_type')){
           $this->redirect('Index/index');
        }
        $this->display();
    }
    public function Login(){
        $this->getSite();
        //是否存在
        if( !isset($_POST['username']) || !isset($_POST['password']) ){
            $this->ajaxReturn('no input');
        }

        //验证用户
        $user=M('mz_user');
        $password = md5($_POST['password']);
        $user_name = $_POST['username'];
        $condition['username'] = $user_name;
        $email['email'] = $user_name;
        if(!($user_info = $user->where($condition)->find())){
            if( !($user_info = $user->where($email)->find()))
            {
                $this->ajaxReturn('no user');
            };
        }

        if( $password == $user_info['password'] ){
            $data['visit_times'] = intval($user_info['visit_times'])+1;
            if( $user->where(" username = '$user_name' ")->save($data) || $user->where(" email = '$user_name' ")->save($data) ){
                session('user_name',$user_name);
                if($user_info['type']>=0){
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

    //回调
    public function back(){
        if(session('back_url')!=''){
            $url = session('back_url');
            session('back_url','');
            redirect($url);
        }else{
            $this->redirect('Index/index');
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
    //注册
    public  function register(){
        $this->getSite();
        $this->display();
    }
    //注册表单
    public function registerForm(){
        $data['email'] = $_POST['email'];
        $data['username'] = $_POST['user_name'];
        $data['nick_name'] = $_POST['user_name'];
        $data['password'] = $_POST['password'];
        $data['sex'] = $_POST['sex'];
        $data['phone'] = $_POST['phone'];
        $code = $_POST['code'];
        if($data['email']!=''&&$data['username']!=''&&$data['password']!=''){

            $verify = new \Think\Verify();
            //检测验证码
            if($verify->check($code, '')){
                $data['password'] = md5($data['password']);
                $data['create_time'] = date('Y-M-D h:i:s');
                if(M('mz_user')->add($data)){
                    $this->ajaxReturn('success');
                }else{
                    $this->ajaxReturn('用户名或邮箱已存在');
                }
            }else{
                $this->ajaxReturn('验证码错误');
            }
        }else{
            $this->ajaxReturn('内容为空');
        }

    }

    //是否已经登录
    public function isLogin(){
        if(session('?user_name')&&session('?user_id')){
            $this->ajaxReturn('true');
        }else{
            $this->ajaxReturn('false');
        }
    }
}