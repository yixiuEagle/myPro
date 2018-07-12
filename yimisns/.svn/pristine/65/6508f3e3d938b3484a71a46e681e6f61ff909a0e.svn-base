<?php
namespace User\Controller;
use Admin\Controller\CommonController;
use User\Model\UserModel;
use Lincense\Controller\Thinkchat;
use Think\Log;
class Test extends CommonController {
	private $user_db;
	function _initialize(){
		parent::_initialize();
		$this->user_db = new UserModel();
	}
	/**
	 * 删除动态
	 */
    function deletedynamic(){
        $result=D("dynamic")->where("id=68")->delete();
    }
}