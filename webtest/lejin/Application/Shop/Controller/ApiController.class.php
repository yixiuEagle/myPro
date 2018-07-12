<?php
namespace Shop\Controller;
use Common\Api\Api;
use Shop\Model\ShopModel;

class ApiController extends Api {
    protected $shop_db;
	function _initialize(){
		parent::_initialize();
        $this->shop_db = new ShopModel();
	}
    /**
     * 检查空间号是否存在
     */
    function isGroups(){
        $db = new \Share\Model\GroupModel();
        $id = I('groups_id',0);
        if (!$db->where(array('id'=>$id,'uid'=>$this->mid))->count()){
            $data = showData(new \stdClass(), '没有创建该空间号', 1);
            $this->jsonOutput($data);
        }
    }
    /**
     * 检查空间号是否申请过商家
     */
    function isGroupsRegSupplier(){
        $id = I('groups_id',0);
        if (M('supplier')->where(array('groups_id'=>$id,'status'=>array('neq',2)))->count()){
            return true;
        }
        return false;
    }
    /**
     * 检查是否商家
     */
    function isSupplier(){
        $id = I('sid',0);
        $supplier = M('supplier')->where(array('id'=>$id))->find();
        if (!$supplier){
            $data = showData(new \stdClass(), '商家不存在', 1);
            $this->jsonOutput($data);
        }
        if($supplier['status'] == 0){
            $data = showData(new \stdClass(), '该商家正在审核中', 1);
            $this->jsonOutput($data);
        }
        if($supplier['status'] == 2){
            $data = showData(new \stdClass(), '该商家审核未通过', 1);
            $this->jsonOutput($data);
        }
    }
    /**
     * 检查商家是否属于该用户
     */
    function supplierIsUser(){
        $id = I('sid',0);
        $supplier = M('supplier')->where(array('id'=>$id,'uid'=>$this->mid))->find();
        if (!$supplier){
            $data = showData(new \stdClass(), '该商家不属于该用户', 1);
            $this->jsonOutput($data);
        }
        if($supplier['status'] == 0){
            $data = showData(new \stdClass(), '该商家正在审核中', 1);
            $this->jsonOutput($data);
        }
        if($supplier['status'] == 2){
            $data = showData(new \stdClass(), '该商家审核未通过', 1);
            $this->jsonOutput($data);
        }
    }
    /**
     * 检查商品是否属于该商家
     */
    function goodsIsSupplier(){
        $sid = I('sid',0);
        $id = I('goods_id',0);
        if (!M('goods')->where(array('id'=>$id,'sid'=>$sid))->count()){
            $data = showData(new \stdClass(), '该商品不属于该商家', 1);
            $this->jsonOutput($data);
        }
    }

    /**
     * 申请开店
     */
    function regSupplier(){
        self::isLogin();
        $this->isGroups();
//        if($this->isGroupsRegSupplier()){$this->jsonOutput(showData(new \stdClass(),'该号已申请过开店',1));}
        $data = array();
        $data['uid'] = $this->mid;
        $data['name'] = I('name');
        $data['phone'] = I('phone');
        $data['groups_id'] = I('groups_id');
//        $data['lng'] = I('lng');
//        $data['lat'] = I('lat');
        $data = $this->shop_db->regSupplier($data);
        $this->jsonOutput($data);
    }

    /**
     * 收藏商家
     */
    function collect(){
        self::isLogin();
        $this->isSupplier();
        $type = I('type',0);
        $return = $this->shop_db->collectSupplier($this->mid,I('sid'),$type);
        $this->jsonOutput($return);
    }

    /**
     * 商家列表
     */
    function supplierList(){
        self::isLogin();
        $data = array(
            'uid' => $this->mid,
            'sid' => I('sid',''),
            'type' => I('type',0),
            'catId' => I('catId',0),
            'lng' => I('lng',0),
            'lat' => I('lat',0),
            'pageSize' => I('pageSize'),
            'page' => I('page')
        );
        if(!empty($data['sid'])){
            $this->isSupplier();
        }
        $return = $this->shop_db->supplierList($data);
        $this->jsonOutput($return);
    }

    /**
     * 添加商品/优惠券
     */
    function addGoods(){
        self::isLogin();
        $this->isSupplier();
        $this->supplierIsUser();
        $data = array(
            'uid' => I('uid',0),
            'sid' => I('sid',0),
            'type' => I('type',1),
            'name' => I('name',''),
            'profile' => I('profile',''),
            'sale_price' => I('sale_price',0),
            'original_price' => I('original_price',0),
            'cheap_price' => I('cheap_price',0),
            'is_cheap' => I('is_cheap',0),
            'deducted_price' => I('deducted_price',0),
            'start_time' => I('start_time',''),
            'end_time' => I('end_time',''),
            'transport_method' => I('transport_method',0),
            'transport_price' => I('transport_price',0),
            'create_time' => NOW_TIME
        );
        $return = $this->shop_db->addGoods($data);
        $this->jsonOutput($return);
    }

    /**
     * 删除商品
     */
    function deleteGoods(){
        self::isLogin();
        $this->isSupplier();
        $this->supplierIsUser();
        $this->goodsIsSupplier();
        $data = array(
            'sid' => I('sid',0),
            'id' => I('goods_id',0)
        );
        $return = $this->shop_db->deleteGoods($data);
        $this->jsonOutput($return);
    }

    /**
     * 编辑商品
     */
    function editGoods(){
        self::isLogin();
        $this->isSupplier();
        $this->supplierIsUser();
        $this->goodsIsSupplier();
        $data = array(
            'sid' => I('sid',0),
            'type' => I('type',1),
            'name' => I('name',''),
            'profile' => I('profile',''),
            'sale_price' => I('sale_price',0),//已去掉
            'update_price' => I('original_price',0),
            'cheap_price' => I('cheap_price',0),
            'is_cheap' => I('is_cheap',0),
            'deducted_price' => I('deducted_price',0),
            'start_time' => I('start_time',''),
            'end_time' => I('end_time',''),
            'transport_method' => I('transport_method',1),
            'transport_price' => I('transport_price',''),
            'update_time' => NOW_TIME
        );
        if(round(floatval($data['update_price'])-floatval($data['cheap_price']),1) < 0.1 && $data['is_cheap'] == 1){
            $data['is_cheap'] = 0;
        }
        $return = $this->shop_db->editGoods(I('goods_id',0),$data,I('uid',0),I('original_images',''));
        $this->jsonOutput($return);
    }

    /**
     * 商家商品列表
     */
    function goodsList(){
        self::isLogin();
        $this->isSupplier();
        $data = array(
            'uid' => $this->mid,
            'sid' => I('sid',0),
            'type' => I('type',0),
            'page' => I('page',''),
            'pageSize' => I('pageSize','')
        );
        if($data['type'] == 1){
            $this->supplierIsUser();
        }
        $return = $this->shop_db->goodsList($data);
        $this->jsonOutput($return);
    }

    /**
     * 商品详情
     */
    function goodsDetail(){
        self::isLogin();
        $data = array(
            'uid' => $this->mid,
            'goods_id' => I('goods_id',0)
        );
        $return = $this->shop_db->goodsDetail($data);
        $this->jsonOutput($return);
    }

    /**
     * 增加或减少购买商品
     */
    function updatePayGoods(){
        self::isLogin();
        $this->isSupplier();
        $this->goodsIsSupplier();
        $data = array(
            'uid' => $this->mid,
            'sid' => I('sid',0),
            'goods_id' => I('goods_id',0),
            'pay_count' => I('new_count',1)
        );
        $return = $this->shop_db->updatePayGoods($data);
        $this->jsonOutput($return);
    }

    /**
     * 付款订单
     */
    function payOrder(){
        self::isLogin();
        $this->isSupplier();
        $data = array(
            'uid' => $this->mid,
            'sid' => I('sid',0),
            'is_balance' => I('is_balance',1),
            'is_coupon' => I('is_coupon',1)
        );
        $return = $this->shop_db->payOrder($data);
        $this->jsonOutput($return);
    }

    /**
     * 提交订单
     */
    function submitOrder(){
        self::isLogin();
        $this->isSupplier();
        $data = array(
            'uid' => $this->mid,
            'sid' => I('sid',0),
            'address' => I('address',''),
            'receiver' => I('receiver',''),
            'phone' => I('phone',''),
            'is_balance' => I('is_balance'),
            'is_coupon' => I('is_coupon'),
            'is_hdfk' => I('is_hdfk')
        );
        $return = $this->shop_db->submitOrder($data);
        $this->jsonOutput($return);
    }
    //付款返回支付信息
    function pay(){
        self::isLogin();
        $return = $this->shop_db->pay(I('order_no'));
        $this->jsonOutput($return);
    }
    /**
     * 支付订单回调
     */
    function notifyurl(){
		\Think\Log::write('<<<<<'.date('Y-m-d H:i:s',time()).' AliPay-START>>>>>','WARN',C('LOG_TYPE'),C('LOG_PATH').date('y_m_d').'-----.log');
        \Think\Log::write('<<<<<'.date('Y-m-d H:i:s',time()).' AliPay------------'.json_encode($_POST).'>>>>>','WARN',C('LOG_TYPE'),C('LOG_PATH').date('y_m_d').'-----.log');
        $alipay_config = C('mobilepay_config');
        $alipayNotify  = new \Common\Pay\AppAli\AlipayNotify($alipay_config);
        $verify_result = $alipayNotify->verifyNotify();
        if($verify_result) {//验证成功
            $out_trade_no  = $_POST['out_trade_no'];   //商户订单号
            $trade_no      = $_POST['trade_no'];       //支付宝交易号
            $trade_status  = $_POST['trade_status'];   //交易状态
            \Think\Log::write('<<<<<'.date('Y-m-d H:i:s',time()).' AliPay-'.json_encode($_POST).'>>>>>','WARN',C('LOG_TYPE'),C('LOG_PATH').date('y_m_d').'-----.log');
            if($_POST['trade_status'] == 'TRADE_FINISHED') {

            } else if ($_POST['trade_status'] == 'TRADE_SUCCESS') {
                $pre = substr($out_trade_no,0,1);
                $out_trade_no = substr($out_trade_no,1,strlen($out_trade_no)-1);
                if($pre == C('FIND_PAY_PRE')){
                    $db   = M('activity_sign');
                    $info = $db->where(array('order_no'=>$out_trade_no))->find();
                    if($info['status'] != 1){
                        $db->where(array('id'=>$info['id']))->setField('status', 1);
                        M('user')->where(array('uid'=>$info['uid']))->setDec('balance',$info['balance']);
                        account_log($info['uid'],$info['balance'],"发现支付回调扣除余额，订单No：".$info['order_no'],1);
                        //添加用户积分
                        M('user')->where(array('uid'=>$info['uid']))->setInc('integral',ceil((floatval($info['pay_price'])+floatval($info['balance']))/10));
                    }
                }elseif($pre == C('BACK_PAY_PRE')){
                    $db   = M('order_back');
                    $info = $db->where(array('id'=>$out_trade_no))->find();
                    $order = M('order')->where(array('id'=>$info['order_id']))->find();
                    if($order['status'] == 6){
                        M('order')->where(array('id'=>$info['order_id']))->setField('status', 5);
                        $this->shop_db->saveOrderStatus(array('order_id'=>$info['id'],'status'=>5,'remark'=>'退款完成'));
                    }
                }elseif($pre == C('RECHAREGE_PAY_PRE')){
                    $db   = M('user_recharge');
                    $info = $db->where(array('id'=>$out_trade_no))->find();
                    if($info['status'] != 1){
                        $db->where(array('id'=>$out_trade_no))->setField('status', 1);
                        //更新用户帐
                        $exp['balance'] = array('exp', 'balance+'.$info['fee']);
                        M('user')->where(array('uid'=>$info['uid']))->save($exp);
                        account_log($info['uid'],$info['balance'],"用户充值");
                    }
                }else{
                    $db   = M('order');
                    $info = $db->where(array('order_no'=>$out_trade_no))->find();
                    if($info['status'] == 0){
                        $status = 1;
                        $goods_type = M('order_goods')->alias("o")->where(array('order_id'=>$info['id']))->join("left join ".C('DB_PREFIX')."goods g on o.goods_id=g.id")->field("g.id,g.type")->select();
                        foreach($goods_type as $type){
                            if($type['type'] == 2){
                                $status = 5;
                                M('user_coupon')->where(array('order_no'=>$out_trade_no,'goods_id'=>$type['id']))->save(array('status'=>1));
                            }else{
                                $status = 1;
                                break;
                            }
                        }
//                    if($status == 5){
//                        M('user_coupon')->where(array('order_no'=>$out_trade_no))->save(array('status'=>1));
//                    }
                        $db->where(array('id'=>$info['id']))->setField('status', $status);
                        $this->shop_db->saveOrderStatus(array('order_id'=>$info['id'],'status'=>1,'remark'=>'付款'));
                        if($info['is_coupon']){
                            M('user_coupon')->where(array("id"=>$info['coupon_id']))->save(array('is_use'=>1));
                        }
                        if($info['is_balances']){
                            M('user')->where(array("uid"=>$info['uid']))->setDec("balance",$info['balances_price']);
                            account_log($info['uid'],$info['balances_price'],"提交订单，使用余额，扣除余额，订单No：".$info['order_no'],1);
                        }
                        //添加用户积分
                        M('user')->where(array('uid'=>$info['uid']))->setInc('integral',ceil(floatval($info['total_price'])/10));
                    }
                }
            }
            echo "success";		//请不要修改或删除
        }else {
            echo "fail";//验证失败
        }
    }

    /**
     * 用户订单列表
     */
    function orderList(){
        self::isLogin();
        $return = $this->shop_db->orderList($this->mid);
        $this->jsonOutput($return);
    }

    /**
     * 订单操作
     * 1-收货 2-换货 3-退货 4-投诉
     */
    function orderOperate(){
        self::isLogin();
        $data = array(
            'uid' => $this->mid,
            'order_id' => I('order_id',0),
            'goods_id' => I('goods_id',0),
            'type' => I('type',''),
            'remark' => I('remark','')
        );
        $return = $this->shop_db->orderOperate($data);
        $this->jsonOutput($return);
    }

    /**
     * 卖家订单列表
     * 1.待发货 2.待评价 3.售后 4.历史
     */
    function supplierOrderList(){
        self::isLogin();
        $data = array(
            'uid' => I('uid'),
            'type' => I('type'),
            'order_id' => I('order_id'),
            'page' => I('page'),
            'pageSize' => I('pageSize')
        );
        $return = $this->shop_db->supplierOrderList($data);
        $this->jsonOutput($return);
    }

    /**
     * 发货
     */
    function deliveryOrder(){
        self::isSupplier();
        $data = array(
            'sid' => I('sid'),
            'order_id' => I('order_id')
        );
        $return = $this->shop_db->deliveryOrder($data);
        $this->jsonOutput($return);
    }

    /**
     * 商品评价
     */
    function goodsComment(){
        self::isLogin();
        $data = array(
            'uid' => I('uid'),
            'order_id' => I('order_id'),
            'goods_id' => I('goods_id'),
            'score' => I('score'),
            'content' => I('content')
        );
        $return = $this->shop_db->goodsComment($data);
        $this->jsonOutput($return);
    }

    /**
     * 商品评价列表
     */
    function goodsCommentList(){
        self::isLogin();
        $data = array(
            'uid' => I('uid'),
            'goods_id' => I('goods_id'),
            'page' => I('page'),
            'pageSize' => I('pageSize')
        );
        $return = $this->shop_db->goodsCommentList($data);
        $this->jsonOutput($return);
    }

    /**
     * 卖单售后
     */
    function supplierOrderBack(){
        self::isLogin();
        self::isSupplier();
        $data = array(
            'order_id' => I('order_id'),
            'goods_id' => I('goods_id'),
            'intro' => I('intro'),
            'status' => I('status')
        );
        $return = $this->shop_db->supplierOrderBack($data);
        $this->jsonOutput($return);
    }

    /**
     * 卖单售后退款
     */
    function orderBackMoney(){
        self::isLogin();
        self::isSupplier();
        $data = array(
            'order_id' => I('order_id')
        );
        $return = $this->shop_db->orderBackMoney($data);
        $this->jsonOutput($return);
    }
    function back_notifyurl(){
        $alipay_config = C('mobilepay_config');
        $alipayNotify  = new \Common\Pay\AppAli\AlipayNotify($alipay_config);
        $verify_result = $alipayNotify->verifyNotify();
        if($verify_result) {//验证成功
            $out_trade_no  = $_POST['out_trade_no'];   //商户订单号
            $trade_no      = $_POST['trade_no'];       //支付宝交易号
            $trade_status  = $_POST['trade_status'];   //交易状态
            if($_POST['trade_status'] == 'TRADE_FINISHED') {

            } else if ($_POST['trade_status'] == 'TRADE_SUCCESS') {
                $db   = M('order_back');
                $info = $db->where(array('id'=>$out_trade_no))->find();
                M('order')->where(array('id'=>$info['order_id']))->setField('status', 5);
                $this->shop_db->saveOrderStatus(array('order_id'=>$info['id'],'status'=>5,'remark'=>'退款完成'));
            }
            echo "success";		//请不要修改或删除
        }else {
            echo "fail";//验证失败
        }
    }

    /**
     * 查询店铺申请状态
     */
    function searchShopStatus(){
        self::isLogin();
        self::isGroups();
        $data = array(
            'uid' => I('uid'),
            'groups_id' => I('groups_id')
        );
        $return = $this->shop_db->searchShopStatus($data);
        $this->jsonOutput($return);
    }

    /**
     * 商家回复评价
     */
    function returnComment(){
        self::isSupplier();
//        self::goodsIsSupplier();
        $data = array(
            'sid' => I('sid'),
            'order_id' => I('order_id'),
            'goods_id' => I('goods_id'),
            'intro' => I('intro')
        );
        $return = $this->shop_db->returnComment($data);
        $this->jsonOutput($return);
    }

    /**
     * 查看售后
     */
    function orderBackInfo(){
        $data = array(
            'ob.order_id' => I('order_id')
        );
        $return = $this->shop_db->orderBackInfo($data);
        $this->jsonOutput($return);
    }

    /**
     * 定时任务
     */
    function task(){
        \Think\Log::write('------------------------------task');
        $now = intval(NOW_TIME);
        //买家付款完成后形成订单，卖家5天（120小时）未发货，则该订单取消，款项退回买家余额。
        //“同城到付”中未付款订单，则直接取消订单，买家无余额；
//        $time = $now-60*60*24*5;//5天之前
        $time = $now-60;//5天之前
        //查询未发货订单
        $orders = M('order')->field('id,order_no,uid,is_coupon,coupon_price,total_price,actual_price,sid,is_hdfk')->where('id in (select order_id from '.C('DB_PREFIX').'order_status where type=1 and create_time <= '.$time.') and status = 1')->select();
        foreach($orders as $order){
            M('order')->where('id='.$order['id'])->save(array('status'=>9));
            M('order_status')->add(array('order_id'=>$order['id'],'type'=>9,'remark'=>'取消','create_time'=>NOW_TIME));
            if($order['is_hdfk'] == 0){
                if($order['is_coupon'] == 1){
                    $order['total_price'] = floatval($order['total_price']) - floatval($order['coupon_price']);
                }
                M('user')->where('uid='.$order['uid'])->setInc('balance',$order['total_price']);
                account_log($order['uid'],$order['total_price'],"定时任务取消订单，订单退款，订单No：".$order['order_no']);
            }
        }

        //卖家已发货，买家10天（240小时）未确认，则自动收货并评价5分，状态为“已完成”，卖家状态同样为“已完成”；
//        $time = $now-60*60*24*10;//10天之前
        $time = $now-60*2;//10天之前
        //查询已发货订单
        $orders = M('order')->field('id,uid,total_price,actual_price,sid,is_hdfk')->where('id in (select order_id from '.C('DB_PREFIX').'order_status where type=2 and create_time <= '.$time.') and status = 2')->select();
        foreach($orders as $order){
            //修改订单状态为已完成
            M('order')->where('id='.$order['id'])->save(array('status'=>5));
            //添加订单状态记录：收货
            M('order_status')->add(array('order_id'=>$order['id'],'type'=>3,'remark'=>'收货','create_time'=>NOW_TIME));
            //评价订单商品
            $orderGoods = M('order_goods')->where('order_id='.$order['id'])->select();
            foreach($orderGoods as $goods){
                $addData = array(
                    'order_id' => $goods['order_id'],
                    'goods_id' => $goods['goods_id'],
                    'uid' => $order['uid'],
                    'score' => 5,
                    'content' => '',
                    'intro' => '',
                    'create_time' => NOW_TIME
                );
                M('goods_comment')->add($addData);
            }
        }

        //买家已收货确认，但5天（120小时）未评价，则自动评价5分，状态为“已完成”。卖家状态同样为“已完成”；
//        $time = $now-60*60*24*5;//5天之前
        $time = $now-60;//5天之前
        //查询已发货订单
        $orders = M('order')->field('id,uid,total_price,actual_price,sid,is_hdfk')->where('id in (select order_id from '.C('DB_PREFIX').'order_status where type=3 and create_time <= '.$time.') and status = 3')->select();
        foreach($orders as $order){
            //修改订单状态为已完成
            M('order')->where('id='.$order['id'])->save(array('status'=>5));
            //评价订单商品
            $orderGoods = M('order_goods')->where('order_id='.$order['id'])->select();
            foreach($orderGoods as $goods){
                $addData = array(
                    'order_id' => $goods['order_id'],
                    'goods_id' => $goods['goods_id'],
                    'uid' => $order['uid'],
                    'score' => 5,
                    'content' => '',
                    'intro' => '',
                    'create_time' => NOW_TIME
                );
                M('goods_comment')->add($addData);
            }
        }

        //只要是状态为“已完成”,“换货”时，10天（240小时）后款项到卖家账户。
//        $time = $now-3600*24*10;//10天之前的订单，打款给卖家
        $time = $now-60*2;//10天之前的订单，打款给卖家
        //确认收货的订单打款给卖家
        $orders = M('order')->field('id,order_no,is_coupon,coupon_price,total_price,actual_price,sid')->where('id in (select order_id from '.C('DB_PREFIX').'order_status where type in (3,7) and create_time <= '.$time.') and status in (5,7) and is_over = 0')->select();
        foreach($orders as $order){
            $uid = M('supplier')->where('id='.$order['sid'])->getField('uid');
            $this->shop_db->startTrans();
            if($order['is_coupon'] == 1){
                $order['total_price'] = floatval($order['total_price']) - floatval($order['coupon_price']);
            }
            M('user')->where('uid='.$uid)->setInc('balance',$order['total_price']);
            account_log($uid,$order['total_price'],"定时任务，10天之前的订单打款给卖家，订单No：".$order['order_no']);
            M('order')->where('id='.$order['id'])->save(array('is_over'=>1));
            $this->shop_db->commit();
        }

        //拒绝的退货订单,给卖家打款
        $orders = M('order')->field('id,order_no,is_coupon,coupon_price,total_price,return_price,actual_price,sid')->where('id in (select order_id from '.C('DB_PREFIX').'order_status where type=6 and create_time <= '.$time.') and status = 6 and is_over = 0')->select();
        $isOver = true;
        foreach($orders as $order){
            $uid = M('supplier')->where('id='.$order['sid'])->getField('uid');
            //查询订单商品
            $orderGoods = M('order_goods')->where('order_id='.$order['id'])->select();
            foreach($orderGoods as $goods){
                $goods['price'] = floatval($goods['price']) * intval($goods['buy_count']);
                $back = M('order_back')->where(array('order_id'=>$order['id'],'goods_id'=>$goods['goods_id']))->find();
                $deduction = floatval($order['total_price'])-floatval($order['return_price'])-floatval($order['coupon_price']);
                if($deduction >= floatval($goods['price'])){
                    $deduction = $goods['price'];
                }
                //如果该商品没有退货，打款给卖家
                if(empty($back)){
                    $this->shop_db->startTrans();
                    M('user')->where('uid='.$uid)->setInc('balance',$deduction);
                    account_log($uid,$deduction,"定时任务，商品没有退货，打款给卖家，订单No：".$order['order_no']);
                    M('order')->where('id='.$order['id'])->save(array('is_over'=>1));
                    $this->shop_db->commit();
                }else{
                    //拒绝退货，打款给卖家
                    if($back['status'] == 2){
                        $this->shop_db->startTrans();
                        M('user')->where('uid='.$uid)->setInc('balance',$deduction);
                        account_log($uid,$deduction,"定时任务，10天之前的订单，有售后但为拒绝退货，打款给卖家，订单No：".$order['order_no']);
                        M('order')->where('id='.$order['id'])->save(array('is_over'=>1));
                        $this->shop_db->commit();
                    }else{//如果有同意退货的商品，则不扣除优惠券抵扣的金额
                        $isOver = false;
                    }
                }
            }
            if($isOver){
                if($order['is_coupon']){
                    M('user')->where('uid='.$uid)->setDec('balance',$order['coupon_price']);
                    $suppBalan = M('user')->where('uid='.$uid)->getField("balance");
                    if(floatval($suppBalan) < 0){
                        //发送私信，提示卖家余额不足
                        $content = "您好，您的账户余额已不足，请及时充值，以免影响正常销售！";
                        $message = new \Message\Model\MessageModel();
                        $tag = getMillisecond();
                        $return = $message->message('10000000',"管理员",$uid,$content,$tag);
                    }
//                    account_log($uid,$order['coupon_price'],"定时任务，同意退货，扣除商家优惠券抵扣的金额",1);
                }
            }
        }

        //退货退款：卖家15天（360小时）未处理：则自动为“同意”，且扣减卖家余额，增加买家余额
        //（如卖家余额还未到账则不再到账，而直接增加买家余额即完成）；
//        $time = $now-3600*24*15;//15天之前
        $time = $now-60*3;//15天之前
        //确认收货的订单打款给卖家
        $orders = M('order')->field('id,order_no,uid,is_coupon,coupon_price,total_price,return_price,actual_price,sid,is_over')->where('id in (select order_id from '.C('DB_PREFIX').'order_status where type=6 and create_time <= '.$time.') and status = 6')->select();
        foreach($orders as $order){
            $uid = M('supplier')->where('id='.$order['sid'])->getField('uid');
            //查询订单商品
            $orderGoods = M('order_goods')->where('order_id='.$order['id'])->select();
            foreach($orderGoods as $goods){
                $goods['price'] = floatval($goods['price']) * intval($goods['buy_count']);
                $back = M('order_back')->where(array('order_id'=>$order['id'],'goods_id'=>$goods['goods_id']))->find();
                if(!empty($back)){
                    if($back['status'] == 0){//退货未处理
                        $this->shop_db->startTrans();
                        M('order_back')->where(array('order_id'=>$order['id'],'goods_id'=>$goods['goods_id']))->save(array('status'=>3));
                        $deduction = floatval($order['total_price'])-floatval($order['return_price'])-floatval($order['coupon_price']);
                        if($deduction >= floatval($goods['price'])){
                            $deduction = $goods['price'];
                        }
                        if($order['is_over'] == 1){
                            M('user')->where('uid='.$uid)->setDec('balance',$deduction);
                            $suppBalan = M('user')->where('uid='.$uid)->getField("balance");
                            if(floatval($suppBalan) < 0){
                                //发送私信，提示卖家余额不足
                                $content = "您好，您的账户余额已不足，请及时充值，以免影响正常销售！";
                                $message = new \Message\Model\MessageModel();
                                $tag = getMillisecond();
                                $return = $message->message('10000000',"管理员",$uid,$content,$tag);
                            }
                            account_log($uid,$deduction,"定时任务，15天未处理退款，自动退款，订单No：".$order['order_no'],1);
                        }
                        M('user')->where('uid='.$order['uid'])->setInc('balance',$deduction);
                        account_log($order['uid'],$deduction,"定时任务，15天未处理退款，自动退款给买家，订单No：".$order['order_no']);
                        M('order')->where('id='.$order['id'])->setInc('return_price',$deduction);
                        $this->shop_db->commit();
                    }
                }
            }
        }

        //换货：卖家15天（360小时）未处理，则自动为“同意”
        //确认收货的订单打款给卖家
        $orders = M('order')->field('id,uid,is_coupon,coupon_price,total_price,actual_price,sid,is_over')->where('id in (select order_id from '.C('DB_PREFIX').'order_status where type=7 and create_time <= '.$time.') and status = 7')->select();
        foreach($orders as $order){
            //查询订单商品
            $orderGoods = M('order_goods')->where('order_id='.$order['id'])->select();
            foreach($orderGoods as $goods){
                $back = M('order_back')->where(array('order_id'=>$order['id'],'goods_id'=>$goods['goods_id']))->find();
                if(!empty($back)){
                    if($back['status'] == 0){//换货未处理
                        M('order_back')->where(array('order_id'=>$order['id'],'goods_id'=>$goods['goods_id']))->save(array('status'=>1));
                    }
                }
            }
        }
    }
}