<?php
/**
 * 类别管理
 */
namespace Find\Controller;
use Admin\Controller\CommonController;
use Find\Model\FindModel;
class ActivityController extends CommonController {
    protected $db;
    function _initialize() {
        parent::_initialize();
        $this->db = new FindModel();
    }
    /**
     * 用户列表
     * @param number $page
     * @param number $rows
     * @param array  $search
     */
    function index($page=1, $rows=10, $search = array()){
        if (IS_POST){
            $map   = array();
            $map['a.type'] = 1;
            $limit = ($page - 1) * $rows . "," . $rows;
            $total = $this->db->alias("a")->where($map)->count();
            $list  = $total ? $this->db->public_list(0, $map, $limit) : array();
            $this->ajaxReturn(array('total'=>$total, 'rows'=>$list));
        }else {
            $this->currentpos = $this->menu_db->currentPos(I('menuid'));  //栏目位置
            $this->display('list');
        }
    }
    /**
     * 删除
     * @param unknown $uid
     */
    function delete($id){
        if ($this->db->where(array('id'=>$id))->delete()) {
            $this->success('删除成功');
        }
        $this->error('删除失败');
    }
    /**
     * 上传图片
     */
    function public_upload() {
        $image = upload();
        if (is_array($image)) {
            $this->ajaxReturn(array('status'=>1, 'info'=>'上传成功', 'image'=>$image));
        }else {
            $this->ajaxReturn(array('status'=>0, 'info'=>$image));
        }
    }
}