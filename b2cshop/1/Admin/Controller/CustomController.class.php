<?php
/**@author:  mizy
 *@首页生成类
 *@2014/3/26 星期三
 */
namespace Admin\Controller;
use Common\Controller\AdminController;
use Common\Controller\ClassManagerController;
class CustomController extends AdminController {

    public function index(){

        $this->checkLogin();
        

   }

    public function addDesigner(){
        $this->checkLogin();
        $fuwuList = M('mz_designer_fuwu')->select();

        $this->assign('fuwulist',$fuwuList);
        $this->display();
    }

    public function addFuwuForm($editorValue='',$imgData='',$fuwuStr='',$fuwu=''){
        $this->checkLogin();
        $data['name'] = I('name','');
        $data['desc'] = $editorValue;
        $data['status'] = 1;//默认上线
        $data['fuwu'] = $fuwuStr;

        $designer = M('mz_designer')->add($data);

        //保存服务
        $fuwu = json_decode($fuwu,true);
        foreach($fuwu as $F){
            $data='';
            $data = $F;
            $data['designer'] = $designer;
            M('mz_designer_fuwu_info')->add($data);
        }

        print_r($fuwu);
        //保存图片
        $imgData = json_decode($imgData,true);
        foreach($imgData as $img){
            $data='';
            $data = $img;
            $data['designer'] = $designer;
            M('mz_designer_info')->add($data);
        }

        $this->ajaxReturn('success');
    }

}