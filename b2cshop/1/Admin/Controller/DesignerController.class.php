<?php
/**@author:  mizy
 *@首页生成类
 *@2014/3/26 星期三
 */
namespace Admin\Controller;
use Common\Controller\AdminController;
 class DesignerController extends AdminController {

    public function index($p=1,$query=''){

        $this->checkLogin();

        if($query==''){
            $where['name'] = array('like','%'.$query.'%');
        }else{
            $where='1=1';
        }
        $num = M('mz_designer')->where($where)->count();
        $page = new \Org\Util\Page($num,20);//每页20条数据
        $showList = $page->show();
        $designerList = M('mz_designer')->page($p,$page->listRows)->where($where)->select();

        $this->assign('showList',$showList);
        $this->assign('designerList',$designerList);
        $this->display();
    }

   //删除造型师
     public function deleteThis($id=''){
         $this->checkLogin();
         if($id!=''){
             M('mz_designer')->where('id='.$id)->delete();
             M('mz_designer_info')->where('designer='.$id)->delete();
            $this->ajaxReturn('success');
         }
     }

     //审核通过
     public function pass($id='null'){
        $this->checkLogin();
         $where['id'] = $id;
         $data['apply_status'] =1;
        if(M('mz_designer')->where($where)->save($data)){
            $this->ajaxReturn('success');
        }else{
            $this->ajaxReturn('failed');
        }
     }

     //详情
     public function modDesigner($id=''){
         $this->checkLogin();
         $designer=M('mz_designer')->where("id=$id")->find();
         $designer['img']=M('mz_designer_info')->where('designer='.$id)->select();
          $this->assign('designer',$designer);
         $this->display();
     }

     //修改表单
     public function modDesignerForm($id='',$editorValue='',$imgData='',$modImgData=''){
        if($id==''){
            $this->ajaxReturn('false');
        }
         $this->checkLogin();

         $where['id'] = $id;
         $data['desc'] = $editorValue;
         $data['name'] = I('name');
         $data['phone'] = I('phone');
         $data['idCard'] = I('idCard');
         $data['status'] = I('status');
         $data['zizhi'] = I('zizhi');
         $data['zuoping'] = I('zuoping');
         $data['address']=I('address');
         $data['price'] = I('price');
         $data['user'] =I('user');
         $data['apply_status'] = I('apply_status');
         $data['fuwu'] = I('fuwuStr');
         M('mz_designer')->where($where)->save($data);
         $imgData = json_decode($imgData,true);
         $modImgData = json_decode($modImgData,true);
        foreach($imgData as $value){
            $value['designer']=$id;
            M('mz_designer_info')->add($value);
        }
        foreach($modImgData as $value){
            $whereInfo['id'] = $value['id'];
            $modData['url'] = $value['url'];
            $modData['title']=$value['title'];
            if($value['delete'] == 'true'){
                M('mz_designer_info')->where($whereInfo)->delete();
            }else{
                M('mz_designer_info')->where($whereInfo)->save($modData);
            }
        }

        $this->ajaxReturn('success');
     }

     public function addDesigner(){
         $this->checkLogin();
         $this->display();
     }

     public function addDesignerForm(){
         $this->checkLogin();

         $data['name'] = I('name');
         $data['phone'] = I('phone');
         $data['idCard'] = I('idCard');
         $data['status'] = I('status');
         $data['zizhi'] = I('zizhi');
         $data['zuoping'] = I('zuoping');
         $data['address']=I('address');
         $data['price'] = I('price');
         $data['user'] =I('user');
         $data['apply_status'] = I('apply_status');
         $data['fuwu'] = I('fuwuStr');
         $designer_id = M('mz_designer')->add($data);
         $imgData = json_decode(I('imgData'),true);
         foreach($imgData as $value){
             $value['designer']=$designer_id;
             M('mz_designer_info')->add($value);
         }

         $this->ajaxReturn('success');
     }

     public function addFenglei(){
         $this->checkLogin();
         $fuwu = M('mz_designer_fuwu')->where('id=1')->find();
         $this->assign('fuwu',$fuwu);
         $this->display();
     }

     public  function addFengleiForm($fuwuStr=''){
         $this->checkLogin();
         $data['title'] =$fuwuStr;
         $where['id']=1;
         M('mz_designer_fuwu')->where($where)->save($data);
         $this->ajaxReturn('success');
     }

}