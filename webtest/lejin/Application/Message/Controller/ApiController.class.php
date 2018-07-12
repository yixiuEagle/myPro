<?php
namespace Message\Controller;
use Message\Model\MessageModel;
use Common\Api\Api;
class ApiController extends Api {

	private $message_db;
	function _initialize() {
		parent::_initialize();
		$this->message_db 	= new MessageModel();
	}
	/**
	 * 发送消息
	 */
	function sendMessage(){
	    self::isLogin();
		$return = $this->message_db->message($this->mid);
		$this->jsonOutput($return);
	}
	
	/**
	 * 发送通知-单个用户 批量用户 群用户 临时会话用户
	 */
	function sendNotice(){
		$return = $this->message_db->sendNotice();
		$this->jsonOutput($return);
	}
}