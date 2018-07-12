<?php
use Org\Util\String;
use Think\Image;
use Think\Upload;
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
		while ( $file = readdir ( $dh ) ) {
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
	
	Log::write("api result=" . json_encode($result), Log::INFO);
	return $result;
}
/**
 * 分页函数
 * @param int $total
 * @return array
 */
function page($total, $currPage = 0, $pageSize = 0) {
	$return 		= array ();
	if ($pageSize) {
		$count = $pageSize;
	}else
		$count 			= I('pageSize','0','intval') ? I('pageSize','0','intval') : 20;
	
	$page_count 	= max ( 1, ceil ( $total / $count ) );
	
	if($currPage)
		$page = $currPage;
	else
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
function fileSaveName($str=''){
	return md5(microtime(true).'_'.String::uuid());
}

/**
 * 如果图片图片前面没有添加网站前缀路径，则加上。否则，直接返回。
 * @param unknown $url
 */
function makeHttpHead($url) {
	if(strpos($url, "http://") !== false || !$url) {
		return $url;
	}
	$newurl =  SITE_PROTOCOL.SITE_URL . $url;
	return $newurl;
}
function upload_multiple($savePath='', $uid='', $type=''){

	$ROOT_PATH  = SITE_DIR.UPLOADS;

	$upload = new \Think\Upload();
	$upload->exts   = array('jpg','png','gif','jpeg','mp4','mp3');// 设置附件上传类型
	$upload->maxSize   = 0;//10*1024*1024; //上传的文件大小限制 (0-不做限制)
	$upload->rootPath  = $ROOT_PATH;
	$upload->replace   = true;
	$upload->savePath  = 'Picture/'; // 设置附件上传目录
	$upload->saveName  = array('fileSaveName','');
	$upload->subName   = array('date','Ymd');

	//设置缩略图
	$thumbWith   = 480;
	$thumbHeight = 320;

	$info   =   $upload->upload();
	if(!$info) {
		return $upload->getError();// 上传错误提示错误信息
	}else{
		// 上传成功
		$image = new \Think\Image();
		$data  = array();
		foreach($info as $file){
			$originUrl =  $file['savepath'].$file['savename'];	//原图
			$smallUrl  =  $file['savepath'].'s_'.$file['savename'];	//小图
			//切小图
			$ext = pathinfo($ROOT_PATH.$originUrl, PATHINFO_EXTENSION);
			$ext = strtolower($ext);
			Log::write("ext=". $ext);
			if ( $ext=='mp4' || $ext=='mp3'){
				
				$videopath = $ROOT_PATH.$originUrl;
				$imgurl = $videopath;
				$imgurl = substr($imgurl, 0, strlen($imgurl) - 4) . ".jpg";
				// 视频截图
				//$cmd = "/usr/local/ffmpeg/bin/ffmpeg -i ". $videopath . " -y -f image2 -ss 3 -t 1 -s ".$thumbWith."x".$thumbHeight." ".$imgurl;
				 //$cmd = "/usr/local/ffmpeg/bin/ffmpeg -i ". $videopath . " -y -f image2 -ss 3 -t 1".$imgurl;
				$cmd = "/usr/local/ffmpeg/bin/ffmpeg -ss 1 -i ". $videopath . " -y  -f image2  ".$imgurl;
				  
				Log::write("imgurl=" . $imgurl);
				Log::write("cmd=" . $cmd);
				$ret = exec($cmd);
				
				list($width, $height, $type, $attr) = getimagesize($imgurl);
				if($width == null)
					$width = 0;
				if($height == null)
					$height = 0;
				
				//视频音视不处理
				$data[] = array(
						'originUrl'	=> UPLOADS.ltrim($originUrl,'/'),
						'smallUrl'	=> UPLOADS.ltrim($originUrl,'/'),
						'imgurl'	=> UPLOADS.ltrim(substr($originUrl, 0, strlen($originUrl) - 4) . ".jpg",'/'),
						'width'		=> $width,
						'height'	=> $height,
						'id'        => String::keyGen(),
						'key'	    => $file['key'],
				);
			}else {
				Log::write("start to handle picture");
				$image->open($ROOT_PATH.$originUrl);//打开图片
				$image->thumb($thumbWith, $thumbHeight)->save($ROOT_PATH.$smallUrl);//切小图
				
				list($width, $height, $type, $attr) = getimagesize($ROOT_PATH.$smallUrl);
				if($width == null)
					$width = 0;
				if($height == null)
					$height = 0;
				
				$data[] = array(
						'key'	    => $file['key'],
						'originUrl'	=> UPLOADS.ltrim($originUrl,'/'),
						'smallUrl'	=> UPLOADS.ltrim($smallUrl,'/'),
						'imgurl'	=> '',
						'id'        => String::keyGen(),
						'width'		=> $width,
						'height'	=> $height
				);
				
				Log::write("upload picture=" . json_encode($data));
			}
		}
		return $data;
	}
}
/**
 * 上传文件
 */
function upload($savePath, $uid, $type){
	//头像 100  聊天小图 200 分享图片 160
	$URL_PATH 	= UPLOADS;//物理根目录
	$upload 	= new Upload();
	$upload->exts 	   = array('jpg','png','gif');// 设置附件上传类型
	$upload->rootPath  = SITE_DIR.UPLOADS;
	$upload->replace   = true;
	$upload->savePath  = $savePath; 		// 设置附件上传目录
	$upload->saveName  = array('fileSaveName','');
	//设置缩略图
	$thumbWith 		   = 300;
	$thumbHeight 	   = 300;
	switch ($type) {
		case 'user':
			$thumbWith = 600;
			$thumbHeight = 600;
			$upload->subName   = $uid;
			if (!$uid) $upload->savePath  = $savePath.'0/'; // 设置附件上传目录
			break;
		case 'group':
			$upload->subName   = array('date','Ymd');
			break;
		case 'share':
			$upload->subName   = array('date','Ymd');
			$thumbWith		= 640;
			$thumbHeight	= 640;
			break;
		case 'dynamic':
				$upload->subName   = array('date','Ymd');
				$thumbWith		= 640;
				$thumbHeight	= 640;
				break;
	}
	$info   =   $upload->upload();
	if(!$info) {
		return $upload->getError();// 上传错误提示错误信息
	}else{// 上传成功
		$SAVE_PATH_HEAD = SITE_DIR.UPLOADS;//保存物理地址
		$image = new Image();
		$data  = array();
		foreach($info as $file){
			$originUrl =  $file['savepath'].$file['savename'];		//原图
			$smallUrl  =  $file['savepath'].'s_'.$file['savename'];	//小图
			
			$image->open($SAVE_PATH_HEAD.$originUrl);//打开图片
			$image->thumb($thumbWith, $thumbHeight)->save($SAVE_PATH_HEAD.$smallUrl);//切小图
			//user
			$data[] = array(
					'originUrl'	=> $URL_PATH.ltrim($originUrl,'/'),
					'smallUrl'	=> $URL_PATH.ltrim($smallUrl,'/'),
					'key'		=> $file['key']
			);
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


/***
 * 清空表数据
* */

function clear_tables($db, $path){
	//读取sql文件
	Log::write("into clear_tables");
	$sql = file_get_contents($path);
	if (!$sql) {
		return false;
	}
	$sql = str_replace("\r", "\n", $sql);
	$sql = explode(";\n", $sql);


	foreach ($sql as $value) {
		$value = trim($value);
		if(empty($value))	continue;
		$db->execute($value);
		Log::write($value);
	}

	return true;
}

/**
 * 发送短信
 */
function sendSMS($code=0, $phone=0, $type=0, $content=''){
    return true;

	 /* header('Content-Type:text/html; charset=utf-8');

	    $uid = 'SDK-FLH-010-00211';

	    $passwd = 'b2#2e-#9';

	    $passwd = strtoupper(md5($uid.$passwd));

	    $telphone = $phone;

	    switch ($type){

	        case 0:

	            $message = '验证码: '.$code.',有效期2小时,请勿向任何人提供您收到的短信检验码';  	//短信内容

	            break;

	        case 1:

	            $message = '验证码: '.$code.',你正在找回密码,需要进行检验,有效期2小时,请勿向任何人提供您收到的短信检验码';  	//短信内容

	            break;

	        default:

	            $message = '验证码: '.$code.',有效期2小时,请勿向任何人提供您收到的短信检验码';
	    }

	    $message .= '【一米社交】';

	    

	    //$message = iconv("gbk","utf-8",$message);//这里需要转换成gbk

	    $message = urlencode($message);

	   

	    $gateway = "http://sdk2.entinfo.cn:8061/mdsmssend.ashx?sn=$uid&pwd=$passwd&mobile=$telphone&content=$message";

	    Log::write($gateway);

	     

	    $result = file_get_contents($gateway);

	    

	    Log::write("result=" . $result);

	    if(  $result>0) return true;

	    return false;  */

	    

	    

	    /* $client = new \SoapClient('http://mb345.com:999/ws/LinkWS.asmx?wsdl',array('encoding'=>'UTF-8'));

	    $sendParam = array(

	        'CorpID'=>$uid,

	        'Pwd'=>$passwd,

	        'Mobile'=>$telphone,

	        'Content'=>$message,

	        'Cell'=>'',

	        'SendTime'=>''

	    );

	    $result = $client->BatchSend($sendParam);

	    $result = $result->BatchSendResult;

	    $client = null;

	    if ($result==0 || $result==1) return true;

	    return false; */


}

/**
 * 检测字符串长度，如果低于$maxlen,返回true，如果小于$minlen，返回false
 * @param unknown $str
 * @param unknown $len
 */
function checkStringLen($str, $maxlen, $minlen=0) {
	$ret = false;
	
	$len = strlen($str)/3;
	if($len <= $maxlen && $len >= $minlen)
		$ret = true;
	
	return $ret;
}
/**
 * 计算当前余额的梯度
 */
function levelMoney($money){
    if(!$money || $money < 0){
        return 1;
    }
    $level=1/round(ceil($money/1000),2);
    return $level;
}
/**
 * 自动判别星座
 * @param unknown $month
 * @param unknown $day
 * @return boolean
 */
function yige_constellation($month, $day) {
    // 检查参数有效性
    if ($month < 1 || $month > 12 || $day < 1 || $day > 31) return false;

    // 星座名称以及开始日期
    $constellations = array(
        array( "20" => "水瓶座"),
        array( "19" => "双鱼座"),
        array( "21" => "白羊座"),
        array( "20" => "金牛座"),
        array( "21" => "双子座"),
        array( "22" => "巨蟹座"),
        array( "23" => "狮子座"),
        array( "23" => "处女座"),
        array( "23" => "天秤座"),
        array( "24" => "天蝎座"),
        array( "22" => "射手座"),
        array( "22" => "摩羯座")
    );

    list($constellation_start, $constellation_name) = each($constellations[(int)$month-1]);

    if ($day < $constellation_start) list($constellation_start, $constellation_name) = each($constellations[($month -2 < 0) ? $month = 11: $month -= 2]);

    return $constellation_name;
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
 * 生成全国省市
 */
function allcity(){
    $city_arr = array('安徽'
            => Array(
            '合肥(*)', '合肥',
            '安庆', '安庆',
            '蚌埠', '蚌埠',
            '亳州', '亳州',
            '巢湖', '巢湖',
            '滁州', '滁州',
            '阜阳', '阜阳',
            '贵池', '贵池',
            '淮北', '淮北',
            '淮化', '淮化',
            '淮南', '淮南',
            '黄山', '黄山',
            '九华山', '九华山',
            '六安', '六安',
            '马鞍山', '马鞍山',
            '宿州', '宿州',
            '铜陵', '铜陵',
            '屯溪', '屯溪',
            '芜湖', '芜湖',
            '宣城', '宣城'),
             
         '北京'
            => Array(
            '东城', '东城',
            '西城', '西城',
            '崇文', '崇文',
            '宣武', '宣武',
            '朝阳', '朝阳',
            '丰台', '丰台',
            '石景山', '石景山',
            '海淀', '海淀',
            '门头沟', '门头沟',
            '房山', '房山',
            '通州', '通州',
            '顺义', '顺义',
            '昌平', '昌平',
            '大兴', '大兴',
            '平谷', '平谷',
            '怀柔', '怀柔',
            '密云', '密云',
            '延庆', '延庆'),
            
         '重庆'
            => Array(
            '万州', '万州',
            '涪陵', '涪陵',
            '渝中', '渝中',
            '大渡口', '大渡口',
            '江北', '江北',
            '沙坪坝', '沙坪坝',
            '九龙坡','九龙坡',
            '南岸', '南岸',
            '北碚', '北碚',
            '万盛', '万盛',
            '双挢', '双挢',
            '渝北', '渝北',
            '巴南', '巴南',
            '黔江', '黔江',
            '长寿', '长寿',
            '綦江', '綦江',
            '潼南', '潼南',
            '铜梁', '铜梁',
            '大足', '大足',
            '荣昌', '荣昌',
            '壁山', '壁山',
            '梁平', '梁平',
            '城口', '城口',
            '丰都', '丰都',
            '垫江', '垫江',
            '武隆', '武隆',
            '忠县', '忠县',
            '开县', '开县',
            '云阳', '云阳',
            '奉节', '奉节',
            '巫山', '巫山',
            '巫溪', '巫溪',
            '石柱', '石柱',
            '秀山', '秀山',
            '酉阳', '酉阳',
            '彭水', '彭水',
            '江津', '江津',
            '合川', '合川',
            '永川', '永川',
            '南川', '南川'),
            
         '福建'
            => Array(
            '福州(*)', '福州',
            '福安', '福安',
            '龙岩', '龙岩',
            '南平', '南平',
            '宁德', '宁德',
            '莆田', '莆田',
            '泉州', '泉州',
            '三明', '三明',
            '邵武', '邵武',
            '石狮', '石狮',
            '晋江', '晋江',
            '永安', '永安',
            '武夷山', '武夷山',
            '厦门', '厦门',
            '漳州', '漳州'),
             
         '甘肃'
            => Array(
            '兰州(*)', '兰州',
            '白银', '白银',
            '定西', '定西',
            '敦煌', '敦煌',
            '甘南', '甘南',
            '金昌', '金昌',
            '酒泉', '酒泉',
            '临夏', '临夏',
            '平凉', '平凉',
            '天水', '天水',
            '武都', '武都',
            '武威', '武威',
            '西峰', '西峰',
            '嘉峪关','嘉峪关',
            '张掖', '张掖'),
            
         '广东'
            => Array(
            '广州(*)', '广州',
            '潮阳', '潮阳',
            '潮州', '潮州',
            '澄海', '澄海',
            '东莞', '东莞',
            '佛山', '佛山',
            '河源', '河源',
            '惠州', '惠州',
            '江门', '江门',
            '揭阳', '揭阳',
            '开平', '开平',
            '茂名', '茂名',
            '梅州', '梅州',
            '清远', '清远',
            '汕头', '汕头',
            '汕尾', '汕尾',
            '韶关', '韶关',
            '深圳', '深圳',
            '顺德', '顺德',
            '阳江', '阳江',
            '英德', '英德',
            '云浮', '云浮',
            '增城', '增城',
            '湛江', '湛江',
            '肇庆', '肇庆',
            '中山', '中山',
            '珠海', '珠海'),
            
         '广西'
            => Array(
            '南宁(*)', '南宁',
            '百色', '百色',
            '北海', '北海',
            '桂林', '桂林',
            '防城港', '防城港',
            '河池', '河池',
            '贺州', '贺州',
            '柳州', '柳州',
            '来宾', '来宾',
            '钦州', '钦州',
            '梧州', '梧州',
            '贵港', '贵港',
            '玉林', '玉林'),
            
         '贵州'
            => Array(
            '贵阳(*)', '贵阳',
            '安顺', '安顺',
            '毕节', '毕节',
            '都匀', '都匀',
            '凯里', '凯里',
            '六盘水', '六盘水',
            '铜仁', '铜仁',
            '兴义', '兴义',
            '玉屏', '玉屏',
            '遵义', '遵义'),
            
         '海南'
            => Array(
            '海口(*)', '海口',
    '三亚', '三亚',
    '五指山', '五指山',
    '琼海', '琼海',
    '儋州', '儋州',
    '文昌', '文昌',
    '万宁', '万宁',
    '东方', '东方',
    '定安', '定安',
    '屯昌', '屯昌',
    '澄迈', '澄迈',
    '临高', '临高',
    '万宁', '万宁',
    '白沙黎族', '白沙黎族',
    '昌江黎族', '昌江黎族',
    '乐东黎族', '乐东黎族',
    '陵水黎族', '陵水黎族',
    '保亭黎族', '保亭黎族',
    '琼中黎族', '琼中黎族',
    '西沙群岛', '西沙群岛',
    '南沙群岛', '南沙群岛',
    '中沙群岛', '中沙群岛'
            ),
            
         '河北'
            => Array(
            '石家庄(*)', '石家庄',
            '保定', '保定',
            '北戴河', '北戴河',
            '沧州', '沧州',
            '承德', '承德',
            '丰润', '丰润',
            '邯郸', '邯郸',
            '衡水', '衡水',
            '廊坊', '廊坊',
            '南戴河', '南戴河',
            '秦皇岛', '秦皇岛',
            '唐山', '唐山',
            '新城', '新城',
            '邢台', '邢台',
            '张家口', '张家口'),
            
         '黑龙江'
            => Array(
            '哈尔滨(*)', '哈尔滨',
            '北安', '北安',
            '大庆', '大庆',
            '大兴安岭', '大兴安岭',
            '鹤岗', '鹤岗',
            '黑河', '黑河',
            '佳木斯', '佳木斯',
            '鸡西', '鸡西',
            '牡丹江', '牡丹江',
            '齐齐哈尔', '齐齐哈尔',
            '七台河', '七台河',
            '双鸭山', '双鸭山',
            '绥化', '绥化',
            '伊春', '伊春'),
            
         '河南'
            => Array(
            '郑州(*)', '郑州',
            '安阳', '安阳',
            '鹤壁', '鹤壁',
            '潢川', '潢川',
            '焦作', '焦作',
            '济源', '济源',
            '开封', '开封',
            '漯河', '漯河',
            '洛阳', '洛阳',
            '南阳', '南阳',
            '平顶山', '平顶山',
            '濮阳', '濮阳',
            '三门峡', '三门峡',
            '商丘', '商丘',
            '新乡', '新乡',
            '信阳', '信阳',
            '许昌', '许昌',
            '周口', '周口',
            '驻马店', '驻马店'),
            
         '香港'
            => Array(
            '香港', '香港',
            '九龙', '九龙',
            '新界', '新界'),
            
         '湖北'
            => Array(
            '武汉(*)', '武汉',
            '恩施', '恩施',
            '鄂州', '鄂州',
            '黄冈', '黄冈',
            '黄石', '黄石',
            '荆门', '荆门',
            '荆州', '荆州',
            '潜江', '潜江',
            '十堰', '十堰',
            '随州', '随州',
            '武穴', '武穴',
            '仙桃', '仙桃',
            '咸宁', '咸宁',
            '襄阳', '襄阳',
            '襄樊', '襄樊',
            '孝感', '孝感',
            '宜昌', '宜昌'),
            
         '湖南'
            => Array(
            '长沙(*)', '长沙',
            '常德', '常德',
            '郴州', '郴州',
            '衡阳', '衡阳',
            '怀化', '怀化',
            '吉首', '吉首',
            '娄底', '娄底',
            '邵阳', '邵阳',
            '湘潭', '湘潭',
            '益阳', '益阳',
            '岳阳', '岳阳',
            '永州', '永州',
            '张家界', '张家界',
            '株洲', '株洲'),
            
         '江苏'
            => Array(
            '南京(*)', '南京',
            '常熟', '常熟',
            '常州', '常州',
            '海门', '海门',
            '淮安', '淮安',
            '江都', '江都',
            '江阴', '江阴',
            '昆山', '昆山',
            '连云港', '连云港',
            '南通', '南通',
            '启东', '启东',
            '沭阳', '沭阳',
            '宿迁', '宿迁',
            '苏州', '苏州',
            '太仓', '太仓',
            '泰州', '泰州',
            '同里', '同里',
            '无锡', '无锡',
            '徐州', '徐州',
            '盐城', '盐城',
            '扬州', '扬州',
            '宜兴', '宜兴',
            '仪征', '仪征',
            '张家港', '张家港',
            '镇江', '镇江',
            '周庄', '周庄'),
            
         '江西'
            => Array(
            '南昌(*)', '南昌',
            '抚州', '抚州',
            '赣州', '赣州',
            '吉安', '吉安',
            '景德镇', '景德镇',
            '井冈山', '井冈山',
            '九江', '九江',
            '庐山', '庐山',
            '萍乡', '萍乡',
            '上饶', '上饶',
            '新余', '新余',
            '宜春', '宜春',
            '鹰潭', '鹰潭'),
            
         '吉林'
            => Array(
            '长春(*)', '长春',
            '白城', '白城',
            '白山', '白山',
            '珲春', '珲春',
            '辽源', '辽源',
            '梅河', '梅河',
            '吉林', '吉林',
            '四平', '四平',
            '松原', '松原',
            '通化', '通化',
            '延吉', '延吉'),
        '辽宁'
            => Array(
            '沈阳(*)', '沈阳',
            '鞍山', '鞍山',
            '本溪', '本溪',
            '朝阳', '朝阳',
            '大连', '大连',
            '丹东', '丹东',
            '抚顺', '抚顺',
            '阜新', '阜新',
            '葫芦岛', '葫芦岛',
            '锦州', '锦州',
            '辽阳', '辽阳',
            '盘锦', '盘锦',
            '铁岭', '铁岭',
            '营口', '营口'),
            
         '澳门'
            => Array(
            '澳门', '澳门'),
            
         '内蒙古'
            => Array(
            '呼和浩特(*)', '呼和浩特',
            '阿拉善盟', '阿拉善盟',
            '包头', '包头',
            '赤峰', '赤峰',
            '东胜', '东胜',
            '海拉尔', '海拉尔',
            '集宁', '集宁',
            '临河', '临河',
            '通辽', '通辽',
            '乌海', '乌海',
            '乌兰浩特', '乌兰浩特',
            '锡林浩特', '锡林浩特'),
            
         '宁夏'
            => Array(
            '银川(*)', '银川',
            '固原', '固原',
            '中卫', '中卫',
            '石嘴山', '石嘴山',
            '吴忠', '吴忠'),
            
         '青海'
            => Array(
            '西宁(*)', '西宁',
            '德令哈', '德令哈',
            '格尔木', '格尔木',
            '共和', '共和',
            '海东', '海东',
            '海晏', '海晏',
            '玛沁', '玛沁',
            '同仁', '同仁',
            '玉树', '玉树'),
            
         '山东'
            => Array(
            '济南(*)', '济南',
            '滨州', '滨州',
            '兖州', '兖州',
            '德州', '德州',
            '东营', '东营',
            '菏泽', '菏泽',
            '济宁', '济宁',
            '莱芜', '莱芜',
            '聊城', '聊城',
            '临沂', '临沂',
            '蓬莱', '蓬莱',
            '青岛', '青岛',
            '曲阜', '曲阜',
            '日照', '日照',
            '泰安', '泰安',
            '潍坊', '潍坊',
            '威海', '威海',
            '烟台', '烟台',
            '枣庄', '枣庄',
            '淄博', '淄博'),
            
         '上海'
            => Array(
            '崇明', '崇明',
            '黄浦', '黄浦',
            '卢湾', '卢湾',
            '徐汇', '徐汇',
            '长宁', '长宁',
            '静安', '静安',
            '普陀', '普陀',
            '闸北', '闸北',
            '虹口', '虹口',
            '杨浦', '杨浦',
            '闵行', '闵行',
            '宝山', '宝山',
            '嘉定', '嘉定',
            '浦东', '浦东',
            '金山', '金山',
            '松江', '松江',
            '青浦', '青浦',
            '南汇', '南汇',
            '奉贤', '奉贤',
            '朱家角', '朱家角'),
            
         '山西'
            => Array(
            '太原(*)', '太原',
            '长治', '长治',
            '大同', '大同',
            '候马', '候马',
            '晋城', '晋城',
            '离石', '离石',
            '临汾', '临汾',
            '宁武', '宁武',
            '朔州', '朔州',
            '忻州', '忻州',
            '阳泉', '阳泉',
            '榆次', '榆次',
            '运城', '运城'),
            
         '陕西'
            => Array(
            '西安(*)', '西安',
            '安康', '安康',
            '宝鸡', '宝鸡',
            '汉中', '汉中',
            '渭南', '渭南',
            '商州', '商州',
            '绥德', '绥德',
            '铜川', '铜川',
            '咸阳', '咸阳',
            '延安', '延安',
            '榆林', '榆林'),
            
         '四川'
            => Array(
            '成都(*)', '成都',
            '巴中', '巴中',
            '达州', '达州',
            '德阳', '德阳',
            '都江堰', '都江堰',
            '峨眉山', '峨眉山',
            '涪陵', '涪陵',
            '广安', '广安',
            '广元', '广元',
            '九寨沟', '九寨沟',
            '康定', '康定',
            '乐山', '乐山',
            '泸州', '泸州',
            '马尔康', '马尔康',
            '绵阳', '绵阳',
            '眉山', '眉山',
            '南充', '南充',
            '内江', '内江',
            '攀枝花', '攀枝花',
            '遂宁', '遂宁',
            '汶川', '汶川',
            '西昌', '西昌',
            '雅安', '雅安',
            '宜宾', '宜宾',
            '自贡', '自贡',
            '资阳', '资阳'),
            
         '台湾'
            => Array(
            '台北(*)', '台北',
            '基隆', '基隆',
            '台南', '台南',
            '台中', '台中',
            '高雄', '高雄',
            '屏东', '屏东',
            '南投', '南投',
            '云林', '云林',
            '新竹', '新竹',
            '彰化', '彰化',
            '苗栗', '苗栗',
            '嘉义', '嘉义',
            '花莲', '花莲',
            '桃园', '桃园',
            '宜兰', '宜兰',
            '台东', '台东',
            '金门', '金门',
            '马祖', '马祖',
            '澎湖', '澎湖',
            '其它', '其它'),
            
         '天津'
            => Array(
            '天津', '天津',
            '和平', '和平',
            '东丽', '东丽',
            '河东', '河东',
            '西青', '西青',
            '河西', '河西',
            '津南', '津南',
            '南开', '南开',
            '北辰', '北辰',
            '河北', '河北',
            '武清', '武清',
            '红挢', '红挢',
            '塘沽', '塘沽',
            '汉沽', '汉沽',
            '大港', '大港',
            '宁河', '宁河',
            '静海', '静海',
            '宝坻', '宝坻',
            '蓟县', '蓟县' ),
            
         '新疆'
            => Array(
            '乌鲁木齐(*)', '乌鲁木齐',
            '阿克苏', '阿克苏',
            '阿勒泰', '阿勒泰',
            '阿图什', '阿图什',
            '博乐', '博乐',
            '昌吉', '昌吉',
            '东山', '东山',
            '哈密', '哈密',
            '和田', '和田',
            '喀什', '喀什',
            '克拉玛依', '克拉玛依',
            '库车', '库车',
            '库尔勒', '库尔勒',
            '奎屯', '奎屯',
            '石河子', '石河子',
            '塔城', '塔城',
            '吐鲁番', '吐鲁番',
            '伊宁', '伊宁'),
            
         '西藏'
            => Array(
            '拉萨(*)', '拉萨',
            '阿里', '阿里',
            '昌都', '昌都',
            '林芝', '林芝',
            '那曲', '那曲',
            '日喀则', '日喀则',
            '山南', '山南'),
            
         '云南'
            => Array(
            '昆明(*)', '昆明',
            '大理', '大理',
            '保山', '保山',
            '楚雄', '楚雄',
            '大理', '大理',
            '东川', '东川',
            '个旧', '个旧',
            '景洪', '景洪',
            '开远', '开远',
            '临沧', '临沧',
            '丽江', '丽江',
            '六库', '六库',
            '潞西', '潞西',
            '曲靖', '曲靖',
            '思茅', '思茅',
            '文山', '文山',
            '西双版纳', '西双版纳',
            '玉溪', '玉溪',
            '中甸', '中甸',
            '昭通', '昭通'),
            
         '浙江'
            => Array(
            '杭州(*)', '杭州',
            '安吉', '安吉',
            '慈溪', '慈溪',
            '定海', '定海',
            '奉化', '奉化',
            '海盐', '海盐',
            '黄岩', '黄岩',
            '湖州', '湖州',
            '嘉兴', '嘉兴',
            '金华', '金华',
            '临安', '临安',
            '临海', '临海',
            '丽水', '丽水',
            '宁波', '宁波',
            '瓯海', '瓯海',
            '平湖', '平湖',
            '千岛湖', '千岛湖',
            '衢州', '衢州',
            '江山', '江山',
            '瑞安', '瑞安',
            '绍兴', '绍兴',
            '嵊州', '嵊州',
            '台州', '台州',
            '温岭', '温岭',
            '温州', '温州',
   '余姚', '余姚',
   '舟山', '舟山'),
        );
    foreach ($city_arr as $k => $v){
       $id=M('hometown')->add(array('parentId'=>0,'name'=>$k));
       for($i=1;$i<count($v);$i=$i+2){
           M('hometown')->add(array('parentId'=>$id,'name'=>$v[$i]));
       }
    }
    return 'ok';
}