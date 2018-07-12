<?php
/**
 * 城市管理
 */
namespace Admin\Controller;
use Admin\Controller\CommonController;
use Org\Util\String;
class JubaoController extends CommonController {
    protected $db;
    function _initialize() {
        parent::_initialize();
        $this->db = M('jubao_list');
    }
    /**
     * 列表
     * @param number $page
     * @param number $rows
     * @param unknown $search
     */
    function index($page=1, $rows=10, $search=array()){
        if (IS_POST) {
            $map = array();
            $limit = ($page - 1) * $rows . "," . $rows;
            $total = $this->db->where($map)->count();
            $list  = $total ? $this->db->where($map)->limit($limit)->order('id asc')->select() : array();
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
            if (!$data['content']) $this->error('请输入内容');
            if ($this->db->add($data)){
                $this->success('添加成功');
            }
            $this->error('添加失败');
        }else {
            $this->rand  = I('rand');
            $this->display();
        }
    }
    /**
     * 编辑
     */
    function edit($id=0){
        if (IS_POST){
            $data = $_POST;
            if (!$data['content']) $this->error('请输入内容');
            if ($this->db->save($data)){
                $this->success('修改成功');
            }
            $this->error('修改失败');
        }else {
            $this->info = $this->db->find($id);
            $this->rand  = I('rand');
            $this->display();
        }
    }
    /**
     * 删除
     */
    function delete($id=0) {
        if ($this->db->where(array('id'=>$id))->delete()){
            $this->success('删除成功');
        }
        $this->error('删除成功');
    }
    
    /**
     * 列表
     * @param number $page
     * @param number $rows
     * @param unknown $search
     */
    function jubao($page=1, $rows=10, $search=array()){
        if (IS_POST) {
            $map = array();
            $limit = ($page - 1) * $rows . "," . $rows;
            $total = M('jubao')->where($map)->count();
            $field = 'j.*,(select `name` from `'.C('DB_PREFIX').'user` where uid=j.uid) as uname';
            $list  = $total ? M('jubao')->alias('j')->field($field)->where($map)->limit($limit)->order('id desc')->select() : array();
            if ($total){
                foreach ($list as $k=>&$v){
                    $v['createtime'] = date('Y-m-d H:i', $v['createtime']);
                    $v['typetext']   = $v['type'] ? '群号' : '用户';
                    $v['isshield']   = 0;
                    if ($v['type']){
                        $v['fname'] = '群号：'.M('groups')->where(array('id'=>$v['otherid']))->getField('name');
                    }else {
                        $tmp = M('user')->field('name, isshield')->where(array('uid'=>$v['otherid']))->find();
                        $v['fname'] = '用户：'.$tmp['name'];
                        $v['isshield'] = $tmp['isshield'];
                    }
                    $v['uname'] = '用户：'.$v['uname'];
                }
            }
            $this->ajaxReturn(array('total'=>$total, 'rows'=>$list));
        }else {
            $this->currentpos = $this->menu_db->currentPos(I('menuid'));  //栏目位置
            $this->display('jubao_list');
        }
    }
    /**
     * 删除
     */
    function jubaoDelete($id=0) {
        if (M('jubao')->where(array('id'=>$id))->delete()){
            $this->success('删除成功');
        }
        $this->error('删除成功');
    }
    /**
     * 屏蔽用户
     */
    function jubaoShield($id) {
        $db = M('user');
        $isshield = $db->where(array('uid'=>$id))->getField('isshield');
        if ($isshield) $this->error('该用户已被屏蔽');
        
        if ($db->where(array('uid'=>$id))->setField('isshield', 1)){
            $this->success('屏蔽成功');
        }
        $this->error('屏蔽失败');
    }
    /**
     * 取消屏蔽
     */
    function cancelShield($id) {
        $db = M('user');        
        if ($db->where(array('uid'=>$id))->setField('isshield', 0)){
            $this->success('屏蔽成功');
        }
        $this->error('屏蔽失败');
    }
    //反馈意见
    /**
     * 发送消息
     */
    function message($id=0){
        if (IS_POST){
            $db  = new \Message\Model\MessageModel();
            $uid = $_POST['uid']; 
            $return = $db->message($uid);
            if ($return['code']){
                $this->error('发送失败');
            }
            $this->success('发送成功');
        }else {
            $user = M('user')->field('uid,name,head')->where(array('uid'=>$id))->find();
            $head = M('user_head')->where(array('id'=>$user['head']))->getField('smallUrl');
            $user['head'] = $head ? SITE_PROTOCOL.SITE_URL.$head : '';
            $user['tag']  = str_replace(array('{','}'), '', String::uuid());
            $this->touser = $user;
            $this->rand   = $_REQUEST['rand'];
            $this->display('jubao_message');
        }
    }
    /**
     * 检查用户
     */
    function public_checkUid(){
        $id = trim(I('name'));
        $exists = M('user')->where(array('uid'=>$id))->field('uid,name,head')->find();
        if ($exists) {
            $info = $exists;
            $head = M('user_head')->where(array('id'=>$exists['head']))->getField('smallUrl');
            $info['head'] = $head ? SITE_PROTOCOL.SITE_URL.$head : '';
            $this->error($info, '用户存在');
        }else{
            $this->success('用户名不存在');
        }
    }
    /**
     * 列表
     * @param number $page
     * @param number $rows
     * @param unknown $search
     */
    function feedback($page=1, $rows=10, $search=array()){
    	if (IS_POST) {
    		$map = array();
    		$limit = ($page - 1) * $rows . "," . $rows;
    		$map['_string'] = "u.uid=f.uid";
    		$total = M('feedback f, tc_user u')->where($map)->count();
    		$field = 'f.uid,f.createtime,content,name';
    		$list  = $total ? M('feedback f, tc_user u')->field($field)->where($map)->limit($limit)->order('createtime desc')->select() : array();
    		if ($total){
    			foreach ($list as $k=>&$v){
    				$v['createtime'] = date('Y-m-d H:i', $v['createtime']);
    			}
    		}
    		$this->ajaxReturn(array('total'=>$total, 'rows'=>$list));
    	}else {
    		$this->currentpos = $this->menu_db->currentPos(I('menuid'));  //栏目位置
    		$this->display('feedback_list');
    	}
    }
}