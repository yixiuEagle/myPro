<?php
/**
 * 用户模块
 * @author yangdong
 *
 */
namespace User\Model;
use Think\Model;
use Lincense\Controller\Thinkchat;
use Common\Model\CommonModel;
class UserModel extends CommonModel {
	public $tableName 	= 'user';
	public $pk        	= 'uid';
	public $friendTable  = 'user_friend';
	
	public $join     = '';
	public $string   = '';
	public $field    = '';
	
	const TYPE_10000  = 10000;//暂无
	const TYPE_10001  = 10001;//申请加好友
	const TYPE_10002  = 10002;//同意加好友
	const TYPE_10003  = 10003;//不同意加好友
	const TYPE_10004  = 10004;//删除好友
	
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
				$tmp = $v;
			    unset($tmp['password']);
			    $tmp['headid'] = $v['head'];
			    $tmp['head'] = $v['face'] ? SITE_PROTOCOL.SITE_URL.$v['face'] : '';
				unset($tmp['face']);
				
				if (isset($v['background'])){
				    $ba = M('background')->getField('background_user');
				    $tmp['background'] = $v['background'] ? SITE_PROTOCOL.SITE_URL.$v['background'] : SITE_PROTOCOL.SITE_URL.$ba;
				    $tmp['backgroundlarge'] = str_replace('/s_', '/', $tmp['background']);
				}
				//会员
				$member = M('user_member_time')->field('*,(select `logo` from `'.$this->tablePrefix.'user_member` where id=memberid) as lv')->where('uid='.$v['uid'].' and time>'.NOW_TIME)->find();
				$tmp['ismember'] = $member ? 1 : 0;
				$tmp['memberid'] = $member ? $member['memberid'] : '';
			    $tmp['lv']       = $member ? SITE_PROTOCOL.SITE_URL.$member['lv'] : '';
                $tmp['distance'] = $this->getDistance(I('lat'),I('lng'),$tmp['lat'],$tmp['lng']);
				$_list[] = $tmp;
			}
		}
		return $_list;
	}
	/**
	 * 取得用户的uid,name headsmall
	 * @param int|string $uid
	 * @return array
	 */
	public function getUserName($uid){
		$this->field = 'uid, name, head,sign,ismember';
		return self::public_list($uid, array('uid'=>$uid), 1);
	}
	public function getUserBackgroud($uid){
		$this->field = 'background';
		return self::public_list($uid, array('uid'=>$uid), 1);
	}
	/**
	 * 系统用户名
	 */
	public function systemUserName(){
		return array('uid'=>'admin', 'name'=>'admin', 'head'=>'');
	}
	/**
	 * 检查是否是好友
	 * @param unknown $uid
	 * @param unknown $fid
	 * @return boolean
	 */
	private function _checkisFriend($uid, $fid){
	    $count = M($this->friendTable)->where("(uid=$uid and fuid=$fid) or (uid=$fid and fuid=$uid)")->count();
	    if ($count) {
	        return array('status'=>1);
	    }else {
	        return array('status'=>0, 'user'=>self::getUserName($uid));
	    }
	}
	/**
	 * 用户列表
	 * @param unknown $map
	 * @param unknown $limit
	 * @param string $order
	 * @param number $uid
	 * @return unknown
	 */
	function public_list($uid, $map, $limit, $order='uid asc'){
	    $join = '';
	    //自定义字段
	    if ($this->field) {
	        $field = $this->field;
	    }else {
	        $field = 'u.*';
	    }
	    //自定义联合查询
	    if ($this->join) $join = $this->join;
	    //自定义条件
	    if ($this->string) $map['_string'] = $this->string;
	    //获取头像
	    $field .= ',(select `smallUrl` from `'.$this->tablePrefix.'user_head` where id=u.head) as face';
	    //是否关注
	    $field .= ',(select count(*) from `'.$this->tablePrefix.'user_follow` where uid='.$uid.' and fuid=u.uid) as isfollow';
	    //是否黑名单
	    $field .= ',(select count(*) from `'.$this->tablePrefix.'user_black` where uid='.$uid.' and fuid=u.uid) as isblack';
	    $field .= ',(select count(*) from `'.$this->tablePrefix.'user_black` where uid=u.uid and fuid='.$uid.') as isblack2';
        //所建群数量
        $field .= ',(select count(*) from `'.$this->tablePrefix.'group` where uid='.$uid.') as group_count';
        //空间号数量
        $field .= ',(select count(*) from `'.$this->tablePrefix.'groups` where uid='.$uid.') as hao_count';
        //优惠券数量
        $field .= ',(select count(*) from `'.$this->tablePrefix.'user_coupon` a left join '.$this->tablePrefix.'goods b on a.goods_id=b.id where a.uid='.$uid.' and a.status = 1 and a.is_use = 0 and b.start_time<='.NOW_TIME.' and b.end_time>='.NOW_TIME.') as coupon_count';
	    
	    $list  = $this->alias('u')->field($field)->join($join)->where($map)->order($order)->limit($limit)->select();
		$_list = self::_format($list,$uid);
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
	function detail($uid, $fid=0){
	    $id = $uid;
		if ($fid && $fid != $uid) $id = $fid;
		$data = self::public_list($uid, array('uid'=>$id), 1);
        if($data['isfollow'] == 1){
            M('look_record')->add(array(
                'uid' => $uid,
                'look_id' => $data['uid'],
                'type' => 3,
                'create' => NOW_TIME
            ));
        }
		//获取头像列表
        $gallery = self::getGalleryLists($id, $data['headid']);
        $data['gallery'] = $gallery;
        //关注的群
        $db = new \Share\Model\GroupModel();
        $string   = 'id in(select `groupsid` from `'.$this->tablePrefix.'groups_follow` where uid='.$id.')';
        $myfollow = $db->field('id, name')->where($string)->select();
        $data['myfollowgroup'] = $myfollow ? $myfollow : array();
        //所建的群号
        $mycreate = $db->field('id, name')->where(array('uid'=>$id))->select();
        $data['mycreategroup'] = $mycreate ? $mycreate : array();
        //所建的群
        $group = M('group')->field('id, name')->where(array('uid'=>$id))->select();
        $data['group'] = $group ? $group : array();
        //取得会员
        $data['memberAccess'] = self::getMemberAccess($uid);
        //到期时间
        $exptime = M('user_member_time')->where(array('uid'=>$uid))->getField('time');
        $data['expiretime'] = $exptime ? $exptime : 0;
        //二维码
        $PNG_TEMP_DIR = SITE_DIR.'/Uploads/Picture/usercode/';
        //html PNG location prefix
        $PNG_WEB_DIR = SITE_PROTOCOL.SITE_URL.'/Uploads/Picture/usercode/';
        
        include COMMON_PATH.'phpqrcode/qrlib.php';
        
        //ofcourse we need rights to create temp dir
        if (!file_exists($PNG_TEMP_DIR))
        	mkdir($PNG_TEMP_DIR);
        $filename = $PNG_TEMP_DIR.'user_'.$data['uid'].'.png';
        //processing form input
        //remember to sanitize user input in real-life solution !!!
        $errorCorrectionLevel = 'L';
        $matrixPointSize = 4;
        //default data
        \QRcode::png('userid:'.$data['uid'], $filename, $errorCorrectionLevel, $matrixPointSize, 2);
        //display generated file
        $data['qrcode'] = $PNG_WEB_DIR.basename($filename);
        
		return showData($data);
	}
	/**
	 * 获取头像列表
	 */
	function getGalleryLists($id, $headid){
	    //获取头像列表
	    $gallery = M('user_head')->where(array('uid'=>$id))->select();
	    if ($gallery){
	        foreach ($gallery as $k=>&$v){
	            $v['originUrl'] = SITE_PROTOCOL.SITE_URL.$v['originUrl'];
	            $v['smallUrl']  = SITE_PROTOCOL.SITE_URL.$v['smallUrl'];
	            $v['default']   = 0;
	            if ($headid == $v['id']) $v['default'] = 1;
	        }
	    }else {
	        $gallery = array();
	    }
	    return $gallery;
	}
	/**
	 * 用户注册
	 */
	function regist(){
	    $data = array(
	        'phone'        => trim(I('phone')),
	        'password'     => trim(I('password')),
	        'name'         => trim(I('name')),
	    );
	    $code = new CodeModel();
	    $return = $code->checkCode();
	    if ($return['code']) return $return;
	    //验证手机
	    if (!$data['phone']) {
	        return showData(new \stdClass(), '请输入手机号', 1);
	    }else {
	        if ($this->where(array('phone'=>$data['phone']))->count())
	            return showData(new \stdClass(), '该手机已注册', 1);
	    }
	    //验证密码
	    if (!$data['password']) {
	        return showData(new \stdClass(), '请输入密码', 1);
	    }else {
	        $password = $data['password'];	//openfire密码
	        $data['password'] = md5($data['password']);
	    }
	    //昵称
	    if (!$data['name']) {
	        return showData(new \stdClass(), '请输入昵称', 1);
	    }else {
	        if (iconv_strlen($data['name'],"UTF-8")>10) return showData(new \stdClass(), '昵称太长了', 1);
	    }
	    $headList = array();
	    if (!empty($_FILES)){
	        $images = upload();
	        if (is_array($images)){
	            $data['head'] = $images['0']['id'];
	            foreach ($images as $k=>&$v){
	                $headList[] = $v;
	            }
	        }else {
	            return showData(new \stdClass(), $images, 1);
	        }
	    }else {
	        return showData(new \stdClass(), '请上传头像', 1);
	    }
	    
	    $uid = $this->add($data); 
	    if ($uid){
	        
	        $thinkchat = new Thinkchat();
	        $thinkchat->init(C('OP_SERVER'));
	        
	        $ret = $thinkchat->regist($uid, $password);
	        if($ret['code'] != 0 ){
	            //注册失败 删除数据
	            $this->where(array('uid'=>$uid))->delete();
	            return showData(new \stdClass(), $ret['msg'], 1);
	        }
	        //保存头像
	        if ($headList){
	            foreach ($headList as $kh=>&$vh){
	                $vh['uid'] = $uid;
	            }
	            M('user_head')->addAll($headList);
	        }
	        $info = self::detail($uid);
	        return showData($info['data'], '注册成功');
	        
	    }
	    return showData(new \stdClass(), '注册失败', 1);
	}
	/**
	 * 用户登录
	 */
	function login(){
	    $phone	  = trim(I('phone'));
	    $password = trim(I('password'));
	    
	    if (!$phone) return showData(new \stdClass(), '请输入手机号', 1);
	    if (!$password) return showData(new \stdClass(), '请输入密码', 1);
	     
	    $info = $this->field('uid,phone,password,isshield')->where(array('phone'=>$phone))->find();
	    if ($info) {
	        //是否被屏蔽
	        if ($info['isshield']) return showData(new \stdClass(), '你被举报，现已被系统禁止登录', 1);
	        if ($info['password'] == md5($password)) {
	            $info = self::detail($info['uid']);
                $info['data']['lng'] = I('lng','');
                $info['data']['lat'] = I('lat','');
                if(!empty($info['data']['lng']) && !empty($info['data']['lat'])){
                    $this->setLonLat($info);
                }
                //添加用户积分
                $last_time = date('Y-m-d',$info['data']['last_time']);
                $now_time = date('Y-m-d',NOW_TIME);
                if($last_time != $now_time){
                    $this->where(array('uid'=>$info['data']['uid']))->save(array('last_time'=>NOW_TIME));
                    $this->where(array('uid'=>$info['data']['uid']))->setInc('integral',1);
                    $info['data']['integral'] = intval($info['data']['integral'])+1;
                }
                $uid = $info['data']['uid'];
                $memberid = M("user_member_time")->where('uid='.$uid.' and time >='.NOW_TIME)->getField('memberid');
                $info['data']['headcount'] = M("user_member_time")->where('id='.$memberid)->getField('headcount');
	            return showData($info['data'], '登录成功');
	        }
	    }
	    return showData(new \stdClass(), '帐号不存在或者密码错误', 1);
	}
	/**
	 * 搜索用户
	 */
	function search($uid){
	    $search = trim(I('search'));
	    if (!$search) return showData(new \stdClass(), '请输入搜索内容', 1);
	    $map['name|phone'] = array('like', '%'.$search.'%');
	    $this->field = 'uid, name, head, sign';
	    $list = self::public_list($uid, $map, 0);
	    return showData($list);
	}
	/**
	 * 修改密码
	 */
	function editPwd($uid){
	    $oldpassword = trim(I('oldpassword'));
	    $newpassword = trim(I('newpassword'));
	    
	    if (!$oldpassword) return showData(new \stdClass(), '请输入旧密码', 1);
	    if (!$newpassword) return showData(new \stdClass(), '请输入新密码', 1);
	    
	    $info = $this->field('password')->where(array('uid'=>$uid))->find();
	    if ($info['password'] == md5($oldpassword)){
	        if ($this->where(array('uid'=>$uid))->setField('password', md5($newpassword))){
	            $thinkchat = new Thinkchat();
	            $thinkchat->init(C('OP_SERVER'));
	            $thinkchat->editPasswd($uid, $newpassword);
	            
	            return showData(new \stdClass(), '修改成功');
	        }
	        return showData(new \stdClass(), '修改失败', 1);
	    }
	    return showData(new \stdClass(), '旧密码错误', 1);
	}	
	/**
	 * 反馈意见
	 */
	function feedback($uid){
	    $data = array(
	        'uid'          => $uid,
	        'content'      => trim(I('content')),
	        'createtime'   => NOW_TIME
	    );
	    if (!$data['content']) return showData(new \stdClass(), '请输入反馈内容', 1);
	    $db = M('feedback');
	    if ($db->add($data)){
	        return showData(new \stdClass(), '反馈成功，感谢您宝贵的意见');
	    }
	    return showData(new \stdClass(), '提交失败', 1);
	}
	/**
	 * 编辑资料 编辑个人资料、设置默认头像、删除图片、更换主图、新增图片
	 * @param number $uid
	 */
	function edit($uid) {
	    $data = array();
	    $name = trim(I('name', ''));//昵称
	    $sign = trim(I('sign',''));//
	    
	    if ($name) {
	        if (iconv_strlen($name,"UTF-8")>20) return showData(new \stdClass(), '你输入的昵称太长了', 1);
	        $data['name'] = $name;
	    }
	    if ($sign) {
	        if (iconv_strlen($sign,"UTF-8")>60) return showData(new \stdClass(), '你输入的签名太长了', 1);
	        $data['sign'] = $sign;
	    }
	    
	    if ($data){
	        if ($this->where(array('uid'=>$uid))->save($data)){
	            return showData(new \stdClass(), '修改成功');
	        }
	        //return showData(new \stdClass(), '修改失败', 1);
	        return showData(new \stdClass(), '修改成功');
	    }else {
	        return showData(new \stdClass(), '你未提交任何内容', 1);
	    }
	}
	/**
	 * 新增图片
	 */
	function addHead($uid){
	    $headList = array();
	    if (!empty($_FILES)){
	        $images = upload();
	        if (is_array($images)){
	            foreach ($images as $k=>&$v){
	                $headList[] = $v;
	            }
	            //保存头像
	            foreach ($headList as $kh=>&$vh){
                    $vh['uid'] = $uid;
                }
                if (M('user_head')->addAll($headList)){
                    $headid = $this->where(array('uid'=>$uid))->getField('headid');
                    $gallery = self::getGalleryLists($uid, $headid);
                    return showData($gallery, '添加成功');
                }
                return showData(new \stdClass(), '添加失败', 1);
	        }else {
	            return showData(new \stdClass(), $images, 1);
	        }
	    }else {
	        return showData(new \stdClass(), '请上传图片', 1);
	    }
	}
	/**
	 * 删除图片
	 */
	function deleteHead($uid){
	    $id = trim(I('id', 0));
	    if (!$id) return showData(new \stdClass(), '请选择一张图片', 1);
	    
	    if (M('user_head')->where(array('id'=>$id))->delete()){
	        return showData(new \stdClass(), '删除成功');
	    }
	    return showData(new \stdClass(), '删除失败', 1);
	}
	/**
	 * 设置默认图片
	 */
	function setDefaultHead($uid){
	    $id = trim(I('id', 0));
	    if (!$id) return showData(new \stdClass(), '请选择一张图片', 1);
	    
	    if ($this->where(array('uid'=>$uid))->setField('head', $id)){
	        return showData(new \stdClass(), '设置成功');
	    }
	    return showData(new \stdClass(), '设置失败', 1);
	}
	/**
	 * 更换主图
	 */
	function editBackground($uid){
	    $headList = array();
	    if (!empty($_FILES)){
	        $images = upload();
	        if (is_array($images)){
	            if ($this->where(array('uid'=>$uid))->setField('background', $images['0']['smallUrl'])){
	                $data = $images['0'];
	                $data['smallUrl'] = SITE_PROTOCOL.SITE_URL.$data['smallUrl'];
	                $data['originUrl'] = SITE_PROTOCOL.SITE_URL.$data['originUrl'];
	                return showData($data, '更换成功');
	            }
	            return showData(new \stdClass(), '更新失败', 1);
	        }else {
	            return showData(new \stdClass(), $images, 1);
	        }
	    }else {
	        return showData(new \stdClass(), '请上传图片', 1);
	    }
	}
	/**
	 * 关注与取消关注
	 * @param unknown $uid
	 * @param unknown $fuid
	 */
	function follow($uid, $fuid) {
	    $action = trim(I('action', 0));//0-添加关注 1-取消关注
	    $db     = M('user_follow');
	    $data   = array('uid'=>$uid, 'fuid'=>$fuid);
	    $count  = $db->where($data)->count();
	    if ($action){
	       if (!$count) return showData(new \stdClass(), '你未关注该用户', 1);
	       if ($db->where($data)->delete()){
	           return showData(new \stdClass(), '取消关注成功');
	       }
	       return showData(new \stdClass(), '取消关注失败', 1);
	    }else {
	        if ($count) return showData(new \stdClass(), '你已关注该用户', 1);
	        $data['addtime'] = NOW_TIME;
	        if ($db->add($data)){
	            return showData(new \stdClass(), '关注成功');
	        }
	        return showData(new \stdClass(), '关注失败', 1);
	    }
	}
	
	/**
	 * 我关注的人
	 * @param unknown $uid
	 */
	function myfollow($uid) {
		$table = "user_follow f, ".C("DB_PREFIX")."user u,".C("DB_PREFIX")."user_head h";
		$where = "f.uid = $uid and f.fuid=u.uid and u.head=h.id";
		$field= "u.uid,u.name,h.smallurl as head";
        $field .= ",(select count(*) from ".$this->tablePrefix."look_record where look_id=f.fuid and uid='".$uid."' and type=3) look_count";
        $field .= ",(select `create` from ".$this->tablePrefix."look_record where type=3 and look_id=u.uid order by `create` desc limit 1) look_time";

		$r = $this->m_db_getlistpage($table,$where,$field,'look_time desc');
		if($r ) {
			$list = $r['data'];
			foreach ($list as $k=>$v) {
				$list[$k]['head'] = SITE_PROTOCOL.SITE_URL.$v['head'];
				
			}
			
			$r['data'] = $list;
		}
		return $r;
	}
	/**
	 * 加入黑名单和取消黑名单
	 * @param unknown $uid
	 * @param unknown $fuid
	 */
	function addBlack($uid, $fuid) {
	    $action = trim(I('action', 0));//0-添加 1-取消
	    $db     = M('user_black');
	    $data   = array('uid'=>$uid, 'fuid'=>$fuid);
	    $count  = $db->where($data)->count();
	    if ($action){
	       if (!$count) return showData(new \stdClass(), '该用户未加入黑名单', 1);
	       if ($db->where($data)->delete()){
	           return showData(new \stdClass(), '取消成功');
	       }
	       return showData(new \stdClass(), '取消失败', 1);
	    }else {
	        if ($count) return showData(new \stdClass(), '已加入了黑名单', 1);
	        $data['addtime'] = NOW_TIME;
	        if ($db->add($data)){
	            return showData(new \stdClass(), '添加成功');
	        }
	        return showData(new \stdClass(), '添加失败', 1);
	    }
	}
	/**
	 * 黑名单列表
	 */
	function blackList($uid) {
	    $this->string = 'uid in(select `fuid` from `'.$this->tablePrefix.'user_black` where uid='.$uid.')';
	    $data = self::public_list($uid, array(), 0);
	    return showData($data);
	}
	/**
	 * 用户充值
	 * @param number $uid
	 */
	function recharege($uid=0) {
	    $payment = trim(I('action', 0));//0-支付宝
	    $fee     = trim(I('fee', 0));//充值金额
	    if ($fee>0){
	        $data = array(
	            'id'		 => date('Ymd').substr(implode(NULL, array_map('ord', str_split(substr(uniqid(), 7, 13), 1))), 0, 8),//订单id
	            'uid' 		 => $uid,
	            'fee'  	     => $fee,
	            'createtime' => NOW_TIME
	        );
	        if (M('user_recharge')->add($data)){
	            $pay = new \Common\Pay\Pay();
	            $subject = '乐津充值';
	            $body    = '充值';
	            switch ($payment) {
	                case 0:
	                    //支付宝 SDK
	                    $url = SITE_PROTOCOL.SITE_URL.'/index.php/user/api/notifyurl';
	                    return $pay->alipay(C('RECHAREGE_PAY_PRE').$data['id'], $fee, $subject. $body, $url);
	                    break;
	            }
	        }
	        return showData(new \stdClass(), '充值失败', 1);
	    }else {
	        return showData(new \stdClass(), '请输入充值金额', 1);
	    }
	}
	/**
	 * 会员列表
     * 可以设置非会员发布的留言字数限制数量，
     * 会员级别列表，可以增加或修改会员级别列表，
     * 设置该类别会员一个月费用，可以设置该类别会员可以设置的头像数量，可以发布分享的数量，也可以设置为不限。
	 */
	function memberList(){
	    //id, name, monthfee, headcount sharecount, messagecount type 0-非会员 1-会员
	    $list = M('user_member')->where(array('type'=>1))->select();
	    return showData($list ? $list : array());
	}
	/**
	 * 用户购买时间(过期就不是会员了)
	 */
	function memberBuytime($uid){
	    //uid, 到期时间， 会员类型
	    $month     = trim(I('month'));    //购买月数
	    if ($month){
	        if (!is_numeric($month)) return showData(new \stdClass(), '请输入整数', 1);
	    }else {
	        return showData(new \stdClass(), '请输入购买月数', 1);
	    }
	    $memberid  = trim(I('memberid'));  //会员类型
	    if (!$memberid) return showData(new \stdClass(), '请选择会员类型', 1);
	    
        $db        = M('user_member_time');
        $data      = array('uid'=>$uid, 'memberid'=>$memberid);
        $info      = $db->where($data)->find();
        
        $time      = strtotime("+".$month." month");
        
        $member    = M('user_member')->where(array('id'=>$memberid))->find();
        $fee = $month*$member['monthfee'];
        
        $balance   = $this->where(array('uid'=>$uid))->getField('balance');
        if ($balance<$fee) return showData(new \stdClass(), '余额不足', 1);
        
        if ($info){
            //如果过期，直接更新时间
            if ($info['time']<NOW_TIME){
                if ($db->where($data)->setField('time', $time)){
                    //扣掉钱钱
                    $this->where(array('uid'=>$uid))->save(array('balance'=>array('exp', 'balance-'.$fee)));
                    return showData(new \stdClass(), '购买成功');
                }
                return showData(new \stdClass(), '购买失败', 1);
            }else {
                return showData(new \stdClass(), '暂时不能更改会员类型，请直接续费', 1);
            }
        }else {
            //直接加入数据
            $data['time'] = $time;
            if ($db->add($data)){
                //扣掉用户的钱钱
                $this->where(array('uid'=>$uid))->save(array('balance'=>array('exp', 'balance-'.$fee)));
                
                return showData(new \stdClass(), '购买成功');
            }
            return showData(new \stdClass(), '购买失败', 1);
        }
	}
	/**
	 * 续费
	 */
	function renewFee($uid){
	    $month     = trim(I('month'));    //购买月数
	    if ($month){
	        if (!is_numeric($month)) return showData(new \stdClass(), '请输入整数', 1);
	    }else {
	        return showData(new \stdClass(), '请输入购买月数', 1);
	    }
	    
	    $db        = M('user_member_time');
	    $data      = array('uid'=>$uid);
	    $info      = $db->where($data)->find();
	    
	    //$time      = $month*30*24*60*60;
	    $exptime   = date('Y-m-d H:i:s', $info['time']);
	    $time      = strtotime($exptime." +".$month." month");
	     
	    $member    = M('user_member')->where(array('id'=>$info['memberid']))->find();
	    $fee = $month*$member['monthfee'];
	    
	    $balance   = $this->where(array('uid'=>$uid))->getField('balance');
	    if ($balance<$fee) return showData(new \stdClass(), '余额不足', 1);
	    
	    if ($db->where($data)->save(array('time'=>array('exp', 'time+'.$time))) ){
	        $this->where(array('uid'=>$uid))->save(array('balance'=>array('exp', 'balance-'.$fee)));
	         
	        return showData(new \stdClass(), '续费成功');
	    }
	    return showData(new \stdClass(), '续费失败', 1);
	}
	/**
	 * 转变会员类型
	 * @param unknown $uid
	 */
	function changeMember($uid){
	    $memberid  = trim(I('memberid', 0));
	    if (!$memberid) return showData(new \stdClass(), '请选择要转变的会员类型', 1);
	    
	    //当前用户的会员类型
	    $user = M('user_member_time')->where(array('uid'=>$uid))->find();
	    if (!$user) return showData(new \stdClass(), '你还不是会员', 1);
	    //当前用户的会员类型
	    $fee = M('user_member')->where(array('id'=>$user['memberid']))->getField('monthfee');
	    
	    $info = M('user_member')->find($memberid);
	    if ($info){
	        if ($fee>$info['monthfee']){
	            //转变为低等级的会员
	            if (M('user_member_time')->where(array('uid'=>$uid))->setField('memberid', $memberid)){
	                return showData(new \stdClass(), '转变成功');
	            }
	            return showData(new \stdClass(), '转变失败', 1);
	        }else {
	            //转变成高等级的会员
	            $exptime = $user['time']-NOW_TIME;
	            if ($exptime > 0){
	                //取得还有几个月
	                $month = round($exptime/(30*24*60*60), 2);
	                $price = round(($info['monthfee']-$fee), 2);
	                //echo 'month='.$month.'<br>';
	                //echo 'price='.$price.'<br>';
	                //补差价
	                $totalPrice = round($month*$price, 2);
	                //echo 'totalPrice='.$totalPrice.'<br>';
	                $balance   = $this->where(array('uid'=>$uid))->getField('balance');
	                //echo 'balance='.$balance.'<br>';
	         
	                if ($balance<$totalPrice) return showData(new \stdClass(), '余额不足', 1);
	                
	                if (M('user_member_time')->where(array('uid'=>$uid))->setField('memberid', $memberid)){
	                    $this->where(array('uid'=>$uid))->save(array('balance'=>array('exp', 'balance-'.$totalPrice)));
	                    return showData(new \stdClass(), '转变成功');
	                }
	                return showData(new \stdClass(), '转变失败', 1);
	            }else {
	                return showData(new \stdClass(), '你的会员已过期', 1);
	            }
	        }
	    }else {
	        return showData(new \stdClass(), '请选择要转变的会员类型', 1);
	    }
	}
	/**
	 * 得到当前会员的权限
	 */
	function getMemberUserAccess($uid){
	    $data = self::getMemberAccess($uid);
	    return showData($data);
	}
	/**
	 * 得到当前会员的权限
	 */
	function getMemberAccess($uid){
	    //可以获取到期时间最小的那个权限
        $db   = M('user_member_time');
        $info = $db->where(array('uid'=>$uid))->find();
        $member = M('user_member');
        if ($info){
            if ($info['time']<NOW_TIME){
                $data = $member->where(array('type'=>0))->find();
            }else {
                $data = $member->where(array('id'=>$info['memberid']))->find();
            }
        }else {
            $data = $member->where(array('type'=>0))->find();
        }
        $data['logo'] = $data['logo'] ? SITE_PROTOCOL.SITE_URL.$data['logo'] : '';
        $data['expiretime'] = $info ? $info['time'] : '';
        return $data;
	}
	/**
	 * 帮助中心
	 * 使用说明
	 * 会员说明
	 * 违规处罚
	 */
    function help(){
        $data = array(
            'helpcenter' => SITE_PROTOCOL.SITE_URL.'/index.php/user/html/web/type/1',
            'usement'    => SITE_PROTOCOL.SITE_URL.'/index.php/user/html/web/type/2',
            'memberment' => SITE_PROTOCOL.SITE_URL.'/index.php/user/html/web/type/3',
            'punishment' => SITE_PROTOCOL.SITE_URL.'/index.php/user/html/web/type/4',
            'regist'     => SITE_PROTOCOL.SITE_URL.'/index.php/user/html/web/type/5',
        );
        return showData($data);
    }
    /**
     * 检查更新
     */
    function update(){
        
    }
    /**
     * 举报
     * @param unknown $param
     */
    function jubao($uid) {
        $type = trim(I('type', 0));//0-用户 1-群号
	    $data   = array('uid'=>$uid, 'otherid'=>trim(I('otherid')), 'content'=>trim(I('content')), 'type'=>$type, 'createtime'=>NOW_TIME);
	    if (!$data['otherid']) return showData(new \stdClass(), '请选择举报用户或群号', 1);
	    if (!$data['content']) {
	        return showData(new \stdClass(), '请选择举报内容', 1);
	    }else {
	        if ($data['content'] == '请选择举报类型') return showData(new \stdClass(), '请选择举报内容', 1);
	    }
	    $db = M('jubao');
	    if ($db->add($data)){
	        return showData(new \stdClass(), '举报成功');
	    }
	    return showData(new \stdClass(), '举报失败', 1);
    }
    /**
     * 举报列表
     */
    function jubaoLists(){
        $list = M('jubao_list')->select();
        return showData($list ? $list : array());
    }
    /**
     * 红点提醒
     * @param number $uid
     */
    function dotTip($uid) {
        $info = M('message_tip')->where(array('uid'=>$uid))->find();
        if ($info){
            $arr = M('groups_follow')->field('groupsid')->where('`groupsid`>0 and `uid` ='.$uid.' and `groupsid` not in(select `groupsid` from '.$this->tablePrefix.'groups_black where uid='.$uid.')')->select();
            $string = '';
            if ($arr){
                foreach ($arr as $k=>$v){
                    $string .= 'find_in_set('.$v['groupsid'].', `groupids`) or ';
                }
            }
            //获取我关注的人
            $string .= ' (s.uid in(select `fuid` from `'.$this->tablePrefix.'user_follow` where uid='.$uid.') and s.uid not in(select `fuid` from `'.$this->tablePrefix.'user_black` where uid='.$uid.'))';
            $tip4 = M('share')->alias('s')->where('('.$string . ') and `createtime`>'.$info['time4'])->count();
            
            $data = array(
                'tip1'  => M('messages')->where(array('createtime'=>array('gt', $info['time1']), 'type'=>0))->count() ? 1 : 0,
                'tip2'  => M('messages')->where(array('createtime'=>array('gt', $info['time2']), 'type'=>1))->count() ? 1 : 0,
                'tip3'  => M('share')->where(array('createtime'=>array('gt', $info['time3']), 'uid'=>$uid))->count() ? 1 : 0,
                'tip4'  => $tip4 ? 1 : 0,
            );
        }else {
            $data = array(
                'tip1'  => 1,
                'tip2'  => 1,
                'tip3'  => 1,
                'tip4'  => 1
            );
        }
        return showData($data);
    }
    
    function citylist() {
    	$list = M("city")->order("sort asc")->select();
    	
    	return showData($list);
    }

    function isMember($uid){
        $count = $this->where(array('uid'=>$uid))->count();
        if($count > 0){
            return true;
        }else{
            return false;
        }
    }
    /**
     * 手机通讯录好友
     */
    function phoneBook($data) {
        //查询通讯录好友信息
        $join = "left join ".$this->tablePrefix."user_head uh on u.head = uh.id";
        $map = array("u.phone"=>array("in",$data['phones']));
        $res = $this->alias('u')->field("u.uid,uh.smallUrl,uh.originUrl,u.phone,u.name")->join($join)->where($map)->select();
        $users = array();
        $userIds = array();
        foreach ($res as $v){
            $users[$v['phone']] = $v;
            $userIds[] = $v['uid'];
        }
//        //查询我的好友，统计我的好友中有多少人添加了这些手机号为好友
//        $friend = M('user_follow')->field('uid')->where(array('_string'=>"uid in (SELECT fuid FROM ".$this->tablePrefix."user_follow where uid='".$data['uid']."')"))->where(array('fuid'=>$data['uid']))->select();
//        $friendIds = array();
//        foreach ($friend as $f){
//            $friendIds[] = $f['uid'];
//        }
//        $friend = M('user_follow')->field('uid,count(*) as count')->where(array('_string'=>"uid in (SELECT fuid FROM ".$this->tablePrefix."user_follow where uid in ('".implode("','",$friendIds)."'))"))->where(array('fuid'=>array('in',$friendIds)))->where(array('uid'=>array('in',$userIds)))->group('uid')->select();
//        foreach ($friend as $f){
//            $friend[$f['uid']] = $f['count'];
//        }
        $isReg = array();
        $isNotReg = array();
        foreach ($data['phones'] as $key => $p){
            $p = preg_replace('/\xa3([\xa1-\xfe])/e', 'chr(ord(\1)-0x80)', $p);
            if (empty($users[$p])){
                $isNotReg[] = array(
                    'uid' => '',
                    'smallUrl' => '',
                    'phone' => $p,
                    'name' => $data['names'][$key],
                    'isfollow' => 0,
                    'join_count' => 0
                );
            }else{
                $count = M('user_follow')->where(array('uid'=>$data['uid'],'fuid'=>$users[$p]['uid']))->count();
                $count1 = M('user_follow')->where(array('fuid'=>$data['uid'],'uid'=>$users[$p]['uid']))->count();
                $isReg[] = array(
                    'uid' => $users[$p]['uid'],
                    'smallUrl' => $users[$p]['smallUrl']?site_url($users[$p]['smallUrl']):'',
                    'phone' => $users[$p]['phone'],
                    'name' => $users[$p]['name'],
                    'isfollow' => $count?$count:0,
                    'join_count' => $count1?$count1:0
                );
            }
        }
        $result = array_merge($isReg,$isNotReg);
        return showData($result);
    }
    /**
     * 附近的人
     */
    function nearby($data) {
        $this->field = 'u.*,ifnull(left((POWER(MOD(ABS(lng - '.$data['lng'].'),360),2) + POWER(ABS(lat - '.$data['lat'].'),2)),15),9999999999) AS distance';
        $where = array('u.uid'=>array('neq',$data['uid']));
        $total = $this->alias("u")->where($where)->count();
        if ($total){
            $page  = page($total);
            $limit = $page['offset'] . ',' . $page['limit'];
        }else {
            $page  = '';
        }
        $data = self::public_list($data['uid'], $where, $limit, 'distance asc');

        //根据距离排序
        $sort = array();
        foreach($data as $k => $v){
            $sort[$k] = $v['distance'];
        }
        array_multisort($sort, SORT_ASC, $data);
        return showData($data,'',0,$page);
    }
    /**
     * 设置用户经纬度
     */
    function setLonLat($data){
        $this->where(array('uid'=>$data['data']['uid']))->save(array('lng'=>$data['data']['lng'],'lat'=>$data['data']['lat']));
    }
    /**
     * 提现
     */
    function extract($data){
        if(floatval($data['price']) <= 0){
            return showData(new \stdClass(),'提现金额必须大于0',1);
        }
        if(empty($data['account_number'])){
            return showData(new \stdClass(),'账号不可以为空',1);
        }
        if(empty($data['account_name'])){
            return showData(new \stdClass(),'账户姓名不可以为空',1);
        }
        //查询用户余额
        $user = M('user')->where('uid='.$data['uid'])->find();
        if(floatval($data['price']) > floatval($user['balance'])){
            return showData(new \stdClass(),'账户余额不足',1);
        }
        $data['status'] = 0;
        $data['create_time'] = NOW_TIME;
        if(M('withdraw')->add($data)){
            M('user')->where('uid='.$data['uid'])->setDec('balance',$data['price']);
            return showData(new \stdClass(),'提交成功');
        }
        return showData(new \stdClass(),'提交失败',1);
    }

    /**
     * 优惠券公共列表
     * @param $uid
     * @param $map
     * @param $limit
     * @param string $order
     * @return array|mixed
     */
    function public_coupon_list($uid, $map, $limit, $order='c.id desc'){
        $join = 'left join '.$this->tablePrefix.'goods d on c.goods_id=d.id left join '.$this->tablePrefix.'supplier e on d.sid=e.id';
        //自定义字段
        if ($this->field) {
            $field = $this->field;
        }else {
            $field = '';
        }
        //自定义联合查询
        if ($this->join) $join = $this->join;
        //自定义条件
        if ($this->string) $map['_string'] = $this->string;
        $field .= "c.goods_id,c.is_use,d.smallUrl,originUrl,d.name,e.name supplier_name,d.deducted_price,d.start_time,d.end_time";

        $list  = M('user_coupon')->alias('c')->field($field)->join($join)->where($map)->order($order)->limit($limit)->select();
        $couponList = array();
        foreach ($list as $v){
            if(empty($v["name"])){
                continue;
            }
            $v['smallUrl'] = empty($v['smallUrl'])?"":site_url($v['smallUrl']);
            $v['originUrl'] = empty($v['originUrl'])?"":site_url($v['originUrl']);
            $v['supplier_name'] = empty($v['supplier_name'])?"":$v['supplier_name'];
            $v['start_time'] = empty($v['start_time'])?"":$v['start_time'];
            $v['end_time'] = empty($v['end_time'])?"":$v['end_time'];
            $v['deducted_price'] = empty($v['deducted_price'])?0:$v['deducted_price'];
            $now_time = NOW_TIME;
            $v['is_expire'] = 0;
            if(intval($v['end_time']) < $now_time){
                $v['is_expire'] = 1;
            }
            $couponList[] = $v;
        }
        if ($couponList && $limit == 1) {
            return $couponList['0'];
        }else {
            return $couponList;
        }
    }
    /**
     * 我的优惠券
     */
    function myCoupon($uid){
        $where = array('c.uid'=>$uid);
        $where['c.status'] = 1;
        $where['c.is_use'] = 0;
        $where['d.name'] = array('exp','is not null');
        $join = 'left join '.$this->tablePrefix.'goods d on c.goods_id=d.id';
        $total = M('user_coupon')->alias("c")->join($join)->where($where)->count();
        $limit = 1;
        if ($total){
            $page  = page($total);
            $limit = $page['offset'] . ',' . $page['limit'];
        }else {
            $page  = '';
        }
        $result = $this->public_coupon_list($uid,$where,$limit);
        return showData($result,'',0,$page);
    }

    function extract_list($map, $limit, $order='w.create_time asc'){
        $join = '';
        //自定义字段
        if ($this->field) {
            $field = $this->field;
        }else {
            $field = 'w.*,u.name,u.balance';
        }
        //自定义联合查询
        if ($this->join) $join = $this->join;
        $join = "left join ".$this->tablePrefix."user u on w.uid=u.uid";
        //自定义条件
        if ($this->string) $map['_string'] = $this->string;

        $list  = M('withdraw')->alias('w')->field($field)->join($join)->where($map)->order($order)->limit($limit)->select();
        if ($list && $limit == 1) {
            return $list['0'];
        }else {
            return $list;
        }
    }

    /**
     * 会员等级列表
     */
    function member(){
        $return = M("user_member")->select();
        return showData($return);
    }
}