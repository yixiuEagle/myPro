<?php
namespace Shop\Controller;
use Admin\Controller\CommonController;
use Shop\Model\IndexModel;

class IndexController extends CommonController {
	private $index_db;
	function _initialize(){
		parent::_initialize();
		$this->index_db = new IndexModel();
	}
	/**
	 * 列表
	 * @param number $page
	 * @param number $rows
	 * @param unknown $search
	 */
	function index($page=1, $rows=10, $search=array()){
		if (IS_POST) {
			$map = array();
			if ($search) {
				if ($search['name']) {
					$map['s.name'] = array('like','%'.$search['name'].'%');
				}
                if ($search['audit'] || $search['audit'] == 0) {
                    $map['status'] = $search['audit'];
                }
			}
			$limit = ($page - 1) * $rows . "," . $rows;
			$total = $this->index_db->alias("s")->where($map)->count();
			$list  = $total ? $this->index_db->public_list(0, $map, $limit) : array();
			$this->ajaxReturn(array('total'=>$total, 'rows'=>$list));
		}else {
			$this->currentpos = $this->menu_db->currentPos(I('menuid'));  //栏目位置
			$this->display('list');
		}
	}
    function audit(){
        $id = I('id');
        $status = I('status');
        if($status != 1 && $status != 2){
            $this->error('审核失败');
        }
        $row = M('supplier')->where(array("id"=>$id))->save(array("status"=>$status));
        if($row){
            $this->success('审核成功');
        }
        $this->error('审核失败');
    }
}