<?php
/**
 * Created by PhpStorm.
 * User: Mizy
 * Date: 14-9-25
 * Time: 下午9:35
 */
namespace Admin\Controller;
use Common\Controller\AdminController;

class OrderController extends AdminController {

    //判断用户是否登录
    public function index($orderType='',$p=1){

        $this->checkLogin();
        $where='';
        if($orderType!=''){
            //分页
            $num = M('mz_order')->where($where)->count();
            $page = new \Org\Util\Page($num,20);//每页20条数据
            $showList = $page->show();
            $where['status'] = $orderType;
            $orderList = M('mz_order')->page($p,$page->listRows)->where($where)->select();
        }else{
            //分页
            $num = M('mz_order')->where($where)->count();
            $page = new \Org\Util\Page($num,20);//每页20条数据
            $showList = $page->show();
            $orderList = M('mz_order')->page($p,$page->listRows)->select();
        }

        $this->assign('showList',$showList);
        $this->assign('orderType',$orderType);
        $this->assign("orderList",$orderList);
        $this->display();
    }

    //删除
    public function deleteThis(){
        $id = I('id','null');

        if(M('mz_order')->where("id = $id")->delete()){
            $this->ajaxReturn('success');
        }else{
            $this->ajaxReturn('wrong!delete failed::'.$id);
        }
    }

    public function modOrder($id=''){
        $this->checkLogin();

        $order  = M('mz_order')->where("id=$id")->find();

        $this->assign("order",$order);
        $this->display();
    }

    public function modOrderForm($id=''){
        $this->checkLogin();
        $data['status'] = I('status');
        $data['user'] = I('user');
        $data['address_id'] = I('address_id');
        $data['total_price'] = I('total_price');
        $data['beizhu'] = I('beizhu');
        $data['post_name'] = I('post_name');
        if(I('billNo','')!=''){
            $data['billNo'] = I('billNo');
        }

        $where['id'] =$id;
        M('mz_order')->where($where)->save($data);
        $this->ajaxReturn('success');
    }

    //新增订单
    public function addOrder($id=''){
        $this->checkLogin();

        $order  = M('mz_order')->where("id=$id")->find();


        $this->assign("order",$order);
        $this->display();
    }

    //订单详情
    public function OrderInfo($id=''){
        $this->checkLogin();
        $order = M('mz_order')->where("id=$id")->find();

        $whereItem['order'] = $id;
        $itemList= M('mz_order_item')->where($whereItem)->select();

        //所有商品的信息
        for($j=0;$j<Count($itemList);$j++){
            $whereItemInfo['item'] = $itemList[$j]['item'];
            $whereItemInfo['type'] = 'desc';
            $itemList[$j]['info'] =  M('mz_item_info')->join('mz_item ON mz_item_info.item = mz_item.id')->where($whereItemInfo)->find();
        }

        $this->assign('order',$order);
        $this->assign('itemList',$itemList);
        $this->display();
   }

    //预约详情
    public function yuyueInfo($id=''){
        $this->checkLogin();
        $order = M('mz_order')->where("id=$id")->find();

        $whereItem['id'] = $order['designer'];
        $designer = M('mz_designer_info')->join(" mz_designer on mz_designer_info.designer = mz_designer.id ")->where($whereItem)->find();


        $this->assign('order',$order);
        $this->assign('desigenr',$designer);
        $this->display();
    }
}