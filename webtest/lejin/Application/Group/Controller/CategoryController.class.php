<?php
/**
 * 类别管理
 */
namespace Group\Controller;
use Admin\Controller\CommonController;
use Group\Model\CategoryModel;
class CategoryController extends CommonController {
    protected $db;
    function _initialize() {
        parent::_initialize();
        $this->db = new CategoryModel();
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
            $limit = ($page - 1) * $rows . "," . $rows;
            $total = $this->db->where($map)->count();
            $list  = $total ? $this->db->public_list(0, $map, $limit) : array();
            $this->ajaxReturn(array('total'=>$total, 'rows'=>$list));
        }else {
            $this->currentpos = $this->menu_db->currentPos(I('menuid'));  //栏目位置
            $this->display('list');
        }
    }
    /**
     * 添加
     */
    function add(){
        if (IS_POST){
            $data = $_POST;
            if (!$data['name']) $this->error('请输入名称');
            if ($this->db->add($data)){
                $this->success('添加成功');
            }else {
                $this->error('添加失败');
            }
        }else {
            $this->rand = I('rand');
            $this->display('add');
        }
    }
    /**
     * 编辑
     * @param unknown $uid
     */
    function edit($id=0){
        if (IS_POST) {
            $data = $_POST;
            if (!$data['name']) $this->error('请输入名称');
            if ($this->db->where(array('id'=>$id))->save($data)){
                $this->success('编辑成功');
            }else {
                $this->error('编辑失败');
            }
        }else {
            $this->info = $this->db->find($id);
            $this->rand = I('rand');
            $this->display('edit');
        }
    }
    /**
     * 删除
     * @param unknown $uid
     */
    function delete($id){
        if (M('group')->where(array('cat_id'=>$id))->count()){
            $this->error('该类别下还有群，不能删除');
        }
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