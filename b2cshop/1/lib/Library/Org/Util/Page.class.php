<?php
// +----------------------------------------------------------------------
// | ThinkPHP [ WE CAN DO IT JUST THINK IT ]
// +----------------------------------------------------------------------
// | Copyright (c) 2009 http://thinkphp.cn All rights reserved.
// +----------------------------------------------------------------------
// | Licensed ( http://www.apache.org/licenses/LICENSE-2.0 )
// +----------------------------------------------------------------------
// | Author: liu21st <liu21st@gmail.com>
// |         lanfengye <zibin_5257@163.com>
// +----------------------------------------------------------------------
namespace Org\Util;

class Page {
    
    // 分页栏每页显示的页数
    public $rollPage = 9;
	//每页的一半参数
	public $helfPage='';
    // 页数跳转时要带的参数
    public $parameter  ;
    // 分页URL地址
    public $url     =   '';
    // 默认列表每页显示行数
    public $listRows = 12;
    // 起始行数
    public $firstRow    ;
    // 分页总页面数
    protected $totalPages  ;
    // 总行数
    protected $totalRows  ;
    // 当前页数
    protected $nowPage    ;
    // 分页的栏的总页数
    protected $coolPages   ;
    // 分页显示定制
    protected $config  =    array('header'=>'个职位','prev'=>'上一页','next'=>'下一页','first'=>'第一页','last'=>'最后一页','theme'=>'  %upPage%   %linkPage%  %downPage%');
    // 默认分页变量名
    protected $varPage;

    /**
     * 架构函数
     * @access public
     * @param array $totalRows  总的记录数
     * @param array $listRows  每页显示记录数
     * @param array $parameter  分页跳转的参数
     */
    public function __construct($totalRows,$listRows='',$parameter='',$url='') {
        $this->totalRows    =   $totalRows;
        $this->parameter    =   $parameter;
        $this->varPage      =   C('VAR_PAGE') ? C('VAR_PAGE') : 'p' ;
        if(!empty($listRows)) {
            $this->listRows =   intval($listRows);
        }
        $this->totalPages   =   ceil($this->totalRows/$this->listRows);     //总页数
        $this->coolPages    =   ceil($this->totalPages/$this->rollPage);
		$this->helfPage      =    intval(($this->rollPage-3)/2+1);
        $this->nowPage      =   !empty($_GET[$this->varPage])?intval($_GET[$this->varPage]):1;
        if(!empty($this->totalPages) && $this->nowPage>$this->totalPages) {
            $this->nowPage  =   $this->totalPages;
        }
        $this->firstRow     =   $this->listRows*($this->nowPage-1);
    }

    public function setConfig($name,$value) {
        if(isset($this->config[$name])) {
            $this->config[$name]    =   $value;
        }
    }

    /**
     * 分页显示输出
     * @access public
     */
    public function show() {
        if(0 == $this->totalRows) return '';
        $p              =   $this->varPage;
        $nowCoolPage    =   ceil($this->nowPage/$this->rollPage);

        // 分析分页参数
        if($this->url){
            $depr       =   C('URL_PATHINFO_DEPR');
            $url        =   rtrim(U('/'.$this->url,'',false),$depr).$depr.'__PAGE__';
        }else{
            if($this->parameter && is_string($this->parameter)) {
                parse_str($this->parameter,$parameter);
            }elseif(empty($this->parameter)){
                unset($_GET[C('VAR_URL_PARAMS')]);
                if(empty($_GET)) {
                    $parameter  =   array();
                }else{
                    $parameter  =   $_GET;
                }
            }
            $parameter[$p]  =   '__PAGE__';
            $url            =   U('',$parameter);
        }
        //上下翻页字符串
        $upRow          =   $this->nowPage-1;
        $downRow        =   $this->nowPage+1;
        if ($upRow>0){
            $upPage     =   "<li><a href='".str_replace('__PAGE__',$upRow,$url)."'>".$this->config['prev']."</a></li>";
        }else{
            $upPage     =   "<li  class='disabled'><a href='#'  >".$this->config['prev']."</a></li>";
        }
		
		//上翻页
		  if ($upRow >= 1){
            $upPage   =   "<li><a href='".str_replace('__PAGE__',$downRow,$url)."'>".$this->config['prev']."</a></li>";
        }else{
            $upPage   =   "<li  class='disabled'><a    href='#'>".$this->config['prev']."</a></li>";
			$downPage = "<li  class='disabled'><a href='#'>".$this->config['next']."</a></li>";
        }

		//下翻页
        if ($downRow <= $this->totalPages){
            $downPage   =   "<li><a href='".str_replace('__PAGE__',$downRow,$url)."'>".$this->config['next']."</a></li>";
        }else{
            $downPage   =   "<li  class='disabled'><a   href='#'>".$this->config['next']."</a></li>";
        }
        // << < > >>
        if($nowCoolPage == 1){
            $theFirst   =   '';
            $prePage    =   '';
        }else{
            $preRow     =   $this->nowPage-$this->rollPage;
            $prePage    =   "<li><a href='".str_replace('__PAGE__',$preRow,$url)."' >上".$this->rollPage."页</a></li>";
            $theFirst   =   "<li><a href='".str_replace('__PAGE__',1,$url)."' >".$this->config['first']."</a></li>";
        }
        if($nowCoolPage == $this->coolPages){
            $nextPage   =   '';
            $theEnd     =   '';
        }else{
            $nextRow    =   $this->nowPage+$this->rollPage;
            $theEndRow  =   $this->totalPages;
            $nextPage   =   "<li><a href='".str_replace('__PAGE__',$nextRow,$url)."' >下".$this->rollPage."页</a></li>";
            $theEnd     =   "<li><a href='".str_replace('__PAGE__',$theEndRow,$url)."' >".$this->config['last']."</a></li>";
        }
        // 1 2 3 4 5
		$linkPage="";
		 if($this->totalPage > $this->rollPage){
				$page=1;
				$linkPage = "<li><a href='".str_replace('__PAGE__',$page,$url)."'>".$page."</a></li>";
				for($i=1;$i<=($this->rollPage-2);$i++){

					$page  = intval($this->nowPage)-$this->helfPage+intval($i);//循环中的页数

					if($page!=$this->nowPage){
						if($page>=3 && ( $page == ($this->nowPage-2) ||  $page == ($this->nowPage+2) )  ){
							$linkPage .= "<li><a href='".str_replace('__PAGE__',$page,$url)."'>...</a></li>";
						}else if( $page>0 ) {
							$linkPage .= "<li><a href='".str_replace('__PAGE__',$page,$url)."'>".$page."</a></li>";
						}else{
							
						};
					}else{
							$linkPage .= "<li class='active'><a  href='' class='current'>".$page."</a></li>";
					}
				}
				$page=$this->totalPages;
				if($page>1){
					$linkPage .= "<li><a href='".str_replace('__PAGE__',$page,$url)."'>".$page."</a></li>";//尾页
				}
		 }else{
				for($i=1;$i<=($this->totalPages);$i++){
					$page=$i;
					if($i!=$this->nowPage){
							
							$linkPage .= "<li><a href='".str_replace('__PAGE__',$page,$url)."'>".$page."</a></li>";
				
					}else{
							$linkPage .= "<li class='active'><a href='#' class='current'>".$page."</a></li>";
					}
				}			
		 }

        $pageStr     =   str_replace(
            array('%header%','%nowPage%','%totalRow%','%totalPage%','%upPage%','%downPage%','%first%','%prePage%','%linkPage%','%nextPage%','%end%'),
            array($this->config['header'],$this->nowPage,$this->totalRows,$this->totalPages,$upPage,$downPage,$theFirst,$prePage,$linkPage,$nextPage,$theEnd),$this->config['theme']);
        return $pageStr;
    }

}