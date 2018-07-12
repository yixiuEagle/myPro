<?php
namespace Common\Api;
use Think\Controller;
use User\Model\UserModel;
use Think\Log;

class Api extends Controller {
    protected $user_db;
    protected $mid;
    function _initialize() {
        //self::checkToken();
        $this->user_db = new UserModel();
        $this->mid       = trim(I('uid', 0));
    }
    
    /**
     * token验证
     */
    function checkToken(){
        $data      = $_REQUEST;
        $token     = trim(I('check_sum'));
        $checkTime = trim(I('check_time'));
        unset($data['check_sum']);         //去掉token
        unset($data['check_time']);    //去掉check_time
        ksort($data);//升序排列
        $string = 'check_time='.$checkTime;
        foreach ($data as $k=>$v){
            $string .= '&' . $k.'='.$v;
        }
        if ($token != md5($string)){
            $info = showData(new \stdClass(), '请求无效', 3, '', 'token验证失败');
            $this->jsonOutput($info);
        }
    }
    /**
     * 空操作，用于输出404页面
     */
    public function _empty(){
        $data = showData(new \stdClass(), '该地址不存在', 404);
        $this->jsonOutput($data);
    }
    /**
     * 检测是否登录
     */
    function isLogin(){
    	$user = M('user')->where(array('uid'=>$this->mid))->find();
        if (!$user){
            $data = showData(new \stdClass(), '用户不存在', 1, '', '用户uid不存在或uid为空');
            $this->jsonOutput($data);
        }
        
         if($user['isshield'] == 1){
        	$data = showData(new \stdClass(), '您已被系统屏蔽了，无法再使用。如果有任何疑问，可以使用【我的-设置-帮助中心-反馈意见】APP反馈问题给我们。', 1, '', '用户被禁止使用');

        	$this->jsonOutput($data);
        } 
    }
    /**
     * 初始化用户
     * @param int $uid
     * @return string
     */
    function _initUser($uid){
        $count = $this->user_db->where(array('uid'=>$uid))->count();
        if ($count) {
            return $uid;
        }else {
            $data = showData(new \stdClass(),'该用户不存在',1);
            $this->jsonOutput($data);
        }
    }
    /**
     * 输出json数据
     * @param array $data
     * @return string
     */
    function jsonOutput($data){
        //header('Content-Type: text/html; charset=utf-8');
        header('Content-Type: application/json; charset=utf-8');
        header('Access-Control-Allow-Origin:*');
        $status = array('code' => $data['code'],'msg'=> $data['msg']);
        if (APP_DEBUG) {
            $status['debugMsg'] = $data['debugMsg'];
            $status['url']      = MODULE_NAME.'/'.CONTROLLER_NAME . '/' . ACTION_NAME;
        }else {
            $status['debugMsg'] = '';
            $status['url']      = '';
        }
        $json = array('data' => $data['data'],'state' => $status,'now_time'=>NOW_TIME);
        if ($data['page']){
            $newPage['total'] 		= $data['page']['total'];		//总条数
            $newPage['count'] 		= $data['page']['count'];		//返回记录的条数
            $newPage['pageCount'] 	= $data['page']['pageCount'];	//总页数
            $newPage['page'] 		= $data['page']['page'];		//当前页
            //如果下一页大于当前页
            if ($data['page']['page_next'] > $data['page']['page']) {
                $newPage['hasMore'] = 1;
            }else {
                $newPage['hasMore'] = 0;
            }
            $json['pageInfo'] = $newPage;
        }
        exit ( json_encode($json) );
    }
}