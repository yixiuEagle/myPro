<?php
/**
 * 版本升级API
 * @author yangdong
 *
 */
namespace Version\Controller;
use Version\Model\VersionModel;
use Common\Api\Api;
class ApiController extends Api {
	function _initialize() {
		parent::_initialize();
	}
	function update(){
		$version = new VersionModel();
		$return  = $version->getVersion();
		$this->jsonOutput($return); 
	}
}