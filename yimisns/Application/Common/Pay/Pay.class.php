<?php
/**
 * 支付类
 * @author yangdong
 * 
 */
namespace Common\Pay;
use User\Model\UserModel;
class Pay {
    function __construct() {
        ;
    }
    
    /**
     * 1. 支付宝 在线支付生成加密字符串(SDK)
     * @return array
     */
    function alipay($order_no, $payprice, $subject='', $body='', $notity_url=''){
        header('Content-Type:text/html; charset=utf-8');
        require_once COMMON_PATH.'Pay/AppAli/alipay_rsa.function.php';
        require_once COMMON_PATH.'Pay/AppAli/alipay_core.function.php';
        $alipay_config = C('mobilepay_config');
        $app_id         = $alipay_config['app_id'];
        $method         = 'alipay.trade.app.pay';
        $timestamp      = date('Y-m-d H:i:s');
        $version        = '1.0';
        //$partner        = $alipay_config['partner'];
        //$seller_id      = $alipay_config['seller_id'];
        $out_trade_no   = $order_no;
        $subject        = $subject ? $subject : '会员充值';//String(128) 商品的标题/交易标题/订单标题/订单关键字等。
        $body           = $body ? $body :'充值';//String(512) 对一笔交易的具体描述信息。如果是多种商品,请将商品描述字符串累加传给 body。
        $total_fee      = $payprice;//支付金额
        $notify_url     = $notity_url ? $notity_url :$alipay_config['notify_url'];//回调通知地址
        //$service        = 'mobile.securitypay.pay';
        $payment_type   = '1';
        $charset = $alipay_config['input_charset'];
        $timeout_express       = '30m';
        //$show_url       = 'm.alipay.com';
        $biz_content['body']=$body;
        $biz_content['subject']=$subject;
        $biz_content['out_trade_no']=$out_trade_no;
        $biz_content['timeout_express']=$timeout_express;
        $biz_content['total_amount']=$total_fee;
        $biz_content['product_code']='QUICK_MSECURITY_PAY';
        $biz_content['payment_type']=$payment_type;
        $biz_content=json_encode($biz_content);
        //$biz_content=urlencode($biz_content);
         /*$para_sort = array(
            'partner'       => '"'.$partner.'"',
            'seller_id'     => '"'.$seller_id.'"',
            'out_trade_no'  => '"'.$out_trade_no.'"',
            'subject'       => '"'.$subject.'"',
            'body'          => '"'.$body.'"',
            'total_fee'     => '"'.$total_fee.'"',
            'notify_url'    => '"'.$notify_url.'"',
            'service'       => '"'.$service.'"',
            'payment_type'  => '"'.$payment_type.'"',
            '_input_charset'=> '"'.$_input_charset.'"',
            'it_b_pay'      => '"'.$it_b_pay.'"',
            'show_url'      => '"'.$show_url.'"',
        ); */
        
        /* $para_sort = array(
                'app_id'        => '\"'.$app_id.'\"',
                'method'        =>  '\"'.$method.'\"',
                'charset'       =>  '\"'.$charset.'\"',
                'timestamp'     =>  '\"'.$timestamp.'\"',
                'version'       => '\"'.$version.'\"',
                'sign_type'       => '\"RSA\"',
        		//'partner'       => '\"'.$partner.'\"',
        		//'seller_id'     => '\"'.$seller_id.'\"',
        		//'out_trade_no'  => '\"'.$out_trade_no.'\"',
        		//'subject'       => '\"'.$subject.'\"',
        		//'body'          => '\"'.$body.'\"',
        		//'total_fee'     => '\"'.$total_fee.'\"',
        		'notify_url'    => '\"'.$notify_url.'\"',
        		//'service'       => '\"'.$service.'\"',
        		//'payment_type'  => '\"'.$payment_type.'\"',
        		'charset'=> '\"'.$charset.'\"',
        		'timeout_express'  => '\"'.$timeout_express.'\"',
        		//'show_url'      => '\"'.$show_url.'\"',
        		'biz_content'     =>  '\"'.$biz_content.'\"'
        ); */
        $para_sort = array();
        $para_sort['app_id'] = $app_id;//支付宝分配给开发者的应用ID
        $para_sort['method'] = $method;//接口名称
        $para_sort['charset'] = $charset;//请求使用的编码格式
        $para_sort['sign_type'] = 'RSA';//商户生成签名字符串所使用的签名算法类型
        $para_sort['timestamp'] = $timestamp;//发送请求的时间
        $para_sort['version'] = $version;//调用的接口版本，固定为：1.0
        $para_sort['notify_url'] = $notify_url;//支付宝服务器主动通知地址
        $para_sort['biz_content'] = $biz_content;//业务请求参数的集合,长度不限,json格式
        /* ksort($para_sort);
        $prestr = createLinkstring($para_sort);
    
        $isSgin = false;
        switch (strtoupper(trim($alipay_config['sign_type']))) {
            case "RSA" :
                $isSgin = rsaSign($prestr, trim($alipay_config['private_key_path']));
                break;
            default :
                $isSgin = false;
        }
        if ($isSgin){
            $string = $prestr.'&sign=\"'.urlencode($isSgin).'\"'.'&sign_type=\"RSA\"';
            return showData(array('data'=>$string), '加密成功');
        }else {
            return showData(new \stdClass(), '加密失败', 1);
        } */
        //生成签名
        $paramStr =getSignContent($para_sort);
        $sign = alonersaSign($paramStr,trim($alipay_config['private_key_path']),'RSA',true);
        
        $para_sort['sign'] = $sign;
        $str = getSignContentUrlencode($para_sort);//返回给客户端
        return showData(array('data'=>$str), '加密成功');
    }
    /**
     * 1.1 支付宝（APP）
     * @param string $order_no
     * @param string $payprice
     */
    function appAlipay($order_no, $payprice, $subject='', $body='', $notity_url=''){
        $alipay_config = C('mobilepay_config');
        //支付宝支付的服务器端
        $partner = $alipay_config['partner'];
        $seller = $alipay_config['seller_id'];
        //坑，注意，需要转换密钥！！！ openssl pkcs8 -topk8 -inform PEM -in your.key -outform PEM -nocrypt > your_nocrypt.key
        // $privateKey=file_get_contents("/ramdisk/your_nocrypt.key");//这里为了方便直接写入到php文件里了。
        $privateKey=<<<EOF
-----BEGIN PRIVATE KEY-----
MIICXgIBAAKBgQDC7w+ouV9bDQLbJm/3n36O/Ytt883pG8Of4CKQJv9wVq1dygCk
RaNUM4iAX5C1+iuKUgMCNTQCoUFGxdvjj6mAd7U5tLzz+FLINVhNY4dUOdztktU9
66gTSMKGAUm/299eSDbkggQjZmY9YK3/udV3argS1RTi1gr+URAZBQz6QQIDAQAB
AoGAJ3kva5Q2GgL1fBk5fSRABYaUMGy5WqXzpDFH7nbnLQFwU9iu7pTncQqKbqxr
al5BaN4Ym97YLFwpEsLINzmFMhMRhcDGa+8jeP+m/yjo6a+ooCdIDOohPEOthsGN
3UKbU7NOjvUmtKv0OUsIOczOHjf+wXFK72RarCiFvWkwr40CQQDhhXcRgmr4LksF
bGbODuM4XTBjGROjGA34h3bZTBxcKlW+C2FaLN4uQ6/CdGmC0m1GU/x/NG+oLlBX
/uGtJ14TAkEA3UdWGvWd8Fr2Ow1Qn7Ff4mqesMNbS9u6JCgbnbngNxtcofgUYLIQ
I6ab6Ds6zFHIHBPP9sTVHB0jMhJbCBKA2wJBANYICsbtVYQQu1Z8WN07N95oYuHK
DN7+l1PFjMASAeBetV1WA6DHcF3ME2SjgveLqfXTA5HePBILUmkRFzF0aU0CQQCn
WPgJ04/q4yAtcNh0rZSyi6gQTu6Q5FBWX+7izlx/0LWx2QiwSHpkO/DVJVZGh+Mr
OOCi5CG37WFc0Pz/kd7ZAkEAjgHE5JliN9fSYWvDAd/mEgoZjHNR/JGQBLLyGg0y
z50RuUbnRDH2vWzkWfETrBYPvCXpgidpIrO/PiAkC8UOLg==
-----END PRIVATE KEY-----
EOF;
        //组装订单信息。可以让客户端传进来orderId等信息，这里连接数据库，查询价格，商品名等信息。ps：价格一定不要让客户端传进来,免得被骗:)
       
        $subject        = $subject ? $subject : '华浩联创';//String(128) 商品的标题/交易标题/订单标题/订单关键字等。
        $body           = $body ? $body :'购物';//String(512) 对一笔交易的具体描述信息。如果是多种商品,请将商品描述字符串累加传给 body。
        $notify_url     = $notity_url ? $notity_url :$alipay_config['notify_url'];//回调通知地址
        
        $dataString=sprintf('partner="%s"&seller_id="%s"&out_trade_no="%s"&subject="%s"&body="%s"&total_fee="%.2f"&notify_url="%s"&service="mobile.securitypay.pay"&payment_type="1"&_input_charset="utf-8"&it_b_pay="30m"&show_url="m.alipay.com"',$partner,$seller,$order_no,$subject,$body,$payprice,$notify_url);
        //获取签名
        $res = openssl_get_privatekey($privateKey);
        openssl_sign($dataString, $sign, $res);
        openssl_free_key($res);
        $sign = urlencode(base64_encode($sign));
        $dataString.='&sign_type="RSA"&bizcontext="{"appkey":"2016040801279307"}"&sign="'.$sign.'"';
        //生成可以直接打开的链接，让iOS客户端打开：[[UIApplication sharedApplication] openURL:[NSURL URLWithString:$iOSLink]];
        $iOSLink= "alipay://alipayclient/?".urlencode(json_encode(array('requestType' => 'SafePay', "fromAppUrlScheme" => /*iOS App的url schema，支付宝回调用*/"LoveLife","dataString"=>$dataString)));
        return showData(array('data'=>$iOSLink));
    }
    /**
     * 回调通知
     * TRADE_FINISHED 交易成功 true(触发通知)
     * TRADE_SUCCESS 支付成功 true(触发通知)
     * WAIT_BUYER_PAY 交易创建 true(触发通知)
     * TRADE_CLOSED 交易关闭 false(不触发通知)
     */
    function notifyurl(){
        header('Content-Type:text/html; charset=utf-8');
        require_once COMMON_PATH.'Pay/AppAli/alipay_rsa.function.php';
        $alipay_config = C('mobilepay_config');
        //$alipayNotify  = new \Common\Pay\AppAli\AlipayNotify($alipay_config);
        //$verify_result = $alipayNotify->verifyNotify();
        $result = rsaCheckV1($_POST,trim($alipay_config['ali_public_key_path']),$_POST['sign_type']);
        if($result) {//验证成功
            $out_trade_no  = $_POST['out_trade_no'];   //商户订单号
            $trade_no      = $_POST['trade_no'];       //支付宝交易号
            $trade_status  = $_POST['trade_status'];   //交易状态
            if($_POST['trade_status'] == 'TRADE_FINISHED') {
    
            } else if ($_POST['trade_status'] == 'TRADE_SUCCESS') {
                $db   = M('user_recharge');
                $info = $db->where(array('id'=>$out_trade_no))->find();
                $db->where(array('id'=>$out_trade_no))->setField('status', 1);
                //更新用户帐
                $userModel = new UserModel();
                if($info['chongzhi_type'] == 1){
                	$userModel->updateUserMember_newmember($info['uid'], $info['memberid']);
                }else if($info['chongzhi_type'] == 2){
                	$userModel->updateUserMember_xuefeimember($info['uid'], $info['memberid']);
                }
            }
            echo "success";		//请不要修改或删除
        }else {
            echo "fail";//验证失败
        }
    }
    /**
     * 2. 微信支付(sdk)
     * @param string $order_no 订单号
     * @return array
     */
    function wxpay($order_no, $payprice, $subject='', $body='', $notity_url=''){
        require_once COMMON_PATH.'/Pay/AppWx/WxPayPubHelper.php';
        //使用统一支付接口
        $unifiedOrder = new \UnifiedOrder_pub();
        $Common_util_pub = new \Common_util_pub();
        //设置统一支付接口参数
        //设置必填参数
        $amount         = $payprice*100;   //金额
        $out_trade_no   = $order_no;    //订单号
        $subject        = $subject ? $subject : '华浩联创';//String(128) 商品的标题/交易标题/订单标题/订单关键字等。
        $body           = $body ? $body :'购物';//String(512) 对一笔交易的具体描述信息。如果是多种商品,请将商品描述字符串累加传给 body。
        $notify_url     = $notity_url ? $notity_url : \WxPayConf_pub::NOTIFY_URL;//回调通知地址
        //appid已填,商户无需重复填写
        //mch_id已填,商户无需重复填写
        //noncestr已填,商户无需重复填写
        //spbill_create_ip已填,商户无需重复填写
        //sign已填,商户无需重复填写
        $unifiedOrder->setParameter("body","$body");//商品描述
        //自定义订单号，此处仅作举例
        $timeStamp = time();
        $unifiedOrder->setParameter("out_trade_no","$out_trade_no");//商户订单号
        $unifiedOrder->setParameter("total_fee","$amount");//总金额
        $unifiedOrder->setParameter("notify_url","$notify_url");//通知地址
        $unifiedOrder->setParameter("trade_type","APP");//交易类型
        //非必填参数，商户可根据实际情况选填
        //$unifiedOrder->setParameter("sub_mch_id","XXXX");//子商户号
        //$unifiedOrder->setParameter("device_info","XXXX");//设备号
        //$unifiedOrder->setParameter("attach","XXXX");//附加数据
        //$unifiedOrder->setParameter("time_start","XXXX");//交易起始时间
        //$unifiedOrder->setParameter("time_expire","XXXX");//交易结束时间
        //$unifiedOrder->setParameter("goods_tag","XXXX");//商品标记
        //$unifiedOrder->setParameter("openid","XXXX");//用户标识
        //$unifiedOrder->setParameter("product_id","1101");//商品ID
    
        //获取统一支付接口结果
        $unifiedOrderResult = $unifiedOrder->getResult();

        //echo json_encode($unifiedOrderResult);
        //商户根据实际情况设置相应的处理流程
        if ($unifiedOrderResult["return_code"] == "FAIL")
        {
            //商户自行增加处理流程
            //echo "通信出错：".$unifiedOrderResult['return_msg']."<br>";
            $data = array();
            $data['success'] = 0;
            $data['out_trade_no'] = $out_trade_no;
            $data['err_code_des']   = $unifiedOrderResult['return_msg'];
            return showData($data);
        }
        elseif($unifiedOrderResult["result_code"] == "FAIL")
        {
            //商户自行增加处理流程
            //echo "错误代码：".$unifiedOrderResult['err_code']."<br>";
            //echo "错误代码描述：".$unifiedOrderResult['err_code_des']."<br>";
            $data = array();
            $data['success']        = 0;
            $data['out_trade_no']   = $out_trade_no;
            $data['err_code']       = $unifiedOrderResult['err_code'];
            $data['err_code_des']   = $unifiedOrderResult['err_code_des'];
            return showData($data);
        }
        elseif($unifiedOrderResult["result_code"] == "SUCCESS")
        {
            //从统一支付接口获取到code_url
            //$code_url = $unifiedOrderResult["code_url"];
            //商户自行增加处理流程
            //......
            //$this->assign('code_url',$code_url);
            //echo json_encode($unifiedOrderResult);
            $data = array();
            $data['appid'] = $unifiedOrderResult["appid"];
            $data['noncestr'] = $unifiedOrderResult["nonce_str"];
            $data['package'] = "Sign=WXPay";
            $data['partnerid'] = \WxPayConf_pub::MCHID;
            $data['prepayid'] = $unifiedOrderResult["prepay_id"];
            $data['timestamp'] = $timeStamp;
            $data['sign'] = $Common_util_pub ->getSign($data);
    
            $data['total_fee'] = $payprice;
            $data['out_trade_no'] = $out_trade_no;
            $data['success'] = 1;
            return showData($data);
        }
    }
    /**
     * 2.1 微信支付(调APP)
     * @return multitype:
     */
    function weixin($order_no, $payprice, $subject='', $body='', $notity_url=''){
        require_once COMMON_PATH.'/Pay/AppWx/WxPayPubHelper.php';
        //STEP 0. 签名
        //更改商户把相关参数后可测试
        $APP_ID     = \WxPayConf_pub::APPID;
        
        //商户号，填写商户对应参数
        $MCH_ID     = \WxPayConf_pub::MCHID;
        //商户API密钥，填写相应参数
        $PARTNER_ID = \WxPayConf_pub::KEY;
        //支付结果回调页面
        $NOTIFY_URL = $notity_url ? $notity_url : \WxPayConf_pub::NOTIFY_URL;//回调通知地址
        
        $amount         = $payprice*100;   //金额
        $out_trade_no   = $order_no;    //订单号
        $subject        = $subject;//String(128) 商品的标题/交易标题/订单标题/订单关键字等。
        $body           = "一米会员充值";//String(512) 对一笔交易的具体描述信息。如果是多种商品,请将商品描述字符串累加传给 body。
    
        //STEP 1. 构造一个订单。
        $order=array(
            "body"          => $body,
            "appid"         => $APP_ID,
            "device_info"   => "APP-001",
            "mch_id"        => $MCH_ID,
            "nonce_str"     =>"yimisns_noce_str",
            "notify_url"    => $NOTIFY_URL,
            "out_trade_no"  => $out_trade_no,
            "spbill_create_ip" => "196.168.1.1",
            "total_fee"     => $amount,//坑！！！这里的最小单位时分，跟支付宝不一样。1就是1分钱。只能是整形。
            "trade_type"    => "APP"
        );
        //return showData(json_encode($order));
        
        ksort($order);
        //STEP 2. 签名
        $sign="";
        foreach ($order as $key => $value) {
            if($value&&$key!="sign"&&$key!="key"){
                $sign.=$key."=".$value."&";
            }
        }
        $sign.="key=".$PARTNER_ID;
        $sign=strtoupper(md5($sign));
        //return showData($sign);
        //STEP 3. 请求服务器
        $xml="<xml>\n";
        foreach ($order as $key => $value) {
            $xml.="<".$key.">".$value."</".$key.">\n";
        }
        $xml.="<sign>".$sign."</sign>\n";
        $xml.="</xml>";
        
        //return showData($xml);
        $opts = array(
            'http' =>
            array(
                'method'  => 'POST',
                'header'  => 'Content-type: text/xml',
                'content' => $xml
            ),
            "ssl"=>array(
                "verify_peer"=>false,
                "verify_peer_name"=>false,
            )
        );
        $context  = stream_context_create($opts);
        $result = file_get_contents('https://api.mch.weixin.qq.com/pay/unifiedorder', false, $context);
        $result = simplexml_load_string($result,null, LIBXML_NOCDATA);
        
        //return showData($result);
    
        //使用$result->nonce_str和$result->prepay_id。再次签名返回app可以直接打开的链接。
        $input=array(
            "noncestr"  => "".$result->nonce_str,
            "prepayid"  => "".$result->prepay_id,//上一步请求微信服务器得到nonce_str和prepay_id参数。
            "appid"     => $APP_ID,
            "package"   => "Sign=WXPay",
            "partnerid" => $MCH_ID,
            "timestamp" => time(),
        );
        ksort($input);
        $sign="";
        foreach ($input as $key => $value) {
            if($value&&$key!="sign"&&$key!="key"){
                $sign.=$key."=".$value."&";
            }
        }
        $sign.="key=".$PARTNER_ID;
        $sign=strtoupper(md5($sign));
        $iOSLink=sprintf("weixin://app/%s/pay/?nonceStr=%s&package=Sign%%3DWXPay&partnerId=%s&prepayId=%s&timeStamp=%s&sign=%s&signType=SHA1",$APP_ID,$input["noncestr"],$MCH_ID,$input["prepayid"],$input["timestamp"],$sign);
    
        $map['nonceStr'] = $input["noncestr"];
        $map['prepayid'] = $input["prepayid"];
        $map['appid'] = $APP_ID;
        $map['partnerid'] = $MCH_ID;
        $map['package'] = "Sign=WXPay";
        $map['sign'] = $sign;
        $map['timestamp'] = time();
        
        
        return showData($map);
    }
    /**
     * 微信支付回调通知
     * @param int $type 0-订单 1-充值
     */
    function wxnotifyurl(){
        require_once COMMON_PATH.'/Pay/AppWx/WxPayPubHelper.php';
        //使用通用通知接口
        $notify = new \Notify_pub();
        //存储微信的回调
        $xml = $GLOBALS['HTTP_RAW_POST_DATA'];
        $notify->saveData($xml);
        //验证签名，并回应微信。
        //对后台通知交互时，如果微信收到商户的应答不是成功或超时，微信认为通知失败，
        //微信会通过一定的策略（如30分钟共8次）定期重新发起通知，
        //尽可能提高通知的成功率，但微信不保证通知最终能成功。
        if($notify->checkSign() == FALSE){
            $notify->setReturnParameter("return_code","FAIL");//返回状态码
            $notify->setReturnParameter("return_msg","签名失败");//返回信息
        }else{
            $notify->setReturnParameter("return_code","SUCCESS");//设置返回码
        }
        $returnXml = $notify->returnXml();
        echo $returnXml;
    
        //==商户根据实际情况设置相应的处理流程，此处 仅作举例=======
        //以log文件形式记录回调信息
        //logResult("【接收到的notify通知】:\n".$xml."\n");
    
        if($notify->checkSign() == TRUE)
        {
            if ($notify->data["return_code"] == "FAIL") {
                //此处应该更新一下订单状态，商户自行增删操作
                //logResult("【通信出错】:\n".$xml."\n");
            }
            elseif($notify->data["result_code"] == "FAIL"){
                //此处应该更新一下订单状态，商户自行增删操作
                //logResult("【业务出错】:\n".$xml."\n");
            }
            else{
                //此处应该更新一下订单状态，商户自行增删操作
                $out_trade_no = $notify->data["out_trade_no"];
//                 if ($type){
                    $db = M('user_recharge');
                    $info = $db->where(array('id'=>$out_trade_no))->find();
                    $db->where(array('id'=>$out_trade_no))->setField('status', 1);
                    //更新用户帐
                
	                $userModel = new UserModel();
	                if($info['chongzhi_type'] == 1){
	                	$userModel->updateUserMember_newmember($info['uid'], $info['memberid']);
	                }else if($info['chongzhi_type'] == 2){
	                	$userModel->updateUserMember_xuefeimember($info['uid'], $info['memberid']);
	                }
//                 }else {
                   // do nothing
//                 }
            }
        }
    }
    /**
     * 3.银联支付
     * @param unknown $order_no
     */
    function uniopay($order_no){
        header ( 'Content-type:text/html;charset=utf-8' );
        require_once COMMON_PATH . 'Pay/AppUpay/common.php';
        require_once COMMON_PATH . 'Pay/AppUpay/httpClient.php';
        require_once COMMON_PATH . 'Pay/AppUpay/secureUtil.php';
        
        $order_price = M('order')->where(array('order_sn'=>$order_no))->getField('totalPrice');//订单金额
        $txnAmt = $order_price*100;
        // 初始化日志
        $params = array(
        		'version'     => '5.0.0',				//版本号
        		'encoding'    => 'utf-8',				//编码方式
        		'certId'      => getSignCertId (),		//证书ID
        		'txnType'     => '01',				    //交易类型	
        		'txnSubType'  => '01',				    //交易子类
        		'bizType'     => '000201',				//业务类型
        		'frontUrl'    => C('upay.SDK_FRONT_NOTIFY_URL'), //前台通知地址，控件接入的时候不会起作用
        		'backUrl'     => C('upay.SDK_BACK_NOTIFY_URL'),   //后台通知地址	
        		'signMethod'  => '01',		             //签名方法
        		'channelType' => '08',		//渠道类型，07-PC，08-手机
        		'accessType'  => '0',		//接入类型
        		'merId'       => '898510154111001',	//商户代码，请改自己的测试商户号
        		'orderId'     => $order_no,	//商户订单号，8-40位数字字母
        		'txnTime'     => date('YmdHis'),	//订单发送时间
        		'txnAmt'      => $txnAmt, //交易金额，单位分
        		'currencyCode'=> '156',	//交易币种
        		'orderDesc'   => '红旗快购',  //订单描述，可不上送，上送时控件中会显示该信息
        		'reqReserved' => '透传信息', //请求方保留域，透传字段，查询、通知、对账文件中均会原样出现
        );
        // 签名
        $signature = sign ( $params );
        if (!$signature) return showData(new \stdClass(), '签名失败', 1);
        $params['signature'] = $signature;
        // 发送信息到后台
        $result = sendHttpRequest ( $params, C('upay.SDK_App_Request_Url') );
        if ($result){
            //返回结果展示
            $result_arr = coverStringToArray ( $result );
            //echo verify ( $result_arr ) ? '验签成功' : '验签失败';
            if (verify ( $result_arr )){
                return showData(array('tn'=>$result_arr['tn'],'result'=>$result_arr), '验签成功');
            }else {
                return showData(new \stdClass(), '验签失败', 1);
            }
        }else {
            return showData(new \stdClass(), '验签失败', 1);
        }
    }
    /**
     * 银联支付回调通知
     */
    function upaynotify(){
        require_once COMMON_PATH . 'Pay/AppUpay/secureUtil.php';
        $data = $_REQUEST;
        if (isset ( $data ['signature'] )) {            
            if (verify ( $data )){
                $out_trade_no = $data ['orderId']; //其他字段也可用类似方式获取
                M('order')->where(array('order_sn'=>$out_trade_no))->setField(array('type'=>1, 'pay'=>3));
            }else {
                echo '验签失败';
            }
            echo 'success';
        } else {
            echo '签名为空';
        }
    }
}