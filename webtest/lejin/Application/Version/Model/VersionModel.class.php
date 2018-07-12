<?php
namespace Version\Model;
use Think\Model;
class VersionModel extends Model {
	protected $tableName = 'version';
	protected $pk        = 'id';
	
	function _list($map, $limit, $order='createtime desc'){
		return $this->where($map)->order($order)->limit($limit)->select();
	}
	/**
	 * 版本升级更新
	 * @return array();
	 */
	function getVersion(){
	    
		$version = I("version", "0");
		$result = M('version')->where("version>" . $version )->order("id asc")->limit(1)->find();
		if($result)
		 	return showData($result);
		else 
			return showData(new \stdClass(), "没有新版本", 1);
	}	
}