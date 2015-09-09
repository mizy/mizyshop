<?php
/**@author:  mizy
 *@首页生成类
 *@2014/3/26 星期三
 */
namespace Home\Controller;
use Common\Controller\SiteController;
use Common\Controller\ClassManagerController;
class ListController extends SiteController {

    public function index($id='',$p=1,$orderType='',$brand=''){

        $this->getSite();

        if($id==''){
            $this->redirect( 'Index/index' );
        }

        //原样返回
        $this->assign('orderType',$orderType);
        $this->assign('id',$id);
        $this->assign('brand',$brand);

        //获取类目信息
        $class = M('mz_class')->where("id=$id")->find();
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

        //判断是否为搭配
        //跳转回去
        if($class['module']!=0){
            $this->match($class,$id,$p,$orderType,$brand);
            exit();
        }

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
        $soldList = M('mz_item')->where($classQuery)->order("sold_num desc")->limit(10)->select();
        $where='';
        if(Count($soldList)>0){
            $where['item']=$soldList[0]['id'];
            $where['type'] = 'desc';
            $soldList[0]['img'] = M('mz_item_info')->where($where)->find();
        }

        //是否有此品牌
        $classQueryNoBrand = $classQuery;
        if($brand!=''){
            $classQuery .= " AND brand=$brand";
        }
        //品牌列表
        $brandList = M('mz_item')->join('mz_brand ON mz_item.brand = mz_brand.id')
      ->where($classQueryNoBrand)->group('brand')->select();

        for($i=0;$i<Count($brandList);$i++){
            $whereBrand = '';
            $whereBrand['brand'] = $brandList[$i]['id'];
            $brandList[$i]['num'] = M('mz_item')->where($classQueryNoBrand)->field('id')->where($whereBrand)->count();
        }

        //商品列表
        $num = M('mz_item')->where($classQuery)->count();
        $page = new \Org\Util\Page($num,20);//每页20条数据
        $showList = $page->show();

        //取出所有
        $itemList = M('mz_item')->where($classQuery)
            ->order($orderType)->page($p,$page->listRows)->select();
        for($i=0;$i<Count($itemList);$i++){
            $whereItem = '';
            $whereItem['item'] = $itemList[$i]['id'];
            $whereItem['type'] = 'desc';
            $itemList[$i]['img'] = M('mz_item_info')->where($whereItem)->find();
        }

        $this->assign('itemList',$itemList);
        $this->assign('brandList',$brandList);
        $this->assign('soldList',$soldList);
        $this->assign('showList',$showList);
        $this->assign('itemNum',$num);
        $this->display();
    }

    //搭配
    public  function match($class,$id,$p,$orderType,$brand){
        //热门榜
        $where = '';
        //新的类管理类
        $classManager2= new ClassManagerController();
        $classList = $classManager2->getClass($class['id']) ;
        $classQuery = "class = ".$class['id']." ";
        for($i = 0;$i<Count($classList);$i++){
            $classQuery = $classQuery."OR class=".$classList[$i]['id']." ";
        }

        //状态为1的取出
        $classQuery = '('.$classQuery.')'. " AND status = 1";
        $soldList = M('mz_match')->where($classQuery)->order("visit_times desc")->limit(10)->select();
        $where='';
        if(Count($soldList)>0){
            $where['match']=$soldList[0]['id'];
            $soldList[0]['img'] = M('mz_match_info')->where($where)->find();
        }

        //品牌筛选
        $classQueryNoBrand = $classQuery;
        if($brand!=''){
            $classQuery .= " AND brand=$brand";
        }

        //品牌列表
        $brandList = M('mz_match')->join('mz_brand ON mz_match.brand = mz_brand.id')
           ->group('brand') ->where($classQueryNoBrand)->select();
        for($i=0;$i<Count($brandList);$i++){
            $whereBrand = '';
            $whereBrand['brand'] = $brandList[$i]['id'];
            $brandList[$i]['num'] = M('mz_match')->where($classQueryNoBrand)->field('id')->where($whereBrand)->count();
        }

        //商品列表
        $num = M('mz_match')->where($classQuery)->count();

        $page = new \Org\Util\Page($num,20);//每页20条数据
        $showList = $page->show();

        //取出所有
        $itemList = M('mz_match')->where($classQuery)
           ->order($orderType)->page($p,$page->listRows)->select();
        for($i=0;$i<Count($itemList);$i++){
            $whereItem = '';
            $whereItem['match'] = $itemList[$i]['id'];
            $itemList[$i]['img'] = M('mz_match_info')->where($whereItem)->find();
        }

        $this->assign('itemList',$itemList);
        $this->assign('brandList',$brandList);
        $this->assign('soldList',$soldList);
        $this->assign('showList',$showList);
        $this->assign('itemNum',$num);
        $this->display('match');
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