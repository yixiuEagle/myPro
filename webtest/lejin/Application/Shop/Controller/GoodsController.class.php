<?php
namespace Shop\Controller;
use Admin\Controller\CommonController;
use Shop\Model\GoodsModel;

class GoodsController extends CommonController {
	private $goods_db;
	function _initialize(){
		parent::_initialize();
		$this->goods_db = new GoodsModel();
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
					$map['g.name'] = array('like','%'.$search['name'].'%');
				}
			}
			$limit = ($page - 1) * $rows . "," . $rows;
			$total = $this->goods_db->alias("g")->where($map)->count();
			$list  = $total ? $this->goods_db->public_list(0, $map, $limit) : array();
			$this->ajaxReturn(array('total'=>$total, 'rows'=>$list));
		}else {
			$this->currentpos = $this->menu_db->currentPos(I('menuid'));  //栏目位置
			$this->display('list');
		}
	}
    function delete(){
        $id = I('id');
        $goods = M('goods')->where(array("id"=>$id))->find();
        $goods_gallery = M('goods_gallery')->where(array("goods_id"=>$id))->select();
        unlink('.'.$goods['smallUrl']);
        unlink('.'.$goods['originUrl']);
        foreach($goods_gallery as $pic){
            unlink('.'.$pic['smallUrl']);
            unlink('.'.$pic['originUrl']);
        }
        if(M('goods')->where(array("id"=>$id))->delete()){
            M('goods_gallery')->where(array("goods_id"=>$id))->delete();
            $this->success('删除成功');
        }
        $this->error('删除失败');
    }
}