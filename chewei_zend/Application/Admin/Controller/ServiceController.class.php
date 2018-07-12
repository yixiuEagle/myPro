<?php
namespace Admin\Controller;
use Admin\Controller\CommonController;
class ServiceController extends CommonController {
    function serviceList($page=1,$rows=10,$search=array()){
        if(IS_POST){
	        $map=array();
	        if($search){
	            if ($search['name']){
	                $map['phone'] = array('like','%'.$search['name'].'%');
	            }
	        }
	        $limit=($page-1)*$rows.','.$rows;
	        $total=M('service')->where($map)->count();
	        $list=$total?M('service')->where($map)->limit($limit)->select():array();
	        $this->ajaxReturn(array('total'=>$total,'rows'=>$list));
	    }
	    $this->currentpos = $this->menu_db->currentPos(I('menuid'));  //栏目位置
	    $this->display('serviceList');
    }
    /**
     * 添加服务号
     */
    function addservice(){
        if(IS_POST){
            $data=I('data','');
            if($data){
                $r=M('service')->where(array('phone'=>$data['phone']))->find();
                if($r){
                    $this->error('此电话号码已存在');
                }
                $data['createtime']=NOW_TIME;
                $list=M('service')->add($data);
                if($list){
                    $this->success('添加成功');
                }else{
                    $this->error('添加失败');
                }
            }else{
                $this->error('添加失败!');
            }
        }
        $this->display('addservice');
    }
    /**
     * 编辑
     */
    function editservice($id){
        if(IS_POST){
            $data=I('info','');
            if($data){
                $re=M('service')->where(array('id'=>$id))->save($data);
                if($re){
                    $this->success('编辑成功');
                }else{
                    $this->error('编辑失败');   
                }
            }
        }
        $ser=M('service')->where(array('id'=>$id))->find();
        $this->assign('info',$ser);
        $this->display('editservice');
    }
    /**
     * 删除
     * @param number $id
     */
    function deleteservice($id=0){
        if($id){
            $list=M('service')->where("id=$id")->delete();
            if($list){
                $this->success('删除成功');
            }else{
                $this->error('删除失败');
            }
        }
    }
    
}