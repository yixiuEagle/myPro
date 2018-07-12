<?php
/**
 * 临时会话
 * @author yangdong
 *
 */
namespace Session\Controller;
use Admin\Controller\CommonController;
use Session\Model\SessionModel;
use User\Model\UserModel;
class SessionController extends CommonController {
	private $session_db;
	function _initialize(){
		parent::_initialize();
		$this->session_db = new SessionModel();
	}
	/**
	 * 会话列表
	 * @param number $page
	 * @param number $rows
	 * @param unknown $search
	 */
function index($page=1, $rows=10, $search = array()){
		if (IS_POST) {
			$map   = array();
			if ($search) {
				if ($search['name']){
					$map['name'] = array('like','%'.$search['name'].'%');
				}
			}
			$limit = ($page - 1) * $rows . "," . $rows;
			$total = $this->session_db->where($map)->count();
			$list  = $this->session_db->where($map)->limit($limit)->select();
			$user=new UserModel();
			$session_user=M('session_user');
			foreach ($list as $key=>$value){
			    $data=$user->where(array('uid'=>$value['uid']))->find();
			    $list[$key]['creator']=$data['nickname'];
			    $count=$session_user->where(array('sessionid'=>$value['id']))->count();
				$list[$key]['count']=$count;
				//格式化时间
				$list[$key]['createtime'] = date('Y-m-d H:i', $value['createtime']);
			}
			$this->ajaxReturn(array('total'=>$total, 'rows'=>$list));
		}else {
			$this->currentpos = $this->menu_db->currentPos(I('menuid'));  //栏目位置
			$this->display('list');
		}
	}
	/**
	 * 编辑
	 * @param number $id
	 */
	function edit($id=0){
		if (IS_POST) {
		    $name=I('name','');
		    if(!$name){$this->error('请输入要修改的会话名称');}
			$return = M('session')->where(array('id'=>$id))->setField('name', $name);
			if ($return) {
				$this->success('修改成功');
			}else {
				$this->error('修改失败');
			}
		}else {
// 			$this->info = $this->session_db->public_list(0, array('id'=>$id), 1);
// 			$this->rand = I('rand');
			$data=$this->session_db->where(array('id'=>$id))->find();
			$user=M('user')->where(array('uid'=>$data['uid']))->find();
			$count=M('session_user')->where(array('sessionid'=>$data['id']))->count();
		    $info=array(
		        'id'=>$data['id'],
		        'name'=>$data['name'],
		        'createtime'=>$data['createtime'],
		        'creator'=>$user['nickname'],
		        'count'=>$count
		    );
			$this->assign('info',$info);
			$this->display('edit');
		}
	}
	/**
	 * 删除
	 * @param number $id
	 */
	function delete($id=0){
		$return = $this->session_db->deleteSession(I('uid'), $id);
		if ($return['code']) {
			$this->error($return['msg']);
		}else {
			$this->success($return['msg']);
		}
	}
}