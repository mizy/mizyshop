<?php
/**@author:  mizy
 *@首页生成类
 *@2014/3/26 星期三
 */
namespace Home\Controller;
use Common\Controller\SiteController;
use Common\Controller\ClassManagerController;
class ItemController extends SiteController {

    public function index($id=''){

        $this->getSite();

        if($id==''){
            $this->redirect( 'Index/index' );
        }

        //获取浏览历史
        $this->getHistory();

        $this->assign('id',$id);
        //获取类目信息
        $item = M('mz_item')->where("id = $id")->find();
        $classId = $item['class'];
        $class = M('mz_class')->where("id=$classId")->find();

        $where['father'] = $class['id'];
        $classChild = M('mz_class')->where($where)->select();
        for($i=0;$i<Count($classChild);$i++){
            $id = $classChild[$i]['id'];
            $classChild[$i]['child'] = M('mz_class')->where("father=$id")->select();
        }

        //面包屑
        $layer = $class['layer']-1;
        $nowClass=$class;
        for($i=$layer;$i>=0;$i--){
            $brandHead[] = $nowClass;
            $whereBrand['id'] = $nowClass['father'];
            $nowClass = M('mz_class')->where($whereBrand)->find();
        }

        //头部信息和类信息
        $this->assign('brandHead',array_reverse($brandHead));
        $this->assign('childClass',$classChild);
        $this->assign('class',$class);

        //销售榜
        $where = '';
        //新的类管理类
        $classManager2= new ClassManagerController();
        $classList = $classManager2->getClass($class['id']) ;
        $classQuery = "class = ".$class['id']." ";
        if ($classList!=''){
            for($i = 0;$i<Count($classList);$i++){
                $classQuery = $classQuery."OR class=".$classList[$i]['id']." ";
            }
        };
        //状态为1的取出
        $classQuery = '('.$classQuery.')'. " AND status = 1";
        $soldList = M('mz_item')->where($classQuery)->order("visit_times desc")->limit(10)->select();
        $where='';
        if(Count($soldList)>0){
            $where['item']=$soldList[0]['id'];
            $where['type']='desc';
            $soldList[0]['img'] = M('mz_item_info')->where($where)->find();
        }

        //商品详情
        $item['img'] = M('mz_item_info')->where("`type`='desc' AND  item = ".$item['id'])->select();

        //商品其他属性
        if($item['module']!=1){
            $item['color'] = M('mz_item_info')->where("`type`='color' AND item=".$item['id'])->select();
        }

        //商品加一
        $id=$item['id'];
        $item['visit_times'] = intval( $item['visit_times'])+1;
        M('mz_item')->where("id = $id")->save($item);

        //浏览历史
        $flag = true;
        $visitedItem = cookie('visitedItem');
        $visitedItem = json_decode($visitedItem,true);
        foreach( $visitedItem as $each){
            if($each == $id){
                $flag = false;
                break;
            }
        }
        if($flag){
            $visitedItem[] = $id;
            $visitedItem = json_encode($visitedItem);
            cookie('visitedItem',$visitedItem,'1000000');
        }


        $this->assign('soldList',$soldList);
        $this->assign('item',$item);
        $this->display();
    }

    public function match($id=''){
        $this->getSite();

        if($id==''){
            $this->redirect( 'Index/index' );
        }

        //获取浏览历史
        $this->getHistory();

        $this->assign('id',$id);
        //获取类目信息
        $match = M('mz_match')->where("id = $id")->find();
        $classId = $match['class'];
        $class = M('mz_class')->where("id=$classId")->find();

        $where['father'] = $class['id'];
        $classChild = M('mz_class')->where($where)->select();
        for($i=0;$i<Count($classChild);$i++){
            $id = $classChild[$i]['id'];
            $classChild[$i]['child'] = M('mz_class')->where("father=$id")->select();
        }

        //面包屑
        $layer = $class['layer']-1;
        $nowClass=$class;
        for($i=$layer;$i>=0;$i--){
            $brandHead[] = $nowClass;
            $whereBrand['id'] = $nowClass['father'];
            $nowClass = M('mz_class')->where($whereBrand)->find();
        }

        //头部信息和类信息
        $this->assign('brandHead',array_reverse($brandHead));
        $this->assign('childClass',$classChild);
        $this->assign('class',$class);

        //热门
        $where = '';
        //新的类管理类
        $classManager2= new ClassManagerController();
        $classList = $classManager2->getClass($class['id']) ;
        $classQuery = "class = ".$class['id']." ";
        if ($classList!=''){
            for($i = 0;$i<Count($classList);$i++){
                $classQuery = $classQuery."OR class=".$classList[$i]['id']." ";
            }
        };
        //状态为1的取出
        $classQuery = '('.$classQuery.')'. " AND status = 1";
        $soldList = M('mz_match')->where($classQuery)->order("visit_times desc")->limit(10)->select();
        $where='';
        if(Count($soldList)>0){
            $where['match']=$soldList[0]['id'];
            $soldList[0]['img'] = M('mz_match_info')->where($where)->find();
        }

        //商品详情
        $match['img'] = M('mz_match_info')->where(" `match`=".$match['id'])->select();

        //itemList搭配包含的商品
        $itemString = explode('_',$match['item']);
        $itemQuery = '';
        foreach($itemString as $eachItemId){
            if($itemQuery ==''){
                $itemQuery = " item=$eachItemId";
            }else{
                $itemQuery .= " OR item=$eachItemId";
            }
        }

        $itemList = M('mz_item_info')->join('mz_item ON mz_item_info.item = mz_item.id')->where($itemQuery)->where("`type`='desc'")->group('item')->select();

        //商品加一
        $id=$match['id'];
        $match['visit_times'] = intval( $match['visit_times'])+1;
        M('mz_match')->where("id = $id")->save($match);

        $this->assign('itemList',$itemList);
        $this->assign('soldList',$soldList);
        $this->assign('match',$match);
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
        echo $id.'---'.$match;
    }

}