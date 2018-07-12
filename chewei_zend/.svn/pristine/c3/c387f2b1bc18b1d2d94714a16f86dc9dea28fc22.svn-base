<?php
namespace Home\Controller;
use Think\Controller;
class IndexController extends Controller {
	/** PC电脑端的 显示页面 **/
	public function index_2() {
		header('Content-Type:text/html; charset=utf-8');
 		$this->assign('title', "首页 | 欢迎光临");
		$this->display();
	}
	
	/** PC电脑端的 显示页面 **/
	/**
	 * 首页
	 */
	public function index() {
		header('Content-Type:text/html; charset=utf-8');
		$this->assign('title', "首页 | 艾生活 e-life");
		$this->display();
	}
	
	/**
	 * 联系我们
	 */
	function contacts(){
		$this->assign('title', "联系我们 | 熟人生活圈 -- 手机会员卡");
		$this->display();
	}
	
	/**
	 * android下载 - 用户版
	 */
	function android_download(){
		header('Content-Type:text/html; charset=utf-8');
		/** 查询app_version表type=android最新发布的 **/
		$where = "type='android'";
		$order = "id DESC";
		$apk = M('version')->where( $where )->order( $order )->find();
		if(!$apk)
		{
			echo '暂时还没有发布最新版本';
			return;
		}
		$filename	=	$apk['url'];
		redirect( $filename );
	}

	
	/**
	 * android下载 - 商家版
	 */
	function android_download_shop(){
		header('Content-Type:text/html; charset=utf-8');
		/** 查询app_version表type=android最新发布的 **/
		$where = "type='android'";
		$order = "id DESC";
		$apk = M('version_shop')->where( $where )->order( $order )->find();
		if(!$apk)
		{
			echo '暂时还没有发布最新版本';
			return;
		}
		$filename	=	$apk['url'];
		redirect( $filename );
	}
	
	
	/**
	 * android下载 - 司机版
	 */
	function android_download_driver(){
		header('Content-Type:text/html; charset=utf-8');
		/** 查询app_version表type=android最新发布的 **/
		$where = "type='android'";
		$order = "id DESC";
		$apk = M('version_driver')->where( $where )->order( $order )->find();
		if(!$apk)
		{
			echo '暂时还没有发布最新版本';
			return;
		}
		$filename	=	$apk['url'];
		redirect( $filename );
	}
	
	
	/**
	 * ios正式版下载 - 用户版
	 */
	function iphone_download(){
		header('Content-Type:text/html; charset=utf-8');
		echo '暂时还没有发布最新版本';
		//$url = "https://itunes.apple.com/us/app/shu-ren-sheng-huo-quan-jiang/id852063555?l=zh&ls=1&mt=8";
		//$url = "https://itunes.apple.com/cn/app/shu-ren-sheng-huo-quan/id941679882?mt=8";
		//redirect($url);
	}


	/**
	 * ios正式版下载 - 商家版
	 */
	function iphone_download_shop(){
		header('Content-Type:text/html; charset=utf-8');
		echo '暂时还没有发布最新版本';
		//$url = "https://itunes.apple.com/us/app/shu-ren-sheng-huo-quan-jiang/id852063555?l=zh&ls=1&mt=8";
		//$url = "https://itunes.apple.com/cn/app/shu-ren-sheng-huo-quan/id941679882?mt=8";
		//redirect($url);
	}
	
	/**
	 * ios正式版下载 - 司机版
	 */
	function iphone_download_driver(){
		header('Content-Type:text/html; charset=utf-8');
		echo '暂时还没有发布最新版本';
		//$url = "https://itunes.apple.com/us/app/shu-ren-sheng-huo-quan-jiang/id852063555?l=zh&ls=1&mt=8";
		//$url = "https://itunes.apple.com/cn/app/shu-ren-sheng-huo-quan/id941679882?mt=8";
		//redirect($url);
	}
}