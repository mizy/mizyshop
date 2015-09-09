<?php
/**@author:  mizy
 *@首页生成类
 *@2014/3/26 星期三
 */
namespace Home\Controller;
use Common\Controller\SiteController;
class PayController extends SiteController {

    public function index( ){
        $this->checkLogin();
        $this->getSite();
        if(I('id','')==''){
            $this->redirect('Index/index');
        }
        $order = M('mz_order')->where("id=".I('id'))->find();
        $this->assign('order',$order);
        $this->display();
        
    }

    //支付宝
    public function alipay($id=''){
        $this->checkLogin();

        if($id==''){
            $this->redirect('Index/index');
        }
        require_once("alipay/alipay.config.php");
        require_once("alipay/alipay_submit.class.php");

        $order=M('mz_order')->where("id=$id")->find();

        //支付类型
        $payment_type = "1";
        //必填，不能修改
        //服务器异步通知页面路径
        $notify_url = "http://b2cshop.sinaapp.com/Home/Pay/notify";
        //需http://格式的完整路径，不能加?id=123这类自定义参数

        //页面跳转同步通知页面路径
        $return_url = "http://b2cshop.sinaapp.com/Home/Pay/returnUrl";
        //需http://格式的完整路径，不能加?id=123这类自定义参数，不能写成http://localhost/

        //卖家支付宝帐户
        $seller_email = 'baixuetao@gmail.com';
        //必填

        //商户订单号
        $out_trade_no = $order['order_id'];
        //商户网站订单系统中唯一订单号，必填

        //订单名称
        $subject = 'b1queen模范行装服务';
        //必填

        //付款金额
        $price = $order['total_price'];
        //必填

        //商品数量
        $quantity = "1";
        //必填，建议默认为1，不改变值，把一次交易看成是一次下订单而非购买一件商品
        //物流费用
        $logistics_fee = "0.00";
        //必填，即运费
        //物流类型
        $logistics_type = "EXPRESS";
        //必填，三个值可选：EXPRESS（快递）、POST（平邮）、EMS（EMS）
        //物流支付方式
        $logistics_payment = "SELLER_PAY";
        //必填，两个值可选：SELLER_PAY（卖家承担运费）、BUYER_PAY（买家承担运费）
        //订单描述

        $body =$order['beizhu'];
        //商品展示地址
        $show_url = 'http://b1queen.com/Home/User/index.html';
        //需以http://开头的完整路径，如：http://www.商户网站.com/myorder.html

        //收货人姓名
        $receive_name = '';
        //如：张三

        //收货人地址
        $receive_address = '';//$order['address_id'];
        //如：XX省XXX市XXX区XXX路XXX小区XXX栋XXX单元XXX号

        //收货人邮编
        $receive_zip = '';
        //如：123456

        //收货人电话号码
        $receive_phone = '';
        //如：0571-88158090

        //收货人手机号码
        $receive_mobile = '';
        //如：13312341234
        /************************************************************/

        //构造要请求的参数数组，无需改动
        $parameter = array(
            "service" => "trade_create_by_buyer",
            "partner" => trim($alipay_config['partner']),
            "payment_type"	=> $payment_type,
            "notify_url"	=> $notify_url,
            "return_url"	=> $return_url,
            "seller_email"	=> $seller_email,
            "out_trade_no"	=> $out_trade_no,
            "subject"	=> $subject,
            "price"	=> $price,
            "quantity"	=> $quantity,
            "logistics_fee"	=> $logistics_fee,
            "logistics_type"	=> $logistics_type,
            "logistics_payment"	=> $logistics_payment,
            "body"	=> $body,
            "show_url"	=> $show_url,
             "receive_name"	=> $receive_name,
            "receive_address"	=> $receive_address,
            "receive_zip"	=> $receive_zip,
            "receive_phone"	=> $receive_phone,
            "receive_mobile"	=> $receive_mobile,
            "_input_charset"	=> trim(strtolower($alipay_config['input_charset']))
        );

        //建立请求
        $alipaySubmit = new AlipaySubmit($alipay_config);
        $html_text = $alipaySubmit->buildRequestForm($parameter,"get", "确认");
         echo $html_text;

    }

    public function notify(){

        require_once("alipay/alipay.config.php");
        require_once("alipay/alipay_notify.class.php");

        //计算得出通知验证结果
        $alipayNotify = new AlipayNotify($alipay_config);
        $verify_result = $alipayNotify->verifyNotify();

        if($verify_result) {//验证成功
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            $out_trade_no = $_POST['out_trade_no'];

            //支付宝交易号

            $trade_no = $_POST['trade_no'];

            //交易状态
            $trade_status = $_POST['trade_status'];


            if($_POST['trade_status'] == 'WAIT_BUYER_PAY') {
                //该判断表示买家已在支付宝交易管理中产生了交易记录，但没有付款


            }
            else if($_POST['trade_status'] == 'WAIT_SELLER_SEND_GOODS') {
                 //买家已付款
                  $order='';
                  $order['status'] = 1;
                  M('mz_order')->where('order_id='.$out_trade_no)->save($order);
            }
            else if($_POST['trade_status'] == 'WAIT_BUYER_CONFIRM_GOODS') {
                //卖家已发货
                $order='';
                $order['status'] = 2;
                M('mz_order')->where('order_id='.$out_trade_no)->save($order);
            }
            else if($_POST['trade_status'] == 'TRADE_FINISHED') {
                //交易完成
                $order='';
                $order['status'] = 3;
                M('mz_order')->where('order_id='.$out_trade_no)->save($order);
            }
            else {

            }

            //——请根据您的业务逻辑来编写程序（以上代码仅作参考）——

            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        }
        else {

        }
    }

    public function returnUrl(){

        require_once("alipay/alipay.config.php");
        require_once("alipay/alipay_notify.class.php");

        //计算得出通知验证结果
        $alipayNotify = new AlipayNotify($alipay_config);
        $verify_result = $alipayNotify->verifyReturn();
        if($verify_result) {//验证成功


            $out_trade_no = $_GET['out_trade_no'];

            //支付宝交易号

            $trade_no = $_GET['trade_no'];

            //交易状态
            $trade_status = $_GET['trade_status'];


            if($_GET['trade_status'] == 'WAIT_SELLER_SEND_GOODS') {

            }
            else if($_GET['trade_status'] == 'TRADE_FINISHED') {

            }
            else {
                echo "trade_status=".$_GET['trade_status'];
            }

            $this->redirect('Pay/Success');
            echo "验证成功<br />";
            echo "trade_no=".$trade_no;

            //——请根据您的业务逻辑来编写程序（以上代码仅作参考）——

            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        }
        else {
            //验证失败
            //如要调试，请看alipay_notify.php页面的verifyReturn函数
            echo "验证失败";
        }
    }

    public function success(){
        $this->getSite();
        $this->display();
    }
}