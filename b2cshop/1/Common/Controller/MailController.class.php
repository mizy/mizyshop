<?php
/**
 * Created by PhpStorm.
 * User: Mizy
 * Date: 14-9-25
 * Time: 下午9:35
 */
namespace Common\Controller;
use Think\Controller;

class MailController extends Controller {

    //判断用户是否登录
    public function sendMail($mailList,$title,$mailTo,$content){

        $mail = new \SaeMail();
        $To= $mailList[0]['email'];
        for($i=1;$i<count($mailList);$i++){
            $To = $mailList[$i]['email'] . ',' .$To;
        }
        $mail->setOpt(
            array(
                'from' => 'admin',
                'to' => $To,
                'smtp_host' => 'smtp.163.com',
                'smtp_port' => '465',
                'smtp_username' => 'b2c1shop@163.com',
                'smtp_password' => 'b2c2shop',
                'subject' => $title,
                'content' => $content,
                'content_type' => 'html',
                'tls' => true
            )
        );

        if(!$ret=$mail->send()){

            $this->ajaxReturn(false);//($mail->ErrorInfo);


        }
        else
        {
           $this->ajaxReturn(true);
        }
    }
}