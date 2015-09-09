<?php
/**@author：mizy
   *@网站信息提取类
   *@2014/3/26 星期三
   */
namespace Common\Controller;
use Think\Controller;

class SiteController extends Controller {

    //获取站点信息
    public function getSite(){

        //用户名
		if(session("?user_name")){
            $this->assign('username',session("user_name"));
        }
        //网站信息
        $site = M('mz_info')->where(" name = 'site_name' ")->find();
        $this->assign('site',$site);
        //cookie购物车
        $cartArray = json_decode(cookie('cart'),true);
        $cart['num'] = Count($cartArray);
        $this->assign('cart',$cart);
        //导航
        $classList = M('mz_class')->where('layer=1')->order('`order`')->select();

        for($i=0;$i<Count($classList);$i++){
            $where['father'] = $classList[$i]['id'];
            $classList[$i]['child'] = M('mz_class')->where($where)->order('`order`')->select();
        }
        $this->assign('classList',$classList);

        //购物车数目
        if(session('?user_id')){
            $where['user'] = session('user_id');
            $cartnum = M('mz_cart')->where($where)->count();
            $this->assign('cartnum',$cartnum);
        }else{
            $this->assign('cartnum',0);
        }
    }

    //检查登录
    //判断用户是否登录
    public function checkLogin(){
        if( !( session('?user_name') && session('?user_type') ) ){
            $this->redirect( 'Login/index' );
        }

        $this->assign('user_name',session('user_name'));
        $this->assign('user_type',session('user_type'));
    }

    //侧边栏历史
    public function getHistory(){

        $history = cookie('visitedItem');
        $num = Count($history);
        if($num>5){
            $history = array_slice($history,-5,5);
        }
        $history = json_decode($history,true);
        $result = array();
        foreach( $history as $each){
            $eve=M('mz_item_info')->join('mz_item ON mz_item_info.item = mz_item.id')->where("item = $each AND `type`='desc'")->find();
            $result[]=$eve;
        }

        $this->assign('historyItem',$result);
    }

    //购物车数目
}