<?php
use Org\Util\String;
use Think\Log;
/**
 * 删除文件目录
 * 
 * @param unknown $dir        	
 * @return boolean
 */
function deldir($dir) {
	if (file_exists ( $dir )) {
		// 先删除目录下的文件：
		$dh = opendir ( $dir );
		$file = readdir ( $dh );
		while ( $file ) {
			if ($file != "." && $file != "..") {
				$fullpath = $dir . "/" . $file;
				if (! is_dir ( $fullpath )) {
					unlink ( $fullpath );
				} else {
					deldir ( $fullpath );
				}
			}
		}
		closedir ( $dh );
		// 删除当前文件夹：
		if (rmdir ( $dir )) {
			return true;
		} else {
			return false;
		}
	}
}
/**
 * 编辑排序
 * @param unknown $a
 * @param unknown $b
 * @return number
 */
function cmp_func($a, $b) {
	global $order;
	if ($a['is_dir'] && !$b['is_dir']) {
		return -1;
	} else if (!$a['is_dir'] && $b['is_dir']) {
		return 1;
	} else {
		if ($order == 'size') {
			if ($a['filesize'] > $b['filesize']) {
				return 1;
			} else if ($a['filesize'] < $b['filesize']) {
				return -1;
			} else {
				return 0;
			}
		} else if ($order == 'type') {
			return strcmp($a['filetype'], $b['filetype']);
		} else {
			return strcmp($a['filename'], $b['filename']);
		}
	}
}
/**
 * 对用户的密码进行加密
 * @param $password
 * @param $encrypt //传入加密串，在修改密码时做认证
 * @return array/password
 */
function password($password, $encrypt='') {
	//import('ORG.Util.String');
	$pwd = array();
	$pwd['encrypt'] =  $encrypt ? $encrypt : String::randString(6);
	$pwd['password'] = md5(md5(trim($password)).$pwd['encrypt']);
	return $encrypt ? $pwd['password'] : $pwd;
}
/**
 * 取得文件扩展
 * @param $filename 文件名
 * @return 扩展名
 */
function fileext($filename) {
	return strtolower(trim(substr(strrchr($filename, '.'), 1, 10)));
}
/**
 * 解析多行sql语句转换成数组
 * @param string $sql
 * @return string;
 */
function sql_split($sql) {
	$sql = str_replace("\r", "\n", $sql);
	$ret = array();
	$num = 0;
	$queriesarray = explode(";\n", trim($sql));
	unset($sql);
	foreach($queriesarray as $query) {
		$ret[$num] = '';
		$queries = explode("\n", trim($query));
		$queries = array_filter($queries);
		foreach($queries as $query) {
			$str1 = substr($query, 0, 1);
			if($str1 != '#' && $str1 != '-') $ret[$num] .= $query;
		}
		$num++;
	}
	return($ret);
}

/**
 * 文件扫描
 * @param $filepath     目录
 * @param $subdir       是否搜索子目录
 * @param $ex           搜索扩展
 * @param $isdir        是否只搜索目录
 * @param $md5			是否生成MD5验证码
 * @param $enforcement  强制更新缓存
 */
function scan_file_lists($filepath, $subdir = 1, $ex = '', $isdir = 0, $md5 = 0, $enforcement = 0) {
	static $file_list = array();
	if ($enforcement) $file_list = array();
	$flags = $isdir ? GLOB_ONLYDIR : 0;
	$list = glob($filepath.'*'.(!empty($ex) && empty($subdir) ? '.'.$ex : ''), $flags);
	if (!empty($ex)) $ex_num = strlen($ex);
	foreach ($list as $k=>$v) {
		$v1 = str_replace(SITE_DIR, '', $v);
		if ($subdir && is_dir($v)) {
			scan_file_lists($v.DIRECTORY_SEPARATOR, $subdir, $ex, $isdir, $md5);
			continue;
		}
		if (!empty($ex) && strtolower(substr($v, -$ex_num, $ex_num)) == $ex) {
			if ($md5) {
				$file_list[$v1] = md5_file($v);
			} else {
				$file_list[] = $v1;
			}
			continue;
		} elseif (!empty($ex) && strtolower(substr($v, -$ex_num, $ex_num)) != $ex) {
			unset($list[$k]);
			continue;
		}
	}
	return $file_list;
}
/**
 * 生成CNZZ统计代码
 */
function tjcode($type='1') {
	if(!S('cnzz')) return false;
	$config = S('cnzz');
	if (empty($config)) {
		return false;
	} else {
		if(!$type) $type=1;
		return '<script src=\'http://pw.cnzz.com/c.php?id='.$config['siteid'].'&l='.$type.'\' language=\'JavaScript\' charset=\'gb2312\'></script>';
	}
}
/**
 * 打印函数
 * @param array $array
 */
function p($array) {
	dump($array,1,'<pre>',0);
}
/**
 * 返回毫秒
 * @return number
 */
function getMillisecond()
{
	list($t1, $t2) = explode(' ', microtime());
	return (float)sprintf('%.0f',(floatval($t1) + floatval($t2)) * 1000);
}
/**
 * curl post 方法
 * @param unknown $post_url
 * @param unknown $string
 * @return mixed
 */
function curl_post($url, $string){
	$ch = curl_init();
	curl_setopt($ch, CURLOPT_URL, $url);
	curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
	curl_setopt($ch, CURLOPT_POST, 1);

	curl_setopt($ch, CURLOPT_POSTFIELDS, $string);
	$output = curl_exec($ch);
	curl_close($ch);
	return $output;
}
/**
 * unicode 转中文
 * @param string $str
 * @param string $encoding
 * @return mixed
 */
function unicodeString($str, $encoding=null) {
	return preg_replace_callback('/\\\\u([0-9a-fA-F]{4})/u', create_function('$match', 'return mb_convert_encoding(pack("H*", $match[1]), "utf-8", "UTF-16BE");'), $str);
}
/**
 * 返回数据
 * @param unknown $data
 * @param string $msg
 * @param number $code
 * @param string $page
 * @param string $debugMsg
 * @return array
 */
function showData($data, $msg='', $code=0, $page='', $debugMsg = '' ){
	$result = array(
			'data'		 	=> $data,
			'msg'  			=> $msg,
			'debugMsg'  	=> $debugMsg,
			'code' 			=> $code,
			'page' 			=> $page
	);
	if (APP_DEBUG) {
		Log::write(json_encode($result));
	}
	return $result;
}
/**
 * 分页函数
 * @param int $total
 * @return array
 */
function page($total) {
	$return 		= array ();
	$count 			= I('pageSize','0','intval') ? I('pageSize','0','intval') : 20;
	$page_count 	= max ( 1, ceil ( $total / $count ) );
	$page 			= I('page','0','intval') ? I('page','0','intval') :1;
	$page_next 		= min ( $page + 1, $page_count );
	$page_previous 	= max ( 1, $page - 1 );
	$offset 		= max ( 0, ( int ) (($page - 1) * $count) );

	$return = array (
			'total' 		=> (int) $total,
			'count' 		=> $count,
			'pageCount' 	=> $page_count,
			'page' 			=> $page,
			'page_next' 	=> $page_next,
			'page_previous' => $page_previous,
			'offset' 		=> $offset,
			'limit' 		=> $count
	);
	return $return;
}
/**
 * 上传文件命令规则
 * @param string $str
 * @return string
 */
function md5Name($str=''){
    $string = md5(microtime(true).'_'.String::uuid());
    return substr($string, 8, 16);
}
/**
 * 上传文件
 */
function upload($savePath='', $uid='', $type='', $isVideoFlag=false){
    
    set_time_limit(0);
    
    $ROOT_PATH  = SITE_DIR.UPLOADS;

    $upload 	= new \Think\Upload();
    $upload->exts 	   = array('jpg','png','gif','jpeg','mp4','mp3');// 设置附件上传类型
    $upload->maxSize   = 20*1024*1024; //上传的文件大小限制 (0-不做限制)
    $upload->rootPath  = $ROOT_PATH;
    $upload->replace   = true;
    $upload->savePath  = '/Picture/'; 		// 设置附件上传目录
    $upload->saveName  = array('md5Name','');
    $upload->subName   = array('date','Ymd');
    //设置缩略图
    $thumbWith 		   = 320;
    $thumbHeight 	   = 320;

    $info   =   $upload->upload();
    if(!$info) {
        return $upload->getError();// 上传错误提示错误信息
    }else{
        // 上传成功
        $image = new \Think\Image();
        $data  = array();
        foreach($info as $file){
            $originUrl =  $file['savepath'].$file['savename'];		//原图
            $smallUrl  =  $file['savepath'].'s_'.$file['savename'];	//小图
            //切小图
            $ext = pathinfo($ROOT_PATH.$originUrl, PATHINFO_EXTENSION);
            $ext = strtolower($ext);
            if ( $ext=='mp4' || $ext=='mp3'){
                //视频音视不处理
                if($isVideoFlag){
                    $data[] = array(
                        'originUrl'	=> UPLOADS.ltrim($originUrl,'/'),
                        'smallUrl'	=> UPLOADS.ltrim($originUrl,'/'),
                        'id'        => String::keyGen(),
                        'key'		=> $file['key'],
                        'isVideo'   => true
                    );
                }else{
                    $data[] = array(
                        'originUrl'	=> UPLOADS.ltrim($originUrl,'/'),
                        'smallUrl'	=> UPLOADS.ltrim($originUrl,'/'),
                        'id'        => String::keyGen(),
                        'key'		=> $file['key']
                    );
                }
            }else {
                $image->open($ROOT_PATH.$originUrl);//打开图片
                $image->thumb($thumbWith, $thumbHeight)->save($ROOT_PATH.$smallUrl);//切小图
                if($isVideoFlag){
                    $data[] = array(
                        'key'		=> $file['key'],
                        'originUrl'	=> UPLOADS.ltrim($originUrl,'/'),
                        'smallUrl'	=> UPLOADS.ltrim($smallUrl,'/'),
                        'id'        => String::keyGen(),
                        'isVideo'   => false
                    );
                }else{
                    $data[] = array(
                        'key'		=> $file['key'],
                        'originUrl'	=> UPLOADS.ltrim($originUrl,'/'),
                        'smallUrl'	=> UPLOADS.ltrim($smallUrl,'/'),
                        'id'        => String::keyGen()
                    );
                }
            }
        }
        return $data;
    }
}

/**
 * 修改CONF_PATH配置文件  如果$config_file为空，则修改config.php
 * @param unknown $new_config
 * @param string $config_file
 * @return boolean
 */
function update_config($new_config, $config_file = '') {
	!is_file($config_file) && $config_file = CONF_PATH . '/config.php';
	if (is_writable($config_file)) {
		$config = require $config_file;
		$config = array_merge($config, $new_config);

		file_put_contents($config_file, "<?php \nreturn " . stripslashes(var_export($config, true)) . ";", LOCK_EX);
		@unlink(RUNTIME_FILE);
		return true;
	} else {
		return false;
	}
}
/**
 * 验证手机号
 * @param unknown $mobile
 */
function availablePhone($mobile){
	if (preg_match("/^1[3578]{1}[0-9]{9}$/", $mobile)) {
		return true;
	}
	return false;
}
/**
 * 5位随机码生成
 * @param number $length
 * @return string
 */
function generate_code( $length = 6 ) {
	$chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
	$code = '';
	for ( $i = 0; $i < $length; $i++ ){
		$code .= $chars[ mt_rand(0, strlen($chars) - 1) ];
	}
	if (M('user')->where(array('code'=>$code))->count()){
		$code = generate_code();
	}
	return $code;
}
/**
 * 把数组中的value编码 urlencode
 * @param unknown $arr
 * @return string
 */
function utf8_to_urlencode(&$arr) {
    foreach ( ( array ) $arr as $key => $item ) {
        if (is_array ( $item )) {
            $arr [$key] = utf8_to_urlencode ( $item );
        } else {
            if (is_string($item)){
                $arr [$key] = urlencode ( $item );
            }
        }
    }
    return $arr;
}

/**
 * 格式化字节大小
 * @param  number $size      字节数
 * @param  string $delimiter 数字和单位分隔符
 * @return string            格式化后的带单位的大小
 * @author 麦当苗儿 <zuojiazi@vip.qq.com>
 */
function format_bytes($size, $delimiter = '') {
    $units = array('B', 'KB', 'MB', 'GB', 'TB', 'PB');
    for ($i = 0; $size >= 1024 && $i < 5; $i++) $size /= 1024;
    return round($size, 2) . $delimiter . $units[$i];
}
/**
 * 通过经纬度获取省市区详细地址
 *
 * 返回的数据格式：
 * {
    "status": "OK",
    "result": {
        "location": {
            "lng": 103.453453,
            "lat": 30.123123
        },
        "formatted_address": "四川省成都市蒲江县",
        "business": "",
        "addressComponent": {
            "city": "成都市",
            "direction": "",
            "distance": "",
            "district": "蒲江县",
            "province": "四川省",
            "street": "",
            "street_number": ""
        },
        "cityCode": 75
    }
}
 *
 */
function getDetailAddress($lat, $lng){
//    $contents = 'http://api.map.baidu.com/geocoder?location='.$lat.','.$lng.'&output=json&key=28bcdd84fae25699606ffad27f8da77b';
    $contents = 'http://api.map.baidu.com/geocoder/v2/?location='.$lat.','.$lng.'&output=json&ak=O2WM94fYV9OyY8031gieuqpeUGX9zB9N';
    $string   = file_get_contents($contents);
    $data     = json_decode($string, true);
    if ($data['status'] == 'OK'){
        return $data;
    }
    return false;
}
/**
 * 群号的生成
 * @return boolean
 */
function groupNumber($string){
    if (preg_match('(\d)\1{2}', $string)) {
        return true;
    }
    return false;
}
//=============================会员权限操作===================================
/**
 * 获取会员类型及权限
 * @param int $uid
 */
function getMemberAccess($uid){
    //可以获取到期时间最小的那个权限
    $db   = M('user_member_time');
    $info = $db->where(array('uid'=>$uid))->find();
    $member = M('user_member');
    if ($info){
        if ($info['time']<NOW_TIME){
            //过期了不是会员
            $data = $member->where(array('type'=>0))->find();
        }else {
            $data = $member->where(array('id'=>$info['memberid']))->find();
        }
    }else {
        $data = $member->where(array('type'=>0))->find();
    }
    $data['logo'] = $data['logo'] ? SITE_PROTOCOL.SITE_URL.$data['logo'] : '';
    $data['expiretime'] = $info ? $info['time'] : '';
    return $data;
}
/**
 * 发布消息的数量限制
 * @param int $uid 根据uid获取会员类型
 */
function sendMessageCount($uid=0, $type=0){
    $return = getMemberAccess($uid);
    $messagecount = $return['messagecount'];
    //获取当前用户今天已了多少条消息
    $start = mktime(0, 0, 0, date('m'), date('d'), date('Y'));
    $end   = mktime(23, 59, 59, date('m'), date('d'), date('Y'));
    if ($type){
        //2.乐分享
        $shareCount = M('share')->where(array('uid'=>$uid, 'createtime'=>array('between', "$start,$end")))->count();
        if ($shareCount>=$messagecount) return showData(new stdClass(), '你是'.$return['name'].',每天只能发布'.$messagecount.'条信息', 1);
    }else {
        //1.大家帮 XXX
        $msgCount = M('messages')->where(array('uid'=>$uid, 'createtime'=>array('between', "$start,$end")))->count();
        if ($msgCount>=$messagecount) return showData(new stdClass(), '你是'.$return['name'].',每天只能发布'.$messagecount.'条信息', 1);
    }
    return showData(new stdClass());
}
/**
 * 创建号的数量的限制
 * @param int $uid
 */
function addGroupCount($uid=0){
    $return = getMemberAccess($uid);
    $groupcount = $return['groupcount'];
    $count = M('groups')->where(array('uid'=>$uid))->count();
    if ($count>=$groupcount) return showData(new stdClass(), '你是'.$return['name'].',只能创建'.$groupcount.'个号', 1);
    
    return showData(new stdClass());
}
//================================= 数组相关操作 =============================
/**
 * 移除数组$arr中值为$element的元素，比如
 * {'test', 'show'}移除'test'，则返回{'show'}
 * @param unknown $arr
 * @param unknown $value
 */
function deleteArrayEelement($arr, $element) {
	$returnarr = array();
	
	foreach ($arr as $key=>$value ) {
		if($value != $element)
			$returnarr[$key] = $value;
	}
	
	return $returnarr;
}

function site_url($path){
    return SITE_PROTOCOL.SITE_URL.$path;
}

// 记录用户余额变动日志
function account_log($uid, $price, $content = '', $type = 0){
    $current = M('user')->where('uid='.$uid)->getField("balance");
    $data = array(
        'uid' => $uid,
        'content' => $content,
        'price' => $price,
        'current_balance' => $current,
        'type' => $type,
        'create_time' => NOW_TIME
    );
    M('user_account_log')->add($data);
}