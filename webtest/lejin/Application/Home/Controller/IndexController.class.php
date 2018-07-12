<?php
namespace Home\Controller;
use Think\Controller;
class IndexController extends Controller {
	/**
	 * 首页
	 */
	public function index() {
		$this->redirect('Admin/Admin/index');
	}
	function test(){
	    echo '测试';
	}
}