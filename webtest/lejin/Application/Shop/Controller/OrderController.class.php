<?php
namespace Shop\Controller;
use Admin\Controller\CommonController;
use Shop\Model\OrderModel;

class OrderController extends CommonController {
	private $order_db;
	function _initialize(){
		parent::_initialize();
		$this->order_db = new OrderModel();
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
					$map['u.name'] = array('like','%'.$search['name'].'%');
				}
			}
			$limit = ($page - 1) * $rows . "," . $rows;
            $join = 'left join '.C('DB_PREFIX').'user u on o.uid=u.uid';
			$total = $this->order_db->alias("o")->join($join)->where($map)->count();
			$list  = $total ? $this->order_db->public_list(0, $map, $limit) : array();
			$this->ajaxReturn(array('total'=>$total, 'rows'=>$list));
		}else {
			$this->currentpos = $this->menu_db->currentPos(I('menuid'));  //栏目位置
			$this->display('list');
		}
	}
    function delete(){
        $id = I('id');
        if(M('order')->where(array("id"=>$id))->delete()){
            M('order_goods')->where(array("order_id"=>$id))->delete();
            $this->success('删除成功');
        }
        $this->error('删除失败');
    }
}