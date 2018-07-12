<?php
/**
 * 快拍
 * @author nye
 *
 */
namespace User\Model;
use Think\Model;
use Think\Log;
use Common\Model\CommonModel;
use Group\Model\GroupModel;

/* 入群
输入：用户id、快拍id
输出：成功与否

发送通知
在线人数通知—
赞通知—
自动加入会议通知—

最新用户头像
输入：用户id、快拍id
输出：用户头像、用户id、用户昵称

点赞
输入：用户id、快拍id
输出：成功与否

评论及通知我（只有管理员可操作）
输入：用户id、快拍id、类型（1-开启 0-取消）
输出：最新状态

关闭评论（只有管理员可操作）
输入：用户id、快拍id、类型（1-开启 0-取消）
输出：最新状态
 */

class KuaipaiModel extends CommonModel {
	// 入群
	function enterGroup($uid) {
		$id = I('id', 0);
		
		$this->checkArguments(Array("id"=>$id));
		// 判断群是否存在，不存在则创建
		$sql = "select g.*,(select u.getmsg from tc_group_user u where u.groupid=g.id and u.uid=$uid) as getmsg from tc_group g where g.name='$id'";
		
		$model = new Model();
		
		//$group =$model->query($sql);
		$group = M('group g')->where("g.name='$id'")->field("g.*,(select u.getmsg from tc_group_user u where u.groupid=g.id and u.uid=$uid) as getmsg")->find();
		$groupModel = new GroupModel();
		
		if(!$group){
			// 获取快拍的创建者
			$kuaipai = M('kuaipai')->where(Array('id'=>$id))->find();
			if(!$kuaipai)
			{
				return showData(0, "快拍未找到",1);
			}
			$kuaipai_admin = $kuaipai['uid'];
			
			// 创建群
			$result = $groupModel->groupAdd2($kuaipai_admin, $id);
			if($result == null ) {
				return showData(0, "创建群失败",1);
			}
			
			if($result['code'] != 0 ) {
					return $result;
				}
				
				//$group = $model->query($sql);
				$group = M('group g')->where("g.name='$id'")->field("g.*,(select u.getmsg from tc_group_user u where u.groupid=g.id and u.uid=$uid) as getmsg")->find();
				
			}
			
			Log::write("group=" . json_encode($group));
			$groupid = $group['id'];
			// 将当前用户加入到群中
			$group_user = M('group_user')->where(Array('groupid'=>$groupid, 'uid'=>$uid))->find();
			if(!$group_user) {
				$data['uid'] = $uid;
				$data['role'] = 0;
				$data['addtime'] = getMillisecond();
				$data['lasttime'] = getMillisecond();
				$data['groupid'] = $groupid;
				M('group_user')->add($data);
			}
		//修改为在线状态
		M('group_user')->where(Array('groupid'=>$groupid, 'uid'=>$uid))->setField('isonline',1);
		self::sendOnlinePersonsNotice($groupid);
			
		
		return showData($group);
		//return $groupModel->groupDetail($group['id'], $uid);
			
	}
	// 发布在线人数通知
	private function sendOnlinePersonsNotice($groupid) {
		$groupModel = new GroupModel();
		
		$total = M('group_user')->where(Array('groupid'=>$groupid))->count();
		$online = M('group_user')->where(Array('groupid'=>$groupid, 'isonline'=>1))->count();
		
		$map['total'] = $total;
		$map['online'] = $online;
		$map['groupid'] = $groupid;
		
		$content = json_encode($map);
		
		$groupModel->sendNoticeCustom('admin', $groupid, UserModel::$NOTICE_KUAIPAI_ONLINEPERSONS, 0, $content);
	}
	//快拍下线
	private function kuaipai_out($uid) {
	   $groupid=I('groupid',0);
	   if($groupid&&$uid){
	       M('group_user')->where(Array('uid'=>$uid))->setField('isonline',0);
	   }
	}
	// 发布赞通知
	private function sendZanNotice($groupid, $uid) {
		$groupModel = new GroupModel();
		
		$map['uid'] = $uid;
		$map['groupid'] = $groupid;
		
		$content = json_encode($map);
		
		$groupModel->sendNoticeCustom('admin', $groupid, UserModel::$NOTICE_KUAIPAI_ZAN, 0, $content);
	}
	// 发布自动加入会议通知
	private function sendAutomeetingNotice($groupid, $meetingNum) {
		$groupModel = new GroupModel();
		
		$map['groupid'] = $groupid;
		$map['meetingNum'] = $meetingNum;
		
		$content = json_encode($map);
		
		$groupModel->sendNoticeCustom('admin', $groupid, UserModel::$NOTICE_KUAIPAI_AUTOMEETING, 0, $content);
	}
	// 发布会议结束通知
	private function sendEndmeetingNotice($groupid, $meetingNum) {
		$groupModel = new GroupModel();
	
		$map['groupid'] = $groupid;
		$map['meetingNum'] = $meetingNum;
	
		$content = json_encode($map);
	
		$groupModel->sendNoticeCustom('admin', $groupid, UserModel::$NOTICE_KUAIPAI_ENDMEETIN, 0, $content);
	}
	
	// 管理员设置是否评论通知
	private function sendCancommentNotice($groupid, $iscancomment) {
		$groupModel = new GroupModel();
	
		$map['groupid'] = $groupid;
		
		$map['cancomment'] = $iscancomment;
	
		$content = json_encode($map);
	
		$groupModel->sendNoticeCustom('admin', $groupid, UserModel::$NOTICE_KUAIPAI_SETTINGCANCOMMENT, 0, $content);
	}
	
	// 获取最新用户头像
	function lastUserHeads($uid) {
		$groupid = I('groupId', 0);
		
		$this->checkArguments(Array('groupId'=>$groupid));
		

		
		$table = "user u, tc_group_user g";
		$where = "g.uid=u.uid and g.groupid=$groupid";
		$field = "u.uid,u.headsmall,u.nickname ";
		$order = "lasttime desc";
		
		return $this->m_db_getlistpage($table, $where, $field, $order, 1, 7);
		
	}
	// 管理员发起自动加入会议
	function kuaipai_automeeting($uid) {
		$groupid = I('groupId', 0);
		$meetingNum = I('meetingNum', 0);
		
		$this->checkArguments(Array('groupId'=>$groupid, 'meetingNum'=>$meetingNum));
		
		$result = M('group')->where(Array('id'=>$groupid))->save(Array('meetingNum'=>$meetingNum));
		
		
		self::sendAutomeetingNotice($groupid, $meetingNum);
		
		return showData("");
	}
	
	// 赞
	function kuaipai_zan($uid,$groupId) {
	    $mes=M('group')->field('name,uid')->where(array('id'=>$groupId))->find();
		$data['linkid'] = $mes['name'];
		$data['uid'] = $uid;
		$data['createtime']=NOW_TIME;
		$this->checkArguments(Array('groupId'=>$data['linkid']));
		if($uid!=$mes['uid']){
		    self::sendZanNotice($data['linkid'], $uid);
		}
		$result = M('kuaipai_zan')->add($data);
		//判断是否增加收益
		$visit=M('kuaipai_visit')->where(array('uid'=>$uid,'linkid'=>$data['linkid'],'type'=>2))->find();
		if(!$visit){
		    $da['uid']=$uid;
		    $da['linkid']=$data['linkid'];
		    $da['type']=2;
		    //添加访问记录
		    $visit=D('kuaipai_visit')->add($da);
		     
		    $fid=M('kuaipai')->field('uid')->where(array('id'=>$data['linkid']))->find();
		    /*zy修改收益新规则*/
		    $worthuser=M('user')->field('worth_user')->where(array('uid'=>$fid['uid']))->find();
		    $level=levelMoney($worthuser['worth_user']);
		    $create=NOW_TIME;
		    $usermodel=new \User\Model\UserModel();
		    $worthlist=$usermodel->worth($fid['uid'],$create,C('zan_dyanmic')*$level,10);
		    $this->money($fid['uid'], C('zan_dyanmic')*$level);
		    //M('kuaipai_statistics')->where(array('linkid'=>$data['linkid']))->setInc('fee',C('zan_dyanmic')*$level);
		}
		/* $f=M('kuaipai_statistics')->where(array('linkid'=>$data['linkid']))->find();
		if($f){
		    $fee['zancount']=array('exp','zancount+1');
		    //更新访问记录
		    $visit=D('kuaipai_statistics')->where(array('linkid'=>$data['linkid']))->save($fee);
		} */
		$count = M('kuaipai_zan')->where(Array('linkid'=>$data['linkid']))->count();
		$result2=M('kuaipai')->where(Array('id'=>$data['linkid']))->setField('zancount', $count);
		$result3=M('kuaipai_statistics')->where(Array('linkid'=>$data['linkid']))->setField('zancount', $count);
        if($result && $result2 && $result3){
            return showData(new \stdClass(), '点赞成功');
        }else{
            return showData(new \stdClass(), '点赞失败', 1);
        }
	}
	/**
	 * 快拍赞数量
	 */
	function kuaipai_zancount($id){
	    $zancount=M('kuaipai')->field('zancount')->where(array('id'=>$id))->find();
	    return showData($zancount);
	}
	// 管理员设置  评论及通知我  关闭评论
	function kuaipai_admin_setting($uid) {
		$groupid = I('groupId', 0);
		
		$this->checkArguments(Array('groupId'=>$groupid));
		
		$getMsg = I('getmsg', 0);
		$cancomment = I('cancomment', 0);
		
		$where = "groupid=$groupid and uid<>$uid";
		$result = M('group_user')->where(Array('groupid'=>$groupid, 'uid'=>$uid))->save(Array('getmsg'=>$getMsg));
		if($result === false)
		{
			return showData("", "设置失败", 1);
		}
		
		$result =  M('group')->where(Array('id'=>$groupid))->save(Array('cancomment'=>$cancomment));
		if($result === false)
		{
			return showData("", "设置失败", 1);
		}
		
		self::sendCancommentNotice($groupid, $cancomment);
		return showData("", "设置成功");
	}
	
	// 直播结束
	function kuaipai_endMeeting($uid) {
		$groupid = I('groupId', 0);
		$meetingNum = I('meetingNum', 0);
		$this->checkArguments(Array('groupId'=>$groupid, 'meetingNum'=>$meetingNum));
		
		$result = M('group')->where(Array('id'=>$groupid))->save(Array('meetingNum'=>''));
		
		self::sendEndmeetingNotice($groupid, $meetingNum);
	
		
		return showData("");
		}
		
		
}