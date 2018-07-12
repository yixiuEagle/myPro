<?php 
/**
 * ★公共的基础-模型层(ok)
 * @author berhp  2015-6-17
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
	 * ★所有接口或PC端中的错误的提示公共部分的内容 - 自定义区  - 可修改
	 * @param string $key  //消息主键 key
	 */
	public function m_msg($key=''){
		header('content-type:text/html;charset=utf-8');
		$msg_data = array(
				'addUser_false' => '注册用户失败了',
				'addUser_get_token_false' 	=> '获取token失败了',  // 注册‘融云’聊天系统的 token时
				'addUser_set_token_false'	=> '保存token失败了',  // 将‘融云’聊天系统的 token保存至用户表失败了
				
				'code_noset'	=>	'验证码不存在',
				'code_error'	=>	'验证码错误',
				'code_guoqi'	=>	'验证码已过期',
				'code_success'	=>	'验证成功',
				'code_get_error'	=>	'获取验证码失败',
				
				'cameraman_noset' => '摄影师不存在',
				'cameraman_gz_error' => '您是摄影师，不能关注其他摄影师',
				'cameraman_gz_error2' => '他并不是摄影师,不能关注他',
				'cameraman_gz_error3' => '您已关注此摄影师了,请不要重复关注',
				
				'data_notmy' 	=> '这条信息不是属于您的，不能进行操作',
				'data_null' 	=> '数据并不存在',
				
				'feedback_success'	=>	'反馈成功',
				'feedback_error'	=>	'反馈失败',
				
				'msg_age' => '请正确输入由0-9数字组成的年龄',
				'msg_sex' => '请正确选择性别 0-未设置 1-男 2-女',
				
				'phone_isset'	=>	'账号已注册',
				'pub_success' 	=> '操作成功',
				'pub_error' 	=> '操作失败',
				'pub_error_self' => '不能自己对自己进行操作',
				'pub_error_id'  => '还未选择角色呢',
				
				'phone_isnull' 	=> '手机号不能为空',
				'phone_preg_error' => '请正确输入由0-9数字组成的11位手机号码',
				
				'uid_isnull' 	=> '用户ID不能为空',
				'user_noset' 	=> '用户不存在',
				'user_password_error' => '密码不正确',
				'user_notCameraman' => '您不是摄影师,不能登录PC端后台管理',
				
				'user_autologin_error' => '自动登录已失效,请重新登录',
				'update_userinfo_error' => '更新用户的信息失败了',
				'update_cameramaninfo_error' => '更新摄影师的信息失败了',
				
				'10'   => '您的账号还未审核,暂时无法登陆,请等待客服联系您',
				'100'  => '用户信息不存在,请先登录',
				'200'  => '摄影师信息不存在',
				'300'  => '您是摄影师,不能对其他摄影师进行操作',
				'400'  => '您不是摄影师,不能进行操作',
				'1000' => '名称不能为空',
				'1100' => '价格不能为空',
				'1101' => '价格的格式不正确,请输入由0-9的数字组成，最多支持小数点2位',
				'1200' => '多个关键词请用空格隔开，最多不能超过8个关键词',
				'1300' => '请输入由0-9数字组成的正整数,排序值,数字越小越在前面',
				'1400' => '创建成功',
				'1500' => '批量上传子图片集失败了',
				'1600' => '此相册并不存在',
				'1601' => '您已经喜欢了,请勿重复操作',
				'1602' => '您已经收藏了,请勿重复操作',
				'1603' => '您并没有收藏它,不能进行取消收藏',
				'1610' => '此信息并不是这个摄影师的,不能进行操作',
				'1700' => '请正确输入type值:1-样片 2-客片',
				'1701' => '您输入的type值与被评论的相册的类型并不相符合，请按接口文档正确的输入参数值',
				'1800' => '被评论的相册并不存在',
				'1900' => '请正确输入当前的时间戳，单位秒',
				'2000' => '您已经对此条评论进行赞了,请勿重复操作',
				'3000' => '订单不存在',
				'3001' => '作品并不存在',
				'3002' => '请正确输入由0-9数字组成的时间戳',
				'3003' => '您的余款不足,请先充值',
				'3010' => '此订单并不是您的，不能进行操作',
				'3020' => '订单未完成,不能进行评论',
				'3030' => '您已经评论一次了,不能重复评论',
				'3040' => '下订单者并不是您,您不能取消订单',
				'3041' => '此订单,已操作,您不能取消订单',
				'3051' => '下单者的用户信息不存在',
				'3052' => '接单者的用户信息不存在',
				'3053' => '作品信息不存在',
				'4000' => '请正确输入type类型,0-未满，1-已满',
				'5000' => '请输入由0-9的数字组成，最多支持小数点2位',
				'6000' => '请正确评价星级,只有为0-5的数字,0即为0星,最高5星',
				'6010' => '订单已结束',
				'6020' => '此订单并不属于您的,不能进行操作',
				'6101' => '拒绝接单,请输入理由',
				'6102' => '摄影师已拒绝接单了,此订单已结束,不能在操作了',
				'6109' => '星级评价3星之下,请输入理由',
				'6110' => '请等待下单者的星级评价',
				'6111' => '订单已完成',
				'6112' => '订单已失败,星级评价3星之下',
				'6120' => '订单已取消',
				'6666' => '未知订单状态,不能进行操作',
				'7777' => '请等待接单者的回复操作',
				'8888' => '请等待下单者的回复操作',

				'9001' => '需要指定具体的专题ID',
				'9002' => '专题并不存在',
				'9601' => '专题名不能为空',
				
				
		);
		$msg = $msg_data[$key] ? $msg_data[$key] : ''; 
		return $msg;
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
	/**
	 *  @desc 根据两点间的经纬度计算距离
	 *  @param float $lat 纬度值
	 *  @param float $lng 经度值
	 */
	public function getDistance($lat1, $lng1, $lat2, $lng2)
	{
	    $earthRadius = 6367000; //approximate radius of earth in meters
	
	    /*
	     Convert these degrees to radians
	     to work with the formula
	     */
	
	    $lat1 = ($lat1 * pi() ) / 180;
	    $lng1 = ($lng1 * pi() ) / 180;
	
	    $lat2 = ($lat2 * pi() ) / 180;
	    $lng2 = ($lng2 * pi() ) / 180;
	
	    /*
	     Using the
	     Haversine formula
	
	     http://en.wikipedia.org/wiki/Haversine_formula
	
	     calculate the distance
	     */
	
	    $calcLongitude = $lng2 - $lng1;
	    $calcLatitude = $lat2 - $lat1;
	    $stepOne = pow(sin($calcLatitude / 2), 2) + cos($lat1) * cos($lat2) * pow(sin($calcLongitude / 2), 2);
	    $stepTwo = 2 * asin(min(1, sqrt($stepOne)));
	    $calculatedDistance = $earthRadius * $stepTwo;
	
	    return $calculatedDistance;
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