<?php
/**
 * 临时会话接口类
 * @author yangdong
 *
 */
namespace Session\Controller;
use Session\Model\SessionModel;
use Common\Api\Api;
class ApiController extends Api {
	private $session_db;
	private $sessionid;
	
	function _initialize() {
		parent::_initialize();
		$this->session_db = new SessionModel();
		$this->sessionid  = trim(I('sessionid', 0));
	}
	/**
	 * 检查会话是否存在
	 */
	private function isSession(){
	    if (!$this->session_db->where(array('id'=>$this->sessionid))->count()){
	        $data = showData(new \stdClass(), '该会话不存在或已删除', 1);
	        $this->jsonOutput($data);
	    }
	}
	/**
	 * 群列表
	 */
	function sessionLists(){
	    self::isLogin();
	    $data = $this->session_db->lists($this->mid);
	    $this->jsonOutput($data);
	}
	/**
	 * 创建会话并加人
	 */
	function add(){
	    self::isLogin();
		$return = $this->session_db->sessionAdd($this->mid);
		$this->jsonOutput($return);
	}
	/**
	 * 添加用户到会话
	 */
	function addUserToSession(){
	    self::isLogin();
	    self::isSession();
		$return = $this->session_db->addUser($this->mid, $this->sessionid);
		$this->jsonOutput($return);
	}
	/**
	 * 可加入的联系人列表
	 */
	function contactList(){
	    self::isLogin();
	    self::isSession();
		$return = $this->session_db->contactList($this->mid, $this->sessionid);
		$this->jsonOutput($return);
	}
	/**
	 * 会话详细
	 */
	function detail(){
		$return = $this->session_db->detail($this->mid, $this->sessionid);
		$this->jsonOutput($return);
	}
	/**
	 * 删除用户
	 */
	function remove(){
	    self::isLogin();
	    self::isSession();
		$fid    = $this->_initUser(I('fuid'));//要删除的用户
		$return = $this->session_db->removeUser($this->mid, $this->sessionid, $fid);
		$this->jsonOutput($return);
	}
	/**
	 * 退出会话
	 */
	function quit(){
	    self::isLogin();
	    self::isSession();
		$return = $this->session_db->quitSession($this->mid, $this->sessionid);
		$this->jsonOutput($return);
	}
	/**
	 * 编辑会话
	 */
	function edit(){
	    self::isLogin();
	    self::isSession();
		$return = $this->session_db->editSession($this->mid, $this->sessionid);
		$this->jsonOutput($return);
	}
	/**
	 * 设置是否接收消息
	 */
	function getmsg(){
	    self::isLogin();
	    self::isSession();
		$return = $this->session_db->getmsg($this->mid, $this->sessionid);
		$this->jsonOutput($return);
	}
	/**
	 * 修改群昵称
	 */
	function editNickname(){
	    self::isLogin();
	    self::isSession();
	    $return = $this->session_db->editNickname($this->mid, $this->sessionid);
	    $this->jsonOutput($return);
	}
	/**
	 * 管理删除会话
	 */
	function delete(){
	    self::isLogin();
	    self::isSession();
		$return = $this->session_db->deleteSession($this->mid, $this->sessionid);
		$this->jsonOutput($return);
	}
}