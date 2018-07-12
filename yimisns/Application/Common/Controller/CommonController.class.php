<?php 
/**
 * 公共-控制层(ok)
 * @author berhp
 *
 */
namespace Common\Controller;
use Think\Controller;
use Common\Model;
class CommonController extends Controller{
	public $mdb;
	function _initialize() {
		$this->mdb = new Model\CommonModel();
	}
	
	/**
	 * 获取单条
	 */
	public function m_db_getone(){
		echo 1;
		die;
		$this->mdb->m_db_getone();
	}
	
	/**
	 * 生成分页功能,html_div
	 * @param $showData  // 包含有 page 分页信息的 showData数据
	 */
	public function create_html_pagebox($showData=array()){
		$page_param = ''; // 自定义参数
		$page_param_pub = array('page','pageSize');
		foreach( $_GET as $k=>$v ){
			if( ! in_array($k, $page_param_pub) ){
				$page_param .= '&'.$k.'='.$v;
			}
		}
	
		$html_string = '';
		if($showData['page'] && $showData['page']['total']){
			$html_string .= "<div class='pub_page'>";
			$html_string .= "<span>";
			$html_string .= "<a class='page_first' href='?page=1&pageSize={$showData['page']['limit']}{$page_param}'  style='display:none'></a>";
			if($showData['page']['page'] != 1) {
				$html_string .= "<a class='page_last' href='?page={$showData['page']['page_previous']}&pageSize={$showData['page']['limit']}{$page_param}'  ><i class='arrow_l'></i></a>";
			}
			$html_string .= "{$showData['page']['page']}/{$showData['page']['pageCount']}";
			if($showData['page']['page'] != $showData['page']['pageCount']) {
				$html_string .= "<a class='page_next' href='?page={$showData['page']['page_next']}&pageSize={$showData['page']['limit']}{$page_param}' ><i class='arrow_r'></i></a>";
			}
			$html_string .= "<a class='page_over' href='?page={$showData['page']['pageCount']}&pageSize={$showData['page']['limit']}{$page_param}' style='display:none'></a>";
			$html_string .= "</span>";
			$html_string .= "<span>";
			$html_string .= "<input type='hidden' name='pageSize_number' value='{$showData['page']['limit']}'></input>";
			$html_string .= "<input type='text' name='page_number'></input>";
			$html_string .= "<a class='page_go' name='page_go' href='javascript:;' onclick='pub_pagego(this)'>GO</a>";
			$html_string .= "</span>";
			$html_string .= "</div>";
			$html_string .= "<div class='clear'></div>";
		}
		return $html_string;
	}
	
}