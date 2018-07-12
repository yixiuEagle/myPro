<?php
/**
 * 用户模块
 * @author yangdong
 *
 */
namespace User\Model;
use Think\Model;
use Lincense\Controller\Thinkchat;
use Org\Util\ArrayList;
use Think\Log;
use Common\Model\CommonModel;

class UserModel extends CommonModel {
	public $tableName 	= 'user';
	public $pk        	= 'uid';
	
	public $join     = '';
	public $string   = '';
	public $field    = '';
	
	public static $NOTICE_HAS_DYNAMIC_NEWMSG 		= 1001;	//有人评论
	
	public static $NOTICE_KUAIPAI_ONLINEPERSONS	= 1002;	//快拍在线人数变化（不显示在通知栏）
	public static $NOTICE_KUAIPAI_ZAN 				= 1003;	//快拍点赞（不显示在通知栏）
	public static $NOTICE_KUAIPAI_AUTOMEETING		= 1004;	//快拍自动加入会议（不显示在通知栏）
	public static $NOTICE_KUAIPAI_HASATME			= 1005;	//快拍有人@我
	public static $NOTICE_KUAIPAI_ENDMEETIN			= 1006;	//结束直播（不显示在通知栏）
	public static $NOTICE_KUAIPAI_SETTINGCANCOMMENT			= 1007;	//管理员设置快拍是否可以评论（不显示在通知栏）
	
	public static $NOTICE_POSSHARE_ENTERGROUP			= 1008;	//入群通知（不显示在通知栏）
	public static $NOTICE_POSSHARE_QUITRGROUP			= 1009;	//退群通知（不显示在通知栏）
	public static $NOTICE_POSSHARE_ENDESHARE			= 1011;	//终止共享，所有收到该通知的人都退出共享（不显示在通知栏）
	
	public static $NOTICE_TONGYI_WIFI					=1012; // 同一wifi
	public static $NOTICE_NEARBY_KUAIPAI				= 1013; // 附近快拍消息
	public static $NOTICE_MY_KUAIPAI                                                 =1014;     //我的快拍
	public static $NOTICE_PUSH_MSG                                                   =1015;  //管理员推送消息	
	public static $NOTICE_zan        =1017;  //动态赞
	public static $NOTICE_frienddynamic        =1018;  //好友动态
	public static $maxDistance = 50000000;								// 查询最大距离
	public static $wifiDistance = 5000000;									// 经纬度在多少距离内算同一wifi
	public static $wifiDiffTime = 720000000;								// 2个小时内算同一wifi(秒)
	public static $nearbyKuaipaiDistance = 500000;					// 多少距离算附近快拍
	
	function _initialize(){
		parent::_initialize();
	}
	/**
	 * 用户数据格式化
	 * @param array $user
	 * @param int   $uid
	 */
	private function _format($list, $uid=0){
		$_list = array();
		if ($list) {
			foreach ($list as $k=>$v){
			    $tmp                = $v;
			    if (isset($v['password'])) unset($tmp['password']);
			    //头像
			    if (isset($v['headsmall'])){
			        $tmp['headsmall'] 	= makeHttpHead($v['headsmall']);
			        $tmp['headlarge'] 	= str_replace('/s_', '/', $tmp['headsmall']);
			    }
			    //会员到期日期
			    if (isset($v['memberenddate'])){
			    	$tmp['memberenddate'] 	= $v['memberenddate'];
			    	
			    }
			    
			    //是否是朋友
			    $tmp['isfriend']	    = self::getFriend($uid, $v['uid']);
			    $tmp['isvisible'] = self::getFriendVisible($uid, $v['uid']);
			    //距离
			    if (isset($v['distance'])){
			        $tmp['distance']    = $v['distance'] ? round($v['distance'],2) : 0;
			    }
			    //是否完成资料设置
			    if (isset($v['nickname'])) {
			        $tmp['is_setting'] 	= $v['nickname'] ? 1 : 0;
			    }
			    //家乡
			    if (isset($v['hometown'])) {
			        $hometown = M('hometown')->where(array('id'=>$v['hometown']))->getField('name');
			        $tmp['hometown'] = $hometown ? $hometown : '';
			    }
			    //备注名
			    $remark = M('user_friend')->where(array('uid'=>$uid,'fid'=>$v['uid']))->getField('remark');
			    $tmp['remarkname'] = $remark ? $remark : '';
			    // 是否绑定手机
			    if($v['phone'] != null && $v['safe_phone'] != null) {
			    	$tmp['isbindphone'] = 1;
			    }else{
			    	$tmp['isbindphone'] = 0;
			    }
			    $tmp['money'] = round($tmp['money'],2);
			    $tmp['money'] = (string)$tmp['money'];
			    $tmp['completion'] = 0;
			    // 粉丝数，关注数
			    $tmp['follownum'] = M('user_friend')->where(Array('uid'=>$v['uid']))->count();
			    $tmp['fansnum'] =  M('user_friend')->where(Array('fid'=>$v['uid']))->count();
				$_list[] = $tmp;
			}
		}
		return $_list;
	}
	
	private function _format2($list, $uid=0){
		$_list = array();
		if ($list) {
			foreach ($list as $k=>$v){
				$tmp                = $v;
				if (isset($v['password'])) unset($tmp['password']);
				//头像
				if (isset($v['headsmall']) && strpos($v['headsmall'], "http")===false){
					$tmp['headsmall'] 	= makeHttpHead($v['headsmall']);
					$tmp['headlarge'] 	= str_replace('/s_', '/', $tmp['headsmall']);
				}
				//会员到期日期
				$fee=M('member_fee')->field('fee')->where(array('id'=>1))->find();
				$fee=$fee['fee']*0.8;
				if ($v['memberenddate']){
					$tmp['memberenddate'] 	= $v['memberenddate'];
					if($v['auto_buy_member']){
					    if($v['memberenddate']<NOW_TIME){
					        if($v['money']>=$fee){
					            $new_money = $v['money'] - $fee;
					            $result = M('user')->where(Array('uid'=>$uid))->save(Array('money'=>$new_money)); 
					            self::updateUserMember_xuefeimember($uid, 2);
					            M('user_recharge')->add(Array('id'=>date('Ymd').substr(implode(NULL, array_map('ord', str_split(substr(uniqid(), 7, 13), 1))), 0, 8),'uid'=>$uid,'fee'=>$fee,'createtime'=>NOW_TIME,'status'=>1,'chongzhi_type'=>2,'memberid'=>1));
					        }
					    }
					}
				}else{
				    if($v['auto_buy_member']){
				        if($v['money']>=$fee){
				            $new_money = $v['money'] - $fee;
				            $result = M('user')->where(Array('uid'=>$uid))->save(Array('money'=>$new_money));
				            self::updateUserMember_newmember($uid, 1);
				            M('user_recharge')->add(Array('id'=>date('Ymd').substr(implode(NULL, array_map('ord', str_split(substr(uniqid(), 7, 13), 1))), 0, 8),'uid'=>$uid,'fee'=>$fee,'createtime'=>NOW_TIME,'status'=>1,'chongzhi_type'=>1,'memberid'=>1));
				        } 
				    }   
				}
				$tmp['wifi_ssid']=base64_encode($v['wifi_ssid']);
				//是否是朋友
				$tmp['isfriend']	    = self::getFriend($uid, $v['uid']);
				$tmp['isvisible'] = self::getFriendVisible($uid, $v['uid']);
				//距离
				if (isset($v['distance'])){
					$tmp['distance']    = $v['distance'] ? round($v['distance'],2) : 0;
				}
				//是否完成资料设置
				if (isset($v['nickname'])) {
					$tmp['is_setting'] 	= $v['nickname'] ? '1' : '0';
				}
                $tmp['bind_qq']=$v['bind_qq'] ? '1' : '0';
                $tmp['bind_weixin']=$v['bind_weixin'] ? '1' : '0';
                $tmp['bind_sina']=$v['bind_sina'] ? '1' : '0';
				//家乡
				if (isset($v['hometown'])) {
					//$hometown = M('hometown')->where(array('id'=>$v['hometown']))->getField('name');
					$hometown = $v['hometown'];
					  $tmp['hometown'] = $hometown ? $hometown : '';
				}
				//备注名
				$remark = M('user_friend')->where(array('uid'=>$uid,'fid'=>$v['uid']))->getField('remark');
				$tmp['remarkname'] = $remark ? $remark : '';
				// 是否绑定手机
				if($v['safe_phone'] != null) {
					$tmp['isbindphone'] = 1;
				}else{
					$tmp['isbindphone'] = 0;
				}
				// 计算个人资料完成度
				$completion = floatval(0);
				$singleValue = floatval(14.3);		
				// 头像、姓名、性别、年龄、星座、故乡、职业、个人签名
				if($tmp['headsmall'])
					$completion += $singleValue;
				if($tmp['nickname'])
					$completion += $singleValue;
				if($tmp['gender'] != 2)
					$completion += $singleValue;
				if($tmp['age'] != 0)
					$completion += $singleValue;
				/* if($tmp['xingzuo'])
					$completion += $singleValue; */
				if($tmp['hometown'])
					$completion += $singleValue;
				if($tmp['job'])
					$completion += $singleValue;
				if($tmp['sign'])
					$completion += $singleValue;
				if($completion>=100){
				    $completion=100;
				}
				$tmp['completion'] = $completion;
				$tmp['money'] = round($tmp['money'],2);
				$tmp['money'] =(string)$tmp['money'];
				// 粉丝数，关注数
				$tmp['follownum'] = M('user_friend')->where(Array('uid'=>$v['uid']))->count();
				$tmp['fansnum'] =  M('user_friend')->where(Array('fid'=>$v['uid']))->count();
				
				$_list[] = $tmp;
			}
		}
		return $_list;
	}
	
	private function _formatChangjingUser($list, $uid=0){
		$_list = array();
		if ($list) {
			foreach ($list as $k=>$v){
				$tmp                = $v;
				
				//头像
				if (isset($v['headsmall'])){
					$tmp['headsmall'] 	= makeHttpHead($v['headsmall']);
					
				}
				//是否是朋友
				$tmp['isfriend']	    = self::getFriend($uid, $v['uid']);
				
				//距离
				if (isset($v['distance'])){
					$tmp['distance']    = $v['distance'] ? round($v['distance'],2) : 0;
				}
				
				
				$_list[] = $tmp;
			}
		}
		return $_list;
	}
	
	private function _format_simple($list, $uid=0){
		$_list = array();
		if ($list) {
			foreach ($list as $k=>$v){
				$tmp                = $v;
				if (isset($v['password'])) unset($tmp['password']);
				//头像
				if (isset($v['headsmall'])){
					$tmp['headsmall'] 	= makeHttpHead($v['headsmall']);
					$tmp['headlarge'] 	= str_replace('/s_', '/', $tmp['headsmall']);
				}
				
				$_list[] = $tmp;
			}
		}
		return $_list;
	}
	
	
	/**
	 * 获取好友关系 1-我关注了他 2-他关注了我 3-好友 0-相互未关注
	 * @param unknown $uid
	 * @param unknown $fid
	 */
	public function getFriend($uid, $fid) {
		if($uid == $fid)
			return 0;
		
		$u = M('user_friend')->where(Array('uid'=>$uid, 'fid'=>$fid))->find();
		
		$f = M('user_friend')->where(Array('uid'=>$fid, 'fid'=>$uid))->find();
		
		if($u && $f)
			return 3;
		if($u)
			return 1;
		if($f)
			return 2;
		
		return 0;
	}
	
	/**
	 * 获取好友的可见性
	 * @param unknown $uid
	 * @param unknown $fid
	 */
	public function getFriendVisible($uid, $fid) {
		if($uid == $fid)
			return 1;
		
		
		$u = M('user_friend')->where(Array('uid'=>$uid, 'fid'=>$fid))->find();
		if($u)
			return $u['isvisible'];
		
		return 0;
	}
	/**
	 * 是否黑名单
	 * @param unknown $uid
	 * @param unknown $fid
	 * @return number
	 */
	public function isBlack($uid, $fid) {
		if($uid == $fid)
			return 0;
		
		return 0;
	}
	/**
	 * 取得用户的uid,name headsmall
	 * @param int|string $uid
	 * @return array
	 */
	public function getUserName($uid){
	    $this->field = 'uid, nickname, headsmall';
		return self::public_list($uid, array('u.uid'=>$uid), 1);
	}
	/**
	 * 系统用户名
	 */
	public function systemUserName(){
		return array('uid'=>'admin', 'nickname'=>'admin', 'headsmall'=>'');
	}
	/**
	 * 用户列表
	 * @param array $map
	 * @param int $uid
	 * @return array
	 */
	public function _list($map,$uid){
	    //自定义条件
	    if ($this->string) $map['_string'] = $this->string;
	    //分页
	    $total = $this->alias('u')->where($map)->count();
	    if ($total){
	        $page  = page($total);
	        $limit = $page['offset'] . ',' . $page['limit'];
	    }else {
	        $page  = '';
	    }
	    $list  = $total ? self::public_list($uid, $map, $limit) : array();
	    return showData($list, '', 0, $page);
	}
	/**
	 * 用户列表
	 * @param unknown $map
	 * @param unknown $limit
	 * @param string $order
	 * @param number $uid
	 * @return unknown
	 */
	function public_list($uid, $map, $limit, $order='u.uid asc'){
	    $join = '';
	    //自定义字段
	    if ($this->field) {
	        $field = $this->field;
	    }else {
	        $field = 'u.*';
	    }
	    $field = 'u.*';
	    //自定义联合查询
	    if ($this->join) $join = $this->join;
	    //自定义条件
	    if ($this->string) $map['_string'] = $this->string;
	    //计算距离
	    if (MODULE_NAME == 'User'){//防止从别的类调用也计算距离
	        $lat   = trim(I('lat')); //纬度
	        $lng   = trim(I('lng')); //经度
	        if ($lat && $lng) {
	            //$field .= ',round(get_distance('.$lng.','.$lat.',u.lng,u.lat),2) as distance';
	        	$field .= ",round(getDistance('$lng','$lat',u.lng,u.lat),2) as distance, round(u.money,2) as money";
	            $order  = 'distance asc';
	        }
	    }
	    
	    Log::write("field=" . $field);
	    $list  = $this->alias('u')->field($field)->join($join)->where($map)->order($order)->limit($limit)->select();
	    $_list = $limit ==1 ? self::_format2($list,$uid) : self::_format($list,$uid);
	    if ($list && $limit == 1) {
	        return $_list['0'];
	    }else {
	        return $_list;
	    }
	}
	/**
	 * 获取用户的详细资料
	 * @param int $uid
	 * @return array
	 */
	function user($uid, $fid=0){
		if ($fid && $fid != $uid) {
		    //添加访客记录
		    self::dynamicGuest($uid, $fid, 0);
			$data=$this->public_list($uid, array('uid'=>$fid),1);
            $z=M('zan');
            foreach ($data as $k=>$v){
                $count=$z->where(array('uid'=>$uid,'fid'=>$fid))->count();
                if($count){
                    $data['is_zan']="1";
                }else{
                    $data['is_zan']="0";
                }
            }
            if($data['hometown']){
                $mes=M('hometown')->field('name')->where(array('id'=>$data['hometown']))->find();
                $data['hometown']=$mes['name'];
            }
            $yinshen=M('yinshen')->where(array('uid'=>$uid,'fid'=>$fid))->find();
            if($yinshen){
                $data['is_yinshen']="1";
            }else{
                $data['is_yinshen']="0";
            }
			return showData($data);
		}else {
		    $data=$this->public_list($uid, array('uid'=>$uid), 1);
		    if($data['hometown']){
		        $mes=M('hometown')->field('name')->where(array('id'=>$data['hometown']))->find();
		        $data['hometown']=$mes['name'];
		    }
			return showData($data);
		}
	}
	/**
	 * 1. 注册用户
	 * @param string $phone;
	 * @param string $nickname;
	 */
	function regist($data=array()){
		if ($data) {
			;
		}else {
			$data = array(
					'phone'		=> I('phone'),
					'password'	=> I('password'),
					'createtime'=> NOW_TIME,
					'openfire'	=> rand(100000, 999999),
			);
		}
		// 验证码
		$return = self::checkCode();
		if ($return['code']) return $return;
		
		//检测手机号
		if ($data['phone']){
			if (strlen($data['phone']) == 11 && is_numeric($data['phone'])) {
		
				if ($this->where(array('phone'=>$data['phone']))->count() > 0) {
					return showData(new \stdClass(), '该手机号已注册', 1);
				}
		
		
			}else {
				return showData(new \stdClass(), '手机号格式错误', 1);
			}
		}else {
			return showData(new \stdClass(), '请输入手机号', 1);
		}
		//md5加密
		if (!$data['password']) {
			return showData(new \stdClass(), '请输入密码', 1);
		}else {
			$password = $data['password'];
			$flag=preg_match('/^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{10}$/', $password);
			if($flag){
			    $data['safe_level']=3;
			    $data['pswLevel']=1;
			}else{
			    $data['safe_level']=2;
			}
			$data['password'] = md5($data['password']);
			$data['safe_phone'] = I('phone');
		}
		
		$uid = $this->add($data);
		if ($uid) {
			//注册到openfire
			$thinkchat = new Thinkchat();
			$thinkchat->init(C('OP_SERVER'));
			
			$ret = $thinkchat->regist($uid, $password);
			if($ret['code'] == 0 ){
				return $this->user($uid);
			}else {
				$this->delete($uid);
				return showData(new \stdClass(), '注册失败', 1, '', '注册到openfire失败');
			}
		}else {
			return showData(new \stdClass(), '注册失败', 1);
		}
	}
	/**
	 * 用户登录
	 * @param string $username; 用户名
	 * @param string $password; 密码
	 */
	function login(){
		$phone	  = I('phone');
		$password = I('password');
		$deviceid = I('deviceid');
		$code = I('code');
		$lat =I('lat');
		$lng =I('lng');
		if (!$phone) return showData(new \stdClass(), '请输入手机号', 1);
		if (!$password) return showData(new \stdClass(), '请输入密码', 1);
	
		
		$user = $this->field('uid,phone,deviceid,password,nickname,headsmall,yinsi_type,safe_level,msg_setting,safe_phone,bind_qq,bind_weixin,bind_renren,bind_sina,wurao_start,wurao_end,tixing_comment, tixing_zan, tixing_frienddynamic, tixing_notfriendmsg, tixing_group, kuaipai_sendnearbyperson, kuaipai_videoshow')->where(array('phone'=>$phone))->find();
		if ($user) {
			Log::write("user=" . json_encode($user));
			if ($user['password'] == md5($password)) {
				
				$uid = $user['uid'];
				if($code != null && $code != "") {// 更换手机设备登录了
					$subtime = time()-10*60;
					$where = "uid=$uid and createtime>=$subtime and code=$code";
					if(M("user_safe_code")->where($where)->count() <= 0){
						return showData(new \stdClass(), '更换设备登录失败', 1);
					}
					M("user_safe_code")->where($where)->delete();
					
					M('user')->where(Array('uid'=>$uid))->save(Array('deviceid'=>$deviceid));
						
				}else{
					$user_deviceid = $user['deviceid'];
					Log::write("mydeviceid=" . $user_deviceid);
					
					// 检测是否设置了设备信息，没有就设置。
					if($user_deviceid == "" ||$user_deviceid == null) {
						Log::write("into null");
						M('user')->where(Array('uid'=>$uid))->save(Array('deviceid'=>$deviceid));
					}else{
						Log::write("into null2");
						// 检测是否开启了安全登录验证，开启了，则需要给安全手机发短信，并提示用户使用安全码登录
						$safe_phone = $user['safe_phone'];
						Log::write("safe_phone=" . $safe_phone);
						Log::write("deviceid=" . $deviceid .",user_deviceid=" . $user_deviceid);
						if($safe_phone != null && $safe_phone != "" && $user_deviceid != $deviceid) {
							Log::write("into null3");
							$code  = 123456;//rand(100000, 999999);
							$newdata['phone'] = $safe_phone;
							$newdata['code'] = $code;
							$newdata['uid'] = $user['uid'];
							$newdata['createtime'] = time();
							$newdata['type'] = 5;
							M('user_safe_code')->add($newdata);
							sendSMS($code, $safe_phone);
							
							return showData(new \stdClass(), '您更换了设备登录，需要输入安全验证码，验证码已发送到手机号'.$safe_phone.'的手机上，请查看。', -1);
						}
					}
				}
				//更改用户经纬度
				M('user')->where(Array('uid'=>$uid))->save(Array('lat'=>$lat,'lng'=>$lng));
				$data=$this->user($user['uid']);
				$member = self::getMemberAccess($uid);
				$data['data']['ismember'] = $member ? 1 : 0;
				//在用户身边随机分配机器人
				M('user')->where(array('usertype'=>1,'allot'=>$uid))->setField('allot',0);
				//男机器
				$grobts=M('user')->where(array('usertype'=>1,'allot'=>0,'gender'=>0))->select();
				shuffle($grobts);
				$arr1=array_slice($grobts,0,C('robtcount')*C('man'));
				//女机器
				$mrobts=M('user')->where(array('usertype'=>1,'allot'=>0,'gender'=>1))->select();
				shuffle($mrobts);
				$arr2=array_slice($mrobts,0,C('robtcount')*C('woman'));
				$arr3=array_merge($arr1,$arr2);
				//更改机器人坐标
				foreach ($arr3 as $k=>$v){
				    $loc=$this->returnSquarePoint($lat,$lng,C('dis'));
				    M('user')->where(array('uid'=>$v['uid']))->save(array('allot'=>$uid,'lat'=>$loc['latloc'],'lng'=>$loc['lngloc']));
				}
				$start = mktime(0,0,0,date('m'),date('d'),date('Y'));
				$end   = mktime(23,59,59,date('m'),date('d'),date('Y'));
				$sharecount=M('user_sharerecord')->where("uid=$uid and (isqqzone=1 or isqq=1 or isweixin=1 or isweixinquan=1 or isweibo =1) and createtime>=$start and createtime<$end")->count();
				$data['data']['sharecount']=$sharecount;
				return $data;
			}else {
				return showData(new \stdClass(), '密码错误', 1);
			}
		}else {
			return showData(new \stdClass(), '该帐号不存在', 1);
		}
	}
	
	/**
	 * 隐身登录
	 */
	function invisibleLogin($uid) {
		$lat = I('lat', 0);
		$lng = I('lng', 0);
		
		$data['lat']	= $lat;
		$data['lng']	= $lng;
		$data['logintime'] = time();
		
		$this->where(Array('uid'=>$uid))->save($data);
		
		return showData(new \stdClass());
	}
	/**
	 * 第三方登录
	 * 
	 */
	function thirdLogin(){
	    $type   = trim(I('type', 1));//1-QQ 2-微信 3-微博 4-人人
	    $openid = trim(I('openid'));
	    if (!$openid) return showData(new \stdClass(), '请选择登录方式', 1);
	    //验证是否已登录
	    $data = array('openid'=>$openid, 'type'=>$type);
	    $uid  = $this->where($data)->getField('uid');
	    if ($uid){
	        $info = self::user($uid);
	        return showData($info['data']);
	    }else {
	        $data['nickname']   = trim(I('nickname'));
	        $data['headsmall']  = trim(I('headsmall'));
	        $data['createtime'] = NOW_TIME;
	        $data['openfire']   = rand(100000, 999999);
	        $password           = $data['openfire'];
	        if($type==1){
	            $data['bind_qq']=$openid;
	        }else if($type==2){
	            $data['bind_weixin']=$openid;
	        }else if($type==3){
	            $data['bind_sina']=$openid;
	        }
	        $uid = $this->add($data);
	        if ($uid){
	            //注册到openfire
	            $thinkchat = new Thinkchat();
	            $thinkchat->init(C('OP_SERVER'));
	            
	            $ret = $thinkchat->regist($uid, $password);
	            if($ret['code'] == 0 ){
	                $info = self::user($uid);
	                return showData($info['data']);
	            }else {
	                $this->delete($uid);
	                return showData(new \stdClass(), '登录失败', 1, '', '注册到openfire失败');
	            }
	        }else {
	            return showData(new \stdClass(), '登录失败', 1);
	        }
	    }
	}
	/**
	 * 首页数据
	 * @param number $uid
	 */
	function nearby($uid) {
		$lat = I('lat', 0);
		$lng = I('lng', 0);
		
		$this->checkArguments(Array('lat'=>$lat, 'lng'=>$lng));
		
		$where = " (u.yinsi_type=0 or (u.yinsi_type=1 and if( (select count(*) as count from tc_user_friend f where (f.uid=$uid and f.fid=u.uid) or (f.uid=u.uid and f.fid=$uid)) >1,1=1,1=0)  ) ) ";
		$where .= " and u.uid <> $uid and getDistance('$lng', '$lat', u.lng, u.lat) <= 500000000 ";
		
		$gender = I('gender', 2);
		$logintime = I('logintime', 0);
		$age = I('age', 0);
		if($age){
		    $age=explode(",",$age);
		    $end=mktime(0,0,0,0,0,$age[0]);
		    $start=mktime(0,0,0,0,0,$age[1]);
		}
		$xingzuo = I('xingzuo', '');
		$hometown = I('hometown', 0);
		$bingding = I('bingding', 0);
		
		if($gender==0 || $gender==1)
			$where .= " and u.gender =$gender";
		
		if($logintime)
		    $logintime=NOW_TIME-$logintime;
			$where .= " and u.logintime >= $logintime ";
		if(count($age)==2){
		    $where .= " and u.age >= $start and u.age<=$end ";
		}else if(count($age)==1 && $age!=0){
		    $where .= " and u.age >= $start ";
		}
			
		if($xingzuo){
			$where .= " and u.xingzuo ='$xingzuo'";
		}
		if($hometown)
			$where .= " and u.hometown = $hometown "; 
		$order = 'distance asc';
		// 附近人
		$list = $this->m_db_getlistpage('user u', $where, "*,getDistance('$lng', '$lat', u.lng, u.lat) as distance", $order);
		if($list['code'] != 0)
			return $list;
		// 广告
		$advList=array();
		$advList = self::advlist(0);
		$returndata['advlist'] = $advList;
		$returndata['xianchanglist'] = self::xianchang();
		$returndata['personlist'] = self::_format($list['data'], $uid);
		$z=M('zan');
		foreach ($returndata['personlist'] as $k=>$v){
		    $data=$z->where(array('uid'=>$uid,'fid'=>$v['uid']))->count();
		    if($data){
		        $returndata['personlist'][$k]['is_zan']="1";
		    }else{
		        $returndata['personlist'][$k]['is_zan']="0";
		    }
		}
		return showData($returndata);
	}
	
	
	function xianchang() {
		$xianchang['num'] = 2;
		
		
		$page = $this->m_db_getlistpage("user u, tc_kuaipai k ", "k.uid=u.uid and k.video<>''", "distinct u.headsmall", "k.id desc",1,2);
		$list = $page['data'];
		if($list) {
			foreach ($list as $k=>$v) {
				if (isset($v['headsmall'])){
					$headlist[] = makeHttpHead($v['headsmall']);
				}
				
			}
		}else{
			$headlist = new ArrayList();
		}
		
		$xianchang['headlist'] = $headlist;
		
		return $xianchang;
		
	}
	/**
	 * 获取广告列表
	 * @param number $pos
	 * @return Ambigous <unknown, \Org\Util\ArrayList>
	 */
	function advlist($pos = 0) {
		//if($pos == 0)
		//	$list = M('adv')->field('id,type,img,url')->order('sort desc')->select();
		//else
			$list = M('adv')->where(Array('pos'=>$pos))->field('id,type,img,url')->order('sort desc')->select();
	
		$list = $list ? $list : Array();

		return $list;
	}
	/**
	 * 完善资料
	 * @param unknown $uid
	 *  
	 */
	function completeInfo($uid){
		$head = '';
		if (!empty($_FILES)) {
			$image = upload('/Picture/avatar/', $uid, 'user');
			if (is_string($image)) {
				return showData(new \stdClass(), $image, 1);
			}else {
				$head = $image['0']['smallUrl'];
				$data['headsmall'] = $head;
			}
		}
		$nickname = trim(I('nickname'));
		if (!$nickname) return showData(new \stdClass(), '请输入昵称', 1);
		if (!checkStringLen($nickname, 20)) {
			return showData(new \stdClass(), '昵称不能超过20个字符', 1);
		}
		$data['nickname'] = $nickname;
		
		$gender = trim(I('gender'));
		if ($gender == '') return showData(new \stdClass(), '请选择性别', 1);
		$data['gender'] = $gender;
		
		$age = trim(I('age', 0));
		if($age == 0 ) return showData(new \stdClass(), '请选择年龄', 1);
		$data['age'] = $age;
		//判别星座
		$month=date('m',$age);
		$day=date('d',$age);
		$data['xingzuo']=yige_constellation($month,$day);
		$job  = trim(I('job'));
		if ($job)
		{
			if(!checkStringLen($job, 20))
				return showData(new \stdClass(), '职业不能超过20个字符', 1);
			
			$data['job'] = $job;
		}
		
		$hometown  = trim(I('hometown'));
		if ($hometown)
		{	
			$data['hometown'] = $hometown;
		}
		
		$xingzuo  = trim(I('xingzuo'));
		if ($xingzuo)
		{	
			$data['xingzuo'] = $xingzuo;
		}
		
		$sign = trim(I('sign'));
		//if($sign)
		//{
			if(!checkStringLen($job, 50))
				return showData(new \stdClass(), '签名不能超过50个字符', 1);
			$data['sign'] = $sign;
		//}
		
		if ($data){
			//Log::write('data=' . json_encode($data));
			if ($this->where(array('uid'=>$uid))->save($data)){
				//判断个人资料完善程度
			   $re=M('reward')->where("uid=$uid")->find();
			     if(!$re){	
			   $da=M('user')->field('headsmall,hometown,job,sign')->where("uid=$uid")->find();
			    $list=count(array_filter($da));
			    $max=7;
			    $min=$max/2;
			    if($list==4){
			        $this->where(array('uid'=>$uid))->save(array('money'=>array('exp','money+'.'1'),'worth_user'=>array('exp','worth_user+'.'100')));
			        $reward['uid']=$uid;
			        M('reward')->add($reward);
			        $msg="您的个人信息已全部完善，奖励1元";
			        $this->sendSysNotice($uid,$msg,1016);
    			}else if($list<=$min){
    			    $msg="为了便于社交建议您完善个人信息，完善后将奖励1元";
    			    $this->sendSysNotice($uid,$msg,1016);
    			}
			}
				return $this->user($uid);
			}
			return showData(new \stdClass(), '修改失败', 1);
		}
		return showData(new \stdClass(), '未填写任何资料', 1);
	}
	/**
	 * 个人赞
	 */
	function info_zan($uid){
	    $fid=I('fid',0);
	    if($fid&&$uid){
	        $z=M('zan');
	        if($z->where(array('uid'=>$uid,'fid'=>$fid))->count())
	            return showData(new \stdClass(), '已经赞过了', 1);
	        $zan['fid']=$fid;
	        $zan['uid']=$uid;
	        $data=$z->add($zan);
	        if($data){
	            return showData(new \stdClass(), '赞成功');
	        }else{
	            return showData(new \stdClass(), '赞失败', 1);
	        }
	    }
	}
	/**
	 * 取消赞
	 */
	function info_delzan($uid){
	    $fid=I('fid',0);
	    if($fid&&$uid){
	        $z=M('zan');
	        if(!$z->where(array('uid'=>$uid,'fid'=>$fid))->count())
	            return showData(new \stdClass(), '没有赞过', 1);
	            $data=$z->where(array('uid'=>$uid,'fid'=>$fid))->delete();
	            if($data){
	                return showData(new \stdClass(), '取消赞成功');
	            }else{
	                return showData(new \stdClass(), '取消赞失败', 1);
	            }
	    }
	}
	/**
	 * 2. 修改用户
	 * @param unknown $uid
	 * @return array
	 */
	function editUser($uid){
		$nickname   = trim(I('nickname'));
		$head		= trim(I('head'));
		$extend		= trim(I('extend', '', ''));
		$password   = trim(I('password', '', ''));
		$data = array();
		if ($nickname) $data['nickname'] = $nickname;
		if ($password) $data['password'] = md5($password);
		if ($head) $data['head'] = $head;
		if ($extend) $data['extend'] = $extend;
		if ($data) {
			$this->startTrans();
			if ($this->where(array('uid'=>$uid))->save($data) !== false) {
				if ($password) {	
					$thinkchat = new Thinkchat();
					$thinkchat->init(C('OP_SERVER'));
						
					$ret = $thinkchat->editPasswd($uid, $password);
					if($ret['code'] != 0 ){
						$this->rollback();
						return showData(new \stdClass(), $ret['msg'], 1);
					}
				}
				$this->commit();
				return showData(new \stdClass(), '修改成功');
			}else {
				$this->rollback();
				return showData(new \stdClass(), '修改失败', 1);
			}
		}else {
			return showData(new \stdClass(), '修改成功');
		}
	}
	/**
	 * 3. 删除用户
	 * @param unknown $uid
	 * @return array
	 */
	function deleteUser($uid){
		
		$this->startTrans();
		if ($this->where(array('uid'=>$uid))->delete()) {
			M('group_user')->where(array('uid'=>$uid))->delete(); //删除群组里的用户
			M('session_user')->where(array('uid'=>$uid))->delete();//删除临时会话里的用户
			
			$thinkchat = new Thinkchat();
			$thinkchat->init(C('OP_SERVER'));
			
			$ret = $thinkchat->delete($uid);
			if($ret['code'] != 0 ){
				$this->rollback();
				return showData(new \stdClass(), $ret['msg'], 1);
			}
			
			$this->commit();
			return showData(new \stdClass(), '删除成功');
		}else {
			$this->rollback();
			return showData(new \stdClass(), '删除失败', 1);
		}
	}
	/**
	 * 4. 自定义通知 (比如:好友关系现在应属于扩展通知,是业务服务器处理好友关系的时候,请求sdk服务器代发一条通知)
	 * @param unknown $uid
	 * @param unknown $fid
	 * @param unknown $type
	 * @return array
	 */
	function sendNotice($uid, $fid){
		/* $thinkchat = new Thinkchat();
		$thinkchat->init(C('OP_SERVER'));
		
		$from     = self::getUserName($uid);
		$to 	  = array('toid'=>$fid, 'touid'=>$fid); */
		$type     = I('type');
		$content  = I('content');
		/* if ($thinkchat->notice($from, $to, $type, $content)) {
			return showData(new \stdClass(), '发送成功');
		}else {
			return showData(new \stdClass(), '发送失败', 1);
		} */
		
		return self::sendCustomNotice($uid, $fid, $type, $content);
	}
	
	/**
	 * 发送自定义通知
	 * @param unknown $uid
	 * @param unknown $fid
	 * @param unknown $type
	 * @param unknown $content
	 * @return Ambigous <multitype:, multitype:unknown \Org\Util\string number >
	 */
	private function sendCustomNotice($uid, $fid, $type, $content) {
		$thinkchat = new Thinkchat();
		$thinkchat->init(C('OP_SERVER'));
		
		$from     = self::getUserName($uid);
		//$from=M('user')->field('uid,nickname,headsmall')->where(array('uid'=>$uid))->find();
		$to 	  = array('toid'=>$fid, 'touid'=>$fid);
		
		Log::write("sendCustomNotice from=$from,to=$to, type=$type, content=$content");
		if ($thinkchat->notice($from, $to, $type, $content)) {
			return showData(new \stdClass(), '发送成功');
		}else {
			return showData(new \stdClass(), '发送失败', 1);
		}
	}
	
	/**
	 * 获取单人、多人在线状态
	 * 
	 */
	function onlinestatus() {
		$uids = I('uids', '');
		
		if(!$uids)
			return showData(new \stdClass(), 'uids不能为空', 1);
		
		$thinkchat = new Thinkchat();
		$thinkchat->init(C('OP_SERVER'));
		
		return $thinkchat->onlinestatus($uids);
	}
	
	/**
	 * 根据手机号获取验证码
	 * @return array
	 */
	function getCode(){
		$phone = I('phone');
		$code  = 123456;//rand(100000, 999999);
		$type  = trim(I('type', 0));//0-获取验证码 1-找回密码时获取验证码 2-获取登陆保护手机验证码
		if (!$phone) return showData(new \stdClass(), '请输入手机号码', 1);
		$data  = array('code'=>$code, 'createtime'=>NOW_TIME);
		$map   = array('phone'=>$phone);
	
		if ($type == 1){
			//重置密码
			if (M('user')->where($map)->count()){
				if (M('user_code')->where($map)->count()) {
					M('user_code')->where($map)->save($data);
				}else {
					$data['phone'] = $phone;
					M('user_code')->add($data);
				}
				if (sendSMS($code, $phone, 1)) {
					return showData(array('code'=>$code), '发送验证码成功');
				}else {
					return showData(new \stdClass(), '发送短信验证码失败，请稍后重试', 1);
				}
			}else {
				return showData(new \stdClass(), '该手机号不能注册', 1);
			}
		}else if($type == 0){
			//获取验证码
			if (M('user')->where($map)->count()){
				//已注册
				return showData(new \stdClass(), '手机号已注册', 1);
			}else {
				$isSuccess = false;
				if (M('user_code')->where($map)->count()){
					if ( M('user_code')->where($map)->save($data)) $isSuccess = true;
				}else {
					$data['phone'] = $phone;
					if (M('user_code')->add($data)) $isSuccess = true;
				}
	
				if ($isSuccess) {
					if (sendSMS($code, $phone)) {
						return showData(array('code'=>$code), '发送验证码成功');
					}
				}
			}
		}else if($type == 2) {
			$map['type'] = 1;
			$result = M('user_safe_code')->where($map)->find();
			if($result) {
				if($result['createtime'] > time() - 10*60) {
					return showData(new \stdClass(), '请稍后重试', 1);
				}
				
				M('user_safe_code')->where($map)->delete();
				
				if (sendSMS($code, $phone, 1)) {
					M('user_safe_code')->add(Array('phone'=>$phone, 'code'=>$code, 'createtime'=>time()));
					return showData(array('code'=>$code), '发送验证码成功');
				}else {
					return showData(new \stdClass(), '发送短信验证码失败，请稍后重试', 1);
				}
			}else{
				if (sendSMS($code, $phone, 1)) {
					M('user_safe_code')->add(Array('phone'=>$phone, 'code'=>$code, 'createtime'=>time()));
					return showData(array('code'=>$code), '发送验证码成功');
				}else {
					return showData(new \stdClass(), '发送短信验证码失败，请稍后重试', 1);
				}
			}
		}else if($type == 4) {
			$map['type'] = 2;
			$result = M('user_safe_code')->where($map)->find();
			if($result) {
				if($result['createtime'] > time() - 10*60) {
					return showData(new \stdClass(), '请稍后重试', 1);
				}
				
				M('user_safe_code')->where($map)->delete();
				
				if (sendSMS($code, $phone, 1)) {
					M('user_safe_code')->add(Array('phone'=>$phone, 'code'=>$code,'type'=>2, 'createtime'=>time()));
					return showData(array('code'=>$code), '发送验证码成功');
				}else {
					return showData(new \stdClass(), '发送短信验证码失败，请稍后重试', 1);
				}
			}else{
				if (sendSMS($code, $phone, 1)) {
					M('user_safe_code')->add(Array('phone'=>$phone, 'code'=>$code,'type'=>2,  'createtime'=>time()));
					return showData(array('code'=>$code), '发送验证码成功');
				}else {
					return showData(new \stdClass(), '发送短信验证码失败，请稍后重试', 1);
				}
			}
		}
		return showData(new \stdClass(), '发送短信验证码失败，请稍后重试', 1);
	}
	/**
	 * 验证验证码
	 */
	function checkCode(){
		//两小时过期
		M('user_code')->where(array('createtime'=>array('lt',NOW_TIME-2*60*60)))->delete();
		 
		$phone = I('phone');
		$code  = I('code');
		if (!$phone) return showData(new \stdClass(), '请输入手机号码', 1);
		if (!$code) return showData(new \stdClass(), '请输入验证码', 1);
		$info = M('user_code')->where(array('phone'=>$phone))->find();
		if ($info['code'] == $code) {
			M('user_code')->where(array('phone'=>$phone))->delete();//验证成功就删除
	
			return showData(new \stdClass(), '验证成功');
		}else {
			return showData(new \stdClass(), '验证失败', 1);
		}
	}
	/**
	 * 验证安全手机验证码
	 */
	function checkSafePhoneCode($type = 1){
		//两小时过期
		M('user_safe_code')->where(array('createtime'=>array('lt',NOW_TIME-2*60*60),'type'=>$type))->delete();
			
		$phone = I('phone');
		$code  = I('code');
		if (!$phone) return showData(new \stdClass(), '请输入手机号码', 1);
		if (!$code) return showData(new \stdClass(), '请输入验证码', 1);
		$info = M('user_safe_code')->where(array('phone'=>$phone,'type'=>$type))->find();
		if ($info['code'] == $code) {
			M('user_safe_code')->where(array('phone'=>$phone,'type'=>$type))->delete();//验证成功就删除
	
			return showData(new \stdClass(), '验证成功');
		}else {
			return showData(new \stdClass(), '验证失败', 1);
		}
	}
	/**
	 * 家乡列表
	 * @return array
	 */
	function hometownlist() {
		$parentId = I('parentId', 0);
		if($parentId)
			$list = M('hometown')->where(Array('parentId'=>$parentId))->select();
		else
			$list = M('hometown')->where(Array('parentId'=>0))->select();
		
		$list = $list ? $list : new ArrayList();
		
		return showData($list);
	}
	function hometownlist2() {
		$parentId = I('parentId', 0);
		if($parentId)
			$list = M('hometown')->where(Array('parentId'=>$parentId))->select();
		else
			$list = M('hometown')->select();
	
		$list = $list ? $list : new ArrayList();
	
		return showData($list);
	}
	
	/**
	 * 工作列表
	 * @return array
	 */
	function joblist() {
		$parentId = I('parentId', 0);
		/* if($parentId)
			$list = M('job')->where(Array('parentId'=>$parentId))->select();
		else
			$list = M('job')->select(); */
		if($parentId){
			$list = M('job')->where(Array('parentId'=>$parentId))->select();
		}else{
			$list = M('job')->where('parentId=0')->select();
		}
		
	
		$list = $list ? $list : array();
	
		return showData($list);
	}
	
	/**
	 * 添加取消关注
	 * @param number $uid
	 */
	function follow($uid) {
		$fid  = I('fid', 0);
		$type = I('type', 0);//0-关注 1-取消关注 2-移除粉丝
		self::checkArguments(array('fid'=>$fid));
		
		$data = array(
		    'uid' => $uid,
		    'fid' => $fid
		);
		$db  = M('user_friend');
		if($type == 0) {
		    if ($db->where($data)->count()) return showData(new \stdClass(), '你已关注了该用户', 1);
		    $data['addtime'] = NOW_TIME;
			
			if($db->add($data)) {
			   //$this->money($fid,C('guanzhu'));
			   //添加2价值
			   /*zy修改收益新规则*/
			   $worthuser=M('user')->field('worth_user')->where(array('uid'=>$fid))->find();
			   $level=levelMoney($worthuser['worth_user']);
			   $create=NOW_TIME;
			   $this->worth($fid,$create,C('guanzhu')*$level,1);
			   $this->money($fid, C('guanzhu')*$level);
			   $todata=M('user')->field('nickname,headsmall')->where("uid=$fid")->find();
			   $fromdata=M('user')->field('nickname,headsmall')->where("uid=$uid")->find();
			    //发送私聊消息
 			    $content='我关注了你';
 			    $message = D('Message/Message');
 			    $tid=$fid;
			 $message->msg($uid,$tid,$content,$fromdata,$todata);
			return showData(self::getFriend($uid, $fid), '关注成功');
			}			
			return showData(new \stdClass(), '关注失败', 1);
		}else if($type == 1){
		    if (!$db->where($data)->count()) return showData(new \stdClass(), '你未关注该用户', 1);
		    if ($db->where($data)->delete()) {
		        /*zy修改收益新规则*/
		        $worthuser=M('user')->field('worth_user')->where(array('uid'=>$fid))->find();
		        $level=levelMoney($worthuser['worth_user']);
		        $create=NOW_TIME;
		        $this->worth($fid,$create,C('quxiaoguanzhu')*$level,1);
		        $this->money($fid, C('quxiaoguanzhu')*$level);
		        return showData(self::getFriend($uid, $fid), '取消关注成功');
		    }
		    return showData(new \stdClass(), '取消关注失败', 1);
		}else if($type == 2){
			$data = array(
					'uid' => $fid,
					'fid' => $uid
			);
			if (!$db->where($data)->count()) return showData(new \stdClass(), '不是你的粉丝了', 1);
			if ($db->where($data)->delete()) {
				return showData(self::getFriend($uid, $fid), '移除成功');
			}
			return showData(new \stdClass(), '移除粉丝失败', 1);
		}
	}
	
	/**
	 * 我的好友
	 * @param number $uid
	 */
	function friendlist($uid) {
	    $lat=I('lat');
	    $lng=I('lng');
	    $data      = array();
		// 关注数
		$follownum = M('user_friend')->where(array("uid=$uid and fid <>$uid"))->count();
		$data['follownum']	= $follownum;
		// 粉丝数
		$fansnum   = M('user_friend')->where(array("fid=$uid and uid<>$uid"))->count();
		$data['fansnum']    = $fansnum;
		// 群组数
		$groupnums = M('session_user')->where(array('uid'=>$uid))->count();
		$data['groupnums']	= $groupnums;
		// 好友列表
		$where  = "f.uid=$uid and f.fid in (select f.uid from `" . $this->tablePrefix . "user_friend` f where f.fid=$uid and f.uid=u.uid) and f.uid<>f.fid";
		
		$field  = "u.uid,u.logintime,u.nickname,u.headsmall,u.age,u.sign,u.memberlevel,u.gender,u.job,getDistance('$lat', '$lng', u.lat, u.lng) as distance";
        $table  = 'user_friend f,' .$this->tablePrefix. 'user u';
		$friend = $this->m_db_getlistpage($table, $where, $field);
		
		$data['friendlist']	= self::_format($friend['data'], $uid);
		$data['follownum']=$data['follownum']-count($data['friendlist']);
		$data['fansnum']=$data['fansnum']-count($data['friendlist']);
		return showData($data,'',0, $friend['page']);
	}
	/**
	 * 0-我关注的，1-关注我的  2-我关注的及好友
	 * @param unknown $uid
	 */
	function myfollow($uid) {
		$type = I('type', 0);
		
		if($type == 0){
			$query = 'user_friend f left join ' .$this->tablePrefix. 'user u on u.uid=f.fid';
			$where = "f.uid=$uid and f.fid not in (select f.uid from `" . $this->tablePrefix . "user_friend` f where f.fid=$uid and f.uid=u.uid)";
		} else if($type==1){
			$query = 'user_friend f left join ' .$this->tablePrefix. 'user u on u.uid=f.uid';
			$where = "f.fid=$uid and f.uid not in (select f.fid from `" . $this->tablePrefix . "user_friend` f where f.uid=$uid and f.fid=u.uid)";
		}else if($type==2){
		    $query = 'user_friend f left join ' .$this->tablePrefix. 'user u on u.uid=f.fid';
		    $where = "f.uid=$uid";
		}
		$field  = 'u.uid,u.nickname,u.logintime,u.headsmall,u.age,u.sign,u.memberlevel,u.gender,u.job';
		$friend = $this->m_db_getlistpage($query, $where, $field);
		$friend['data'] = self::_format($friend['data'], $uid);
		return $friend;
	}
	/**
	 * 验证电话号码
	 */
	function isMobile($mobile) {
	    if (!is_numeric($mobile)) {
	        return false;
	    }
	    return preg_match('#^13[\d]{9}$|^14[5,7]{1}\d{8}$|^15[^4]{1}\d{8}$|^17[0,6,7,8]{1}\d{8}$|^18[\d]{9}$#', $mobile) ? true : false;
	}
	/**
	 * 导入手机号码识别关系
	 * @param int $uid
	 * @param string $string 格式 电话1,电话2,电话3
	 * @return number 0-邀请:没有注册 1-添加:已注册 2-已添加:已是朋友
	 */
		function importContact($uid){
	Log::write("phone2");
	Log::write("phone=" . json_encode($_REQUEST));
	    $string = trim(I('phone'));
	    if (!$string) return showData(new \stdClass(), '请导入手机通讯录', 1);
	    $arr  = explode(',', $string);
	    M("user_phone")->where(Array('uid'=>$uid))->delete();
	    $list = array();
	    foreach ($arr as $key=>$v){
	        $mobile=$this->isMobile($v);
	        if($mobile){ //return showData(new \stdClass(), '通讯录号码格式错误', 1);
    	    	$a=M("user_phone")->add(Array('uid'=>$uid, 'phone'=>$v));
    	        $user = $this->field('uid')->where(array('phone'=>$v))->find();
    	        if ($user) {//存在
    	            $mes['phone']=$v;
    	            $mes['isfriend']=self::getFriend($uid, $user['uid']);
    	            if($mes['isfriend']==1 || $mes['isfriend']==3){
    	                continue;
    	            }
    	            $mes['type']=1;
    	            $mes['uid']=$user['uid'];
    	            if($mes['uid']==$uid){
    	                continue;
    	            }
    	            $list[]=$mes;
    	            /* $list[$key]['phone'] 	= $v;
    	            $list[$key]['isfriend'] = self::getFriend($uid, $user['uid']);
    	            $list[$key]['type']  	= 1;
    	            $list[$key]['uid']  	= $user['uid']; */
    	        }else {//不存在  邀请
    	            /* $list[$key]['phone'] 	= $v;
    	            $list[$key]['isfriend'] = 0;
    	            $list[$key]['type']  	= 0;
    	            $list[$key]['uid'] 	    = 0; */
    	            $mes['phone']=$v;
    	            $mes['isfriend']=0;
    	            $mes['type']=0;
    	            $mes['uid']=0;
    	            $list[]=$mes;
    	        }
	      } 
	    }
	    return showData($list);
	}
	/**
	 * 设置备注名
	 */
    function setRemark($uid, $fid){
        $name = trim(I('remark'));
        //if (!$name) return showData(new \stdClass(), '请输入备注内容', 1);
        $data = array('uid'=>$uid, 'fid'=>$fid);
        $db   = M('user_friend');
        if ($db->where($data)->setField('remark', $name)){
            return showData(new \stdClass(), '设置成功');
        }
        return showData(new \stdClass(), '设置失败', 1);
    }	
    /**
	 * 星座列表
	 */
	function xingzuoLists(){
	    $data = M('user_xingzuo')->select();
	    return showData($data);
	}
	/**
	 * 加入黑名单和取消黑名单
	 * @param int $uid
	 * @param int $fuid
	 */
	function black($uid, $fuid) {
	    $type = trim(I('type', 0));//0-加入黑名单 1-取消黑名单
	    $data = array('uid'=>$uid, 'fid'=>$fuid);
	    if ($uid == $fuid) return showData(new \stdClass(), '自己不能拉黑自己', 1);
	    $db   = M('user_black');
	    if ($type){
	        if (!$db->where($data)->count()) return showData(new \stdClass(), '该用户未加入黑名单', 1);
	        if ($db->where($data)->delete()){
	            return showData(new \stdClass(), '取消成功');
	        }
	        return showData(new \stdClass(), '取消失败', 1);
	    }else {
	        if ($db->where($data)->count()) return showData(new \stdClass(), '该用户已加入了黑名单', 1);
	        $data['addtime'] = NOW_TIME;
	        if ($db->add($data)){
	       
	            return showData(new \stdClass(), '添加成功');
	        }
	        return showData(new \stdClass(), '添加失败', 1);
	    }
	}
	/**
	 * 用户的黑名单列表
	 * @param int $uid
	 */
	function blackLists($uid) {
	    // 好友列表
	    $where  = "b.uid=$uid and b.fid in (select f.fid from `" . $this->tablePrefix . "user_black` f where f.uid=$uid and f.fid=u.uid)";
	    $field  = 'u.uid,u.nickname,u.headsmall,u.age,u.sign,u.memberlevel';
	    $table  = 'user_black b,' .$this->tablePrefix. 'user u';
	    $friend = $this->m_db_getlistpage($table, $where, $field, 'b.addtime desc');
	    
	    $data	= self::_format($friend['data'], $uid);
	    
	    return showData($data,'',0, $friend['page']);
	}
	/**
	 * 可能认识的人，推荐的人
	 */
	function recommendList($uid){
	    $data   = array();
	    $field  = 'u.uid,u.nickname,u.headsmall,u.age,u.sign,u.memberlevel';
	    //通讯录好友
	    $string = trim(I('phone'));
	    if ($string) {
	        $where  = 'u.uid in(select `uid` from `'.$this->tablePrefix.'user` where phone in('.$string.'))';
	        //$where  = 'u.uid<>'.$uid.' and u.uid in(select `uid` from `'.$this->tablePrefix.'user` where phone in('.$string.'))';
	        $where .= ' and u.uid not in(select `fid` from `'.$this->tablePrefix.'user_friend` where uid='.$uid.')';
	        $return = self::m_db_getlistpage('user u', $where, $field, 'u.uid desc', 1, 5);
	        $number = 0;
	        if ($return){
	            $count = count($return['data']);
	            $data['recommend'] = self::_format($return['data'], $uid);
	            if ($count<5){
	                //5-count个附近的人
	                $number = 5-$count;
	            }
	        }else {
	            //取5个附近的人
	            $number = 5;
	        }
	        $lat = trim(I('lat',0));
	        $lng = trim(I('lng',0));
	        if ($number){
	            if ($lat && $lng){
	                $order  = 'distance asc';
	                $field .= ",getDistance('$lat', '$lng', 'lat', 'lng') as distance";
	                $list   = self::m_db_getlistpage('user u', array(), $field, $order, 1, 20);
	                $tmp    = self::_format($list['data'], $uid);
	                $tmp_new=array();
	                foreach ($tmp as $k =>$v){
	                    if(count($tmp_new)==$number){
	                        break;
	                    }
	                    if($v['isfriend']!=3 && $v['isfriend']!=1 && $v['uid']!=$uid){
	                        $tmp_new[]=$v;
	                    }
	                }
	                $data['recommend'] = array_merge_recursive($data['recommend'], $tmp_new);
	            }
	        }
	    }else{
	        $number = 5;
	        $lat = trim(I('lat',0));
	        $lng = trim(I('lng',0));
	        if ($lat && $lng){
	            $order  = 'distance asc';
	            $field .= ",getDistance('$lat', '$lng', 'lat', 'lng') as distance";
	            $list   = self::m_db_getlistpage('user u', array(), $field, $order, 1, 20);
	            $tmp    = self::_format($list['data'], $uid);
	            $tmp_new=array();
	            foreach ($tmp as $k =>$v){
	                if($v['isfriend']!=3 && $v['isfriend']!=1 && $v['uid']!=$uid){
	                    $tmp_new[]=$v;
	                }
	                if(count($tmp_new)==$number){
	                    break;
	                }
	            }
	            $data['recommend'] = $tmp_new;
	        }
	    }
	    //可能认识的人 查出好友
	    $where  = 'u.uid in(select `fid` from `'.$this->tablePrefix.'user_friend` where uid in(select `fid` from `'.$this->tablePrefix.'user_friend` where `uid`='.$uid.' and `fid`<>'.$uid.') and `fid`<>`uid`) and u.uid not in(select `fid` from `'.$this->tablePrefix.'user_friend` where `uid`='.$uid.') and u.uid <>'.$uid;
	    $return = self::m_db_getlistpage('user u', $where, $field, 'u.uid desc', 1, 10);
	    $num=0;
	    if(count($return['data'])<10){
	        $num=10-count($return['data']);
	    }
	    $wifi=M('user')->field('wifi_ssid')->where(array('uid'=>$uid))->find();
	    $wifi=$wifi['wifi_ssid'];
	    $where="u.wifi_ssid=$wifi";
	    $near = self::m_db_getlistpage('user u', $where, $field, 'u.uid desc', 1, $num);
	    $return['data']=array_merge_recursive($return['data'],$near['data']);
	    if ($return['data']){
	        $data['list'] = self::_format($return['data'], $uid);
	    }else {
	        $data['list'] = array();
	    }
	    return showData($data);
	}
	
	// 第三方账号好友推荐
	function thirdfriend($uid) {
		$data   = array();
		$field  = 'u.uid,u.nickname,u.headsmall,u.age,u.sign,u.memberlevel';
		
		$type = I('type');
		//$string=M('user')->field('bind_qq,bind_weixin,bind_sina')->where(array('uid'=>$uid))->find();
		//$string = trim(I('openids'));
		

		//if ($string) {
			/* if( substr($string, strlen($string) - 1,1 )=="," )
				$string = substr($string, 0, strlen($string) - 1); */
			
			if($type == "1") {
				$where  = "u.uid in(select `uid` from `".$this->tablePrefix."user` where bind_qq <>'') and u.uid<>" . $uid;
			}
			if($type == "2") {
				$where  = "u.uid in(select `uid` from `".$this->tablePrefix."user` where bind_weixin <>'') and u.uid<>" . $uid;
			}
			if($type == "3") {
				$where  = "u.uid in(select `uid` from `".$this->tablePrefix."user` where bind_sina <>'') and u.uid<>" . $uid;
			}
			
			//$where .= ' and u.uid not in(select `fid` from `'.$this->tablePrefix.'user_friend` where uid='.$uid.')';
			$return = self::m_db_getlistpage('user u', $where, $field, 'u.uid desc', 1, 5);

			
			$return['data'] = self::_format($return['data'], $uid);
		//}
		
		if($return)
			return $return;
		
		return $data;
	}
	/**
	 * 搜索用户列表
	 */
	function search($uid){
	      $name = trim(I('name', ''));
	  
	    if (!$name) return showData(new \stdClass(), '请输入搜索内容', 1);
	 
	    $field  = 'u.uid,u.nickname,u.headsmall,u.age,u.sign,u.memberlevel';
	    $table  = 'user u';
	    $friend = $this->m_db_getlistpage($table, "nickname like '%$name%' or phone like '%$name%' or uid like '%$name%'", $field);
	     
	    $data	= self::_format($friend['data'], $uid);

	    return showData($data,'',0, $friend['page']);
	}
	/**
	 * 转赠
	 * @param number $uid
	 */
	function give($uid, $fuid){
	$money=trim(I('money',0));
	if($money<0.01){
	    return showData(new \stdClass(), '转赠金额不能小于0.01元', 1);
	}
	    $data = array('money'=>$money, 'content'=>trim(I('content')));
	    self::checkArguments($data);
	//判断余额是否足够
        $moneydata=$this->field('money')->where("uid=$uid")->find();
	    if($money >$moneydata['money']){
            return showData(new \stdClass(), '余额不足', 1);
        } 
	    $this->startTrans();
        if ($this->where(array('uid'=>$uid))->save(array('money'=>array('exp', 'money-'.$data['money'])))){
            if ($this->where(array('uid'=>$fuid))->save(array('money'=>array('exp', 'money+'.$data['money'])))){
                $this->commit();
                return showData(new \stdClass(), '赠送成功');
            }
        }
        $this->rollback();
        return showData(new \stdClass(), '赠送失败', 1);
	}
	/**
	 * 举报类型列表
	 * 
	 */
	function jubao_list() {
		$list = $this->m_db_getlist('jubao_type');
		return showData($list);
	}
	
	/**
	 * 举报
	 * @param unknown $uid
	 * 
	 */
	function jubao($uid) {
		$fid = I('fid', 0);
		
		
		$btype = I('btype', 1);
		$content = I('content', '');
		
		if($btype==2 || $btype == 3) {
			if($content == ""){
				return showData('', 'content字段不能为空', 1);
			}
		}
		if($btype == 1) {
			if($fid == 0)
				return showData('', '被举报人不能为空', 1);
		}
		if($btype ==4){
		    $adv=M('adv')->where(array('id'=>$fid))->find();
		    if(!$adv){
		        return showData('', '广告不存在', 1);
		    }
		    if($fid == 0)
		        return showData('', '被举报广告不能为空', 1);
		}
		if($btype==5){
		    if($fid == 0)
		        return showData('', '被举报动态不能为空', 1);
		    $dyc=M('dynamic')->where(array('id'=>$fid))->find();
		    if(!$dyc){
		        return showData('', '动态不存在', 1);
		    }
		}
		if($btype==6){
		    if($fid == 0)
		        return showData('', '被举报群不能为空', 1);
		        $gp=M('session')->where(array('id'=>$fid))->find();
		        if(!$gp){
		            return showData('', '群不存在', 1);
		        }
		}
		
		$type = I('type', 0);
		if(!$type)
			return showData('', '请选择举报类型', 1);
		if($btype==1){
		    $flag=M('jubao')->where(array('uid'=>$uid,'fid'=>$fid,'btype'=>1))->find();
		    if($flag){
		        return showData('', '你已经举报过了', 1);
		    }
		}
		if($btype==3){
		    $flag=M('jubao')->where(array('uid'=>$uid,'content'=>$content))->find();
		    if($flag){
		        return showData('', '你已经举报过了', 1);
		    }
		}
		if($btype==4){
		    $flag=M('jubao')->where(array('uid'=>$uid,'fid'=>$fid,'btype'=>4))->find();
		    if($flag){
		        return showData('', '你已经举报过了', 1);
		    }
		}
		if($btype==5){
		    $flag=M('jubao')->where(array('uid'=>$uid,'fid'=>$fid,'btype'=>5))->find();
		    if($flag){
		        return showData('', '你已经举报过了', 1);
		    }
		}
		if($btype==6){
		    $flag=M('jubao')->where(array('uid'=>$uid,'fid'=>$fid,'btype'=>6))->find();
		    if($flag){
		        return showData('', '你已经举报过了', 1);
		    }
		}
		$data['uid'] = $uid;
		$data['fid'] = $fid;
		$data['content'] = $content;
		$data['btype'] = $btype;
		$data['createtime'] = time();
		$data['type'] = $type;
		
		$result = M('jubao')->add($data);
		if(!$result)
			return showData('', '举报失败', 1);
		//判断是否被举报3次及以上
		if($btype==1){
		    $count=M('jubao')->field('uid')->where(array('fid'=>$fid,'btype'=>1))->select();
		    if(count($count)==3){
		       foreach ($count as $k=>$v){
		           /*zy修改收益新规则*/
		           $worthuser=M('user')->field('money,worth_user')->where(array('uid'=>$v['uid']))->find();
		           $level=levelMoney($worthuser['worth_user']);
		           $create=NOW_TIME;
		           $worthlist=$this->worth($v['uid'],$create,C('shejiaojubao')*$level,3);
		           $this->money($v['uid'], C('shejiaojubao')*$level);
		       }
		       //$worthuser=M('user')->field('money,worth_user')->where(array('uid'=>$fid))->find();
		       //if($worthuser['money']>=0.1&&$worthuser['worth_user']>=10){
		       //$level=levelMoney($worthuser['worth_user']);
		       $create=NOW_TIME;
		       $worthlist=$this->worth($fid,$create,C('shejiaobeijubao'),2);
		       $this->money($fid, C('shejiaobeijubao'));
		       //}
		       if($worthlist){
		           $msg="您被拉黑举报，已被扣除10价值！";
		           $this->sendSysNotice($fid,$msg);
		       }
		    }
		    if(count($count)>3){
		        /*zy修改收益新规则*/
		        //奖励举报人
		        $worthuser=M('user')->field('worth_user')->where(array('uid'=>$uid))->find();
	            $level=levelMoney($worthuser['worth_user']);
	            $create=NOW_TIME;
	            $worthlist=$this->worth($uid,$create,C('shejiaojubao')*$level,3);
	            $this->money($uid, C('shejiaojubao')*$level);
	            //扣除被举报人
	            //$worthuser=M('user')->field('money,worth_user')->where(array('uid'=>$fid))->find();
	            //if($worthuser['money']>=0.1&&$worthuser['worth_user']>=10){
	            //$level=levelMoney($worthuser['worth_user']);
	            $create=NOW_TIME;
	            $worthlist=$this->worth($fid,$create,C('shejiaobeijubao'),2);
	            $this->money($fid, C('shejiaobeijubao'));
	            //}
	            if($worthlist){
	                $msg="您被拉黑举报，已被扣除10价值！";
	                $this->sendSysNotice($fid,$msg);
	            }
		    }
		    return showData('举报成功');
		}else if($btype==3){
		    $userid=M('kuaipai')->field('uid')->where(array('id'=>$content))->find();
		    $userid=$userid['uid'];
		    $count=M('jubao')->field('uid')->where(array('content'=>$content))->select();
		    if(count($count)==3){
		        foreach ($count as $k=>$v){
		            /*zy修改收益新规则*/
		            $worthuser=M('user')->field('money,worth_user')->where(array('uid'=>$v['uid']))->find();
		            $level=levelMoney($worthuser['worth_user']);
		            $create=NOW_TIME;
		            $worthlist=$this->worth($v['uid'],$create,C('jubao')*$level,3);
		            $this->money($v['uid'], C('jubao')*$level);
		        }
		        //扣除快拍发布者
		        //$worthuser=M('user')->field('money,worth_user')->where(array('uid'=>$userid))->find();
		        //if($worthuser['money']>=0.1&&$worthuser['worth_user']>=10){
		        //$level=levelMoney($worthuser['worth_user']);
		        $create=NOW_TIME;
		        $worthlist=$this->worth($userid,$create,C('beijubao'),2);
		        $this->money($userid, C('beijubao'));
		        //}
		        if($worthlist){
		            $msg="您的快拍举报3次或以上，已被扣除20价值！";
		            $this->sendSysNotice($userid,$msg);
		        }
		        M('kuaipai')->where(array('id'=>$content))->delete();
		    }
		    /* if(count($count)>3){
		        //zy修改收益新规则
		        $worthuser=M('user')->field('worth_user')->where(array('uid'=>$uid))->find();
		        $level=levelMoney($worthuser['worth_user']);
		        $create=NOW_TIME;
		        $worthlist=$this->worth($uid,$create,C('jubao')*$level,3);
		        $this->money($uid, C('jubao')*$level);
		        //扣除发布快拍者
		        $worthuser=M('user')->field('money,worth_user')->where(array('uid'=>$userid))->find();
		        //if($worthuser['money']>=0.1&&$worthuser['worth_user']>=10){
		        $level=levelMoney($worthuser['worth_user']);
		        $create=NOW_TIME;
		        $worthlist=$this->worth($userid,$create,C('beijubao')*$level,2);
		        $this->money($userid, C('beijubao')*$level);
		        //}
		        if($worthlist){
		            $msg="您被拉黑举报3次或以上，已被扣除20价值！";
		            $this->sendSysNotice($userid,$msg);
		        }
		    }*/
		    return showData('举报成功'); 
		}else if($btype==4){
		    $count=M('jubao')->field('uid')->where(array('fid'=>$fid,'btype'=>4))->select();
		    if(count($count)==3){
		        foreach ($count as $k=>$v){
		            /*zy修改收益新规则*/
		            $worthuser=M('user')->field('money,worth_user')->where(array('uid'=>$v['uid']))->find();
		            $level=levelMoney($worthuser['worth_user']);
		            $create=NOW_TIME;
		            $worthlist=$this->worth($v['uid'],$create,C('shejiaojubao')*$level,3);
		            $this->money($v['uid'], C('shejiaojubao')*$level);
		        }
		        M('adv')->where(array('id'=>$fid))->delete();
		    }
		    return showData('举报成功');
		}else if($btype==5){
		    $userid=M('dynamic')->field('uid')->where(array('id'=>$fid))->find();
		    $userid=$userid['uid'];
		    $count=M('jubao')->field('uid')->where(array('fid'=>$fid,'btype'=>5))->select();
		    if(count($count)==3){
		        foreach ($count as $k=>$v){
		            /*zy修改收益新规则*/
		            $worthuser=M('user')->field('money,worth_user')->where(array('uid'=>$v['uid']))->find();
		            $level=levelMoney($worthuser['worth_user']);
		            $create=NOW_TIME;
		            $worthlist=$this->worth($v['uid'],$create,C('jubao')*$level,3);
		            $this->money($v['uid'], C('jubao')*$level);
		        }
		        //扣除快拍发布者
		        //$worthuser=M('user')->field('money,worth_user')->where(array('uid'=>$userid))->find();
		        //if($worthuser['money']>=0.1&&$worthuser['worth_user']>=10){
		        //$level=levelMoney($worthuser['worth_user']);
		        $create=NOW_TIME;
		        $worthlist=$this->worth($userid,$create,C('beijubao'),2);
		        $this->money($userid, C('beijubao'));
		        //}
		        if($worthlist){
		            $msg="您的动态举报3次或以上，已被扣除20价值！";
		            $this->sendSysNotice($userid,$msg);
		        }
		        M('dynamic')->where(array('id'=>$fid))->delete();
		    }
		    return showData('举报成功');
		}else if($btype==6){
		    $count=M('jubao')->field('uid')->where(array('fid'=>$fid,'btype'=>6))->select();
		    $gp=M('session')->field('uid,name')->where(array('id'=>$fid))->find();
		    $creator=$gp['uid'];
		    if(count($count)==3){
		       foreach ($count as $k=>$v){
		           /*zy修改收益新规则*/
		           $worthuser=M('user')->field('money,worth_user')->where(array('uid'=>$v['uid']))->find();
		           $level=levelMoney($worthuser['worth_user']);
		           $create=NOW_TIME;
		           $worthlist=$this->worth($v['uid'],$create,C('shejiaojubao')*$level,3);
		           $this->money($v['uid'], C('shejiaojubao')*$level);
		       }
		       //$worthuser=M('user')->field('money,worth_user')->where(array('uid'=>$creator))->find();
		       //if($worthuser['money']>=0.1&&$worthuser['worth_user']>=10){
		       //$level=levelMoney($worthuser['worth_user']);
		       $create=NOW_TIME;
		       $worthlist=$this->worth($creator,$create,C('shejiaobeijubao'),2);
		       $this->money($creator, C('shejiaobeijubao'));
		       //}
		       if($worthlist){
		           $msg="您的群(".$gp['name'].")被举报，已被扣除10价值！";
		           $this->sendSysNotice($creator,$msg);
		       }
		    }
		    if(count($count)>3){
		        /*zy修改收益新规则*/
		        //奖励举报人
		        $worthuser=M('user')->field('worth_user')->where(array('uid'=>$uid))->find();
	            $level=levelMoney($worthuser['worth_user']);
	            $create=NOW_TIME;
	            $worthlist=$this->worth($uid,$create,C('shejiaojubao')*$level,3);
	            $this->money($uid, C('shejiaojubao')*$level);
	            //扣除被举报人
	            //$worthuser=M('user')->field('money,worth_user')->where(array('uid'=>$creator))->find();
	            //if($worthuser['money']>=0.1&&$worthuser['worth_user']>=10){
	            //$level=levelMoney($worthuser['worth_user']);
	            $create=NOW_TIME;
	            $worthlist=$this->worth($creator,$create,C('shejiaobeijubao'),2);
	            $this->money($creator, C('shejiaobeijubao'));
	            //}
	            if($worthlist){
	                $msg="您的群(".$gp['name'].")被举报，已被扣除10价值！";
	                $this->sendSysNotice($creator,$msg);
	            }
		    }
		    return showData('举报成功');
		}
		//扣除被举报人20价值
		/* $create=NOW_TIME;
		$datamoney=M('user')->field('money,worth_user')->where("uid=$fid")->find();
		if($datamoney['money']>=0.2&&$datamoney['worth_user']>=20){
		    $worthdata=$this->worth($fid,$create,C('beijubao'),2);
		    $this->money($fid, C('beijubao'));
		}
		//发送通知
		if($worthdata){
		$msg="您被拉黑举报，已被扣除20价值！";
		$this->sendSysNotice($fid,$msg);
		}
		//奖励举报人20价值
		$worthlist=$this->worth($uid,$create,C('jubao'),3);
		$this->money($uid, C('jubao'));
		return showData('举报成功'); */
	}
	
	/**
	 * 发布
	 * @param unknown $uid
	 * 
	 */
	function publish_kuaipai($uid,$admin_publish=0) {
		$title = I('title', '');
		$picture = '';
		$video = '';
		if (!empty($_FILES)) {
	        
			$image   = array();
			if (!empty($_FILES)) {
				$image = upload_multiple('/dynamic/', 0, 'dynamic');
				if (!is_array($image)) {
					return showData(new \stdClass(), $image, 1);
				}
			}
			
			$width = 0;
			$height = 0;
			
			if ($image){
				Log::write("imagess=" . json_encode($image));
				foreach ($image as $k=>$v){
				    //$path = $v['smallUrl'];
				    $path = $v['originUrl'];
				    if(!$admin_publish){
    					if(strstr($path, ".mp4") || strstr($path, ".MP4")) {
    						  $video = $path;
    						  $width = $v['width'];
    						  $height = $v['height'];
    					}else{
    						$picture = $path;
    					}
				    }else{
				        log::write('imagesumall='.$v['smallUrl']);
				        if(strstr($path, ".mp4") || strstr($path, ".MP4")) {
				            $video = $path;
				            $picture = $v['imgurl'];
				            $width = $v['width'];
				            $height = $v['height'];
				        }else{
				            $picture = $path;
				            $width = $v['width'];
				            $height = $v['height'];
				        }
				    }
					//break;
				}
	
			}
		}
		$lat = I('lat', '');
		$lng = I('lng', '');
		if(!$lat || !$lng)
			return showData('', '需要上传位置信息',1 );
		if(!$picture && !$video)
			return showData('', '图片或视频必须要有一个。',1 );
		
		$tonearyby = I('tonearyby', 0);
		$todynamic = I('todynamic', 0);
		
		$data['uid'] = $uid;
		if($title) $data['title'] = $title;
		$data['lat'] = $lat;
		$data['lng'] = $lng;
		$data['createtime'] = time();
		if(!$video) 
		{
			$data['img'] = $picture;
			$data['width'] = $width;
			$data['height'] = $height;
		}else {
			
			$data['video'] = $video;
			$data['img'] = $picture;
			$data['width'] = $width;
			$data['height'] = $height;
			
		}
		
		
		$this->startTrans();
		
		$kuaipai_result = M('kuaipai')->add($data);
		if(!$kuaipai_result){
			$this->rollback();
			return showData('', '写入快拍失败',1 );
		}else{
		    //统计记录
		    $this->kplist($kuaipai_result);
		}
		
		if($todynamic) {
			unset($data['img']);
			unset($data['video']);
			unset($data['width']);
			unset($data['height']);
			$data['iskuaipai']=1;
			$data['kid']=$kuaipai_result;
			if($video){
			$data['isimg']=2;
			}else if($picture){
			$data['isimg']=1;
			}
			$result = M('dynamic')->add($data);
			if(!$result){
				$this->rollback();
				return showData('', '写入动态失败',1 );
			}else{
			    //统计记录
			    $this->dylist($result);
			}



			if($video){
			    $newdata['path'] = $picture;
			    $newdata['video'] = $video;
			    $newdata['width'] = $width;
			    $newdata['height'] = $height;
			}else {
				
				$newdata['path'] = $picture;
				$newdata['width'] = $width;
				$newdata['height'] = $height;
			}
			$newdata['dynamicid'] = $result;
			$result = M('dynamic_pic')->add($newdata);
			if(!$result)
				return showData('', '写入动态失败',1 );
		}
		
		$this->commit();
		
		//self::sendNearyby($kuaipai_result);
		//通知附近的人
		if(!$video){
		    self::notice_nearby_kuaipai($lat, $lng, $title, $uid);
		    self::notice_tongyi_wifi($uid, $lat, $lng, $title);
		}
		self::notice_my_kuaipai($uid, $title);
		return showData('发布成功' );
	}
	
	//记录
	function kplist($id){
	    //访问统计表
	    $dat['linkid']=$id;
	    $dat['createtime']=NOW_TIME;
	    $visit=D('kuaipai_statistics')->add($dat);
	}
	/**
	 * 快拍列表
	 * @param unknown $uid
	 * @return \Common\Model\array()|Ambigous <\Common\Model\array(), unknown, string>
	 */
	function kuaipai_list($uid) {
		$lat = I('lat', 0);
		$lng = I('lng', 0);
		$type = I('type', 1);
		
		$this->checkArguments(Array('lat'=>$lat, 'lng'=>$lng));
		
		$field = "k.*, u.uid,u.nickname,u.headsmall,round(getDistance('$lng', '$lat', k.lng, k.lat),2) as distance";
		
		if($type == 1) {// 快拍现场
			$where = "  u.uid=k.uid and getDistance('$lng','$lat', k.lng, k.lat)  <= 50000000 and k.video<>''";
			
			$order = 'distance asc';
		}
		if($type == 4){//根据发布时间排序
		    $where = "  u.uid=k.uid and getDistance('$lng','$lat', k.lng, k.lat)  <= 50000000 and k.video<>''";
		    $order='createtime desc';
		}
		if($type == 5){//根据点赞数量排序
		    $where = "u.uid=k.uid and getDistance('$lng','$lat', k.lng, k.lat)  <= 50000000 and k.video<>''";
		    $order='zancount desc';
		}
		if($type == 2) { // 同一wifi
			//$wifi_ssid = I('wifi_ssid', '');
		    $wifi_ssid=M('user')->field('wifi_ssid')->where(array('uid'=>$uid))->find();
		    $wifi_ssid=$wifi_ssid['wifi_ssid'];
			if(!$wifi_ssid) {
				return  showData(array(), 'wifi_ssid不能为空', 0);
			}
			$starttime = time() - wifiDiffTime;
			$where = "  u.uid=k.uid and u.uid<> $uid and u.wifi_ssid='$wifi_ssid' and u.wifi_updatetime>=0  and getDistance('$lng','$lat', u.wifi_lng, u.wifi_lat)  <= ".self::$wifiDistance;
				
			$order = 'k.createtime desc';
		}
		
		if($type == 3) {// 附近快拍
			$where = "  u.uid=k.uid and getDistance('$lng','$lat', k.lng, k.lat)  <= " . self::$nearbyKuaipaiDistance;
		
			$order = 'distance asc';
		}
		if($type == 6){//我的快拍
		    $where="k.uid=$uid and k.uid=u.uid";
		    $order = 'createtime desc';
		}
		if($type == 7) {//快拍照片
		    $where = "u.uid<>$uid and u.uid=k.uid and getDistance('$lng','$lat', k.lng, k.lat)  <= 50000000 and k.video='' and k.img<>''";
		    $order = 'createtime desc';
		}
		$list = $this->m_db_getlistpage('kuaipai k, ' . $this->tablePrefix . 'user u', $where, $field, $order);
		if($list['code'] != 0)
			return $list;
		if($type == 6){
    	   		 foreach ($list['data']  as $k=>$v) {
    	    		    $list['data'][$k]['headsmall'] = makeHttpHead($v['headsmall']);
    	   		     $list['data'][$k]['img'] = makeHttpHead($v['img']);
    			        $list['data'][$k]['hasunread'] = 0;
    	        	
    			    }
    			    return $list;
		}
		foreach ($list['data']  as $k=>$v) {
			$list['data'][$k]['headsmall'] = makeHttpHead($v['headsmall']);
			$list['data'][$k]['img'] = str_replace("s_", "",  makeHttpHead($v['headsmall']));
			$list['data'][$k]['hasunread'] = 0;
			
		}
		
		
		return $list;
	}
	/**
	 * 快拍详细
	 * @param unknown $uid
	 * @param number $id
	 * @return array
	 */
	function kuaipai_detail($uid,$id=0) {
	    $id = $id ? $id : I('id', 0);
	    if (!$id) return showData(new \stdClass(), '请选择快拍', 1);
	    
		
	
		$kuaipai = M('kuaipai')->where(Array('id'=>$id))->find();
		if(!$kuaipai){
			return showData(new \stdClass(), '快拍不存在', 1);
		}
		$kuaipai_admin = $kuaipai['uid'];
		$sql = "select u.uid, u.headsmall,u.nickname, (select count(*) from tc_user_friend f where f.fid=u.uid and f.uid=$uid) as isfollow from tc_user u where u.uid=" . $kuaipai_admin;
		$userModel = new Model();
		$user = $userModel->query($sql);
		$user = $user[0];
		if($user['headsmall'] != null)
			$user['headsmall'] = makeHttpHead($user['headsmall']);
		
		$kuaipai['userinfo'] = $user;
		//判断是否已经浏览过
		if($kuaipai_admin!=$uid){
		    $visitdata=D('kuaipai_visit')->where(array('uid'=>$uid,'linkid'=>$id,'type'=>1))->find();
		    if(!$visitdata){
		        $data['uid']=$uid;
		        $data['linkid']=$id;
		        $data['type']=1;
		        //添加访问记录
		        $visit=D('kuaipai_visit')->add($data);
		        //添加1价值
		        $create=NOW_TIME;
		        $kp=M('kuaipai')->field('uid')->where("id=$id")->find();
		        /*zy修改收益新规则*/
		        $worthuser=M('user')->field('worth_user')->where(array('uid'=>$kp['uid']))->find();
		        $level=levelMoney($worthuser['worth_user']);
		        $worthlist=$this->worth($kp['uid'],$create,C('liulan')*$level,4);
		        $this->money($kp['uid'],C('liulan')*$level);
		        M('kuaipai_statistics')->where(array('linkid'=>$id))->setInc('fee',C('liulan')*$level);
		    }
		    $f=M('kuaipai_statistics')->where("linkid=$id")->find();
		    if($f){
		        $fee['viewcount']=array('exp','viewcount+1');
		        M('kuaipai_statistics')->where("linkid=$id")->save($fee);
		    }
		}
		
		return showData($kuaipai);
	}
	/**
	 * 删除快拍
	 */
	function delete_kuaipai($uid){
	   $kid=I('kid',0);
	    $k=M('kuaipai')->where("id=$kid")->find();
	    if(!$k) 
	        return showData("", "快拍不存在", 1);    
	    $kuaipai=M('kuaipai')->where("id=$kid")->delete();
	    $dy['iskuaipai']=0;
	    $dy['isimg']=0;
	    $dy['kid']=0;
	    $dynamic=M('dynamic')->where("kid=$kid")->save($dy);
	        if($kuaipai&&$dynamic!=false){
	            return showData("", "删除成功", 0);
	        }else{
	            return showData("", "删除失败", 1);
	        }
	        
	}
	/**
	 * 话题列表
	 * @param unknown $uid
	 */
	function huati_list($uid) {
		$list = $this->m_db_getlistpage("huati");
		return $list;
	}
	/**
	 * 发送给周围的人
	 * @param unknown $kuaipai_id
	 */
	private function sendNearyby($kuaipai_id) {
		    $lat=I('lat',0);
	    $lng=I('lng',0);
	    $title=I('title','');
	    $uid=I('uid',0);
	    if($uid){
	       $this->notice_nearby_kuaipai($lat, $lng, $title, $uid);
	    }
	}
	
	/**
	 * 发布动态
	 * @param int $uid
	 */
	function publish_dynamic($uid,$robt_publish=0) {
		$picture = $video = false;
		$image   = array();
		if (!empty($_FILES)) {
			$image = upload_multiple();
			log::write('dynamicfiles='.json_decode($image));
			if (!is_array($image)) {
			    return showData(new \stdClass(), $image, 1);
			}
		}
		$data = array();
		//标题
		$title   = I('title', '');
		//if (!$title) return showData(new \stdClass(), '请输入标题', 1);
		$data['title'] = $title;
		//经纬度
		$lat = I('lat', '');
		$lng = I('lng', '');
// 		if(!$lat || !$lng) {
// 		    return showData(new \stdClass(), '需要上传位置信息',1 );
// 		}else {
		    $data['lat'] = $lat;
		    $data['lng'] = $lng;
// 		}
		//视频图片
		/* if(!$image)
			return showData('', '图片或视频必须要有一个。',1 ); */
		
		$linkurl = I('linkurl', '');
		if($linkurl) {
			checkStringLen($linkurl, 200);
			//title
			if(strpos($linkurl, "www.")===false){
			    $linkurl = "www.".$linkurl;
			}
			if(strpos($linkurl, "http://")===false){
			    $linkurl = SITE_PROTOCOL.$linkurl;
			}else{
			    $linkurl = str_replace("http","https",$linkurl);
			}
			$info=file_get_contents($linkurl);
			preg_match('|<title>(.*?)<\/title>|i',$info,$title);
			$data['linkurl_title'] =$title[1];
			$data['linkurl'] = $linkurl;
			//content
			$meta_tags = get_meta_tags($linkurl);
			$data['linkurl_content'] =$meta_tags['description'];
			if(!$data['linkurl_content']){
			    $data['linkurl_content']='无';			    
			}
			//imgurl
        			  preg_match('/href=\"(.*?)\.ico/i', $info, $match);
			if($match[1]){
            			    $data['linkurl_img'] ='http:'.$match[1].'.ico';
			}else{
			    $data['linkurl_img'] ='http://yimisns.com/Uploads/Picture/avatar/200009/s_7e2f7dbf8a1ed138d0376a43e1281c02.jpg';
			}
		}
		$addr = I('addr', '');
		if($addr) {
			checkStringLen($addr, 200);
			$data['addr'] = $addr;
		}
		$cityname = I('cityname', '');
		if($cityname) {
			$data['cityname'] = $cityname;
		}
		/* $addr_lat = I('addr_lat', '');
		if($addr_lat) {
			$data['addr_lat'] = $addr_lat;
		}
		$addr_lng = I('addr_lng', '');
		if($addr_lng) {
			$data['addr_lng'] = $addr_lng;
		} */
		
		$touids = I('touids', '');
		if($touids){
			$data['touids'] = $touids;
			}

		$data['uid'] = $uid;
		$data['createtime'] = NOW_TIME;
		$data['is_public']=I('is_public',1);
		if($image['0']['imgurl']||$image['1']['imgurl']){
		    $data['isimg']=2;
		}else if($image['0']['smallUrl']||$image['1']['smallUrl']){
		    $data['isimg']=1;
		}
		$dynamicid = M('dynamic')->add($data);
		if(!$dynamicid)
			return showData('', '发布失败',1 );
		$width = 0;
		$height = 0;
		//图片处理
// 		print_r($image);die();
		if ($image){
		    $list=array();
		    Log::write($image);
		      foreach ($image as $k=>$v){
		          if(!$robt_publish){
    		          if(strpos($v['smallUrl'], ".mp4") === false&&$v['key']!='cover'){//图片
        		         $list['dynamicid']=$dynamicid;
        		         $list['path']=$v['smallUrl'];
        		         $list['width']=$v['width'];
        		         $list['height']=$v['height'];
    		          }else if($v['key']=='cover'){
    		              $list['cover']=$v['smallUrl'];
    		          }else if(strpos($v['smallUrl'], ".mp4") !== false){
    		              $list['video']=$v['smallUrl'];
    		              $list['dynamicid']=$dynamicid;
    		          }
		          }else{
		              $list['dynamicid'] = $dynamicid;
		              $list['path']=$v['smallUrl'];
		              $list['video']=$v['imgurl'];
        		      $list['width']=$v['width'];
        		      $list['height']=$v['height'];
		          }
		      }
// 		      print_r($list);die();
		      M('dynamic_pic')->add($list);
		}
		$where  = "uid=$uid and fid in (select uid from `" . $this->tablePrefix . "user_friend` where fid=$uid) and uid<>fid";
		$friend=M('user_friend')->where($where)->select();
		foreach ($friend as $k => $v){
		    $frienddynamic=M('user')->field('tixing_frienddynamic')->where(array('uid'=>$v['fid']))->find();
		    if($frienddynamic['tixing_frienddynamic']){
		        $map['id']=(string)$dynamicid;
		        $map['iskuaipai']='0';
		        self::sendSysNotice($v['fid'], json_encode($map), UserModel::$NOTICE_frienddynamic);
		    }
		}
		//记录
		$this->dylist($dynamicid);
		//分享
		$is_share=I('is_share',0);
		if($is_share){
		 $type=1;
		 $share['shareurl']=$this->shareurl($type,$dynamicid,'');
		 $share['dynamic_id']=$dynamicid;
		   return showData($share, '发布成功');
		}
		$result_id['dynamic_id']=$dynamicid;
		$result_id['shareurl']='http://www.yimisns.com/yimisns.com/index.php/user/api/sharepage?type=1&id='.$dynamicid;
		 return showData($result_id);
		
	}
	//记录
	function dylist($id){
	    //访问记录表
	    $create=NOW_TIME;
	    $dat['linkid']=$id;
	    $dat['createtime']=$create;
	    $visit=D('dynamic_statistics')->add($dat);
	}
	//动态未读数量
	function dynamic_unreadnum($uid) {
		$unread = M('dynamic_comment')->where(Array('replyuid'=>$uid, 'isvisible'=>0))->count();
		
		return showData($unread);
	}
	/**
	 * 删除动态
	 */
	function delete_dynamic($uid){
	    $id=I("id",0);
	    if($id){
	        M()->startTrans();
	        //unlink()
	        //删除评论
	        $result_comment = M("dynamic_comment")->where(array("linkid"=>$id))->delete();
	        //删除图片视频
	        $result_pic = M("dynamic_pic")->where(array("dynamicid"=>$id))->delete();
	        //删除动态
	        $result = M("dynamic")->where(array("id"=>$id,"uid"=>$uid))->delete();
	        if($result){
	            M()->commit();
	            return showData(new \stdClass(), '删除成功', 0);
	        }else{
	            M()->rollback();
	            return showData(new \stdClass(), '删除失败', 1);
	        }
	    }else{
	        return showData(new \stdClass(), '请选择动态', 1);
	    }
	}
	// 动态未读消息列表
	function dynamic_unread_list($uid) {
		
		$where = "dc.linkid=d.id and dc.replyuid=$uid and dc.isvisible=0";
		$field = "d.*, dc.id as commentid";
		$order = "dc.id desc";
		$list = $this->m_db_getlistpage('dynamic d, tc_dynamic_comment dc', $where, $field, $order);
		// 更新状态为已读
		$this->m_db_update('dynamic d, tc_dynamic_comment dc', $where, Array('isvisible'=>1));
		
		$datalist = $list['data'];
		foreach ($datalist as $k=>$v) {
			$commentid = $v['commentid'];

			$comment = $this->m_db_getone("dynamic_comment dc, tc_user u", "u.uid=dc.uid and dc.id=" . $commentid, "dc.id,dc.content,dc.createtime,u.nickname,u.uid,u.headsmall");
			//头像
			if (isset($comment['headsmall'])){
				$comment['headsmall'] 	= makeHttpHead($comment['headsmall']);
				$comment['headlarge'] 	= str_replace('/s_', '/', $comment['headsmall']);
			}
			$datalist[$k]['comment']  = $comment;
			
			$attachment = $this->m_db_getone("dynamic_pic","dynamicid=" . $v['id'], "*");
			if($attachment) {
				if (isset($attachment['path'])){
					$attachment['path'] 	= makeHttpHead($attachment['path']);
					
				}
				if (isset($attachment['video'])){
					$attachment['video'] 	= makeHttpHead($attachment['video']);
						
				}
				
				$datalist[$k]['attachment']  = $attachment;
			}else {
				$datalist[$k]['attachment']  = new \stdClass();
			}
			
		}
		$list['data'] = $datalist;
		
		return $list;
	}
	
	/**
	 * 附近动态列表
	 * @param unknown $uid
	 */
	function dynamic_nearby($uid) {
		$lat = I('lat', 0);
		$lng = I('lng', 0);
	
		$this->checkArguments(Array('lat'=>$lat, 'lng'=>$lng));

		
		$where = "u.uid=d.uid and u.uid not in (select y.uid from " .$this->tablePrefix. "yinshen y where y.fid=$uid) and getDistance('$lng', '$lat', d.lng, d.lat) <= 50000000 and d.is_public=1 and d.isalbum=0 and (d.touids='' or d.touids like '%$uid%')";
		$field = "u.uid, u.nickname, u.headsmall,u.gender,u.logintime,u.age,u.job,u.memberlevel, d.*, getDistance('$lng', '$lat', d.lng, d.lat) as distance";
		$order = 'distance asc';
		
		$list = $this->m_db_getlistpage('dynamic d, ' . $this->tablePrefix . 'user u', $where, $field, $order);
	
		if($list['code'] != 0)
			return $list;
	
		// 广告
		$advList = self::advlist(2);
	
		$returndata['advlist'] = $advList;
		foreach ($list['data'] as $k =>$v){
		    if(!$v['addr']){
		        $addr=getDetailAddress($v['lat'],$v['lng']);
		        $v['addr']=$addr['result']['formatted_address'];
		    }
		    $list['data'][$k]=$v;
		}
		$returndata['personlist'] = self::_formatDynamic($list['data']);
	
		$list['data'] = $returndata;
		return $list;
	}
	/**
	 * 好友动态列表
	 * @param unknown $uid
	 */
	function dynamic_friend($uid) {
		$lat = I('lat', 0);
		$lng = I('lng', 0);
		$this->checkArguments(Array('lat'=>$lat, 'lng'=>$lng));
		
		$where = "u.uid=d.uid and u.uid in (select f.fid from " .$this->tablePrefix. "user_friend f where f.uid=$uid) and u.uid not in (select y.uid from " .$this->tablePrefix. "yinshen y where y.fid=$uid) and d.is_public=1 and d.isalbum=0 and (d.touids='' or d.touids like '%$uid%')";
		$field = "u.uid, u.nickname, u.headsmall,u.gender,u.logintime,u.age,u.job,u.memberlevel, d.*";
		$order = 'd.createtime desc';
	
		$list = $this->m_db_getlistpage('dynamic d, ' . $this->tablePrefix . 'user u', $where, $field, $order);
	
		if($list['code'] != 0)
			return $list;
	
		// 广告
		$returndata['advlist'] = array();
		foreach ($list['data'] as $k =>$v){
		    $dis=$this->getDistance($lat,$lng,$v['lat'],$v['lng']);
		    $v['distance']=$dis;
		    if(!$v['addr']){
		        $addr=getDetailAddress($v['lat'],$v['lng']);
		        $v['addr']=$addr['result']['formatted_address'];
		    }
		    $list['data'][$k]=$v;
		}
		$returndata['personlist'] = self::_formatDynamic($list['data']);
	
		$list['data'] = $returndata;
		
		return $list;
	}
	
	/**
	 * 他的动态
	 * @param unknown $uid
	 */
	function dynamic_list($uid) {
	    
		$lat = I('lat', 0);
		$lng = I('lng', 0);
		$fid = I('fid', 0);
		if($uid!=$fid){
		    $is_yinshen=M('yinshen')->where(array('uid'=>$fid,'fid'=>$uid))->find();
		    if($is_yinshen){
		        return showData(new \stdClass());
		    }
		    $this->checkArguments(Array('lat'=>$lat, 'lng'=>$lng, 'fid'=>$fid));
		    //添加访客记录
		    self::dynamicGuest($uid, $fid, 1);
		    $where = "u.uid=d.uid and d.uid=$fid and d.is_public=1 and d.isalbum=0 and (d.touids='' or d.touids like '%$uid%')";
		}else{
		    //$where = "u.uid=d.uid and d.uid=$fid and d.isalbum=0 and (d.touids='' or d.touids like '%$uid%')";
		    $where = "u.uid=d.uid and d.uid=$fid and d.isalbum=0 ";
		}
		
		$field = 'u.uid, u.nickname, u.headsmall,u.gender,u.logintime,u.age,u.job,u.memberlevel';//用户信息
		$field .= ", d.*";//动态信息
		$order = 'd.createtime desc';
		//是不是会员
		/* $m=M('user_member')->where("uid=$uid")->find();
	  	//  有没有关注
		$w=M('user_friend')->where("uid=$uid and fid=$fid")->find();
	 	   if($w||$m){
	   	     $currPage=0;
	  	      $pageSize=0;
		        }else{
	  	          $currPage=1;
	  	          $pageSize=8;
		        } */
		$list = $this->m_db_getlistpage('dynamic d, ' . $this->tablePrefix . 'user u', $where, $field, $order);
	
		if($list['code'] != 0)
			return $list;
		// 广告
		$returndata['advlist'] = array();
		foreach ($list['data'] as $k =>$v){
		    $dis=$this->getDistance($lat,$lng,$v['lat'],$v['lng']);
		    $v['distance']=$dis;
		    if(!$v['addr']){
		        $addr=getDetailAddress($v['lat'],$v['lng']);
		        $v['addr']=$addr['result']['formatted_address'];
		    }
		    $list['data'][$k]=$v;
		}
		$returndata['personlist'] = self::_formatDynamic($list['data']);
	
		$list['data'] = $returndata;
		return $list;
	}
	/**
	 * 动态详细
	 * @param unknown $uid
	 * @param number $id
	 * @return array
	 */
	function dynamic_detail($uid, $id=0) {
		$lat = I('lat', 0);
		$lng = I('lng', 0);
		$id = $id ? $id : I('id', 0);
		//$type = I('type',0);
		//非会员用户1天在没有关注对方前最多能看8个个人动态
		$member=M('user')->field('memberenddate,memberlevel')->where(array('uid'=>$uid))->find();
		if($member['memberenddate']<NOW_TIME || $member['memberlevel']==0){
		    $start = mktime(0,0,0,date('m'),date('d'),date('Y'));
		    $end   = mktime(23,59,59,date('m'),date('d'),date('Y'));
		    $users=M('dynamic_visit')->alias('dv')->field('d.uid')->join('left join '.C('DB_PREFIX').'dynamic d on dv.linkid=d.id')->where(array('dv.uid'=>$uid))->select();
		    $users=$users?$users:array();
		    $fids=M('user_friend')->field('fid')->where(array('uid'=>$uid))->select();
		    $fids=$fids?$fids:array();
		    $res=array_diff($users,$fids);
		    if(count($res)>=8){
		        return  showData(new \stdClass(), '非会员最多只能看8个', 1);
		    }
		}
		//if($type==1){
		    //判断是否已经浏览过
		    $visitdata=D('dynamic_visit')->where(array('uid'=>$uid,'linkid'=>$id,'type'=>1))->find();
		    if(!$visitdata){
		        $data['uid']=$uid;
		        $data['linkid']=$id;
		        $data['type']=1;
		        $data['createtime']=NOW_TIME;
		        //添加访问记录
		        $visit=D('dynamic_visit')->add($data);
		        //添加1价值
		        $create=NOW_TIME;
		        $dy=M('dynamic')->field('uid')->where("id=$id")->find();
		        /*zy修改收益新规则*/
		        $worthuser=M('user')->field('worth_user')->where(array('uid'=>$dy['uid']))->find();
		        $level=levelMoney($worthuser['worth_user']);
		        $list=$this->money($dy['uid'],C('liulan')*$level);
		        $worthlist=$this->worth($dy['uid'],$create,C('liulan')*$level,9);
		        M('dynamic_statistics')->where(array('linkid'=>$id))->setInc('fee',C('liulan')*$level);
		    }
		    $fe=M('dynamic_statistics')->where("linkid=$id")->find();
		    if($fe){
		        $dat['viewcount']=array('exp','viewcount+1');
		        //更新访问记录
		        $visit=D('dynamic_statistics')->where("linkid=$id")->save($dat);
		    }
		//}else{//动态详细
    		$where = "u.uid=d.uid and d.id=$id";
    		$field = "u.uid, u.nickname, u.headsmall,u.gender,u.logintime,u.age,u.job,u.memberlevel, d.*";
    		$order = 'd.createtime desc';
    		
    		$info = $this->m_db_getone('dynamic d, ' . $this->tablePrefix . 'user u', $where, $field);
    		$dis=$this->getDistance($lat,$lng,$info['lat'],$info['lng']);
    		$info['distance']=$dis;
		    if(!$info['addr']){
		        $addr=getDetailAddress($info['lat'],$info['lng']);
		        $info['addr']=$addr['result']['formatted_address'];
		    }
    		$info = self::_formatDynamicDetail($info, $uid);
    		return showData($info);
		//}
	}
	
	private function _formatDynamic($list) {
		$_list = array();
		if ($list) {
			foreach ($list as $k=>$v){
			    $tmp = $v;
			    
			    $tmp['headsmall'] 	= makeHttpHead($v['headsmall']);
			    $tmp['headlarge'] 	= str_replace('/s_', '/', $tmp['headsmall']);
			    /*
				$tmp['uid'] 		= $v['uid'];
				$tmp['nickname'] 	= $v['nickname'];

				$tmp['gender']		= $v['gender'];//0-男 1-女 2-未填写
				$tmp['logintime'] 	= $v['logintime'];
				$tmp['age'] 			= $v['age'];
				$tmp['job'] 			= $v['job'];
				$tmp['memberlevel'] 	= $v['memberlevel'];
				$tmp['distance'] 		= isset($v['distance']) ? round($v['distance'], 2) : 0;
		
				$tmp['id']				= $v['id'];
				$tmp['title']			= $v['title'];
				$tmp['content']			= $v['content'];
				$tmp['sharecount']		= $v['sharecount'];
				$tmp['zancount']		= $v['zancount'];
				$tmp['commentcount']	= $v['commentcount'];
				$tmp['createtime']		= $v['createtime'];
				*/
			    
			    $tmp['linkurl']			= $v['linkurl'];
			    $tmp['linkurl_title']			= $v['linkurl_title'];
			    $tmp['linkurl_img']			= $v['linkurl_img'];
			    
				$tmp['addr']			= $v['addr'];
				$tmp['cityname']		= $v['cityname'];
				//$tmp['addr_lat']		= $v['addr_lat'];
				//$tmp['addr_lng']		= $v['addr_lng'];
				
				// 是否赞
				$currUid = I('uid', 0);
				$isZan = M('dynamic_zan')->where(Array('linkid'=>$v['id'], 'uid'=>$currUid))->count();
				$tmp['iszan']			= $isZan ? 1 : 0;
				
				// 动态图片
				$picList = M('dynamic_pic')->where(Array('dynamicid'=>$v['id']))->select();
				$tmp['attachment'] = $picList ? $picList : array();
				
				// 获取最新10个赞的内容
				$tmp['zanlist']			= self::zan_list($v['id'],10);
		
				// 获取评论列表
				$commentList = self::comment_list($v['id'], 10);
				if($commentList){
					$tmp['commentlist']		= $commentList['data'];
				} else {
				    $tmp['commentlist']		= array();
				}
				
				$_list[] = $tmp;
			}
		}
		return $_list;
	}
	private function _formatDynamicDetail($v, $uid) {
		$tmp = array();
		if ($v != null) {
				$tmp['uid'] 			= $v['uid'];
				$tmp['nickname'] 	= $v['nickname'];
				$tmp['headsmall'] 	= makeHttpHead($v['headsmall']);
				$tmp['headlarge'] 	= str_replace('/s_', '/', $v['headsmall']);
				$tmp['gender']		= $v['gender'];//0-男 1-女 2-未填写
				$tmp['logintime'] 	= $v['logintime'];
				$tmp['age'] 			= $v['age'];
				$tmp['job'] 			= $v['job'];
				$tmp['memberlevel'] 	= $v['memberlevel'];
				$tmp['distance'] 		= $v['distance'] ? $v['distance'] : 0;
	
				$tmp['id']				= $v['id'];
				$tmp['title']			= $v['title'];
				$tmp['content']			= $v['content'];
				$tmp['sharecount']		= $v['sharecount'];
				$tmp['zancount']		= $v['zancount'];
				$tmp['commentcount']	= $v['commentcount'];
				$tmp['createtime']		= $v['createtime'];
				$tmp['linkurl']			= $v['linkurl'];
				$tmp['linkurl_title']			= $v['linkurl_title'];
				$tmp['linkurl_img']			= $v['linkurl_img'];
				$tmp['addr']			= $v['addr'];
				$tmp['cityname']		= $v['cityname'];
				$tmp['lat']		= $v['lat'];
				$tmp['lng']		= $v['lng'];
				
				// 是否赞
				$currUid = I('uid', 0);
				$isZan = M('dynamic_zan')->where(Array('linkid'=>$v['id'], 'uid'=>$currUid))->count();
				$tmp['iszan']			= $isZan ? 1 : 0;
				
				// 动态图片
				$picList = M('dynamic_pic')->where(Array('dynamicid'=>$v['id']))->select();
				$tmp['attachment'] = $picList ? $picList : array();
	
				// 获取最新10个赞的内容
				$tmp['zanlist']			= self::zan_list($v['id'],10);
				
				// 获取评论列表
				//$commentList = self::comment_list($v['id'], 20);
				$commentList = self::comment_list($v['id'], 3);
				if($commentList){
					$tmp['commentlist']		= $commentList['data'];
				}
				else 
					$tmp['commentlist']		= array();
	
				// 判断是否赞过
				$result = M('dynamic_zan')->where(Array('linkid'=>$v['id'], 'uid'=>$uid))->find();
				if($result)
					$tmp['iszan'] = 1;
				else 
					$tmp['iszan'] = 0;
			
		}
		return $tmp;
	}
	/**
	 * 访客记录
	 * @param number $uid
	 * @param number $fuid
	 * @param number $type 0-用户的访客 1-动态的访客
	 */
	function dynamicGuest($uid, $fuid, $type=0){
	    if ($uid != $fuid){
	        $data  = array('uid'=>$uid, 'fuid'=>$fuid, 'type'=>$type);
	        $map   = $data;
	        $start = mktime(0,0,0,date('m'),date('d'),date('Y'));
	        $end   = mktime(23,59,59,date('m'),date('d'),date('Y'));
	        $map['createtime'] = array('between', "$start,$end");
	        if (M('dynamic_guest')->where($map)->count()){
	            //更新时间
	            M('dynamic_guest')->where($map)->setField('createtime', NOW_TIME);
	        }else {
	            $data['createtime'] = NOW_TIME;
	            M('dynamic_guest')->add($data);
	        }
	    }
	}
	/**
	 * 访客列表
	 * @param unknown $uid
	 */
	function dynamic_guest($uid) {
	/* 	$lat  = I('lat', 0);
		$lng  = I('lng', 0); */
		
		$fid = I('fid', 0);
		$is_yinshen=M('yinshen')->where(array('uid'=>$fid,'fid'=>$uid))->find();
		if($is_yinshen){
		    return showData(new \stdClass());
		}
		$type = I('type',0);//1--我的动态访客 0-谁看过我资料
		
		//self::checkArguments(Array('lat'=>$lat, 'lng'=>$lng, 'fid'=>$fid));
		/* select u.uid, u.headsmall
		 from tc_user u, tc_dynamic_guest g 
		 where g.uid=u.uid and g.type=0 and g.fuid=200007 */
		$addr=M('user')->field('lat,lng')->where(array('uid'=>$fid))->find();
		$lat=$addr['lat'];
		$lng=$addr['lng'];
		$order = "g.id desc";
		$where = "g.uid=u.uid and g.type=$type and g.fuid=$fid";

		$field = "u.*,getDistance('$lng', '$lat', u.lng, u.lat) as distance";
		$list = $this->m_db_getlistpage('user u, tc_dynamic_guest g', $where, $field, $order);		
		$list['data'] = self::_format_simple($list['data'], $uid);
		return $list;
		
	}
	function num_guest($uid){
        $list['num']=M('dynamic_guest')->where(array('fuid'=>$uid))->count('distinct(uid)');
	    return showData($list);
	}
	/**
	 * 删除相册图片
	 */
	function album_delete($uid){
        $id=I('id',0);
	    if($id){
	        $dyc=M('dynamic_pic')->where(array('dynamicid'=>$id))->delete();
	        $dy=M('dynamic')->where(array('id'=>$id))->delete();
	        if($dyc&&$dy){
	            return  showData(new \stdClass(), '删除成功', 0);
	        }else{
	            return  showData(new \stdClass(), '删除失败', 1);
	        }
	    }
	}
	/**
	 * 相册添加图片
	 */
	function add_album($uid){
	    if($_FILES){
	        $count=M('dynamic')->where(array('uid'=>$uid,'isalbum'=>1))->count();
	        if($count>=9) return showData(new \stdClass(), '加入会员即可上传无限量照片',0);
	        $image=upload_multiple();
	        $data['isimg']=1;
	        foreach ($image as $k=>$v){
	            if(strpos($v['smallUrl'], ".mp4") !== false){
	                $data['isimg']=2;
	            }
	        }
	        $data['uid']=$uid;
	        $data['createtime']=NOW_TIME;
	        $data['isalbum']=1;
	        $dynamicid = M('dynamic')->add($data);
	        if ($image){
	            $list=array();
	            foreach ($image as $k=>$v){
	                    if(strpos($v['smallUrl'], ".mp4") === false&&$v['key']!='cover'){//图片
	                        $list['dynamicid']=$dynamicid;
	                        $list['path']=$v['smallUrl'];
	                        $list['width']=$v['width'];
	                        $list['height']=$v['height'];
	                    }else if($v['key']=='cover'){
	                        $list['cover']=$v['smallUrl'];
	                    }else if(strpos($v['smallUrl'], ".mp4") !== false){
	                        $list['video']=$v['smallUrl'];//视频
	                    }
	            }
	            M('dynamic_pic')->add($list);
	        }
	        
	        return  showData(new \stdClass(), '上传成功', 0);
	    }else{
	        return  showData(new \stdClass(), '请选择文件', 1);
	    }
	}
	/**
	 * 相册列表
	 * @param unknown $uid
	 * @return unknown
	 */
	function album_list($uid) {
			$fid = I('fid',$uid);
		$is_yinshen=M('yinshen')->where(array('uid'=>$fid,'fid'=>$uid))->find();
		if($is_yinshen){
		    return showData(new \stdClass());
		}
		//判断访问人是不是自己
	   if($uid==$fid){
		$where = "dp.dynamicid=d.id and d.uid=$uid and (dp.path<>'' or dp.video<>'') and iskuaipai=0";
		
	   }else{
	    $where = "dp.dynamicid=d.id and d.uid=$fid and (dp.path<>'' or dp.video<>'') and iskuaipai=0";
	   }
	   $field = " d.iskuaipai,d.isimg,d.kid,d.isalbum,d.createtime,dp.*";//动态和图片视频信息
	   $order = 'd.createtime desc';
	   $list = $this->m_db_getlistpage('dynamic d, ' . $this->tablePrefix . 'dynamic_pic dp', $where, $field, $order);
	   foreach ($list['data'] as $k=>$v) {
	       $list['data'][$k]['path'] = makeHttpHead($v['path']);
 	       $list['data'][$k]['video'] = makeHttpHead($v['video']);
	   }
	   return $list;
	}
	/**
	 * 赞列表
	 * @param unknown $linkid
	 * @param number $limit
	 * @return Ambigous <>
	 */
	function zan_list($linkid, $limit = 10) {
		$field = "u.headsmall,z.*";
		$where = "u.uid=z.uid and z.linkid=$linkid";
		$order = "z.createtime desc";
		
		$list = $this->m_db_getlistpage("dynamic_zan z, ".$this->tablePrefix."user u", $where, $field,$order, 1, $limit);
		
		foreach ($list['data'] as $k=>$v) {
			$list['data'][$k]['headsmall'] = makeHttpHead($v['headsmall']);
		}
		
		return $list['data'];
	}
	
	/**
	 * 动态的评论列表
	 * @param unknown $linkid
	 * @param number $limit
	 */
	function comment_list($linkid, $limit=20) {
	
		$field = "c.id,c.replyuid,ifnull((select `nickname` from `".$this->tablePrefix."user` where uid=c.replyuid),'') as `reply_nickname`,c.content,c.createtime,u.uid,u.headsmall,u.nickname";
		$where = "u.uid=c.uid and c.type=1 and c.linkid=$linkid";
		$order = "c.createtime desc";
		if($limit)
			$list = $this->m_db_getlistpage("dynamic_comment c, ".$this->tablePrefix."user u", $where, $field, $order,1, $limit);
		else
			$list = $this->m_db_getlistpage("dynamic_comment c, ".$this->tablePrefix."user u", $where, $field, $order);
		
		foreach ($list['data'] as $k=>&$v) {
		    $v['headsmall'] = makeHttpHead($v['headsmall']);
		    /*
			$replyuid = $v['replyuid'];
			$list['data'][$k]['headsmall'] = makeHttpHead($v['headsmall']);
			if($replyuid) {
				$user = M('user')->where(Array('uid'=>$v['uid']))->find();
				
				$list['data'][$k]['reply_nickname'] = $user['nickname'];
			}else {
				$list['data'][$k]['reply_nickname'] = '';
			}*/
		}
		
		return $list;
	}
	
	/**
	 * 赞动态
	 */
	function dynamiczan($uid,$id) {
		//$content = I('content', '');
		$type = I('type', 1);
		
		if($type) {
			$this->checkArguments(Array('id'=>$id));
			$data['linkid'] = $id;
			$data['uid'] = $uid;
			//$data['content'] = $content;
			$data['createtime'] = time();
			
			$result = M('dynamic_zan')->add($data);
			//被赞加2价值
			$visit=M('dynamic_visit')->where(array('uid'=>$uid,'linkid'=>$id,'type'=>2))->find();
			if(!$visit){
			    $da['uid']=$uid;
			    $da['linkid']=$id;
			    $da['type']=2;
			    $da['createtime']=NOW_TIME;
			    //添加访问记录
			    $visit=D('dynamic_visit')->add($da);
			    
    			$fid=M('dynamic')->field('uid')->where("id=$id")->find();
    			/*zy修改收益新规则*/
    			$worthuser=M('user')->field('worth_user')->where(array('uid'=>$fid['uid']))->find();
    			$level=levelMoney($worthuser['worth_user']);
    			$create=NOW_TIME;
    			$worthlist=$this->worth($fid['uid'],$create,C('zan_dyanmic')*$level,5);
    			$this->money($fid['uid'], C('zan_dyanmic')*$level);
    			M('dynamic_statistics')->where(array('linkid'=>$id))->setInc('fee',C('zan_dyanmic')*$level);
			}
			//记录
			$f=M('dynamic_statistics')->where("linkid=$id")->find();
			if($f){
			    $fee['zancount']=array('exp','zancount+1');
			    //更新访问记录
			    $visit=D('dynamic_statistics')->where("linkid=$id")->save($fee);
			}
			if(!$result&&!$worthlist)
				return showData(new \stdClass(), '赞失败', 1);
			
			// 统计评论数
			$count = M('dynamic_zan')->where(Array('linkid'=>$id))->count();
			M('dynamic')->where(Array('id'=>$id))->setField('zancount', $count);
			$fid=M('dynamic')->field('uid,iskuaipai')->where("id=$id")->find();
			$flag=M('dynamic_comment')->add(array('uid'=>$uid,'replyuid'=>$fid['uid'],'content'=>'赞了你','createtime'=>NOW_TIME,'linkid'=>$id,'isvisible'=>0,'type'=>0));
			// 返回最新一条
			$zan=M('user')->field('tixing_zan')->where(array('uid'=>$uid))->find();
			if($zan['tixing_zan'] && $uid!=$fid['uid']){
			    $iskuaipai=$fid['iskuaipai'];
			    $map['id']=(string)$id;
			    $map['iskuaipai']=(string)$iskuaipai;
			    self::sendSysNotice($fid['uid'], json_encode($map), UserModel::$NOTICE_zan);
			}
			$list = self::zan_list($id, 1);
			return showData($list[0]);
		}else {
			$this->checkArguments(Array('id'=>$id));
			
			$result = M('dynamic_zan')->where(Array('linkid'=>$id, 'uid'=>$uid))->delete();
			if(!$result)
				return showData(new \stdClass(), '取消赞失败', 1);
			
			// 统计评论数
			$count = M('dynamic_zan')->where(Array('linkid'=>$id))->count();
			M('dynamic')->where(Array('id'=>$id))->setField('zancount', $count);
			
			return showData(new \stdClass(), '取消赞成功');
		}
		
		return showData(new \stdClass());
		
	}
	/**
	 * 评论动态
	 * @param unknown $uid
	 * @return array
	 */
	function dynamiccomment($uid) {
		$id       = I('id', 0);
		$content  = I('content', '');
		$replyuid = I('replyuid', 0);
		
		Log::write("dynamiccomment post=" . json_encode($_REQUEST));
		
	
		$this->checkArguments(Array('id'=>$id, 'content'=>$content));
		checkStringLen($content, 200);
	
		$dynamic = M('dynamic')->where(Array('id'=>$id))->find();
		if(!$dynamic) {
			return showData(new \stdClass(), '获取动态信息失败', 1);
		}
		$admin_uid = $dynamic['uid'];
		$iskuaipai= $dynamic['iskuaipai'];
		
		$data['linkid']       = $id;
		$data['uid']          = $uid;
		$data['content']      = $content;
		$data['createtime']   = NOW_TIME;
		
		if ($replyuid) {
			$data['replyuid'] = $replyuid;
		}else{
			/* $replyuid = $admin_uid;
			$data['replyuid'] = $replyuid; */
		}
	
		$result = M('dynamic_comment')->add($data);
		if(!$result)
			return showData(new \stdClass(), '评论失败', 1);
		// 统计评论数
		$count = M('dynamic_comment')->where(Array('linkid'=>$id))->count();
		M('dynamic')->where(Array('id'=>$id))->setField('commentcount', $count);
		// 返回最新一条
		$list = self::comment_list($id, 1);
		
		$comment=M('user')->field('tixing_comment')->where(array('uid'=>$uid))->find();
		if($comment['tixing_comment'] && $uid!=$replyuid){
		    // 通知用户有多少未读动态新消息
		    $unreadCount = M('dynamic_comment')->where(Array('replyuid'=>$replyuid, 'isvisible'=>0))->count();
		    $map['unreadcount'] = $unreadCount;
		    $map['id']=$id;
		    $map['iskuaipai']=$iskuaipai;
		    self::sendSysNotice($replyuid, json_encode($map), UserModel::$NOTICE_HAS_DYNAMIC_NEWMSG);
		}
		return showData($list['data'][0]);
	}
	/**
	 * 添加动态分享数量
	 * @param unknown $uid
	 * @return array
	 */
	function addShareCount($uid) {
		$id = I('id', 0);
		$this->checkArguments(Array('id'=>$id));
		
		$data['linkid'] = $id;
		$data['uid'] = $uid;
		$data['createtime'] = time();
		
		$result = M('dynamic_share')->add($data);

		// 统计评论数
		$count = M('dynamic_share')->where(Array('linkid'=>$id))->count();
		M('dynamic')->where(Array('id'=>$id))->setField('sharecount', $count);
		
		return showData('', '操作成功');
	}
	/**
	 * 添加打卡分享数量
	 * @param unknown $uid
	 * @return array
	 */
	function addDakaCount($uid) {
		$id = I('id', 0);
		$this->checkArguments(Array('id'=>$id));
		
		$result = M('daka')->where(Array('id'=>$id))->setInc("sharecount", 1);
		
		return showData('', '操作成功');
	}
    
	/**
	 * 定向隐身
	 * @param unknown $uid
	 * @return array
	 */
	function yinshen($uid) {
		$fid = I('fid', 0);
		if(!is_numeric($fid)){
		    return showData('', '请输入数字', 1);
		}
		$this->checkArguments(Array('fid'=>$fid));
		if($uid==$fid){
		    return showData('', '不能对自己进行隐身额', 1);
		}
		$type = I('type', 1);
		if($type) {	// 隐身
			$data['uid'] = $uid;
			$data['fid'] = $fid;
			$data['createtime'] = time();
			
			$result = M('yinshen')->add($data);
			
		}else { // 取消隐身
			$where['uid'] = $uid;
			$where['fid'] = $fid;
			$result = M('yinshen')->where($where)->delete();
		}
		
		if(!$result){
			return showData('', '操作失败', 1);
		}
		
		return showData('', '操作成功');
	}
	/**
	 * 定身隐身列表
	 * @param unknown $uid
	 * @return \Common\Model\array()
	 */
	function yinshen_list($uid) {
		$where = " uid in (select s.fid from ".$this->tablePrefix."yinshen s where s.uid=$uid)";
		$field = "*";
		$list = $this->m_db_getlistpage("user", $where, $field);
		$list['data'] = self::_format($list['data'], $uid);
		return $list;
	}
	/**
	 * 会员费用列表
	 * @param unknown $uid
	 * @return array
	 */
	function member_fee($uid) {
		$list = $this->m_db_getlist("member_fee");
		return showData($list);
	}
	/**
	 * 获取用户是不是会员
	 * @param unknown $uid
	 */
	function getMemberAccess($uid){
	    //可以获取到期时间最小的那个权限
	    $db     = M('user_member');
	    $info   = $db->where(array('uid'=>$uid))->find();
	    $member = M('member_fee');
	    $data   = false;
	    if ($info){
	        if ($info['time']>NOW_TIME){
	            $data = $member->where(array('id'=>$info['memberid']))->find();
	        }
	    }
	    if ($data) {
	        $data['time'] = $info ? $info['time'] : '';
	    }
	    return $data;
	}
	/**
	 * 会员中心
	 */
	function memberCenter($uid){
	     //是否是会员 会员介绍 定向隐身介绍
	     $member = self::getMemberAccess($uid);
	     $data['ismember'] = $member ? 1 : 0;
	     if ($data['ismember']){
	         $user = $this->field('headsmall,nickname')->where(array('uid'=>$uid))->find();
	         $data['member'] = array(
	             'headsmall'   => $user['headsmall'] ? makeHttpHead($user['headsmall']) : '',
	             'nickname'    => $user['nickname'],
	             'time'        => $member['time'],//到期时间
	         );
	     }else {
	         $data['member']   = new \stdClass();
	     }
	     
	     
	     
	     
	     
	     $data['yinshenurl']   = 'http://yimisns.com:81/index.php/Home/index/htmlcontent?key=yinshen';
	     $data['roamurl']      = 'http://yimisns.com:81/index.php/Home/index/htmlcontent?key=roam';
	     $data['descurl']      = 'http://yimisns.com:81/index.php/Home/index/htmlcontent?key=memberprotocol';
	     return showData($data);
	}
	/**
	 * 加入会员
	 */
	function addMember($uid){
	    
	}
	/**
	 * 续费
	 */
	function renewMemer($uid){
	   
	}
	/**
	 * 打卡列表
	 */
	function dakalists($uid){
	    // 好友列表
	    $field  = '*,(select count(*) from `'.$this->tablePrefix.'daka_user` u where u.uid='.$uid.' and u.dakaid=d.id) as isdaka';
	    $order  ='createtime desc';
	    $data   = $this->m_db_getlistpage('daka d', array(), $field,$order);
	    if ($data['data']){
	        foreach ($data['data'] as $k=>&$v){
	            if ($v['type']){
	                $v['content'] = makeHttpHead($v['content']);
	            }
	            
	            if (isset($v['headsmall'])){
	            	$v['headsmall'] 	= makeHttpHead($v['headsmall']);
	            }
	            if($v['createtime']){
                    	$v['createtime']=date('Y-m-d H:i:s',$v['createtime']);               
	            }
	            
	        }
	    }
	    return showData($data['data'], '', 0, $data['page']);
	}
	/**
	 * 打卡
	 */
	function addDaka($uid){
	    $id   = trim(I('id', 0));
	    if (!$id) return showData(new \stdClass(), '请选择一个有奖打卡', 1);
	    $data  = array('uid'=>$uid, 'dakaid'=>$id);
	    $time=M('daka')->field('createtime')->where(array('id'=>$id))->find();
	    $where['uid'] = $uid;
	    $start = mktime(0,0,0,date('m'),date('d'),date('Y'));
	    $end   = mktime(23,59,59,date('m'),date('d'),date('Y'));
	    if($time['createtime']<$start){
	        return showData(new \stdClass(), '请选择当天的打卡', 1);
	    }
	    $where['createtime'] = array('between', "$start,$end");
	    
	    if (M('daka_user')->where($where)->count()) {
	        return showData(new \stdClass(), '你已打过卡了', 1);
	    }else {
	        $data['createtime'] = NOW_TIME;
	        if (M('daka_user')->add($data)){
	            /*zy修改收益新规则*/
	            $worthuser=M('user')->field('worth_user')->where(array('uid'=>$uid))->find();
	            $level=levelMoney($worthuser['worth_user']);
	            $list=$this->money($uid, C('youjiangdaka')*$level);
	            //打卡成功添加20价值
	            $create=NOW_TIME;
	            $worthlist=$this->worth($uid,$create,C('youjiangdaka')*$level,6);
	            if($list&&$worthlist){
		        $msg="打卡成功,已增加20价值!";
	            $this->sendSysNotice($uid,$msg);
	            }
		return showData(new \stdClass(), '打卡成功');
	        }
	        return showData(new \stdClass(), '打卡失败', 1);
	    }
	}
	/**
	 * 广告列表
	 * @return array
	 */
	function adv_list() {
		$pos = I('type', 0);
		$list = self::advlist($pos);
		
		return showData($list);
	}
	/**
	 * 反馈意见
	 * @param unknown $uid
	 * @return array
	 */
	function feedback($uid) {
		$content = I('content', '');
		$this->checkArguments(Array('content'=>$content));
		
		checkStringLen($content, 200);
		
		$data['content'] = $content;
		$data['uid'] = $uid;
		$data['createtime'] = time();
		
		$result = M('user_feedback')->add($data);
		
		if(!$result){
			return showData('', '操作失败', 1);
		}
		
		return showData('', '操作成功');
	}
	/**
	 * 修改密码
	 * @param unknown $uid
	 * @return array
	 */
	function modifypass($uid) {
		$oldpass = I('oldpass', '');
		$newpass = I('newpass', '');
		
		$this->checkArguments(Array('oldpass'=>$oldpass, 'newpass'=>$newpass));
		
		$where['uid'] = $uid;
		$where['password'] = md5($oldpass);
		$user = M('user')->where($where)->find();
		if(!$user) {
			return showData('', '操作失败，原密码不对', 1);
		}
		$flag=preg_match('/^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{10}$/', $newpass);
		if($flag){
		    $result = M('user')->where(Array('uid'=>$uid))->save(Array('password'=>md5($newpass),'pswLevel'=>1));
		    $phone=M('user')->field('safe_phone')->where(Array('uid'=>$uid))->find();
		    if($phone['safe_phone']){
		        M('user')->where(Array('uid'=>$uid))->save(Array('safe_level'=>3));
		    }else{
		        M('user')->where(Array('uid'=>$uid))->save(Array('safe_level'=>2));
		    }
		}else{
		    $result = M('user')->where(Array('uid'=>$uid))->save(Array('password'=>md5($newpass),'pswLevel'=>0));
		    $phone=M('user')->field('safe_phone')->where(Array('uid'=>$uid))->find();
		    if($phone['safe_phone']){
		        M('user')->where(Array('uid'=>$uid))->save(Array('safe_level'=>2));
		    }else{
		        M('user')->where(Array('uid'=>$uid))->save(Array('safe_level'=>1));
		    }
		}
		if(!$result){
			return showData('', '操作失败', 1);
		}
		
		return showData('', '操作成功');
	}
	/**
	 * 获取设置消息
	 */
	function getmsg($uid){
	    $sid=I('sessionid');
	    $msg=M('session_user')->field('getmsg')->where(array('uid'=>$uid,'sessionid'=>$sid))->find();
	    return showData($msg);
	}
	/**
	 * 找回密码
	 * @param unknown $uid
	 */
	function findPassword(){
	    $phone=I('phone');
	    $code=I('code');
	    $newpassword=I('newpassword');
	    M('user_code')->where(array('createtime'=>array('lt',NOW_TIME-2*60*60)))->delete();
	    if (!$phone) return showData(new \stdClass(), '请输入手机号码', 1);
	    if (!$code) return showData(new \stdClass(), '请输入验证码', 1);
	    $info = M('user_code')->where(array('phone'=>$phone))->find();
	    if ($info['code'] == $code) {
	        M('user_code')->where(array('phone'=>$phone))->delete();//验证成功就删除
	        $result = M('user')->where(Array('phone'=>$phone))->save(Array('password'=>md5($newpassword)));
	        if($result){
	            return showData(new \stdClass(), '修改成功');
	        }else{
	            return showData(new \stdClass(), '修改失败',1);
	        }   
	    }else {
	        return showData(new \stdClass(), '验证码错误', 1);
	    }
	    
	}
	function income($uid) {
		$user = M('user')->where(Array('uid'=>$uid))->find();
		if(!$user)
			return showData(new \stdClass(), '用户信息不存在', 1);
		
		$worth=M('worth')->where("uid=$uid")->sum('value');
		$start = mktime(0,0,0,date('m'),date('d'),date('Y'));
       		$end   = mktime(23,59,59,date('m'),date('d'),date('Y'));
		$data['money'] = round($user['money'],2);
		$data['money'] =(string)$data['money'];
		if($worth){
		    $data['total_income'] = $worth/100;
		}else{
		    $data['total_income'] = 0;
		}
		
		$today=M('worth')->where("uid=$uid and createtime>=$start and createtime<=$end")->sum('value');
		if($today){
		    $data['today_income'] =$today/100;
		}else{
		    $data['today_income'] =0;
		}
		 
		$thismonth = date('m');
		$thisyear = date('Y');
		$startDay = $thisyear . '-' . $thismonth . '-1';
		$endDay = $thisyear . '-' . $thismonth . '-' . date('t', strtotime($startDay));
		$b_time= strtotime($startDay);//当前月的月初时间戳
		$e_time= strtotime($endDay);//当前月的月末时间戳
		$month=M('worth')->where("uid=$uid and createtime>=$b_time and createtime<= $e_time")->sum('value');
		if($month){
		    $data['month_income'] =$month/100;
		}else{
		    $data['month_income'] =0;
		}
		
		$data['unget_income'] = 40.00;
		return showData($data);
	}
	
	function withdraw($uid) {
		$fee = I('fee', 0);
		$mes=M('user')->field('alipay_account,money')->where(array('uid'=>$uid))->find();
		if($mes['money']<300){
		    return showData('', '你的余额还不满足提现要求');
		}
		if(!$mes['alipay_account']){
		    return showData('', '请绑定支付宝账号');
		}
		$this->checkArguments(Array('fee'=>$fee));
		
		$data['uid'] = $uid;
		$data['fee'] = $fee;
		$data['createtime'] = time();
		$data['alipay_account']=$mes['alipay_account'];
		
		$result = M('withdraw')->add($data);
		$flag=M('user')->where(array('uid'=>$uid))->setDec('money',$fee);
		if(!$result || !$flag)
			return showData('', '申请提现失败', 1);
		
		return showData('', '申请提现成功，请等待后台审核');
	}
	
	function income_sort($uid) {
		$sql = "select sum(value) as total_income,uid from tc_worth group by uid order by total_income desc limit 0,50";
		$model = new Model();
		$list = $model->query($sql);
		foreach ($list as $k=>$v) {
			$uid = $v['uid'];
			$user = M('user')->where(Array('uid'=>$uid))->find();
			$list[$k]['nickname'] = $user['nickname'];
			$list[$k]['total_income']= $v['total_income']/100;
		}
		
		$list = $list ? $list : array();
		
		return showData($list);
		
	}
	
	function share_statistics($uid) {
	    //zy修改
	    $starttime=I('starttime');
	    $endtime=I('endtime');
		$return = array();
		// QQ
		$tmp['name'] = "QQ";
		$where['isqqzone|isqq']=1;
		$where['createtime']=array('between',array($starttime,$endtime));
		$where['uid']=$uid;
		$count=M('user_sharerecord')->where($where)->count();
		$tmp['desc'] = $count.'次';
		$n=($endtime-$starttime)/(24*3600);
		$subtmp = array();
		$qqtime=$starttime;
		for ($i = 0;$i<$n; $i++) {
			$subtmp_item['createtime'] = $qqtime;
			$qqtime=$qqtime+24*3600;
			$map['isqqzone|isqq']=1;
			$map['createtime']=array('between',array($subtmp_item['createtime'],$qqtime));
			$map['uid']=$uid;
			$count=M('user_sharerecord')->where($map)->count();
			$subtmp_item['total'] = $count;	
			$subtmp[] = $subtmp_item;
		}
		$tmp['list'] = $subtmp;
		$return[] = $tmp;
		// 微信
		$tmp['name'] = "微信";
		$wx['isweixin|isweixinquan']=1;
		$wx['createtime']=array('between',array($starttime,$endtime));
		$wx['uid']=$uid;
		$count=M('user_sharerecord')->where($wx)->count();
		$tmp['desc'] = $count.'次';
		$wxtime=$starttime;
		$subtmp = array();
		for ($i = 0; $i < $n; $i++) {
			$subtmp_item['createtime'] = $wxtime;
			$wxtime=$wxtime+24*3600;
			$map['isweixin|isweixinquan']=1;
			$map['createtime']=array('between',array($subtmp_item['createtime'],$wxtime));
			$map['uid']=$uid;
			$count=M('user_sharerecord')->where($map)->count();
			$subtmp_item['total'] = $count;	
			$subtmp[] = $subtmp_item;
		}
		$tmp['list'] = $subtmp;
		$return[] = $tmp;
		
		// 微博
		$tmp['name'] = "微博";
		$count=M('user_sharerecord')->where(array('uid'=>$uid,'isweibo'=>1,'createtime'=>array('between',array($starttime,$endtime))))->count();
		$tmp['desc'] = $count.'次';
		$wbtime=$starttime;
		$subtmp = array();
		for ($i = 0; $i < $n; $i++) {
			$subtmp_item['createtime'] = $wbtime;
			$wbtime=$wbtime+24*3600;
			$map['isweibo']=1;
			$map['createtime']=array('between',array($subtmp_item['createtime'],$wbtime));
			$map['uid']=$uid;
			$count=M('user_sharerecord')->where($map)->count();
			$subtmp_item['total'] = $count;	
			$subtmp[] = $subtmp_item;
		}
		$tmp['list'] = $subtmp;
		$return[] = $tmp;
		
		
		return showData($return);
		
		
	}
	
	function award_daka($uid) {
	    //zy修改
	    $starttime=I('starttime');
	    $endtime=I('endtime');
		$return = array();
		$tmp['name'] = "有奖打卡";
		$count=M('daka_user')->where(array('uid'=>$uid,'createtime'=>array('between',array($starttime,$endtime))))->count();
		$tmp['desc'] = $count.'次';
		$n=($endtime-$starttime)/(24*3600);
		$subtmp = array();
		for ($i = 0; $i < $n; $i++) {
			$subtmp_item['createtime'] = $starttime;
			$starttime=$starttime+24*3600;
			$map['createtime']=array('between',array($subtmp_item['createtime'],$starttime));
			$map['uid']=$uid;
			$count=M('daka_user')->where($map)->count();
			$subtmp_item['total'] = $count;	
			$subtmp[] = $subtmp_item;
		}
		$tmp['list'] = $subtmp;
		$return[] = $tmp;
	
		
	
		return showData($return);
	
	
	}
	
	function jubao_statistics($uid) {
	    //zy修改
	    $starttime=I('starttime');
	    $endtime=I('endtime');
		$return = array();
		// 举报
		$tmp['name'] = "举报";
		$count=M('jubao')->where(array('uid'=>$uid,'createtime'=>array('between',array($starttime,$endtime))))->count();
		$tmp['desc'] = $count.'次';
		$n=($endtime-$starttime)/(24*3600);
		$subtmp = array();
		$jubaotime=$starttime;
		for ($i = 0; $i <$n; $i++) {
			$subtmp_item['createtime'] = $jubaotime;
			$jubaotime=$jubaotime+24*3600;
			$map['createtime']=array('between',array($subtmp_item['createtime'],$jubaotime));
			$map['uid']=$uid;
			$count=M('jubao')->where($map)->count();
			$subtmp_item['total'] = $count;	
			$subtmp[] = $subtmp_item;
		}
		$tmp['list'] = $subtmp;
		$return[] = $tmp;
	
		// 被举报
		$tmp['name'] = "被举报";
		//array('fid'=>$uid,'createtime'=>array('between',array($starttime,$endtime)))
		//id in (select order_id from '.C('DB_PREFIX').'order_status where type=4 and create_time <= '.$time.') and status = 4'
		$count=M('jubao')->where('(fid='.$uid.' or (btype=3 and content in (select id from '.C('DB_PREFIX').'kuaipai where uid='.$uid.'))) and createtime>='.$starttime.' and createtime<'.$endtime)->count();
		$tmp['desc'] = $count.'次';
		$beijubaotime=$starttime;
		$subtmp = array();
		for ($i = 0; $i < $n; $i++) {
			$subtmp_item['createtime'] = $beijubaotime;
			$beijubaotime=$beijubaotime+24*3600;
			$count=M('jubao')->where('(fid='.$uid.' or (btype=3 and content in (select id from '.C('DB_PREFIX').'kuaipai where uid='.$uid.'))) and createtime>='.$subtmp_item['createtime'].' and createtime<'.$beijubaotime)->count();
			$subtmp_item['total'] = $count;	
			$subtmp[] = $subtmp_item;
		}
		$tmp['list'] = $subtmp;
		$return[] = $tmp;
	
	
	
		return showData($return);
	
	
	}
	
	function dynaimc_statistics($uid) {
		  $field = "s.*";
		  $from = "dynamic d, ".$this->tablePrefix."dynamic_statistics s";
		  $where = " s.linkid = d.id and d.uid=$uid";
		  $order = "s.createtime desc";
		  
		  $list = $this->m_db_getlistpage($from, $where, $field, $order);
		  foreach ($list['data'] as $k=>$v){
		  	$single = self::dynamic_detail($uid, $v['linkid']);
		  	if($single)
		  		$list['data'][$k]['detail'] = $single['data'];
		  	else
		  		$list['data'][$k]['detail'] = new \stdClass();
		  } 
		  
		  return showData($list['data']);
	}
	/**
	 * 快拍统计
	 * @param unknown $uid
	 * @return Ambigous <\stdClass, \Common\Model\array(), \User\Model\array>
	 */
	function kuaipai_statistics($uid) {
		$field = "s.*";
		$from = "kuaipai d, ".$this->tablePrefix."kuaipai_statistics s";
		$where = " s.linkid = d.id and d.uid=$uid";
		$order = "s.createtime desc";
	
		$list = $this->m_db_getlistpage($from, $where, $field, $order);
		 foreach ($list['data'] as $k=>$v){
		     $view=M('kuaipai_visit')->where(array('linkid'=>$v['linkid'],'type'=>1))->count('distinct(uid)');
		     $v['viewperson']=$view;
		     $list['data'][$k]=$v;
			$single = self::kuaipai_detail($uid, $v['linkid']);
			//$single=M('kuaipai')->where(array('id'=>$v['linkid']))->find();
			//$member=M('kuaipai')->alias('k')->field('gu.*')->join('join '.C('DB_PREFIX').'group g on g.name=k.id join '.C('DB_PREFIX').'group_user gu on g.id=gu.groupid')->where(array('k.id'=>$v['linkid']))->select();
			if($single)
				$list['data'][$k]['detail'] = $single['data'];
			else
				$list['data'][$k]['detail'] = new \stdClass();
		}  
	
		return showData($list['data']);
	}
	/**
	 * 设置是否自动购买
	 * @param unknown $uid
	 * @return array|\User\Model\array
	 */
	function setAutoBuyMember($uid) {
		$state = I('state', 0);
		$result = M('user')->where(Array('uid'=>$uid))->save(Array('auto_buy_member'=>$state));
		/* if(!$result)
			return showData(0, '设置失败', 1); */
		
		$info = M('user')->where(Array('uid'=>$uid))->find();
		
		return self::user($uid, $uid);
	}
	/**
	 * 设置支付宝账号
	 * @param unknown $uid
	 * @return array|\User\Model\array
	 */
	function setAlipayAccount($uid) {
		$name = I("name", '');
		$account = I('account', '');
		
		$this->checkArguments(Array('name'=>$name, 'account'=>$account));
		checkStringLen($name, 20);
		checkStringLen($account, 50);
		
		$data['alipay_account'] = $account;
		$data['alipay_name'] = $name;
		$result =  M('user')->where(Array('uid'=>$uid))->save($data);
		
		if(!$result)
			return showData(new \stdClass(), '设置失败', 1);
		
		return self::user($uid, $uid);
	}
	/**
	 * 取消支付宝账号
	 * @param unknown $uid
	 * @return array|\User\Model\array
	 */
	function delAlipayAccount($uid) {
		$data['alipay_account'] = "";
		$data['alipay_name'] = "";
		$result =  M('user')->where(Array('uid'=>$uid))->save($data);
	
		/* if(!$result)
			return showData(new \stdClass(), '设置失败', 1); */
	
		return self::user($uid, $uid);
	}
	/**
	 * 发布红包
	 * @param unknown $uid
	 * @return array
	 */
	function publish_hongbao($uid) {
		$type = I('type', 1);
		$fid = I('fid', 0);
		$title = I('title', '恭喜发财，大吉大利！');
		$nums = I('nums', 0);
		$money = I('money', 0);
		$singlemoney = I('singlemoney', 0);
		if($money!=0 && $money/$nums<0.01){
		    return showData(new \stdClass(), '单个红包不能小于0.01元', 1);
		}
		if($singlemoney!=0 && $singlemoney<0.01){
		    return showData(new \stdClass(), '单个红包不能小于0.01元', 1);
		}
		$paymoeny = 0.0;
		// 检测余额是否够发红包
       		 $moneydata=M('user')->field('money')->where("uid=$uid")->find();
        		
		$this->checkArguments(Array('fid'=>$fid, 'nums'=>$nums));
		if($type == 1) {
			if($money >$moneydata['money']){
            			return showData(new \stdClass(), '余额不足', 1);
        			}    
			$this->checkArguments(Array('money'=>$money));
			
			$paymoeny = $money;
		}else if($type == 2) {
			if($singlemoney>$moneydata['money']){
            			return showData(new \stdClass(), '余额不足', 1);
        			}    
			$this->checkArguments(Array('singlemoney'=>$singlemoney));
			$paymoeny = $singlemoney * $nums;
			$data['singlemoney'] = $singlemoney;
		}
		
		// 写入记录
		$data['uid'] = $uid;
		$data['fid'] = $fid;
		$data['nums'] = $nums;
		$data['title'] = $title;
		$data['money'] = $paymoeny;
		$data['type'] = $type;
		$data['createtime'] = time();
		$result1=M('user')->where(array('uid'=>$uid))->setDec('money',$paymoeny);
		$result = M('hongbao')->add($data);
		if(!$result && !$result1)
			return showData(new \stdClass(), '发红包失败', 1);
		
		$info = self::hongbao_record($uid, $result);
		
		return showData($info['data'], '发红包成功');
	}
	
	// 是否抢了红包
	function has_qianghongbao($uid) {
		$hongbao_id = I('hongbao_id', 0);
		$this->checkArguments(Array('hongbao_id'=>$hongbao_id));
		// 检测是否已抢红包
		if(M('hongbao_record')->where(Array('hongbao_id'=>$hongbao_id, 'uid'=>$uid))->count()) {
			return showData(1, '你已抢了红包', 0);
		}
		
		return showData(0, '还未抢红包', 0);
	}
	/**
	 * 抢红包
	 * @param unknown $uid
	 * @return array
	 */
	function qiang_hongbao($uid) {
		$hongbao_id = I('hongbao_id', 0);
		
		$this->checkArguments(Array('hongbao_id'=>$hongbao_id));
		$hongbao = M('hongbao')->where(Array('id'=>$hongbao_id))->find();
		if(!$hongbao)
			return showData(new \stdClass(), '红包不存在', 1);
		// 检测是否已抢红包
		if(M('hongbao_record')->where(Array('hongbao_id'=>$hongbao_id, 'uid'=>$uid))->count()) {
			return showData(new \stdClass(), '你已抢了红包，无法再抢', 1);
		}
		// 计算最大可抢金额
		$sql = "select r.*,u.nickname,u.headsmall from ".$this->tablePrefix."hongbao_record r, ".$this->tablePrefix."user u where u.uid=r.uid and r.hongbao_id=$hongbao_id";
		$model = new Model();
		$list = $model->query($sql);
		$count = 0;
		$total_qiang_money = 0.0;
		foreach ($list as $v) {
			$count += 1;
			$total_qiang_money += $v['money'];
		}
		
		if($count >= $hongbao['nums']) {
			return showData(0, '来晚了，已经没有红包可抢了', 0);
		}
		
		$leave_count = $hongbao['nums'] - $count;
		$leave_money = $hongbao['money'] - $total_qiang_money;
		
		if($hongbao['type'] == 2) { // 等金额红包
			Log::write("into leave_count=2");
			$data['money'] = $hongbao['singlemoney'];
		}else { // 手气红包
			if($leave_count == 1){
				Log::write("into leave_count=1");
				$data['money'] = $leave_money;
			}else {
				Log::write("into leave_count not 1");
				$rand_result = rand(1, $leave_count * 10.0) + 0.01;
				Log::write("rand_result=" . $rand_result);
				Log::write("leave_money=" . $leave_money);
				$money = $leave_money * ($rand_result / ($leave_count * 10));
				$money = $money<0.01 ? 0.01 :round($money,2);
				Log::write("money=" . $money);
				$data['money'] = $money;
			}
		}
		$data['uid'] = $uid;
		$data['createtime'] = time();
		$data['hongbao_id'] = $hongbao_id;
		$result1=M('user')->where(array('uid'=>$uid))->setInc('money',$data['money']);
		$result = M('hongbao_record')->add($data);
		if(!$result && !$result1)
			return showData(new \stdClass(), '抢红包失败了！', 1);
		
		if($leave_count == 1)
			self::updateHongbaoBest($hongbao_id);
		
		return showData($data['money'], '抢红包成功');
	}
	/**
	 * 更新红包手气王
	 * @param unknown $hongbao_id
	 */
	private function updateHongbaoBest($hongbao_id) {
		$record = M('hongbao_record')->where(Array('hongbao_id'=>$hongbao_id))->order("money desc")->find();
		if($record) {
			M('hongbao_record')->where(Array('id'=>$record['id']))->save(Array('isbest'=>1));
		}
	}
	/**
	 * 红包详细
	 * @param unknown $uid
	 * @return array
	 */
	function hongbao_record($uid, $id=0) {
	    
		$get_id     = I('hongbao_id', 0);
		$hongbao_id = $id ? $id : $get_id;
		
		$this->checkArguments(Array('hongbao_id'=>$hongbao_id));
		$hongbao = M('hongbao')->where(Array('id'=>$hongbao_id))->find();
		if(!$hongbao)
			return showData(new \stdClass(), '红包不存在', 1);
		// 获取红包发布者信息
		$uid  = $hongbao['uid'];
		$user = M('user')->where(Array('uid'=>$uid))->find();
		$data['id']        = $hongbao['id'];
		$data['nickname']  = $user['nickname'];
		$data['headsmall'] = $user['headsmall'];
		$data['type']      = $hongbao['type'];
		$data['title']     = $hongbao['title'];
		
		// 获取抢的红包
		$hongbao_qiang = M('hongbao_record')->where(Array('hongbao_id'=>$hongbao_id))->find();
		if($hongbao_qiang) {
			$data['qiang_money'] = $hongbao_qiang['money'];
			$sql   = "select r.*,u.nickname,u.headsmall from ".$this->tablePrefix."hongbao_record r, ".$this->tablePrefix."user u where u.uid=r.uid and r.hongbao_id=$hongbao_id";
			$model = new Model();
			$list  = $model->query($sql);
			$count = 0;
			$total_qiang_money = 0.0;
			
			$list_user = array();
			foreach ($list as $v) {
				$count += 1;
				$total_qiang_money += $v['money'];
				$tmp['uid']         = $v['uid'];
				$tmp['nickname']    = $v['nickname'];
				$tmp['headsmall']   = $v['headsmall'];
				$tmp['money']       = $v['money'];
				$tmp['isbest']      = $v['isbest'];
				$tmp['createtime']  = $v['createtime'];
				
				$list_user[] = $tmp;
			}
			$data['tip']     = "已领取$count/".$hongbao['nums']."个，共$total_qiang_money/".$hongbao['money']."元";
			$data['display'] = 1;
			$data['list']    = $list_user;
		}else{
			$data['qiang_money'] = 0;
			$data['tip']         = "";
			$data['display']     = 0;
			$data['list']        = array();
		}
		return showData($data);
	}
	/**
	 * 我收到的红包
	 * @param unknown $uid
	 * @return \Common\Model\array()
	 */
	function my_receive_hongbao($uid) {
		$year = I("year", 0);
		$this->checkArguments(Array('year'=>$year));
		
		$mintime = strtotime($year . "-01-01 00:00:00");
		$maxtime = strtotime($year+1 .  "-01-01 00:00:00");
		
		
		$where = "uid=$uid and createtime > $mintime and createtime <= $maxtime";
		// 获取总的信息
		$list = M('hongbao_record')->where($where)->select();
		$total_money = 0;
		$total_num = 0;
		$best_num = 0;
		foreach ($list as $v) {
			$total_money += $v['money'];
			$total_num += 1;
			if ($v['isbest']) {
				$best_num += 1;
			}
		}
		
		// 获取列表信息
		$table = "hongbao_record r, tc_hongbao h,tc_user u";
		$where = "r.hongbao_id=h.id and h.uid=u.uid and r.uid=$uid and r.createtime>$mintime and r.createtime<=$maxtime";
		$field = "r.*, u.nickname";
		$order = "r.createtime desc";
		
		$sublist = $this->m_db_getlistpage($table, $where, $field, $order);
		
		$data['total_money'] =(string)round($total_money,2);
		$data['total_num'] = $total_num;
		$data['best_num'] = $best_num;
		$data['list'] = $sublist['data'];
		
		$sublist['data'] = $data;
		
		return $sublist;
		
	}
	/**
	 * 我发出的红包
	 * @param unknown $uid
	 * @return \Common\Model\array()
	 */
	function my_publish_hongbao($uid) {
		$year = I("year", 0);
		$this->checkArguments(Array('year'=>$year));
		
		$mintime = strtotime($year . "-01-01 00:00:00");
		$maxtime = strtotime($year+1 .  "-01-01 00:00:00");
		
		
		$where = "uid=$uid and createtime > $mintime and createtime <= $maxtime";
		// 获取总的信息
		$list = M('hongbao')->where($where)->select();
		$total_money = 0;
		$total_num = 0;
		foreach ($list as $v) {
			$total_money += $v['money'];
			$total_num += 1;
		}
		
		// 获取列表信息
		$table = "hongbao h";
		$where = "h.uid=$uid and h.createtime>$mintime and h.createtime<=$maxtime";
		$field = "h.*";
		$order = "h.createtime desc";
		
		$sublist = $this->m_db_getlistpage($table, $where, $field, $order);
		$subdata = $sublist ? $sublist['data'] : array();
		foreach ($subdata as $k=>$v) {
			$count = M("hongbao_record")->where(Array('hongbao_id'=>$v['id']))->count();
			$subdata[$k]['get_nums'] = $count;
		}
		
		$data['total_money'] = (string)$total_money;
		$data['total_num'] = $total_num;
		$data['list'] = $subdata;
		
		$sublist['data'] = $data;
		
		return $sublist;
	}
	
	function consume_list($uid) {
		/*
		$starttime = I('starttime', 0);
		$endtime = I('endtime', 0);
		$this->checkArguments(Array('starttime'=>$starttime));
		$this->checkArguments(Array('endtime'=>$endtime));
		
		$where = "uid=$uid and createtime >= $starttime and createtime <= $endtime";
		
		$list = $this->m_db_getlistpage("consume_record", $where, "id,title,type,money,createtime,uid", "createtime desc");
		*/
	  $starttime = I('starttime', 0);
	    $endtime = I('endtime', 0);
	    $this->checkArguments(Array('starttime'=>$starttime));
	    $this->checkArguments(Array('endtime'=>$endtime));
       //发红包	    
	   $where = "uid=$uid and createtime >= $starttime and createtime <= $endtime";
	    $field="id,title,type,money,createtime,uid";
	    $list = $this->m_db_getlistpage("hongbao", $where,$field, "createtime desc");
	    foreach ($list['data']  as $k=>$v) {
	        $list['data'][$k]['money'] = '-'.$v['money'];
	        
	    }
	    //收红包
 	    $where2="uid=$uid and createtime >= $starttime and createtime <= $endtime";
	    $field2="id,money,hongmao_id,createtime,isbest,uid";
 	    $list2 = $this->m_db_getlistpage("hongbao_record", $where2, $field2, "createtime desc");
	    foreach ($list2['data']  as $k=>$v) {
	        $list2['data'][$k]['title'] = '收到的红包';
		 $list2['data'][$k]['type'] = 1;
	    }
	    
	    $arr['data']=array_merge($list['data'],$list2['data']);
        return showData($arr['data']);
	}
	
	// 关注/取消关注 
	function follow_old($uid) {
		$fuid = I("fid", 0);
		$type = I("type", 1);
		
		
		if($type) {// 关注
			$result = M('user_friend')->where(Array('uid'=>$uid, 'fid'=>$fuid))->find();
			if($result){
				return showData(0, "你已经关注了", 1);
			}
			
			$data['uid'] = $uid;
			$data['fuid'] = $fuid;
			$data['addtime'] = time();
			
			$result = M('user_friend')->add($data);
			if(!$result){
				return showData("", "关注失败", 1);
			}
			//被关注加2价值
			/*zy修改收益新规则*/
			$worthuser=M('user')->field('worth_user')->where(array('uid'=>$fuid))->find();
			$level=levelMoney($worthuser['worth_user']);
			$create=NOW_TIME;
			$worthlist=$this->worth($fuid,$create,C('beiguanzhu')*$level,2);
			$this->money($fuid,C('beiguanzhu')*$level);
			return showData(self::friendRelation($uid, $fuid), "关注成功old", 0);
			
		}else{// 取消关注
			$result = M('user_friend')->where(Array('uid'=>$uid, 'fid'=>$fuid))->find();
			if($result){
				return showData(0, "你还未关注，操作失败", 1);
			}
			
			$result = M('user_friend')->where(Array('uid'=>$uid,'fid'=>$fuid))->delete();
			if(!$result){
				return showData("", "取消关注失败", 1);
			}
				
			return showData(self::friendRelation($uid, $fuid), "取消关注成功", 0);
		}
		
	}
	
	// 获取好友关系 0-没有任何关系  1-我关注的，2-关注我的 3-相互关注的
	private function friendRelation($uid, $fid) {
		$where = "(uid=$uid and fid=$fid) and (uid=$fid and fid=$fid)";
		$result = M('user_friend')->where($where)->find();
		if($result){
			return 3;
		}
		
		$where = "uid=$uid and fid=$fid";
		$result = M('user_friend')->where($where)->find();
		if($result){
			return 1;
		}
		
		$where = "uid=$fid and fid=$uid";
		$result = M('user_friend')->where($where)->find();
		if($result){
			return 2;
		}
		
		return 0;
	}
	
	// 设置隐私类别
	public function setYinsi_type($uid) {
		$type = I("type", 0);
		$result = M('user')->where(Array('uid'=>$uid))->save(Array('yinsi_type'=>$type));
		if($result === false){
			return showData(0,"设置失败",1);
		}
		
		return showData($type,"设置成功");
	}
	
	// 设置消息设置
	public function msg_setting($uid) {
		$msg = I("msg_setting", 0);
		$this->checkArguments(Array('msg_setting'=>$msg));
		
		if(strlen($msg) != 4) {
			return showData(0,"设置格式错误了",1);
		}
		$result = M('user')->where(Array('uid'=>$uid))->save(Array('msg_setting'=>$msg));
		if($result === false){
			return showData(0,"设置失败",1);
		}
	
		return showData($type,"设置成功");
	}
	
	// 设置对好友是否隐私或可见
	public function setFriendYinsi_type($uid) {
		$fid = I("fid", 0);
		$isvisible = I("isvisible", 1);
		$this->checkArguments(Array('fid'=>$fid));
		
		
		$result = M('user_friend')->where(Array('uid'=>$uid, 'fid'=>$fid))->save(Array('isvisible'=>$isvisible));
		if($result === false){
			return showData(0,"设置失败或没有任何关系了",1);
		}
	
		return showData($isvisible,"设置成功");
	}
	
	// 绑定或解绑账号
	public function bindAccount($uid) {
		$type = I('type', 0);
		$optype = I('optype', 0);// 0-解绑 1-绑定
		$account = I('account', '');
		
		$this->checkArguments(Array('type'=>$type));
		$user = M('user')->where(Array('uid'=>$uid))->find();
		
		if($optype) {// 绑定

			// qq
			if($type == 1 ) {
				if ($user['bind_qq'] != null){
					return showData(0,"已绑定，无法再绑定",1);
				}else{
					$this->checkArguments(Array('account'=>$account));
					$result = M('user')->where(Array('uid'=>$uid))->save(Array('bind_qq'=>$account));
				}
			}
			
			// weixin
			if($type == 2 ) {
				if ($user['bind_weixin'] != null){
					return showData(0,"已绑定，无法再绑定",1);
				}else{
					$this->checkArguments(Array('account'=>$account));
					$result = M('user')->where(Array('uid'=>$uid))->save(Array('bind_weixin'=>$account));
				}
			}
			
			// sina
			if($type == 3 ) {
				if ($user['bind_sina'] != null){
					return showData(0,"已绑定，无法再绑定",1);
				}else{
					$this->checkArguments(Array('account'=>$account));
					$result = M('user')->where(Array('uid'=>$uid))->save(Array('bind_sina'=>$account));
				}
			}
			
			// renren
			if($type == 4 ) {
				if ($user['bind_renren'] != null){
					return showData(0,"已绑定，无法再绑定",1);
				}else{
					$this->checkArguments(Array('account'=>$account));
					$result = M('user')->where(Array('uid'=>$uid))->save(Array('bind_renren'=>$account));
				}
			}
		}else{// 解绑
			// qq
			if($type == 1 ) {
				if ($user['bind_qq'] != null){
					//$this->checkArguments(Array('account'=>$account));
					$result = M('user')->where(Array('uid'=>$uid))->save(Array('bind_qq'=>''));
					
				}else{
					return showData(0,"未绑定，无法解绑",1);
				}
			}
			
			// weixin
			if($type == 2 ) {
				if ($user['bind_weixin'] != null){
					//$this->checkArguments(Array('account'=>$account));
					$result = M('user')->where(Array('uid'=>$uid))->save(Array('bind_weixin'=>''));
						
				}else{
					return showData(0,"未绑定，无法解绑",1);
				}
			}
			
			// sina
			if($type == 3 ) {
				if ($user['bind_sina'] != null){
					//$this->checkArguments(Array('account'=>$account));
					$result = M('user')->where(Array('uid'=>$uid))->save(Array('bind_sina'=>''));
						
				}else{
					return showData(0,"未绑定，无法解绑",1);
				}
			}
			
			// renren
			if($type == 4 ) {
				if ($user['bind_renren'] != null){
					//$this->checkArguments(Array('account'=>$account));
					$result = M('user')->where(Array('uid'=>$uid))->save(Array('bind_renren'=>''));
						
				}else{
					return showData(0,"未绑定，无法解绑",1);
				}
			}
		}
		
		if($result){
			return showData("","设置成功");
		}
		
		return showData("","设置失败",1);
		
	}
	
	// 设置用户勿扰时间
	public function setUserWurao($uid) {
		$wurao_start = I("wurao_start", "");
		$wurao_end = I("wurao_end", "");
		$type = I('type', 0);//0-取消 1-开启
		
		if($type)
			$this->checkArguments(Array('wurao_start'=>$wurao_start, 'wurao_end'=>$wurao_end));
		
		$data = null;
		if($type){
			$data['wurao_start'] = $wurao_start;
			$data['wurao_end'] = $wurao_end;
		}else{
			$data['wurao_start'] = '';
			$data['wurao_end'] = '';
		}
		$result = M('user')->where(Array('uid'=>$uid))->save($data);
	
		if($result){
			return showData("","设置成功");
		}
		
		return showData("","设置失败",1);
	}
	
	// 绑定安全手机
	public function bindSafePhone($uid) {
		$phone = I('phone', "");
		
		$this->checkArguments(Array('phone'=>$phone));
		
		// 验证码
		/* $return = self::checkSafePhoneCode(2);
		if ($return['code']) return $return; */
		
		if(is_numeric($phone) == false){
			return showData("","手机格式错误",1);
		}
		
		$user = M('user')->where(Array('uid'=>$uid))->find();
		if(!$user){
			return showData("","用户不存在",1);
		}
		if($user['safe_phone'] != null)
			return showData("","已绑定安全手机，无法再绑定",1);
		
		$result = M('user')->where(Array('uid'=>$uid))->save(Array('safe_phone'=>$phone));
		if($result){
		    $psw=M('user')->field('pswLevel')->where(Array('uid'=>$uid))->find();
		    if($psw['pswLevel']){
		        M('user')->where(Array('uid'=>$uid))->save(Array('safe_level'=>3));
		    }else{
		        M('user')->where(Array('uid'=>$uid))->save(Array('safe_level'=>2));
		    }
			return showData("","设置成功");
		}
		
		return showData("","设置失败",1);
	}
	// 安全手机重置密码
	public function resetPassBySafePhone($uid) {
		// 验证码
		$return = self::checkSafePhoneCode();
		if ($return['code']) return $return;

		
		$password   = trim(I('password', '', ''));
		$data = array();
		if ($password) $data['password'] = md5($password);
		
		if ($data) {
			$this->startTrans();
			if ($this->where(array('uid'=>$uid))->save($data) !== false) {
				if ($password) {	
					$thinkchat = new Thinkchat();
					$thinkchat->init(C('OP_SERVER'));
						
					$ret = $thinkchat->editPasswd($uid, $password);
					if($ret['code'] != 0 ){
						$this->rollback();
						return showData(new \stdClass(), $ret['msg'], 1);
					}
				}
				$this->commit();
				return showData(new \stdClass(), '修改成功');
			}else {
				$this->rollback();
				return showData(new \stdClass(), '修改失败', 1);
			}
		}else {
			return showData(new \stdClass(), '修改成功');
		}
	}
	
	//重新计算安全级别
	private function calcUserSafeLevel($uid) {
		
	}
	//private
	 function sendSysNotice($fid, $msg, $type) {
		
		$thinkchat = new Thinkchat();
		$thinkchat->init(C('OP_SERVER'));
		 
		$uid = 0;
		
		$admin = M("system_config")->where(Array('keyword'=>'sendmsgadminid'))->find();
		if($admin){
			$uid = $admin['content'];
		}
		$from = self::getUserName($uid);
		$to['toid']  = $fid;
		$to['touid'] = $fid;
		$content     = $msg;

		if ($thinkchat->notice($from, $to, $type, $content)){
			return;
		}
			
		return;
	} 
	// 设置用户其他配置 
	// tixing_comment, tixing_zan, tixing_frienddynamic,
	// tixing_notfriendmsg, tixing_group, kuaipai_sendnearbyperson,
	// kuaipai_videoshow
	public function setUserOtherConfig($uid) {
		$data = array();
		
		$tixing_comment = I("tixing_comment", -1);
		if($tixing_comment != -1)
			$data['tixing_comment'] = $tixing_comment;
		
		$tixing_zan = I("tixing_zan", -1);
		if($tixing_zan != -1)
			$data['tixing_zan'] = $tixing_zan;
		
		$tixing_frienddynamic = I("tixing_frienddynamic", -1);
		if($tixing_frienddynamic != -1)
			$data['tixing_frienddynamic'] = $tixing_frienddynamic;
		
		$tixing_notfriendmsg = I("tixing_notfriendmsg", -1);
		if($tixing_notfriendmsg != -1)
			$data['tixing_notfriendmsg'] = $tixing_notfriendmsg;
		
		$tixing_group = I("tixing_group", -1);
		if($tixing_group != -1)
			$data['tixing_group'] = $tixing_group;
		
		$kuaipai_sendnearbyperson = I("kuaipai_sendnearbyperson", -1);
		if($kuaipai_sendnearbyperson != -1)
			$data['kuaipai_sendnearbyperson'] = $kuaipai_sendnearbyperson;
		
		$kuaipai_videoshow = I("kuaipai_videoshow", -1);
		if($kuaipai_videoshow != -1)
			$data['kuaipai_videoshow'] = $kuaipai_videoshow;
		
		if(count($data) > 0) {
			$result = M('user')->where(Array('uid'=>$uid))->save($data);
			if(!$result)
				return showData("", '设置失败', 1);
			else
				return showData("", '设置成功');
		}
		return showData("", '未设置任何项', 1);
	}
	
	/**
	 * 更新用户会员信息--新会员
	 * @param unknown $uid
	 * @param unknown $chongzhi_type
	 * @param unknown $feeid
	 */
	function updateUserMember_newmember($uid, $feeid) {
		$member_fee = M('member_fee')->where(Array('id'=>$feeid))->find();
		if($member_fee == null)
			return;
		$user_member = M('user_member')->where(Array('uid'=>$uid))->find();
		if($user_member) {
			$m=M('user_member')->where(Array('uid'=>$uid))->delete();
		}
		$currTime = time();
		$endTime = $currTime + $member_fee['days'] * 24 * 3600;
		$data['uid'] = $uid;
		$data['time'] = $endTime;
		$data['memberid'] = $feeid;
		
		M('user_member')->add($data);
		
		M('user')->where(Array('uid'=>$uid))->save(Array('memberenddate'=>$endTime, 'memberlevel'=>$feeid));
	}
	/**
	 * 更新用户会员信息--续费
	 * @param unknown $uid
	 * @param unknown $chongzhi_type
	 * @param unknown $feeid
	 */
	function updateUserMember_xuefeimember($uid, $feeid) {
		$member_fee = M('member_fee')->where(Array('id'=>$feeid))->find();
		if($member_fee == null)
			return;
		$user_member = M('user_member')->where(Array('uid'=>$uid))->find();
		if(!$user_member) {
			return;
		}
		$user_time = $user_member['time'];
		$endTime = $user_time + $member_fee['days'] * 24 * 3600;
		$data['time'] = $endTime;
		$data['memberid'] = $feeid;
		
		M('user_member')->where(Array('uid'=>$uid))->save($data);
		
		M('user')->where(Array('uid'=>$uid))->save(Array('memberenddate'=>$endTime, 'memberlevel'=>$feeid));
	}
	
	// 会员续费金额,以前级别低，需要补上以前的费用，如果同级别或高级别，则不需要补上以前的。
	function member_xufei_money($uid){
		$memberid = I('memberid', 0);
		
		$user_member = M('user_member')->where(Array('uid'=>$uid))->find();
		if(!$user_member) {
			return showData(0, '您还不是会员', 1);
		}
		$old_member_level = $user_member['memberid'];
		
		$member_fee = M('member_fee')->where(Array('id'=>$memberid))->find();
		if($member_fee == null)
			return showData(0, '获取会员级别失败', 1);
		
		$old_member_fee = M('member_fee')->where(Array('id'=>$old_member_level))->find();
		if($old_member_fee == null)
			return showData(0, '获取会员级别失败', 1);
		
		$money =$member_fee['fee'];
		if($old_member_fee['fee'] < $member_fee['fee']) {
			$cha_money = $member_fee['fee'] - $old_member_fee['fee'];
			$money += $cha_money;
		}
		
		return showData($money);
	}
	/**
	 * 用户充值 用户id、会员项id、会员费用、支付方式（ 0-支付宝支付 1-微信支付2-余额支付）、充值方式（1-新购买 2-续费）
	 * @param number $uid
	 */
	function recharege($uid=0) {
		$memberid = I('memberid', 0);
		$chongzhi_type = I('chongzhi_type', 1);
		
		$payment = trim(I('action', 0));//0-支付宝
		$fee     = trim(I('fee', 0));//充值金额
		if ($fee>0){
			$data = array(
					'id'		 => date('Ymd').substr(implode(NULL, array_map('ord', str_split(substr(uniqid(), 7, 13), 1))), 0, 8),//订单id
					'uid' 		 => $uid,
					'fee'  	     => $fee,
					'memberid'		 => $memberid,
					'chongzhi_type'=>$chongzhi_type,
					'createtime' => NOW_TIME
			);
			if (M('user_recharge')->add($data)){
				$pay = new \Common\Pay\Pay();
				$subject = '一米充值';
				$body    = '充值';
				switch ($payment) {
					case 0:
						//支付宝 SDK
						$url = SITE_PROTOCOL.SITE_URL.'/index.php/user/api/notifyurl';
						return $pay->alipay($data['id'], $fee, $subject, $body, $url);
						break;
					case 1:
						//微信
						$url = SITE_PROTOCOL.SITE_URL.'/index.php/user/api/wxnotifyurl';
						return $pay->weixin($data['id'], $fee, $subject, $body, $url);
						break;
					case 2:
						//余额
						$user = M('user')->where(Array('uid'=>$uid))->find();
						if(!$user)
							return showData(new \stdClass(), '查询用户失败', 1);
						
						$user_money = $user['money'];
						if($user_money<$fee)
							return showData(new \stdClass(), '余额不足', 1);
						$new_money = $user_money - $fee;
						$result = M('user')->where(Array('uid'=>$uid))->save(Array('money'=>$new_money));
						if(!$result)
							return showData(new \stdClass(), '余额充值失败', 1);
						
						if($chongzhi_type == 1) {
							self::updateUserMember_newmember($uid, $memberid);
						}else if($chongzhi_type == 2){
							self::updateUserMember_xuefeimember($uid, $memberid);
						}
						
						M('user_recharge')->where(Array('id'=>$data['id']))->setField("status", 1);
						
						return showData(new \stdClass(), '充值成功');
						break;
				}
			}
			return showData(new \stdClass(), '充值失败', 1);
		}else {
			return showData(new \stdClass(), '请输入充值金额', 1);
		}
	}
	// ================= 服务 =======================
	/* 服务类别接口 */
	
	public function  service_category_list() {
		$list = M('service_category')->select();
		
		
		
		foreach ($list as $key=>$value) {
			$tmp = $value;
			$tmp['img'] = makeHttpHead($value['img']);
		
			$list[$key] = $tmp;
		}
		
		
		return showData($list);
	}
	/* 服务列表
	 */
	public function service_list($uid){
		$lat = I('lat', '');
		$lng = I('lng', '');
		$categoryid = I('categoryid', 0);
		$keyword = I('keyword', '');
		$where = "1=1 and getDistance('$lng', '$lat', lng, lat)<=5000 ";
		 if($categoryid != 0){
		     $where .= " and categoryid=$categoryid";
		 }
		 if($keyword != ''){
			$where .= " and name like '%$keyword%'"; 
			// 记录用户搜索历史
			M('service_search')->add(Array('uid'=>$uid, 'keyword'=>$keyword, 'createtime'=>time()));
		}   
		
		// 附近人
		$list = $this->m_db_getlistpage('service', $where, "*,getDistance('$lng', '$lat', lng, lat) as distance", "distance asc");
		if($list['code'] != 0)
			return $list;
		
		
		
		return $list;
	}
	
	/* 服务搜索历史 */
	public function service_search_list($uid) {
		$where = "uid=$uid";
		$list = $this->m_db_getlistpage('service_search', $where, "*", "createtime desc", 1, 10);
		$first=$list['data'][0];
		//$list=M('service_search')->field('id,uid,keyword,createtime')->where(array('uid'=>$uid,'id'=>array('neq',$first['id']),'keyword'=>array('neq',$first['keyword'])))->group('keyword')->order('count("keyword") desc')->select();
		$list=M('service_search')->field('id,uid,keyword,createtime')->where(array('uid'=>$uid))->group('keyword')->order('count("keyword") desc')->select();
		$list=$list?$list:Array();
		$list=showData( $list, '', 0);
        //if(!empty($list['data'])) array_unshift($list['data'], $first);
		if($list['code'] != 0)
			return $list;
		return $list;
	}
	
	private function update_user_pos($uid, $lat, $lng) {
		M('user')->where(Array('uid'=>$uid))->save(Array('lat'=>$lat, 'lng'=>$lng));
	}
	// 场景附近的人
	public function changjing_nearby_persons($uid) {
		$lat = I('lat', '');
		$lng = I('lng', '');
		
		$this->checkArguments(Array('lat'=>$lat, 'lng'=>$lng));
		
		self::update_user_pos($uid, $lat, $lng);
		$where = "isdelete=0 and uid<>$uid and getDistance('$lng','$lat',lng,lat)<=5000";
		$field = "uid,headsmall,nickname,lat,lng,getDistance('$lng','$lat',lng,lat) as distance";
		$order = "distance asc";
		$list = $this->m_db_getlistpage('user', $where, $field,$order, 1, 25);
		
		if($list['code'] != 0)
			return $list;
		
		$list['data'] = self::_formatChangjingUser($list['data'], $uid);
		
		return $list;
		
	}
	// 场景附近的服务站点
	public function changjing_nearby_service($uid) {
	    $lat = I('lat', '');
	    $lng = I('lng', '');
	    $categoryid=I('categoryid',0);
	    $this->checkArguments(Array('lat'=>$lat, 'lng'=>$lng));
	
	    self::update_user_pos($uid, $lat, $lng);
	    $where = "getDistance('$lng','$lat',lng,lat)<=5000 and categoryid=$categoryid";
	    $field = "*,getDistance('$lng','$lat',lng,lat) as distance";
	    $order = "distance asc";
	    $list = $this->m_db_getlistpage('service', $where, $field,$order, 1, 50);
	    foreach ($list['data'] as $k=>$v){
	        $list['data'][$k]['img']=makeHttpHead($v['img']);
	    }
	    if($list['code'] != 0){
	        return $list;
	    }
	
        return $list;
	
	}
	// 取消手机安全设置
	public function close_safe_login($uid) {
		M('user')->where(Array('uid'=>$uid))->save(Array('safe_phone'=>''));
		$psw=M('user')->field('pswLevel')->where(Array('uid'=>$uid))->find();
		if($psw['pswLevel']){
		    M('user')->where(Array('uid'=>$uid))->save(Array('safe_level'=>2));
		}else{
		    M('user')->where(Array('uid'=>$uid))->save(Array('safe_level'=>1));
		}
		return showData("");
	}
	
	// 网址收藏
	public function netcollect($uid) {
		$url = I("url", "");
		
		if($url == "") {
			return showData("", "内容不能为空", 1);
		}
		$data['createtime'] = time();
		$data['uid'] = $uid;
		$data['content'] = $url;
		M('user_net')->add($data);
		
		return showData("");
	}
	
	// 记录分享
	public function sharerecord($uid) {
		$content = I('content', '');
		$isopen = I('isopen', 0);
		$type = I('type', 1);
		
		
		$isqqzone = I('isqqzone', 0);
		$isqq = I('isqq', 0);
		$isweixin = I('isweixin', 0);
		$isweixinquan = I('isweixinquan', 0);
		$isweibo = I('isweibo', 0);
		
		if($content== ""){
			return showData("", "内容不能为空", 1);
		}
		
		$data['uid'] = $uid;
		$data['content'] = $content;
		$data['type'] = $type;
		$data['createtime'] = time();
		$data['isqqzone'] = $isqqzone;
		$data['isqq'] = $isqq;
		$data['isweixin'] = $isweixin;
		$data['isweixinquan'] = $isweixinquan;
		$data['isweibo'] = $isweibo;
		
		M('user_sharerecord')->add($data);
		if($type==1){
		    M('kuaipai_statistics')->where(array('linkid'=>$content))->setInc("sharecount", 1);
		}else if($type==2){
		    $result = M('dynamic_share')->add(array('linkid'=>$content,'uid'=>$uid,'createtime'=>time()));  
		    // 统计评论数
		    $count = M('dynamic_share')->where(Array('linkid'=>$content))->count();
		    M('dynamic')->where(Array('id'=>$content))->setField('sharecount', $count);
		}else if($type==4){
		    $result = M('daka')->where(Array('id'=>$content))->setInc("sharecount", 1);
		}
		//app内分享每次加2价值(分享人)
		if($isqqzone==0&&$isqq==0&&$isweixin==0&&$isweixinquan==0&&$isweibo==0){
    	    /*zy修改收益新规则*/
    	    $worthuser=M('user')->field('worth_user')->where(array('uid'=>$uid))->find();
    	    $level=levelMoney($worthuser['worth_user']);
		   $create=NOW_TIME;
		   $this->worth($uid,$create, C('appneifx')*$level,8);
		   $this->money($uid, C('appneifx')*$level);
		}else{
		 	$start = mktime(0,0,0,date('m'),date('d'),date('Y'));
		    $end   = mktime(23,59,59,date('m'),date('d'),date('Y'));
		    $datelist=M('user_sharerecord')->field('createtime')->where("uid=$uid and (isqqzone<>0
		        or isqq<>0 or isweixin<>0 or isweixinquan<>0 or isweibo<>0) and createtime>=$start and createtime<=$end")->count();
		    if($datelist==1){
		        //加20价值
		        /*zy修改收益新规则*/
		        $worthuser=M('user')->field('worth_user')->where(array('uid'=>$uid))->find();
		        $level=levelMoney($worthuser['worth_user']);
    		       $create=NOW_TIME;
    		    $this->worth($uid,$create,C('appwaifx')*$level,7);
    		  $this->money($uid, C('appwaifx')*$level);
    		  //M('dynamic_statistics')->where(array('linkid'=>$id))->setInc('fee',C('appneifx')*$level);
		    }
		}
	
		return showData("");
	}
	
	// 获取全球号码
	public function haoma() {
		$list = $this->m_db_getlistpage('haomao', "", "*"," name asc", 1, 5000);
		
		return $list;
		
			
	}
	
	// 通知附近快拍
	private function notice_nearby_kuaipai($lat, $lng, $title, $uid) {
		Log::write("into notice_nearby_kuaipai");
		if(!$title)
			$title = "有新的快拍了!";
		
		$data['title'] = $title;
		
		$user = M('user')->where(Array('uid'=>$uid))->find();
		$data['username'] = $user['nickname'];
		$data['headsmall'] = $user['headsmall'];
		$wifi=$user['wifi_ssid'];
		$sql = "select *,round(getDistance('$lng','$lat',lng,lat),2) as distance from tc_user where getDistance('$lng','$lat',lng,lat)<=".self::$nearbyKuaipaiDistance." and uid <>$uid";
		//$where="getDistance('$lng','$lat',lng,lat)<=".self::$nearbyKuaipaiDistance." and uid <>$uid and wifi_ssid <>$wifi";
		//$list=M('user')->where($where)->select();
		$model = new Model();
		$list = $model->query($sql);
		$i=0;
		foreach ($list as $v) {
		    if($v['wifi_ssid']!=$wifi){
		        $data['distance']=$v['distance'];
		        self::sendCustomNotice($uid, $v['uid'], self::$NOTICE_NEARBY_KUAIPAI, json_encode($data));
		        $i++;
		    }
		}
		log::write('shuliang='.$i);
	}
	
	// 客户端wifi链接上或断开的时候调用
	public function updatewifi($uid) {
		$lat = I('lat', '');
		$lng = I('lng', '');
		$type = I('type', 1);// 1-链接 0-断开
		$wifi_ssid = I('wifi_ssid', '');
		$wifi_updatetime = time();
		
		$data = array();
		if($type) {// 链接
		    $wifi_ssid=str_replace("&quot;","",$wifi_ssid);
			$data['wifi_ssid'] = $wifi_ssid;
			$data['wifi_updatetime'] = $wifi_updatetime;
			if($lat)
				$data['wifi_lat'] = $lat;
			
			if($lng)
				$data['wifi_lng'] = $lng;
			
			$result = M('user')->where(Array('uid'=>$uid))->save($data);
			if(!$result) {
				return showData("");
			}
			
			
		}else{// 断开
			$data['wifi_ssid'] = '';
			$data['wifi_lat'] = '';
			$data['wifi_lng'] = '';
			$data['wifi_updatetime'] = $wifi_updatetime;
			$result = M('user')->where(Array('uid'=>$uid))->save($data);
			if(!$result) {
				return showData("");
			}
		}
		
		return showData("");
	}
	// 通知同一wifi
	private function notice_tongyi_wifi($uid, $lat, $lng, $title ) {
		Log::write("into notice_tongyi_wifi");
		$userwifi = M("user")->where(Array('uid'=>$uid))->find();
		Log::write( M("user")->getLastSql());
		if(!$userwifi || !$userwifi['wifi_ssid']){
			Log::write("no wifi_ssid");
			return;
		}
		
		if(!$title)
			$title = "有新的快拍了!";
		$user = M('user')->where(Array('uid'=>$uid))->find();
		
		$data['title'] = $title;
		$data['username'] = $user['nickname'];
		$data['headsmall'] = $user['headsmall'];
		$wifi_ssid = $userwifi['wifi_ssid'];
		$starttime = time() - $wifiDiffTime;
		
		$sql = "select *,round(getDistance('$lng','$lat',lng,lat),2) as distance from tc_user where wifi_ssid='$wifi_ssid' and uid <>$uid and wifi_updatetime>='0' and getDistance('$lng','$lat',lng,lat)<= " . self::$wifiDistance;
		$model = new Model();
		$list = $model->query($sql);
		foreach ($list as $v) {
		    $data['distance']=$v['distance'];
			self::sendCustomNotice($uid, $v['uid'], self::$NOTICE_TONGYI_WIFI, json_encode($data));
		}
	}
	//我的快拍
	private function notice_my_kuaipai($uid, $title ) {
   	Log::write("into notice_nearby_kuaipai");
		
		if(!$title)
			$title = "有新的快拍了!";
		
		$data['title'] = $title;
		
		$user = M('user')->where(Array('uid'=>$uid))->find();
		$data['username'] = $user['nickname'];
		$data['headsmall'] = $user['headsmall'];
		
		
	return 	self::sendCustomNotice($uid, $uid, self::$NOTICE_MY_KUAIPAI, json_encode($data));
		
    		
	}
	function test(){
	    $movie = new ffmpeg_movie($video_filePath);
	    $ff_frame = $movie->getFrame(1);
	    $gd_image = $ff_frame->toGDImage();
	    $img="./test.jpg";
	    imagejpeg($gd_image, $img);
	    imagedestroy($gd_image);
	     $uid=I('uid');
	    $fid=I('fid');
	    $type=I('type');
	    $content=I('content');
		self::sendCustomNotice($uid, $fid, $type, $content); 
	    //return  $mes;
	}
	/**
	 * 自定义通知
	 */
	function sharenotice($uid){
	    $btype=I('btype'); //1-个人  2-会话
	    $fid=I('fid');
	    $type=I('type');
	    $content=I('content');
	    if($btype==1){
	        self::sendCustomNotice($uid, $fid, $type, $content);
	    }else if($btype==2){
	        $s_user=M('session_user')->where(array('sessionid'=>$fid,'role'=>0))->select();
	        foreach ($s_user as $k => $v){
	            self::sendCustomNotice($uid, $v['uid'], $type, $content);
	        }
	    }
	    return showData(new \stdClass());
	}
	/**
	 * 管理员推送消息
	 * @param unknown $uid
	 * @param unknown $title
	 */
 	function pushmsg($uid,$title,$url) {
	        $data['title'] = $title;
	        $data['url'] = $url;
	   self::sendCustomNotice($uid, $uid, self::$NOTICE_PUSH_MSG, json_encode($data));
	}


	/**
	 * 模板输出
	 */
	function show($data){
	    $result = array(
	        'data'=> $data,
	    );
	    return $result;
	}
	/**
	 * 动态分享
	 */
	function dynamicshare(){
	    $id =I('id', 0);
	    if($id){
		$where = "u.uid=d.uid and d.id=$id";
		$field = "u.uid, u.nickname, u.headsmall,u.gender,u.logintime,u.age,u.job,u.memberlevel, d.*";
		$order = 'd.createtime desc';
		$info = $this->m_db_getone('dynamic d, ' . $this->tablePrefix . 'user u', $where, $field);
		$info['headsmall']=makeHttpHead($info['headsmall']);
		$info['age']=date('Y-m-d', NOW_TIME)-date('Y-m-d', $info['age']);
		$info['createtime']=date('Y-m-d', $info['createtime']);
		$path=M('dynamic_pic')->where("dynamicid=$id")->find();
		foreach ($path as $k=>$v){
		    $info['path']=makeHttpHead($path['path']);
		    $info['video']=makeHttpHead($path['video']);
		}
		$info['home']=$this->home();
		return $this->show($info);
	    }
	}
	/**
	 * 快拍分享
	 */
	function kuaipaishare(){
	    $id  = trim(I('id',0));
	    if($id){
		$kuaipai = M('kuaipai')->where(Array('id'=>$id))->find();
		if(!$kuaipai){
			return showData("",'快拍不存在',1);
		}
		$kuaipai['createtime']=date('Y-m-d', $kuaipai['createtime']);
		$kuaipai['img']=makeHttpHead($kuaipai['img']);
		$kuaipai['video']=makeHttpHead($kuaipai['video']);
		$kuaipai_admin = $kuaipai['uid'];
		$sql = "select u.uid,u.age, u.headsmall,u.nickname from tc_user u where u.uid=" . $kuaipai_admin;
		$userModel = new Model();
		$user = $userModel->query($sql);
		$user = $user[0];
		foreach ($user as $k=>$v){
		    $kuaipai['nickname'] = $user['nickname'];
		    $kuaipai['headsmall'] = makeHttpHead($user['headsmall']);
		    $kuaipai['age']=date('Y-m-d', NOW_TIME)-date('Y-m-d', $user['age']);
		}
		$kuaipai['home']=$this->home();
		return $this->show($kuaipai);
	     }
	}
	/**
	 * 打卡分享
	 */
	function dakashare(){
	    $id  = trim(I('id',0));
	    if($id){
	        $daka = M('daka')->where(Array('id'=>$id))->find();
	        if(!$daka){
	            return showData("",'打卡信息不存在',1);
	        }
	        $daka['createtime']=date('Y-m-d', $daka['createtime']);
	        $daka_admin = $daka['uid'];
	        $sql = "select u.uid, u.headsmall,u.nickname from tc_user u where u.uid=" . $daka_admin;
	        $userModel = new Model();
	        $user = $userModel->query($sql);
	        $user = $user[0];
            foreach ($user as $k=>$v){
                $daka['headsmall'] = makeHttpHead($user['headsmall']);
                $daka['nickname'] = $user['nickname'];
            }
	       $daka['home']=$this->home();
            return $this->show($daka);
	    }
	}
	//网页分享
	function webshare(){
	    $url=trim(I('url',0));
	    if($url){
	        $link=array();
	        if(strpos($url, "http://") === false){
	            $link['url']=SITE_PROTOCOL. $url;
	        }else{
	            $link['url']=$url;
	        }
		    $link['home']=$this->home();
            return $this->show($link);
	    }
	}
	//首页url地址
	function home(){
	    $home=makeHttpHead('/index.php/Home');
	    return $home;
	}
	/**
	 * 机器人随机昵称
	 * 
	 */
	function getRandChar(){
	    $tou_num=rand(0,331);
        $wei_num=rand(0,325);
        $nicheng_tou=C('nickname1');
        $nicheng_wei=C('nickname2');
        $nicheng=$nicheng_tou[$tou_num].$nicheng_wei[$wei_num];
	    return $nicheng; //输出随机生成的昵称
	}
	/**
	 * 机器人随机头像
	 * 
	 */
	function getRobtPrcture(){
	    $num=rand(0,8);
	    $prcture=C('robtprcture');
	    $robtprcture=$prcture[$num];
	    return $robtprcture;//输出随机头像地址
	}
	
	/**
	 * 随机函数
	 * @param number $min
	 * @param number $max
	 * @return number
	 */
	function randomFloat($min = 0, $max = 100) {
	    return $min + mt_rand() / mt_getrandmax() * ($max - $min);
	}
	/**
	 * 获取周围随机坐标
	 * 
	 * @param 纬度 $lat
	 * @param 经度 $lng
	 * @param 范围(公里) $distance
	 * @return string[]
	 */
	public function returnSquarePoint($lat, $lng,$distance = 2){
	    $earthRadius = 6378138;
	    $dlng =  2 * asin(sin($distance / (2 * $earthRadius)) / cos(deg2rad($lat)));
	    $dlng = rad2deg($dlng);
	    $dlat = $distance/$earthRadius;
	    $dlat = rad2deg($dlat);
	  
	    $max=$lng + $dlng;//最大经度
	    $min=$lng - $dlng;//最小经度
	    $num=$this->randomFloat($min,$max);
	    $newNum  = sprintf("%.6f",$num);
	    $lngloc= $newNum;
	   
	    
	    $max= $lat + $dlat;//最大纬度
	    $min=$lat - $dlat;//最小纬度
	    $num=$this->randomFloat($min,$max);
	    $newNum  = sprintf("%.6f",$num);
	    $latloc= $newNum;
	    return array("latloc"=>"$latloc","lngloc"=>"$lngloc");
	}


	/**
	 * 随机浏览动态20个并点一次赞
	 */
    function browsedynamic($count=20){
        //检查是否开启自动浏览
        $manage=M('manage')->where('dtype=1')->find();
        if(!$manage){
            return;
        }
        $robtlist=M("user")->field('uid')->where("usertype=1")->select();
        if($robtlist){
            $starttime=NOW_TIME;
    //        $endtime=$starttime+20*60;
            $where['createtime']=array('EGT',$manage['time']);
            $where['robt_look']=array('EQ',0);
            $dy=M('dynamic');
            $dynamic=$dy->field('id,uid')->where($where)->select();
            foreach ($dynamic as $k=>$v){
                for($x=0; $x<$count; $x++){
                    $datafuid=$robtlist[mt_rand(0,count($robtlist)-1)];
                    //$time=mt_rand($starttime,$endtime);
                    $data = array('robt_look'=>1);
                    $dy->where(array('id'=>$v['id']))->save($data);
                    $this->guest($v['uid'], $datafuid['uid'], $type=1, NOW_TIME);
                }
                M('dynamic')->where(array('id'=>$v['id']))->setInc('zancount');
                $stat['viewcount']=array('exp','viewcount+20');
                $stat['zancount']=array('exp','zancount+1');
                M('dynamic_statistics')->where(array('linkid'=>$v['id']))->save($stat);
            }
    //         $datatime=$time=mt_rand($starttime,$endtime);
    //         M('dynamic_zan')->add(array('uid'=>$uid,'linkid'=>"$linkid",'createtime'=>"$datatime"));
        }
    }
    function guest($uid, $fuid, $type=1,$time){
        if ($uid != $fuid){
            $data  = array('uid'=>$uid, 'fuid'=>$fuid, 'type'=>$type);
            $map   = $data;
            if (M('dynamic_guest')->where($map)->count()){
                //更新时间
                M('dynamic_guest')->where($map)->setField('createtime', $time);
            }else {
                $data['createtime'] = $time;
                M('dynamic_guest')->add($data);
            }
        }
    }
    /**
     * 随机浏览快拍20个并点一次赞
     */
    function browsekuaipai($count=20){
        //检查是否开启自动浏览
        $manage=M('manage')->where('ktype=1')->find();
        if(!$manage){
            return;
        }
        $robtlist=M("user")->field('uid')->where("usertype=1")->select();
        if($robtlist){
            $starttime=NOW_TIME;
            //        $endtime=$starttime+20*60;
            $where['createtime']=array('EGT',$manage['time']);
            $where['robt_look']=array('EQ',0);
            $kuaipai=M('kuaipai')->field('id,uid')->where($where)->select();
            $kuaipai=M('kuaipai');
            $kuaipai_stat= M('dynamic_statistics');
            foreach ($kuaipai as $k=>$v){
                $kp['zancount']=array('exp','zancount+1');
                $kp['robt_look']=array('exp','robt_look+1');
                $kuaipai->where(array('id'=>$v['id']))->save($kp);
                $stat['viewcount']=array('exp','viewcount+20');
                $stat['zancount']=array('exp','zancount+1');
                $kuaipai_stat->where(array('linkid'=>$v['id']))->save($stat);
                
            }
        }
    }
  //分享url
    function shareurl($type=0,$id=0,$url=''){
        if($id&&$type){
            $url=makeHttpHead("/index.php/User/api/sharepage?type=$type&id=$id");
            return $url;
        }
        if($type&&$url){
            $url=makeHttpHead("/index.php/User/api/sharepage?type=$type&url=$url");
            return $url;
        }
    }
	/**
	 * 价值
	 * $uid 用户
	 * $value 价值
	 */
     	 function worth($uid,$create,$value,$type){
         	 $data['uid']=$uid;
     	     $data['type']=$type;
       	     $data['createtime']=$create;
        	 $data['value']=$value*100;
        	 $worthlist=D("worth")->add($data);
       	  return $worthlist;
     	}
     /**
      *金额
      */
     function money($uid,$value){
         $user=$this->where(array('uid'=>$uid))->find();
         $U['money'] = $user['money']+$value;
         if($value>0){
             $U['worth_user'] = $user['worth_user']+$value*100;
         }
         $list=$this->where("uid=$uid")->save($U);
         return $list;
         
     }
}