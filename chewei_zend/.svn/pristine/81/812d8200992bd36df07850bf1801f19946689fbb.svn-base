<?php 
/**
 * ★公共的基础-模型层(ok)
 * @author nye  2016-12-22
 * 
 */ 
namespace Common\Model;
use Think\Model;
use Common\Api\Api;
class CommonModel extends Model{
	public $tableName='user'; 	// 参照物-基础表的名
	public $pk='uid';  			// 参照物-基础表的主键名
	function _initialize() {
		
	}
	

	/**
	 * 获取单条(ok)
	 * @param string $table
	 * @param string $where
	 * @param string $field
	 * @return Ambigous <\Think\mixed, boolean, NULL, multitype:, unknown, mixed, string, object>
	 */
	public function m_db_getone($table='',$where='',$field=''){
		$r = $this->table($this->tablePrefix.$table)->field($field)->where($where)->find();
		return $r;
	}
	
	
	/**
	 * 获取多条-(无分页) - OK
	 * @param string $table
	 * @param string $where
	 * @param string $field
 	 * @param string $order
 	 * @param string $group
	 * @return Ambigous <\Think\mixed, boolean, NULL, multitype:, unknown, mixed, string, object>
	 * @tutorial  动态解析
	 *  SELECT $field FROM  $table WHERE $where GROUP BY $group ORDER BY $order LIMIT $limit
	 * 例如:	 	
	    select * FROM app_user_cameraman_dq WHERE uid=4 AND createtime>3 GROUP BY createtime ORDER BY logid DESC LIMIT 0,2
	 */
	public function m_db_getlist($table='',$where='',$field='', $order='', $group=''){
		$r = $this->table($this->tablePrefix.$table)->field($field)->where($where)->group($group)->order($order)->select();
		return $r;
	}
	
	/**
	 * 获取多条-(有分页) - ok
	 * @param string $table  // 表名，支持取别名，支持内链其他表,注意 最前面不要表前缀; 如  user_cameraman_photo A INNER JOIN app_user B ON A.uid=B.uid
	 * @param string $where
	 * @param string $field
	 * @param string $order  // 排序
	 * @return array() showData()  // 含有分页的信息
	 * @tutorial
	 *  1.先查询满足条件的一共有多少条数据，2.然后根据 page信息 动态返回数据
	 *  3. 如果设置了currPage和pageSize，则获取该页数据
	 */
	public function m_db_getlistpage($table='',$where='',$field='',$order='', $currPage = 0, $pageSize = 0){
		$total = $this->table($this->tablePrefix.$table)->field($field)->where($where)->count();
		if($currPage && $pageSize)
			$page = page($total, $currPage, $pageSize);
		else
			$page = page($total);
		$limit = $page['offset'].','.$page['limit'];
		$r = $this->table($this->tablePrefix.$table)->field($field)->where($where)->order($order)->limit($limit)->select();
		if(!$r){
			return showData( array(), '', 0, $page, '');  //没有数据时
		}else{
			return showData( $r, '', 0, $page, '');
		}	
	}
	
	/**
	 * 新增一条 (ok)
	 * @param string $table
	 * @param unknown $data
	 * @return Ambigous <\Think\mixed, boolean, string, unknown>
	 */
	public function m_db_addone( $table='',$data=array() ){
		//$r = $this->table($this->tablePrefix.$table)->data($data)->add();
		$r = M($table)->data($data)->add();
		return $r;
	}
	
	/**
	 * 新增多条
	 * @param string $table
	 * @param array $dataList
	 * @return Ambigous <boolean, string, unknown>
	 */
	public function m_db_addlist($table='',$dataList=array()){
		$r = M($table)->addAll($dataList);
		return $r;
	}
	

	/**
	 * 删除指定条件的数据(ok)
	 * @param string $table
	 * @param string $where
	 * @return Ambigous <\Think\mixed, boolean, unknown>
	 */
	public function m_db_delete($table='', $where=''){
		$r = M($table)->where($where)->delete();
		return $r;		
	}

	/**
	 * 更新指定条件的数据(ok)
	 * @param string $table
	 * @param string $where
	 * @param unknown $data
	 * @return Ambigous <boolean, unknown>
	 */
	public function m_db_update($table='', $where='', $data=array()){
		//$r = $this->table($this->tablePrefix.$table)->where($where)->data($data)->save();
		$r = M($table)->where($where)->data($data)->save();
		return $r;
	}
	
	/**
	 * 按sql源语句操作(ok)
	 * @param string $sql
	 * @return \Think\mixed
	 */
	public function m_db_query( $sql='' ){
		$r  = $this->query($sql);
		return $r;
	}
	
	/**
	 * 查询指定表，和满足指定条件有多少条数据(ok)
	 * @param string $table
	 * @param string $where
	 * @return int  //返回总个数，不存在则是 0
	 */
	public function m_db_count( $table='', $where='' ){
		$r = $this->table($this->tablePrefix.$table)->where($where)->count();
		return $r;
	}
	
	public function checkArguments($list) {
		foreach ($list as $key => $value) {
			if($value == null){
				$data = showData(new \stdClass(), '参数不能为空', 1, '', $key . '不能为空');
				$api = new Api();
				$api->jsonOutput($data);
			}
		}

	}
}