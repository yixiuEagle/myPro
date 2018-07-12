<?php
/**
 * 临时会话
 * @author yangdong
 *
 */
namespace Session\Controller;
use Admin\Controller\CommonController;
use Session\Model\SessionModel;
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
			$list  = $total ? $this->session_db->public_list(0, $map, $limit) : array();
			foreach ($list as $key=>$value){
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
			$return = $this->session_db->editSession(I('uid'), $id);
			if ($return['code']) {
				$this->error($return['msg']);
			}else {
				$this->success('修改成功');
			}
		}else {
			$this->info = $this->session_db->public_list(0, array('id'=>$id), 1);
			$this->rand = I('rand');
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