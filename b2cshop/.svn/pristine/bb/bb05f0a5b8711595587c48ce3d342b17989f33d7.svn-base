<?php
/**@author:  mizy
 *@首页生成类
 *@2014/3/26 星期三
 */
namespace Home\Controller;
use Common\Controller\SiteController;
use Common\Controller\ClassManagerController;
class UserController extends SiteController {

    public function index($p=1,$orderType='order_time desc',$status=''){
        $this->checkLogin();
        $this->getSite();
        $user_id = session('user_id');

        $whereOL['type'] = 'good';
        $whereOL['user'] = session('user_id');

        //计算订单数目
        $order_num = M('mz_order')->where($whereOL)->count();
        $page = new \Org\Util\Page($order_num,12);//每页20条数据
        $showList = $page->show();

        //取出所有订单
        if($status!=''){
            $whereOL['status'] = $status;
        }
        $orderList = M('mz_order')->where($whereOL)->order($orderType)->page($p,$page->listRows)->select();

        //每个订单的商品
        for($i=0;$i<Count($orderList);$i++){
           //所有商品
            $orderList[$i]['itemList'] = M('mz_order_item')->where('`order`='.$orderList[$i]['id'])->select();
            $orderList[$i]['length'] = Count($orderList[$i]['itemList']);
            //所有商品的信息
            for($j=0;$j<Count($orderList[$i]['itemList']);$j++){
                $whereItemInfo['item'] = $orderList[$i]['itemList'][$j]['item'];
                $whereItemInfo['type'] = 'desc';
                $orderList[$i]['itemList'][$j]['info'] =  M('mz_item_info')->join('mz_item ON mz_item_info.item = mz_item.id')->where($whereItemInfo)->find();
            }
        }

        $this->assign('orderList',$orderList);
        $this->assign('showList',$showList);
        $this->display();
    }

    //collect
    public function collect($p=1){
        $this->checkLogin();
        $this->getSite();

        $where['user'] = session('user_id');

        $num = M('mz_user_collect')->where($where)->count();
        $page = new \Org\Util\Page($num,12);//每页20条数据
        $showList = $page->show();
        $itemList = M('mz_user_collect')->where($where)->page($p,$page->listRows)->select();
        for($i=0;$i<Count($itemList);$i++){
            $whereI['item'] = $itemList[$i]['item'];
            $whereI['type'] = 'desc';
            $itemList[$i] =  M('mz_item_info')->join('mz_item ON mz_item_info.item = mz_item.id')->where($whereI)->find();
        }

        $this->assign('showList',$showList);
        $this->assign('itemList',$itemList);
        $this->display();
    }

    //delete collect item
    public function deleteCollect($id='',$type=''){
        if($id!=''){
            $where['item'] = $id;
            $where['type'] = 'item';
            $where['user'] = session('user_id');
            M('mz_user_collect')->where($where)->delete();
            $this->ajaxReturn('success');
        }
    }

    //地址管理
    public function my_address(){
        $this->checkLogin();
        $this->getSite();

        $where['user'] = session('user_id');
        $addressList = M('mz_user_address')->where($where)->select();

        $this->assign('addressList',$addressList);
        $this->display();
    }

    //删除地址
    public function deleteAddress($id=''){
        $this->checkLogin();
        if($id!=''){
            $where['user']=session('user_id');
            $where['id'] = $id;
            M('mz_user_address')->where($where)->delete();
        }
        $this->redirect('User/my_address');
    }

    //添加地址
    public function addAddressForm(){
        $this->checkLogin();
        $data['user'] = session('user_id');
        $data['name'] = I('name','');
        $data['address']=I('address','');
        $data['posta_code'] = I('posta_code','');
        $data['phone'] = I('phone','');
        M('mz_user_address')->add($data);
        $this->redirect('User/my_address');
    }

    //修改地址
    public function modAddress($id=''){
        $this->checkLogin();
        $this->getSite();

        $where['user'] = session('user_id');
        $addressList = M('mz_user_address')->where($where)->select();

        $this->assign('addressList',$addressList);

        $whereA['id'] = $id;
        $address = M('mz_user_address')->where($whereA)->find();
        $this->assign('address',$address);
        $this->assign('id',$id);
        $this->display();
    }

    //修改地址表单
    public function modAddressForm($id=''){
        $where['id'] = $id;
        $this->checkLogin();
        $data['name'] = I('name','');
        $data['address']=I('address','');
        $data['posta_code'] = I('posta_code','');
        $data['phone'] = I('phone','');
        M('mz_user_address')->where($where)->save($data);
        $this->redirect('User/my_address');
    }


    //设置默认
    public function defaultAddress($id){
        $whereN['user'] = session('user_id');
        $whereN['default'] = 1;
        $data['default'] = 0;
        $default = M('mz_user_address')->where($whereN)->save($data);
        $data['default'] = 1;
        M('mz_user_address')->where("id=$id")->save($data);
        $this->redirect('User/my_address');
    }

    //显示用户信息
    public function myInfo(){
        $this->checkLogin();
        $this->get();
        $where['id'] = session('user_id');
        $user = M('mz_user')->where($where)->find();

        $this->assign('user',$user);
        $this->display();
    }

    public function modInfoForm(){
        $this->checkLogin();
        $where['id'] = session('user_id');
        $data['phone'] = I('phone','');
        $data['sex']  = I('sex','');

        M('mz_user')->where($where)->save($data);
        $this->redirect('User/myInfo');

    }

    public function modPassword(){
        $this->checkLogin();
        $this->getSite();
        $this->display();
    }

    public function modPassForm($old='',$new=''){
        $this->checkLogin();
        $where['id'] = session('user_id');
        if($old==''||$new==''){
            $this->ajaxReturn('error');
        }
        $user = M('mz_user')->where($where)->find();
        $old = md5($old);
        $data['password'] = md5($new);
        if($old==$user['password']){
            if(M('mz_user')->where($where)->save($data)){
                $this->ajaxReturn('success');
            }else{
                $this->ajaxReturn('wrong');
            }
        }else{
            $this->ajaxReturn('wrong');
        }

    }

    //预约过的订单
    public function yuyue($p=1){
        $this->checkLogin();
        $this->getSite();

        //申请成功，提取出订单
        $whereOrder['type'] = 'yuyue';
        $whereOrder['user'] = session('user_id');
         //分页
        $order_num = M('mz_order')->where($whereOrder)->count();
        $page = new \Org\Util\Page($order_num,12);//每页20条数据
        $showList = $page->show();
        //取出订单
        $orderList = M('mz_order')->where($whereOrder)->order('order_time desc')->page($p,$page->listRows)->select();

        //每个订单的造型师
        for($i=0;$i<Count($orderList);$i++){
            //所有商品
            $orderList[$i]['designer'] = M('mz_designer_info')->join('mz_designer on mz_designer_info.designer = mz_designer.id')->where('id='.$orderList[$i]['designer'])->find();
        }

        $this->assign('showList',$showList);
        $this->assign('orderList',$orderList);

        $this->display();
    }

    //logout
    public  function logout(){
        session_destroy();
        $this->redirect('Index/index');
    }

}