<?php
/**@athor:  mizy
 *@class 类目管理
 *@2014/4/8 星期二
 */
namespace Common\Controller;
use Think\Controller;

class ClassManagerController extends Controller {
    private  $res='';
    private  $res_id=0;

    public  function getClass($id=''){
        if($id==''){

            //导航栏,内容栏这一层的类目
            $superFather = M('mz_class')->where('father < 0')->select();
            //分别查找对应的子类
            $this->findChild($superFather);//导航栏,内容栏
            return $this->res;
        }else{

            //导航栏,内容栏这一层的类目
            if( $superFather = M('mz_class')->where('father = '.$id)->select()){
                //分别查找对应的子类
                $this->findChild($superFather);//导航栏,内容栏
                return $this->res;
            }else{
                return  $res='';
            }

        }

    }

    //获取标题
    private  function getTitle($father){
        $attr = '';
        for($i = 0;$i<$father['layer'];$i++){
            $attr = $attr.'————&nbsp;';
        }
        $father['title']  = $attr.$father['title'];
        return($father['title']);
    }

    //查询子类方法 @father : 父类数组
    private function findChild($father){
         //父类循环
        for($f=0;$f<Count($father);$f++){

            //结果集录入父类
            $this->res[$this->res_id]  = $father[$f];
            $this->res[$this->res_id]['title'] = $this->getTitle($father[$f]);

            $this->res_id +=1;

            //查找该类下的数据
            $where['father'] = $father[$f]['id'];
            $child = M('mz_class')->where($where)->order('`order`')->select();

            //分别查找对应的子类，递归
            $this->findChild($child);

        }

    }


}