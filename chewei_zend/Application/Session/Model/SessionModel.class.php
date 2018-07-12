<?php
/**
 * 临时会话
 * @author yangdong
 *
 */
namespace Session\Model;
use Think\Model;
use User\Model\UserModel;
use Lincense\Controller\Thinkchat;
class SessionModel extends Model {
	protected $tableName 	= 'session';
	protected $pk        	= 'id';
	protected $sessionUser  = 'session_user';
	protected $tablePrefix;
	
	function _initialize(){
		$this->tablePrefix	= C('DB_PREFIX');
	}
	/**
	 * 临时会话数据格式化
	 * @param unknown $list
	 * @param number $uid
	 */
	private function _format($list, $uid=0){
		$_list = array();
		if ($list) {
			foreach ($list as $k=>$v){
				$tmp['id']			= $v['id'];
				$tmp['name']		= $v['name'];
				$tmp['count']	    = $v['count'];
				$tmp['uid']			= $v['uid'];
				$tmp['creator']	    = $v['creator'];
				
				if (isset($v['role'])) {
					if (is_null($v['role'])) {	//表示用户与这个群没有任何的关系
						$tmp['isjoin'] = 0;		//未加入群
						$tmp['role']   = -1;	//没有角色
						$tmp['getmsg'] = -1;	//没有加入群，所以不会接收消息
					}else {
						$tmp['isjoin'] = 1;				//加入了群
						$tmp['role']   = $v['role'];	//0-member 1-owner
						$tmp['getmsg'] = $v['getmsg'];	//0-不接收 1-接收
					}
				}
				
				$tmp['createtime']  = $v['createtime'];
				
				$_list[] = $tmp;
			}
		}
		return $_list;
	}
	/**
	 * 获取当前用户是否是创建者
	 * @param unknown $uid
	 * @param unknown $sessionid
	 */
	private function _checkisSessionCreator($uid, $sessionid){
		return M($this->sessionUser)->where(array('sessionid'=>$sessionid, 'uid'=>$uid))->getField('role');
	}
	/**
	 * 临时会话会话列表
	 * @param unknown $uid
	 * @param unknown $map
	 * @param unknown $limit
	 * @param string $order
	 */
	function public_list($uid, $map, $limit, $order='createtime desc'){
		$creator  = '(SELECT name FROM `'.$this->tablePrefix.'user` WHERE uid=s.uid) as creator';
		$mbCount  = '(SELECT count(*) FROM `'.$this->tablePrefix.$this->sessionUser.'` WHERE sessionid=s.id) as count';
		$join     = 'left join `'.$this->tablePrefix.$this->sessionUser.'` su on su.sessionid=s.id and su.uid='.$uid;
		$field    = 's.*, su.getmsg, su.role,'.$creator.','.$mbCount;
		$list  	  = $this->alias('s')->field($field)->where($map)->join($join)->order($order)->limit($limit)->select();
		$_list 	  = $this->_format($list,$uid);
		if ($limit == 1) {
			return $_list['0'];
		}else {
			return $_list;
		}
	}
	/**
	 * 添加用户进入到会话
	 * @param int $sessionid;
	 * @param boolean
	 */
	private function addUserToSession($sessionid, $uids){
		$uidsArr = explode(',', $uids);
		$uidsArr = array_unique($uidsArr);
		$data    = array();
		foreach ($uidsArr as $v){
			if ($v && !M($this->sessionUser)->where(array('sessionid'=>$sessionid, 'uid'=>$v))->count()) {
				$data[] = array(
					'sessionid'  => $sessionid,
					'uid'		 => $v,
					'addtime'	 => NOW_TIME,
				);
			}
		}
		if ($data) {
			if (M($this->sessionUser)->addAll($data)) {
				return true;
			}else {
				return false;
			}
		}else {
			return true;
		}
	}
	/**
	 * 发送通知
	 * @param unknown $uid
	 * @param unknown $id
	 * @param unknown $type
	 * @param unknown $content
	 */
	private function sendNotice($uid, $id, $type, $fid=0){
		$thinkchat = new Thinkchat();
		$thinkchat->init(C('OP_SERVER'));
		
		$user	    = new UserModel();
		$userinfo   = $user->getUserName($uid);//得到用户资料
		$to['toid'] = $id;
		$room 	 	= $this->field('id,name')->where(array('id'=>$id))->find();
		switch ($type) {
			case 300:
				$to['touid'] = self::noticeToUsers($id);
				$thinkchat->notice($userinfo, $to, $type, $userinfo['name'].'退出了该会话', $room);
				break;
			case 301:
				$to['touid'] = $fid;
				$thinkchat->notice($userinfo, $to, $type, '你被管理员踢出了该会话', $room);
				break;
			case 302:
				$to['touid'] = self::noticeToUsers($id);
				$thinkchat->notice($userinfo, $to, $type, '管理员'.$userinfo['name'].'修改了会话名称为:'.$room['name'], $room);
				break;
			case 303:
				$to['touid'] = self::noticeToUsers($id);
				$thinkchat->notice($userinfo, $to, $type, '管理员'.$userinfo['name'].'解散了该会话', $room);
				break;
			case 304:
				$to['touid'] = self::noticeToUsers($id);
				$fuserinfo   = $user->getUserName($fid);
				$thinkchat->notice($fuserinfo, $to, $type, $fuserinfo['name'].'被管理员踢出了该会话', $room);
				break;
		}
	}
	/**
	 * 根据群id获取发送通知到相应的用户
	 */
	function noticeToUsers($id){
		$uidsArr  = M($this->sessionUser)->field('uid')->where(array('sessionid'=>$id,'role'=>array('neq',1)))->select();
		$uids 	  = '';
		if ($uidsArr) {
			foreach ($uidsArr as $k=>$v){
				$uids .= $v['uid'].',';
			}
			$uids = substr($uids, 0, -1);
		}
		return $uids;
	}
	/**
	 * 创建临时会话
	 * @param int $uid;
	 */
	function sessionAdd($uid){
		$uids = I('uids');
		$data = array(
			'uid'			=> $uid,
			'name'			=> I('name'),
			'createtime'	=> NOW_TIME,
		);
		if (!$data['name']) return showData(new \stdClass(), '请输入会话名称', 1);
		if (!$uids) return showData(new \stdClass(), '请选择用户', 1);
		$sessionid = $this->add($data);
		if ($sessionid) {
			if (self::addUserToSession($sessionid, $uids)){
				//把自己也加入 并且是创建者
				$where = array('sessionid'=>$sessionid, 'uid'=>$uid);
				if (M($this->sessionUser)->where($where)->count()) {
					M($this->sessionUser)->where($where)->setField('role', 1);
				}else {
					$where['addtime']	= NOW_TIME;
					$where['role']		= 1;
					M($this->sessionUser)->add($where);
				}
				return self::detail($uid, $sessionid);
			}else {
				$this->delete($sessionid);//删除会话
				M($this->sessionUser)->where(array('sessionid'=>$sessionid))->delete();//删除部份加入的人
				return showData(new \stdClass(), '创建会话失败', 1);
			}
		}else {
			return showData(new \stdClass(), '创建会话失败', 1);
		}
	}
	/**
	 * 添加用户到临时会话
	 */
	function addUser($uid, $sessionid){
		if (self::_checkisSessionCreator($uid, $sessionid)) {
			$uids = I('uids');
			if (!$uids) return showData(new \stdClass(), '请选择用户', 1);
			if (self::addUserToSession($sessionid, $uids)) {
				return showData(new \stdClass(), '添加成功');
			}else {
				return showData(new \stdClass(), '添加失败', 1);
			}
		}else {
			return showData(new \stdClass(), '你不是管理员不能添加成员', 1);
		}
	}
	/**
	 * 临时会话详细
	 * @param unknown $uid
	 * @param unknown $sessionid
	 */
	function detail($uid, $sessionid){
		$map['s.id'] = $sessionid;
		$info = self::public_list($uid, $map, 1);
		$user = new UserModel();
		$where['_string'] = 'u.uid IN (SELECT uid from `'.$this->tablePrefix.$this->sessionUser.'` where sessionid='.$sessionid.')';
		$info['list'] = $user->public_list($uid, $where, 0);
		return showData($info);
	}
	/**
	 * 可选联系人列表
	 * @param unknown $uid
	 * @param unknown $sessionid
	 * @return array
	 */
	function contactList($uid, $sessionid){
		$user 	= new UserModel();
		$string = 'u.uid NOT IN (SELECT uid from `'.$this->tablePrefix.$this->sessionUser.'` where sessionid='.$sessionid.')';
		return $user->friendlist($uid, $string);
		
	}
	/**
	 * 退出会话
	 * @param int $uid 当前登陆用户
	 * @param int $session 会话id
	 * @param int type 通知类型
	 */
	function quitSession($uid, $sessionid, $type=300){
		if (self::_checkisSessionCreator($uid, $sessionid)) {
			return showData(new \stdClass(), '你是管理员,不能退出', 1);
		}else {
			if (M($this->sessionUser)->where(array('uid'=>$uid, 'sessionid'=>$sessionid))->delete()){
				self::sendNotice($uid, $sessionid, $type);//发送通知
				return showData(new \stdClass(), '退出成功');
			}else {
				return showData(new \stdClass(), '退出失败', 1);
			}
		}
	}
	/**
	 * 删除用户
	 * @param int $uid
	 * @param int $sessionid
	 * @param int $type=31 通知类型
	 */
	function removeUser($uid, $sessionid, $fid, $type=301){
		if (self::_checkisSessionCreator($uid, $sessionid)) {
			if ($uid == $fid) return showData(new \stdClass(), '你是管理员,不能删除自己', 1);
			
			self::sendNotice($uid, $sessionid, $type, $fid);//发送通知
			
			if (M($this->sessionUser)->where(array('uid'=>$fid, 'sessionid'=>$sessionid))->delete()){
				self::sendNotice($uid, $sessionid, $type+3, $fid);//发送通知
				
				return showData(new \stdClass(), '删除用户成功');
			}else {
				return showData(new \stdClass(), '删除失败', 1);
			}
		}else {
			return showData(new \stdClass(), '你不是管理员不能删除成员', 1);
		}
	}
	/**
	 * 编辑会话
	 * @param int $uid
	 * @param int $sessionid
	 * @param int $type=32 通知类型
	 */
	function editSession($uid, $sessionid, $type=302){
		if (self::_checkisSessionCreator($uid, $sessionid)) {
			$name = I('name');
			if (!$name) return showData(new \stdClass(), '请输入要修改的会话名称', 1);
			if ($this->where(array('id'=>$sessionid))->setField('name', $name)) {
				self::sendNotice($uid, $sessionid, $type);//发送通知
				return showData(new \stdClass(), '修改成功');
			}else {
				return showData(new \stdClass(), '修改失败', 1);
			}
		}else {
			return showData(new \stdClass(), '你不是管理员,不能编辑会话名称', 1);	
		}
	}
	/**
	 * 设置消息是否接收
	 * @param unknown $uid
	 * @param unknown $sessionid
	 */
	function getmsg($uid, $sessionid){
		$getmsg = I('getmsg', 0);
		if (M($this->sessionUser)->where(array('uid'=>$uid, 'sessionid'=>$sessionid))->setField('getmsg', $getmsg)) {
			return showData(new \stdClass(), '设置成功');
		}else {
			return showData(new \stdClass(), '设置失败', 1);
		}
	}
	/**
	 * 管理员删除会话
	 * @param int $uid
	 * @param int $sessionid
	 * @param int $type=33 通知类型
	 */
	function deleteSession($uid, $sessionid, $type=303){
		if (self::_checkisSessionCreator($uid, $sessionid)) {
			$name = $this->where(array('id'=>$sessionid))->getField('name');
			self::sendNotice($uid, $sessionid, $type);//发送通知
			if ($this->delete($sessionid)) {
				M($this->sessionUser)->where(array('sessionid'=>$sessionid))->delete();//删除成员表
				M('message')->where(array('typechat'=>300,'toid'=>$sessionid))->delete();//删除消息
				return showData(new \stdClass(), '删除成功');
			}else {
				return showData(new \stdClass(), '删除失败', 1);
			}
		}else {
			return showData(new \stdClass(), '你不是管理员，不能删除临时会话', 1);
		}
	}
}