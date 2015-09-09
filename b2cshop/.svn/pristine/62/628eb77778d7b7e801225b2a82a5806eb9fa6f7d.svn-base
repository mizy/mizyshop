<?php
/**@author:  mizy
 *@首页生成类
 *@2014/3/26 星期三
 */
namespace Home\Controller;
use Common\Controller\SiteController;
use Common\Controller\ClassManagerController;
class CustomController extends SiteController {

    public function index($p=1,$orderType='',$fuwu=''){
        $fuwu  = urldecode($fuwu);
        $this->getSite();

        //原样返回
        $this->assign('orderType',$orderType);
        $this->assign('fuwu',$fuwu);

        $classQuery = 'status = 1';
        if($orderType==''){
             $orderType = "id";
        }
        if($fuwu!=''){
            $classQuery .= " AND `fuwu` LIKE '%".$fuwu."%'";
        }

        //商品列表
        $num = M('mz_designer')->where($classQuery)->count();
        $page = new \Org\Util\Page($num,20);//每页20条数据
        $showList = $page->show();

        //取出所有
        $itemList = M('mz_designer')->where($classQuery)
            ->order($orderType)->page($p,$page->listRows)->select();
        for($i=0;$i<Count($itemList);$i++){
            $whereItem = '';
            $whereItem['designer'] = $itemList[$i]['id'];
            $itemList[$i]['img'] = M('mz_designer_info')->where($whereItem)->find();
        }

        //服务列表
        $fuwuList = M('mz_designer_fuwu')->where('id=1')->find();


        $this->assign('fuwuList',$fuwuList);
        $this->assign('itemList',$itemList);
        $this->assign('showList',$showList);
        $this->assign('itemNum',$num);
        $this->display();
    }

    //搭配
    public  function designer($id=''){

       $this->getSite();

        $this->assign('id',$id);

        //热门
        $HotList = M('mz_designer')->where("status=1")->order('visit_times desc')->limit(0,5)->select();
        $HotList[0]['img'] = M('mz_designer_info')->where('designer='.$HotList[0]['id'])->find();

        //找到desigenr
        $where['id'] = $id;
        $where['status'] = '1';
        $designer = M('mz_designer')->where($where)->find();

        //浏览次数+1
        $designer['visit_times'] = intval($designer['visit_times'])+1;
        M('mz_designer')->where('id='.$id)->save($designer);

        //描述图片
        $designer['img'] = M('mz_designer_info')->where("designer=$id")->select();

        //浏览次数+1
        $designer['visit_times'] = intval($designer['visit_times'])+1;
        M('mz_designer')->where('id='.$id)->save($designer);

        $this->assign('HotList',$HotList);
        $this->assign('item',$designer);
        $this->display();
    }

    public function addZan($id,$match){
        $where['id'] = $id;
        if($match==1){
            $table = 'mz_match';
            $type='match';
        }else{
            $table = 'mz_item';
            $type='item';
        }
        //用户登录
        if(session('?user_id')){
            $data['user'] = session('user_id');
            $data['item'] = $id;
            $data['type'] = $type;
            $num = M('mz_user_collect')->where($data)->count();
            if($num<1){

                M('mz_user_collect')->add($data);
            }
        }
        $zan = M($table)->where($where)->find();
        $zan['zan'] = $zan['zan']+1;
        M($table)->where($where)->save($zan);
    //    echo $id.'---'.$match;
    }

}