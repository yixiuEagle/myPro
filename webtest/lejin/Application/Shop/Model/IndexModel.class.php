<?php
namespace Shop\Model;
use Think\Model;
use Lincense\Controller\Thinkchat;
class IndexModel extends Model {
	protected $tableName = 'supplier';
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
			$tmp['phone']	  	= $v['phone'];
			$tmp['address']	  	= $v['address'];
			$tmp['cat_name']	  	= $v['cat_name'];
			$tmp['status']		= $v['status'];
			$tmp['create_time']	= date('Y-m-d',intval($v['create_time']));

            $supplier_gallery = M("supplier_gallery")->where(array('sid'=>$tmp['id']))->field("smallUrl,originUrl")->select();
            foreach($supplier_gallery as $k => $g){
                $tmp['smallUrl'.$k] = site_url($g['smallUrl']);
                $tmp['originUrl'.$k] = site_url($g['originUrl']);
            }
			$_list[]	= $tmp;
		}
		return $_list;
	}
	/**
	 * 列表
	 */
	public function public_list($uid, $map, $limit, $order='create_time desc'){
		$field    = 's.*,sc.name as cat_name';
        $join = 'left join '.$this->tablePrefix.'share_category sc on s.cat_id=sc.id';
		$list  	  = $this->alias('s')->field($field)->join($join)->where($map)->order($order)->limit($limit)->select();
		$_list 	  = $this->_format($list,$uid);
		if ($limit == 1) {
			return $_list['0'];
		}else {
			return $_list;
		}
	}
}