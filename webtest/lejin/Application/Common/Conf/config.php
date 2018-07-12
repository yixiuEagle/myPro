<?php
return array(
		/* 数据库设置 */
		'DB_TYPE'               => 'mysql',		// 数据库类型
		'DB_HOST'               => 'localhost',     // 服务器地址
		'DB_NAME'               => 'lejin',     // 数据库名
		'DB_USER'               => 'root',     // 用户名
		'DB_PWD'                => '',      // 密码
        /* 'DB_HOST'               => '120.24.61.200',     // 服务器地址
        'DB_NAME'               => 'lejin',     // 数据库名
        'DB_USER'               => 'root',     // 用户名
        'DB_PWD'                => 'Root123456',      // 密码 */
		'DB_PORT'               => '3306',     // 端口
		'DB_PREFIX'             => 'tc_',   // 数据库表前缀
        'OP_SECRET'				=> 'thinkchat_!@#456',
		//数据库配置1
		'DB_CONFIG1' => 'mysqli://root:Root123456@127.0.0.1:3306/lejin',
		//数据库配置2
		'DB_CONFIG2' => 'mysqli://root:Root123456@127.0.0.1:3306/openfire',
		//消息服务器地址
		'OP_SERVER'				=> '127.0.0.1:9090',
		/* 加载额外的配置文件 */
		'LOAD_EXT_CONFIG' 		=> 'module,push,pay',
		
		/* Cookie设置 */
		'COOKIE_EXPIRE'         => 0,                 // Coodie有效期
		'COOKIE_DOMAIN'         => '',                // Cookie有效域名
		'COOKIE_PATH'           => '/',               // Cookie路径
		'COOKIE_PREFIX'         => '',                // Cookie前缀 避免冲突
		
		/* SESSION设置 */
		'SESSION_AUTO_START'    => true,              // 是否自动开启Session
		'SESSION_OPTIONS'       => array(),           // session 配置数组 支持type name id path expire domain 等参数
		'SESSION_TYPE'          => '',                // session hander类型 默认无需设置 除非扩展了session hander驱动
		'SESSION_PREFIX'        => '',                // session 前缀
		
		'DEFAULT_FILTER'        => '',

		/* 模板解析设置 */
		'TMPL_PARSE_STRING'     => array(
				'__PUBLIC__' => __ROOT__ . '/Public',
		),
		
		/* URL设置 */
		'URL_CASE_INSENSITIVE'  => false,              // 默认false 表示URL区分大小写 true则表示不区分大小写
        'UPDATE_SUPPLIER_SCORE_TIME'  => '04:00:00',   // 更新商家的评分时间
        'USER_ACTIVITY_SOURCE_DATE'  => '01',   // 用户30天发布活动和资源计算的起始日01=当月的1号
        'FIND_PAY_PRE'  => 'F',   // 发现订单支付，订单号前缀
        'ORDER_PAY_PRE'  => 'O',   // 订单支付，订单号前缀
        'BACK_PAY_PRE'  => 'B',   // 退款，订单号前缀
        'RECHAREGE_PAY_PRE'  => 'R',   // 用户充值
);