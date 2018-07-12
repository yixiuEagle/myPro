<?php
namespace Shop\Model;
use Think\Model;
use Lincense\Controller\Thinkchat;
class GoodsModel extends Model {
	protected $tableName = 'goods';
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
			$tmp['shop_name']	  	= $v['shop_name'];
			$tmp['smallUrl']	  	= site_url($v['smallUrl']);
			$tmp['profile']	  	= $v['profile'];
			$tmp['create_time']	= date('Y-m-d',intval($v['create_time']));

			$_list[]	= $tmp;
		}
		return $_list;
	}
	/**
	 * 列表
	 */
	public function public_list($uid, $map, $limit, $order='create_time desc'){
		$field    = 'g.*,s.shop_name';
        $join = 'left join '.$this->tablePrefix.'supplier s on g.sid=s.id';
		$list  	  = $this->alias('g')->field($field)->join($join)->where($map)->order($order)->limit($limit)->select();
		$_list 	  = $this->_format($list,$uid);
		if ($limit == 1) {
			return $_list['0'];
		}else {
			return $_list;
		}
	}
}