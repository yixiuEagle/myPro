<?php
namespace Admin\Controller;
use Admin\Controller\CommonController;
class ServiceController extends CommonController {
    function servicelist($page=1,$rows=10,$search=array()){
        if(IS_POST){
	        $map=array();
	        if($search){
	            if ($search['name']){
	                $map = array('categoryid'=>$search['name']);
	            }
	        }
	        $limit=($page-1)*$rows.','.$rows;
	        $total=M('service')->where($map)->count();
	        $list=$total?M('service')->where($map)->limit($limit)->order('createtime desc')->select():array();
	        foreach ($list as $key=>$value){
	            //格式化时间
	            $list[$key]['createtime'] = date('Y-m-d H:i', $value['createtime']);
	            $id=$value['categoryid'];
	            //图片
	            $list[$key]['img']=makeHttpHead($value['img']);
	            $category=M('service_category')->where("id=$id")->find();
	            $list[$key]['type']=$category['name'];
	        }
	        $this->ajaxReturn(array('total'=>$total,'rows'=>$list));
	    }
	    $this->currentpos = $this->menu_db->currentPos(I('menuid'));  //栏目位置
	    $this->display('servicelist');
    }
    function servicetype($page=1,$rows=10,$search=array()){
        if(IS_POST){
	        $map=array();
	        if($search){
	            if ($search['name']){
	                $map = array('categoryid'=>$search['name']);
	            }
	        }
	        $limit=($page-1)*$rows.','.$rows;
	        $total=M('service_category')->where($map)->count();
	        $list=$total?M('service_category')->where($map)->limit($limit)->select():array();
	        foreach ($list as $key=>$value){
	            //格式化时间
	            //$list[$key]['createtime'] = date('Y-m-d H:i', $value['createtime']);
	            $id=$value['id'];
	            //图片
	            $list[$key]['img']=makeHttpHead($value['img']);
	            $category=M('service_category')->where("id=$id")->find();
	            $list[$key]['name']=$category['name'];
	        }
	        $this->ajaxReturn(array('total'=>$total,'rows'=>$list));
	    }
	    $this->currentpos = $this->menu_db->currentPos(I('menuid'));  //栏目位置
	    $this->display('servicetype');
    }
    
    function addservice(){
        if(IS_POST){
            $data=I('data','');
            if(empty($_FILES['file']['tmp_name'])){
                  $this->error('请选择文件!');
            }
            if($_FILES){
                $img=upload('/Picture/service/',0,'');
                $data['img']=$img['0']['smallUrl'];
            }
            if($data['categoryid']){
                $data['createtime']=NOW_TIME;
                $list=M('service')->add($data);
                if($list){
                    $this->success('添加成功');
                }else{
                    $this->error('添加失败');
                }
            }else{
                $this->error('请选择服务类型!');
            }
        }
        $this->display('addservice');
    }
    function addtype(){
        if(IS_POST){
            $data=I('data','');
            if(empty($_FILES['file']['tmp_name'])){
                $this->error('请选择文件!');
            }
            if($_FILES){
                $img=upload('/Picture/service/',0,'');
                $data['img']=$img['0']['smallUrl'];
            }
            //$data['createtime']=NOW_TIME;
            $list=M('service_category')->add($data);
            if($list){
                $this->success('添加成功');
            }else{
                $this->error('添加失败');
            }

        }
        $this->display('addtype');
    }
    //服务站点类别
    function category(){
        /* if(S('service_category')){
            $data = S('service_category');
        }else{ */
            $category=M('service_category')->select();
            $data=json_encode($category,JSON_UNESCAPED_UNICODE);
           /*  S('service_category', $data);
        } */
        echo $data;
    }
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
    function deleteservicetype($id=0){
        if($id){
            $list=M('service_category')->where("id=$id")->delete();
            if($list){
                $this->success('删除成功');
            }else{
                $this->error('删除失败');
            }
        }
    }
    
}