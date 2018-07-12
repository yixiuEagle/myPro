文件夹说明
	Public 		-- 存放一些公共的资源文件 比如 js css images等。
	ThinkPHP   	-- THinkphp的框架 最好不要做任何的更改，版本是3.2.2。
	Data   		-- 存放一些数据文件 比如整个网站用到的图片。
	Application -- 整个网站要实现的功能在此处实现
	Application
		Common -- 公共模块 可以放一些自定义的文件
		Common -- Tools 一些自定义的类文件 请以 XXX.class.php命名. 调用方法 比如： new \Common\Tools\Checkcode();
		Common -- Data  一些数据文件,自定义类，函数等用到的数据文件。
		Common -- Func  一些自定义的函数 请以 xxx.func,php命名 调用方法 比如：load('Func.Sys#func', COMMON_PATH);
		Common -- Common -- function.php 整个系统用到的公共函数是自动加载，不用手动调，直接可以用。
		Common -- Conf -- config.php 整个系统用到的配置文件
		
		Admin 实现所有的后台功能
				在某一个功能类当中，如果某一个函数是公共的验证作用，以public_xx命名。这样的命名将不会受到权限管理的限制
		Api	  实现所有的接口功能
		Home  实现所有的前端功能
	
	额外的说明：
	
	另外不知道怎么用Thinkphp的，请自己上官网去查看别人的文档
	后台用到的是 jquery easyui框架，不明白的可以上官网查看使用方法。
	
	如果进入后台首页报错 not found class 'COM'
	★ php 根目录的 ext 文件夹下确保存有 php_com_dotnet.dll 这个文件
	★ php.ini 确保有此语句
	extension=php_com_dotnet.dll
	
