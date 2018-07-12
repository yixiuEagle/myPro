<?php
namespace User\Controller;
use Admin\Controller\CommonController;
use User\Model\UserModel;

class UserController extends CommonController {
	private $user_db;
	function _initialize(){
		parent::_initialize();
		$this->user_db = new UserModel();
	}
	/**
	 * 用户列表
	 * @param number $page
	 * @param number $rows
	 * @param array  $search
	 */
	function index($page=1, $rows=10, $search = array()){
		if (IS_POST){
			$map   = array();
			if ($search) {
				if ($search['name']){
					$map['name'] = array('like','%'.$search['name'].'%');
				}
                if(intval($search['account']) == 1){
                    $map['balance'] = array('egt','0');
                }
                if(intval($search['account']) == 2){
                    $map['balance'] = array('lt','0');
                }
			}
			$limit = ($page - 1) * $rows . "," . $rows;
			$total = $this->user_db->where($map)->count();
			$list  = $total ? $this->user_db->public_list(0, $map, $limit) : array();
			$this->ajaxReturn(array('total'=>$total, 'rows'=>$list));
		}else {
			$this->currentpos = $this->menu_db->currentPos(I('menuid'));  //栏目位置
			$this->display('list');
		}
	}
	/**
	 * 账户异常用户列表
	 * @param number $page
	 * @param number $rows
	 * @param array  $search
	 */
	function ex_user_list($page=1, $rows=10, $search = array()){
		if (IS_POST){
			$map   = array();
			if ($search) {
				if ($search['name']){
					$map['name'] = array('like','%'.$search['name'].'%');
				}
			}
            $map['balance'] = array('lt','0');
			$limit = ($page - 1) * $rows . "," . $rows;
			$total = $this->user_db->where($map)->count();
			$list  = $total ? $this->user_db->public_list(0, $map, $limit) : array();
			$this->ajaxReturn(array('total'=>$total, 'rows'=>$list));
		}else {
			$this->currentpos = $this->menu_db->currentPos(I('menuid'));  //栏目位置
			$this->display('ex_list');
		}
	}
	/**
	 * 编辑
	 * @param unknown $uid
	 */
	function edit($uid=0){
		if (IS_POST) {
			$data = I('info');
			if (!$data['headsmall']) unset($data['headsmall']);
			if ($this->user_db->where(array('uid'=>$uid))->save($data)){
				$this->success('编辑成功');
			}else {
				$this->error('编辑失败');
			}
		}else {
			$this->info = $this->user_db->public_list($uid, array('uid'=>$uid), 1);
			$this->rand = I('rand');
			$this->display('edit');
		}
	}
	/**
	 * 删除
	 * @param unknown $uid
	 */
	function delete($uid){
		$this->error('用户uid='.$uid);
	}
	/**
	 * @param unknown $uid
	 */
	function add100($uid){
		M("user")->where(array("uid"=>$uid))->setInc("balance",100);
        account_log($uid,100,"后台充值100元");
        $this->success('充值成功');
	}
	/**
	 * 用户消费明细
	 */
    function account_log($page=1, $rows=10, $search = array()){
        if (IS_POST){
            $map   = array();
            $uid  = $_REQUEST['uid'];
            $map['uid'] = $uid;
            $limit = ($page - 1) * $rows . "," . $rows;
            $total = M('user_account_log')->where($map)->count();
            $list  = $total ? M('user_account_log')->where($map)->limit($limit)->order('create_time desc')->select() : array();
            foreach ($list as &$item){
                if($item['type'] == 0){
                    $item['type'] = "增加";
                }else{
                    $item['type'] = "减少";
                }
                $item['create_time'] = date('Y-m-d H:i:s',$item['create_time']);
            }
            $this->ajaxReturn(array('total'=>$total, 'rows'=>$list));
        }else {
            $this->display('account_log');
        }
    }
	/**
	 * 昵称相同
	 * @param unknown $email
	 */
	function public_checkNickname($nickname){
		if (I('default') == $nickname) {
			$this->error('昵称相同');
		}
		$exists = $this->user_db->where(array('nickname'=>$nickname))->field('nickname')->find();
		if ($exists) {
			$this->success('昵称存在');
		}else{
			$this->error('昵称不存在');
		}
	}
	/**
	 * 上传头像
	 * @param unknown $uid
	 */
	function public_uploadHead($uid=0){
		$data = upload('/Picture/avatar/', $uid, 'user');
		if (is_string($data)) {
			$this->ajaxReturn(array('info'=>$data, 'status'=>0));
		}else {
			$this->ajaxReturn(array('info'=>'上传成功', 'url'=>$data['0']['smallUrl'], 'status'=>1));
		}
	}

    /**
     * 提现列表
     * @param int $page
     * @param int $rows
     * @param array $search
     */
	function extract($page=1, $rows=10, $search = array()){
        if (IS_POST){
            $map   = array();
            if ($search) {
                if ($search['name']){
                    $map['u.name'] = array('like','%'.$search['name'].'%');
                }
            }
            $limit = ($page - 1) * $rows . "," . $rows;
            $total = M('withdraw')->alias("w")->join("left join ".C('DB_PREFIX')."user u on w.uid=u.uid")->where($map)->count();
            $list  = $total ? $this->user_db->extract_list($map, $limit) : array();
            foreach ($list as &$item){
                $item['create_time'] = date('Y-m-d H:i:s',$item['create_time']);
            }
            $this->ajaxReturn(array('total'=>$total, 'rows'=>$list));
        }else {
            $this->currentpos = $this->menu_db->currentPos(I('menuid'));  //栏目位置
            $this->display('extract');
        }
    }
    /**
     * 提现审核
     * @param unknown $uid
     */
    function extractCheck($id,$status){
        $withdraw = M('withdraw')->where(array('id'=>$id))->find();
//        $balance = M('user')->where(array('uid'=>$withdraw['uid']))->getField('balance');
//        if($balance < $withdraw['price'] && $status == 1){
//            $this->success('余额不足，审核失败');
//        }
        M('withdraw')->where(array('id'=>$id))->save(array('status'=>$status));
        $content = "您好！您的提现平台已处理，请注意查收！";
        if($status == 2){
            M('user')->where(array('uid'=>$withdraw['uid']))->setInc('balance',$withdraw['price']);
            $content = "您好！您本次提现未处理成功，相应金额已退回到您的余额中";
        }
        $message = new \Message\Model\MessageModel();
        $tag = getMillisecond();
        $return = $message->message('10000000',"管理员",$withdraw['uid'],$content,$tag);
        $this->success('操作成功');
    }
}