<?php
namespace News\Model;
use Think\Model;
class NewsModel extends Model {
	protected $tableName 	= 'news';
	protected $pk        	= 'id';
	
	public $join     = '';
	public $string   = '';
	public $field    = '';
	
	/**
	 * 数据格式化
	 * @param array $list
	 * @param int $uid
	 * @return array
	 */
	private function _format($list, $uid=0){
	    if ($list){
	        foreach ($list as $k=>&$v){
	            //主图
	            if (isset($v['logo'])) {
	                $v['logo'] = $v['logo'] ? SITE_PROTOCOL.SITE_URL.$v['logo'] : '';
	                $v['logolarge'] = str_replace('/s_', '/', $v['logo']);
	            }
	            //附图
	            if (isset($v['images'])) {
	                $images = json_decode($v['images'], true);
	                $v['images'] = array();
	                foreach ($images as $k1=>$v2){
	                    $v['images'][] = array(
	                        'small'    => SITE_PROTOCOL.SITE_URL.$v2,
	                        'large'    => SITE_PROTOCOL.SITE_URL.str_replace('/s_', '/', $v2)
	                    );
	                }
	            }
	            //赞助商
	            if (isset($v['sponsor'])){
	                $v['sponsor'] = $v['sponsor'] ? SITE_PROTOCOL.SITE_URL.$v['sponsor'] : '';
	                $v['sponsorlarge'] = str_replace('/s_', '/', $v['sponsor']);
	            }
	        }
	    }else {
	        $list = array();
	    }
	    return $list;
	}
	/**
	 * 公共群组列表
	 */
	private function _list($map, $uid, $order=''){
	    //自定义条件
	    if ($this->string) $map['_string'] = $this->string;
	
	    $total = $this->alias('g')->where($map)->count();
	    if ($total){
	        $page  = page($total);
	        $limit = $page['offset'] . ',' . $page['limit'];
	    }else {
	        $page  = '';
	    }
	    $list  = $total ? self::public_list($uid, $map, $limit, $order) : array();
	    return showData($list, '', 0, $page);
	}
	/**
	 * 群组公共列表
	 */
	public function public_list($uid, $map, $limit, $sort=''){
	    $join  = '';
	    $order = '';
	    //自定义字段
	    if ($this->field) {
	        $field = $this->field;
	    }else {
	        $field = 'g.*';
	    }
	    //自定义联合查询
	    if ($this->join) $join = $this->join;
	    //自定义条件
	    if ($this->string) $map['_string'] = $this->string;
	    //计算距离
	    $lat   = trim(I('lat')); //纬度
	    $lng   = trim(I('lng')); //经度
	    if ($lat && $lng) {
	        $field .= ',round(getDistance('.$lng.','.$lat.',g.lng,g.lat)) as distance';
	        //$order  = 'distance asc';
	    }
	    //排序
	    if ($sort) $order = $sort;
	    //赞
	    $field  .= ',(select count(*) from `'.$this->tablePrefix.'news_praise` where `uid`='.$uid.' and `newsid`=g.id) as ispraise'; 
	    //收藏
	    $field  .= ',(select count(*) from `'.$this->tablePrefix.'user_collect` where `uid`='.$uid.' and `newsid`=g.id) as iscollect';
	     
	    $list  	  = $this->alias('g')->field($field)->where($map)->join($join)->order($order)->limit($limit)->select();
	    $_list 	  = self::_format($list,$uid);
	    if ($list && $limit == 1) {
	        return $_list['0'];
	    }else {
	        return $_list;
	    }
	}
	
	/**
	 * 资讯列表
	 */
	function lists($uid) {
	    $map  = array();
	    //类别1
	    $cateid1 = trim(I('cateid1', 0));
	    if ($cateid1) $map['cateid1'] = $cateid1;
	    //类别2
	    $cateid2 = trim(I('cateid2', 0));
	    if ($cateid2) $map['cateid2'] = $cateid2;
	    //城市
	    $cityid = trim(I('cityid', 0));
	    if ($cityid) $map['cityid'] = $cityid;
	    
	    $this->field = 'id, title, cateid1, description,createtime';
	    $list = self::_list($map, $uid, 'createtime desc');
	    return $list;
	}
	/**
	 * 详细
	 * @param number $id
	 */
	function detail($uid, $id=0) {
	    $map  = array('id'=>$id);
	    $data = self::public_list($uid, $map, 1);
	    self::readCount($id);
	    return showData($data);
	}
	/**
	 * 家教资讯子类别列表
	 */
	function categoryList() {
	    $list = M('news_cate_two')->select();
	    $data = $list ? $list : array();
	    return showData($data);
	}
	/**
	 * 添加赞和取消赞
	 * @param int $uid
	 * @param int $id
	 */
	function praise($uid, $id) {
	    //$action = trim(I('action', 0));
	    $data   = array('uid'=>$uid, 'newsid'=>$id);
	    $db     = M('news_praise');
	    $count  = $db->where($data)->count();
	    /* if ($action) {
	        //取消赞
	        if (!$count) return showData(new \stdClass(), '你没有赞该资讯', 1);
	        if ($db->where($data)->delete()){
	            $this->where(array('id'=>$id))->setDec('praisecount');
	            return showData(new \stdClass(), '取消赞成功');
	        }
	        return showData(new \stdClass(), '取消赞失败', 1);
	    }else { */
	        //添加赞
        if ($count) return showData(new \stdClass(), '你已赞了该资讯', 1);
        $data['createtime'] = NOW_TIME;
        if ($db->add($data)){
            $this->where(array('id'=>$id))->setInc('praisecount', 1);
            return showData(new \stdClass(), '添加赞成功');
        }
        return showData(new \stdClass(), '添加赞失败', 1);
	    //}
	}
	/**
	 * 阅读数
	 * @param number $id 资讯Id
	 */
	function readCount($id=0) {
	    return $this->where(array('id'=>$id))->setInc('readcount', 1);
	}
	/**
	 * 添加收藏和取消收藏
	 * @param number $uid
	 * @param number $id
	 * @return multitype:
	 */
	function collect($uid, $id) {
	    $action = trim(I('action', 0));//0-添加收藏 1-取消收藏
	    $data   = array('uid'=>$uid, 'newsid'=>$id);
	    $db     = M('user_collect');
	    $count  = $db->where($data)->count();
	    if ($action){
	        if (!$count) return showData(new \stdClass(), '你未收藏该资讯', 1);
	        if ($db->where($data)->delete()){
	            return showData(new \stdClass(), '取消收藏成功');
	        }
	        return showData(new \stdClass(), '取消收藏失败', 1);
	    }else {
	        if ($count) return showData(new \stdClass(), '你已收藏了该资讯', 1);
	        $data['createtime'] = NOW_TIME;
	        if ($db->add($data)) {
	            return showData(new \stdClass(), '收藏成功');
	        }
	        return showData(new \stdClass(), '收藏失败', 1);
	    }
	}
	/**
	 * 用户的收藏列表
	 * @param ints $uid
	 */
	function collectLists($uid) {
	    $this->string = 'g.id in(select `newsid` from `'.$this->tablePrefix.'user_collect` where `uid`='.$uid.')';
	    $this->field = 'id, title, cateid1, description';
	    $map  = array();
	    $cateid1 = trim(I('cateid1', 0));
	    if ($cateid1) $map['cateid1'] = $cateid1;
	    $data = self::_list($map, $uid);
	    return $data;
	}
}