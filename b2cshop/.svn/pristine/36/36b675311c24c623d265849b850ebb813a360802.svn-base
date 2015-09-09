<?php
/**@author:  mizy
 *@首页生成类
 *@2014/3/26 星期三
 */
namespace Admin\Controller;
use Common\Controller\AdminController;
use Common\Controller\ClassManagerController;
use Think\Exception;

class ProductController extends AdminController {
    public function index($p=1,$classId=''){
        //检查登陆
        $this->checkLogin();

        //输出分类
        $classManager= new ClassManagerController();
        $res = $classManager->getClass();

        //分页
        $num = M('mz_item')->count();
        $page = new \Org\Util\Page($num,20);//每页12条数据
        $showList = $page->show();

        //排序查询
        $orderType = I('orderType','create_time');
        $where='';
        if($classId !=''){
            //新的类管理类
            $classManager2= new ClassManagerController();
            $classList = $classManager2->getClass($classId) ;
            $classQuery = "class = ".$classId." ";
            for($i = 1;$i<Count($classList);$i++){
                $classQuery = $classQuery."OR class=".$classList[$i]['id']." ";
            }

            $where['_string'] = $classQuery;
        }
        $query = I('query','');
        if( $query != ''){
            $where['title'] = array('like','%'.$query.'%');
        }
        $where['_logic'] ="AND";
        //取出所有
        $itemList = M(' mz_item')->page($p,$page->listRows)->where($where)->order($orderType)->select();

        $this->assign('productList',$itemList);
        $this->assign('showList',$showList);
        $this->assign('classId',$classId);
        $this->assign('orderType',$orderType);
        $this->assign('classList',$res);
        $this->display();

    }

    //批量操作
    public function batchDeal($data = ''){
        $data = json_decode($data,true);
        if(I('type','')=='delete'){
            foreach($data as $eachItem){
                M(I('table',''))->where('id = '.$eachItem['id'])->delete();
            }
        }else if(I('type','')=='shangjia'){//上架
            $saveData['status'] = 1;
            foreach($data as $eachItem){
                M(I('table',''))->where('id = '.$eachItem['id'])->save($saveData);
            }
        }else if(I('type','')=='shangjia'){//下架
            $saveData['status'] = 0;
            foreach($data as $eachItem){
                M(I('table',''))->where('id = '.$eachItem['id'])->save($saveData);
            }
        }else{
            $this->ajaxReturn('no type');
        }
        $this->ajaxReturn('success');
    }
    //删除
    public function deleteThis($module='0'){
        $id = I('id','-1');
        $table = 'mz_item';
        if($module == 1){
            $table = 'mz_match';
        }

        if( M($table)->where("id = $id")->delete()){
           $this->ajaxReturn('success');
       }else{
           $this->ajaxReturn("failed table:$table,id:$id,module:$module");
       }
    }
    //单品添加页面
    public function addProduct(){
        //检查登陆
        $this->checkLogin();

        //输出分类
        $classManager= new ClassManagerController();
        $res = $classManager->getClass();
        if(I('classId','')!=''){
            $WClass['id'] = I('classId');
            $class = M('mz_class')->where($WClass)->find();
            //$propertyList = $this->getProperty($class['module']);

            //$this->assign('propertyList',$propertyList);
            $this->assign('class',$class);
        }else{

            $this->assign('class',array('id'=>'-1'));
        }

        $brandList =  M('mz_brand')->select();

        $this->assign('brandList',$brandList);
        $this->assign('classList',$res);
        $this->display();
    }

    //获取属性 ！已经没用了！
    /*
    private function getProperty($moduleId){
        $where['father'] = $moduleId;
        $propertyList = M('mz_module_info')->where($where)->select();
        return $propertyList;
    }*/

    //添加表单
    public function addProductForm($domain = 'img',$editorValue='',$imgDesc='',$itemImg=''){
        //post表单的数据
        $item['desc'] =$editorValue;
        $item['title'] = I('title','');
        $item['module'] = I('module','0');
        $item['class'] = I('class','');
        $item['price'] = I('price','9999');
        $item['hot'] = I('hot','0');
        $item['status'] = I('status','0');
        $item['brand'] = I('brand','');
        $item['size'] = I('size','');
        $item['category'] = I('category','');
        $item['size'] = I('size','');
        $item['sold_num'] = I('sold_num','');
        $item['stock_num'] = I('stock_num','');
        if($item['class']=="" || $item['title']==""){
            $this->ajaxReturn("failed!请填写必填项");
        }

        $mz_item =  M('mz_item');
        //保存到数据库，同时获取返回的ID
        if(!$id = $mz_item->add($item)){
            $this->ajaxReturn('保存到数据库错误');
        }

        //保存颜色图片
        if($imgDesc!=''){
           $imgDesc = json_decode($imgDesc,true);
            for($i = 0;$i<Count($imgDesc);$i++){
                $imgDescData = $imgDesc[$i];
                $imgDescData['type'] = 'color';//颜色分类
                $imgDescData['item'] = $id;
                M('mz_item_info')->add($imgDescData);
            }
        }
        //保存主要图片
        if($itemImg!=''){
            $itemImg = json_decode($itemImg,true);
            for($i = 0;$i<Count($itemImg);$i++){
                $itemImgData = $itemImg[$i];
                $itemImgData['type'] = 'desc';//描述图片分类
                $itemImgData['item'] = $id;
                M('mz_item_info')->add($itemImgData);
            }
        }



        $this->ajaxReturn('success');

    }

    //修改产品页面
    public function modProduct(){
        $this->checkLogin();
        $id = I('id','');
        if($id==''){
            $this->redirect('Product/index');
        }
        $where['id'] =$id;

        //输出产品
        $product = M('mz_item')->where($where)->find();
        //输出分类
        $classManager= new ClassManagerController();
        $res = $classManager->getClass();
        //输出品牌
        $brandList =  M('mz_brand')->order('`order`')->select();
        //找到图片
        $item_info['item'] = $product['id'];
        $item_info['type'] = 'desc';
        $imgDesc = M('mz_item_info')->where($item_info)->order('id')->select();
        if($product['module'] == '0'){
            $item_info['type'] = 'color';
            $color = M('mz_item_info')->where($item_info)->order('id')->select();
            $this->assign('colorDesc0',$color);
        }
        if($product['module'] == '2'){
            $item_info['type'] = 'color';
            $color = M('mz_item_info')->where($item_info)->order('id')->select();
            $this->assign('colorDesc2',$color);
        }

        $this->assign('imgDesc',$imgDesc);
        $this->assign('brandList',$brandList);
        $this->assign('classList',$res);
        $this->assign('product',$product);
        $this->display();

    }

    //保存修改表单
    public function modProductForm($domain = 'img',$editorValue='',$imgDesc='',$itemImg=''){
        $id = I('id','');
        if($id==''){
            $this->redirect('Product/index');
        }else{
            $save['id'] = $id;
        }

        //post表单的数据
        $item['desc'] = $editorValue;
        $item['title'] = I('title','');
        $item['module'] = I('module','0');
        $item['class'] = I('class','');
        $item['price'] = I('price','9999');
        $item['hot'] = I('hot','0');
        $item['status'] = I('status','0');
        $item['brand'] = I('brand','');
        $item['size'] = I('size','');
        $item['category'] = I('category','');
        $item['size'] = I('size','');
        $item['sold_num'] = I('sold_num','');
        $item['stock_num'] = I('stock_num','');
        if($item['class']=="" || $item['title']==""){
            $this->ajaxReturn("failed!请填写必填项");
        }

        $mz_item =  M('mz_item');
        //保存到数据库，同时获取返回的ID
        if(!($mz_item->where($save)->save($item)>=0)){
            $this->ajaxReturn('保存到数据库错误:'.$id);
        }

        //保存颜色图片
        if($imgDesc!=''){
            $imgDesc = json_decode($imgDesc,true);
            for($i = 0;$i<Count($imgDesc);$i++){
                $imgDescData = $imgDesc[$i];
                $data='';
                $data['type']='color';
                $data['item'] = $id;
                $data['title'] = $imgDescData['title'];
                $data['url'] = $imgDescData['url'];
                //判断是否存在
                if($imgDescData['id']!=''){
                    $where='';
                    $where['id'] = $imgDescData['id'];

                    //判断是否删除
                    if($imgDescData['delete'] =='true'){
                        M('mz_item_info')->where($where)->delete();
                    }else{
                        M('mz_item_info')->where($where)->save($data);
                    }
                }else{
                    //保存新的
                    M('mz_item_info')->add($data);
                }
            }
        }
        //保存主要图片
        if($itemImg!=''){
            $itemImg = json_decode($itemImg,true);
            for($i = 0;$i<Count($itemImg);$i++){
                $imgImgData = $itemImg[$i];
                $data='';
                $data['type']='desc';
                $data['item'] = $id;
                $data['title'] = $imgImgData['title'];
                $data['url'] = $imgImgData['url'];
                //判断是否存在
                if($imgImgData['id']!=''){
                    $where='';
                    $where['id'] = $imgImgData['id'];
                    //判断是否删除
                    if($imgImgData['delete'] =='true'){
                        M('mz_item_info')->where($where)->delete();
                    }else{
                        M('mz_item_info')->where($where)->save($data);
                    }
                }else{
                    //保存新的
                    M('mz_item_info')->add($data);
                }
            }
        }
        $this->ajaxReturn('success');
    }

    //产品详情页面
    public function productInfo(){
        $this->modProduct();

    }

    public function searchItem(){
        if(I('query','')!=''){
            $q = urldecode(I('query'));
            $query['title'] = array('like','%'.$q.'%');
            $query['id'] = array('like','%'.$q.'%');
            $query['_logic'] = 'OR';
        }else{
            $this->ajaxReturn('{ [id:"-1",text:"无"]}');
            exit();
        }
        $res = M('mz_item')->where($query)->select();

        $this->ajaxReturn($res);
    }

    public function getItem($id){
        $res = M('mz_item')->where("id=$id")->find();
        $this->ajaxReturn($res);
    }

    //搭配详情
    public  function  match($p=1,$classId=''){
        //检查登陆
        $this->checkLogin();

        //输出分类
        $classManager= new ClassManagerController();
        $res = $classManager->getClass();

        //分页
        $num = M('mz_match')->count();
        $page = new \Org\Util\Page($num,20);//每页12条数据
        $showList = $page->show();

        //排序查询
        $orderType = I('orderType','create_time');
        $where='';
        if($classId !=''){
            $classManager2= new ClassManagerController();
            $classList = $classManager2->getClass($classId) ;
            $classQuery = "class =".$classId." ";
            for($i = 1;$i<Count($classList);$i++){
                $classQuery = $classQuery."OR class=".$classList[$i]['id']." ";
            }
            $where['_string'] = $classQuery;
        }
        $query = I('query','');
        if( $query != ''){
            $where['title'] = array('like','%'.$query.'%');
        }
        //取出所有
        $productList = M(' mz_match ')->page($p,$page->listRows)->where($where)->order($orderType)->select();

        $this->assign('productList',$productList);
        $this->assign('showList',$showList);
        $this->assign('classId',$classId);
        $this->assign('orderType',$orderType);
        $this->assign('classList',$res);
        $this->display();
    }

    public function addMatch(){
        $this->addProduct();
    }

    //match add表单
    public function addMatchForm($imgData=''){
        $data['title']  = I('title','');
        $data['class'] = I('class','');
        $data['hot'] = I('hot','');
        $data['item'] = I('item_data','');
        $data['desc'] = I('desc','');
        $data['status'] = I('status','0');
        $data['brand'] = I('brand','');

        if( $data['title']==''){
            $this->ajaxReturn('no input title');
            exit();
        }

        //处理上传图片
        try{
            $class_id = M('mz_match')->add($data);
            $this->imgSave($imgData,'','mz_match_info',$class_id);

            $this->ajaxReturn("success");
        }catch (Exception $e){
            $this->ajaxReturn('failed,insert error:'.$e);
        };
    }

    //match mod
    public function modMatch($id=''){
        if($id==''){
            $this->redirect('Product/match');
        }
        $match=M('mz_match')->where("id=$id")->find();
        $imgList = M('mz_match_info')->where("`match` = $id")->select();
        $this->assign('match',$match);
        $this->assign('imgList',$imgList);

        $this->addMatch();
    }

    public function modMatchForm($id='',$imgData='',$imgModInfo=''){
        $data['title']  = I('title','');
        $data['class'] = I('class','');
        $data['hot'] = I('hot','');
        $data['item'] = I('item_data','');
        $data['desc'] = I('desc','');
        $data['status'] = I('status','0');
        $data['brand'] = I('brand','');

        if( $id==''){
            $this->ajaxReturn('no id');
            exit();
        }

        //处理上传图片
        try{
            M('mz_match')->where("id = $id")->save($data);
            $this->imgSave($imgData,$imgModInfo,'mz_match_info',$id);
            $this->ajaxReturn("success");
        }catch (Exception $e){
            $this->ajaxReturn('failed,insert error:'.$e);
        };
    }

    public function imgSave($imgData,$imgModInfo,$table,$id){
        //保存图片
        if($imgData!=''){
            $imgData = json_decode($imgData,'true');
            for($i = 0;$i<Count($imgData);$i++){
                if($imgData[$i]['url']!=''){
                    $imgSaveData['url'] = $imgData[$i]['url'];
                    $imgSaveData['title'] = $imgData[$i]['title'];
                    $imgSaveData['match'] = $id;
                    M($table)->add($imgSaveData);
                }
            }
        };
        //图片删除修改
        if($imgModInfo != ''){
            $imgModInfo = json_decode($imgModInfo,true);
            for($i=0;$i<Count($imgModInfo);$i++){
                $imgWhere['id'] = $imgModInfo[$i]['id'];
                if($imgModInfo[$i]['delete']=='true'){
                    M($table)->where($imgWhere)->delete();
                }else{
                    $imgData['title'] = $imgModInfo[$i]['title'];
                    M($table)->where($imgWhere)->save($imgData);
                }
            }
        }
    }

    //matchInfo
    public function matchInfo($id=''){
        $this->modMatch($id);
    }
}
?>