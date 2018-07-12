<?php
/**
 * 数据库备份还原控制器
 * @author yangdong
 * 
 */
namespace Admin\Controller;
use Admin\Controller\CommonController;
use Think\Db;
class DatabaseController extends CommonController {
    function _initialize() {
        parent::_initialize();
    }
    /**
     * 数据库列表
     */
    function index(){
        if (IS_POST){
            $Db    = Db::getInstance();
            $list  = $Db->query('SHOW TABLE STATUS');
            $list  = array_map('array_change_key_case', $list);
            $this->ajaxReturn($list);
        }else {
            $this->currentpos = $this->menu_db->currentPos(I('menuid'));  //栏目位置
            $this->display('list');
        } 
    }
}