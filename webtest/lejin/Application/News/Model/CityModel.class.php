<?php
/**
 * 城市列表
 */
namespace News\Model;
use Think\Model;
class CityModel extends Model {
    protected $tableName 	= 'city';
	protected $pk        	= 'id';
	
	/**
	 * 城市列表
	 * @param string $order
	 * @return multitype:|unknown
	 */
	function public_list($order='sort asc'){
	    $list  = $this->alias('u')->order($order)->select();
		if (!$list) return array();
		return $list;
	}
	/**
	 * 城市列表
	 */
	function lists(){
	    $list = self::public_list();
	    return showData($list);
	}
}