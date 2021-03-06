<?php
/**
 * 消息类
 * @author yangdong
 *
 */
namespace Message\Model;
use Think\Model;
use Think\Upload;
use Think\Image;
use Lincense\Controller\Thinkchat;
use User\Model\UserModel;
use Group\Model\GroupModel;
use Think\Log;

class MessageModel extends Model {
	protected $tableName   = 'message';
	protected $pk          = 'id';
	protected $groupUser   = 'group_user';
	protected $sessionUser = 'session_user';
	//消息文件类型
	const text 			= 1; //文本
	const image 		= 2; //图片
	const voice 		= 3; //语音
	const location 		= 4; //位置
	const file          = 5; //文件
	//消息聊天类型
	const singleChat	= 100;//单聊
	const groupChat		= 200;//群聊
	const sessionChat	= 300;//会话
	
	// 上传文件，主要处理c#上传文件方式不同的问题
	function uploadFile($uid, $typefile=2) {

		//上传文件
		if (!empty($_FILES)) {
			$info = self::upload($uid, $typefile);
			if ($info['status']) {
				$imageData = $info['image'];
				$voiceData = $info['voice'];
				$fileData  = $info['file'];
				

				$result = base64_encode(json_encode($info));
				return  showData($result);
			}else {
				return showData(new \stdClass(), $info['info'], 1);
			}
		}
		
		return showData(new \stdClass(), '没有选择文件', 1);
	}
	/**
	 * 关注消息
	 */
	function msg($uid,$tid,$content,$fromdata,$todata){
		$typechat  = I('typechat') ? I('typechat') : 100;//聊天类型
		$typefile  = I('typefile') ? I('typefile') : 1;	//上传文件类型
		$fromid    = $uid;					//发送者
		$fromname  = $fromdata['nickname']; //发送者名称
		$fromhead  = makeHttpHead($fromdata['headsmall']); //发送者名称
		$fromextend= I('fromextend','',''); //发送者的护展信息
		$toid      = $tid;				//接收者
		$toname    = $todata['nickname'];	//接收者名称
		$tohead    = makeHttpHead($todata['headsmall']);	//接收者名称
		$toextend  = I('toextend','','');	//接收者的扩展信息
		$content   = I('content','','')?I('content','',''):$content;	//消息内容
		$extend	   = I('extend','','');		//消息的扩展
		$bodyextend= I('bodyextend','','');	//上传文件扩展
		
		$fileInfo = I('fileinfo', '', '');	// 文件路径，如果此字段有值，则不需要再上传文件了
		$imageData = '';	//图片信息			
		$voiceData = '';	//语音信息
		$fileData  = '';    //文件信息
		$location  = '';	//位置信息
		$videoData = '';     //视频位置
		$tag	   = I('tag');//客户端用的tag标识符
		//检查用户是否是给自己发送消息
		if($fromid==$toid){
			return showData(new \stdClass(), '不能给自己发送消息', 1);
		}
		//检查用用户是否还在一个群组当中
		$checkUser = self::checkUser($typechat, $toid, $fromid);
		if ($checkUser['code']) return $checkUser;
		
		// 检测客户端如果自己上传了fileInfo值，则不需要再上传文件了。
		if($fileInfo) {
			$info = json_decode(base64_decode($fileInfo), true);
			Log::write("info=" . $info);
			//图片
			if($typefile == self::image) $imageData = $info['image'];
			//语音
			if($typefile == self::voice) {
				$voiceData          = $info['voice'];
				$voicetime          = I('voicetime', '', '');
				$voiceData['time']  = $voicetime;
			}
			//文件
			if($typefile == self::file) $fileData = $info['file'];
		}else {
			//上传文件
			if (!empty($_FILES)) {
				Log::write("prepare to upload file");
				$info = self::upload($uid, $typefile);
				if ($info['status']) {
					$imageData = $info['image'];
					$voiceData = $info['voice'];
					$fileData  = $info['file'];
					$videoDate =$info['video'];
					Log::write("upload result=" . json_encode($info));
				}else {
					return showData(new \stdClass(), $info['info'], 1);
				}
			}
		}
		//位置
		if (I('lat') || I('lng') || I('address')) {
			$location = array('lat'=>I('lat'),'lng'=>I('lng'),'address'=>I('address'));
		}
		//消息体
		$body = array(
				'fromid'	=> $fromid,
				'fromname'	=> $fromname,
				'fromhead'	=> $fromhead,
				'fromextend'=> $fromextend ? json_decode($fromextend,true) : '',
				'toid'		=> $toid,
				'toname'	=> $toname,
				'tohead'	=> $tohead,
				'toextend'	=> $toextend ? json_decode($toextend,true) : '',	
				'image'		=> $imageData,	
				'voice'		=> $voiceData,
		        'video'     => $videoDate,
				'location'	=> $location,
		        'file'      => $fileData,
				'content'	=> $content,
				'extend'	=> $extend ? json_decode($extend,true) : '',
				'bodyextend'=> $bodyextend ? json_decode($bodyextend,true) : '',
				'typechat'	=> $typechat, 	
				'typefile'	=> $typefile,	
				'tag'		=> $tag,
				'time'		=> getMillisecond(),//时间
		);
		$data = $body;
		$data['fromextend'] = $fromextend;
		$data['toextend'] 	= $toextend;
		$data['image']		= $imageData ? json_encode($imageData) : '';
		$data['voice']		= $voiceData ? json_encode($voiceData) : '';
		$data['video']		= $videoData ? json_encode($videoData) : '';
		$data['location']	= $location ? json_encode($location) : '';
		$data['file']	    = $fileData ? json_encode($fileData) : '';
		$data['extend']		= $extend;
		$data['bodyextend']	= $bodyextend;
		//判断是单聊还是群聊及接收消息的用户
		$uids = self::chatType($typechat, $toid, $fromid);
		if ($uids) $toUids = $uids;
		//写入数据表
		$msgid = $this->add($data);
		if ($msgid) {
			$body['id'] = $msgid;
			$black=M('user_black')->where(array('uid'=>$toid,'fid'=>$uid))->count();
			
			if (isset($toUids)&&$black==0){
				$device 	= I('device', '');
				$thinkchat 	= new Thinkchat();
				$thinkchat->init(C('OP_SERVER'));
				
				$ret = $thinkchat->message($fromid, $toUids, $body);
				if($ret['code'] != 0 ){
					$this->delete($msgid);
					return showData(new \stdClass(), $ret['msg'], 1);
				}
				return showData($body, '发送消息成功');
			}else {//没有接收者 只是保存消息
				return showData($body, '发送消息成功');
			}
		}else {
			return showData(new \stdClass(), '发送消息失败', 1);
		}
	}
	/**
	 * 聊天接口
	 */
	function message($uid){
		Log::write("MessageModel into message,post=" . json_encode($_REQUEST));
		
		$typechat  = I('typechat') ? I('typechat') : 100;//聊天类型
		$typefile  = I('typefile') ? I('typefile') : 1;	//上传文件类型
		$fromid    = $uid;					//发送者
		$fromname  = I('fromname', '', ''); //发送者名称
		$fromhead  = I('fromhead', '', ''); //发送者名称
		$fromextend= I('fromextend','',''); //发送者的护展信息
		$toid      = I('toid');				//接收者
		$rem=M('user_friend')->field('remark')->where(array('uid'=>$toid,'fid'=>$uid))->find();
		if($rem && $rem['remark']){
		    $fromname=$rem['remark'];
		}
		$toname    = I('toname', '', '');	//接收者名称
		$tohead    = I('tohead', '', '');	//接收者名称
		$toextend  = I('toextend','','');	//接收者的扩展信息
		$content   = I('content','','');	//消息内容
		$extend	   = I('extend','','');		//消息的扩展
		$bodyextend= I('bodyextend','','');	//上传文件扩展
		
		$fileInfo = I('fileinfo', '', '');	// 文件路径，如果此字段有值，则不需要再上传文件了
		$imageData = '';	//图片信息			
		$voiceData = '';	//语音信息
		$fileData  = '';    //文件信息
		$location  = '';	//位置信息
		$videoData ='';    //视频信息
		$tag	   = I('tag');//客户端用的tag标识符
		//检查用户是否是给自己发送消息
		if($fromid==$toid){
			return showData(new \stdClass(), '不能给自己发送消息', 1);
		}
		//检查用用户是否还在一个群组当中
		$checkUser = self::checkUser($typechat, $toid, $fromid);
		if ($checkUser['code']) return $checkUser;
		
		// 检测客户端如果自己上传了fileInfo值，则不需要再上传文件了。
		if($fileInfo) {
			$info = json_decode(base64_decode($fileInfo), true);
			Log::write("info=" . $info);
			//图片
			if($typefile == self::image) $imageData = $info['image'];
			//语音
			if($typefile == self::voice) {
				$voiceData          = $info['voice'];
				$voicetime          = I('voicetime', '', '');
				$voiceData['time']  = $voicetime;
			}
			//文件
			if($typefile == self::file) $fileData = $info['file'];
		}else {
			//上传文件
			if (!empty($_FILES)) {
				Log::write("prepare to upload file");
				$info = self::upload($uid, $typefile);
				if ($info['status']) {
					$imageData = $info['image'];
					$voiceData = $info['voice'];
					$fileData  = $info['file'];
					$videoData  = $info['video'];
					Log::write("upload result=" . json_encode($info));
				}else {
					return showData(new \stdClass(), $info['info'], 1);
				}
			}
		}
		//位置
		if (I('lat') || I('lng') || I('address')) {
			$location = array('lat'=>I('lat'),'lng'=>I('lng'),'address'=>I('address'));
		}
		//消息体
		$body = array(
				'fromid'	=> $fromid,
				'fromname'	=> $fromname,
				'fromhead'	=> $fromhead,
				'fromextend'=> $fromextend ? json_decode($fromextend,true) : '',
				'toid'		=> $toid,
				'toname'	=> $toname,
				'tohead'	=> $tohead,
				'toextend'	=> $toextend ? json_decode($toextend,true) : '',	
				'image'		=> $imageData,	
				'voice'		=> $voiceData,
				'location'	=> $location,
		        'file'      => $fileData,
		        'video'     =>$videoData,
				'content'	=> $content,
				'extend'	=> $extend ? json_decode($extend,true) : '',
				'bodyextend'=> $bodyextend ? json_decode($bodyextend,true) : '',
				'typechat'	=> $typechat, 	
				'typefile'	=> $typefile,	
				'tag'		=> $tag,
				'time'		=> getMillisecond(),//时间
		);
		$data = $body;
		$data['fromextend'] = $fromextend;
		$data['toextend'] 	= $toextend;
		$data['image']		= $imageData ? json_encode($imageData) : '';
		$data['voice']		= $voiceData ? json_encode($voiceData) : '';
		$data['location']	= $location ? json_encode($location) : '';
		$data['file']	    = $fileData ? json_encode($fileData) : '';
		$data['video']	    = $videoData ? json_encode($videoData) : '';
		$data['extend']		= $extend;
		$data['bodyextend']	= $bodyextend;
		//判断是单聊还是群聊及接收消息的用户
		$uids = self::chatType($typechat, $toid, $fromid);
		if ($uids) $toUids = $uids;
		//写入数据表
		$msgid = $this->add($data);
		if ($msgid) {
			$body['id'] = $msgid;
			$black=M('user_black')->where(array('uid'=>$toid,'fid'=>$uid))->count();
			
			if (isset($toUids)&&$black==0){
				$device 	= I('device', '');
				$thinkchat 	= new Thinkchat();
				$thinkchat->init(C('OP_SERVER'));
				
				$ret = $thinkchat->message($fromid, $toUids, $body);
				if($ret['code'] != 0 ){
					$this->delete($msgid);
					return showData(new \stdClass(), $ret['msg'], 1);
				}
				return showData($body, '发送消息成功');
			}else {//没有接收者 只是保存消息
				return showData($body, '发送消息成功');
			}
		}else {
			return showData(new \stdClass(), '发送消息失败', 1);
		}
	}
	/**
	 * 通知
	 * @param unknown $uid
	 * @param unknown $fid
	 * @return array
	 */
	function sendNotice(){
		$typechat 	= I('typechat', 100);
		$uid 		= I('uid', 0);
		$touid 		= I('touid', 0);
		
		if($typechat == self::singleChat) {	// 单聊通知
			if (!$touid) {
				return showData(new \stdClass(), 'touid不能为空', 1);
			}
			$user_db = new UserModel();
			return $user_db->sendNotice($uid, $touid);
		}
		
		// 群聊或临时会话
		$groupid = I('groupid', 0);
		$type     = I('type');
		$content  = I('content', '');
		$noticeself = I('noticeself', 0);

		if(!$groupid)
			return showData(new \stdClass(), 'groupid不能为空', 1);
	
		
		$user	  = new UserModel();
		$userinfo = $user->getUserName($uid);//得到用户资料
		
		$group_db = new GroupModel();
		$group    = $group_db->_getGroupNameLogo($groupid);//群组信息
		$to 	  = array('toid'=>$groupid);
		
		if($typechat == 200) {	// 群聊
			if(!$touid) {
				if($noticeself)
					$where = "groupid = " . $groupid . " and getmsg = 1";
				else
					$where = "groupid = " . $groupid . " and getmsg = 1 and uid <> " . $uid;
				
				$list = M('group_user')->field('uid')->where($where)->select();
				foreach ($list as $value){
					$touid .= $value['uid'] . ',';
				}
				if($touid) {
					$touid = substr($touid, 0, strlen($touid) - 1);
				}
			}
		}
		if($typechat == 300 ) {	// 临时会话
		if(!$touid) {
				if($noticeself)
					$where = "sessionid = " . $groupid . " and getmsg = 1";
				else
					$where = "sessionid = " . $groupid . " and getmsg = 1 and uid <> " . $uid;
				
				$list = M('session_user')->field('uid')->where($where)->select();
				
				$touid = implode(',', $list);
			}
		}
		$to['touid'] = $touid;

		if(!$touid)
			return showData(new \stdClass(), '消息接受者为空了', 2);
		
		
		$thinkchat = new Thinkchat();
		$thinkchat->init(C('OP_SERVER'));
		return $thinkchat->notice($userinfo, $to, $type, $content, $group);
	}
	/**
	 * 判断哪些用户能够接收消息
	 * @param unknown $typechat
	 * @return string
	 */
	function chatType($typechat, $toid, $fromid){
		$list = array();
		$uids = '';
		switch ($typechat) {
			case self::singleChat:
				$uids = $toid;
				break;
			case self::groupChat:
				$list = M($this->groupUser)->field('uid')->where(array('groupid'=>$toid,'uid'=>array('neq',$fromid)))->select();
				break;
			case self::sessionChat:
				$list = M($this->sessionUser)->field('uid')->where(array('sessionid'=>$toid,'uid'=>array('neq',$fromid)))->select();
				break;
		}
		if ($list) {
			foreach ($list as $k=>$v){
				$uids .= $v['uid'] . ',';
			}
			$uids = substr($uids, 0, -1);
		}
		return $uids;
	}
	/**
	 * 检查用户是不是某组成员
	 * @return 
	 */
	function checkUser($typechat, $toid, $fromid){
		if ($typechat == self::groupChat) {
			if ( ! M($this->groupUser)->where(array('groupid'=>$toid,'uid'=>$fromid))->count()) {
				return showData(new \stdClass(), '发送失败，你已不是该组成员！',3);
			}
		}else if ($typechat == self::sessionChat) {
			if ( ! M($this->sessionUser)->where(array('sessionid'=>$toid,'uid'=>$fromid))->count()) {
				return showData(new \stdClass(), '发送失败，你已不是该组成员！',3);
			}
		}
		return showData(new \stdClass());
	}
	/**
	 * 上传图片
	 * @param int $uid 用户id
	 * @param int $typefile 文件类型
	 * @return array
	 */
	function upload($uid, $typefile){
	    $ROOT_PATH 	= SITE_DIR.UPLOADS;	//物理根目录
	    $URL_PATH 	= SITE_PROTOCOL.SITE_URL.UPLOADS; //URL地址
	    //检测文件是否已上传
	    $md5file  = isset($_FILES['upload_file']['tmp_name']) ? $_FILES['upload_file']['tmp_name'] : 0;
	    $fileinfo = false;
	    if ($md5file){
	        $fileinfo = M('message_file')->where(array('md5'=>$md5file))->find();
	    }
	    $imageData = $voiceData = $fileData=$videoData = array();
	    if ($fileinfo){//该文件已上传
	        $str = $fileinfo['savepath'].$fileinfo['savename'];
	        $fileData['url']  = $URL_PATH.ltrim($str,'/');
	        $fileData['name'] = $fileinfo['name'];
	        $fileData['size'] = $fileinfo['size'];
	    }else {
	        $upload   	= new Upload();
	        $upload->rootPath  = $ROOT_PATH;
	        $upload->savePath  = '/Picture/message/'.$uid.'/'; // 设置附件上传目录
	        $upload->exts      = array('jpg','png','gif','mp3','jpeg','mp4');// 设置附件上传类型
	        if ($typefile == self::file){
	            $upload->exts     = array();
	            $upload->savePath = '/Picture/message/'; // 设置附件上传目录
	            $upload->saveName = '';
	        }
	        $upload->replace   = true;
	        $upload->subName   = array('date','Ymd');
	        // 上传文件
	        $info   =   $upload->upload();
	        if(!$info) {// 上传错误提示错误信息
	            return array('status'=>0, 'info'=>$upload->getError());
	        }else{// 上传成功
	            $image = new Image();

	            foreach($info as $file){
	                $URL =  $file['savepath'].$file['savename'];
	                if ($typefile == self::image) {
	                    $smallUrl = $file['savepath'].'s_'.$file['savename'];
	                    $image->open($ROOT_PATH.$URL);			//打开图片
	                    $s_path = $ROOT_PATH.$smallUrl;			//小图
	                    $image->thumb(200, 200)->save($s_path);	//压缩
	                    $image->open($s_path);					// 打开小图
	                    $imageData['urllarge'] 	= $URL_PATH.ltrim($URL,'/');
	                    $imageData['urlsmall'] 	= $URL_PATH.ltrim($smallUrl,'/');
	                    $imageData['width'] 	= $image->width();
	                    $imageData['height'] 	= $image->height();
	                }else if ($typefile == self::file){//文件
	                    M('message_file')->add($file);//把文件写入数据库
	                    $str = $file['savepath'].$file['savename'];
	                    $fileData['url']  = $URL_PATH.ltrim($str,'/');
	                    $fileData['name'] = $file['name'];
	                    $fileData['size'] = $file['size'];
	                }else if($typefile == self::voice){
	                    $voiceData['url']   = $URL_PATH.ltrim($URL,'/');
	                    $voiceData['time']	= I('voicetime',0);
	                }else{
	                    if(strpos($URL_PATH.ltrim($URL,'/'), ".mp4") === false && strpos($URL_PATH.ltrim($URL,'/'), ".mp3") === false){
	                        $smallUrl = $file['savepath'].'s_'.$file['savename'];
	                        $image->open($ROOT_PATH.$URL);			//打开图片
	                        $s_path = $ROOT_PATH.$smallUrl;			//小图
	                        $image->thumb(200, 200)->save($s_path);	//压缩
	                        $image->open($s_path);					// 打开小图
	                        $imageData['urllarge'] 	= $URL_PATH.ltrim($URL,'/');
	                        $imageData['urlsmall'] 	= $URL_PATH.ltrim($smallUrl,'/');
	                        $imageData['width'] 	= $image->width();
	                        $imageData['height'] 	= $image->height();
	                    }else{
	                        $videoData['url']   = $URL_PATH.ltrim($URL,'/');
	                    }
	                }
	            }
	        }
	        return array('status'=>1, 'image'=>$imageData, 'voice'=>$voiceData, 'file'=>$fileData,'video'=>$videoData);
	    }
	}
}