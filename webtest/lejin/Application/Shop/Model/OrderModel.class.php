<?php
namespace Shop\Model;
use Think\Model;
use Lincense\Controller\Thinkchat;
class OrderModel extends Model {
	protected $tableName = 'order';
	protected $pk        = 'id';
	
	protected $map = array();
	
	/**
	 * 格式化
	 */
	private function _format($list, $uid=0){
		$_list = array();
		foreach ($list as $k=>$v){
			$tmp['id']		  	= $v['id'];
			$tmp['name']		  	= $v['name'];
			$tmp['order_no']	  	= $v['order_no'];
			$tmp['status']	  	= $v['status'];
			$tmp['total_price']	  	= $v['total_price'];
			$tmp['coupon_price']	  	= $v['coupon_price'];
			$tmp['balances_price']	  	= $v['balances_price'];
			$tmp['actual_price']	  	= $v['actual_price'];
			$tmp['shipping_address']	  	= $v['shipping_address'];
			$tmp['remark']	  	= $v['remark'];
			$tmp['create_time']	= date('Y-m-d',intval($v['create_time']));

			$_list[]	= $tmp;
		}
		return $_list;
	}
	/**
	 * 列表
	 */
	public function public_list($uid, $map, $limit, $order='create_time desc'){
		$field    = 'o.*,u.name';
        $join = 'left join '.$this->tablePrefix.'user u on o.uid=u.uid';
		$list  	  = $this->alias('o')->field($field)->join($join)->where($map)->order($order)->limit($limit)->select();
		$_list 	  = $this->_format($list,$uid);
		if ($limit == 1) {
			return $_list['0'];
		}else {
			return $_list;
		}
	}
}