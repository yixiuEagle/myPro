<?php
namespace Message\Controller;
use Message\Model\MessageModel;
use Common\Api\Api;
use Think\Log;

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
		/* $input_data = json_decode(file_get_contents('php://input'), true);
		Log::write("input result=" . json_encode($input_data)); */
		
		if (!empty($_FILES)) {
			Log::write("check the file");
		}
		
		
		//Log::write("ApiController sendMessage, post=" . json_encode($_REQUEST));
	    //self::isLogin();
		$return = $this->message_db->message($this->mid);
		//Log::write("ApiController sendMessage, return=" . json_encode($return));
		$this->jsonOutput($return);
	}
	
	/**
	 * 上传文件
	 */
	function uploadFile(){
	
		Log::write("ApiController sendMessage, post=" . json_encode($_REQUEST));
		//self::isLogin();
		$return = $this->message_db->uploadFile($this->mid,5);
		$this->jsonOutput($return);
	}
	function uploadImage(){
	
		Log::write("ApiController sendMessage, post=" . json_encode($_REQUEST));
		//self::isLogin();
		$return = $this->message_db->uploadFile($this->mid,2);
		$this->jsonOutput($return);
	}
	function uploadVoice(){
	
		Log::write("ApiController sendMessage, post=" . json_encode($_REQUEST));
		//self::isLogin();
		$return = $this->message_db->uploadFile($this->mid,3);
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