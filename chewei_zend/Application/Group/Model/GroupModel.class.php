<?php
namespace Group\Model;
use Think\Model;
use User\Model\UserModel;
use Lincense\Controller\Thinkchat;
class GroupModel extends Model {
	protected $tableName = 'group';
	protected $pk        = 'id';
	protected $groupUser = 'group_user';
	protected $tablePrefix;
	
	protected $map = array();
	function _initialize(){
		$this->tablePrefix = C('DB_PREFIX');
	}
	/**
	 * 群详细格式化
	 */
	private function _format($list, $uid=0){
		$_list = array();
		foreach ($list as $k=>$v){
			$tmp['id']		  	= $v['id'];
			$tmp['uid']		  	= $v['uid'];
			$tmp['creator']	  	= $v['creator'];
			$tmp['name']	  	= $v['name'];
			$tmp['logosmall'] 	= $v['logosmall'] ? (stristr($v['logosmall'], 'http://') ? $v['logosmall'] : SITE_PROTOCOL.SITE_URL.$v['logosmall']) : '';
			$tmp['logolarge'] 	= str_replace('/s_','/',$tmp['logosmall']);
			$tmp['extend']		= $v['extend'];
			$tmp['description']	= $v['description'];
			$tmp['count']	  	= $v['count'];
			
			if (is_null($v['role'])) {	//表示用户与这个群没有任何的关系
				$tmp['isjoin'] = 0;		//未加入群
				$tmp['role']   = -1;	//没有角色
				$tmp['getmsg'] = -1;	//没有加入群，所以不会接收消息
			}else {
				$tmp['isjoin'] = 1;				//加入了群
				$tmp['role']   = $v['role'];	//0-member 1-owner
				$tmp['getmsg'] = $v['getmsg'];	//0-不接收 1-接收
			}
			$tmp['createtime']= $v['createtime'];

			$_list[]	= $tmp;
		}
		return $_list;
	}
	/**
	 * 检查用户是否在群组中
	 */
	private function _checkisIngroup($groupid, $uid){
		$count = M( $this->groupUser )->where(array('groupid'=>$groupid, 'uid'=>$uid))->count();
		if ($count) {
			return true;
		}else {
			return false;
		}
	}
	/**
	 * 得到群创建者
	 */
	private function _getGroupCreater($groupid){
		return $this->where($this->map)->where(array('id'=>$groupid))->getField('uid');
	}
	/**
	 * 得到群组的name logo
	 */
	public function _getGroupNameLogo($groupid){
		return $this->field('id,uid,name,logosmall')->find($groupid);//群信息
	}
	/**
	 * 发送通知
	 * @param unknown $uid		发送者
	 * @param unknown $groupid	群组id
	 * @param unknown $type		通知类型
	 * @param unknown $fid		接收者
	 * @param string $content	内容
	 */
	function sendNotice($uid, $groupid, $type, $fid, $content=''){
		$thinkchat = new Thinkchat();
		$thinkchat->init(C('OP_SERVER'));
		$userModel = new UserModel();
		$user	   = $userModel->getUserName($uid);		//得到用户信息
		if ($uid == 'admin') $user = $userModel->systemUserName();
		$group	   = self::_getGroupNameLogo($groupid);	//得到群信息
		$to 	   = array('toid'=>$groupid, 'touid'=>$group['uid']);
		switch ($type){
			case 200:
				$content = '您创建的群['.$group['name'].']已通过审核';
				break;
			case 201:
				$content = '您创建的群['.$group['name'].']未能通过审核,原因：'.$content;
				break;
			case 202:
				$ctont	 = '用户['.$user['name'].']申请加入群['.$group['name'].']';
				if ($content) $content = $ctont.',理由：'.$content;
				$content = $ctont;
				break;
			case 203:
				$to['touid'] = $fid;
				$content = '您已通过加入群['.$group['name'].']的申请';
				break;
			case 204:
				$to['touid'] = $fid;
				$content = '群主拒绝了你加入群['.$group['name'].']的申请';
				break;
			case 205:
				$to['touid'] = $fid;
				$content = '群主['.$user['name'].']邀请您加入群['.$group['name'].']';
				break;
			case 206:
				$content = '用户['.$user['name'].']接受了你的邀请，加入了群['.$group['name'].']';
				break;
			case 207:
				$content = '用户['.$user['name'].']拒绝了加入了群['.$group['name'].']的邀请';
				break;
			case 208:
				$to['touid'] = $fid;
				$content = '你被群主从群['.$group['name'].']中踢出了';
				break;
			case 211:
				$to['touid'] = self::noticeToUsers($groupid);
				$content = '['.$user['name'].']被群主踢出了该群';
				break;
			case 209:
				$uids = self::noticeToUsers($groupid);
				if ($uids) {
					$uids .= $uids .','.$group['uid'];
				}else {
					$uids = $group['uid'];
				}
				$to['touid'] = $uids;
				$content = '用户['.$user['name'].']退出了群['.$group['name'].']';
				break;
			case 210:
				$to['touid'] = self::noticeToUsers($groupid);
				$content = '群主['.$user['name'].']解散了群['.$group['name'].']';
				break;
		}
		return $thinkchat->notice($user, $to, $type, $content, $group);
	}
	/**
	 * 接收通知的用户
	 * @param unknown $groupid
	 */
	function noticeToUsers($groupid){
		$uidsArr  = M($this->groupUser)->field('uid')->where(array('groupid'=>$groupid,'role'=>array('neq',1)))->select();
		$uids 	  = '';
		if ($uidsArr) {
			foreach ($uidsArr as $k=>$v){
				$uids .= $v['uid'].',';
			}
			$uids = substr($uids, 0, -1);
		}
		return $uids ? $uids : 0;
	}
	/**
	 * 公共群组列表
	 */
	private function _list($map,$uid){
		$map   = array_merge($map,$this->map);
		$total = $this->alias('g')->where($map)->count();
		if ($total){
			$page  = page($total);
			$limit = $page['offset'] . ',' . $page['limit'];
		}else {
			$page  = '';
		}
		$list  = $total ? $this->public_list($uid, $map, $limit) : array();
		return showData($list, '', 0, $page);
	}
	/**
	 * 群组公共列表
	 */
	public function public_list($uid, $map, $limit, $order='createtime desc'){
		$creator  = '(SELECT name FROM '.$this->tablePrefix.'user WHERE uid=g.uid) as creator';
		$mbCount  = '(SELECT count(*) FROM `'.$this->tablePrefix.$this->groupUser.'` WHERE groupid=g.id) as count';
		$join     = 'left join `'.$this->tablePrefix.$this->groupUser.'` gu on gu.groupid=g.id and gu.uid='.$uid;
		$field    = 'g.*, gu.getmsg, gu.role,'.$creator.','.$mbCount;
		$list  	  = $this->alias('g')->field($field)->where($map)->join($join)->order($order)->limit($limit)->select();
		$_list 	  = $this->_format($list,$uid);
		if ($limit == 1) {
			return $_list['0'];
		}else {
			return $_list;
		}
	}
	/**
	 *  群组审核
	 * @param unknown $data
	 * @param number $type =200 201通知类型
	 * @return array
	 */
	public function groupAudit($data,$type=200){
		$audit 	   = $data['audit'];	//审核状态
		$groupid   = $data['groupid'];	//群组id
		$creatorid = self::_getGroupCreater($groupid);
		//do something
	}
	/**
	 * 群详细
	 */
	public function groupDetail($id,$uid){
		$map['id'] 		= $id;
		$map  			= array_merge($map,$this->map);
		$info 			= $this->public_list($uid, $map, 1);
		$groupUserList  = $this->groupUserList($id);
		$info['list']   = $groupUserList['data'];
		$uids = '';
		if ($info['list']) {
			foreach ($info['list'] as $k=>$v){
				$uids .= $v['uid'] . ',';
			}
			$uids = substr($uids, 0, -1);
		}
		$info['uids'] = $uids;
		return showData($info);
	}
	/**
	 * 创建群组
	 * @param number $uid
	 * @param unknown $isAdd
	 * @param unknown $data
	 * @return array
	 */
	public function groupAdd($uid=0, $isAdd=1, $data=array()){
		if (!$data) {
			$logosmall = '';
			if (!empty($_FILES)) {
				$image = upload('/Picture/group/', 0, 'group');
				if (is_array($image)) {
					$logosmall = $image['0']['smallUrl'];
				}else {
					return showData(new \stdClass(), $image, 1);
				}
			}
			$data = array(
				'uid'			=> $uid,
				'name'			=> I('name'),
				'logosmall' 	=> $logosmall,
				'description'	=> I('description',''),
 				'extend'		=> I('extend', '', ''),
				'createtime'	=> NOW_TIME,
			);
		}
		if (!$data['name']) return showData(new \stdClass(), '请输入群名称', 1);
		
		$groupid = $this->add($data);
		if ($groupid) {
			if ($isAdd) {
				$group = array('groupid' => $groupid,'uid' => $uid,'addtime' => NOW_TIME,'role' => 1);
				M($this->groupUser)->add($group);
			}
			//return showData(new \stdClass(), '创建成功');
			return self::groupDetail($groupid, $uid);
		}else {
			return showData(new \stdClass(), '创建失败', 1);
		}
	}
	/**
	 * 搜索群
	 */
	public function groupSearch($uid){
		$name  = I('search');
		if ($name) {
			$map['name'] = array('like', '%'.$name.'%');
			return $this->_list($map,$uid);
		}else {
			return showData(new \stdClass(), '请输入搜索名称', 1);
		}
	}
	/**
	 * 用户的群列表 包括创建的和加入的
	 */
	public function groupList($uid){
		/* //我创建的群
		$mapCreate['g.uid'] = $uid;
		$myCreate  = $this->public_list($uid, $mapCreate, 0);
		$data['0'] = array('title'=>'加入的群','group'=>$myCreate);
		//我加入的群
		$mapJoin['_string'] = 'g.id in(select groupid from '.$this->tablePrefix.$this->groupUser.' where uid='.$uid.' and role<>1)';
		$myJoin    = $this->public_list($uid, $mapJoin, 0);
		$data['1'] = array('title'=>'创建的群','group'=>$myJoin);
		return showData($data); */
		
		$mapJoin['_string'] = 'g.id in(select groupid from '.$this->tablePrefix.$this->groupUser.' where uid='.$uid.')';
		$myJoin    = $this->public_list($uid, $mapJoin, 0);
		foreach ($myJoin as $k=>$v){
			$myJoin[$k]['uids'] = self::groupUserList($v['id'], 1);
		}
		return showData($myJoin);
	}
	/**
	 * 群成员列表
	 */
	public function groupUserList($groupid, $ids=0){
		$map['_string'] = 'uid in(SELECT uid from '.$this->tablePrefix.$this->groupUser.' where groupid='.$groupid.')';
		$total = M('user')->where($map)->count();
		if ($total){
			$page  = page($total);
			$limit = $page['offset'] . ',' . $page['limit'];
		}else {
			$page  = '';
		}
		$list = $total ? M('user')->field('uid,name,head,extend')->where($map)->limit($limit)->select() : array();
		if ($ids) {
			$uids = '';
			foreach ($list as $k=>$v){
				$uids .= $v['uid'] . ',';
			}
			$uids = substr($uids, 0, -1);
			return $uids;
		}
		return showData($list, '', 0, $page);
	}
	/**
	 * 群组邀请列表
	 * @param int $uid
	 * @param int $groupid
	 */
	public function groupInviteUserList($uid, $groupid){
		$map['_string'] = '(uid IN (SELECT fid FROM '.$this->tablePrefix.'user_friend WHERE uid='.$uid.')) and (uid NOT IN (SELECT uid from '.$this->tablePrefix.$this->groupUser.' where groupid='.$groupid.'))';
		$total = M('user')->where($map)->count();
		$list = $total ? M('user')->field('uid,name,head,extend')->where($map)->select() : array();
		return showData($list);
	}
	/**
	 * 申请加入群
	 * @param unknown $uid
	 * @param unknown $groupid
	 * @param number $type=202 通知类型
	 * @return array
	 */
	public function apply($uid, $groupid, $type=202){
		$group  = $this->_checkisIngroup($groupid, $uid);
		if ($group) {
			return showData(new \stdClass(), '您已加入了该群！', 1);
		}else {
			if (self::sendNotice($uid, $groupid, $type, 0)) {
				return showData(new \stdClass(), '申请成功，请等待处理！');
			}else {
				return showData(new \stdClass(), '申请失败，请稍侯再试！');
			}
		}
	}
	/**
	 * 同意申请加入群
	 * @param unknown $fid  申请用户
	 * @param unknown $groupid
	 * @param number $type=203 通知类型
	 * @return array
	 */
	public function agreeApply($uid, $fid, $groupid, $type=203){
		$group  = $this->_checkisIngroup($groupid, $fid);
		if ($group) {
			return showData(new \stdClass(), '您已加入了该群！', 1);
		}else {
			$data = array('groupid' => $groupid,'uid' => $fid,'addtime' => NOW_TIME);
			if (M($this->groupUser)->add($data)) {
				if (self::sendNotice($uid, $groupid, $type, $fid)) {
					return showData(new \stdClass(), '添加成功');
				}else {
					return showData(new \stdClass(), '添加失败', 1);
				}
			}else {
				return showData(new \stdClass(), '添加失败', 1);
			}
		}
	}
	/**
	 * 不同意加入群
	 * @param unknown $fid 申请用户
	 * @param unknown $groupid
	 * @param number $type=204通知类型
	 * @return array
	 */
	public function disagreeApply($uid,  $fid, $groupid, $type=204){
		if (self::sendNotice($uid, $groupid, $type, $fid)) {
			return showData(new \stdClass(), '处理成功');
		}else {
			return showData(new \stdClass(), '处理失败', 1);
		}
	}
	/**
	 * 邀请加入群
	 * @param unknown $fid	被邀请用户
	 * @param unknown $groupid
	 * @param number $type=205 通知类型
	 * @return array
	 */
	public function invite($uid, $fid, $groupid, $type=205){
		$group  = $this->_checkisIngroup($groupid, $fid);
		if ($group) {
			return showData(new \stdClass(), '该用户已加入了该群！', 1);
		}else {
			if (self::sendNotice($uid, $groupid, $type, $fid)) {
				return showData(new \stdClass(), '邀请成功，请等待对方的同意');
			}else {
				return showData(new \stdClass(), '邀请失败，请稍侯再试！');
			}
		}
	}
	/**
	 * 同意邀请
	 * @param unknown $uid 被邀请者，即当前用户
	 * @param unknown $groupid
	 * @param number $type=206 通知类型
	 * @return array
	 */
	public function agreeInvite($uid, $groupid, $type=206){
		$group  = $this->_checkisIngroup($groupid, $uid);
		if ($group) {
			return showData(new \stdClass(), '您已加入了该群！', 1);
		}else {
			$data = array('groupid' => $groupid,'uid' => $uid,'addtime' => NOW_TIME);
			if (M($this->groupUser)->add($data)) {
				if (self::sendNotice($uid, $groupid, $type, 0)) {
					return showData(new \stdClass(), '加入成功');
				}else {
					return showData(new \stdClass(), '加入失败', 1);
				}
			}else {
				return showData(new \stdClass(), '加入失败', 1);
			}
		}
	}
	/**
	 * 不同意邀请
	 * @param unknown $uid
	 * @param unknown $groupid
	 * @param number $type=207 通知类型
	 * @return array
	 */
	public function disagreeInvite($uid, $groupid, $type=207){
		if (self::sendNotice($uid, $groupid, $type, 0)) {
			return showData(new \stdClass(), '处理成功');
		}else {
			return showData(new \stdClass(), '处理失败', 1);
		}
	}
	/**
	 * 管理员移除群组成员
	 * @param unknown $uid
	 * @param unknown $groupid
	 * @param unknown $fid
	 * @param number $type=208 通知类型
	 * @return array
	 */
	function removeUser($uid, $groupid, $fid, $type=208){
		$creator = self::_getGroupCreater($groupid);
		if ($creator == $uid) {
			if ($uid == $fid) return showData(new \stdClass(), '你是群主,不能删除自己', 1);
			self::sendNotice($uid, $groupid, $type, $fid);
			if (M( $this->groupUser )->where(array('uid'=>$fid, 'groupid'=>$groupid))->delete()) {
				self::sendNotice($uid, $groupid, $type+3, 0);
				return showData(new \stdClass(), '移除成功');
			}else {
				return showData(new \stdClass(), '移除失败，请稍侯再试', 1);
			}
		}else {
			return showData(new \stdClass(), '您不是管理员，不能移除成员', 1);
		}
	}
	/**
	 * 退出群
	 * @param unknown $uid
	 * @param unknown $groupid
	 * @return array $type=209 通知类型
	 */
	function quitGroup($uid, $groupid, $type=209){
		$creator = self::_getGroupCreater($groupid);
		if ($creator == $uid) {
			return showData(new \stdClass(), '您是管理员，不能退出该群', 1);
		}else {
			if (M( $this->groupUser )->where(array('uid'=>$uid, 'groupid'=>$groupid))->delete()) {
				self::sendNotice($uid, $groupid, $type, 0);
				return showData(new \stdClass(), '你已成功退出该群');
			}else {
				return showData(new \stdClass(), '退出部落失败，请稍侯再试');
			}
		}
	}
	/**
	 * 管理员删除群
	 * @param int $uid
	 * @param int $sessionid
	 * @param int $type=210 通知类型
	 */
	function deleteGroup($uid, $groupid, $type=210){
		$creator = self::_getGroupCreater($groupid);
		if ($creator == $uid) {
			self::sendNotice($uid, $groupid, $type, 0);
			if ($this->delete($groupid)) {
				M($this->groupUser)->where(array('groupid'=>$groupid))->delete();//删除成员表
				M('message')->where(array('typechat'=>200,'toid'=>$groupid))->delete();//删除消息
				return showData(new \stdClass(), '删除成功');
			}else {
				return showData(new \stdClass(), '删除失败', 1);
			}
		}else {
			return showData(new \stdClass(), '你不是管理员，不能删除临时会话', 1);
		}
	}
	/**
	 * 编辑群资料
	 * @param unknown $uid
	 * @param unknown $groupid
	 */
	function editGroup($uid, $groupid, $type=212){
		$logosmall = I('logosmall', '');
		if (!empty($_FILES)) {
			$image = upload('/Picture/group/', 0, 'group');
			if (is_array($image)) {
				$logosmall = $image['0']['smallUrl'];
			}else {
				return showData(new \stdClass(), $image, 1);
			}
		}
		$data = array();
		if ($logosmall) $data['logosmall'] = $logosmall;
		if (I('name')) $data['name'] = I('name');
		if (I('extend')) $data['extend'] = I('entend');
		if (I('description')) $data['description'] = I('description');
		if (count($data)) {
			if ($this->where(array('id'=>$groupid))->save($data)) {
				return showData(new \stdClass(), '修改成功');
			}else {
				return showData(new \stdClass(), '修改失败', 1);
			}
		}else {
			return showData(new \stdClass(), '你什么都没有填写', 1);
		}
	}
	/**
	 * 设置是否接收消息
	 * @param unknown $uid
	 * @param unknown $groupid
	 */
	function getmsg($uid, $groupid){
		$getmsg = I('getmsg', 0);
		if (M($this->groupUser)->where(array('uid'=>$uid, 'groupid'=>$groupid))->setField('getmsg', $getmsg)) {
			return showData(new \stdClass(), '设置成功');
		}else {
			return showData(new \stdClass(), '设置失败', 1);
		}
	}
	
	/**
	 * 直接删除群成员
	 * @param unknown $groupid
	 * @param unknown $fid
	 * @return Ambigous <multitype:, multitype:unknown \Org\Util\string number >
	 */
	function removeWithoutNotice($groupid, $fid){
		if (M( $this->groupUser )->where(array('uid'=>$fid, 'groupid'=>$groupid))->delete()) {
			return showData(new \stdClass(), '移除成功');
		}else {
			return showData(new \stdClass(), '移除失败，请稍侯再试', 1);
		}
	}
	
	/**
	 * 直接添加群成员
	 * @param unknown $groupid
	 * @param unknown $fid
	 */
	function addUserWithoutNotice($groupid, $fid){
		$data = array('groupid' => $groupid,'uid' => $fid,'addtime' => NOW_TIME);
		if (M($this->groupUser)->add($data)) {
			return showData(new \stdClass(), '添加成功');
		}else {
			return showData(new \stdClass(), '添加失败', 1);
		}
	}
}