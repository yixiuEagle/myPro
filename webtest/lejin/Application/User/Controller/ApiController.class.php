<?php
namespace User\Controller;
use User\Model\PushModel;
use Common\Api\Api;
class ApiController extends Api {
	function _initialize(){
		parent::_initialize();
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
	//====================================以上================================
	/**
	 * 获取验证码
	 */
	function getCode(){
	    $db = new \User\Model\CodeModel();
	    $data = $db->getCode();
	    $this->jsonOutput($data);
	}
	/**
	 * 验证验证码
	 */
	function checkCode() {
	    $db = new \User\Model\CodeModel();
	    $data = $db->checkCode();
	    $this->jsonOutput($data);
	}
	/**
	 * 重置密码
	 */
	function resetPassword(){
	    $db = new \User\Model\CodeModel();
	    $data = $db->resetPassword();
	    $this->jsonOutput($data);
	}
	/**
	 * 用户注册
	 */
	function regist() {
	    $data = $this->user_db->regist();
	    $this->jsonOutput($data);
	}
	/**
	 * 用户登录
	 */
	function login() {
	    $data = $this->user_db->login();
	    $this->jsonOutput($data);
	}
	/**
	 * 用户的详细资料
	 */
	function detail() {
	    self::isLogin();
	    $fuid = trim(I('fuid', 0));
	    if ($fuid) $fuid = $this->_initUser($fuid);
	    $data = $this->user_db->detail($this->mid, $fuid);
	    $this->jsonOutput($data);
	}
	/**
	 * 搜索用户
	 */
	function search(){
	    self::isLogin();
	    $data = $this->user_db->search($this->mid);
	    $this->jsonOutput($data);
	}
	/**
	 * 修改密码
	 */
	function editPwd(){
	    self::isLogin();
	    $data = $this->user_db->editPwd($this->mid);
	    $this->jsonOutput($data);
	}
	/**
	 * 反馈意见
	 */
	function feedback(){
	   // self::isLogin();
	    $data = $this->user_db->feedback($this->mid);
	    $this->jsonOutput($data);
	}
    /**
	 * 编辑资料 编辑个人资料、设置默认头像、删除图片、更换主图、新增图片
	 * @param number $uid
	 */
	function edit() {
	    self::isLogin();
	    $data = $this->user_db->edit($this->mid);
	    $this->jsonOutput($data);
	}
	/**
	 * 新增图片
	 */
	function addHead($uid){
	    self::isLogin();
	    $data = $this->user_db->addHead($this->mid);
	    $this->jsonOutput($data);
	}
	/**
	 * 删除图片
	 */
	function deleteHead($uid){
	    self::isLogin();
	    $data = $this->user_db->deleteHead($this->mid);
	    $this->jsonOutput($data);
	}
	/**
	 * 设置默认图片
	 */
	function setDefaultHead($uid){
	    self::isLogin();
	    $data = $this->user_db->setDefaultHead($this->mid);
	    $this->jsonOutput($data);
	}
	/**
	 * 更换主图
	 */
	function editBackground($uid){
	    self::isLogin();
	    $data = $this->user_db->editBackground($this->mid);
	    $this->jsonOutput($data);
	}
	/**
	 * 添加关注与取消关注
	 */
	function follow() {
	    self::isLogin();
	    $fuid = $this->_initUser(I('fuid', 0));
	    $data = $this->user_db->follow($this->mid, $fuid);
	    $this->jsonOutput($data);
	}
	
	function myfollow() {
		self::isLogin();
		
		$data = $this->user_db->myfollow($this->mid);
		$this->jsonOutput($data);
	}
	
	/**
	 * 加入黑名单和取消黑名单
	 */
	function addBlack() {
	    self::isLogin();
	    $fuid = $this->_initUser(I('fuid', 0));
	    $data = $this->user_db->addBlack($this->mid, $fuid);
	    $this->jsonOutput($data);
	}
	/**
	 * 黑名单列表
	 */
	function blackList() {
	    self::isLogin();
	    $data = $this->user_db->blackList($this->mid);
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
	/**
	 * 会员列表
	 */
	function memberLists(){
	    self::isLogin();
	    $data = $this->user_db->memberList();
	    $this->jsonOutput($data);
	}
	/**
	 * 会员购买时间
	 */
	function memberBuytime(){
	    self::isLogin();
	    $data = $this->user_db->memberBuytime($this->mid);
	    $this->jsonOutput($data);
	}
	/**
	 * 续费
	 */
	function renewFee(){
	    self::isLogin();
	    $data = $this->user_db->renewFee($this->mid);
	    $this->jsonOutput($data);
	}
	/**
	 * 获取会员权限
	 */
	function getMemberUserAccess(){
	    self::isLogin();
	    $data = $this->user_db->getMemberUserAccess($this->mid);
	    $this->jsonOutput($data);
	}
	/**
	 * 改变会员类型
	 */
	function changeMember(){
	    self::isLogin();
	    $data = $this->user_db->changeMember($this->mid);
	    $this->jsonOutput($data);
	}
	/**
	 * 帮助中心
	 */
	function help() {
	    $data = $this->user_db->help();
	    $this->jsonOutput($data);
	}
	/**
	 * 更新
	 */
	function update() {
	    ;
	}
	/**
	 * 举报
	 */
	function report() {
	    self::isLogin();
	    $data = $this->user_db->jubao($this->mid);
	    $this->jsonOutput($data);
	}
	/**
	 * 举报列表
	 */
	function reportLists() {
	    $data = $this->user_db->jubaoLists();
	    $this->jsonOutput($data);
	}
	/**
	 * 红点提醒
	 */
	function dotTip() {
	    self::isLogin();
	    $data = $this->user_db->dotTip($this->mid);
	    $this->jsonOutput($data);
	}
	
	function citylist() {
		 $data = $this->user_db->citylist();
	    $this->jsonOutput($data);
	}
    /**
     * 通讯录好友
     */
    function phoneBook(){
        self::isLogin();
        $data = array();
        $data['phones'] = I('phones')?explode(',',I('phones')):array();
        $data['names'] = I('names')?explode(',',I('names')):array();
        $data['uid'] = I('uid');
        $data = $this->user_db->phoneBook($data);
        $this->jsonOutput($data);
    }
    /**
     * 附近的人
     */
    function nearby(){
        self::isLogin();
        $data = array();
        $data['lng'] = I('lng');
        $data['lat'] = I('lat');
        $data['uid'] = I('uid');
//        $data['pageSize'] = I("pageSize");
//        $data['page'] = I("page");
        $data = $this->user_db->nearby($data);
        $this->jsonOutput($data);
    }
    /**
     * 申请提现
     */
    function extract(){
        self::isLogin();
        $data = array();
        $data['uid'] = I('uid');
        $data['price'] = I('price');
        $data['account_name'] = I('account_name');
        $data['account_number'] = I('account_number');
        $data = $this->user_db->extract($data);
        $this->jsonOutput($data);
    }
    /**
     * 我的优惠券
     */
    function myCoupon(){
        self::isLogin();
//        $data = array();
//        $data['pageSize'] = I("pageSize");
//        $data['page'] = I("page");
        $data = $this->user_db->myCoupon($this->mid);
        $this->jsonOutput($data);
    }
    /**
     * 邀请好友
     */
    function invite(){
        self::isLogin();
        $phone = I('phone');
        //TODO 发送短信
        $this->jsonOutput(showData(new \stdClass(),'邀请成功'));
    }

    /**
     * 会员等级列表
     */
    function member(){
        $data = $this->user_db->member($this->mid);
        $this->jsonOutput($data);
    }
}