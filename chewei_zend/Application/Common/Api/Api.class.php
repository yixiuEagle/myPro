<?php
namespace Common\Api;
use Think\Controller;
use User\Model\UserModel;
use Think\Log;

class Api extends Controller {
    protected $user_db;
    protected $mid;
    function _initialize() {
    	
    	if(C('LOG_REQUEST_ARGUMENT')){
    		Log::write("request=" . json_encode($_REQUEST));
    	}
    	
    	if(C('APP_CHECK_URL_SAFE'))
        	self::checkToken();
        $this->user_db = new UserModel();
        $this->mid       = trim(I('uid', 0));
    }
    
    /**
     * token验证
     */
    function checkToken(){
        $data      = $_REQUEST;
        $token     = trim(I('_checksum'));
        $checkTime = trim(I('_checktime'));
        unset($data['_checksum']);         //去掉token
        unset($data['_checktime']);    //去掉check_time
        ksort($data);//升序排列
        $string = '_checktime='.$checkTime;
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
        if (!$this->user_db->where(array('uid'=>$this->mid))->count()){
            $data = showData(new \stdClass(), '用户不存在', 1, '', '用户uid不存在或uid为空');
            $this->jsonOutput($data);
        }
    }
    /**
     * 初始化用户
     * @param int $uid
     * @return string
     */
    function _initUser($uid){
        $count = $this->user_db->where(array('uid'=>$this->mid))->count();
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
        $status = array('code' => $data['code'],'msg'=> $data['msg']);
        if (APP_DEBUG) {
            $status['debugMsg'] = $data['debugMsg'];
            $status['url']      = MODULE_NAME.'/'.CONTROLLER_NAME . '/' . ACTION_NAME;
        }else {
            $status['debugMsg'] = '';
            $status['url']      = '';
        }
        $json = array('data' => $data['data'],'state' => $status);
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
        $json = utf8_to_urlencode($json);
        $json = urldecode(json_encode($json));
        exit ( $json );
    }
    function getRandChar($length){
        $str = null;
        $strPol = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789abcdefghijklmnopqrstuvwxyz";
        $max = strlen($strPol)-1;
    
        for($i=0;$i<$length;$i++){
            $str.=$strPol[rand(0,$max)];//rand($min,$max)生成介于min和max两个数之间的一个随机整数
        }
    
        return $str;
    }
}