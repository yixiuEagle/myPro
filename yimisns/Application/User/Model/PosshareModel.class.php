<?php
/**
 * 实时位置共享
 * @author nye
 *
 */
namespace User\Model;
use Think\Model;
use Think\Log;
use Common\Model\CommonModel;
use Group\Model\GroupModel;



class PosshareModel extends CommonModel {
	// 入群
	function enterGroup($uid) {
		$groupid = I('groupId', 0);
		$lat = I('lat', '');
		$lng = I('lng', '');
		
		$this->checkArguments(Array( 'lat'=>$lat, 'lng'=>$lng));
		
		$groupModel = new GroupModel();
		if($groupid) {
			// 获取群信息
			$groupinfo = M('group')->where(Array('id'=>$groupid))->find();	
			if($groupinfo['isshareend'] == 1){
				return showData(new \stdClass(), "共享已结束，无法进入", 1);
			}
			
		}else{// 不存在就创建群
			$groupname = "实时位置共享群" +time();
			// 创建群
			$result = $groupModel->groupAdd3($uid, $groupname);
			if($result == null ) {
				return showData(0, "创建群失败",1);
			}
				
			if($result['code'] != 0 ) {
				return $result;
			}
			
			$groupinfo = M('group')->where(Array('name'=>$groupname))->find();
			$groupid = $groupinfo['id'];
		}
		
		// 将当前用户加入到群中
		$group_user = M('group_user')->where(Array('groupid'=>$groupid, 'uid'=>$uid))->find();
		if(!$group_user) {
			$data['uid'] = $uid;
			$data['role'] = 0;
			$data['addtime'] = getMillisecond();
			$data['lasttime'] = getMillisecond();
			$data['groupid'] = $groupid;

			M('group_user')->add($data);
			
			// 发送入群通知
			self::sendEnterGroupNotice($groupid, $uid);
		}
		
		
		// 获取群成员
		$sql = "select u.uid,u.headsmall,u.nickname,u.lat,u.lng,getDistance('$lng','$lat',u.lng,u.lat) as distance from tc_user u, tc_group_user g where g.uid=u.uid and g.groupid=$groupid order by lasttime desc";
		$model = new Model();
		$userlist = $model->query($sql);
		$groupinfo['userlist'] = $userlist;
		
		return showData($groupinfo);
			
	}
	
	// 更新用户位置
	public function updatepos($uid) {
		
		$lat = I('lat', '');
		$lng = I('lng', '');
		
		$this->checkArguments(Array( 'lat'=>$lat, 'lng'=>$lng));
		
		$data['lat'] = $lat;
		$data['lng'] = $lng;
		
		M('user')->where(Array( 'uid'=>$uid))->save($data);
		return showData(0);
	}
	
	// 退出群
	public function quitGroup($uid) {
		$groupid = I('groupId', 0);
		$this->checkArguments(Array( 'groupId'=>$groupid));
		
		$groupinfo = M('group')->where(Array('id'=>$groupid))->find();
		$admin_uid = $groupinfo['uid'];
		if($admin_uid == $uid) {
			$newdata['isshareend'] = 1;
			M('group')->where(Array('id'=>$groupid))->save($newdata);
			// 发送终止群通知
			self::sendEndGroupNotice($groupid, $uid);
			
			return showData("");
		}
		$time=M('group_user')->field('addtime')->where(Array('groupid'=>$groupid, 'uid'=>$uid))->find();
		$watchtime=NOW_TIME-$time['addtime'];
		M('kuaipai_statistics')->alias('ks')->field('gu.*')->join('join '.C('DB_PREFIX').'group g on g.name=ks.linkid')->where(array('g.id'=>$groupid))->setInc('viewtime',$watchtime);
		$result = M('group_user')->where(Array('groupid'=>$groupid, 'uid'=>$uid))->delete();
		if(!$result)
			return showData("", "操作失败", 1);
		
		// 发送退群通知
		self::sendQuitGroupNotice($groupid, $uid);
		
		return showData("");
	}
	
	// 获取最新用户头像
	function lastUserHeads($uid) {
		$groupid = I('groupId', 0);
		$lat = I('lat', '');
		$lng = I('lng', '');
		
		
		$this->checkArguments(Array('groupId'=>$groupid, 'lat'=>$lat, 'lng'=>$lng));
		
		
		$table = "user u, tc_group_user g";
		$where = "g.uid=u.uid and g.groupid=$groupid";
		$field = "u.uid,u.headsmall,u.nickname,u.lat,u.lng,getDistance('$lng','$lat',u.lng,u.lat) as distance ";
		$order = "lasttime desc";
		
		return $this->m_db_getlistpage($table, $where, $field, $order, 1, 1000);
		
	}
	
	// 发布入群通知
	private function sendEnterGroupNotice($groupid, $uid) {
		$groupModel = new GroupModel();
	
		$map['uid'] = $uid;
		$map['groupid'] = $groupid;
	
		$content = json_encode($map);
	
		$groupModel->sendNoticeCustom('admin', $groupid, UserModel::$NOTICE_POSSHARE_ENTERGROUP, 0, $content);
	}
	
	// 发布退群通知
	private function sendQuitGroupNotice($groupid, $uid) {
		$groupModel = new GroupModel();
	
		$map['uid'] = $uid;
		$map['groupid'] = $groupid;
	
		$content = json_encode($map);
	
		$groupModel->sendNoticeCustom('admin', $groupid, UserModel::$NOTICE_POSSHARE_QUITRGROUP, 0, $content);
	}
	
	// 发布终止群通知
	private function sendEndGroupNotice($groupid, $uid) {
		$groupModel = new GroupModel();
	
		$map['uid'] = $uid;
		$map['groupid'] = $groupid;
	
		$content = json_encode($map);
	
		$groupModel->sendNoticeCustom('admin', $groupid, UserModel::$NOTICE_POSSHARE_ENDESHARE, 0, $content);
	}
		
		
}