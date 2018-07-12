<?php
/**
 * 消息推送
 * @author mywind
 *
 */
namespace User\Model;
use Think\Model;
use Think\Log;

class PushModel extends Model {
	protected $tableName    = 'user_push';
	protected $pk        	= 'uid';
	protected $OP_ADMIN 	= "admin";
	protected $OP_BEAUTYAS  = "beautyas";
	
	/**
	 * 获取from内容
	 * @param string $xml 消息
	 * @return string 发送者
	 */
	private function parseFromFiled($xml){
		$start  = strpos($xml, 'from="', 0);
		if($start <= 0) return '';
		$start  = $start + strlen('from="');
		$end    = strpos($xml, '"', $start);
		$newmsg = substr($xml, $start, $end-$start);
		
		return $newmsg;
	}
	/**
	 * 取出json消息体
	 * @param string $xml 消息体
	 * @return string
	 */
	private function parseBodyField($xml){
		$start 	= strpos($xml, '<body>', 0);
		if($start <= 0) return '';
		$start 	= $start + strlen('<body>');
		$end 	= strpos($xml, '</body>', $start);
		$newmsg = substr($xml, $start, $end-$start);
		return $newmsg;
	}
	/**
	 * 推送消息给苹果服务器
	 * @param unknown $uid 接收者
	 * @param unknown $content
	 * @return number 成功返回1，失败返回0
	 */
	private function send2ios_msg($uid, $content, $msgcount = 1){
		$devToken = $this->where(array('uid'=>$uid, 'bnotice'=>1))->getField('udid');
		if ($devToken) {
			// 发送通知
			self::iosmsg($devToken, $content, $msgcount);
		}
	}
	/**
	 * ios推送消息
	 * @param unknown $devToken 设备
	 * @param unknown $msg 消息
	 * @param unknown $badge 消息数量
	 */
	private function iosmsg($devToken, $msg, $badge){
		$deviceToken = $devToken;	//deviceToken
		$passphrase  = C('IOS_PUSH_PASSWD');	//密码
		$message     = $msg;		//推送消息
	
		$ctx = stream_context_create();
		if (C('IOS_PUSH_RELEASE')) {
			//正式
			stream_context_set_option($ctx, 'ssl', 'local_cert', SITE_DIR.'/Data/release.pem');//pem地址
			stream_context_set_option($ctx, 'ssl', 'passphrase', $passphrase);	//证书密码
			//这个为正式的发布地址
			$fp = stream_socket_client("ssl://gateway.push.apple.com:2195", $err, $errstr, 60, STREAM_CLIENT_CONNECT, $ctx);
		}else {
			//测试pem
			stream_context_set_option($ctx, 'ssl', 'local_cert', SITE_DIR.'/Data/develop.pem');//pem地址
			stream_context_set_option($ctx, 'ssl', 'passphrase', $passphrase);	//证书密码
			//这个是沙盒测试地址
			$fp = stream_socket_client('ssl://gateway.sandbox.push.apple.com:2195', $err, $errstr, 60, STREAM_CLIENT_CONNECT|STREAM_CLIENT_PERSISTENT, $ctx);
		}
	
		if (!$fp) return false;
	
		$body['aps'] = array(
				'alert' => $message,
				'sound' => 'default',
				'badge' => (int)$badge
		);
		//Encode the payload as JSON
		$payload = json_encode($body);
		//Build the binary notification
		$msg = chr(0) . pack('n', 32) . pack('H*', $deviceToken) . pack('n', strlen($payload)) . $payload;
	
		fwrite($fp, $msg, strlen($msg));
		fclose($fp);
		return true;
	}
	/**
	 * 推送消息体
	 * @param unknown $typefile
	 * @param unknown $msg
	 */
	private function msg($typefile, $fromname, $content){
		Log::write("handleIosPush msg typefile=$typefile, fromname=$fromname, content=$content");
		$msg = '';
		//用户发送的消息
		switch ($typefile) {
			case 1:
				//文字
				$msg = $fromname.':'.$content;
				break;
			case 2:
				//图片
				$msg = $fromname.':发送了一张图片';
				break;
			case 3:
				//语音
				$msg = $fromname.':发送了一段语音';
				break;
			case 4:
				$msg = $fromname.':发送了一个位置';
		}
		return $msg;
	}
	
	
	/**
	 * 添加通知host
	 */
	function addNoticeHostForIphone($uid){
		$udid    = I('udid');
		$bnotice = I('bnotice') ? I('bnotice') : 1;
	
		$this->where(array('uid'=>$uid))->delete();	//删除掉用户相关
		$this->where(array('udid'=>$udid))->delete();//删除掉设备相关
	
		$ret = $this->add(array('uid'=>$uid, 'udid'=>$udid, 'bnotice'=>$bnotice));
		if ($ret) {
			return showData(new \stdClass(), '操作成功');
		}else {
			return showData(new \stdClass(), '操作失败', 1);
		}
	}
	/**
	 * 移除通知host
	 */
	function removeNoticeHostForIphone($uid){
		$udid    = I('udid');
		if ($this->where(array('uid'=>$uid, 'udid'=>$udid))->delete()){
			return showData(new \stdClass(), '操作成功');
		}else {
			return showData(new \stdClass(), '操作失败', 1);
		}
	}
	
	private function base64_decode_java($str) {
		$tmp = $str;
		
		$tmp = str_replace(" ", "+", $tmp);
		$tmp = str_replace("@", "+", $tmp);
		$tmp = str_replace("*", "/", $tmp);
		$tmp = str_replace("-", "=", $tmp);
		
		return base64_decode($tmp);
	}
	/**
	 * 处理消息推送具体内容
	 */
	function handleIosPush() {
		$data = $_POST['list'];
		$list = (Array)json_decode($data, TRUE);		
		Log::write('data:'.$data);
		foreach ($list as $value) {
			$msg 	= '';
			$str = self::base64_decode_java($value['stanza']);
			$newData= array();
			$newData= json_decode(self::parseBodyField($str), true);//$newData 是消息体
			$fromID = self::parseFromFiled($str);
			//系统通知
			if(strpos($fromID, "admin") !== false || strpos($fromID, "beautyas") !== false ){
				$msg = '';
			}else {
				//群聊
				if ($newData['typechat'] == 200) {
					if (M('group_user', C('DB_PREFIX'), 'DB_CONFIG1')->where(array('groupid'=>$newData['fromid'],'uid'=>$value['username']))->getField('getmsg')) {
						$msg = self::msg($newData['typefile'], $newData['fromname'], $newData['content']);
					}
				}else if ($newData['typechat'] == 300) {
					//会话;
					if (M('session_user', C('DB_PREFIX'), 'DB_CONFIG1')->where(array('sessionid'=>$newData['fromid'],'uid'=>$value['username']))->getField('getmsg')) {
						$msg = self::msg($newData['typefile'], $newData['fromname'], $newData['content']);
					}
				}else {
					
					$msg = self::msg($newData['typefile'], $newData['fromname'], $newData['content']);
				}
			}
			// 3. 发送消息到苹果手机,如果用户不是苹果手机，则直接丢弃该消息。
			if ($msg){
				self::send2ios_msg($value['username'], $msg, $value['msgcount']);//username 用户uid
			}
		}
	}
}