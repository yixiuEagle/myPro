<?php
/**
 * 会员管理
 */
namespace User\Controller;
use Admin\Controller\CommonController;
class MemberController extends CommonController {
    protected $db;
    function _initialize() {
        parent::_initialize();
        $this->db = M('user_member');
    }
    /**
     * 会员列表
     * @param number $page
     * @param number $rows
     * @param unknown $search
     */
    public function index($page=1, $rows=10, $search = array()){
        if(IS_POST){
            $total = $this->db->count();
            $list  = $this->db->order('id asc')->select();
            if ($list){
                foreach ($list as $k=>&$v){
                    $v['userimage'] = $v['userimage'] ? '是' : '否';
                    $v['groupimage'] = $v['groupimage'] ? '是' : '否';
                    $v['groupshow'] = $v['groupshow'] ? '是' : '否';
                    switch ($v['isvisible']) {
                        case 0:
                            $v['isvisible'] = '本地';
                            break;
                        case 1:
                            $v['isvisible'] = '本省';
                            break;
                        case 2:
                            $v['isvisible'] = '全国';
                            break;
                    }
                }
            }
            $data  = array('total'=>$total, 'rows'=>$list);
            $this->ajaxReturn($data);
        }else {
            $this->currentpos = $this->menu_db->currentPos(I('menuid'));  //栏目位置
            $this->display('list');
        }
    }
    /**
     * 会员编辑
     * @param int $id
     */
    public function edit($id){
        if(IS_POST){
            $data = $_POST;
            if ($this->db->save($data)){
                $this->success('编辑成功');
            }
            $this->error('编辑失败');
        }else {
            $info = $this->db->where(array('id'=>$id))->find();
            $this->assign('info', $info);
            $this->rand = $_REQUEST['rand'];
            $this->display('edit');
        }
    }
    // 删除
    public function delete($id) {
        if($id == '1') $this->error('该对象不能被删除');
        $result = $this->db->where(array('roleid'=>$id))->delete();
        if ($result){
            $this->success('删除成功');
        }else {
            $this->error('删除失败');
        }
    }
}