<?php
return array(
		/* 数据库设置 */
		'DB_TYPE'               => 'mysqli',			// 数据库类型
		'DB_HOST'               => '127.0.0.1',     	// 服务器地址
		'DB_NAME'               => 'chewei',     		// 数据库名
		'DB_USER'               => 'root',    			 // 用户名
		//'DB_PWD'                => 'root',      		// 密码
        'DB_PWD'                => '',      		// 密码
		'DB_PORT'               => '3306',     			// 端口
		'DB_PREFIX'             => 'tc_',   			// 数据库表前缀
		
		'APP_SECRET_CHECK'		=> false,				// 接口是否进行数据有效性验证,设置为false后，不会对md5验证，也不会对token进行验证。
		'APP_SECRET'			=> '123456',			// 接口秘钥
		
		//数据库配置1
		'DB_CONFIG1' => 'mysqli://root:root@127.0.0.1:3306/xframe',
		//数据库配置2
		'DB_CONFIG2' => 'mysqli://root:root@127.0.0.1:3306/openfire',
		
		// 是否启用thinkchat即时通讯
		'OP_THINKCHAT_CHECK'		=> false,
		//消息服务器地址
		'OP_SERVER'				=> '127.0.0.1:9090',
		/* 加载额外的配置文件 */
		'LOAD_EXT_CONFIG' 		=> 'module,push,language',
		
		/* APP设置 */
		'FRAMEWORK_VERSION'         => '1.0',           	// 站点版本号
		'WEBSITE_NAME'         		=> '西竹PHP Web',      	// 站点名称
		
		/* Cookie设置 */
		'COOKIE_EXPIRE'         => 0,                 		// Coodie有效期
		'COOKIE_DOMAIN'         => '',                		// Cookie有效域名
		'COOKIE_PATH'           => '/',               		// Cookie路径
		'COOKIE_PREFIX'         => '',               		// Cookie前缀 避免冲突
		
		/* SESSION设置 */
		'SESSION_AUTO_START'    => true,              		// 是否自动开启Session
		'SESSION_OPTIONS'       => array(),           		// session 配置数组 支持type name id path expire domain 等参数
		'SESSION_TYPE'          => '',                		// session hander类型 默认无需设置 除非扩展了session hander驱动
		'SESSION_PREFIX'        => '',                		// session 前缀
		
		/* 模板解析设置 */
		'TMPL_PARSE_STRING'     => array(
				'__PUBLIC__' => __ROOT__ . '/Public',
		),
		
		/* URL设置 */
		'URL_CASE_INSENSITIVE'  => false,              		// 默认false 表示URL区分大小写 true则表示不区分大小写
);