<?php
/**@author:  mizy
 *@首页生成类
 *@2014/3/26 星期三
 */
namespace Home\Controller;
use Common\Controller\SiteController;
use Common\Controller\ClassManagerController;
class CartController extends SiteController {

    public function index( ){
        $this->checkLogin();
        $this->getSite();

        $where['user']=session('user_id');
        $cart = M('mz_cart')->where($where)->select();
        //绑定各个item和info
        for( $i=0;$i<Count($cart);$i++){
            $cart[$i]['info'] = M('mz_item_info')->join('mz_item ON mz_item_info.item = mz_item.id')->where('item='.$cart[$i]['item'])->find();
        }


        //地址检出
        $addressList = M('mz_user_address')->where('user='.session('user_id'))->select();

        $this->assign('addressList',$addressList);
        $this->assign('cart',$cart);
        $this->display();

    }

    //提交订单
    public function addOrder($orderInfo='',$beizhu='',$addressId='',$deleteCart='false'){

        $this->checkLogin();

        $order = json_decode($orderInfo,true);//解析json
        if(Count($order)<1 || $addressId==''){
            $this->ajaxReturn('no orderInfo');
        }

        //写入订单表
        $data='';
        $data['user'] = session('user_id');
        $data['beizhu'] = $beizhu;
        $address = M('mz_user_address')->where("id=$addressId")->find();
        $data['address_id'] = $address['address']." ".$address['name']." 邮编:".$address['posta_code']."  电话:".$address['phone'];
        //总价
        $data['total_price'] = 0;
        for($i=0;$i<Count($order);$i++){
            $item = M('mz_item')->where('id='.$order[$i]['item'])->find();
            $order[$i]['price'] = $item['price'];//写入订单
            $price = intval($order[$i]['num'])*intval($item['price']);//小计
            $data['total_price'] += $price;
        }
        $year_code = array('A','B','C','D','E','F','G','H','I','J');
        $order_sn = $year_code[intval(date('Y'))-2010].
            strtoupper(dechex(date('m'))).date('d').
            substr(time(),-5).substr(microtime(),2,5).sprintf('%02d',rand(0,99));
        $data['order_id'] = $order_sn;

        //写入
        $id = M('mz_order')->add($data);

        //写入每个item的信息
        for($i=0;$i<Count($order);$i++){
            $data = $order[$i];
            $data['order'] = $id;
            M('mz_order_item')->add($data);
        }
        $res['status']='success';
        $res['id'] = $id;

        //是否删除购物车
        if($deleteCart=='true'){
            $whereCart['user'] = session('user_id');
            M('mz_cart')->where($whereCart)->delete();
        }

        $this->ajaxReturn($res);

    }

    //提交预约
    public function yuyue($id='',$chima='',$num=''){
        if($id==''||$chima==''||$num==''){
            $this->redirect('Custom/index');
        }

        $this->checkLogin();
        $this->getSite();

        //用户购买信息取出
        $where['user'] = session('user_id');
        $buyOrder['chima'] = $chima ;
        $buyOrder['num'] = $num;
        $buyOrder['item'] = $id;

        $item  = M('mz_designer_info')->join('mz_designer ON mz_designer_info.designer = mz_designer.id')->where('designer='.$id)->find();

        //地址检出
        $addressList = M('mz_user_address')->where('user='.session('user_id'))->select();

        $this->assign('item',$item);
        $this->assign('buyOrder',$buyOrder);
        $this->assign('addressList',$addressList);
        $this->display();


    }

    //提交预约订单
    public function addYuyue($orderInfo='',$beizhu='',$addressId=''){

        $this->checkLogin();

        $order = json_decode($orderInfo,true);//解析json
        if(Count($order)<1 || $addressId==''){
            $this->ajaxReturn('no orderInfo');
        }
        $order = $order[0];//只有一条

        //查出designer
        $designer = M('mz_designer')->where("id=".$order['item'])->find();

        //写入订单表
        $data='';
        $data['user'] = session('user_id');
        $data['num'] = $order['num'];
        $data['fuwu'] = $order['chima'];
        $data['beizhu'] = $beizhu;
        $address = M('mz_user_address')->where("id=$addressId")->find();
        $data['address_id'] = $address['address']." ".$address['name']." 邮编:".$address['posta_code']."  电话:".$address['phone'];
        //总价
        $data['total_price'] = intval($data['num'])*intval($designer['price']);

        $year_code = array('A','B','C','D','E','F','G','H','I','J');
        $order_sn = $year_code[intval(date('Y'))-2010].
            strtoupper(dechex(date('m'))).date('d').
            substr(time(),-5).substr(microtime(),2,5).sprintf('%02d',rand(0,99));
        $data['order_id'] = $order_sn;
        $data['designer'] = $order['item'];
        $data['type'] = 'yuyue';

        //写入
        $id = M('mz_order')->add($data);


        $res['status']='success';
        $res['id'] = $id;

        $this->ajaxReturn($res);

    }

    //购物车删除Item
    public  function  deleteCartItem($id){
        $where['user'] = session('user_id');
        $where['id'] = $id;
        if(M('mz_cart')->where($where)->delete()){
            $this->ajaxReturn('success');
        }
        $this->ajaxReturn('noThisItem');
    }

    //ajax to 购物车
    public  function toCart($chima,$color='',$num,$item){
        $data['chima'] = $chima;
        $data['color'] = $color||'';
        $data['num']  = $num;
        $data['item'] = $item;
        $data['user'] = session('user_id');
        if(M('mz_cart')->add($data)){
            $this->ajaxReturn('success');
        };

    }

    //现在购买信息更新
    public function buynow($chima='',$color='',$num='',$item=''){
        $data['chima'] = $chima;
        $data['color'] = $color;
        $data['num']  = $num;
        $data['item'] = $item;
        $data['user'] = session('user_id');
        if(!M('mz_buynow')->where('user = '.$data['user'])->save($data)){
            if(M('mz_buynow')->add($data)){
                $this->ajaxReturn('success');
            };
        }else{
            $this->ajaxReturn('failed');
        }
        $this->ajaxReturn('success');
    }

    //现在购买
    public function buy(){
        $this->checkLogin();
        $this->getSite();

        //用户购买信息取出
        $where['user'] = session('user_id');
        $buyOrder = M('mz_buynow')->where($where)->find();

        $item  = M('mz_item_info')->join('mz_item ON mz_item_info.item = mz_item.id')->where('item='.$buyOrder['item'])->find();

        //地址检出
        $addressList = M('mz_user_address')->where('user='.$buyOrder['user'])->select();

        $this->assign('item',$item);
        $this->assign('buyOrder',$buyOrder);
        $this->assign('addressList',$addressList);
        $this->display();

    }

    //需要登录
    public function needLogin($id){
        $this->getSite();

        if(session('?user_name')&&session('?user_type')){
            $url = "/Home/Item/index.html?id=".$id;
            session('back_url',$url);
        }

        $this->display();
    }
}