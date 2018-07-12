<?php
namespace Group\Model;
use Lincense\Controller\Thinkchat;
use Think\Model;
use User\Model\UserModel;
class GroupModel extends UserModel {
	public  $tableName = 'group';
	public $pk        = 'id';
	public  $groupUser = 'group_user';
	
	public  $map = array();
	
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
			$tmp['rule']	  	= $v['rule'];
			$tmp['cat_id']	  	= $v['cat_id'];
			$tmp['cat_name']	  	= $v['cat_name'];
			$tmp['address']	  	= $v['address'];
			$tmp['lat']         =$v['lat'];
			$tmp['lng']         =$v['lng'];
			$tmp['logosmall'] 	= $v['logosmall'] ? (stristr($v['logosmall'], 'http://') ? $v['logosmall'] : SITE_PROTOCOL.SITE_URL.$v['logosmall']) : '';
			$tmp['logolarge'] 	= str_replace('/s_','/',$tmp['logosmall']);
			$tmp['extend']		= $v['extend'];
			$tmp['description']	= $v['description'];
			$tmp['isblack']	  	= $v['isblack'];
			$tmp['count']	  	= $v['join_count'];

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
		$mbCount  = '(SELECT count(*) FROM `'.$this->tablePrefix.$this->groupUser.'` WHERE groupid=g.id) as join_count';
		$join     = 'left join `'.$this->tablePrefix.$this->groupUser.'` gu on gu.groupid=g.id and gu.uid='.$uid.' left join '.$this->tablePrefix.'group_category gc on g.cat_id=gc.id';
		if($this->join){$join .= $this->join;}
        $field    = 'g.*, gu.getmsg, gu.role,gc.name as cat_name,'.$creator.','.$mbCount;
        //是否被群主拉黑
        $field   .= ',(select count(*) from '.$this->tablePrefix.'user_black where uid=g.uid and fuid='.$uid.') isblack';
        $field   .= ',(select count(*) from '.$this->tablePrefix.'look_record where look_id=g.id and uid='.$uid.' and type=2) look_count';
        if($this->field){$field .= $this->field;}
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
		$map['g.id'] 		= $id;
		$map  			= array_merge($map,$this->map);
		$info 			= $this->public_list($uid, $map, 1);
        if($info['isjoin'] == 1){
            M('look_record')->add(array(
                'uid' => $uid,
                'look_id' => $info['id'],
                'type' => 2,
                'create' => NOW_TIME
            ));
        }
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
        $db = new \User\Model\UserModel();
        if (!$db->isMember($uid)) return showData(new \stdClass(), '你不是会员， 不能创建群组', 1);
	        
		if (!$data) {
            $name = I('name');
            $rule = I('rule','');
            $description = I('description','');
            $address = I('address','');
            $lat=I('lat');
            $lng=I('lng');
            if(iconv_strlen($name,"UTF-8")>20){return showData(new \stdClass(), '群名称限制20字', 1);}
            if(iconv_strlen($rule,"UTF-8")>60){return showData(new \stdClass(), '群规限制60字', 1);}
            if(iconv_strlen($description,"UTF-8")>60){return showData(new \stdClass(), '群介绍限制60字', 1);}
            if(empty($address)){return showData(new \stdClass(), '群地点不可为空', 1);}
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
				'name'			=> $name,
				'logosmall' 	=> $logosmall,
				'description'	=> $description,
 				'rule'		=> $rule,
 				'cat_id'		=> I('cat_id',''),
 				'address'		=> $address,
			    'lat'           => $lat,
			    'lng'           => $lng,
 				'extend'		=> '',
				'createtime'	=> NOW_TIME,
			);
		}
		if (!$data['name']) return showData(new \stdClass(), '请输入群名称', 1);
		if (!$data['cat_id']) return showData(new \stdClass(), '请选择群组类型', 1);
		
		$groupid = $this->add($data);
		
		if ($groupid) {
			if ($isAdd) {
				$group = array('groupid' => $groupid,'uid' => $uid,'addtime' => NOW_TIME,'role' => 1);
				M($this->groupUser)->add($group);
			}
			return $this->groupMainDetail($groupid,$uid);
		}else {
			return showData(new \stdClass(), '创建失败', 1);
		}
	}

    /**
     * 查询群组详情包含群主信息
     */
	public function groupMainDetail($id,$uid){
        $map['g.id'] 		= $id;
        $map  			= array_merge($map,$this->map);
        $info 			= $this->public_list($uid, $map, 1);
        
        return showData($info);
    }
	/**
	 * 搜索群
	 */
	public function groupSearch($uid){
		$name  = I('search');
		if ($name) {
			$map['name|id'] = array('like', '%'.$name.'%');
			return $this->_list($map,$uid);
		}else {
			return showData(new \stdClass(), '请输入搜索名称', 1);
		}
	}
	/**
	 * 用户的群列表 包括创建的和加入的
	 * @param int $uid
	 */
	public function groupList($uid){
	    $map['_string'] = 'g.id in(select `groupid` from '.$this->tablePrefix.$this->groupUser.' where uid='.$uid.')';
	    $map['g.cat_id'] = array('neq',0);
        $list   = self::public_list($uid, $map, 0);
	    return showData($list);
	}
	/**
	 * 群成员列表
	 */
	public function groupUserList($groupid, $ids=0){
		$map['_string'] = 'u.uid in(SELECT uid from '.$this->tablePrefix.$this->groupUser.' where groupid='.$groupid.')';
		$total = M('user')->alias("u")->where($map)->count();
		if ($total){
			$page  = page($total);
			$limit = $page['offset'] . ',' . $page['limit'];
		}else {
			$page  = '';
		}
        $join = "left join ".$this->tablePrefix."user_head uh on u.head=uh.id";
		$list = $total ? M('user')->alias("u")->field('u.uid,u.name,uh.smallUrl as head,uh.originUrl,u.extend')->join($join)->where($map)->limit($limit)->select() : array();
		if ($ids) {
			$uids = '';
			foreach ($list as $k=>$v){
				$uids .= $v['uid'] . ',';
			}
			$uids = substr($uids, 0, -1);
			return $uids;
		}
        foreach ($list as $k=>&$v){
            $v['head'] = site_url($v['head']);
            $v['originUrl'] = site_url($v['originUrl']);
        }
		return showData($list, '', 0, $page);
	}
	/**
	 * 群组邀请列表
	 * @param int $uid
	 * @param int $groupid
	 */
	public function groupInviteUserList($uid, $groupid){
		$map['_string'] = '(uid IN (SELECT fuid FROM '.$this->tablePrefix.'user_friend WHERE uid='.$uid.')) and (uid NOT IN (SELECT uid from '.$this->tablePrefix.$this->groupUser.' where groupid='.$groupid.'))';
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
			return showData(new \stdClass(), '你不是管理员，不能删除群组', 1);
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
		//if (I('cat_id')) $data['cat_id'] = I('cat_id');
		//if (I('address')) $data['address'] = I('address');
		if (I('rule')) $data['rule'] = I('rule');
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

    /**
     * 查询群组类别列表
     * @param $uid
     * @param $follow 0.不显示我关注的，1.显示我关注的
     * @param int $cat_id 类别id
     */
	function groupCatList($uid,$follow,$cat_id = 0){
	    //查询我关注的
	    $mylat=I('lat');
	    $mylng=I('lng');
	    $follow_group = array();
        if($follow){
            //我关注的群
            $group_id = M('group_follw')->where(array('uid'=>$uid))->field('group_id')->select();
            $group_ids = array();
            foreach($group_id as $v){
                $group_ids[] = $v['group_id'];
            }
            $follow_group = self::public_list($uid,array('g.id'=>array('in',$group_ids)),20,'look_count desc'); 
            //我关注的空间号
            $arr = M('groups_follow')->field('groupsid')->where('`groupsid`>0 and `uid` ='.$uid.' and `groupsid` not in(select `groupsid` from '.$this->tablePrefix.'groups_black where uid='.$uid.') and `uid` not in(select `uid` from `'.$this->tablePrefix.'user` where isshield=1)')->select();   
            if ($arr){
                foreach ($arr as $k=>$v){
                    $m=M('groups')->where(array('id'=>$v['groupsid']))->find();
                    $follow_group[]=$m;
                }
            }
            //按从近到远进行排序
            //$order_follow_group=array();
            foreach ($follow_group as $k=>$v){
                if(array_key_exists('number',$v)){
                    $v['type']='空间号';
                }else{
                    $v['type']='群组' ;   
                }
                $dis=$this->getDistance($mylat,$mylng,$v['lat'],$v['lng']);
                //$order_follow_group[$dis.'.'.$v['id']]=$v;
                $v['distance']=$dis;
                $follow_group[$k]=$v;
            }
            foreach($follow_group as $k =>$v){
                $distance[$k] = $v['distance'];
            }
            array_multisort($distance, $follow_group);
        }
        //查询群组类别列表
        $map = array();
        if($cat_id){
            $map['id'] = $cat_id;
        }
        $group_cat = M('share_category')->field('id,name')->where($map)->select();
        return showData(array(
            'follow_group'=>$follow_group?$follow_group:array(),
            'group_cat'=>$group_cat?$group_cat:array()
        ));
    }

    /**
     * 查询类别下的群列表（除开自己建的）
     * @param $uid
     * @param int $cat_id 类别id
     */
	function catGroupList($uid,$cat_id){
	    $mylat=I('lat');
	    $mylng=I('lng');
        $where = array('cat_id'=>array('neq',0));
        $orderby = 'createtime desc';
        //if($type == 1){
            if(empty($cat_id)){
                return showData(new \stdClass(),'群类别不可以为空',1);
            }
            $where['cat_id'] = $cat_id;
        //}
        /* if($type == 2){
            $group_id = M('group_follw')->where(array('uid'=>$uid))->field('group_id')->select();
            $group_ids = array();
            foreach($group_id as $v){
                $group_ids[] = $v['group_id'];
            }
//            $group_id = M('group')->where(array('uid'=>$uid,'cat_id'=>array('neq',0)))->field('id')->select();
//            foreach($group_id as $v){
//                $group_ids[] = $v['id'];
//            }
            $where['g.id'] = array('in',$group_ids);
            $this->field = ",(select `create` from ".$this->tablePrefix."look_record where type=2 and look_id=g.id order by `create` desc limit 1) look_time";
            $orderby = 'look_time desc';
        } */
        $total = $this->alias('g')->where($where)->count();
        $limit = "0,10";
        if ($total){
            $page  = page($total);
            $limit = $page['offset'] . ',' . $page['limit'];
        }else {
            $page  = '';
        }
        //该类别下的所有群
        $data = self::public_list($uid, $where, $limit, $orderby);
        //该类别下的所有号
        $m=M('groups')->where(array('uid'=>array('neq',$uid),'cateid'=>$cat_id))->select();
        foreach ($m as $k =>$v){
            $n=M('groups_black')->where(array('uid'=>$uid,'groupsid'=>$v['id']))->find();
            if(empty($n)){
                $data[]=$v;
            }
        }
        //排序
        foreach ($data as $k => $v){
            if(array_key_exists('number',$v)){
                    $v['type']='空间号';
                }else{
                    $v['type']='群组' ;   
                }
                $dis=$this->getDistance($mylat,$mylng,$v['lat'],$v['lng']);
                //$order_follow_group[$dis.'.'.$v['id']]=$v;
                $v['distance']=$dis;
                $data[$k]=$v;
        }
        foreach($data as $k =>$v){
            $distance[$k] = $v['distance'];
        }
        array_multisort($distance, $data);
        /* if($type == 2){
            $group_id = M('group')->where(array('uid'=>$uid,'cat_id'=>array('neq',0)))->field('id')->select();
            $group_ids = array();
            foreach($group_id as $v){
                $group_ids[] = $v['id'];
            }
            $where['g.id'] = array('in',$group_ids);
            $this->field = ",(select `create` from ".$this->tablePrefix."look_record where type=2 and look_id=g.id order by `create` desc limit 1) look_time";
            $orderby = 'look_time desc';
            $createGroup = self::public_list($uid, $where, $limit, $orderby);
            $groups = array();
            foreach($createGroup as $g){
                $groups[] = $g;
            }
            foreach($data as $g){
                $groups[] = $g;
            }
        } */
        return showData($data,'',0,$page);
    }

    /**
     * 关注群
     * @param $uid
     * @param $groupid
     * @param $type 0.取消关注，1.关注
     */
    function follow($uid, $groupid, $type){
        $data   = array('uid'=>$uid, 'group_id'=>$groupid);
        if($type){
            $count = M('group_follw')->where($data)->count();
            if($count > 0){
                return showData(new \stdClass(),'已关注过该群',1);
            }
            $data['create_time'] = NOW_TIME;
            $row = M('group_follw')->add($data);
            if($row){
                M('group_user')->add(array(
                    'groupid' => $data['group_id'],
                    'uid' => $data['uid'],
                    'role' => 0,
                    'getmsg' => 1,
                    'addtime' => NOW_TIME
                ));
                return showData(new \stdClass(),'关注成功');
            }
            return showData(new \stdClass(),'关注失败',1);
        }else{
            $count = M('group_follw')->where($data)->count();
            if($count <= 0){
                return showData(new \stdClass(),'没有关注过该群',1);
            }
            if (M('group_follw')->where($data)->delete()){
                M('group_user')->where(array('uid' => $data['uid'],'groupid' => $data['group_id']))->delete();
                return showData(new \stdClass(), '取消关注成功');
            }
            return showData(new \stdClass(), '取消关注失败', 1);
        }
    }
    /**
     * 我创建的群列表
     * @param int $uid
     */
    public function createGroupList($uid, $fuid){
        $mylat=I('lat');
        $mylng=I('lng');
        //我创建的群
        $map['g.uid'] = $uid;
        $map['g.cat_id'] = array('neq',0);
        $list   = self::public_list($uid, $map, 0);
        //我创建的空间号
        $m=M('groups')->where(array('uid'=>$uid,'cateid'=>array('neq',0)))->select();
        foreach ($m as $k =>$v){
            $n=M('groups_black')->where(array('uid'=>$uid,'groupsid'=>$v['id']))->find();
            if(empty($n)){
                $list[]=$v;
            }
        }
        //位置排序
        //$order_list=array();
        foreach ($list as $k => $v){
            if(array_key_exists('number',$v)){
                    $v['type']='空间号';
                }else{
                    $v['type']='群组' ;   
                }
                $dis=$this->getDistance($mylat,$mylng,$v['lat'],$v['lng']);
                //$order_follow_group[$dis.'.'.$v['id']]=$v;
                $v['distance']=$dis;
                $list[$k]=$v;
        }
        foreach($list as $k =>$v){
            $distance[$k] = $v['distance'];
        }
        array_multisort($distance, $list);
        //ksort($order_list);
        
        return showData($list);
    }
    /**
     * 所有群及空间号(自己所建除外)
     * @param unknown $groupid
     */
    public function allGrouplist($uid){
        $mylat=I('lat');
        $mylng=I('lng');
        //所有群（自己建的除外）
        $map['g.uid'] = array('neq',$uid);
        $map['g.cat_id'] = array('neq',0);
        $list   = self::public_list($uid, $map, 0);
        //所有空间号（自己建的除外）
        $m=M('groups')->where(array('uid'=>array('neq',$uid),'cateid'=>array('neq',0)))->select();
        foreach ($m as $k =>$v){
            $n=M('groups_black')->where(array('uid'=>$uid,'groupsid'=>$v['id']))->find();
            if(empty($n)){
                $list[]=$v;
            }
        }
        //位置排序
        foreach ($list as $k => $v){
            if(array_key_exists('number',$v)){
                    $v['type']='空间号';
                }else{
                    $v['type']='群组' ;   
                }
                $dis=$this->getDistance($mylat,$mylng,$v['lat'],$v['lng']);
                //$order_follow_group[$dis.'.'.$v['id']]=$v;
                $v['distance']=$dis;
                $list[$k]=$v;
        }
        foreach($list as $k =>$v){
            $distance[$k] = $v['distance'];
        }
        array_multisort($distance, $list);
        
        return showData($list);
    }

    public function getGroupMessage($groupid){
        $total = M('message')->where('toid='.$groupid)->count();
        $limit = "0,10";
        if ($total){
            $page  = page($total);
            $limit = $page['offset'] . ',' . $page['limit'];
        }else {
            $page  = '';
        }
        $messages = M('message')->where('toid='.$groupid)->order('time desc')->limit($limit)->select();
        return showData($messages,'',0,$page);
    }
}