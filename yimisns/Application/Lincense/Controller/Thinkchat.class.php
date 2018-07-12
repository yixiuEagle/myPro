<?php
/**
 * openfire 交互类
 * @author yangdong
 * 创建时间: 2014-6-14
 * 通过userService插件的http方式与openfire通讯
 */
namespace Lincense\Controller;

use Think\Log;

class Thinkchat {
	private $OP_URL;	//openfire 访问地址
	private $secret = "7ih1mIbF";
	private $OP_AS  = 'beautyas';  //小助手id
	private $lincense_info;
	private $sn = "uiow92384!dd@#5^&*(-==9@@(==)";
	private $lincense;
	
	private $currCheckNums = 0;
	private $checkNums = 100;
	
	function __construct(){
	}
	
	function init($url='127.0.0.1:9090') {
		$this->OP_URL = $url;
		//$this->lincense = Lincense::getInstance();
		
	}
	//======================= 用户相关 ======================
	/**
	 * 用户注册
	 * @param string|int $username
	 * @param string $password
	 * @return boolean|string 1-注册成功 0-注册失败 -1-用户已注册
	 */
	public function regist($username, $password, $device=''){
		$url    = $this->OP_URL . '/plugins/thinkchat/thinkchat';
		
		$check_time = time();
		$check_sum = self::getCheckMd5('001', $check_time);
		
		$param  = self::getEncryUrl(Array('action'=>"001", 'username'=>$username, 'password'=>$password, 'check_time' => $check_time, 'check_sum' => $check_sum));
		$result = self::curl_post($url, $param);	
		log::write($url . '?'. $param, Log::DEBUG);	
		log::write($result);
		$ret = self::parseOPResult($result);
		log::write("ret=" . json_encode($ret));
		return self::parseOPResult($result);
	}
	/**
	 * 用户修改密码
	 * @param string|int $username
	 * @param string $password
	 * @return boolean|string 1-修改成功 0-修改失败 -1-用户不存在
	 */
	public function editPasswd($username, $password, $device=''){
		/* $result = $this->lincense->checkAuth();
		if($result && $result['code'] != 0)
				return showData(null, $result['msg'], 1);
		 */
		$url 	= $this->OP_URL . '/plugins/thinkchat/thinkchat';
		
		$check_time = time();
		$check_sum = self::getCheckMd5('005', $check_time);
		
		$param = self::getEncryUrl(Array('action'=>"005", 'secret'=>$this->secret, 'username'=>$username, 'password'=>$password, 'check_time' => $check_time, 'check_sum' => $check_sum));
		$result = self::curl_post($url, $param);
		
		return self::parseOPResult($result);
	}
	/**
	 * 用户删除
	 * @param string|int $username
	 * @return boolean|string 1-删除成功 0-删除失败 -1-用户不存在
	 */
	public function delete($username, $device=''){
		$result = $this->lincense->checkAuth(true,true, true, true);
		if($result && $result['code'] != 0)
				return showData(null, $result['msg'], 1);
		$url 	= $this->OP_URL . '/plugins/thinkchat/thinkchat';
		$check_time = time();
		$check_sum = self::getCheckMd5('002', $check_time);
		$param = self::getEncryUrl(Array('action'=>'002', 'secret'=>$this->secret, 'username'=>$username, 'check_time' => $check_time, 'check_sum' => $check_sum));
		$result = self::curl_post($url, $param);
		
		return self::parseOPResult($result);
	}
	/**
	 * 用户在线状态
	 * @param unknown $uids--多个用户id，用“，”分开
	 * 返回值：用户id,在线状态;用户id,在线状态...
	 */
	public function onlinestatus($uids) {
		$url 	= $this->OP_URL . '/plugins/thinkchat/thinkchat';
		$check_time = time();
		$check_sum = self::getCheckMd5('008', $check_time);
		$param = self::getEncryUrl(Array('action'=>'008',  'uid'=>$uids, 'check_time' => $check_time, 'check_sum' => $check_sum));
		$result = self::curl_post($url, $param);
		
		return self::parseOPResult($result);
	}
	/**
	 * 用户在线数
	 * @return 
	 */
	public function useronlinenums() {
		$url 	= $this->OP_URL . '/plugins/thinkchat/thinkchat';
		$check_time = time();
		$check_sum = self::getCheckMd5('009', $check_time);
		$param = self::getEncryUrl(Array('action'=>'009', 'check_time' => $check_time, 'check_sum' => $check_sum));
		$result = self::curl_post($url, $param);
	
		return self::parseOPResult($result);
	}
	/**
	 * 是否thinkchat
	 * 
	 */
	public function isthinkchat() {
		$url 	= $this->OP_URL . '/plugins/thinkchat/thinkchat';
		$check_time = time();
		$check_sum = self::getCheckMd5('006', $check_time);
		$param = self::getEncryUrl(Array('action'=>'006', 'check_time' => $check_time, 'check_sum' => $check_sum));
		$result = self::curl_post($url, $param);
	
		return self::parseOPResult($result);
	}
	
	//======================= 消息相关 ======================
	/**
	 * 发送消息
	 * @param unknown $from	发送者
	 * @param unknown $to	接收者
	 * @param array $body	消息体
	 * @param string $action 类型 个人:person 所有人:allusers 所有在线用户:allonlineusers 指定用户:batchusers
	 */
	public function message($from, $to, $body, $action='batchusers', $device=''){
		Log::write("Thinkchat message into");
		
		// 发送消息
		$url 	= $this->OP_URL . '/plugins/thinkchat/thinkchat';
		$check_time = time();
		$check_sum = self::getCheckMd5('007', $check_time);
		$param  = self::getEncryUrl(Array('action'=>'007', 'from'=>$from, 'to'=>$to, 'body'=>urlencode(json_encode($body)), 'type'=>$action, 'check_time' => $check_time, 'check_sum' => $check_sum));
		//Log::write("Thinkchat message check_time=" . $check_time . ", check_sum=" . $check_sum);
		Log::write("thinkchat url=" . $url . ",params=" . json_encode($param));
		$result = self::curl_post($url, $param);
		Log::write("thinkchat result=" . $result);
		//log::write("$url?$param");
		return self::parseOPResult($result);
	}
	
	/**
	 * 通知
	 * @param unknown $from 发送者
	 * @param unknown $to	接收者
	 * @param number $type	消息类型
	 * @param number $tid
	 * @param string $content
	 * @param unknown $other
	 */
	public function notice($from, $to, $type=1, $content='',$other='', $device=''){
		$device = $device ? $device : I('device', '');
		//$type=$type ? $type : 1015;
		//通知消息体
		$notice = array(
				'user' 	 => $from,
				'content'=> $content,
				'type' 	 => $type,
				'room'   => $other ? $other :new \stdClass(),
				'time'	 => getMillisecond()
		);
		$result = self::message($this->OP_AS, $to['touid'], $notice, 'batchusers', $device);
		if (APP_DEBUG){//debug模式下写入数据库
			$data = array(
					'type'		=> $type,
					'uid'		=> $from['uid'],
					'toUid'		=> $to['touid'],
					'content'	=> $notice['content'],
					'createtime'=> NOW_TIME,
					'status'	=> $result ? 1 : 0
			);
			M('notice')->add($data);
		}
		return $result;
	}
	
	//======================= 消息相关结束 ======================
	/**
	 * 对参数进行加密，返回加密后的url
	 * @param unknown $map
	 */
	private function getEncryUrl($map) {
		$result = "";
		foreach ($map as $key=>$value) {
			$result .= $key . "@" . $value . ";";
		}
		//Log::write("getEncryUrl=" . $result);
		$md5_value = md5($result);
// 		$data   = base64_encode(XorUtil::compose($result, $this->sn));
		$data   = XorUtil::compose($result, $this->sn);
		$data   = urlencode($data);
		$result = "data=" .$data. "&md5=".$md5_value;
		return $result;
	}

	/**
	 * 解析op返回的数据
	 * @param unknown $content
	 * @return Ambigous <multitype:, multitype:unknown \Org\Util\string number >
	 */
	private function parseOPResult($content) {
		if(!$content)
			return showData(null, '获取数据失败', 1);
		
		//log::write('parseOPResult content=' . $content, Log::DEBUG);
		
		// 移除2边的result标签
		$content = trim($content);
		$len 	 = strlen($content);
		$sublen  = strlen('</result>');
		$content = substr($content, 0, $len - $sublen);
		$sublen  = strlen('<result>');
		$content = substr($content, $sublen);
		$content = trim($content);

		$tmp = explode(",", $content);
		if(!$tmp || count($tmp) != 2)
			return showData(null, '返回数据格式有误,错误码001', 1);
	
		$dataKeyValue = explode("=", $tmp[0], 2);
		if(!$dataKeyValue || count($dataKeyValue) != 2)
			return showData(null, '返回数据格式有误,错误码002', 1);
	
		// 解密data，包括data, msg, code等信息
// 		$info = XorUtil::parse(base64_decode(urldecode($dataKeyValue[1])), $this->sn);
// 		$info = XorUtil::parse(base64_decode($dataKeyValue[1]), $this->sn);
		$info = urldecode($dataKeyValue[1]);
		$info = XorUtil::parse($info, $this->sn);
		// 验证md5
		$md5keyvalue = explode("=", $tmp[1], 2);
		if(!$md5keyvalue || count($md5keyvalue) != 2)
			return showData(null, '返回数据格式有误,错误码003', 1);
		$md5_value = $md5keyvalue[1];
	
		return self::parseResult($info);
	}
	
	/**
	 * 解析数据，输入参数格式为：data,123;msg,showme;code:0
	 * @param unknown $content
	 */
	private function parseResult($content) {
		$arr = explode(";", $content);
		if(!$arr || count($arr) != 4)
			return showData(null, '返回数据格式有误,错误码004', 1);
	
		$tmpArr = explode(",", $arr[0]);
		if(!$tmpArr || $tmpArr[0] != "data")
			return showData(null, '返回数据格式有误,错误码005', 1);
		$val = $tmpArr[1];
		$data = $val ? $val : null;
	
		$tmpArr = explode(",", $arr[1]);
		if(!$tmpArr || $tmpArr[0] != "msg")
			return showData(null, '返回数据格式有误,错误码006', 1);
		$val = $tmpArr[1];
		$msg = $val ? urldecode($val) : null;
	
		$tmpArr = explode(",", $arr[2]);
		if(!$tmpArr || $tmpArr[0] != "code")
			return showData(null, '返回数据格式有误,错误码007', 1);
		$val = $tmpArr[1];
		$code = $val;
	
		
		return showData($data, $msg, $code);
	}
	
	/**
	 * curl post 方法
	 * @param unknown $url
	 * @param unknown $string
	 * @return mixed
	 */
	private function curl_post($url, $string){
		//Log::write("curl_post url=" . $url . ", string=" . $string);
		
		$ch = curl_init();
		curl_setopt($ch, CURLOPT_URL, $url);
		curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
		curl_setopt($ch, CURLOPT_POST, 1);
	
		curl_setopt($ch, CURLOPT_POSTFIELDS, $string);
		$output = curl_exec($ch);
		curl_close($ch);
		
		return $output;
	}
	
	/**
	 * 解密url
	 * @param unknown $content
	 * @return unknown
	 */
	private function encryUrl($content) {
		return $content;
	}
	
	/**
	 * 解密url
	 * @param unknown $content
	 * @return unknown
	 */
	private function decryUrl($content) {
		return $content;
	}
	
	/**
	 * 获取加密的字符串
	 * @param unknown $action
	 * @param unknown $time
	 */
	private function getCheckMd5($action, $time) {
		$op_secret = C('OP_SECRET');
		if(!$op_secret) 
			$op_secret = 'thinkchat_!@#456';
		
		$result = md5($action . $op_secret . $time);
		
		return $result;
	}
}