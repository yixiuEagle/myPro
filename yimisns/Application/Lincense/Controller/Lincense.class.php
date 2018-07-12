<?php

namespace Lincense\Controller;

use Lincense\Model\LincenseModel;
use User\Model\UserModel;
use Admin\Controller\CommonController;

class Lincense extends CommonController{
	private $xizue;
	private $lincense_db;
	private $lincense_info;		// lincense信息
	private $auth_info;			// 显示到后台的授权内容
	private static $instance;
	private $user_db;
	private $user_count;
	
	
	private $lincense_url = "http://lincense.thinkchat.com.cn/";
	
	
	function _initialize(){
		$this->user_db = new UserModel();
		$this->user_count = $this->user_db->count();
		
		$this->lincense_db = new LincenseModel();
		self::parse();
	}
	public static function getInstance(){
		if(!(self::$instance instanceof self)){
			self::$instance = new self;
		}
		
		// return
		return self::$instance;
	}
	
	
	//防止对象被复制
	public function __clone(){
		trigger_error('Clone is not allowed !');
	}
	//=========================== 授权内容 =========================
	// 获取授权信息，在后台展示
	public function auth_info() {
		return $this->auth_info;
	}
	
	/**
	 * 更新了授权信息，需要重新获取
	 */
	public function update_auth() {
		self::parse();
	}
	
	public function create_lincense($map=array()) {
		$customerid = $map['customerid'];
		$orderid = $map['orderid'];
		$paymethod = $map['paymethod'];
		$ip = $map['ip'];
		$domain = $map['domain'];
		$buytime = $map['buytime'];
		$expiretime = $map['expiretime'];
		$chat_maxuser = $map['chat_maxuser'];
		$chat_maxonlineuser = $map['chat_maxonlineuser'];
		$group_maxnum = $map['group_maxnum'];
		$group_singlemaxnum = $map['group_singlemaxnum'];
		$clients = $map['clients'];
		$oldorderid = $map['oldorderid'];
		
		if(!$customerid)
			return showData(null, "客户ID不能为空", 1);
		
		if(!$customerid)
		return showData(null, "订单ID不能为空", 1);
		
		if(!$ip && !$domain)
		return showData(null, "ip或域名不能全为空", 1);
		
		if(!$buytime)
		return showData(null, "购买时间不能为空", 1);
		
		if(!$expiretime)
		return showData(null, "过期时间不能为空", 1);
		
		if(!$chat_maxuser)
		return showData(null, "聊天最大数不能为空", 1);
		
		if(!$chat_maxonlineuser)
		return showData(null, "聊天同时在线最大数不能为空", 1);
		
		if(!$group_maxnum)
		return showData(null, "群数量不能为空", 1);
		
		if(!$group_singlemaxnum)
		return showData(null, "群成员最大数不能为空", 1);
		
		if(!$clients)
		return showData(null, "请选中客户端", 1);
		
		// 生成lincense
		$xizue = array();
		
		$info = array();
		$info['orderid'] = $orderid;
		$info['acount'] = $customerid;
		$info['ip'] = $ip;
		$info['domain'] = $domain;
		$info['ordertime'] = self::generateTime2UnixTime($buytime);
		$info['expiretime'] = self::generateTime2UnixTime($expiretime);
		$info['paymethod'] = $paymethod;
		
		$xizue['info'] = $info;
		
		
		$device = array();
		
		if(in_array('android', $clients)) {
			$device['android'] = "1";
		}else {
			$device['android'] = "0";
		}
		
		if(in_array('ios', $clients)) {
			$device['iphone'] = "1";
		}else {
			$device['iphone'] = "0";
		}
		
		if(in_array('android_pad', $clients)) {
			$device['android_pad'] = "1";
		}else {
			$device['android_pad'] = "0";
		}
		
		if(in_array('ipad', $clients)) {
			$device['ipad'] = "1";
		}else {
			$device['ipad'] = "0";
		}
		
		if(in_array('web', $clients)) {
			$device['web'] = "1";
		}else {
			$device['web'] = "0";
		}
		
		if(in_array('windows_pc', $clients)) {
			$device['windows_pc'] = "1";
		}else {
			$device['windows_pc'] = "0";
		}
		$xizue['device'] = $device;
		
		
		$feature = array();
		$chat = array();
		$chat['maxusernum'] = $chat_maxuser;
		$chat['maxonlineusernum'] = $chat_maxonlineuser;
		$feature['chat'] = $chat;
		
		$group = array();
		$group['maxgroupnum'] = $group_maxnum;
		$group['maxgrouppersonnum'] = $group_singlemaxnum;
		$feature['group'] = $group;
		
		$user = array();
		$user['loginmultipledevice'] = "0";
		$user['multipleuser'] = "0";
		$feature['user'] = $user;
		
		$xizue['feature'] = $feature;
		$xizue['pay'] = "http://www.xizue.com/pay";
		$xizue['expireorderid'] = $oldorderid;
		$xizue['version'] = "1.0.0";
		
		// 返回
		$lincense_data['xizue'] = $xizue;
		
		$result = self::encodeLincense(json_encode($lincense_data));
		
		return showData($result, "创建Lincense成功", 0);
	}
	
	private function generateTime2UnixTime($content) {
		date_default_timezone_set('Asia/Chongqing');
		$time1 = $content;
		$time2 = strtotime($time1);
		
		return $time2;
	}
	public function del_lincense() {
		// 先从xizue服务器检测
		
		
		// 移除本地的数据
		$result = $this->lincense_db->where(Array('id'=>1))->save(array('lincense'=>''));
		if(!$result)
			return showData(null, "删除Lincense失败", 0);
		
		return showData(null, "删除Lincense成败", 0);
	}
	
	public function set_lincense($lincense='') {
		// 检测服务器是否授权了
		$url = "http://lincense.xizue.com/Lincense/Api/checkNewLincense";
		$xizue = (Array)self::parseLincense_temp($lincense);
		
		$info = $xizue['xizue']['info'];
		
		$customerid = $info->acount;
		$orderid = $info->orderid;
		$oldorderid = $xizue['xizue']->expireorderid;

		$params .= 'customerid=' . $customerid . '&';
		$params .= 'orderid=' . $orderid . '&';
		$params .= 'oldorderid=' . $oldorderid . '&';
		$params .= 'lincense=' . $lincense;
		
		
		$result_post = curl_post($url, $params);
		$newResult = (Array)(json_decode($result_post));
		$state = (Array)$newResult['state'];
		
		if($state['code'] != 0)
			return showData(null, $state['msg'], 1);

		
		// 更新本地
		$result = $this->lincense_db->where(Array('id'=>1))->save(Array('lincense'=>$lincense));
		if($result === false)
			return showData(null, '更新Lincense失败', 0);
		
		return showData(null, '更新Lincense成功', 0);
	}
	//============================权限============================
	
	// 检测授权
	public function checkAuth($c_time=true, $c_device=true, $c_ipdomain=true, $c_username=false) {
		if($c_time) {
			$result = Lincense::getInstance()->checkExpireTime();
			if($result && $result['code'] != 0)
				return showData(null, $result['msg'], 1);
		}

		return showData(null, "授权成功", 0);
	}
	
	public function checkAuthOnline($currOnlineNums) {
		$result = Lincense::getInstance()->checkOnlineUserNum($currOnlineNums);
		if($result && $result['code'] != 0)
			return showData(null, $result['msg'], 1);
		
		return showData(null, "授权成功", 0);
	}
	
	
	// 检测是否过期
	private function checkExpireTime() {
		$info = $this->xizue->info;
		$expireTime = $info->expiretime;
		
		if($expireTime == -1 || $expireTime == "")
			return showData(null, "授权成功");
		
		$currTime = time();
		//Log::write("currTime=$currTime, expireTime=$expireTime");
		
		if($currTime > $expireTime )
			return showData(null, "授权已过期", 1);
		
		return showData(null, "授权成功");
	}
	
	private function real_domain() {
		$domain = trim($_SERVER['SERVER_NAME']);
		$domain = str_replace("http://", "", $domain);
		$domain = str_replace("https://", "", $domain);
		$index = stripos($domain, "/");
		if($index > 0) {
			$domain = substr($domain, 0, $index);
		}
		
		return $domain;
	}
	/**
	 * 获取本地ip
	 * @return NULL|Ambigous <string, unknown>
	 */
	private function real_ip()
	{
		return gethostbyname($_SERVER["SERVER_NAME"]);
	}
	/**
	 * 检测用户数
	 */
	public function checkUserNum() {
		$count = $this->user_count;
		
		$chat = $this->xizue->feature->chat;
		if(!$chat)	return showData(null, '获取lincense失败', 1);

		if($chat->maxusernum != -1) {
			if($count > $chat->maxusernum )
				return showData(null, '用户数已超过'.$chat->maxusernum.'人,请升级授权继续使用', 1);
		} 
		
		return showData(null, '获取lincense失败', 0);;
	}
	
	/**
	 * 检测在线用户数
	 */
	private function checkOnlineUserNum($currOnlineNums) {
		$count = $currOnlineNums;
		
		$chat = $this->xizue->feature->chat;
		if(!$chat)	return showData(null, '获取lincense失败', 1);

		if($chat->maxonlineusernum != -1) {
			if($count > $chat->maxonlineusernum )
				return showData(null, '当前在线用户数已超过'.$chat->maxonlineusernum.'人,请升级授权继续使用', 1);
		} 
		
		return showData(null, '获取lincense失败', 0);;
	}
	
	
	
	
	/**
	 * 1. 解析lincense
	 * @return Ambigous <multitype:, multitype:unknown \Org\Util\string number >
	 */
	private function parse() {
		self::readLincense();
		
		self::parseLincense($this->lincense_info);
		
		return showData(null, "解析成功", 0);
	}
	
	private function encodeLincense($content) {
		$result = XorUtil::compose_lincense($content, 'xizue_thinkchat_server');
		$result = base64_encode($result);
		
		return $result;
	}
	
	/**
	 * 解密默认的lincense
	 * @param unknown $content
	 */
	private function decodeDefaultLincense($content) {
		
		$result = self::decodeLincense($content);
		
		return $result;
	}
	
	/**
	 * 解密lincense
	 * @param unknown $content
	 */
	private function decodeLincense($content) {
		
		$result = base64_decode($content);
		$result = XorUtil::parse_lincense($result, 'xizue_thinkchat_server');
		
		return $result;
	}
	

	
	// 解析lincense输出
	private function parseLincense($jsonContent) {
		$output_info = array();
	
		$test = json_decode($jsonContent);
		if(!$jsonContent)
			return showData(null, 'lincense错误', 1);
	
		try {
			$content = (Array)json_decode($jsonContent);
		} catch (Exception $e) {
			return showData(null, 'lincense错误', 1);
		}
	
		//=================== info ===================
		$xizue = (Array)$content['xizue'];
		if(!$xizue)
			return showData(null, 'lincense错误', 1);
		$this->xizue = new Xizue();
		
		$info = (Array)$xizue['info'];
		if(!$info)
			return showData(null, 'lincense错误', 1);
		$infoClass = new Xizue_Info();
		$this->xizue->info = $infoClass;
		
		$orderid = $info['orderid'];
		$infoClass->orderid = $orderid;
		$output_info['orderid'] = $orderid;
		
		// 账号
		$acount = $info['acount'];
		if(!$acount)
			return showData(null, 'lincense错误', 1);
		$output_info['acount'] = $acount;
		$infoClass->acount = $acount;
	
		// 支付方式
		$paymethod = $info['paymethod'];
		if($paymethod == 0){
			$output_info['paymethod'] = "免费用户";
		}else if($paymethod == 1){
			$output_info['paymethod'] = "永久有效";
		}else if($paymethod == 2){
			$output_info['paymethod'] = "按月付款";
		}else if($paymethod == 3){
			$output_info['paymethod'] = "按年付款";
		}else{
			return showData(null, 'lincense错误', 1);
		}
		$infoClass->paymethod = $paymethod;
	
		// ip domain
		$ip = $info['ip'];
		$domain = $info['domain'];
		$infoClass->ip = $ip;
	
		$output_info['ip'] = ($ip == "-1") ? "无限" : $ip;
		$output_info['domain'] = ($domain == "-1") ? "无限" : $domain;
		$infoClass->domain = $domain;
	
		// 购买时间
		$buytime = $info['ordertime'];
		if(!$buytime)
			$buytime = "";
		$output_info['buytime'] = date('Y-m-d H:i:s', $buytime);
		$infoClass->ordertime = $buytime;
	

		
		// 过期时间
		$expiretime = $info['expiretime'];
		//Log::write("expiretime=".$expiretime);
		if($expiretime == -1 || $expiretime == "" )
			$output_info['expiretime'] = "无限";
		else
			$output_info['expiretime'] = date('Y-m-d H:i:s', $expiretime);
		$infoClass->expiretime = $expiretime;
	
		$output_info['status'] = "正常";
		// 状态
		if($expiretime != "" && $buytime != ""){
			if(time() >= $expiretime) {
				$output_info['status'] = "已过期";
			}else if(time()-24*3600*10 >= $expiretime){
				$output_info['status'] = "即将过期";
			}
		}
		//=================== device ===================
		$device = (Array)$xizue['device'];
		if(!$device)
			return showData(null, 'lincense错误', 1);
		$deviceClass = new Xizue_Device();
		$this->xizue->device = $deviceClass;
		
		// 授权客户端
		
		$output_info['clients'] = "";
		
		$feature = (Array)$xizue['feature'];
		if(!$feature)
			return showData(null, 'lincense错误', 1);
		$featureClass = new Xizue_Feature();
		$this->xizue->feature = $featureClass;
		//=========================单聊===========================
		$chat = (Array)$feature['chat'];
		if(!$chat)
			return showData(null, 'lincense错误', 1);
		$chatClass = new Xizue_Chat();
		$featureClass->chat = $chatClass;
		
		// 最大用户数
		$maxusernum = $chat['maxusernum'];
		if($maxusernum == -1)
			$maxusernum = "不限";
		$output_info['chat_maxuser'] = $maxusernum;
		$chatClass->maxusernum = 0;
	
		// 最大在线用户数
		$maxonlineusernum = $chat['maxonlineusernum'];
		if($maxonlineusernum == -1)
			$maxonlineusernum = "不限";
		$output_info['chat_maxonlineuser'] = $maxonlineusernum;
		$chatClass->maxonlineusernum = $maxonlineusernum;
	
		//=========================群聊===========================
		$group = (Array)$feature['group'];
		if(!$group)
			return showData(null, 'lincense错误', 1);
		$groupClass = new Xizue_Group();
		$featureClass->group = $groupClass;
		
		// 最大群数
		$maxgroupnum = $group['maxgroupnum'];
		if($maxgroupnum == -1)
			$maxgroupnum = "不限";
		$output_info['group_maxnum'] = $maxgroupnum;
		$groupClass->maxgroupnum = 0;
	
		// 最大单个群支持的数量
		$maxgrouppersonnum = $group['maxgrouppersonnum'];
		if($maxgrouppersonnum == -1)
			$maxgrouppersonnum = "不限";
		$output_info['group_singlemaxnum'] = $maxgrouppersonnum;
		$groupClass->maxgrouppersonnum = 0;
	
		//=========================账号==========================
		$user = (Array)$feature['user'];
		if(!$user)
			return showData(null, 'lincense错误', 1);
		$userClass = new Xizue_User();
		$featureClass->user = $userClass;
		
		
		// 登陆多设备
		$loginmultipledevice = $user['loginmultipledevice'];
		if($loginmultipledevice && $$loginmultipledevice == 1){
			$output_info['user_onedevice'] = "是";
			$userClass->loginmultipledevice = 1;
		}
		else
			$output_info['user_onedevice'] = "否";
		// 支持多用户登陆
		$multipleuser = $user['multipleuser'];
		if($multipleuser && $$multipleuser == 1){
			$output_info['user_oneacount'] = "是";
			$userClass->multipleuser = 1;
		}
		else
			$output_info['user_oneacount'] = "否";
	
		// pay url
		$payurl = $xizue['pay'];
		$output_info['payurl'] = $payurl;
		$this->xizue->payurl = $payurl;
		
		$this->auth_info = $output_info;
		return showData(null, "解析成功", 0);
	}
	// 临时解析
	private function parseLincense_temp($jsonContent) {
		$json = self::decodeLincense($jsonContent);
		
		$xizue = new Xizue();
		
		$test = json_decode($json);
		if(!$json)
			return showData(null, 'lincense错误001', 1);
	
		try {
			$content = (Array)json_decode($json);
			
			
		} catch (Exception $e) {
			return showData(null, 'lincense错误002', 1);
		}
	
		//=================== info ===================
		$xizue = (Array)$content['xizue'];
		if(!$xizue)
			return showData(null, 'lincense错误003', 1);
		
	
		$info = (Array)$xizue['info'];
		if(!$info)
			return showData(null, 'lincense错误004', 1);
		$infoClass = new Xizue_Info();
		$xizue->info = $infoClass;
	
		$orderid = $info['orderid'];
		$infoClass->orderid = $orderid;
		$output_info['orderid'] = $orderid;
	
		// 账号
		$acount = $info['acount'];
		if(!$acount)
			return showData(null, 'lincense错误005', 1);
		$output_info['acount'] = $acount;
		$infoClass->acount = $acount;
	
		// 支付方式
		$paymethod = $info['paymethod'];
		if($paymethod == 0){
			$output_info['paymethod'] = "免费用户";
		}else if($paymethod == 1){
			$output_info['paymethod'] = "永久有效";
		}else if($paymethod == 2){
			$output_info['paymethod'] = "按月付款";
		}else if($paymethod == 3){
			$output_info['paymethod'] = "按年付款";
		}else{
			return showData(null, 'lincense错误006', 1);
		}
		$infoClass->paymethod = $paymethod;
	
		// ip domain
		$ip = $info['ip'];
		$domain = $info['domain'];
		$infoClass->ip = $ip;
	
		$output_info['ip'] = ($ip == "-1") ? "无限" : $ip;
		$output_info['domain'] = ($domain == "-1") ? "无限" : $domain;
		$infoClass->domain = $domain;
	
		// 购买时间
		$buytime = $info['ordertime'];
		if(!$buytime)
			$buytime = "";
		$output_info['buytime'] = date('Y-m-d H:i:s', $buytime);
		$infoClass->ordertime = $buytime;
	
	
	
		// 过期时间
		$expiretime = $info['expiretime'];
		if($expiretime == -1 || $expiretime == "")
			$output_info['expiretime'] = "无限";
		else
			$output_info['expiretime'] = date('Y-m-d H:i:s', $expiretime);
		$infoClass->expiretime = $expiretime;
	
		$output_info['status'] = "正常";
		// 状态
		if($expiretime != "" && $buytime != ""){
			if(time() >= $expiretime) {
				$output_info['status'] = "已过期";
			}else if(time()-24*3600*10 >= $expiretime){
				$output_info['status'] = "即将过期";
			}
		}
		//=================== device ===================
		$device = (Array)$xizue['device'];
		if(!$device)
			return showData(null, 'lincense错误007', 1);
		$deviceClass = new Xizue_Device();
		$this->xizue->device = $deviceClass;
	
		// 授权客户端
		$android = $device['android'];
		$android_pad = $device['android_pad'];
		$iphone = $device['iphone'];
		$ipad = $device['ipad'];
		$web = $device['web'];
		$windows_pc = $device['windows_pc'];
	
		$device_info = "";
		if($android && $android == 1){
			if($device_info){
				$device_info .= "," . "Android客户端";
				$deviceClass->android = 1;
			}
			else
				$device_info = "Android客户端";
		}
		if($android_pad && $android_pad == 1){
			if($device_info){
				$device_info .= "," . "Android平板客户端";
				$deviceClass->android_pad = 1;
			}
			else
				$device_info = "Android平板客户端";
		}
		if($iphone && $iphone == 1){
			if($device_info){
				$device_info .= "," . "iPhone客户端";
				$deviceClass->iphone = 1;
			}
			else
				$device_info = "iPhone客户端";
		}
		if($ipad && $ipad == 1){
			if($device_info){
				$device_info .= "," . "iPad客户端";
				$deviceClass->ipad = 1;
			}
			else
				$device_info = "iPad客户端";
		}
		if($web && $web == 1){
			if($device_info){
				$device_info .= "," . "web客户端";
				$deviceClass->web = 1;
			}
			else
				$device_info = "web客户端";
		}
		if($windows_pc && $windows_pc == 1){
			if($device_info){
				$device_info .= "," . "Windows PC客户端";
				$deviceClass->windows_pc = 1;
			}
			else
				$device_info = "Windows PC客户端";
		}
		$output_info['clients'] = $device_info;
	
		$feature = (Array)$xizue['feature'];
		if(!$feature)
			return showData(null, 'lincense错误008', 1);
		$featureClass = new Xizue_Feature();
		$this->xizue->feature = $featureClass;
		//=========================单聊===========================
		$chat = (Array)$feature['chat'];
		if(!$chat)
			return showData(null, 'lincense错误009', 1);
		$chatClass = new Xizue_Chat();
		$featureClass->chat = $chatClass;
	
		// 最大用户数
		$maxusernum = $chat['maxusernum'];
		if($maxusernum == -1)
			$maxusernum = "不限";
		$output_info['chat_maxuser'] = $maxusernum;
		$chatClass->maxusernum = $maxusernum;
	
		// 最大在线用户数
		$maxonlineusernum = $chat['maxonlineusernum'];
		if($maxonlineusernum == -1)
			$maxonlineusernum = "不限";
		$output_info['chat_maxonlineuser'] = $maxonlineusernum;
		$chatClass->maxonlineusernum = $maxonlineusernum;
	
		//=========================群聊===========================
		$group = (Array)$feature['group'];
		if(!$group)
			return showData(null, 'lincense错误010', 1);
		$groupClass = new Xizue_Group();
		$featureClass->group = $groupClass;
	
		// 最大群数
		$maxgroupnum = $group['maxgroupnum'];
		if($maxgroupnum == -1)
			$maxgroupnum = "不限";
		$output_info['group_maxnum'] = $maxgroupnum;
		$groupClass->maxgroupnum = $maxgroupnum;
	
		// 最大单个群支持的数量
		$maxgrouppersonnum = $group['maxgrouppersonnum'];
		if($maxgrouppersonnum == -1)
			$maxgrouppersonnum = "不限";
		$output_info['group_singlemaxnum'] = $maxgrouppersonnum;
		$groupClass->maxgrouppersonnum = $maxgrouppersonnum;
	
		//=========================账号==========================
		$user = (Array)$feature['user'];
		if(!$user)
			return showData(null, 'lincense错误011', 1);
		$userClass = new Xizue_User();
		$featureClass->user = $userClass;
	
	
		// 登陆多设备
		$loginmultipledevice = $user['loginmultipledevice'];
		if($loginmultipledevice && $$loginmultipledevice == 1){
			$output_info['user_onedevice'] = "是";
			$userClass->loginmultipledevice = 1;
		}
		else
			$output_info['user_onedevice'] = "否";
		// 支持多用户登陆
		$multipleuser = $user['multipleuser'];
		if($multipleuser && $$multipleuser == 1){
			$output_info['user_oneacount'] = "是";
			$userClass->multipleuser = 1;
		}
		else
			$output_info['user_oneacount'] = "否";
	
		// pay url
		
		$ret_data['xizue'] = $xizue;
		
		return $ret_data;
		//return $xizue;
	}
	
	// 读取lincense
	private function readLincense() {
		$lincense = $this->lincense_db->where(Array('id'=>1))->find();
		if(!$lincense)
			return showData(null, '获取lincense信息失败', 1);
	
		$lincense_content = $lincense['lincense'];
		$bDefault = 0;
	
		if(!$lincense_content){
			$lincense_content = $lincense['default'];
			$bDefault = 1;
		}
	
		if(!$lincense_content)
			return showData(null, '获取lincense内容失败', 1);
	
		//$ttt = self::encodeLincense($lincense_content);
		
		if($bDefault){
			$this->lincense_info = self::decodeDefaultLincense($lincense_content);
		}else{
			$this->lincense_info = self::decodeLincense($lincense_content);
		}
	
		return showData(null, '解密成功', 0);
		}
	}

class Xizue {
	public $info;
	public $device;
	public $feature;
	public $expireorderid;
	public $payurl;	// 付款地址
	public $version;
}

class Xizue_Info {
	public $orderid;
	public $acount;
	public $ip;
	public $domain;
	public $ordertime;
	public $expiretime;	// 过期日期 永久则为-1
	public $tryexpiretime;
	public $paymethod;	// 1-一次性付款 2-按月付款 3-按年付款 0-免费用户
}

class Xizue_Device {
	public $android = 0;
	public $android_pad = 0;
	public $iphone = 0;
	public $ipad = 0;
	public $web = 0;
	public $windows_pc = 0;
}

class Xizue_Feature {
	public $chat;
	public $group;
	public $user;
}

class Xizue_Chat {
	public $maxusernum;
	public $maxonlineusernum;
}

class Xizue_Group {
	public $maxgroupnum;
	public $maxgrouppersonnum;
}

class Xizue_User {
	public $loginmultipledevice;	// 登陆多设备
	public $multipleuser;			// 单台设备支持多用户登陆
}
?>