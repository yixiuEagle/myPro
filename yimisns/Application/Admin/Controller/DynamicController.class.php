<?php
namespace Admin\Controller;
use Admin\Controller\CommonController;
class DynamicController extends CommonController {
     function dynamiclist($page=1,$rows=10,$search=array()){
         if(IS_POST){
             $map=array();
             $map=array('isalbum'=>0);
             if($search){
            	if ($search['name']){
                             $uid=$search['name'];
                             $map=array('uid'=>$uid);
            	}
             }
             $limit=($page - 1) * $rows . "," . $rows;
             $total=M('dynamic')->where($map)->count();
             $list=$total?M('dynamic')->where($map)->limit($limit)->order('createtime desc')->select():array();
             foreach ($list as $k=>$v){
                 $id=$v['id'];
                 $data=M('dynamic_pic')->field('path')->where("dynamicid=$id")->find();
                 $list[$k]['img']=makeHttpHead($data['path']);
                 $list[$k]['createtime']=date('Y-m-d H:i',$v['createtime']);
             }
             $this->ajaxReturn(array('total'=>$total,'rows'=>$list));
         }
         $this->currentpos = $this->menu_db->currentPos(I('menuid'));  //栏目位置
         $this->display('list');
     }
     function shield(){
         $id=I('id',0);
         $d=M('dynamic')->field("is_public")->where("id=$id")->find();
         if($d['is_public']==1){
             $public=array('is_public'=>2);
             $data=M('dynamic')->where("id=$id")->save($public);
             if($data){
                 $this->success('屏蔽成功');
             }else{
                 $this->error("屏蔽失败");
             }
         }
         if($d['is_public']==2){
             $public=array('is_public'=>1);
             $data=M('dynamic')->where("id=$id")->order('createtime desc')->save($public);
             if($data){
                 $this->success('取消屏蔽成功');
             }else{
                 $this->error("取消屏蔽失败");
             }
         }
     }
}