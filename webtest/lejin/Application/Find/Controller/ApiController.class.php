<?php
namespace Find\Controller;
use Common\Api\Api;
use Find\Model\FindModel;

class ApiController extends Api {
    protected $find_db;
	function _initialize(){
		parent::_initialize();
        $this->find_db = new FindModel();
	}

    /**
     * 创建活动
     * 1.活动，2.闲置资源
     */
    function createActivity(){
        self::isLogin();
        $data = array(
            'uid' => $this->mid,
            'title' => I('title'),
            'address' => I('address'),
            'start_time' => I('start_time'),
            'end_time' => I('end_time'),
            'fees_price' => I('fees_price',0),
            'type' => 1,
            'remark' => I('remark')
        );
        $return = $this->find_db->create($data);
        $this->jsonOutput($return);
    }

    /**
     * 创建闲置资源
     * 1.活动，2.闲置资源
     */
    function createSource(){
        self::isLogin();
        $data = array(
            'uid' => $this->mid,
            'title' => I('title'),
            'address' => I('address'),
            'start_time' => I('start_time'),
            'end_time' => I('end_time'),
            'fees_price' => I('fees_price'),
            'fees_type' => I('fees_type',0),
            'type' => 2,
            'remark' => I('remark')
        );
        $return = $this->find_db->create($data);
        $this->jsonOutput($return);
    }

    /**
     * 活动详情
     */
    function activityDetail(){
        self::isLogin();
        $data = array(
            'uid' => $this->mid,
            'activity_id' => I('activity_id'),
            'type' => 1
        );
        $return = $this->find_db->detail($data);
        $this->jsonOutput($return);
    }

    /**
     * 闲置资源详情
     */
    function sourceDetail(){
        self::isLogin();
        $data = array(
            'uid' => $this->mid,
            'activity_id' => I('source_id'),
            'type' => 2
        );
        $return = $this->find_db->detail($data);
        $this->jsonOutput($return);
    }

    /**
     * 报名
     */
    function sign(){
        self::isLogin();
        $data = array(
            'uid' => $this->mid,
            'name' => I('name'),
            'phone' => I('phone'),
            'activity_id' => I('activity_id')
        );
        $return = $this->find_db->sign($data);
        $this->jsonOutput($return);
    }

    /**
     * 活动列表
     */
    function activityList(){
        self::isLogin();
        $data = array(
            'uid' => $this->mid,
            'type' => I('type'),
            'data_type' => 1,
            'page' => I('page'),
            'pageSize' => I('pageSize')
        );
        $return = $this->find_db->dataList($data);
        $this->jsonOutput($return);
    }

    /**
     * 闲置资源列表
     */
    function sourceList(){
        self::isLogin();
        $data = array(
            'uid' => $this->mid,
            'type' => I('type'),
            'data_type' => 2,
            'page' => I('page'),
            'pageSize' => I('pageSize')
        );
        $return = $this->find_db->dataList($data);
        $this->jsonOutput($return);
    }

    /**
     * 发布活动评论
     */
    function activityComment(){
        self::isLogin();
        $data = array(
            'uid' => $this->mid,
            'activity_id' => I('activity_id'),
            'data_type' => 1,
            'content' => I('content')
        );
        $return = $this->find_db->dataComment($data);
        $this->jsonOutput($return);
    }

    /**
     * 发布闲置资源评论
     */
    function sourceComment(){
        self::isLogin();
        $data = array(
            'uid' => $this->mid,
            'activity_id' => I('source_id'),
            'data_type' => 2,
            'content' => I('content')
        );
        $return = $this->find_db->dataComment($data);
        $this->jsonOutput($return);
    }

    /**
     * 活动评论列表
     */
    function activityCommentList(){
        self::isLogin();
        $data = array(
            'uid' => $this->mid,
            'activity_id' => I('activity_id'),
            'data_type' => 1,
            'page' => I('page'),
            'pageSize' => I('pageSize')
        );
        $return = $this->find_db->dataCommentList($data);
        $this->jsonOutput($return);
    }

    /**
     * 闲置资源评论列表
     */
    function sourceCommentList(){
        self::isLogin();
        $data = array(
            'uid' => $this->mid,
            'activity_id' => I('source_id'),
            'data_type' => 2,
            'page' => I('page'),
            'pageSize' => I('pageSize')
        );
        $return = $this->find_db->dataCommentList($data);
        $this->jsonOutput($return);
    }

    /**
     * 支付
     */
    function pay(){
        self::isLogin();
        $data = array(
            'uid' => $this->mid,
            'pay_price' => I('pay_price'),
            'is_balance' => I('is_balance'),
            'activity_id' => I('activity_id')
        );
        $return = $this->find_db->pay($data);
        $this->jsonOutput($return);
    }
    /**
     * 支付订单回调
     */
    function notifyurl(){
        $alipay_config = C('mobilepay_config');
        $alipayNotify  = new \Common\Pay\AppAli\AlipayNotify($alipay_config);
        $verify_result = $alipayNotify->verifyNotify();
        if($verify_result) {//验证成功
            $out_trade_no  = $_POST['out_trade_no'];   //商户订单号
            $trade_no      = $_POST['trade_no'];       //支付宝交易号
            $trade_status  = $_POST['trade_status'];   //交易状态
            if($_POST['trade_status'] == 'TRADE_FINISHED') {

            } else if ($_POST['trade_status'] == 'TRADE_SUCCESS') {
                $db   = M('activity_sign');
                $info = $db->where(array('activity_id'=>$out_trade_no))->find();
                $db->where(array('id'=>$info['id']))->setField('status', 1);
                M('user')->where(array('uid'=>$info['uid']))->setDec('balance',$info['balance']);
                account_log($info['uid'],$info['balance'],"发现最开始的回调",1);
            }
            echo "success";		//请不要修改或删除
        }else {
            echo "fail";//验证失败
        }
    }

    /**
     * 搜索
     * 1活动、2资源、3商品、4商家、5用户、6号、7群
     */
    function search(){
        self::isLogin();
        $data = array(
            'uid' => $this->mid,
            'search' => I('search'),
            'type' => I('type'),
            'page' => I('page'),
            'pageSize' => I('pageSize'),
            'mylat' =>I('lat'),
            'mylng' =>I('lng')
        );
        if (!$data['search']) $this->jsonOutput(showData(new \stdClass(), '请输入搜索内容', 1));
        $where = array();
        $page = array();
        if($data['type'] == 1 || $data['type'] == 2){
            $where['a.title'] = array('like', '%'.$data['search'].'%');
            $where['a.type'] = $data['type'];
            $page = $this->navigation('activity_source','a',$where);
            $result = $this->find_db->public_list($data['uid'],$where,$page['limit'],'a.id asc',$data['type']);
            $return = showData($result,'',0,$page['page']);
        }
        if($data['type'] == 3){
            $where['g.name'] = array('like', '%'.$data['search'].'%');
            $page = $this->navigation('goods','g',$where);
            $goods = new \Shop\Model\ShopModel();
            $result = $goods->public_goods_list($data['uid'],$where,$page['limit']);
            $return = showData($result,'',0,$page['page']);
        }
        if($data['type'] == 4){
            $where['s.shop_name'] = array('like', '%'.$data['search'].'%');
            $page = $this->navigation('supplier','s',$where);
            $goods = new \Shop\Model\ShopModel();
            $result = $goods->public_list($data['uid'],$where,$page['limit']);
            $return = showData($result,'',0,$page['page']);
        }
        if($data['type'] == 5){
            $where['u.name|u.phone'] = array('like', '%'.$data['search'].'%');
            $page = $this->navigation('user','u',$where);
            $goods = new \User\Model\UserModel();
            $result = $goods->public_list($data['uid'],$where,$page['limit']);
            $return = showData($result,'',0,$page['page']);
        }
        if($data['type'] == 6){
            $where['u.name'] = array('like', '%'.$data['search'].'%');
            $page = $this->navigation('groups','u',$where);
            $groups = new \Share\Model\GroupModel();
            $result = $groups->public_list($data['uid'],$where,$page['limit']);
            foreach ($result as $k => $v){
                    $common=new \Common\Model\CommonModel();
                    $dis= $common->getDistance($mylat,$mylng,$v['lat'],$v['lng']);
                    $v['distance']=$dis;
                    $result[$k]=$v;
            }
            foreach($result as $k =>$v){
                $distance[$k] = $v['distance'];
            }
            array_multisort($distance, $result);
            $return = showData($result,'',0,$page['page']);
        }
        if($data['type'] == 7){
            $where['g.name'] = array('like', '%'.$data['search'].'%');
            $where['g.cat_id'] = array('neq',0);
            $page = $this->navigation('group','g',$where);
            $group = new \Group\Model\GroupModel();
            $result = $group->public_list($data['uid'],$where,$page['limit']);
            foreach ($result as $k => $v){
                $common=new \Common\Model\CommonModel();
                $dis= $common->getDistance($mylat,$mylng,$v['lat'],$v['lng']);
                $v['distance']=$dis;
                $result[$k]=$v;
            }
            foreach($result as $k =>$v){
                $distance[$k] = $v['distance'];
            }
            array_multisort($distance, $result);
            $return = showData($result,'',0,$page['page']);
        }
        $this->jsonOutput($return);
    }

    /**
     * 删除活动或资源
     */
    function delete(){
        self::isLogin();
        $data = array(
            'id' => I('id')
        );
        $return = $this->find_db->deleteRow($data);
        $this->jsonOutput($return);
    }

    function navigation($table,$alias,$where){
        $total = M($table)->alias($alias)->where($where)->count();
        if ($total){
            $page  = page($total);
            $limit = $page['offset'] . ',' . $page['limit'];
        }else {
            $page  = '';
        }
        return array('limit'=>$limit,'page'=>$page);
    }

}