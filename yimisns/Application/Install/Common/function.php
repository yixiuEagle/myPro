<?php 
/**
 *系统环境检测
 *@return [array] [系统环境数据] 
 */
function check_env(){
	$items = array(
		'os'      => array('操作系统', '不限制', '类Unix', PHP_OS, 'success'),
		'php'     => array('PHP版本', '5.3', '5.0+',PHP_VERSION, 'success'),
		'upload'  => array('附件上传', '不限制', '2M+', '未知', 'success'),
		'gd'      => array('GD库', '2.0', '2.0+', '未知', 'success'),
		'disk'    => array('磁盘空间', '5M', '不限制', '未知', 'success'),
	);

	//php环境检测
	if (version_compare($items['php'][3],$items['php'][1],'<') ){
		$items['php'][4] = 'error';
		session('error',true);
		session('errorinfo' , 'php版本不对');
	}

	//上传文件大小检测
	if(@ini_get('file_uploads')){
		$items['upload'][3] = ini_get('upload_max_filesize');
	}

	//GD库检测
	$tmp = function_exists('gd_info') ? gd_info() : array();
	if (empty($tmp['GD Version'])) {
		$items['gd'][3] = '未安装';
		$items['gd'][4] = 'error';
		session('errorinfo' , 'gd未安装');
		session('error',true);
	} else {
		$items['gd'][3] = $tmp['GD Version'];
	}
	unset($tmp);

	//磁盘空间检测
	if (function_exists('disk_free_space')) {
		$items['disk'][3] = floor(disk_free_space('/') / (1024*1024)).'M';
	}
	return $items;
}


/**
 * 目录文件读写检测
 * @return [array] [检测数据]
 */
function check_dirfile(){
	$items = array(//需要判断权限的目录
		array('dir','可读','success','./Uploads/Download'),
		array('dir','可读','success','./Uploads/Picture'),
		array('dir','可读','success','./Uploads/Editor'),
		array('dir','可读','success','./Application/Runtime'),
		array('dir','可读','success','./Application/Common/Conf'),
	    array('dir','可读','success','./Application/Install/Data'),
	    array('file','可读','success','./Data/install.sql'),
		array('file','可写','success','./Application/Common/Conf/config.php'),
		);

	foreach ($items as &$value) {
		if ($value[0] == 'dir') {
			if (file_exists($value[3])) {//判断路径是否存在
				if (!is_writable($value[3])) {//判断路径是否有写入权限
					$value[1] = '不可读';
					$value[2] = 'error';
					session('errorinfo' , $value[3] . '不可读');
					session('error',true);
				}
			}else{
				$value[1] = '不存在';
				$value[2] = 'error';
				session('errorinfo' , $value[3] . '不存在');
				session('error',true);
			}	
		}else{
			if (file_exists($value[3])) {//判断文件是否存在
				if (!is_writable($value[3])) {//判断文件是否有写入权限
					$value[1] = '不可读';
					$value[2] = 'error';
					session('errorinfo' , $value[3] . '不可读');
					session('error',true);
				}
			}else{
				$value[1] = '不存在';
				$value[2] = 'error';
				session('errorinfo' , $value[3] . '不存在');
				session('error',true);
			}
		}
	}
	return $items;
}

/**
 * 函数检测
 * @return [array] [检测函数数据]
 */
function check_func(){
	$items = array(
		array('mysql_connect',		'支持','success'),
		array('file_get_contents',	'支持','success'),
		array('mb_strlen',			'支持','success'),
		);
	foreach ($items as $value) {
		if (!function_exists($value[0])) {
			$value[1] = '不支持';
			$value[2] = 'error';
			$value[3] = '开启';
			session('errorinfo' , $value[0] . '不支持');
			session('error',true);
		}
	}
	return $items;
}

/**
 * 写入配置文件
 * @param [array] [$config] [配置文件内容]
 * 
 */
function write_config($config){
	if (is_array($config)) {
		$conf = file_get_contents('./Application/Install/Data/conf.tpl');//读取公用配置信息
		foreach ($config as $name => $value) {
			$conf = str_replace("[$name]", $value, $conf);//替换相应的配置文件
		}

		//写入应用配置文件
		if (file_put_contents('./Application/Common/Conf/config.php', $conf)) {
			show_msg('配置文件写入成功');
		} else {
			show_msg('配置文件写入失败','error');
			session('error',true);
		}
		return '';
	}
}

/**
 * 创建数据表
 * @param [resource] [$db] [数据库连接资源]
 * @param [string] [$prefix] [数据表前缀]
 */
function create_tables($db,$prefix = ''){
	//读取sql文件
	$sql = file_get_contents('./Data/install.sql');
	if (!$sql) show_msg('读取./Data/install.sql配置文件失败','error');
	$sql = str_replace("\r", "\n", $sql);
	$sql = explode(";\n", $sql);

	//替换表前缀
	$sql = str_replace("`tc_", "`{$prefix}", $sql);
	//开始安装
	show_msg('开始安装数据库...');
	foreach ($sql as $value) {
		$value = trim($value);
		if (empty($value)) continue;
		if (substr($value, 0,12) == 'CREATE TABLE') {
			$name = preg_replace("/^CREATE TABLE `(\w+)` .*/s", "\\1", $value);
			$msg = "创建数据表{$name}";
			if (false !== $db->execute($value)) {
				show_msg($msg . '...成功');
			} else {
				show_msg($msg . '...失败!','error');
				session('error',true);
			}
		} else {
			$db->execute($value);
		}
	}
}

/**
 * [管理员注册信息]
 * @param  [resource] 	$db     [数据库连接资源句柄]
 * @param  [string] 	$prefix [数据表前缀]
 * @param  [array] 		$admin  [管理员注册信息]
 * @return [空]         		[空]
 */
function register_administrator($db,$prefix,$admin){
	show_msg('开始注册创始人帐号...');
	$passwordinfo 		= password($admin['password']);
	
	$username 	 	= $admin['username'];
	$password 	 	= $passwordinfo['password'];
	$encrypt 	 	= $passwordinfo['encrypt'];
	$lastloginip 	= get_client_ip();
	$lastlogintime	= NOW_TIME;

	$sql = "INSERT INTO `{$prefix}admin` VALUES (1,'{$username}','{$password}','1','{$encrypt}','{$lastloginip}','{$lastlogintime}','','','')";
	
	//执行sql;
	$db->execute($sql);	
	show_msg('创始人帐号注册完成');
}

/**
 * [show_msg description]
 * @param  [string] $msg   	[提示信息]
 * @param  [string]	$class 	[description]
 * @return [type]        	[description]
 */
function show_msg($msg,$class = ''){
	echo "<script type=\"text/javascript\">showmsg(\"{$msg}\", \"{$class}\")</script>";
	flush();
	ob_flush();
}




?>