<?php
namespace User\Controller;

class IndexController extends \Admin\Controller\CommonController {

	public function _initialize(){
		parent::_initialize();

	}
	//首页
	function index() {
		$this->display('index');
	}
	
}