<?php
/* *
 * 支付宝接口RSA函数
 * 详细：RSA签名、验签、解密
 * 版本：3.3
 * 日期：2012-07-23
 * 说明：
 * 以下代码只是为了方便商户测试而提供的样例代码，商户可以根据自己网站的需要，按照技术文档编写,并非一定要使用该代码。
 * 该代码仅供学习和研究支付宝接口使用，只是提供一个参考。
 */

/**
 * RSA签名
 * @param $data 待签名数据
 * @param $private_key_path 商户私钥文件路径
 * return 签名结果
 */
function rsaSign($data, $private_key_path) {
    $priKey = file_get_contents($private_key_path);
    $res = openssl_get_privatekey($priKey);
    
    openssl_sign($data, $sign, $res);
    openssl_free_key($res);
	//base64编码
    $sign = base64_encode($sign);
    return $sign;
}
/**
 * 新版签名
 * @param unknown $data
 * @param unknown $privatekey
 * @param string $signType
 * @param string $keyfromfile
 * @return string
 */
function alonersaSign($data,$privatekey,$signType = "RSA",$keyfromfile=false) {

    if(!$keyfromfile){
        $priKey=$privatekey;
        $res = "-----BEGIN RSA PRIVATE KEY-----\n" .
            wordwrap($priKey, 64, "\n", true) .
            "\n-----END RSA PRIVATE KEY-----";
    }
    else{
        $priKey = file_get_contents($privatekey);
        $res = openssl_get_privatekey($priKey);
    }

    ($res) or die('您使用的私钥格式错误，请检查RSA私钥配置');

    if ("RSA2" == $signType) {
        openssl_sign($data, $sign, $res, OPENSSL_ALGO_SHA256);
    } else {
        openssl_sign($data, $sign, $res);
    }

    if($keyfromfile){
        openssl_free_key($res);
    }
    $sign = base64_encode($sign);
    return $sign;
}
/**
 * 校验$value是否非空
 * @param unknown $value
 * @return boolean
 */
function checkEmpty($value) {
    if (!isset($value))
        return true;
        if ($value === null)
            return true;
            if (trim($value) === "")
                return true;

                return false;
}
/**
 * 转换字符集编码
 * @param $data
 * @param $targetCharset
 * @return string
 */
function characet($data, $targetCharset) {

    if (!empty($data)) {
        $fileType = "UTF-8";
        if (strcasecmp($fileType, $targetCharset) != 0) {
            $data = mb_convert_encoding($data, $targetCharset, $fileType);
            //				$data = iconv($fileType, $targetCharset.'//IGNORE', $data);
        }
    }


    return $data;
}
/**
 * 新版拼接
 * @param unknown $params
 * @return string
 */
function getSignContent($params) {
    ksort($params);

    $stringToBeSigned = "";
    $i = 0;
    foreach ($params as $k => $v) {
        if (false === checkEmpty($v) && "@" != substr($v, 0, 1)) {

            // 转换成目标字符集
            $v =characet($v, "UTF-8");

            if ($i == 0) {
                $stringToBeSigned .= "$k" . "=" . "$v";
            } else {
                $stringToBeSigned .= "&" . "$k" . "=" . "$v";
            }
            $i++;
        }
    }

    unset ($k, $v);
    return $stringToBeSigned;
}
/**
 * 新版urlencode
 * @param unknown $params
 * @return string
 */
function getSignContentUrlencode($params) {
    ksort($params);

    $stringToBeSigned = "";
    $i = 0;
    foreach ($params as $k => $v) {
        if (false === checkEmpty($v) && "@" != substr($v, 0, 1)) {

            // 转换成目标字符集
            $v = characet($v, "UTF-8");

            if ($i == 0) {
                $stringToBeSigned .= "$k" . "=" . urlencode($v);
            } else {
                $stringToBeSigned .= "&" . "$k" . "=" . urlencode($v);
            }
            $i++;
        }
    }

    unset ($k, $v);
    return $stringToBeSigned;
}
/** rsaCheckV1 & rsaCheckV2
 *  验证签名
 *  在使用本方法前，必须初始化AopClient且传入公钥参数。
 *  公钥是否是读取字符串还是读取文件，是根据初始化传入的值判断的。
 **/
function rsaCheckV1($params, $rsaPublicKeyFilePath,$signType='RSA') {
    $sign = $params['sign'];
    $params['sign_type'] = null;
    $params['sign'] = null;
    return verify(getSignContent($params), $sign, $rsaPublicKeyFilePath,$signType);
}
function rsaCheckV2($params, $rsaPublicKeyFilePath, $signType='RSA') {
    $sign = $params['sign'];
    $params['sign'] = null;
    return $this->verify($this->getSignContent($params), $sign, $rsaPublicKeyFilePath, $signType);
}

function verify($data, $sign, $rsaPublicKeyFilePath, $signType = 'RSA') {
    $alipayPublicKey='';
    /*if(checkEmpty($this->alipayPublicKey)){

        $pubKey= $this->alipayrsaPublicKey;
        $res = "-----BEGIN PUBLIC KEY-----\n" .
            wordwrap($pubKey, 64, "\n", true) .
            "\n-----END PUBLIC KEY-----";
    }else {*/
        //读取公钥文件
        $pubKey = file_get_contents($rsaPublicKeyFilePath);
        //转换为openssl格式密钥
        $res = openssl_get_publickey($pubKey);
    //}

    ($res) or die('支付宝RSA公钥错误。请检查公钥文件格式是否正确');

    //调用openssl内置方法验签，返回bool值

    if ("RSA2" == $signType) {
        $result = (bool)openssl_verify($data, base64_decode($sign), $res, OPENSSL_ALGO_SHA256);
    } else {
        $result = (bool)openssl_verify($data, base64_decode($sign), $res);
    }

    if(!checkEmpty($alipayPublicKey)) {
        //释放资源
        openssl_free_key($res);
    }

    return $result;
}

/**
 * RSA验签
 * @param $data 待签名数据
 * @param $ali_public_key_path 支付宝的公钥文件路径
 * @param $sign 要校对的的签名结果
 * return 验证结果
 */
function rsaVerify($data, $ali_public_key_path, $sign)  {
	$pubKey = file_get_contents($ali_public_key_path);
    $res = openssl_get_publickey($pubKey);
    $result = (bool)openssl_verify($data, base64_decode($sign), $res);
    openssl_free_key($res);    
    return $result;
}

/**
 * RSA解密
 * @param $content 需要解密的内容，密文
 * @param $private_key_path 商户私钥文件路径
 * return 解密后内容，明文
 */
function rsaDecrypt($content, $private_key_path) {
    $priKey = file_get_contents($private_key_path);
    $res = openssl_get_privatekey($priKey);
	//用base64将内容还原成二进制
    $content = base64_decode($content);
	//把需要解密的内容，按128位拆开解密
    $result  = '';
    for($i = 0; $i < strlen($content)/128; $i++  ) {
        $data = substr($content, $i * 128, 128);
        openssl_private_decrypt($data, $decrypt, $res);
        $result .= $decrypt;
    }
    openssl_free_key($res);
    return $result;
}
?>