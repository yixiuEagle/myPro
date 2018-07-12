<?php
/**
 * 商城模块
 * @author yangdong
 *
 */
namespace Shop\Model;
use Think\Model;
use Lincense\Controller\Thinkchat;
use Common\Model\CommonModel;
class ShopModel extends CommonModel {
	public $tableName 	= 'supplier';
	public $pk        	= 'id';

	public $join     = '';
	public $string   = '';
	public $field    = '';

	function _initialize(){
		parent::_initialize();
	}

    /**
     * 查询用户一共有多少商品
     * @param $uid
     */
    function userGoodsCount($uid){
        $where = array();
        $where['_string'] = "sid in (select id from ".$this->tablePrefix."supplier where uid=".$uid.")";
        return M('goods')->where($where)->count();
    }

    function computeScore($score,$last_time,$sid){
        // TODO 计算商家分数，规则见原型图
        //判断上次更新分数的时间是否和当前时间一天
        $now_time = NOW_TIME;
        $hours = C('UPDATE_SUPPLIER_SCORE_TIME');
        $last_date = date('Y-m-d',$last_time);
        $now_date = date('Y-m-d',$now_time);
        if($last_date != $now_date){
            //不在一天是否在4点之后
            $hours = strtotime($now_date." ".$hours);
            if($now_time >= $hours){
                //如果在四点之后计算分数
                $old_date = date('Y-m-d',strtotime('-1 day'));
                $now_date = date('Y-m-d',$now_time);
                $old_time = strtotime($old_date.' 03:00:00');
                $now_time = strtotime($now_date.' 03:00:00');
                $newScore = M('goods_comment')->field('SUM(score)/count(score) as score')->where(array('_string'=>'goods_id IN(SELECT id FROM '.$this->tablePrefix.'goods where sid='.$sid.') and create_time < '.$now_time))->find();
                $newScore = round(floatval($newScore['score']),1);
                $this->where(array('id'=>$sid))->save(array('score'=>$newScore,'last_time'=>NOW_TIME));
                return $newScore;
            }
        }
        return $score;
    }

	function _format($list){
	    if(is_array($list)){
	        $result = array();
            foreach ($list as $item){
                $score = $this->computeScore($item['score'],$item['last_time'],$item['id']);
                $result[] = array(
                    'sid' => $item['id'],
                    'suid' => $item['uid'],
                    'smallUrl' => site_url($item['smallUrl']),
                    'name' => $item['shop_name'],
                    'lng' => $item['lng'],
                    'lat' => $item['lat'],
                    'address' => $item['address'],
                    'cat_id' => $item['cat_id'],
                    'cat_name' => $item['cat_name'],
                    'score' => $score,
                    'is_collect' => $item['is_collect']
                );
            }
            return $result;
        }else{
            return array();
        }
    }

	function _goods_format($list){
	    if(is_array($list)){
	        $result = array();
            foreach ($list as $item){
                $now_time = date('Ymd',NOW_TIME);
                $update_time = date('Ymd',$item['update_time']);
                if($now_time != $update_time){
                    $nowH = date('H',NOW_TIME);
                    if($nowH >= 4){
                        if(floatval($item['update_price']) > 0){
                            $item['original_price'] = $item['update_price'];
                            M('goods')->where('id='.$item['id'])->save(array('original_price'=>$item['update_price'],'update_price'=>0));
                        }
                    }
                }
                $result[] = array(
                    'id' => $item['id'],
                    'sid' => $item['sid'],
                    'suid' => $item['uid'],
                    'group_id' => $item['group_id'],
                    'shop_name' => $item['shop_name'],
                    'profile' => $item['profile'],
                    'smallUrl' => site_url($item['smallUrl']),
                    'originUrl' => site_url($item['originUrl']),
                    'name' => $item['name'],
                    'sale_price' => $item['sale_price'],
                    'original_price' => $item['original_price'],
                    'cheap_price' => $item['cheap_price'],
                    'type' => $item['type'],
                    'transport_method' => $item['transport_method'],
                    'transport_price' => $item['transport_price'],
                    'is_cheap' => $item['is_cheap'],
                    'deducted_price' => $item['deducted_price'],
                    'start_time' => $item['start_time'],
                    'end_time' => $item['end_time'],
                    'is_join_cart' => $item['is_join_cart'],
                    'is_join' => $item['is_join'],
                    'comment_count' => $item['comment_count'],
                    'create_time'  =>$item['create_time']
                );
            }
            return $result;
        }else{
            return array();
        }
    }

	function _order_format($list,$is_supplier){
	    if(is_array($list)){
	        $result = array();
            foreach ($list as $item){
                // TODO 买家评价后7天自动改为卖家已评价状态
                $order_goods = M('order_goods')->alias("a")->field('a.goods_id as id,a.goods_name,a.buy_count,a.price,b.type')->join("left join ".$this->tablePrefix."goods b on a.goods_id=b.id")->where(array('order_id'=>$item['id']))->select();
                if(!empty($order_goods)){
                    $arr = array(
                        'id' => $item['id'],
                        'sid' => $item['sid'],
                        'uid' => $item['uid'],
                        'create_time' => $item['create_time'],
                        'status' => $item['status'],
                        'order_no' => $item['order_no'],
                        'is_hdfk' => $item['is_hdfk'],
                        'is_back' => intval($item['is_back'])>0?1:0,
                        'pro_status' => $item['pro_status'],
                        'transport_method' => $item['transport_method'],
                        'transport_price' => $item['transport_price'],
                        'goods_list' => $order_goods
                    );
                    // TODO 买家评价
                    if($is_supplier){
                        $arr['address'] = $item['shipping_address'];
                        $arr['receiver'] = $item['shipping_name'];
                        $arr['phone'] = $item['shipping_phone'];
//                        $arr['back_info'] = new \stdClass();
                        if(in_array($item['status'],array(6,7))){
                            foreach($arr['goods_list'] as $k => &$goods){
                                $back_info = M('order_back')->where(array('order_id'=>$arr['id'],'goods_id'=>$goods['id']))->find();
                                $tmp = array();
                                if($back_info){
                                    $tmp['status'] = $back_info['status'];
                                    $tmp['reason'] = $back_info['reason'];
                                    $tmp['type'] = $back_info['type'];
                                    $tmp['intro'] = $back_info['intro'];
                                    $goods['back_info'] = empty($tmp)?new \stdClass():$tmp;
                                }else{
                                    if(I('type') == 3){
                                        array_splice($arr['goods_list'],$k,1);
//                                        unset($arr['goods_list'][$k]);
                                    }
                                }
                            }
                        }
                    }
                    foreach($arr['goods_list'] as &$goods){
                        $comment = M('goods_comment')->where(array('order_id'=>$arr['id'],'goods_id'=>$goods['id']))->field("content,intro,score")->find();
                        $goods['comment_info'] = empty($comment)?new \stdClass():$comment;
                    }
                    $result[] = $arr;
                }
            }
            return $result;
        }else{
            return array();
        }
    }

    /**
     * 商家列表
     * @param unknown $map
     * @param unknown $limit
     * @param string $order
     * @return unknown商家id、头像、昵称、地址、类别id、类别名称、星级
     */
    function public_list($uid,$map, $limit, $order='s.id asc'){
        $join = '';
        //自定义字段
        if ($this->field) {
            $field = $this->field;
        }else {
            $field = 's.*';
        }
        //自定义联合查询
        if ($this->join) $join = $this->join;
        //自定义条件
        if ($this->string) $map['_string'] = $this->string;
        //获取头像
        $field .= ',(select `smallUrl` from `'.$this->tablePrefix.'user` a left join `'.$this->tablePrefix.'user_head` b on a.head=b.id where a.uid=s.uid) as smallUrl';
        $field .= ',(select `alias` from `'.$this->tablePrefix.'share_category` where id=s.cat_id) as cat_name';
        $field .= ',(select count(*) from `'.$this->tablePrefix.'collect_supplier` where uid='.$uid.' and sid=s.id) as is_collect';

        $list  = $this->alias('s')->field($field)->join($join)->where($map)->order($order)->limit($limit)->select();
        $_list = self::_format($list);
        if ($list && $limit == 1) {
            return $_list['0'];
        }else {
            return $_list;
        }
    }

    /**
     * 商品列表
     * @param unknown $map
     * @param unknown $limit
     * @param string $order
     * @return unknown
     */
    function public_goods_list($uid=0,$map, $limit, $order='g.create_time asc'){
        $join = '';
        //自定义字段
        if ($this->field) {
            $field = $this->field;
        }else {
            $field = 'g.*';
        }
        //自定义联合查询
        if ($this->join) $join = $this->join;
        //自定义条件
        if ($this->string) $map['_string'] = $this->string;

        $field .= ',(select count(*) from '.$this->tablePrefix.'goods_comment where goods_id=g.id) as comment_count';
        $field .= ',(select uid from '.$this->tablePrefix.'supplier where id=g.sid) as uid';
        $field .= ',(select shop_name from '.$this->tablePrefix.'supplier where id=g.sid) as shop_name';
        $field .= ',(select count(*) from '.$this->tablePrefix.'cart where goods_id=g.id and uid='.$uid.') as is_join_cart';
        $field .= ',(select b.group_id from '.$this->tablePrefix.'supplier a left join '.$this->tablePrefix.'groups b on a.groups_id=b.id where a.id=g.sid) as group_id';
        $field .= ',(select count(*) from '.$this->tablePrefix.'group_user where groupid in (select b.group_id from '.$this->tablePrefix.'supplier a left join '.$this->tablePrefix.'groups b on a.groups_id=b.id where a.id=g.sid) and uid='.$uid.') as is_join';

        $list  = M('goods')->alias('g')->field($field)->join($join)->where($map)->order($order)->limit($limit)->select();
        $_list = self::_goods_format($list);
        if ($list && $limit == 1) {
            return $_list['0'];
        }else {
            return $_list;
        }
    }

    /**
     * 订单列表
     * @param unknown $map
     * @param unknown $limit
     * @param string $order
     * @return unknown
     */
    function public_order_list($map, $limit, $order='o.id asc',$is_supplier=0){
        $join = '';
        //自定义字段
        if ($this->field) {
            $field = $this->field;
        }else {
            $field = 'o.*';
        }
        //自定义联合查询
        if ($this->join) $join = $this->join;
        //自定义条件
        if ($this->string) $map['_string'] = $this->string;

        $field .= ",(select count(*) from ".$this->tablePrefix."order_back where order_id=o.id order by create_time desc limit 1) is_back";
        $field .= ",(select if(count(*)>0,status,'') from ".$this->tablePrefix."order_back where order_id=o.id order by create_time desc limit 1) pro_status";
        $join .= ' left join '.$this->tablePrefix.'order_goods og on o.id=og.order_id left join '.$this->tablePrefix.'goods g on og.goods_id=g.id';
        $list  = M('order')->alias('o')->field($field)->join($join)->where($map)->order($order)->group('order_no')->limit($limit)->select();
        $_list = self::_order_format($list,$is_supplier);
        if ($list && $limit == 1) {
            return $_list['0'];
        }else {
            return $_list;
        }
    }

    /**
     * 申请开店
     */
    function regSupplier($data){
        $supplier_id = M('supplier')->where(array('groups_id'=>$data['groups_id']))->getField("id");
        //查询空间号地址和名称、类别
        $groupsInfo = M('groups')->field("name,address,cateid,lng,lat")->where(array('id'=>$data['groups_id']))->select();
        //上传图片列表
        $imgList = array();
        if (!empty($_FILES)){
            $images = upload();
            if (is_array($images)){
                foreach ($images as $k=>$v){
                    $imgList[$k]['smallUrl'] = $v['smallUrl'];
                    $imgList[$k]['originUrl'] = $v['originUrl'];
                    $imgList[$k]['create_time'] = NOW_TIME;
                }
            }else {
                return showData(new \stdClass(), $images, 1);
            }
        }else {
            return showData(new \stdClass(), '请上传图片', 1);
        }
        //创建商家
        $data['shop_name'] = $groupsInfo[0]['name'];
        $data['lng'] = $groupsInfo[0]['lng'];
        $data['lat'] = $groupsInfo[0]['lat'];
        $data['address'] = $groupsInfo[0]['address'];
        $data['cat_id'] = $groupsInfo[0]['cateid'];
        $data['create_time'] = NOW_TIME;
        $sid = M('supplier')->add($data);
        if($sid){
            if($supplier_id){
                M('supplier')->where(array('id'=>$supplier_id))->delete();
            }
            foreach($imgList as &$img){
                $img['sid'] = $sid;
            }
            if (M('supplier_gallery')->addAll($imgList)){
                return showData(new \stdClass(), '申请成功');
            }else{
                return showData(new \stdClass(), '图片上传失败', 1);
            }
        }else{
            return showData(new \stdClass(), '申请失败', 1);
        }
    }

    /**
     * 收藏商家
     * @param $uid
     * @param $sid
     * @param $type 0.取消，1.收藏
     */
    function collectSupplier($uid, $sid, $type){
        $data   = array('uid'=>$uid, 'sid'=>$sid);
        if($type){
            $count = M('collect_supplier')->where($data)->count();
            if($count > 0){
                return showData(new \stdClass(),'已收藏过该商家',1);
            }
            $data['create_time'] = NOW_TIME;
            $row = M('collect_supplier')->add($data);
            if($row){
                return showData(new \stdClass(),'收藏成功');
            }
            return showData(new \stdClass(),'收藏失败',1);
        }else{
            $count = M('collect_supplier')->where($data)->count();
            if($count <= 0){
                return showData(new \stdClass(),'没有收藏过该商家',1);
            }
            if (M('collect_supplier')->where($data)->delete()){
                return showData(new \stdClass(), '取消收藏成功');
            }
            return showData(new \stdClass(), '取消收藏失败', 1);
        }
    }

    /**
     * 商家列表
     * @param $data
     */
    function supplierList($data){
        $order = "";
        $where = array();
        //查询类型，单个商家，格式化返回参数
      
        $this->field = 's.*,(POWER(MOD(ABS(s.lng - '.$data['lng'].'),360),2) + POWER(ABS(s.lat - '.$data['lat'].'),2)) AS distance';
        $order = 'distance asc';
        /* if($data['type'] == 2){
            $this->field = "s.*,((select sum(buy_count)*0.3 from ".$this->tablePrefix."order_goods where goods_id in (select id from ".$this->tablePrefix."goods where sid=s.id) and create_time > ".(time()-(1000*60*60*24*30)).") + (select count(*)*0.4 from ".$this->tablePrefix."goods_click where goods_id in (select goods_id from ".$this->tablePrefix."goods where sid=s.id) and create_time > ".(time()-(1000*60*60*24*30)).") + s.score*100*0.3) renqi";
            $order = 'renqi desc';
        }
        if($data['type'] == 3){
            $order = 's.create_time desc,s.hot desc';
        } */
        if($data['type'] == 1){
            $where['_string'] = "s.id in (select sid from ".$this->tablePrefix."collect_supplier where uid=".$data['uid'].")";
        }
        $where['s.uid'] = array("neq",$data['uid']);
        if(intval($data['catId']) > 0){
            $where['s.cat_id'] = $data['catId'];
        }
        $where['s.status'] = 1;
        $total = $this->alias("s")->where($where)->count();
        if ($total){
            $page  = page($total);
            $limit = $page['offset'] . ',' . $page['limit'];
        }else {
            $page  = '';
        }
        if(!empty($data['sid'])){
            $where['s.id'] = $data['sid'];
            $limit = 1;
        }
        $data = self::public_list($data['uid'],$where, $limit, $order);
        return showData($data,'',0,$page);
    }

    /**
     * 添加商品/优惠券
     * @param $data
     */
    function addGoods($data){
        //检查当前会员等级，发布的商品数量是否超出限制
        $user_member = $this->getUserMember($data['uid']);
        $goods_count = $this->userGoodsCount($data['uid']);
        if($goods_count > $user_member['goods_count']){
            return showData(new \stdClass(), '超出了当前会员等级添加商品的数量', 1);
        }
        //检查商品图片数量是否超出限制
//        if(count($_FILES) > $user_member['goods_img_count']){
//            return showData(new \stdClass(), '超出了当前会员等级发布商品图片的数量', 1);
//        }
        unset($data['uid']);
        $key = array();
        $lng = array();
        if($data['type'] == 1){
            $key = array('name','profile','original_price','cheap_price');
            $lng = array('品名','商品简介','原价','特价');
        }else{
            $key = array('name','profile','original_price','cheap_price','deducted_price','start_time','end_time');
            $lng = array('品名','商品简介','原价','特价','抵扣费用','开始时间','结束时间');
        }
        foreach ($key as $k => $v){
            if($v == 'cheap_price'){
                if($data['is_cheap']){
                    if(empty($data[$v])){
                        return showData(new \stdClass(),$lng[$k].'不可以为空',1);
                    }
                }
            }else{
                if(empty($data[$v])){
                    return showData(new \stdClass(),$lng[$k].'不可以为空',1);
                }
            }
        }
        if (!empty($_FILES)){
            $images = upload();
            if (is_array($images)){
                foreach ($images as $k=>$v){
                    $imgList[$k]['smallUrl'] = $v['smallUrl'];
                    $imgList[$k]['originUrl'] = $v['originUrl'];
                    $imgList[$k]['create_time'] = NOW_TIME;
                }
                $data['smallUrl'] = $imgList[0]['smallUrl'];
                $data['originUrl'] = $imgList[0]['originUrl'];
            }else {
                return showData(new \stdClass(), $images, 1);
            }
        }else {
            return showData(new \stdClass(), '请上传图片', 1);
        }
        $goods_id = M('goods')->add($data);
        if($goods_id){
            foreach ($imgList as &$v){
                $v['goods_id'] = $goods_id;
            }
            if (M('goods_gallery')->addAll($imgList)){
                return showData(new \stdClass(), '添加成功');
            }else{
                return showData(new \stdClass(), '图片上传失败', 1);
            }
        }else{
            return showData(new \stdClass(), '添加失败', 1);
        }
    }

    /**
     * 删除商品
     * @param $data
     */
    function deleteGoods($data){
        $goods_gallery = M('goods_gallery')->where(array('goods_id'=>$data['id']))->select();
        M('goods_gallery')->where(array('goods_id'=>$data['id']))->delete();
        foreach ($goods_gallery as $pic){
            unlink('./'.$pic['smallUrl']);
            unlink('./'.$pic['originUrl']);
        }
        $res = M('goods')->where($data)->delete();
        if($res){
            return showData(new \stdClass(), '删除成功');
        }else{
            return showData(new \stdClass(), '删除失败', 1);
        }
    }

    /**
     * 编辑商品
     * @param $data
     */
    function editGoods($goods_id,$data,$uid,$original_images){
//        \Think\Log::write("request data = ".json_encode($_REQUEST),'ERR','',C('LOG_PATH').date('y_m_d').'-----.log');
//        \Think\Log::write("files data = ".json_encode($_FILES),'ERR','',C('LOG_PATH').date('y_m_d').'-----.log');
        $original_images = explode(',',$original_images);
        $user_member = $this->getUserMember($uid);
        //检查商品图片数量是否超出限制
//        if((count($_FILES)+count($original_images)) > $user_member['goods_img_count']){
//            return showData(new \stdClass(), '超出了当前会员等级发布商品图片的数量', 1);
//        }
        $key = array();
        $lng = array();
        if($data['type'] == 1){
            $key = array('name','profile','update_price','cheap_price');
            $lng = array('品名','商品简介','原价','特价');
        }else{
            $key = array('name','profile','update_price','cheap_price','deducted_price','start_time','end_time');
            $lng = array('品名','商品简介','原价','特价','抵扣费用','开始时间','结束时间');
        }
        foreach ($key as $k => $v){
            if($v == 'cheap_price'){
                if($data['is_cheap']){
                    if(empty($data[$v])){
                        return showData(new \stdClass(),$lng[$k].'不可以为空',1);
                    }
                }
            }else{
                if(empty($data[$v])){
                    return showData(new \stdClass(),$lng[$k].'不可以为空',1);
                }
            }
        }
        $imgList = array();
        foreach($original_images as $key => &$img){
            if(!empty($img)){
                $img = str_replace(SITE_PROTOCOL.SITE_URL,'',$img);
                $imgList[$key]['goods_id'] = $goods_id;
                $imgList[$key]['smallUrl'] = $img;
                $imgList[$key]['originUrl'] = $img;
                $imgList[$key]['create_time'] = NOW_TIME;
            }else{
                unset($original_images[$key]);
            }
        }
        if (!empty($_FILES)){
            $images = upload();
            if (is_array($images)){
                foreach ($images as $k=>$v){
                    $imgList[count($original_images)+$k]['goods_id'] = $goods_id;
                    $imgList[count($original_images)+$k]['smallUrl'] = $v['smallUrl'];
                    $imgList[count($original_images)+$k]['originUrl'] = $v['originUrl'];
                    $imgList[count($original_images)+$k]['create_time'] = NOW_TIME;
                }
                $data['smallUrl'] = $imgList[0]['smallUrl'];
                $data['originUrl'] = $imgList[0]['originUrl'];
            }else {
                return showData(new \stdClass(), $images, 1);
            }
        }
        $res = M('goods')->where(array('id'=>$goods_id))->save($data);
        if($res >= 0){
            if(!empty($imgList)){
                $goods_gallery = M('goods_gallery')->where(array('goods_id'=>$goods_id))->select();
                M('goods_gallery')->where(array('goods_id'=>$goods_id))->delete();
                foreach ($goods_gallery as $pic){
                    $is_delete = true;
                    foreach($original_images as $key => $img){
                        if($img == $pic['smallUrl'] || $img == $pic['originUrl']){
                            $imgList[$key]['smallUrl'] = $pic['smallUrl'];
                            $imgList[$key]['originUrl'] = $pic['originUrl'];
                            $is_delete = false;
                            break;
                        }
                    }
                    if($is_delete){
                        unlink('./'.$pic['smallUrl']);
                        unlink('./'.$pic['originUrl']);
                    }
                }
                if (M('goods_gallery')->addAll($imgList)){
                    return showData(new \stdClass(), '编辑成功');
                }else{
                    return showData(new \stdClass(), '图片上传失败', 1);
                }
            }else{
                return showData(new \stdClass(), '编辑成功');
            }
        }else{
            return showData(new \stdClass(), '编辑失败', 1);
        }
    }

    /**
     * 商品列表
     * @param $data
     */
    function goodsList($data){
        $supplier = self::public_list($data['uid'],array('s.id'=>$data['sid']),1);
        $where = array('sid'=>$data['sid']);
        $total = M('goods')->where($where)->count();
        if ($total){
            $page  = page($total);
            $limit = $page['offset'] . ',' . $page['limit'];
        }else {
            $page  = '';
        }
        $supplier['goods_list'] = self::public_goods_list($data['uid'],$where,$limit);
        return showData($supplier,'',0,$page);
    }

    /**
     * 商品图片列表
     * @param $data
     */
    function goodsGallery($goods_id){
        $gallery = M('goods_gallery')->where(array("goods_id"=>$goods_id))->select();
        $result = array();
        foreach($gallery as $v){
            $result[] = array(
                'smallUrl' => site_url($v['smallUrl']),
                'originUrl' => site_url($v['originUrl'])
            );
        }
        return $result;
    }

    /**
     * 商品详情
     * @param $data
     */
    function goodsDetail($data){
        $goods = self::public_goods_list($data['uid'],array('id'=>$data['goods_id']),1);
        $goods['goods_gallery'] = $this->goodsGallery($goods['id']);
        $goods_comment = M('goods_comment')->alias("a")->field("a.*,b.name,c.originUrl,c.smallUrl")->join("left join ".$this->tablePrefix."user b on a.uid=b.uid left join ".$this->tablePrefix."user_head c on b.head=c.id")->where(array('a.goods_id'=>$data['goods_id']))->order('a.create_time desc')->limit(1)->find();
        $goods_comment['originUrl'] = site_url($goods_comment['originUrl']);
        $goods_comment['smallUrl'] = site_url($goods_comment['smallUrl']);
        $goods['goods_comment'] = $goods_comment?$goods_comment:new \stdClass();
        $score = M('goods_comment')->where(array('goods_id'=>$data['goods_id']))->field("round(sum(score)/count(score),1) score")->find();
        $goods['score'] = $score['score'];
        $cart = $this->cartGoodsList($data['uid'],$goods['sid'],$data['goods_id']);
        $goods['cart'] = empty($cart[0])?new \stdClass():$cart[0];
        M('goods')->where(array('id'=>$data['goods_id']))->setInc("click_count",1);
        M('goods_click')->add(array('goods_id'=>$data['goods_id'],'create_time'=>NOW_TIME));
        return showData($goods);
    }

    /**
     * 购物车商品列表
     */
    function cartGoodsList($uid,$sid=0,$goods_id=0){
        $where = array('a.uid'=>$uid);
        if($sid){
            $where['a.sid'] = $sid;
        }
        if($goods_id){
            $where['a.goods_id'] = $goods_id;
        }
        $where['b.name'] = array('exp','is not null');
        $cart_list = M('cart')->alias("a")->join("left join ".$this->tablePrefix."goods b on a.goods_id=b.id")->where($where)->field("a.goods_id,a.pay_count,b.smallUrl,b.originUrl,b.name,b.original_price,b.cheap_price,b.is_cheap,b.transport_method,b.transport_price,b.type")->select();
        $result = array();
        foreach($cart_list as $v){
            if($v['is_cheap'] == 1){
                $v['pay_price'] = round(floatval($v['cheap_price'])*intval($v['pay_count']),2);
            }else{
                $v['pay_price'] = round(floatval($v['original_price'])*intval($v['pay_count']),2);
            }
            $v['smallUrl'] = site_url($v['smallUrl']);
            $v['originUrl'] = site_url($v['originUrl']);
            $result[] = $v;
        }
        return $result;
    }

    /**
     * 增加或减少购买商品
     * @param $data
     */
    function updatePayGoods($data){
        $where = array(
            'uid' => $data['uid'],
            'sid' => $data['sid'],
            'goods_id' => $data['goods_id']
        );
        //判断最新数量是否小于1，小于1直接删除
        if(intval($data['pay_count']) < 1){
            M('cart')->where($where)->delete();
        }else{
            //判断购物车中是否已经存在该商品
            $goods = M('cart')->where($where)->find();
            if($goods){
                M('cart')->where($where)->save(array('pay_count'=>$data['pay_count']));
            }else{
                $data['create_time'] = NOW_TIME;
                M('cart')->add($data);
            }
        }
        return showData($this->cartGoodsList($data['uid'],$data['sid']));
    }

    /**
     * 计算购物车商品价格
     * @param $cartData 购物车商品列表
     * @param $data 提交订单参数
     */
    function cartGoodsPrice($cartData,$data,$flag = false){
        $result = array();
        $order['total_price'] = 0;//实际支付扣除的金额（到付商品不加到实际支付金额）
        $cash_on_delivery = 0;//同城到付商品总价格
        $result['cart'] = $cartData;
        $result['transport_method'] = 1;
        $result['transport_price'] = 0;
        $result['sum_price'] = 0;
        $type = $result['cart'][0]['type'];
        foreach($result['cart'] as $v){
            if(intval($v['pay_count']) > 0){
                if($flag){
                    if($data['is_hdfk'] == 1){//货到付款只能为同城到付商品
                        if($v['transport_method'] == 2){
                            return -1;
                        }
                    }
                    if($type != $v['type']){
                        return -2;
                    }
                }
                //统计最高的运费为订单的运费
                if($v['transport_price'] > $result['transport_price']){
                    $result['transport_method'] = $v['transport_method'];
                    $result['transport_price'] = $v['transport_price'];
                }
                //同城到付，统计扣除商品价格
//                if($v['transport_method'] == 1){
//                    $order['total_price'] += floatval($v['pay_price']);
//                }
                if($v['transport_method'] == 1){
                    $cash_on_delivery += floatval($v['pay_price']);
                }
                //优惠券，取消使用优惠券购买
                if($v['type'] == 2){
                    $data['is_coupon'] = 0;
                }
                $result['sum_price'] += floatval($v['pay_price']);
            }
        }
        $result['sum_price'] += floatval($result['transport_price']);
        $result['pay_price'] = $result['sum_price'];
        $result['pay_price'] -= $order['total_price'];
        $result['cash_on_delivery'] = $result['pay_price']>$cash_on_delivery?$cash_on_delivery:$result['pay_price'];
        $result['balance_price'] = 0;
        $result['coupon_price'] = 0;
        $result['is_balance'] = $data['is_balance'];
        $result['is_coupon'] = $data['is_coupon'];
        if($data['is_coupon']){
            //查询用户可用的优惠券，
            //优惠券使用规则：只有一张优惠券时直接使用，否则挑选到期最早的优惠券
            $user_coupon = M('user_coupon')->alias('a')->join('left join '.$this->tablePrefix.'goods b on a.goods_id=b.id')->where(array('a.uid'=>$data['uid'],'a.sid'=>$data['sid'],'b.start_time'=>array('ELT',NOW_TIME),'b.end_time'=>array('EGT',NOW_TIME),'is_use'=>0))->field('a.id,a.goods_id,b.deducted_price')->order('b.end_time asc, b.deducted_price desc')->select();
            $tmp = true;
            foreach($user_coupon as $v){
//                if(floatval($v['deducted_price']) <= $result['pay_price']){
                if(count($user_coupon) == 1){
                    $tmp = false;
                    $result['coupon_id'] = $v['id'];
                    $result['coupon_gid'] = $v['goods_id'];
                    $result['coupon_price'] = $v['deducted_price'];
                    $result['pay_price'] -= floatval($v['deducted_price']);
                    if($result['pay_price'] < 0){
                        $result['pay_price'] = 0;
                    }
                }else{
                    if(floatval($v['deducted_price']) <= $result['pay_price']){
                        $tmp = false;
                        $result['coupon_id'] = $v['id'];
                        $result['coupon_gid'] = $v['goods_id'];
                        $result['coupon_price'] = $v['deducted_price'];
                        $result['pay_price'] -= floatval($v['deducted_price']);
                        if($result['pay_price'] < 0){
                            $result['pay_price'] = 0;
                        }
                        break;
                    }
                }
//                }
            }
            if(empty($result['coupon_id']) && count($user_coupon)>0){
                $coupon_row = M('user_coupon')->alias('a')->join('left join '.$this->tablePrefix.'goods b on a.goods_id=b.id')->where(array('a.uid'=>$data['uid'],'a.sid'=>$data['sid'],'b.start_time'=>array('ELT',NOW_TIME),'b.end_time'=>array('EGT',NOW_TIME),'is_use'=>0))->field('a.id,a.goods_id,b.deducted_price')->order('b.end_time asc, b.deducted_price asc')->limit(1)->find();
                $tmp = false;
                $result['coupon_id'] = $coupon_row['id'];
                $result['coupon_gid'] = $coupon_row['goods_id'];
                $result['coupon_price'] = $coupon_row['deducted_price'];
                $result['pay_price'] -= floatval($coupon_row['deducted_price']);
                if($result['pay_price'] < 0){
                    $result['pay_price'] = 0;
                }
            }
            if($tmp){
                $result['is_coupon'] = 0;
            }
        }
        if($data['is_balance']){
            //查询用户余额
            $balance = M('user')->where(array('uid'=>$data['uid']))->getField("balance");
            $balance = floatval($balance);
            if($result['pay_price'] < $balance){
                $result['balance_price'] = $result['pay_price'];
//                $res = M('user')->where(array('uid'=>$data['uid']))->setDec('balance',$result['pay_price']);
//                if($res){
                $result['pay_price'] = 0.00;
//                }
            }else{
                $result['balance_price'] = $balance;
//                $res = M('user')->where(array('uid'=>$data['uid']))->save(array('balance'=>0));
//                if($res){
                $result['pay_price'] -= $balance;
//                }
            }
            if($balance <= 0){
                $result['is_balance'] = 0;
            }
        }
        return $result;
    }

    /**
     * 付款订单
     * @param $data
     */
    function payOrder($data){
        $cartGoods = $this->cartGoodsList($data['uid'],$data['sid']);
        $result = $this->cartGoodsPrice($cartGoods,$data);
//        if($result == -1){
//            return showData(new \stdClass(),'您所选择的商品中包含同城到付商品，请单独购买',1);
//        }elseif($result == -2){
//            return showData(new \stdClass(),'您所选择的商品中包含优惠券，请单独购买',1);
//        }
        return showData($result);
    }

    function saveOrderStatus($data){
        M('order_status')->add(array(
            'order_id' => $data['order_id'],
            'type' => $data['status'],
            'remark' => $data['remark'],
            'create_time' => NOW_TIME
        ));
    }

    /**
     * 提交订单
     * @param $data
     */
    function submitOrder($data){
        $cart = $this->cartGoodsList($data['uid'],$data['sid']);
        $result = $this->cartGoodsPrice($cart,$data,true);
        if($result == -1){
            return showData(new \stdClass(),'您所选择的商品中包含同城到付商品，请单独购买',1);
        }elseif($result == -2){
            return showData(new \stdClass(),'您所选择的商品中包含优惠券，请单独购买',1);
        }
        $order = array(
            'uid' => $data['uid'],
            'sid' => $data['sid'],
            'order_no' => date('Ymd').substr(implode(NULL, array_map('ord', str_split(substr(uniqid(), 7, 13), 1))), 0, 8),
            'status' => $result['pay_price']==0?1:0,
            'transport_method' => $result['transport_method'],
            'transport_price' => $result['transport_price'],
            'total_price' => $result['sum_price'],
            'is_hdfk' => $data['is_hdfk'],
            'coupon_id' => $result['coupon_id'],
            'is_coupon' => $result['is_coupon'],
            'coupon_price' => $result['coupon_price'],
            'is_balances' => $result['is_balance'],
            'balances_price' => $result['balance_price'],
            'actual_price' => $result['pay_price'],
            'shipping_address' => $data['address'],
            'shipping_name' => $data['receiver'],
            'shipping_phone' => $data['phone'],
            'create_time' => NOW_TIME
        );
        $order_goods = array();
        $noOrder = 0;
        $coupon = 0;
        foreach ($cart as $v){
            if(intval($v['pay_count']) > 0){
                $order_goods[] = array(
                    'goods_id' => $v['goods_id'],
                    'smallUrl' => $v['smallUrl'],
                    'originUrl' => $v['originUrl'],
                    'goods_name' => $v['name'],
                    'price' => ($v['is_cheap'] == 1?$v['cheap_price']:$v['original_price']),
                    'buy_count' => $v['pay_count'],
                    'is_back' => 0,
                    'create_time' => NOW_TIME
                );
                if($v['type'] == 2){
                    $coupon++;
                    for($i = 0; $i < intval($v['pay_count']); $i++){
                        M('user_coupon')->add(array(
                            'uid' => $data['uid'],
                            'sid' => $data['sid'],
                            'order_no' => $order['order_no'],
                            'goods_id' => $v['goods_id'],
                            'is_use' => 0,
                            'status' => 0,
                            'create_time' => NOW_TIME
                        ));
                    }
                }
            }else{
                $noOrder++;
                $where = array(
                    'uid' => $data['uid'],
                    'sid' => $data['sid'],
                    'goods_id' => $v['goods_id']
                );
                M('cart')->where($where)->delete();
            }
        }
        if($noOrder == count($cart)){
            return showData(new \stdClass());
        }
        if(count($cart) == 1){
            if($cart[0]['type'] == 2 && $order['actual_price'] == 0){
                $order['status'] = 5;
                M('user_coupon')->where(array('uid'=>$data['uid'],'order_no'=>$order['order_no'],'goods_id'=>$cart[0]['goods_id']))->save(array('status'=>1));
            }
        }elseif(count($cart) == ($noOrder+$coupon)){
            $order['status'] = 5;
            M('user_coupon')->where(array('uid'=>$data['uid'],'order_no'=>$order['order_no']))->save(array('status'=>1));
        }
        $order_id = M('order')->add($order);
        if($order_id){
            //如果订单状态为已付款
            if($order['status'] == 1 || $order['status'] == 5){
                $this->saveOrderStatus(array('order_id'=>$order_id,'status'=>1,'remark'=>'付款'));
                if($order['status'] == 5){
                    //添加订单状态记录：收货
                    $this->saveOrderStatus(array('order_id'=>$order_id,'status'=>3,'remark'=>'收货'));
                }
                //添加用户积分
                M('user')->where(array('uid'=>$order['uid']))->setInc('integral',ceil(floatval($order['total_price'])/10));
                if($order['is_coupon']){
                    M('user_coupon')->where(array("id"=>$order['coupon_id']))->save(array('is_use'=>1));
                }
                if($order['is_balances']){
                    M('user')->where(array("uid"=>$order['uid']))->setDec("balance",$order['balances_price']);
                    account_log($order['uid'],$order['balances_price'],"提交订单，使用余额，扣除余额，订单No：".$order['order_no'],1);
                }
            }
            foreach ($order_goods as &$v){
                $v['order_id'] = $order_id;
            }
            $res = M('order_goods')->addAll($order_goods);
            if($res){
//                if($order['is_coupon']){
//                    M('user_coupon')->where(array("id"=>$order['coupon_id']))->save(array('is_use'=>1));
//                }
//                if($order['is_balances']){
//                    M('user')->where(array("uid"=>$order['uid']))->setDec("balance",$order['balances_price']);
//                    account_log($order['uid'],$order['balances_price'],"提交订单，使用余额，扣除余额",1);
//                }
                M('cart')->where(array('uid'=>$data['uid'],'sid'=>$data['sid']))->delete();
                return $this->pay($order['order_no']);
            }
        }
        return showData(new \stdClass(), '订单提交失败', 1);
    }
    function pay($order_no){
        $order = M('order')->where(array('order_no'=>$order_no))->find();
        $pay = new \Common\Pay\Pay();
        $subject = '乐津';
        $body    = '购物';
        //支付宝 SDK
        $url = SITE_PROTOCOL.SITE_URL.'/index.php/Shop/Api/notifyurl';
        return $pay->alipay(C('ORDER_PAY_PRE').$order_no, $order['actual_price'], $subject. $body, $url);
    }

    /**
     * 买单列表
     */
    function orderList($uid){
        $where = array('o.uid'=>$uid);
        $total = M('order')->alias("o")->where($where)->count();
        if ($total){
            $page  = page($total);
            $limit = $page['offset'] . ',' . $page['limit'];
        }else {
            $page  = '';
        }
        $data = self::public_order_list($where, $limit, 'o.create_time desc');
        return showData($data,'',0,$page);
    }

    /**
     * 订单操作
     */
    function orderOperate($data){
        //查询订单信息
        $order = M('order')->where(array('uid'=>$data['uid'],'id'=>$data['order_id']))->find();
        if(empty($order)){
            return showData(new \stdClass(),'订单不存在',1);
        }
        //判断操做类型
        if($data['type'] == 1){//收货
            //只有已发货订单可以收货
            if($order['status'] != 2){
                return showData(new \stdClass(),'只有已发货订单才可以收货',1);
            }
            //$res = M('order')->where(array('id'=>$data['order_id']))->save(array('status'=>3));
            $res=M('order_goods')->where(array('order_id'=>$data['order_id'],'goods_id'=>$data['goods_id']))->save(array('is_finish'=>1));
            if($res){
                $goodsArr=M('order_goods')->where(array('id'=>$data['order_id']))->select();
                foreach ($goodsArr as $k => $v){
                    if($goodsArr[$k]['is_finnish']!==1){
                        return showData(new \stdClass(),'该商品收货成功');
                    }else{
                        $this->saveOrderStatus(array('order_id'=>$data['order_id'],'status'=>3,'remark'=>'收货'));
                        return showData(new \stdClass(),'订单收货成功');
                    }
                }     
            }
        }else{
                $num=M('order_goods')->where(array('order_id'=>$data['order_id']))->select();
                //if($typeArr[$k] == 2){//换货
                if($data['type']==2){
                    if(count($num)>1){     //判断该订单是否有多个商品
                        $goods=M('order_goods')->where(array('order_id'=>$data['order_id'],'goods_id'=>$data['goods_id']))->select();
                        $price=floatval($goods[0]['price'])*floatval($goods[0]['buy_count']);   //拆出来的订单价格
                        $mes=M('order')->where(array('id'=>$data['order_id']))->find();
                        M('order')->add(array('uid'=>$mes['uid'],'sid'=>$mes['sid'],'order_no'=>$mes['order_no'],'status'=>7,'transport_method'=>$mes['transport_method'],'transport_price'=>$mes['transport_price'],'total_price'=>$price,'actual_price'=>$price,'shipping_address'=>$mes['shipping_address'],'shipping_name'=>$mes['shipping_name'],'shipping_phone'=>$mes['shipping_phone'],'remark'=>$data['remark'],'create_time'=>$mes['create_time'],'is_over'=>$mes['is_over']));
                        M('order')->where(array('id'=>$data['order_id']))->save(array('total_price'=>(floatval($mes['total_price'])-$price),'actual_price'=>(floatval($mes['actual_price'])-$price)));
                        $new=M('order')->where(array('order_no'=>$mes['order_no']))->order('id desc')->limit(1)->select();
                        $newid=$new[0]['id'];     //拆出订单id
                        //将换货商品纳入拆出订单内
                        M('order_goods')->where(array('order_id'=>$data['order_id'],'goods_id'=>$data['goods_id']))->save(array('order_id'=>$newid));
                        $this->saveOrderStatus(array('order_id'=>$newid,'status'=>7,'remark'=>'换货'));
                        $arr = array(
                            'uid' => $data['uid'],
                            'order_id' => $newid,
                            //'goods_id' => $v,
                            'goods_id' => $data['goods_id'],
                            //'reason' => $remarkArr[$k],
                            'reason' => $data['remark'],
                            'status' => 0,
                            'money' => $order['actual_price'],
                            'type' => 2,
                            'create_time' => NOW_TIME
                        );
                        M('order_back')->add($arr);
                    }else{
                        //$res = M('order')->where(array('id'=>$data['order_id']))->save(array('status'=>7,'remark'=>$remarkArr[$k]));
                        $res = M('order')->where(array('id'=>$data['order_id']))->save(array('status'=>7,'remark'=>$data['remark']));
                        if($res){
                            $this->saveOrderStatus(array('order_id'=>$data['order_id'],'status'=>7,'remark'=>'换货'));
                            $arr = array(
                                'uid' => $data['uid'],
                                'order_id' => $data['order_id'],
                                //'goods_id' => $v,
                                'goods_id' => $data['goods_id'],
                                //'reason' => $remarkArr[$k],
                                'reason' => $data['remark'],
                                'status' => 0,
                                'money' => $order['actual_price'],
                                'type' => 2,
                                'create_time' => NOW_TIME
                            );
                            M('order_back')->add($arr);
                        }
                    }
                  
                //}elseif($typeArr[$k] == 3){//退货
                }elseif($data['type'] == 3){
                    if(count($num)>1){
                        $goods=M('order_goods')->where(array('order_id'=>$data['order_id'],'goods_id'=>$data['goods_id']))->select();
                        $price=floatval($goods[0]['price'])*floatval($goods[0]['buy_count']);   //拆出来的订单价格
                        $mes=M('order')->where(array('id'=>$data['order_id']))->find();        //原订单
                        M('order')->add(array('uid'=>$mes['uid'],'sid'=>$mes['sid'],'order_no'=>$mes['order_no'],'status'=>6,'transport_method'=>$mes['transport_method'],'transport_price'=>$mes['transport_price'],'total_price'=>$price,'actual_price'=>$price,'shipping_address'=>$mes['shipping_address'],'shipping_name'=>$mes['shipping_name'],'shipping_phone'=>$mes['shipping_phone'],'remark'=>$data['remark'],'create_time'=>$mes['create_time'],'is_over'=>$mes['is_over']));
                        M('order')->where(array('id'=>$data['order_id']))->save(array('total_price'=>(floatval($mes['total_price'])-$price),'actual_price'=>(floatval($mes['actual_price'])-$price)));
                        $new=M('order')->where(array('order_no'=>$mes['order_no']))->order('id desc')->limit(1)->select();
                        $newid=$new[0]['id'];     //拆出订单id
                        //将退货商品纳入拆出订单内
                        M('order_goods')->where(array('order_id'=>$data['order_id'],'goods_id'=>$data['goods_id']))->save(array('order_id'=>$newid));
                        $this->saveOrderStatus(array('order_id'=>$newid,'status'=>6,'remark'=>'退货'));
                        $arr = array(
                            'uid' => $data['uid'],
                            'order_id' => $newid,
                            //'goods_id' => $v,
                            'goods_id' => $data['goods_id'],
                            //'reason' => $remarkArr[$k],
                            'reason' => $data['remark'],
                            'status' => 0,
                            'money' => $order['total_price'],
                            'type' => 1,
                            'create_time' => NOW_TIME
                        );
                        M('order_back')->add($arr);
                    }else{
                        //$res = M('order')->where(array('id'=>$data['order_id']))->save(array('status'=>6,'remark'=>$remarkArr[$k]));
                        $res = M('order')->where(array('id'=>$data['order_id']))->save(array('status'=>6,'remark'=>$data['remark']));
                        if($res){
                            $this->saveOrderStatus(array('order_id'=>$data['order_id'],'status'=>6,'remark'=>'退货'));
                            $arr = array(
                                'uid' => $data['uid'],
                                'order_id' => $data['order_id'],
                                //'goods_id' => $v,
                                'goods_id' => $data['goods_id'],
                                //'reason' => $remarkArr[$k],
                                'reason' => $data['remark'],
                                'status' => 0,
                                'money' => $order['total_price'],
                                'type' => 1,
                                'create_time' => NOW_TIME
                            );
                            M('order_back')->add($arr);
                        }
                    }
                    
                //}elseif($typeArr[$k] == 4){//投诉
                }elseif($data['type'] == 4){
                    //卖家拒绝售后可以投诉
                    $order_back = M('order_back')->where(array('uid'=>$data['uid'],'order_id'=>$data['order_id']))->find();
                    if($order_back['status'] != 2){
                        return showData(new \stdClass(),'此订单不符合投诉要求',1);
                    }
                    if(count($num)>1){
                        $goods=M('order_goods')->where(array('order_id'=>$data['order_id'],'goods_id'=>$data['goods_id']))->select();
                        $price=floatval($goods[0]['price'])*floatval($goods[0]['buy_count']);   //拆出来的订单价格
                        $mes=M('order')->where(array('id'=>$data['order_id']))->find();        //原订单
                        M('order')->add(array('uid'=>$mes['uid'],'sid'=>$mes['sid'],'order_no'=>$mes['order_no'],'status'=>8,'transport_method'=>$mes['transport_method'],'transport_price'=>$mes['transport_price'],'total_price'=>$price,'actual_price'=>$price,'shipping_address'=>$mes['shipping_address'],'shipping_name'=>$mes['shipping_name'],'shipping_phone'=>$mes['shipping_phone'],'remark'=>$data['remark'],'create_time'=>$mes['create_time'],'is_over'=>$mes['is_over']));
                        M('order')->where(array('id'=>$data['order_id']))->save(array('total_price'=>(floatval($mes['total_price'])-$price),'actual_price'=>(floatval($mes['actual_price'])-$price)));
                        $new=M('order')->where(array('order_no'=>$mes['order_no']))->order('id desc')->limit(1)->select();
                        $newid=$new[0]['id'];     //拆出订单id
                        //将投诉商品纳入拆出订单内
                        M('order_goods')->where(array('order_id'=>$data['order_id'],'goods_id'=>$data['goods_id']))->save(array('order_id'=>$newid));
                        $this->saveOrderStatus(array('order_id'=>$newid,'status'=>8,'remark'=>'投诉'));
                        $arr = array(
                            'uid' => $data['uid'],
                            'order_id' => $newid,
                            //'goods_id' => $v,
                            'goods_id' => $data['goods_id'],
                            //'reason' => $remarkArr[$k],
                            'reason' => $data['remark'],
                            'status' => 1,
                            'money' => $order['total_price'],
                            'type' => 3,
                            'finish_time' => NOW_TIME,
                            'create_time' => NOW_TIME
                        );
                        M('order_back')->add($arr);
                    }
                    //$res = M('order')->where(array('id'=>$data['order_id']))->save(array('status'=>8,'remark'=>$remarkArr[$k]));
                    $res = M('order')->where(array('id'=>$data['order_id']))->save(array('status'=>8,'remark'=>$data['remark']));
                    if($res){
                        $this->saveOrderStatus(array('order_id'=>$data['order_id'],'status'=>8,'remark'=>'投诉'));
                        $arr = array(
                            'uid' => $data['uid'],
                            'order_id' => $data['order_id'],
                            //'goods_id' => $v,
                            'goods_id' => $data['goods_id'],
                            //'reason' => $remarkArr[$k],
                            'reason' => $data['remark'],
                            'status' => 1,
                            'money' => $order['actual_price'],
                            'type' => 3,
                            'finish_time' => NOW_TIME,
                            'create_time' => NOW_TIME
                        );
                        M('order_back')->add($arr);
                    }
                }
            }
            return showData(new \stdClass(),'操作成功');
        }
    

    /**
     * 卖家订单列表
     * 1.待发货 2.待评价 3.售后 4.历史
     */
    function supplierOrderList($data){
        $where = array('_string'=>'o.sid in (select id from '.$this->tablePrefix.'supplier where uid='.$data['uid'].')');
        if(!empty($data['order_id'])){
            $where['o.id'] = $data['order_id'];
        }
        $status = "(o.status = 1 or (o.is_hdfk = 1 and (o.status = 1 or o.status = 0)))";
        if($data['type'] == 1){
            $where['_string'] .= ' and (o.status = 1 or (o.is_hdfk = 1 and (o.status = 1 or o.status = 0)))';
        }
        if($data['type'] == 2){
            $where['o.status'] = 4;
            $status = "o.status=4";
        }
        if($data['type'] == 3){
            $where['_string'] .= ' and o.status in (6,7)';
            $status = "o.status in (6,7)";
        }
        if($data['type'] == 4){
            $where['_string'] .= ' and o.status in (5,9)';
            $status = "o.status in (5,9)";
        }
//        $where['g.type'] = array('neq',2);
//        $sql = "SELECT COUNT(*)AS tp_count FROM (SELECT o.* FROM ".$this->tablePrefix."order o LEFT JOIN ".$this->tablePrefix."order_goods og ON o.id = og.order_id LEFT JOIN ".$this->tablePrefix."goods g ON og.goods_id = g.id WHERE (o.sid IN(SELECT id FROM ".$this->tablePrefix."supplier WHERE uid = ".$data['uid'].")) AND (".$status.") AND (g.type <> 2) GROUP BY order_no)a LIMIT 1";
        $sql = "SELECT COUNT(*)AS tp_count FROM (SELECT o.* FROM ".$this->tablePrefix."order o LEFT JOIN ".$this->tablePrefix."order_goods og ON o.id = og.order_id LEFT JOIN ".$this->tablePrefix."goods g ON og.goods_id = g.id WHERE (o.sid IN(SELECT id FROM ".$this->tablePrefix."supplier WHERE uid = ".$data['uid'].")) AND (".$status.") GROUP BY order_no)a LIMIT 1";
        $total = $this->query($sql);
        $total = $total[0]['tp_count'];
        if ($total){
            $page  = page($total);
            $limit = $page['offset'] . ',' . $page['limit'];
        }else {
            $page  = '';
        }
        $data = self::public_order_list($where, $limit, 'o.create_time desc',1);
        return showData($data,'',0,$page);
    }

    /**
     * 发货
     */
    function deliveryOrder($data){
        //查询订单信息
        $order = M('order')->where(array('sid'=>$data['sid'],'id'=>$data['order_id']))->find();
        if(empty($order)){
            return showData(new \stdClass(),'订单不存在',1);
        }
        if($order['status'] != 1 && $order['is_hdfk'] != 1){
            return showData(new \stdClass(),'此订单不符合发货要求',1);
        }
        $res = M('order')->where(array('id'=>$data['order_id']))->save(array('status'=>2));
        if($res){
            $this->saveOrderStatus(array('order_id'=>$data['order_id'],'status'=>2,'remark'=>'发货'));
            $order_list = $this->supplierOrderList($data);
            return showData($order_list['data'][0]);
        }
    }

    /**
     * 商品评价
     */
    function goodsComment($data){
        $goodsArr = json_decode($data['goods_id'],true);
        $scoreArr = json_decode($data['score'],true);
        $contentArr = json_decode($data['content'],true);
        foreach($goodsArr as $k => $v){
            $where = array('uid'=>$data['uid'],'order_id'=>$data['order_id'],'goods_id'=>$v);
            $count = M('goods_comment')->where($where)->count();
            if($count > 0){
                return showData(new \stdClass(),'已评价过该商品',1);
            }
            if(empty($data['score'])){
                return showData(new \stdClass(),'评价分数不可为空',1);
            }
            $addData = array(
                'uid' => $data['uid'],
                'order_id' => $data['order_id'],
                'goods_id' => $v,
                'score' => $scoreArr[$k],
                'content' => $contentArr[$k],
                'create_time' => NOW_TIME
            );
            M('goods_comment')->add($addData);
        }
        M('order')->where(array('id'=>$data['order_id']))->save(array('status'=>4));
        return showData(new \stdClass(),'评价成功');
//        $where = array('uid'=>$data['uid'],'order_id'=>$data['order_id'],'goods_id'=>$data['goods_id']);
//        $count = M('goods_comment')->where($where)->count();
//        if($count > 0){
//            return showData(new \stdClass(),'已评价过该商品',1);
//        }
//        if(empty($data['score'])){
//            return showData(new \stdClass(),'评价分数不可为空',1);
//        }
//        $data['create_time'] = NOW_TIME;
//        if(M('goods_comment')->add($data)){
//            M('order')->where(array('id'=>$data['order_id']))->save(array('status'=>4));
//            return showData(new \stdClass(),'评价成功');
//        }
//        return showData(new \stdClass(),'评价失败',1);
    }

    /**
     * 商品评价列表
     */
    function goodsCommentList($data){
        $where = array('a.goods_id'=>$data['goods_id']);
        $total = M('goods_comment')->alias('a')->where($where)->count();
        if ($total){
            $page  = page($total);
            $limit = $page['offset'] . ',' . $page['limit'];
        }else {
            $page  = '';
        }
        $result = M('goods_comment')->alias('a')->join('left join '.$this->tablePrefix.'user b on a.uid=b.uid left join '.$this->tablePrefix.'user_head c on b.head=c.id')->where($where)->limit($limit)->field('b.name,c.smallUrl,c.originUrl,a.uid,a.score,a.content,a.intro,a.create_time')->order('a.create_time desc')->select();
        foreach ($result as &$item) {
            $item['smallUrl'] = site_url($item['smallUrl']);
            $item['originUrl'] = site_url($item['originUrl']);
        }
        return showData($result,'',0,$page);
    }

    /**
     * 卖单售后
     */
    function supplierOrderBack($data){
        \Think\Log::write('<<<<<'.date('Y-m-d H:i:s',time()).' supplierOrderBack------------'.json_encode($_REQUEST).'>>>>>','WARN',C('LOG_TYPE'),C('LOG_PATH').date('y_m_d').'-----.log');
//        $where = array('order_id'=>$data['order_id']);
//        $back_info = M('order_back')->where($where)->order('create_time desc')->limit(1)->find();
//        if($back_info['status'] != 0){
//            return showData(new \stdClass(),'已处理过该售后订单',1);
//        }
       // $goodsArr = json_decode($data['goods_id'],true);
       // $introArr = json_decode($data['intro'],true);
        //$statusArr = json_decode($data['status'],true);
        //foreach ($goodsArr as $k => $v){
            //$where = array('order_id'=>$data['order_id'],'goods_id'=>$v,'status'=>0);
            $where = array('order_id'=>$data['order_id'],'goods_id'=>$data['goods_id'],'status'=>0);
            $back = M('order_back')->where($where)->count();
            echo $back;
            if(!$back){
                return showData(new \stdClass(),'售后状态不正确，请稍后再试',1);
            }
            $this->startTrans();
            //if($statusArr[$k] == 2){
            if($data['status'] == 2){
                //if(empty($introArr[$k])){
                if(empty($data['intro'])){
                    $this->rollback();
                    return showData(new \stdClass(),'拒绝理由不可为空',1);
                }
            }
            $where = array('order_id'=>$data['order_id'],'goods_id'=>$data['goods_id']);
            $back_info = M('order_back')->where($where)->order('create_time desc')->limit(1)->find();
            $save = array(
                'status' => $data['status'],
                'intro' => $data['intro'],
                'finish_time' => NOW_TIME
            );
            $data['finish_time'] = NOW_TIME;
            if($data['status'] == 3){
                $order = M('order')->where(array('id'=>$data['order_id']))->find();
                //$orderGoods = M('order_goods')->where(array('order_id'=>$data['order_id'],'goods_id'=>$data['goods_id']))->find();
                //$orderGoods['price'] = floatval($orderGoods['price']) * intval($orderGoods['buy_count']);
                //$order['total_price'] = floatval($order['total_price'])-floatval($order['return_price'])-floatval($order['coupon_price']);
                //if($order['total_price'] >= floatval($orderGoods['price'])){
                 //   $order['total_price'] = $orderGoods['price'];
                //}
                if($order['is_over'] == 1){
                    $suppler = M('supplier')->where(array('id'=>$order['sid']))->find();
                    $user = M('user')->where(array('uid'=>$suppler['uid']))->find();
                    M('user')->where(array('uid'=>$suppler['uid']))->setDec('balance',$order['total_price']);
                    $orderno = M('order')->where('id='.$data['order_id'])->getField("order_no");
                    account_log($suppler['uid'],$order['total_price'],"卖家同意售后，直接扣除余额，订单No：".$orderno,1);
                    if(floatval($user['balance']) < $order['total_price']){
                        //发送私信，提示卖家余额不足
                        $content = "您好，您的账户余额已不足，请及时充值，以免影响正常销售！";
                        $message = new \Message\Model\MessageModel();
                        $tag = getMillisecond();
                        $return = $message->message('10000000',"管理员",$suppler['uid'],$content,$tag);
                    }
                }
                //退款给用户
                M('user')->where(array('uid'=>$order['uid']))->setInc('balance',$order['total_price']);
                $orderno = M('order')->where('id='.$data['order_id'])->getField("order_no");
                account_log($order['uid'],$order['total_price'],"卖家同意售后，退给买家，订单No：".$orderno);
                M('order')->where('id='.$data['order_id'])->setInc('return_price',$order['total_price']);
//                M('user')->where(array('uid'=>$order['uid']))->setDec('integral',ceil(floatval($orderGoods['price'])/10));
//                $order = M('order')->where(array('id'=>$data['order_id']))->find();
//                if(floatval($order['balances_price']) > 0){
//                    M('user')->where(array('uid'=>$order['uid']))->setInc('balance',floatval($order['balances_price']));
//                }
//                if(intval($order['coupon_id']) > 0){
//                    M('user_coupon')->where(array('id'=>$order['coupon_id']))->save(array('is_use'=>0));
//                }
//                M('user')->where(array('uid'=>$order['uid']))->setInc('balance',floatval($order['actual_price']));
            }
            M('order_back')->where(array('id'=>$back_info['id']))->save($save);
        //}
        $this->commit();
        return showData(new \stdClass(),'操作成功');
//        if($data['status'] == 2){
//            if(empty($data['intro'])){
//                return showData(new \stdClass(),'拒绝理由不可为空',1);
//            }
//        }
//        $data['finish_time'] = NOW_TIME;
//        $ret = M('order_back')->where(array('id'=>$back_info['id']))->save($data);
//        if($ret){
////            if($back_info['type'] == 1){
////                M('order')->where(array('id'=>$data['order_id']))->save(array('status'=>9));
////                $order = M('order')->where(array('id'=>$data['order_id']))->find();
////                if(floatval($order['balances_price']) > 0){
////                    M('user')->where(array('uid'=>$order['uid']))->setInc('balance',floatval($order['balances_price']));
////                }
////                if(intval($order['coupon_id']) > 0){
////                    M('user_coupon')->where(array('id'=>$order['coupon_id']))->save(array('is_use'=>0));
////                }
////            }
//            return showData(new \stdClass(),'操作成功');
//        }
//        return showData(new \stdClass(),'操作失败',1);
    }

    /**
     * 卖单售后退款
     */
    function orderBackMoney($data){
        $orderArr = json_decode($data['order_id'],true);
//        foreach ($orderArr as $item){
//            $order = M('order')->where(array('id'=>$item))->find();
//            if(floatval($order['balances_price']) > 0){
//                M('user')->where(array('uid'=>$order['uid']))->setInc('balance',floatval($order['balances_price']));
//            }
//            if(intval($order['coupon_id']) > 0){
//                M('user_coupon')->where(array('id'=>$order['coupon_id']))->save(array('is_use'=>0));
//            }
//            M('user')->where(array('uid'=>$order['uid']))->setInc('balance',floatval($order['actual_price']));
//        }
        return showData(new \stdClass(),'退款成功');
    }

    /**
     * 查询店铺状态
     * @param $data
     * 0.申请中，1.已通过，2.未通过
     */
    function searchShopStatus($data){
        if(M('supplier')->where($data)->count() <= 0){
            return showData(new \stdClass(),'该空间号未申请开店',1);
        }
        $res = M('supplier')->where($data)->order('create_time desc')->limit(1)->find();
        $text = '';
        $status = 0;
        $name = "";
        $phone = "";
        $ID_card_picture = "";
        if(empty($res)){
            $status = 0;
        }else{
            if($res['status'] == '0'){
                $text = "申请中";
                $status = 3;
                $name = $res['name'];
                $phone = $res['phone'];
                $ID_card_picture = site_url(M('supplier_gallery')->where('sid='.$res['id'])->getField('originUrl'));
            }elseif($res['status'] == '1'){
                $text = "已通过";
                $status = 1;
            }elseif($res['status'] == '2'){
                $text = "未通过";
                $status = 2;
            }
        }
        $result = array(
            'text' => $text,
            'status' => $status,
            'name' => $name,
            'phone' => $phone,
            'ID_card_picture' => $ID_card_picture
        );
        return showData($result);
    }

    /**
     * 回复商品评价
     * @param $data
     */
    function returnComment($data){
        $goodsIdArr = json_decode($data['goods_id'],true);
        $introArr = json_decode($data['intro'],true);
        foreach($goodsIdArr as $k => $v){
            $where = array('order_id'=>$data['order_id'],'goods_id'=>$v);
            $count = M('goods_comment')->where($where)->count();
            if($count <= 0){
                return showData(new \stdClass(),'评论信息不存在',1);
            }
            M('goods_comment')->where($where)->save(array('intro'=>$introArr[$k]));
        }
        M('order')->where(array('id'=>$data['order_id']))->save(array('status'=>5));
        return showData(new \stdClass(),'回复评论成功');
//        $where = array('order_id'=>$data['order_id'],'goods_id'=>$data['goods_id']);
//        $count = M('goods_comment')->where($where)->count();
//        if($count <= 0){
//            return showData(new \stdClass(),'评论信息不存在',1);
//        }
//        $res = M('goods_comment')->where($where)->save(array('intro'=>$data['intro']));
//        if($res){
//            M('order')->where(array('id'=>$data['order_id']))->save(array('status'=>5));
//            return showData(new \stdClass(),'回复评论成功');
//        }
//        return showData(new \stdClass(),'回复评论失败',1);
    }

    /**
     * 查看售后信息
     * @param $data
     */
    function orderBackInfo($data){
        $count = M('order_back')->alias('ob')->where($data)->count();
        if($count <= 0){
            return showData(new \stdClass(),'不存在该订单售后信息',1);
        }
        $back = M('order_back')->alias('ob')->join('left join '.$this->tablePrefix.'order_goods og on ob.order_id=og.order_id and ob.goods_id=og.goods_id ')->field("ob.uid,ob.order_id,ob.goods_id,ob.reason,ob.status,ob.money,ob.type,ob.intro,ob.finish_time,ob.create_time,og.price,og.buy_count,og.goods_name")->where($data)->order("create_time desc")->select();
        if($back){
            return showData($back);
        }
        return showData(new \stdClass(),'查询失败',1);
    }
}