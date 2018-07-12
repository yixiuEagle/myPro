<?php
/**
 * 群
 */
namespace Share\Model;
use Think\Model;
use Common\Tools\Pinyin;
use Think\Log;
use Common\Model\CommonModel;

class GroupModel extends CommonModel {
    public $tableName = 'groups';
    public $pk        = 'id';
    
    public $join     = '';
    public $string   = '';
    public $field    = '';
    /**
     * 数据格式化
     * @param array $user
     * @param int   $uid
     */
    private function _format($list, $uid=0){
        $_list = array();
        if ($list) {
            foreach ($list as $k=>$v){
                $tmp = $v;
                $tmp['supplier_name'] = "";
                $tmp['supplier_phone'] = "";
                $tmp['supplier_ID_card_picture'] = "";
                if($tmp['status'] == "" || $tmp['status'] == null){
                    $tmp['status'] = 0;
                }elseif($tmp['status'] == 0){
                    $tmp['status'] = 3;
                    $supplier = M('supplier')->where(array('groups_id'=>$tmp['id'],'uid'=>$uid))->field("id,name,phone")->find();
                    $tmp['supplier_name'] = $supplier['name'];
                    $tmp['supplier_phone'] = $supplier['phone'];
                    $tmp['supplier_ID_card_picture'] = site_url(M('supplier_gallery')->where('sid='.$supplier['id'])->getField('originUrl'));
                }
                if (isset($v['background'])){
                    $ba = M('background')->getField('background_group');
                    $tmp['background'] = $v['background'] ? SITE_PROTOCOL.SITE_URL.$v['background'] : SITE_PROTOCOL.SITE_URL.$ba;
                    $tmp['backgroundlarge'] = str_replace('/s_', '/', $tmp['background']);
                }
                if (isset($v['logo'])){
                    $tmp['logo'] = $v['logo'] ? SITE_PROTOCOL.SITE_URL.$v['logo'] : '';
                }
                $tmp['sid'] = empty($tmp['sid'])?0:$tmp['sid'];
                $_list[] = $tmp;
            }
        }
        return $_list;
    }
    /**
     * 列表
     * @param array $map
     * @param string $limit
     * @param string $order
     * @param number $uid
     * @return array
     */
    function public_list($uid, $map, $limit, $order='id desc'){
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
        $field .= ',ifnull((select `smallUrl` from `'.$this->tablePrefix.'groups_head` where id=u.logo),\'\') as logo';
        //是否关注
        $field .= ',(select count(*) from `'.$this->tablePrefix.'groups_follow` where uid='.$uid.' and groupsid=u.id) as isfollow';
        //类别
        $field .= ',(select `name` from `'.$this->tablePrefix.'share_category` where id=u.cateid) as categoryname';
        //关注人数
        $field .= ',(select count(*) from `'.$this->tablePrefix.'groups_follow` where groupsid=u.id) as followcount';
        //是否黑名单
        $field .= ',(select count(*) from `'.$this->tablePrefix.'groups_black` where uid='.$uid.' and groupsid=u.id) as isblack';
        //是否开店
        $field .= ',(select count(*) from `'.$this->tablePrefix.'supplier` where groups_id=u.id and status=1) as is_shop';
        //审核状态
        $field .= ',(select status from `'.$this->tablePrefix.'supplier` where groups_id=u.id) as status';
        $field .= ',(select count(*) from `'.$this->tablePrefix.'group_user` where groupid=u.group_id and uid='.$uid.') as is_join';
        $field .= ',(select count(*) from `'.$this->tablePrefix.'look_record` where look_id=u.id and uid='.$uid.' and type=1) as look_count';

        $join .= ' left join '.$this->tablePrefix.'supplier s on u.id=s.groups_id';
        $field .= ',s.id as sid';
        
        $list  = $this->alias('u')->field($field)->join($join)->where($map)->order($order)->limit($limit)->select();
        $_list = self::_format($list,$uid);
        if ($list && $limit == 1) {
            return $_list['0'];
        }else {
            return $_list;
        }
    }
    /**
     * 列表
     * @param array $map
     * @param string $uid
     * @param string $order
     */
	private function _list($map, $uid, $order=''){
	    //自定义条件
	    if ($this->string) $map['_string'] = $this->string;
	
	    $total = $this->alias('u')->where($map)->count();
	    if ($total){
	        $page  = page($total);
	        $limit = $page['offset'] . ',' . $page['limit'];
	    }else {
	        $page  = '';
	    }
	    $list  = $total ? self::public_list($uid, $map, $limit, $order) : array();
	    return showData($list, '', 0, $page);
	}
    /**
     * 创建群
     * @param number $uid
     */
    function addGroups($uid) {
        //检测用户是否会员，可以创建群的个数不同
        //检查权限
        $access = addGroupCount($uid);
        if ($access['code']) return $access;
        
        $data = array(
            'uid'           => $uid,
            'background'    => '',//主图
            'logo'          => '',//群头像
            'number'        => mt_rand(100000000, 999999999),//群号
            'name'          => trim(I('name')),//群名称
            'sign'          => trim(I('sign')),//群签名
            'remark'        => trim(I('remark')),//群备注群规
            'address'       => trim(I('address')),//群地址
            'lat'           => trim(I('lat',0)),//纬度
            'lng'           => trim(I('lng',0)),//经度
            'cateid'        => trim(I('cateid')),//类别
            'isdefault'     => trim(I('default',0)),//默认号
            'createtime'    => NOW_TIME,
            'isshow'        => 0,
        );
        //检测用户是不是会员
        $member = M('user_member_time')->where('uid='.$uid.' and time>'.NOW_TIME)->find();
        if ($member) $data['isshow'] = 1;
        
        $headList = array();
        
        if (!empty($_FILES)){
            $images = upload();
            if (is_array($images)){
                foreach ($images as $k=>$v){
                    if ($v['key'] == 'background'){
                        $data['background'] = $v['smallUrl'];
                    }else {
                        $data['logo'] = $v['id'];
                        $headList[] = $v;
                    }
                }
            }else {
                return showData(new \stdClass(), $images, 1);
            }
        } 
        if (!$data['logo']) return showData(new \stdClass(), '请上传群头像', 1);
        
        if (!$data['name']) {
            return showData(new \stdClass(), '请输入群名称', 1);
        }else {
            if (iconv_strlen($data['name'],"UTF-8")>20) return showData(new \stdClass(), '你输入的群名称太长了', 1);
            $data['sort'] = Pinyin::pinyin($data['name'], 1, 1);
        }
        if ($data['sign']){
            if (iconv_strlen($data['sign'],"UTF-8")>60) return showData(new \stdClass(), '你输入的签名太长了', 1);
        }
        if (!$data['cateid']) return showData(new \stdClass(), '请选择类别', 1);
        
        if ($data['lat']){
            if (!$data['address']) return showData(new \stdClass(), '请选择发布地点', 1);
            if (!$data['lat'] || !$data['lng']) return showData(new \stdClass(), '请选择经纬度', 1);
            //取得城市
            $result = getDetailAddress($data['lat'], $data['lng']);
            if ($result){
                $data['city'] = $result['result']['addressComponent']['city'];
            }
        }
        //默认群
        if ($data['isdefault']){
            $this->where(array('uid'=>$uid))->setField('isdefault', 0);
        }
        $groupsid = $this->add($data);
        if ($groupsid) {
            //保存头像
            if ($headList){
                foreach ($headList as $kh=>&$vh){
                    $vh['gid'] = $groupsid;
                }
                M('groups_head')->addAll($headList);
            }

            //添加群组
            $groupData = array(
                'uid'			=> $uid,
                'name'			=> $data['name'],
                'logosmall' 	=> $data['logo'],
                'description'	=> '',
                'rule'		=> $data['remark'],
                'cat_id'		=> 0,
                'address'		=> $data['address'],
                'lat'           =>$data['lat'],
                'lng'           =>$data['lng'],
                'extend'		=> '',
                'createtime'	=> NOW_TIME
            );
            $groupid = M('group')->add($groupData);
            if ($groupid) {
                $group = array('groupid' => $groupid,'uid' => $uid,'addtime' => NOW_TIME,'role' => 1);
                M('group_user')->add($group);
            }
            $this->where(array('id'=>$groupsid))->save(array('group_id'=>$groupid));
            return showData(new \stdClass(), '发布成功');
        }
        return showData(new \stdClass(), '发布失败', 1);
    }
    /**
     * 群列表 (0-所有群列表, 1-我关注的  2-我创建的 3-搜索 4-黑名单)
     * @param unknown $uid
     */
    function lists($uid) {
        $action = trim(I('action', 0));
        $mylat    = trim(I('lat'));
        $mylng    = trim(I('lng'));
        $map    = array();
        $this->field = 'u.id, u.uid, u.name, u.sign, u.background, u.isdefault,u.group_id,u.lat,u.lng,u.cateid';
        $data   = showData(array());
        switch ($action) {
            case 0:
                //取得城市
                $lat    = trim(I('lat'));
                $lng    = trim(I('lng'));
                if (!$lat || !$lng) return showData(new \stdClass(), '请先定位', 1);
                $result = getDetailAddress($lat, $lng);
                if ($result){
                    $map['city'] = $result['result']['addressComponent']['city'];
                } 
                $cateid = trim(I('cateid', 0));
                $map['u.uid']=array('neq',$uid);
                if ($cateid) $map['u.cateid'] = $cateid;
                $data = self::_list($map, $uid, 'u.id desc');
                break;
            case 1:
//                $this->string = 'u.id in(select `groupsid` from `'.$this->tablePrefix.'groups_follow` where uid='.$uid.') or u.uid in (select f.fuid from tc_user_follow f where f.uid= '.$uid.')';
                $this->string = 'u.id in(select `groupsid` from `'.$this->tablePrefix.'groups_follow` where uid='.$uid.')';
                $this->field = "u.*,(select `create` from ".$this->tablePrefix."look_record where type=1 and look_id=u.id order by `create` desc limit 1) look_time";
                $map['u.uid'] = array('neq',$uid);
                $data = self::_list($map, $uid, 'look_time desc');
                 /* $this->string = 'u.id in (select id from '.$this->tablePrefix.'groups where uid='.$uid.')';
                $this->field = "u.*,(select `create` from ".$this->tablePrefix."look_record where type=1 and look_id=u.id order by `create` desc limit 1) look_time";
                unset($map['u.uid']);
                $createGroups = self::_list($map, $uid, 'look_time desc');  */
                $showData = array();
                /* foreach($createGroups['data'] as $g){
                    $showData[] = $g;
                }  */
                foreach($data['data'] as $g){
                    $showData[] = $g;
                }
                $data['data'] = $showData;
                break;
            case 2:
                $map['u.uid'] = $uid;
                $data = self::_list($map, $uid, 'u.sort asc');
                break;
            case 3:
                $name = trim(I('name'));
                if (!$name) return showData(new \stdClass(), '请输入搜索内容', 1);
                $where = '';
                if (is_numeric($name)){
                    $where = "u.uid in(select `uid` from `".$this->tablePrefix."user` where `phone` like '%".$name."%')";
                }
                $this->string = "(u.name like '%".$name."%') or (u.id like '%".$name."%')";
                if ($where) $this->string .= ' or ('.$where.')';
                //$map['u.name|u.id'] = array('like', '%'.$name.'%');
                $data = self::_list($map, $uid, 'u.id desc');
                break;
            case 4:
                $this->string = 'u.id in(select `groupsid` from `'.$this->tablePrefix.'groups_black` where uid='.$uid.')';
                $data = self::_list($map, $uid);
                break;
        }
        $groups=array();
        foreach ($data['data'] as $k => $v){
            if(!$v['isblack']){
                $dis=$this->getDistance($mylat,$mylng,$v['lat'],$v['lng']);
                $v['distance']=$dis;
                $groups[]=$v;
            }         
        }
        foreach($groups as $k =>$v){
            $distance[$k] = $v['distance'];
        }
        array_multisort($distance, $groups);
        return showData($groups);
    }
    
    /**
     * 设置默认号
     * @param number $uid
     * @param number $id
     */
    function setDefault($uid, $id){
        $this->where(array('uid'=>$uid))->setField('isdefault', 0);
        if ($this->where(array('id'=>$id))->setField('isdefault', 1)){
            return showData(new \stdClass(), '设置成功');
        }
        return showData(new \stdClass(), '设置失败', 1);
    }
    /**
     * 群详细
     * @param number $uid
     * @param number $id
     */
    function detail($uid, $id) {
        $map  = array('u.id'=>$id);
        $data = self::public_list($uid, $map, 1);
        if($data['isfollow'] == 1){
            M('look_record')->add(array(
                'uid' => $uid,
                'look_id' => $data['id'],
                'type' => 1,
                'create' => NOW_TIME
            ));
        }
        //获取群头像列表
        $gallery = self::getGallerylists($data['id']);
        $data['gallery'] = $gallery;
        //群主
        $db = new \User\Model\UserModel();
        $user = $db->getUserName($data['uid']);
        $data['user'] = $user ? $user : new \stdClass();
        //群二维码
        $PNG_TEMP_DIR = SITE_DIR.'/Uploads/Picture/code/';
        //html PNG location prefix
        $PNG_WEB_DIR = SITE_PROTOCOL.SITE_URL.'/Uploads/Picture/code/';
        
        include COMMON_PATH.'phpqrcode/qrlib.php';
        
        //ofcourse we need rights to create temp dir
        if (!file_exists($PNG_TEMP_DIR))
            mkdir($PNG_TEMP_DIR);
        $filename = $PNG_TEMP_DIR.'groups_'.$data['id'].'.png';
        //processing form input
        //remember to sanitize user input in real-life solution !!!
        $errorCorrectionLevel = 'L';
        $matrixPointSize = 4;
        //default data
        \QRcode::png('groupid:'.$data['id'], $filename, $errorCorrectionLevel, $matrixPointSize, 2);
        //display generated file
        $data['qrcode'] = $PNG_WEB_DIR.basename($filename);
        
        return showData($data);
    }
    /**
     * 获取群头像列表
     * @param unknown $id
     */
    function getGallerylists($id){
        $gallery = M('groups_head')->where(array('gid'=>$id))->select();
        if ($gallery){
            foreach ($gallery as $k=>&$v){
                $v['originUrl'] = SITE_PROTOCOL.SITE_URL.$v['originUrl'];
                $v['smallUrl']  = SITE_PROTOCOL.SITE_URL.$v['smallUrl'];
            }
        }else {
            $gallery = array();
        }
        return $gallery;
    }
    /**
     * 添加关注和取消关注
     */
    function follow($uid, $id){
        $action = trim(I('action', 0));
        $data   = array('uid'=>$uid, 'groupsid'=>$id);
        $db     = M('groups_follow');
        $count  = $db->where($data)->count();
        $groups = M('groups')->where('id='.$id)->find();
        if ($action){
            if (!$count) return showData(new \stdClass(), '你未关注该群', 1);
            if ($db->where($data)->delete()){
                $group_db = new \Group\Model\GroupModel();
                $group_db->follow($uid,$groups['group_id'],0);
                return showData(new \stdClass(), '取消关注成功');
            }
            return showData(new \stdClass(), '取消关注失败', 1);
        }else {
            if ($count) return showData(new \stdClass(), '你已关注了该群', 1);
            $data['addtime'] = NOW_TIME;
            if ($db->add($data)){
                $group_db = new \Group\Model\GroupModel();
                $group_db->follow($uid,$groups['group_id'],1);
                return showData(new \stdClass(), '关注成功');
            }
            return showData(new \stdClass(), '关注失败', 1);
        }
    }
	/**
	 * 加入黑名单和取消黑名单
	 * @param unknown $uid
	 * @param unknown $fuid
	 */
	function addBlack($uid, $fuid) {
	    $action = trim(I('action', 0));//0-添加 1-取消
	    $db     = M('groups_black');
	    $data   = array('uid'=>$uid, 'groupsid'=>$fuid);
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
	 * 编辑资料 编辑个人资料、设置默认头像、删除图片、更换主图、新增图片
	 * @param number $uid
	 */
	function edit($uid, $id) {
	    $data = array();
	    $name = trim(I('name', ''));//昵称
	    $sign = trim(I('sign',''));
	     
		if ($name) {
	        if (iconv_strlen($name,"UTF-8")>10) return showData(new \stdClass(), '你输入的昵称太长了', 1);
	        $data['name'] = $name;
	    }
	    if ($sign) {
	        if (iconv_strlen($name,"UTF-8")>60) return showData(new \stdClass(), '你输入的签名太长了', 1);
	        $data['sign'] = $sign;
	    }
	     
	    if ($data){
	        if ($this->where(array('id'=>$id))->save($data)){
	            return showData(new \stdClass(), '修改成功');
	        }
	        return showData(new \stdClass(), '修改成功');
	    }else {
	        return showData(new \stdClass(), '你未提交任何内容', 1);
	    }
	}
	/**
	 * 新增图片
	 */
	function addHead($uid, $id){
	    $headList = array();
	    if (!empty($_FILES)){
	        $images = upload();
	        if (is_array($images)){
	            foreach ($images as $k=>&$v){
	                $headList[] = $v;
	            }
	            //保存头像
	            foreach ($headList as $kh=>&$vh){
	                $vh['gid'] = $id;
	            }
	            if (M('groups_head')->addAll($headList)){
	                $gallery = self::getGallerylists($id);
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
	    $id = trim(I('imageid', 0));
	    if (!$id) return showData(new \stdClass(), '请选择一张图片', 1);
	     
	    if (M('groups_head')->where(array('id'=>$id))->delete()){
	        return showData(new \stdClass(), '删除成功');
	    }
	    return showData(new \stdClass(), '删除失败', 1);
	}
	/**
	 * 设置默认图片
	 */
	function setDefaultHead($uid, $id){
		Log::write("post=" . json_encode($_REQUEST));
	    $imageid = trim(I('imageid', 0));
	    if (!$imageid) return showData(new \stdClass(), '请选择一张图片', 1);
	     
	    if ($this->where(array('id'=>$id))->setField('logo', $imageid)){
	        return showData(new \stdClass(), '设置成功');
	    }
	    return showData(new \stdClass(), '设置失败', 1);
	}
	/**
	 * 更换主图
	 */
	function editBackground($uid, $id){
	    $headList = array();
	    if (!empty($_FILES)){
	        $images = upload();
	        if (is_array($images)){
	            if ($this->where(array('id'=>$id))->setField('background', $images['0']['smallUrl'])){
	                return showData(new \stdClass(), '更换成功');
	            }
	            return showData(new \stdClass(), '更新失败', 1);
	        }else {
	            return showData(new \stdClass(), $images, 1);
	        }
	    }else {
	        return showData(new \stdClass(), '请上传图片', 1);
	    }
	}
}