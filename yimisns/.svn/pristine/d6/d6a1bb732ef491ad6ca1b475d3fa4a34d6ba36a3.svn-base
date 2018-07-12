<?php
namespace Lincense\Controller;
use Admin\Controller\CommonController;
use Lincense\Model\LincenseModel;
use Lincense;
class IndexController extends CommonController {
	private $lincense_db;
	private $lincense_info;		
	private $id = 1;
	private $sn = "uiow92384!dd@#5^&*(-==9@@(==)";
	private $xizue;
	public function _initialize(){
		parent::_initialize();
		$this->lincense_db = new LincenseModel();
	}
	/**
	 * 获取lincense
	 */
	function index() {
		$lincense = Lincense\Controller\Lincense::getInstance();
		if(!$lincense)
			return $this->error("获取lincense失败");
		$result = $lincense->auth_info();
		if(!$result)
			return $this->error("获取lincense失败");
		$this->assign("info", (Array)$result);
		$this->currentpos = $this->menu_db->currentPos(I('menuid'));  
		$this->display('index');
	}
	/**
	 * 更新
	 * @param string $lincense
	 */
	function setLincense($lincense='') {
		if(IS_POST){
			if(!$lincense)
				return $this->error("请输入Lincense信息");
			
			$lincense_instanll = Lincense\Controller\Lincense::getInstance();
			$result = $lincense_instanll->set_lincense($lincense);
			if(!$result)
				return $this->error("更新Lincense信息失败");
			
			if($result['code'] != 0)
				return $this->error($result['msg']);
			
			return $this->success("更新Lincense信息成功");
		}else {
			$this->currentpos = $this->menu_db->currentPos(I('menuid'));  
			$this->display('setlincense');
		}
	}
	/**
	 * 删除
	 */
	function delLincense() {
		$lincense_instanll = Lincense\Controller\Lincense::getInstance();
		$result = $lincense_instanll->del_lincense();
		if(!$result)
			return $this->error("删除Lincense信息失败");
		
		if($result['code'] != 0)
			return $this->error($result['msg']);
		
		return $this->success("删除Lincense信息成功");
	}

}