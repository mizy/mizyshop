<?php
/**@author:  mizy
 *@首页生成类
 *@2014/3/26 星期三
 */
namespace Home\Controller;
use Common\Controller\SiteController;
use Common\Controller\ClassManagerController;
class DesignerInfoController extends SiteController {

    public function index($p=1){
        session('back_url',"/Home/DesignerInfo/index");
        $this->checkLogin();
        $this->getSite();

        $user_id['user'] = session('user_id');
        if($designer = M('mz_designer')->where($user_id)->find()){
            if($designer['apply_status']=='1'){

                //申请成功，提取出订单
                $designer = M('mz_designer')->where('user='.session('user_id'))->find();
                $whereOrder['status'] = I('status','1');
                $whereOrder['type'] = 'yuyue';
                $whereOrder['designer'] = $designer['id'];
                $this->assign('yuyue','yuyue_'.$whereOrder['status']);
                //分页
                $order_num = M('mz_order')->where($whereOrder)->count();
                $page = new \Org\Util\Page($order_num,12);//每页20条数据
                $showList = $page->show();
                //取出订单
                $orderList = M('mz_order')->where($whereOrder)->order('order_time desc')->page($p,$page->listRows)->select();

                $this->assign('showList',$showList);
                $this->assign('orderList',$orderList);

                $this->display();
            }else{
                //申请处理中
                 $this->dealIng();
            }

        }else{
            //没有申请
            $this->redirect('DesignerInfo/apply');
        }
    }

    //申请中
    public function dealIng(){
        $this->getSite();

        $user_id['user'] = session('user_id');
        $designer = M('mz_designer')->where($user_id)->find();
        $this->assign('designer',$designer);
        $this->display('DesignerInfo/dealIng');
    }

    //申请表单
    public function apply(){
        $this->checkLogin();
        //是否申请过
        $user_id['user'] = session('user_id');
        if($designer = M('mz_designer')->where($user_id)->find()){
            $this->redirect('DesignerInfo/index');
        }
        $this->getSite();
        $this->display('DesignerInfo/apply');
    }

    //写入申请表单
    public function applyForm(){
        $this->checkLogin();
        $data['name'] = I('name','');
        $data['phone'] = I('phone','');
        $data['address'] = I('address','');
        $data['zizhi'] = I('zizhi','');
        $data['zuoping'] = I('zuoping','');
        $data['idCard'] = I('idCard','');
        $data['user'] = session('user_id');
        if(M('mz_designer')->add($data)){
            $this->redirect('DesignerInfo/dealIng');
        }else{
            $this->redirect('DesignerInfo/apply');
        }
    }

    //修改信息
    public function modInfo(){
        $this->checkLogin();
        $this->getSite();
        $where['user'] = session('user_id');
        $designer=M('mz_designer')->where($where)->find();
        $designer['img']=M('mz_designer_info')->where('designer='.$designer['id'])->select();

        $this->assign('designer',$designer);

         $this->display();
    }
    //修改信息表单提交
    public function modInfoForm($editorValue='',$imgData='',$modImgData=''){
        $this->checkLogin();
        $where['user'] = session('user_id');
        $designer = M('mz_designer')->where($where)->find();

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
            $value['designer']=$designer['id'];
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

    //服务通过
    public function fuwuDown($id=''){
        $this->checkLogin();
        $data['status'] = 2;
        if(        M('mz_order')->where('id='.$id)->save($data)    ){
            $this->ajaxReturn('success');
        }else{
            $this->ajaxReturn('failed.id:'.$id);

        }
    }
}