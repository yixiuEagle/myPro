<?php
/**
 * 发现模块
 * @author yangdong
 *
 */
namespace Find\Model;
use Think\Model;
use Lincense\Controller\Thinkchat;
use Common\Model\CommonModel;
class FindModel extends CommonModel {
	public $tableName 	= 'activity_source';
	public $pk        	= 'id';
	
	public $join     = '';
	public $string   = '';
	public $field    = '';
	
	function _initialize(){
		parent::_initialize();
	}

    /**
     * 用户30天创建的活动/闲置数量
     * @param $uid
     */
    function userFindCount($uid,$type){
        $start_time = date('Y-m',NOW_TIME);
        $start_time .= '-'.C('USER_ACTIVITY_SOURCE_DATE');
        $start_time = strtotime($start_time);
        $where = array('_string'=>'create_time >= '.$start_time.' and create_time <= '.NOW_TIME.' and type='.$type.' and uid='.$uid);
        return M('activity_source')->where($where)->count();
    }

    function _format($list,$type){
        if(is_array($list)){
            $result = array();
            foreach ($list as $item){
                $pic = json_decode($item['pic'],true);
                foreach($pic as &$v){
                    $v['smallUrl'] = site_url($v['smallUrl']);
                    $v['originUrl'] = site_url($v['originUrl']);
                }
                if($type == 1){
                    $arr = array(
                        'id' => $item['id'],
                        'title' => $item['title'],
                        'pic' => $pic,
                        'address' => $item['address'],
                        'start_time' => $item['start_time'],
                        'end_time' => $item['end_time'],
                        'sign_count' => $item['sign_count'],
                        'fees_price' => $item['fees_price'],
                        'is_sign' => $item['is_sign'],
                        'sign_id' => '',
                        'order_no' => $item['order_no'],
                        'status' => $item['status'],
                        'remark' => $item['remark'],
                        'create_time' => $item['create_time']
                    );
                    if(intval($arr['is_sign']) > 0){
                        $arr['sign_id'] = $item['sign_id'];
                    }
                }else{
                    $arr = array(
                        'id' => $item['id'],
                        'title' => $item['title'],
                        'pic' => $pic,
                        'address' => $item['address'],
                        'start_time' => $item['start_time'],
                        'end_time' => $item['end_time'],
                        'fees_type' => $item['fees_type'],
                        'fees_price' => $item['fees_price'],
                        'remark' => $item['remark'],
                        'create_time' => $item['create_time']
                    );
                }
                $result[] = $arr;
            }
            return $result;
        }else{
            return array();
        }
    }

    function _format_comment($list){
        if(is_array($list)){
            $result = array();
            foreach ($list as $item){
                $arr = array(
                    'uid' => $item['uid'],
                    'name' => $item['name'],
                    'smallUrl' => site_url($item['smallUrl']),
                    'originUrl' => site_url($item['originUrl']),
                    'id' => $item['id'],
                    'content' => $item['content'],
                    'create_time' => $item['create_time']
                );
                $result[] = $arr;
            }
            return $result;
        }else{
            return array();
        }
    }

    /**
     * 公共活动资源列表
     * @param unknown $map
     * @param unknown $limit
     * @param string $order
     * @return unknown商家id、头像、昵称、地址、类别id、类别名称、星级
     */
    function public_list($uid,$map, $limit, $order='a.id asc',$type){
        $join = '';
        //自定义字段
        if ($this->field) {
            $field = $this->field;
        }else {
            $field = 'a.*';
        }
        //自定义联合查询
        if ($this->join) $join = $this->join;
        //自定义条件
        if ($this->string) $map['_string'] = $this->string;

        $field .= ',(select count(*) from `'.$this->tablePrefix.'activity_sign` b where b.activity_id=a.id and b.uid='.$uid.' and b.status=1) as is_sign';
        $field .= ',(select count(*) from `'.$this->tablePrefix.'activity_sign` b where b.activity_id=a.id) as sign_count';
        $field .= ',c.activity_id as sign_id,c.status,c.order_no';
        $join .= 'left join '.$this->tablePrefix.'activity_sign c on a.id=c.activity_id and c.uid='.$uid;

        $list  = $this->alias('a')->field($field)->join($join)->where($map)->order($order)->limit($limit)->select();
        $_list = self::_format($list,$type);
        if ($list && $limit == 1) {
            return $_list['0'];
        }else {
            return $_list;
        }
    }

    /**
     * 公共活动资源评论列表
     * @param unknown $map
     * @param unknown $limit
     * @param string $order
     * @return unknown商家id、头像、昵称、地址、类别id、类别名称、星级
     */
    function public_comment_list($map, $limit, $order='a.id asc'){
        $join = 'left join '.$this->tablePrefix.'user b on a.uid = b.uid left join '.$this->tablePrefix.'user_head c on b.head = c.id';
        //自定义字段
        if ($this->field) {
            $field = $this->field;
        }else {
            $field = 'a.*,c.smallUrl,c.originUrl,b.uid,b.name';
        }
        //自定义联合查询
        if ($this->join) $join = $this->join;
        //自定义条件
        if ($this->string) $map['_string'] = $this->string;

        $list  = M('activity_source_comment')->alias('a')->field($field)->join($join)->where($map)->order($order)->limit($limit)->select();
        $_list = self::_format_comment($list);
        if ($list && $limit == 1) {
            return $_list['0'];
        }else {
            return $_list;
        }
    }

    /**
     * 创建活动/资源
     * @param mixed|string $data
     * @return array|mixed
     */
    function create($data){
        $member = $this->getUserMember($data['uid']);
        $userCount = $this->userFindCount($data['uid'],$data['type']);
        if($data['type'] == 1){
            if($userCount > $member['activity_count']){
                return showData(new \stdClass(), '超出了当前会员等级发布活动的数量', 1);
            }
//            if(count($_FILES) > $member['activity_img_count']){
//                return showData(new \stdClass(), '超出了当前会员等级发布活动图片的数量', 1);
//            }
        }else{
            if($userCount > $member['source_count']){
                return showData(new \stdClass(), '超出了当前会员等级发布闲置资源的数量', 1);
            }
//            if(count($_FILES) > $member['source_img_count']){
//                return showData(new \stdClass(), '超出了当前会员等级发布闲置资源图片的数量', 1);
//            }
            if(intval($data['fees_type']) > 1){
                if(floatval($data['fees_price']) <= 0){
                    return showData(new \stdClass(), '费用必须大于0', 1);
                }
            }
        }
        $key = array('title','address','start_time','end_time','type','remark');
        $lng = array('标题','地点','开始时间','结束时间','类型','说明');
        foreach ($key as $k => $v){
            if(empty($data[$v])){
                return showData(new \stdClass(),$lng[$k].'不可以为空',1);
            }
        }
        if(iconv_strlen($data['title'],"UTF-8")>20){return showData(new \stdClass(), '标题限制20字', 1);}
        if(iconv_strlen($data['address'],"UTF-8")>20){return showData(new \stdClass(), '地点限制20字', 1);}
        if(iconv_strlen($data['remark'],"UTF-8")>200){return showData(new \stdClass(), '文字说明限制200字', 1);}
        $imgList = array();
        if (!empty($_FILES)){
            $images = upload();
            if (is_array($images)){
                foreach ($images as $k=>$v){
                    $imgList[$k]['smallUrl'] = $v['smallUrl'];
                    $imgList[$k]['originUrl'] = $v['originUrl'];
                }
            }else {
                return showData(new \stdClass(), $images, 1);
            }
        }else {
            return showData(new \stdClass(), '请上传图片', 1);
        }
        $data['pic'] = json_encode($imgList);
        $data['create_time'] = NOW_TIME;
        $id = M('activity_source')->add($data);
        if($id){
            $user = M('user')->where('uid = '.$data['uid'])->find();
            if($data['type'] == 1){
                M('activity_sign')->add(array(
                    'uid' => $data['uid'],
                    'activity_id' => $id,
                    'name' => $user['name'],
                    'phone' => $user['phone'],
                    'create_time' => NOW_TIME
                ));
            }
            return showData($this->public_list($data['uid'],array('a.id'=>$id),1,'a.id asc',$data['type']));
        }
        return showData(new \stdClass(),'创建失败',1);
    }

    /**
     * 活动/资源详情
     * @param mixed|string $data
     * @return array|mixed
     */
    function detail($data){
        $result = $this->public_list($data['uid'],array('a.id'=>$data['activity_id'],'a.type'=>$data['type']),1,'a.id asc',$data['type']);
        return showData($result);
    }

    /**
     * 报名
     * @param mixed|string $data
     * @return array|mixed
     */
    function sign($data){
        $sign = M('activity_sign')->where(array('uid'=>$data['uid'],'activity_id'=>$data['activity_id']))->find();
        if(!empty($sign)){
            return showData(new \stdClass(),'该用户已报名过此活动',1);
        }
        if(empty($data['name'])){
            return showData(new \stdClass(),'姓名不可以为空',1);
        }
        if(empty($data['phone'])){
            return showData(new \stdClass(),'手机不可以为空',1);
        }
        $data['order_no'] = date('Ymd').substr(implode(NULL, array_map('ord', str_split(substr(uniqid(), 7, 13), 1))), 0, 8);
        $data['create_time'] = NOW_TIME;
        $data['status'] = 0;
        $price = $this->where(array('id'=>$data['activity_id']))->getField('fees_price');
        if(floatval($price) == 0){
            $data['status'] = 1;
        }
        $id = M('activity_sign')->add($data);
        if($id){
            return showData(new \stdClass(),'报名成功');
        }
        return showData(new \stdClass(),'报名失败',1);
    }

    /**
     * 活动/资源列表
     * @param mixed|string $data
     * @return array|mixed
     */
    function dataList($data){
        $where = array('a.type' => $data['data_type']);
        if($data['type'] == 1){
            $where['a.uid'] = $data['uid'];
        }
        if($data['type'] == 2){
            $where['_string'] = 'a.id in (select activity_id from '.$this->tablePrefix.'activity_sign where uid='.$data['uid'].')';
        }
        $total = $this->alias("a")->where($where)->count();
        if ($total){
            $page  = page($total);
            $limit = $page['offset'] . ',' . $page['limit'];
        }else {
            $page  = '';
        }
        if($data['data_type'] == 1 && $data['type'] == 2){
            $where['c.status'] = 1;
        }
        $result = self::public_list($data['uid'],$where,$limit,'a.create_time desc',$data['data_type']);
        return showData($result,'',0,$page);
    }

    /**
     * 活动/资源评论
     * @param mixed|string $data
     * @return array|mixed
     */
    function dataComment($data){
        $count = $this->where(array('id'=>$data['activity_id'],'type'=>$data['data_type']))->count();
        if($count <= 0){
            if($data['data_type'] == 1){
                return showData(new \stdClass(),'活动不存在',1);
            }else{
                return showData(new \stdClass(),'闲置资源不存在',1);
            }
        }
        if(empty($data['content'])){
            return showData(new \stdClass(),'评论内容不可为空',1);
        }
//        if(iconv_strlen($data['content'],"UTF-8") > 60){
//            return showData(new \stdClass(),'评论内容太长了',1);
//        }
        $id = M('activity_source_comment')->add(array(
            'uid' => $data['uid'],
            'activity_id' => $data['activity_id'],
            'content' => $data['content'],
            'create_time' => NOW_TIME
        ));
        if($id){
            return showData(self::public_comment_list(array('a.id'=>$id),1));
        }
        return showData(new \stdClass(),'评论失败',1);
    }

    /**
     * 活动/资源评论列表
     * @param mixed|string $data
     * @return array|mixed
     */
    function dataCommentList($data){
        $where = array();
        if($data['activity_id']){
            $where['a.activity_id'] = $data['activity_id'];
        }
        $total = M('activity_source_comment')->alias("a")->where($where)->count();
        if ($total){
            $page  = page($total);
            $limit = $page['offset'] . ',' . $page['limit'];
        }else {
            $page  = '';
        }
        $result = self::public_comment_list($where,$limit);
        return showData($result,'',0,$page);
    }

    /**
     * 支付
     * @param mixed|string $data
     * @return array|mixed
     */
    function pay($data){
        $is_balance = $data['is_balance'];
        unset($data['is_balance']);
        $sign = M('activity_sign')->where(array('uid'=>$data['uid'],'activity_id'=>$data['activity_id'],'status'=>1))->find();
        if(!empty($sign)){
            return showData(new \stdClass(),'该用户已报名过此活动',1);
        }
        $sign = M('activity_sign')->where(array('uid'=>$data['uid'],'activity_id'=>$data['activity_id'],'status'=>0))->find();
        if(empty($sign)){
            $user = M('user')->where(array('uid'=>$data['uid']))->field("name,phone")->find();
            $data['name'] = $user['name'];
            $data['phone'] = $user['phone'];
            $data['balance'] = 0;
            $data['order_no'] = date('Ymd').substr(implode(NULL, array_map('ord', str_split(substr(uniqid(), 7, 13), 1))), 0, 8);
            $order_no = $data['order_no'];
            $data['create_time'] = NOW_TIME;
            $data['status'] = 0;
            $price = $this->where(array('id'=>$data['activity_id']))->getField('fees_price');
            if(floatval($price) == 0){
                $data['status'] = 1;
            }
            $data['pay_price'] = $price;
            $id = M('activity_sign')->add($data);
            if(floatval($data['pay_price']) == 0 && $id){
                return showData(new \stdClass(),'报名成功',2);
            }
        }else{
            $id = $sign['id'];
            $order_no = $sign['order_no'];
            $data['status'] = 0;
            $price = $this->where(array('id'=>$data['activity_id']))->getField('fees_price');
            if(floatval($price) == 0){
                $data['status'] = 1;
            }
            $data['pay_price'] = $price;
            M('activity_sign')->where(array('id'=>$id))->save(array('pay_price'=>$data['pay_price'],'status'=>$data['status']));
            if(floatval($data['pay_price']) == 0){
                return showData(new \stdClass(),'报名成功',2);
            }
        }
        if($id){
            $data['balance'] = floatval($data['pay_price']);
            if($is_balance){
                $balance = M('user')->where(array('uid'=>$data['uid']))->getField("balance");
                if(floatval($balance) >= floatval($data['pay_price'])){
                    $data['pay_price'] = 0;
                    M('user')->where(array('uid'=>$data['uid']))->setDec('balance',$data['balance']);
                    account_log($data['uid'],$data['balance'],"发现活动报名扣除余额，订单No：".$order_no,1);
                }else{
                    $data['pay_price'] = floatval($data['pay_price']) - floatval($balance);
                    $data['balance'] = $data['balance'] - $data['pay_price'];
                }
            }
            if(floatval($data['pay_price']) == 0){
                $data['status'] = 1;
            }
            M('activity_sign')->where(array("uid"=>$data['uid'],'activity_id'=>$data['activity_id']))->save(array('pay_price'=>$data['pay_price'],'balance'=>$data['balance'],'status'=>$data['status']));
            if(floatval($data['pay_price']) == 0){
                return showData(new \stdClass(),'报名成功',2);
            }
            $pay = new \Common\Pay\Pay();
            $subject = '乐津';
            $body    = '活动付费';
            //支付宝 SDK
            $url = SITE_PROTOCOL.SITE_URL.'/index.php/Find/api/notifyurl';
            return $pay->alipay(C('FIND_PAY_PRE').$order_no, $data['pay_price'], $subject. $body, $url);
        }
        return showData(new \stdClass(),'报名失败',1);

    }

    /**
     * 删除活动或资源
     * @param array|mixed $data
     */
    function deleteRow($data){
        $this->where(array('id'=>$data['id']))->delete();
        return showData(new \stdClass(),'删除成功');
    }

}