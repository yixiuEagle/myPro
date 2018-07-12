<?php
/**
 * 群组API控制器
 * @author yangdong
 * 
 */
namespace Group\Controller;
use Group\Model\GroupModel;
use Common\Api\Api;
class ApiController extends Api {
	private $group_db;
	private $groupid;
	function _initialize(){
		parent::_initialize();
		$this->group_db= new GroupModel();
		$this->groupid = I('groupid', 0);
	}
	
	/**
	 * 检查群是否存在
	 */
	private function isGroup(){
	    if (!$this->group_db->where(array('id'=>$this->groupid))->count()){
	        $data = showData(new \stdClass(), '该群不存在', 1);
	        $this->jsonOutput($data);
	    }
	}
	/**
	 * 群组详细1
	 */
	function detail(){
		self::isLogin();
		self::isGroup();
		$return = $this->group_db->groupDetail($this->groupid, $this->mid);
		$this->jsonOutput($return);
	}
	/**
	 * 创建群组2
	 */
	function add(){
		self::isLogin();
		$return = $this->group_db->groupAdd($this->mid);
		$this->jsonOutput($return);
	}
	/**
	 * 搜索群3
	 */
	function search(){
		self::isLogin();
		$return = $this->group_db->groupSearch($this->mid);
		$this->jsonOutput($return);
	}
	/**
	 * 用户的群组列表4
	 */
	function groupList(){
		self::isLogin();
		$return = $this->group_db->groupList($this->mid);
		$this->jsonOutput($return);
	}
	/**
	 * 获取群组的用户列表5
	 */
	function groupUserList(){
		self::isLogin();
		self::isGroup();
		$return = $this->group_db->groupUserList($this->groupid);
		$this->jsonOutput($return);
	}
	/**
	 * 群组可邀请的用户列表6
	 */
	function groupInviteUserList(){
		self::isLogin();
		self::isGroup();
		$return = $this->group_db->groupInviteUserList($this->mid, $this->groupid);
		$this->jsonOutput($return);
	}
	/**
	 * 申请加入群组7
	 */
	function apply(){
		self::isLogin();
		self::isGroup();
		$return = $this->group_db->apply($this->mid, $this->groupid);
		$this->jsonOutput($return);
	}
	/**
	 * 群主同意申请用户加入群8
	 * @param $fid 申请用户
	 */
	function agreeApply(){
		self::isLogin();
		self::isGroup();
		$fid 	= $this->_initUser(I('fuid'));
		$return = $this->group_db->agreeApply($this->mid, $fid, $this->groupid);
		$this->jsonOutput($return);
	}
	/**
	 * 群主不同意申请用户加入群9
	 * @param $fid 申请用户
	 */
	function disagreeApply(){
		self::isLogin();
		self::isGroup();
		$fid 	= $this->_initUser(I('fuid'));
		$return = $this->group_db->disagreeApply($this->mid, $fid, $this->groupid);
		$this->jsonOutput($return);
	}
	/**
	 * 群主邀请用户加入群10
	 * @param $fid 被邀请用户
	 */
	function invite(){
		self::isLogin();
		self::isGroup();
		$fid 	= $this->_initUser(I('fuid'));
		$return = $this->group_db->invite($this->mid, $fid, $this->groupid);
		$this->jsonOutput($return);
	}
	/**
	 * 被邀请用户同意邀请
	 * @param $uid 当前用户即被邀请用户
	 */
	function agreeInvite(){
		self::isLogin();
		self::isGroup();
		$reurn = $this->group_db->agreeInvite($this->mid, $this->groupid);
		$this->jsonOutput($reurn);
	}
	/**
	 * 被邀请用户不同意邀请入群
	 * @param $uid 当前用户即被邀请用户
	 */
	function disagreeInvite(){
		self::isLogin();
		self::isGroup();
		$return = $this->group_db->disagreeInvite($this->mid, $this->groupid);
		$this->jsonOutput($return);
	}
	/**
	 * 管理员移除成员
	 */
	function remove(){
		self::isLogin();
		self::isGroup();
		$fid 	= $this->_initUser(I('fuid'));
		$return = $this->group_db->removeUser($this->mid, $this->groupid, $fid);
		$this->jsonOutput($return);
	}
	/**
	 * 退出群组
	 */
	function quit(){
		self::isLogin();
		self::isGroup();
		$return = $this->group_db->quitGroup($this->mid, $this->groupid);
		$this->jsonOutput($return);
	}
	/**
	 * 管理员删除群
	 */
	function delete(){
		self::isLogin();
		self::isGroup();
		$return = $this->group_db->deleteGroup($this->mid, $this->groupid);
		$this->jsonOutput($return);
	}
	/**
	 * 编辑群资料
	 */
	function edit(){
		self::isLogin();
		self::isGroup();
		$return = $this->group_db->editGroup($this->mid, $this->groupid);
		$this->jsonOutput($return);
	}
	/**
	 * 设置是否接收群消息
	 */
	function getmsg(){
		self::isLogin();
		self::isGroup();
		$return = $this->group_db->getmsg($this->mid, $this->groupid);
		$this->jsonOutput($return);
	}
	
	/**
	 * 直接删除群成员
	 */
	function removeWithoutNotice() {
	    self::isLogin();
	    self::isGroup();
		$fid 	= $this->_initUser(I('fuid'));
		$return = $this->group_db->removeWithoutNotice($this->groupid, $fid);
		$this->jsonOutput($return);
	}
	
	/**
	 * 直接添加群成员
	 */
	function addUserWithoutNotice() {
	    self::isLogin();
	    self::isGroup();
		$fid 	= $this->_initUser(I('fuid'));
		$return = $this->group_db->addUserWithoutNotice($this->groupid, $fid);
		$this->jsonOutput($return);
	}

    /**
     * 群类别列表
     */
	function groupCatList(){
        self::isLogin();
        $follow = I('follow',0);
        $return = $this->group_db->groupCatList($this->mid,$follow);
        $this->jsonOutput($return);
    }

    /**
     * 关注群
     */
    function follow(){
        self::isLogin();
        self::isGroup();
        $type = I('type',0);
        $return = $this->group_db->follow($this->mid,$this->groupid,$type);
        $this->jsonOutput($return);
    }

    /**
     * 类别下的群列表
     */
    function catGroupList(){
        self::isLogin();
        $cat_id = I('cat_id',0);
        //$type = I('type',0);
        $return = $this->group_db->catGroupList($this->mid,$cat_id);
        $this->jsonOutput($return);
    }

    /**
     *  我创建的群列表
     */
    function createGroupList(){
        self::isLogin();
        $uid = I('uid',0);
        $fuid = I('fuid',0);
        $return = $this->group_db->createGroupList($this->mid,$fuid);
        $this->jsonOutput($return);
    }
    /**
     *  所有群及空间号（除自己所建的）
     */
    function allGrouplist(){
        self::isLogin();
        $uid = I('uid',0);
        $return = $this->group_db->allGrouplist($this->mid);
        $this->jsonOutput($return);
    }

    /**
     *  获取群组消息记录
     */
    function getGroupMessage(){
        self::isLogin();
        $return = $this->group_db->getGroupMessage($this->groupid);
        $this->jsonOutput($return);
    }
	
	function sendNotice() {
		$uid = I('uid', 0);
		$toUser = I('touser', '');
		$groupid = I('groupid', 0);
		$type = I('type', 0);
		$content = I('content', '');
		
		
		$return = $this->group_db->sendNotice($uid, $toUser, $groupid, $type, $content);
		$this->jsonOutput($return);
	}
	
}