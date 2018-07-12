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
	const file         = 5; //文件
	//消息聊天类型
	const singleChat	= 100;//单聊
	const groupChat		= 200;//群聊
	const sessionChat	= 300;//会话
	/**
	 * 聊天接口
	 */
	function message($uid,$fromname = '',$toid = '',$content='',$tag=''){
		$typechat  = I('typechat') ? I('typechat') : 100;//聊天类型
		$typefile  = I('typefile') ? I('typefile') : 1;	//上传文件类型
		$fromid    = $uid;					//发送者
		$fromname  = I('fromname', $fromname, ''); //发送者名称
		$fromhead  = I('fromhead', '', ''); //发送者名称
		$fromextend= I('fromextend','',''); //发送者的护展信息
		$toid      = I('toid',$toid);				//接收者
		$toname    = I('toname', '', '');	//接收者名称
		$tohead    = I('tohead', '', '');	//接收者名称
		$toextend  = I('toextend','','');	//接收者的扩展信息
		$content   = I('content',$content,'');	//消息内容
		$extend	   = I('extend','','');		//消息的扩展
		$bodyextend= I('bodyextend','','');	//上传文件扩展
		$imageData = '';	//图片信息			
		$voiceData = '';	//语音信息
		$fileData  = '';    //文件信息
		$location  = '';	//位置信息
		$tag	   = I('tag',$tag);//客户端用的tag标识符
        //检查消息内容是否超出长度
        if (iconv_strlen($content,"UTF-8")>300) return showData(new \stdClass(), '消息限制300字以内', 1);
		//检查用用户是否还在一个群组当中
		$checkAuth = self::checkUser($typechat, $toid, $fromid);
		if ($checkAuth['code']) return $checkAuth;
		//上传文件
		if (!empty($_FILES)) {
			$info = self::upload($uid, $typefile);
			if ($info['status']) {
				$imageData = $info['image'];
				$voiceData = $info['voice'];
				$fileData  = $info['file'];
			}else {
				return showData(new \stdClass(), $info['info'], 1);
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
		$data['extend']		= $extend;
		$data['bodyextend']	= $bodyextend;
		//判断是单聊还是群聊及接收消息的用户
		$uids = self::chatType($typechat, $toid, $fromid);
		if ($uids) $toUids = $uids;
        \Think\Log::write('<<<<<'.date('Y-m-d H:i:s',time()).' SendMessage-START>>>>>','WARN',C('LOG_TYPE'),C('LOG_PATH').date('y_m_d').'-----.log');
		//写入数据表
		$msgid = $this->add($data);
		if ($msgid) {
			$body['id'] = $msgid;
			if (isset($toUids)){
				
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
                //如果接收消息的用户把发送消息的用户拉入黑名单，不进行发消息操作
                $count = M("user_black")->where(array('uid'=>$toid,'fuid'=>$fromid))->count();
                if($count <= 0){
                    $uids = $toid;
                }
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
	   if (isset($_FILES['upload_file'])){
			$md5file  = $_FILES['upload_file']['tmp_name'];
			$fileinfo = M('message_file')->where(array('md5'=>$md5file))->find();
		}else{
			$fileinfo = false;
		}
	    $imageData = $voiceData = $fileData = array();
	    if ($fileinfo){//该文件已上传
	        $str = $fileinfo['savepath'].$fileinfo['savename'];
	        $fileData['url']  = $URL_PATH.ltrim($str,'/');
	        $fileData['name'] = $fileinfo['name'];
	        $fileData['size'] = $fileinfo['size'];
	    }else {
	        $upload   	= new Upload();
	        $upload->rootPath  = $ROOT_PATH;
	        $upload->savePath  = '/Picture/message/'.$uid.'/'; // 设置附件上传目录
	        $upload->exts      = array('jpg','png','gif','mp3','jpeg');// 设置附件上传类型
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
	                }else {
	                    $voiceData['url']   = $URL_PATH.ltrim($URL,'/');
	                    $voiceData['time']	= I('voicetime',0);
	                }
	            }
	        }
	        return array('status'=>1, 'image'=>$imageData, 'voice'=>$voiceData, 'file'=>$fileData);
	    }
	}
}