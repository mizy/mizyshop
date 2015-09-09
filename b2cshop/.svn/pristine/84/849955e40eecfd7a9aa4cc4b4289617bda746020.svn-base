<?php
/**
 * Created by PhpStorm.
 * User: Mizy
 * Date: 14-9-25
 * Time: 下午9:35
 */
namespace Admin\Controller;
use Common\Controller\AdminController;
use Common\Controller\ClassManagerController;
use Think\Exception;

class ClassController extends AdminController {

    //判断用户是否登录
    public function index(){

        $this->checkLogin();

        //输出分类
        $classManager= new ClassManagerController();
        $res = $classManager->getClass();

        for($i=0;$i<Count($res);$i++){
            $wh['id'] = $res[$i]['module'];
            $Module = M('mz_module')->where($wh)->find();
            $res[$i]['moduleTitle'] = $Module['title'];
        }

        $this->assign("classList",$res);
        $this->display();
    }

    //添加Class
    public function addClass(){
        $this->checkLogin();

        //输出分类
        $classManager= new ClassManagerController();
        $res = $classManager->getClass();
        $moduleList = M('mz_module')->select();

        $this->assign('moduleList',$moduleList);
        $this->assign('classList',$res);
        $this->display();
    }

    public  function  addClassForm($imgData=''){

        //检查
        if(I('title','')!=''&&I('order','')!=''&&I('classId','')!=''){
            $data['title'] = I('title');
            $data['order'] = I('order');
            $data['father'] = I('classId');
            $data['desc'] = I('desc');
            $data['hot'] = I('hot','0');
            $data['module'] = I('module','0');
            $data['alias'] = I('alias','');

            //父类子目录数目加一
            $where['id'] = $data['father'];
            $father = M('mz_class')->where($where)->find();

            //子类目的层数加一
            $data['layer'] = $father['layer'] + 1;

            //添加子类目
            try{
                $class_id = M('mz_class')->add($data);
                //保存图片
                if($imgData!=''){
                    $imgData = json_decode($imgData,'true');
                    for($i = 0;$i<Count($imgData);$i++){
                        if($imgData[$i]['url']!=''){
                            $imgSaveData['url'] = $imgData[$i]['url'];
                            $imgSaveData['title'] = $imgData[$i]['title'];
                            $imgSaveData['class'] = $class_id;
                            M('mz_class_info')->add($imgSaveData);
                        }
                    }
                }

                $this->ajaxReturn("success");
            }catch (Exception $e){
                $this->ajaxReturn('failed,insert error:'.$e);
            }
        }else{
            $this->ajaxReturn('no param::'.I('title').I('order').I('classId'));
        }
    }

    //修改类目
    public  function  modClass(){
        $this->checkLogin();

        //检索存在的类目
        $where['id']=I('id');
        $class = M('mz_class')->where($where)->find();

        //输出图片
        $whereImg['class'] = I('id');
        $imgList = M('mz_class_info')->where($whereImg)->select();

        //输出分类
        $classManager= new ClassManagerController();
        $res = $classManager->getClass();

        //类型
        $moduleList = M('mz_module')->select();

        $this->assign('imgList',$imgList);
        $this->assign('moduleList',$moduleList);
        $this->assign('classList',$res);
        $this->assign('class',$class);
        $this->display();
    }

    //修改类目表单
    public  function  modClassForm($imgData='',$imgModInfo=''){
        //检查
        if(I('id','')!=''&&I('title','')!=''&&I('order','')!=''&&I('classId','')!=''){

            $data['title'] = I('title');
            $data['order'] = I('order');
            $data['father'] = I('classId');
            $data['desc'] = I('desc');
            $data['hot'] = I('hot','');
            $data['module'] = I('module','0');
            $data['alias'] = I('alias','');

            //新父类获取
            $where['id'] = $data['father'];
            $father = M('mz_class')->where($where)->find();

            //子类目的层数加一
            $data['layer'] = $father['layer'] + 1;

            //图片删除修改
            if($imgModInfo != ''){
                $imgModInfo = json_decode($imgModInfo,true);
            }
            for($i=0;$i<Count($imgModInfo);$i++){
                $imgWhere['id'] = $imgModInfo[$i]['id'];
                if($imgModInfo[$i]['delete']=='true'){
                    M('mz_class_info')->where($imgWhere)->delete();
                }else{
                    $imgData0['title'] = $imgModInfo[$i]['title'];
                    M('mz_item_info')->where($imgWhere)->save($imgData0);
                }
            }

            //保存子类目
            $id['id'] = I('id');
            try{
                $class_id = M('mz_class')->where($id)->save($data);
                //保存图片

                if($imgData!=''){
                    $imgData = json_decode($imgData,true);
                    for($i = 0;$i<Count($imgData);$i++){
                        if($imgData[$i]['url']!=''){
                            $imgSaveData['url'] = $imgData[$i]['url'];
                            $imgSaveData['title'] = $imgData[$i]['title'];
                            $imgSaveData['class'] = $id['id'];
                            M('mz_class_info')->add($imgSaveData);
                        }
                    }
                }

                $this->ajaxReturn("success");
            }catch (Exception $e){
                $this->ajaxReturn('failed,insert error:'.$e);
            }
        }else{
            $this->ajaxReturn('no param::'.I('title').I('order').I('classId'));
        }

    }

    //删除
    public function deleteThis(){
        $id = I('id','null');

        if(M('mz_class')->where("id = $id")->delete()){

            $this->ajaxReturn('success');
        }else{
            $this->ajaxReturn('wrong!delete failed::'.$id);
        }
    }
}