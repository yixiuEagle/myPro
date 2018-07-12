<?php
namespace Admin\Controller;
use Admin\Controller\CommonController;
class SettingController extends CommonController {
    function _initialize() {
        parent::_initialize();
    }
    
    /**
     * 主图设置
     */
    function main(){
        if (IS_POST){
            $data = $_POST;
            $db   = M('background');
            if ($db->find()){
                if ($db->save($data)){
                    $this->success('修改成功');
                }
                $this->error('修改失败');
            }else {
                unset($data['id']);
                if ($db->add($data)){
                    $this->success('添加成功');
                }
                $this->error('添加失败');
            }
        }else {
            $this->currentpos = $this->menu_db->currentPos(I('menuid'));  //栏目位置
            $this->info = M('background')->find();
            $this->display();
        }
    }
    /**
     * 上传图片
     */
    function public_uploadHead() {
        $images = upload();
        if (is_array($images)){
            $this->ajaxReturn(array('status'=>1, 'info'=>$images, 'url'=>$images));
        }else {
            $this->ajaxReturn(array('status'=>0, 'info'=>$images));
        }
    }
    /**
     * 帮助中心
     */
    function helpcenter() {
        if (IS_POST){
            $data = $_POST['helpcenter'];
            if (S('helpcenter', $data)){
                $this->success('修改成功');
            }
            $this->error('修改失败');
        }else {
            $this->currentpos = $this->menu_db->currentPos(I('menuid'));  //栏目位置
            $this->content    = S('helpcenter') ? S('helpcenter') : '';
            $this->display();
        }
    }
    /**
     * 使用说明
     */
    function usement() {
        if (IS_POST){
            $data = $_POST['usement'];
            if (S('usement', $data)){
                $this->success('修改成功');
            }
            $this->error('修改失败');
        }else {
            $this->currentpos = $this->menu_db->currentPos(I('menuid'));  //栏目位置
            $this->content    = S('usement') ? S('usement') : '';
            $this->display('usement');
        }
    }
    /**
     * 注册协议
     */
    function regist() {
        if (IS_POST){
            $data = $_POST['regist'];
            if (S('regist', $data)){
                $this->success('修改成功');
            }
            $this->error('修改失败');
        }else {
            $this->currentpos = $this->menu_db->currentPos(I('menuid'));  //栏目位置
            $this->content    = S('regist') ? S('regist') : '';
            $this->display('regist');
        }
    }
    /**
     * 违规说明
     */
    function punishment() {
        if (IS_POST){
            $data = $_POST['punishment'];
            if (S('punishment', $data)){
                $this->success('修改成功');
            }
            $this->error('修改失败');
        }else {
            $this->currentpos = $this->menu_db->currentPos(I('menuid'));  //栏目位置
            $this->content    = S('punishment') ? S('punishment') : '';
            $this->display('punishment');
        }
    }
    /**
     * 会员说明
     */
    function memberment() {
        if (IS_POST){
            $data = $_POST['memberment'];
            if (S('memberment', $data)){
                $this->success('修改成功');
            }
            $this->error('修改失败');
        }else {
            $this->currentpos = $this->menu_db->currentPos(I('menuid'));  //栏目位置
            $this->content    = S('memberment') ? S('memberment') : '';
            $this->display('memberment');
        }
    }
}