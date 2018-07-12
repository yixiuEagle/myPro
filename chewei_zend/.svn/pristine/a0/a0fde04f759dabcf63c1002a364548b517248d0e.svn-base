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
					$map['nickname'] = array('like','%'.$search['name'].'%');
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
	 * 编辑
	 * @param unknown $uid
	 */
	function edit($uid=0){
		if (IS_POST) {
			$data = I('info');
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
		if(IS_POST){
		    $where=array('uid'=>$uid);
		    $data=M('user')->where($where)->delete();
		    if($data){
		        $this->success('删除成功');
		    }else{
		        $this->error('删除失败');
		    }
		}
	}
	/**
	 * 提现审核列表
	 */
	function verify_receiveList($page=0,$rows=10,$search=array()){
	    if(IS_POST){
	        $map   = array('status'=>0);
	        if ($search) {
	            if ($search['name']){
	                $map['uid'] = array('eq',$search['name']);
	            }
	        }
	        $limit = ($page - 1) * $rows . "," . $rows;
	        $total = M('receive')->where($map)->count();
	        $list  = $total ? M('receive')->where($map)->limit($limit)->order('createtime desc')->select() : array();
	        foreach ($list as $k=>$v){
	            $list[$k]['createtime']=date('Y-m-d H:i',$v['createtime']);
	        }
	        $this->ajaxReturn(array('total'=>$total, 'rows'=>$list));
	    }
	    $this->currentpos = $this->menu_db->currentPos(I('menuid'));  //栏目位置
	    $this->display('verify_receiveList');
	}
	/**
	 * 提现申请记录列表 
	 */
	function receiveList($page=0,$rows=10,$search=array()){
	    if(IS_POST){
	        $map   = array();
	        if ($search) {
	            if ($search['name']){
	                $map['uid'] = array('eq',$search['name']);
	            }
	        }
	        $limit = ($page - 1) * $rows . "," . $rows;
	        $total = M('receive')->where($map)->count();
	        $list  = $total ? M('receive')->where($map)->limit($limit)->order('createtime desc')->select() : array();
	        foreach ($list as $k=>$v){
	             $list[$k]['createtime']=date('Y-m-d H:i',$v['createtime']);
	        }
	        $this->ajaxReturn(array('total'=>$total, 'rows'=>$list));
	    }
	    $this->currentpos = $this->menu_db->currentPos(I('menuid'));  //栏目位置
	    $this->display('receiveList');
	}
	/**
	 * 修改
	 * 提现成功
	 */
	function receiveEdit($id){
	   if(IS_POST&&$id){
		    $where=array('id'=>$id);
		    $data=M('receive')->where($where)->setField('status',1);
		    $receive=M('receive')->field('uid,fee')->where($where)->find();
		    $user=new UserModel();
		    //通知
		    $content='您已提现成功';
		    $re=$user->remsg($receive['uid'], $content, 1);
		    //消费记录
		    $user->consume_record($receive['uid'],3, $receive['fee']);//2购买
		    if($data){
		        $this->success('操作成功');
		    }else{
		        $this->error('操作失败');
		    }
		}
	}
	/**
	 * 
	 * 提现失败
	 */
	function receive_fail($id){
	    if(IS_POST&&$id){
	        $msg=I('msg','');
	        if($msg){
    	        $where=array('id'=>$id);
    	        //更改状态
    	        $data=M('receive')->where($where)->setField('status',2);
    	        $receive=M('receive')->field('uid,fee')->where($where)->find();
    	        //退回余额
    	        $li=M('user')->field('money')->where(array('uid'=>$receive['uid']))->find();
    	        $money['money']=$li['money']+$receive['fee'];
    	        M('user')->where(array('uid'=>$receive['uid']))->save($money);
    	        //发送通知
    	        $mone=$receive['fee'];
    	        $user=new UserModel();
    	        $content='您提现失败，原因是'.$msg.'。￥'.$mone.'已退回至您的余额。';
    	        $re=$user->remsg($receive['uid'], $content, 1);
    	        if($data&&$re){
    	            $this->success('操作成功');
    	        }else{
    	            $this->error('操作失败');
    	        }
	        }else{
	            $this->error('请填写提现失败原因!');
	        }
	    }
	    $list=M('receive')->where(array('id'=>$id))->find();
	    $this->assign('info',$list);
	    $this->display('receive_fail');
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
}