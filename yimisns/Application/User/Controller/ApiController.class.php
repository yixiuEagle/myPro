<?php
namespace User\Controller;
use User\Model\PushModel;
use User\Model\KuaipaiModel;

use Common\Api\Api;
use User\Model\PosshareModel;
use Think\Model;
class ApiController extends Api {
	
	private $msg_db;
	protected $kuaipai_db;
	protected $posshare_db;
	
	function _initialize(){
		parent::_initialize();
		
		$this->kuaipai_db = new KuaipaiModel();
		$this->posshare_db = new PosshareModel();
	}
	/**
	 * 机器人随机浏览快拍
	 */
	function browsekuaipai(){
	    $data = $this->user_db->browsekuaipai();
	}
    /**
     *机器人随机浏览动态 
     */
	function browsedynamic(){
	    $data = $this->user_db->browsedynamic();
// 	    $this->jsonOutput($data);
	}
	/**
	 * 分享网页
	 */
	function sharepage(){
	    $type=I('type',0);
	    if($type==1){//动态分享网页
	        $data=$this->user_db->dynamicshare();
	        //$this->jsonOutput($data);
	        $this->assign('data',$data);
	        $this->display('dynamic');
	    }
	    if($type==2){//快拍分享网页
	        $data=$this->user_db->kuaipaishare();
	       // $this->jsonOutput($data);
	       if($data['data']==""||$data['data']==null){
	           echo "快拍信息不存在";
	           return;
	       }
	        $this->assign('data',$data);
	        $this->display('kuaipai');
	    }
	    if($type==3){//打卡分享网页
	        $data=$this->user_db->dakashare();
	        //$this->jsonOutput($data);
	        if($data['data']==""||$data['data']==null){
	            echo "打卡信息不存在";
	            return;
	        }
	        $this->assign('data',$data);
	        $this->display('daka');
	        
	    }
	    if($type==4){//分享网址
	        $data=$this->user_db->webshare();
	        //$this->jsonOutput($data);
	        $this->assign('data',$data);
	        $this->display('web');
	    }
	     
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
	 * 隐身登陆
	 */
	function invisibleLogin(){
		self::isLogin();
		$return = $this->user_db->invisibleLogin($this->mid);
		$this->jsonOutput($return);
	}
	/**
	 * 取消手机安全设置
	 */
	function close_safe_login(){
		self::isLogin();
		$return = $this->user_db->close_safe_login($this->mid);
		$this->jsonOutput($return);
	}
	/**
	 * 第三方登录
	 */
	function thirdLogin(){
	    $return = $this->user_db->thirdLogin();
	    $this->jsonOutput($return);
	}
	/**
	 * 附近用户
	 */
	function nearby(){
		self::isLogin();
		$return = $this->user_db->nearby($this->mid);
		$this->jsonOutput($return);
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
	 * 个人资料赞
	 */
	function info_zan(){
	    self::isLogin();
	    $data=$this->user_db->info_zan($this->mid);
	    $this->jsonOutput($data);
	}
	/**
	 * 取消赞
	 */
	function info_delzan(){
	    self::isLogin();
	    $data=$this->user_db->info_delzan($this->mid);
	    $this->jsonOutput($data);
	}
	/**
	 * 获取用户的详细信息
	 * 当是自己的时候直接获取用户资料，如果不是自己的时候就获取别人的资料
	 */
	function detail(){
		self::isLogin();
		$fid = I('fuid', 0);
		if ($fid) $fid = $this->_initUser($fid);
		$return = $this->user_db->user($this->mid, $fid);
		$this->jsonOutput($return);
	}
	/**
	 * 搜索用户
	 */
	function search(){
		self::isLogin();
		$return = $this->user_db->search($this->mid);
		$this->jsonOutput($return);
	}

	/**
	 * 申请加好友
	 */
	function applyAddFriend(){
		self::isLogin();
		$fid 	= $this->_initUser(I('fuid'));
		$return = $this->user_db->applyAddFriend($this->mid, $fid);
		$this->jsonOutput($return);
	}
	/**
	 * 同意加好友
	 */
	function agreeAddFriend(){
		self::isLogin();
		$fid 	= $this->_initUser(I('fuid'));
		$return = $this->user_db->agreeAddFriend($this->mid, $fid);
		$this->jsonOutput($return);
	}
	/**
	 * 拒绝加好友
	 */
	function refuseAddFriend(){
		self::isLogin();
		$fid 	= $this->_initUser(I('fuid'));
		$return = $this->user_db->refuseAddFriend($this->mid, $fid);
		$this->jsonOutput($return);
	}
	
	/**
	 * 关注/取消关注 
	 */
	function follow_old(){
		self::isLogin();
		$fid 	= $this->_initUser(I('fuid'));
		$return = $this->user_db->follow_old($this->mid, $fid);
		$this->jsonOutput($return);
	}
	
	/**
	 * 删除好友
	 */
	function deleteFriend(){
		self::isLogin();
		$fid 	= $this->_initUser(I('fuid'));
		$return = $this->user_db->deleteFriend($this->mid, $fid);
		$this->jsonOutput($return);
	}
	/**
	 * 编辑资料
	 */
	function edit(){
		self::isLogin();
		$return = $this->user_db->editUser($this->mid);
		$this->jsonOutput($return);
	}
	/**
	 * 完善资料
	 */
	function completeInfo(){
		self::isLogin();
		$return = $this->user_db->completeInfo($this->mid);
		$this->jsonOutput($return);
	}
	/**
	 * 职业列表
	 */
	function joblist() {
		$return = $this->user_db->joblist();
		$this->jsonOutput($return);
	}
	/**
	 * 故乡列表
	 */
	function hometownlist() {
		$return = $this->user_db->hometownlist();
		$this->jsonOutput($return);
	}
	/**
	 * 添加故乡
	 */
	function addhometown(){
	    allcity();
	}
	// 提供给android使用
	function hometownlist2() {
		$return = $this->user_db->hometownlist2();
		$this->jsonOutput($return);
	}
	/**
	 * 修改密码
	 */
	function editPassword(){
		self::isLogin();
		$return = $this->user_db->editPassword($this->mid);
		$this->jsonOutput($return);
	}
	/**
	 * 找回密码
	 */
	function findPassword(){
	    $return = $this->user_db->findPassword();
	    $this->jsonOutput($return);
	}
	/**
	 * 反馈意见
	 */
	function feedback(){
		self::isLogin();
		$return = $this->user_db->feedback($this->mid);
		$this->jsonOutput($return);
	}
	/**
	 * 举报
	 */
	function jubao(){
		self::isLogin();
		//$fid 	= $this->_initUser(I('fid'));
		$return = $this->user_db->jubao($this->mid);
		$this->jsonOutput($return);
	}
	/**
	 * 举报类型列表
	 */
	function jubao_list(){
		$return = $this->user_db->jubao_list();
		$this->jsonOutput($return);
	}
	
	/**
	 * 添加取消关注
	 */
	function follow(){
		self::isLogin();
		$return = $this->user_db->follow($this->mid);
		$this->jsonOutput($return);
	}
	
	/**
	 * 我的好友
	 */
	function friendlist(){
		self::isLogin();
		$return = $this->user_db->friendlist($this->mid);
		$this->jsonOutput($return);
	}
	
	/**
	 * 0-我关注的，1-关注我的  2-我关注的及好友
	 */
	function myfollow(){
		self::isLogin();
		$return = $this->user_db->myfollow($this->mid);
		$this->jsonOutput($return);
	}
	/**
	 * 导入手机联系人
	 */
	function importContact(){
	    self::isLogin();
	    $data = $this->user_db->importContact($this->mid);
	    $this->jsonOutput($data);
	}
	/**
	 * 设置备注
	 */
	function setRemark(){
	    self::isLogin();
	    $fid  = $this->_initUser(I('fid'));
	    $data = $this->user_db->setRemark($this->mid, $fid);
	    $this->jsonOutput($data);
	}
	/**
	 * 添加到黑名单和取消
	 */
	function black(){
	    self::isLogin();
	    $fid  = $this->_initUser(I('fid'));
	    $data = $this->user_db->black($this->mid, $fid);
	    $this->jsonOutput($data);
	}
	/**
	 * 黑名单列表
	 */
	function blackList(){
	    self::isLogin();
	    $data = $this->user_db->blackLists($this->mid);
	    $this->jsonOutput($data);
	}
	/**
	 * 可能认识的人，推荐的人
	 */
	function recommendList(){
	    self::isLogin();
	    $data = $this->user_db->recommendList($this->mid);
	    $this->jsonOutput($data);
	}
	/**
	 * 第三方账号好友推荐
	 */
	function thirdfriend(){
		self::isLogin();
		$data = $this->user_db->thirdfriend($this->mid);
		$this->jsonOutput($data);
	}
	/**
	 * 转赠
	 */
	function giveMoney(){
	    self::isLogin();
	    $fuid = $this->_initUser(I('fid'));
	    $data = $this->user_db->give($this->mid, $fuid);
	    $this->jsonOutput($data);
	}
	/**
	 * 发布快拍
	 */
	function publish_kuaipai(){
		self::isLogin();
		$return = $this->user_db->publish_kuaipai($this->mid);
		$this->jsonOutput($return);
	}
	
	/**
	 * 快拍列表
	 */
	function kuaipai_list(){
		self::isLogin();
		$return = $this->user_db->kuaipai_list($this->mid);
		$this->jsonOutput($return);
	}
	/**
	 * 快拍详细
	 */
	function kuaipai_detail(){
	    self::isLogin();
	    $return = $this->user_db->kuaipai_detail($this->mid);
	    $this->jsonOutput($return);
	}
	/**
	 * 删除快拍
	 */
	function delete_kuaipai(){
	    self::isLogin();
	    $return = $this->user_db->delete_kuaipai($this->mid);
	    $this->jsonOutput($return);
	}
	/**
	 * 话题列表
	 */
	function huati_list(){
		self::isLogin();
		$return = $this->user_db->huati_list($this->mid);
		$this->jsonOutput($return);
	}
	
	/**
	 * 发布动态
	 */
	function publish_dynamic(){
		self::isLogin();
		$return = $this->user_db->publish_dynamic($this->mid);
		$this->jsonOutput($return);
	}
	/**
	 * 删除动态
	 */
	function delete_dynamic(){
	    self::isLogin();
	    $result = $this->user_db->delete_dynamic($this->mid);
	    $this->jsonOutput($result);
	}
	/**
	 * 动态未读数量
	 */
	function dynamic_unreadnum(){
		self::isLogin();
		$return = $this->user_db->dynamic_unreadnum($this->mid);
		$this->jsonOutput($return);
	}
	/**
	 * 动态未读消息列表
	 */
	function dynamic_unread_list(){
		self::isLogin();
		$return = $this->user_db->dynamic_unread_list($this->mid);
		$this->jsonOutput($return);
	}
	
	/**
	 * 附近动态列表
	 */
	function dynamic_nearby(){
		self::isLogin();
		$return = $this->user_db->dynamic_nearby($this->mid);
		$this->jsonOutput($return);
	}
	/**
	 * 好友动态列表
	 */
	function dynamic_friend(){
		self::isLogin();
		$return = $this->user_db->dynamic_friend($this->mid);
		$this->jsonOutput($return);
	}
	/**
	 * 他的动态列表
	 */
	function dynamic_list(){
		self::isLogin();
		$return = $this->user_db->dynamic_list($this->mid);
		$this->jsonOutput($return);
	}
	/**
	 * 动态详细
	 */
	function dynamic_detail(){
		self::isLogin();
		$return = $this->user_db->dynamic_detail($this->mid);
		$this->jsonOutput($return);
	}
	
	/**
	 * 动态评论列表
	 */
	function comment_list(){
		self::isLogin();
		$linkid = I('id', 0);
		$return = $this->user_db->comment_list($linkid, 0);
		$this->jsonOutput($return);
	}
	
	/**
	 * 访客列表
	 */
	function dynamic_guest(){
		self::isLogin();
		$return = $this->user_db->dynamic_guest($this->mid);
		$this->jsonOutput($return);
	}
	/**
	 * 访客人数
	 */
	function num_guest(){
	    self::isLogin();
	    $return = $this->user_db->num_guest($this->mid);
	    $this->jsonOutput($return);
	}
	/**
	 * 相册删除图片
	 */
	function album_delete(){
	    self::isLogin();
	    $return = $this->user_db->album_delete($this->mid);
	    $this->jsonOutput($return);
	}
	/**
	 * 相册添加图片
	 */
	function add_album(){
	    self::isLogin();
	    $return = $this->user_db->add_album($this->mid);
	    $this->jsonOutput($return);
	}
	/**
	 * 相册列表
	 */
	function album_list(){
		self::isLogin();
		$return = $this->user_db->album_list($this->mid);
		$this->jsonOutput($return);
	}
	
	/**
	 * 赞动态
	*/
	function dynamiczan(){
		self::isLogin();
		$id = I('id', 0);
		$return = $this->user_db->dynamiczan($this->mid,$id);
		$this->jsonOutput($return);
	}
	
	/**
	 * 评论动态
	 */
	function dynamiccomment(){
		self::isLogin();
		$return = $this->user_db->dynamiccomment($this->mid);
		$this->jsonOutput($return);
	}
	
	/**
	 * 增加分享次数
	 */
	function addShareCount(){
		self::isLogin();
		$type = I('type', 1);
		if($type == 1) {
			$return = $this->user_db->addShareCount($this->mid);
			$this->jsonOutput($return);
		}else{
			$return = $this->user_db->addDakaCount($this->mid);
			$this->jsonOutput($return);
		}
		
	}
	
	/**
	 * 定向隐身
	 */
	function yinshen() {
		self::isLogin();
		$return = $this->user_db->yinshen($this->mid);
		$this->jsonOutput($return);
	}
	
	/**
	 * 隐身列表
	 */
	function yinshen_list() {
		self::isLogin();
		$return = $this->user_db->yinshen_list($this->mid);
		$this->jsonOutput($return);
	}
	
	/**
	 * 会员费列表
	 */
	function member_fee() {
		self::isLogin();
		$return = $this->user_db->member_fee($this->mid);
		$this->jsonOutput($return);
	}
	/**
	 * 会员中心
	 */
	function memberCenter(){
	    self::isLogin();
	    $data = $this->user_db->memberCenter($this->mid);
	    $this->jsonOutput($data);
	}
	/**
	 * 加入会员
	 */
	function addMember($uid){
	     
	}
	/**
	 * 续费
	 */
	function renewMemer($uid){
	
	}
	/**
	 * 打卡列表
	 */
	function dakalists(){
	    self::isLogin();
	    $data = $this->user_db->dakalists($this->mid);
	    $this->jsonOutput($data);
	}
	/**
	 * 添加打卡
	 */
	function addDaka(){
	    self::isLogin();
	    $data = $this->user_db->addDaka($this->mid);
	    $this->jsonOutput($data);
	}
	/**
	 * 广告列表
	 */
	function adv_list() {
		$return = $this->user_db->adv_list();
		$this->jsonOutput($return);
	}
	
	/**
	 * 修改密码
	 */
	function modifypass() {
		self::isLogin();
		$return = $this->user_db->modifypass($this->mid);
		$this->jsonOutput($return);
	}
	/**
	 * 获取消息设置
	 */
	function getmsg(){
	    self::isLogin();
	    $return = $this->user_db->getmsg($this->mid);
	    $this->jsonOutput($return);
	}
	/**
	 * 我的收益
	 */
	function income() {
		self::isLogin();
		$return = $this->user_db->income($this->mid);
		$this->jsonOutput($return);
	}
	
	/**
	 * 申请提现
	 */
	function withdraw() {
		self::isLogin();
		$return = $this->user_db->withdraw($this->mid);
		$this->jsonOutput($return);
	}
	
	/**
	 * 近期收益排名
	 */
	function income_sort() {
		self::isLogin();
		$return = $this->user_db->income_sort($this->mid);
		$this->jsonOutput($return);
	}
	
	/**
	 * 分享统计
	 */
	function share_statistics() {
		self::isLogin();
		$return = $this->user_db->share_statistics($this->mid);
		$this->jsonOutput($return);
	}
	
	/**
	 * 有奖统计
	 */
	function award_daka() {
		self::isLogin();
		$return = $this->user_db->award_daka($this->mid);
		$this->jsonOutput($return);
	}
	
	/**
	 * 举报统计
	 */
	function jubao_statistics() {
		self::isLogin();
		$return = $this->user_db->jubao_statistics($this->mid);
		$this->jsonOutput($return);
	}
	
	/**
	 * 动态统计
	 */
	function dynaimc_statistics() {
		self::isLogin();
		$return = $this->user_db->dynaimc_statistics($this->mid);
		$this->jsonOutput($return);
	}
	
	/**
	 * 快拍统计
	 */
	function kuaipai_statistics() {
		self::isLogin();
		$return = $this->user_db->kuaipai_statistics($this->mid);
		$this->jsonOutput($return);
	}
	
	/**
	 * 设置是否自动购买
	 */
	function setAutoBuyMember() {
		self::isLogin();
		$return = $this->user_db->setAutoBuyMember($this->mid);
		$this->jsonOutput($return);
	}
	
	/**
	 * 设置支付宝账号
	 */
	function setAlipayAccount() {
		self::isLogin();
		$return = $this->user_db->setAlipayAccount($this->mid);
		$this->jsonOutput($return);
	}
	
	/**
	 * 取消支付宝账号
	 */
	function delAlipayAccount() {
		self::isLogin();
		$return = $this->user_db->delAlipayAccount($this->mid);
		$this->jsonOutput($return);
	}
	
	/**
	 * 发红包
	 */
	function publish_hongbao() {
		self::isLogin();
		$return = $this->user_db->publish_hongbao($this->mid);
		$this->jsonOutput($return);
	}
	
	/**
	 * 抢红包
	 */
	function qiang_hongbao() {
		self::isLogin();
		$return = $this->user_db->qiang_hongbao($this->mid);
		$this->jsonOutput($return);
	}
	
	/**
	 * 红包详细
	 */
	function hongbao_record() {
		self::isLogin();
		$return = $this->user_db->hongbao_record($this->mid);
		$this->jsonOutput($return);
	}
	
	/**
	 * 是否抢了红包
	 */
	function has_qianghongbao() {
		self::isLogin();
		$return = $this->user_db->has_qianghongbao($this->mid);
		$this->jsonOutput($return);
	}
	
	/**
	 * 我收到的红包
	 */
	function my_receive_hongbao() {
		self::isLogin();
		$return = $this->user_db->my_receive_hongbao($this->mid);
		$this->jsonOutput($return);
	}
	function testnotice(){
	    $return=$this->user_db->test();
	    $this->jsonOutput($return);
	}
	/**
	 * 自定义通知
	 */
	function sharenotice(){
	    $return=$this->user_db->sharenotice($this->mid);
	    $this->jsonOutput($return);
	}
	/**
	 * 我发出的红包
	 */
	function my_publish_hongbao() {
		self::isLogin();
		$return = $this->user_db->my_publish_hongbao($this->mid);
		$this->jsonOutput($return);
	}
	
	/**
	 * 消费记录
	 */
	function consume_list() {
		self::isLogin();
		$return = $this->user_db->consume_list($this->mid);
		$this->jsonOutput($return);
	}
	/**
	 * 星座列表
	 */
	function xingzuoLists(){
	    $data = $this->user_db->xingzuoLists();
	    $this->jsonOutput($data);
	}
	
	/**
	 * 设置隐私
	 */
	function setYinsi_type(){
		self::isLogin();
		$data = $this->user_db->setYinsi_type($this->mid);
		$this->jsonOutput($data);
	}
	
	/**
	 * 设置对好友是否隐私或可见
	 */
	function setFriendYinsi_type(){
		self::isLogin();
		$data = $this->user_db->setFriendYinsi_type($this->mid);
		$this->jsonOutput($data);
	}
	
	/**
	 * 绑定或解绑账号
	 */
	function bindAccount(){
		self::isLogin();
		$data = $this->user_db->bindAccount($this->mid);
		$this->jsonOutput($data);
	}
	
	/**
	 * 设置用户勿扰时间
	 */
	function setUserWurao(){
		self::isLogin();
		$data = $this->user_db->setUserWurao($this->mid);
		$this->jsonOutput($data);
	}
	
	/**
	 * 绑定安全手机
	 */
	function bindSafePhone(){
		self::isLogin();
		$data = $this->user_db->bindSafePhone($this->mid);
		$this->jsonOutput($data);
	}
	
	/**
	 * 安全手机重置密码
	 */
	function resetPassBySafePhone(){
		self::isLogin();
		$data = $this->user_db->resetPassBySafePhone($this->mid);
		$this->jsonOutput($data);
	}
	
	/**
	 * 设置消息设置
	 */
	function msg_setting(){
		self::isLogin();
		$data = $this->user_db->msg_setting($this->mid);
		$this->jsonOutput($data);
	}
	
	/**
	 * 设置用户其他配置 
	 */
	function setUserOtherConfig(){
		self::isLogin();
		$data = $this->user_db->setUserOtherConfig($this->mid);
		$this->jsonOutput($data);
	}
	/* function updateUserMember_xuefeimember(){
	    $feeid=I('feeid');
	    $data = $this->user_db->updateUserMember_xuefeimember($this->mid,$feeid);
	} */
	
	/**
	 * 会员续费金额
	 */
	function member_xufei_money() {
		self::isLogin();
		$data = $this->user_db->member_xufei_money($this->mid);
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
	//=================== 快拍相关 ==========================
	/**
	 * 入群
	 */
	function enterGroup() {
		self::isLogin();
		$data = $this->kuaipai_db->enterGroup($this->mid);
		$this->jsonOutput($data);
	}
	
	/**
	 * 获取最新用户头像
	 */
	function lastUserHeads() {
		self::isLogin();
		$data = $this->kuaipai_db->lastUserHeads($this->mid);
		$this->jsonOutput($data);
	}
	
	/**
	 * 赞
	 */
	function kuaipai_zan() {
		self::isLogin();
		$groupId=I('groupId', 0);
		$data = $this->kuaipai_db->kuaipai_zan($this->mid,$groupId);
		$this->jsonOutput($data);
	}
	/**
	 * 快拍赞数量
	 */
	function kuaipai_zancount(){
	    $id=I('id', 0);
	    $data = $this->kuaipai_db->kuaipai_zancount($id);
	    $this->jsonOutput($data);
	}
	/**
	 * 管理员设置  评论及通知我  关闭评论
	 */
	function kuaipai_admin_setting() {
		self::isLogin();
		$data = $this->kuaipai_db->kuaipai_admin_setting($this->mid);
		$this->jsonOutput($data);
	}
	
	/**
	 * 管理员发起自动加入会议
	 */
	function kuaipai_automeeting() {
		self::isLogin();
		$data = $this->kuaipai_db->kuaipai_automeeting($this->mid);
		$this->jsonOutput($data);
	}
	
	/**
	 * 直播结束
	 */
	function kuaipai_endMeeting() {
		self::isLogin();
		$data = $this->kuaipai_db->kuaipai_endMeeting($this->mid);
		$this->jsonOutput($data);
	}
	
	
	/**
	 * 服务类别接口
	 */
	function service_category_list() {
		self::isLogin();
		$data = $this->user_db->service_category_list();
		$this->jsonOutput($data);
	}
	/**
	 * 服务列表
	 */
	function service_list() {
		self::isLogin();
		$data = $this->user_db->service_list($this->mid);
		$this->jsonOutput($data);
	}
	/**
	 * 服务搜索历史
	 */
	function service_search_list() {
		self::isLogin();
		$data = $this->user_db->service_search_list($this->mid);
		$this->jsonOutput($data);
	}
	
	/**
	 * 场景附近的人
	 */
	function changjing_nearby_persons() {
		self::isLogin();
		$data = $this->user_db->changjing_nearby_persons($this->mid);
		$this->jsonOutput($data);
	}
	/**
	 * 场景附近的服务站点
	 */
	function changjing_nearby_service() {
	    self::isLogin();
	    $data = $this->user_db->changjing_nearby_service($this->mid);
	    $this->jsonOutput($data);
	}
	//==================实时位置共享====================
	/**
	 * 入群
	 */
	function posshare_enterGroup() {
		self::isLogin();
		$data = $this->posshare_db->enterGroup($this->mid);
		$this->jsonOutput($data);
	}
	/**
	 * 更新用户位置
	 */
	function posshare_updatepos() {
		self::isLogin();
		$data = $this->posshare_db->updatepos($this->mid);
		$this->jsonOutput($data);
	}
	/**
	 * 退出群
	 */
	function posshare_quitGroup() {
		self::isLogin();
		$data = $this->posshare_db->quitGroup($this->mid);
		$this->jsonOutput($data);
	}
	
	/**
	 * 获取最新用户头像
	 */
	function posshare_lastUserHeads() {
		self::isLogin();
		$data = $this->posshare_db->lastUserHeads($this->mid);
		$this->jsonOutput($data);
	}
	
	/**
	 * 网址收藏
	 */
	function netcollect() {
		self::isLogin();
		$data = $this->user_db->netcollect($this->mid);
		$this->jsonOutput($data);
	}
	
	/**
	 * 记录分享
	 */
	function sharerecord() {
		self::isLogin();
		$data = $this->user_db->sharerecord($this->mid);
		$this->jsonOutput($data);
	}
	
	/**
	 * 获取全球号码
	 */
	function haoma() {
		$data = $this->user_db->haoma();
		$this->jsonOutput($data);
	}
	
	/**
	 * 更新wifi信息
	 */
	function updatewifi() {
		self::isLogin();
		$data = $this->user_db->updatewifi($this->mid);
		$this->jsonOutput($data);
	}
	/**
	 * 获取周围随机经纬度
	 */
	function returnSquarePoint(){
	    $data = $this->user_db->returnSquarePoint(I('lat'),I('lng'),I('distance'));
	    $this->jsonOutput($data);
	}
	/**
	 * 计算两点的距离
	 * 
	 */
	function getDistance(){
	    $lat1=I('lat1');
	    $lng1=I('lng1');
	    $lat2=I('lat2');
	    $lng2=I('lng2');
	    $earthRadius = 6367000; //approximate radius of earth in meters
	
	    /*
	     Convert these degrees to radians
	     to work with the formula
	     */
	
	    $lat1 = ($lat1 * pi() ) / 180;
	    $lng1 = ($lng1 * pi() ) / 180;
	
	    $lat2 = ($lat2 * pi() ) / 180;
	    $lng2 = ($lng2 * pi() ) / 180;
	
	    /*
	     Using the
	     Haversine formula
	
	     http://en.wikipedia.org/wiki/Haversine_formula
	
	     calculate the distance
	     */
	
	    $calcLongitude = $lng2 - $lng1;
	    $calcLatitude = $lat2 - $lat1;
	    $stepOne = pow(sin($calcLatitude / 2), 2) + cos($lat1) * cos($lat2) * pow(sin($calcLongitude / 2), 2);
	    $stepTwo = 2 * asin(min(1, sqrt($stepOne)));
	    $calculatedDistance = $earthRadius * $stepTwo;
	    return round($calculatedDistance);
	}
	/**
	 * 定时任务1
	 */
	function task(){
	    //注册半个月内的新用户
	    $now=intval(NOW_TIME);
	    $time=$now-15*24*60*60;
	    $newuser=M('user')->where(array('createtime'=>array('EGT',$time),'usertype'=>0))->select();
	    foreach ($newuser as $k => $v){
	       $kuaipai=M('kuaipai')->where(array('uid'=>$v['uid']))->select();
	       $robts=M('user')->where(array('usertype'=>1))->select();
	       shuffle($robts);//随机取到访问用户的机器人
	       //随机进入快拍
	       foreach ($kuaipai as $k =>$v){
	           $id=$v['id'];
	           $uid=$v['uid'];
	           if($v['createtime']>=($now-10*60)){  //10分钟之内
	               $robts=array_slice($robts,0,C('arobtcount'));
	               $zan=mt_rand(count($robts)*C('min'),count($robts)*C('max'));  //随机赞数量
	               foreach ($robts as $k => $v){
	                   $return = $this->user_db->kuaipai_detail($v['uid'],$id); //浏览快拍
	                   $gid=M('group')->field('id')->where(array('name'=>$id))->find();
	                   $staytime=mt_rand(C('mintime'),C('maxtime'));     //在快拍里呆的时间
	                   M('group_user')->add(array('groupid'=>$gid['gid'],'uid'=>$v['uid'],'addtime'=>NOW_TIME,'lasttime'=>(NOW_TIME+$staytime*60)));
	                   if($k<$zan){
	                       $data = $this->kuaipai_db->kuaipai_zan($v['uid'],$gid);  //随机点赞
	                   }
	               }
	           }else if($v['createtime']>=($now-20*60) && $v['createtime']<($now-10*60)){  //10分钟-20分钟
	               $robts=array_slice($robts,0,C('brobtcount'));
	               $zan=mt_rand(count($robts)*C('min'),count($robts)*C('max'));  //随机赞数量
	               foreach ($robts as $k => $v){
	                   $return = $this->user_db->kuaipai_detail($v['uid'],$id); //浏览快拍
	                   $gid=M('group')->field('id')->where(array('name'=>$id))->find();
	                   $staytime=mt_rand(C('mintime'),C('maxtime'));     //在快拍里呆的时间
	                   M('group_user')->add(array('groupid'=>$gid['gid'],'uid'=>$v['uid'],'addtime'=>NOW_TIME,'lasttime'=>(NOW_TIME+$staytime*60)));
	                   if($k<$zan){
	                       $data = $this->kuaipai_db->kuaipai_zan($v['uid'],$gid);  //随机点赞
	                   }
	               }
	           }else if($v['createtime']>=($now-30*60) && $v['createtime']<($now-20*60)){  //20分钟-30分钟
	               $robts=array_slice($robts,0,C('crobtcount'));
	               $zan=mt_rand(count($robts)*C('min'),count($robts)*C('max'));  //随机赞数量
	               foreach ($robts as $k => $v){
	                   $return = $this->user_db->kuaipai_detail($v['uid'],$id); //浏览快拍
	                   $gid=M('group')->field('id')->where(array('name'=>$id))->find();
	                   $staytime=mt_rand(C('mintime'),C('maxtime'));     //在快拍里呆的时间
	                   M('group_user')->add(array('groupid'=>$gid['gid'],'uid'=>$v['uid'],'addtime'=>NOW_TIME,'lasttime'=>(NOW_TIME+$staytime*60)));
	                   if($k<$zan){
	                       $data = $this->kuaipai_db->kuaipai_zan($v['uid'],$gid);  //随机点赞
	                   }
	               }
	           }else if($v['createtime']>=($now-40*60) && $v['createtime']<($now-30*60)){  //30分钟-40分钟
	               $robts=array_slice($robts,0,C('drobtcount'));
	               $zan=mt_rand(count($robts)*C('min'),count($robts)*C('max'));  //随机赞数量
	               foreach ($robts as $k => $v){
	                   $return = $this->user_db->kuaipai_detail($v['uid'],$id); //浏览快拍
	                   $gid=M('group')->field('id')->where(array('name'=>$id))->find();
	                   $staytime=mt_rand(C('mintime'),C('maxtime'));     //在快拍里呆的时间
	                   M('group_user')->add(array('groupid'=>$gid['gid'],'uid'=>$v['uid'],'addtime'=>NOW_TIME,'lasttime'=>(NOW_TIME+$staytime*60)));
	                   if($k<$zan){
	                       $data = $this->kuaipai_db->kuaipai_zan($v['uid'],$gid);  //随机点赞
	                   }
	               }
	           }
	       }
	       
	    } 
	}
	function task2(){
	    //注册半个月内的新用户
	    $now=intval(NOW_TIME);
	    $time=$now-15*24*60*60;
	    $newuser=M('user')->where(array('createtime'=>array('EGT',$time),'usertype'=>0))->select();
	    foreach ($newuser as $k => $v){
	        //$kuaipai=M('kuaipai')->where(array('uid'=>$v['uid']))->select();
	        $robts=M('user')->where(array('usertype'=>1))->select();
	        shuffle($robts);//随机取到访问用户的机器人
	        //随机进入动态
	        $dynamic=M('dynamic')->where(array('uid'=>$v['uid']))->select();
	        foreach ($dynamic as $k => $v){
	            $id=$v['id'];
	            $uid=$v['uid'];
	            if($v['createtime']>=($now-24*60*60)){   //动态发布后一天内
	                $robts=array_slice($robts,0,C('arobtcount'));
	                $zan=mt_rand(count($robts)*C('min'),count($robts)*C('max'));  //随机赞数量
	                foreach ($robts as $k => $v){
	                    $return=$this->user_db->dynamic_detail($v['uid'],$id);   //浏览动态
	                    if($k<$zan){
	                        $return = $this->user_db->dynamiczan($v['uid'],$id);  //随机点赞
	                    }
	                }
	            }else if($v['createtime']>=($now-2*24*60*60) && $v['createtime']<($now-24*60*60)){   //动态发布后2天内
	                $robts=array_slice($robts,0,C('brobtcount'));
	                $zan=mt_rand(count($robts)*C('min'),count($robts)*C('max'));  //随机赞数量
	                foreach ($robts as $k => $v){
	                    $return=$this->user_db->dynamic_detail($v['uid'],$id);   //浏览动态
	                    if($k<$zan){
	                        $return = $this->user_db->dynamiczan($v['uid'],$id);  //随机点赞
	                    }
	                }
	            }else if($v['createtime']>=($now-3*24*60*60) && $v['createtime']<($now-2*24*60*60)){   //动态发布后3天内
	                $robts=array_slice($robts,0,C('crobtcount'));
	                $zan=mt_rand(count($robts)*C('min'),count($robts)*C('max'));  //随机赞数量
	                foreach ($robts as $k => $v){
	                    $return=$this->user_db->dynamic_detail($v['uid'],$id);   //浏览动态
	                    if($k<$zan){
	                        $return = $this->user_db->dynamiczan($v['uid'],$id);  //随机点赞
	                    }
	                }
	            }else if($v['createtime']>=($now-4*24*60*60) && $v['createtime']<($now-3*24*60*60)){   //动态发布后4天内
	                $robts=array_slice($robts,0,C('drobtcount'));
	                $zan=mt_rand(count($robts)*C('min'),count($robts)*C('max'));  //随机赞数量
	                foreach ($robts as $k => $v){
	                    $return=$this->user_db->dynamic_detail($v['uid'],$id);   //浏览动态
	                    if($k<$zan){
	                        $return = $this->user_db->dynamiczan($v['uid'],$id);  //随机点赞
	                    }
	                }
	            }
	        }
	    }
	    //异性机器人查看用户资料
	    $newuser=M('user')->where(array('usertype'=>0))->select();
	    foreach ($newuser as $k =>$v){
	        $fid=$v['uid'];
	        if($v['gender']==0){
	            $robts=M('user')->where(array('usertype'=>1,'gender'=>1))->select();
	            shuffle($robts);
	            $robts=array_slice($robts,0,5);
	            foreach ($robts as $k =>$v){
	                $this->user_db->dynamicGuest($v['uid'], $fid, 0);
	            }
	        }else if($v['gender']==1){
	            $robts=M('user')->where(array('usertype'=>1,'gender'=>0))->select();
	            shuffle($robts);
	            $robts=array_slice($robts,0,5);
	            foreach ($robts as $k =>$v){
	                $this->user_db->dynamicGuest($v['uid'], $fid, 0);
	            }
	        }
	    }
	    //检查是否开启自动浏览
	    /* $manage=M('manage')->where('ktype=1')->find();
	     if($manage){
	     return;
	     } */
	}
}