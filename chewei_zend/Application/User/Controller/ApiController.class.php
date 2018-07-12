<?php
namespace User\Controller;
use User\Model\PushModel;
use Common\Api\Api;
use User\Model\MapModel;
class ApiController extends Api {
	private $map_db;
	private $msg_db;
	function _initialize(){
		parent::_initialize();
		
		$this->map_db=new MapModel();
	}
	/**
	 * 统计
	 */
	function statistics(){
	    $data=$this->user_db->statistics();
	    $this->jsonOutput($data);
	}
	/**
	 * 更新地图
	 */
	function update_map(){
	    $data = $this->user_db->update_map();
	    if(is_array($data)){
	        $this->jsonOutput($data);
	    }else{
	        exit($data);
	    }
	}
	/**
	 * 扫描二维码
	 */
	function codeMsg(){
	    $data=$this->user_db->codeMsg();
	    $this->jsonOutput($data);
	}
	/**
	 * 获取验证码
	 */
	function getCode(){
	    $data = $this->user_db->getCode();
	    $this->jsonOutput($data);
	}
	
	/**
	 * 注册
	 */
	function regist(){
		$return = $this->user_db->regist();
	    $this->jsonOutput($return);
	}
	/**
	 * 登陆
	 */
	function login(){
	    $return = $this->user_db->login();
	    $this->jsonOutput($return);
	}
	/**
	 * 修改用户
	 */
	function edit(){
		$uid = $this->_initUser(I('uid'));
		$return = $this->user_db->editUser($uid);
		exit(unicodeString( json_encode($return) ));
	}
	/**
	 * 删除用户
	 */
	function delete(){
		$uid = $this->_initUser(I('uid'));
		$return = $this->user_db->deleteUser($uid);
		exit(unicodeString( json_encode($return) ));
	}
	/**
	 * 发送通知
	 */
	function notice(){
		$uid = $this->_initUser(I('uid'));
		$fid = $this->_initUser(I('touid'));
		$return = $this->user_db->sendNotice($uid, $fid);
		exit(unicodeString( json_encode($return) ));
	}
	/**
	 * 接收推送通知
	 */
	function addNoticeHostForIphone(){
		$uid = $this->_initUser(I('uid'));
		$push = new PushModel();
		$return = $push->addNoticeHostForIphone($uid);
		$this->jsonOutput($return);
	}
	/**
	 * 拒绝推送通知
	 */
	function removeNoticeHostForIphone(){
		$uid = $this->_initUser(I('uid'));
		$push = new PushModel();
		$return = $push->removeNoticeHostForIphone($uid);
		$this->jsonOutput($return);
	}
	
	/**
	 * 用户在线状态
	 */
	function onlinestatus() {
		$return = $this->user_db->onlinestatus();
		exit(unicodeString( json_encode($return) ));
	}
	/**
	 * 处理ios推送
	 */
	function handleIosPush() {
		$model = new PushModel();
		$return = $model->handleIosPush();
		exit(unicodeString( json_encode($return) ));
	}
	/**
	 * 个人信息
	 */
	function userInfo(){
	    self::isLogin();
	    $data=$this->user_db->user($this->mid);
	    $this->jsonOutput($data);
	}
	/**
	 * 绑定或解绑账号
	 */
	function bindAccount(){
	    $data = $this->user_db->bindAccount();
	    $this->jsonOutput($data);
	}
	/**
	 * 电话求助
	 */
	function help(){
	    $data=$this->user_db->help();
	    $this->jsonOutput($data);
	}
	/**
	 * 提现信息查询
	 */
	function receive_info(){
	    self::isLogin();
	    $data=$this->user_db->receive_info($this->mid);
	    $this->jsonOutput($data); 
	}
	/**
	 * 提现
	 */
	function receive(){
	    self::isLogin();
	    $data=$this->user_db->receive($this->mid);
	    $this->jsonOutput($data);
	}
	/**
	 * 已购地图列表
	 */
	function purchaseList(){
	    self::isLogin();
	    $data=$this->map_db->purchaseList($this->mid);
	    $this->jsonOutput($data);
	}
	/**
	 * 附近停车场
	 */
	function nearby(){
	    $data=$this->map_db->nearby();
	    $this->jsonOutput($data);
	}
	/**
	 * 搜索停车场
	 */
	function search_map(){
	    $data=$this->map_db->search_map();
	    $this->jsonOutput($data);
	}
	/**
	 * 地图下载
	 */
	function map_download(){
	    self::isLogin();
	    $data=$this->map_db->map_download($this->mid);
	    $this->jsonOutput($data);
	}
	/**
	 * 地图收入
	 */
	function mapIncome(){
	    self::isLogin();
	    $data=$this->map_db->mapIncome($this->mid);
	    $this->jsonOutput($data);
	}
	/**
	 * 检测地图是否购买
	 */
	function checkmap(){
	    self::isLogin();
	    $data=$this->map_db->checkmap($this->mid);
	    $this->jsonOutput($data);
	}
	/**
	 * 消费记录
	 */
	function consume_recordList(){
	    self::isLogin();
	    $data=$this->user_db->consume_recordList($this->mid);
	    $this->jsonOutput($data);
	}
	/**
	 * 读取消费通知
	 */
	function getmsg(){
	    self::islogin();
	    $data=$this->user_db->wrmsg($this->mid);
	    $this->jsonOutput($data);
	}
	/**
	 * 读消息
	 */
	function read_msg(){
	    self::isLogin();
	    $data=$this->user_db->read_msg();
	    $this->jsonOutput($data);
	}
	/**
	 * 广告列表
	 */
	function advlist(){
	    $data=$this->user_db->advlist();
	    $this->jsonOutput($data);
	}
	/**
	 * 地图信息
	 */
	function mapmsg(){
	    $data=$this->user_db->mapmsg();
	    $this->jsonOutput($data);
	}
	/**
	 * 上传信息
	 */
	function upload(){
	    $data=$this->user_db->upload();
	    $this->jsonOutput($data);
	}
	/**
	 * 充值
	 */
	function recharege(){
	    self::isLogin();
	    $data = $this->user_db->recharege($this->mid);
	    $this->jsonOutput($data);
	}
	//1.支付宝 订单回调通知地址
	function notifyurl(){
	    $pay  = new \Common\Pay\Pay();
	    $pay->notifyurl();
	}
	//1.微信 订单回调通知地址
	function wxnotifyurl(){
	    $pay  = new \Common\Pay\Pay();
	    $pay->wxnotifyurl();
	}
}