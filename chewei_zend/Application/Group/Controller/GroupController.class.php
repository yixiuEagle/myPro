<?php
namespace Group\Controller;
use Admin\Controller\CommonController;
use Group\Model\GroupModel;

class GroupController extends CommonController {
	private $group_db;
	function _initialize(){
		parent::_initialize();
		$this->group_db = new GroupModel();
	}
	/**
	 * 群组列表
	 * @param number $page
	 * @param number $rows
	 * @param unknown $search
	 */
	function index($page=1, $rows=10, $search=array()){
		if (IS_POST) {
			$map = array();
			if ($search) {
				if ($search['name']) {
					$map['name'] = array('like','%'.$search['name'].'%');
				}
				if ($search['audit'] < 3) {
					$map['audit'] = $search['audit'];
				}
			}
			$limit = ($page - 1) * $rows . "," . $rows;
			$total = $this->group_db->where($map)->count();
			$list  = $total ? $this->group_db->public_list(0, $map, $limit) : array();
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
	 * 审核通过
	 */
	function auditPass(){
		$data   = array('audit'=>I('audit'), 'id'=>I('id'));
		$return = $this->group_db->groupAudit($data);
		if (!$return['code']) {
			$this->success($return['msg']);
		}else {
			$this->error($return['msg']);
		}
	}
	/**
	 * 审核未通过
	 */
	function auditNopass($id=0){
		if (IS_POST) {
			$data = I('info');
			$data['audit'] = 2;
			$return = $this->group_db->groupAudit($data);
			if (!$return['code']) {
				$this->success($return['msg']);
			}else {
				$this->error($return['msg']);
			}
		}else {
			$this->rand = I('rand');
			$this->id   = $id;
			$this->display('nopass');
		}
	}
	/**
	 * 编辑
	 * @param number $id
	 */
	function edit($id=0){
		if (IS_POST) {
			$data = I('info');
			$return = $this->group_db->editGroup($data['uid'], $data['id']);
			if (!$return['code']) {
				$this->success($return['msg']);
			}else {
				$this->error($return['msg']);
			}
		}else {
			$this->rand = I('rand');
			$this->info = $this->group_db->public_list(0, array('id'=>$id), 1);
			$this->display('edit');
		}
	}
	/**
	 * 删除
	 * @param number $id
	 */
	function delete($id=0){
		$return = $this->group_db->deleteGroup(I('uid'), $id);
		if (!$return['code']) {
			$this->success($return['msg']);
		}else {
			$this->error($return['msg']);
		}
	}
	/**
	 * 上传群组logo图片
	 */
	function public_uploadGroupPicture(){
		$image = upload('/Picture/group/', 0, 'group');
		if (is_array($image)){
			$this->ajaxReturn(array('info'=>'success', 'url'=>$image['0']['smallUrl'], 'status'=>1, 'show'=>C('HTTP_URL').$image['0']['smallUrl']));
		}else {
			$this->error($image);
		}
	}
}