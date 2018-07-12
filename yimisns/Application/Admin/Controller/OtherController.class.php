<?php
namespace Admin\Controller;
use Admin\Controller\CommonController;
class OtherController extends CommonController {
       function joblist(){
           if(IS_POST){
               $list  =$this->getTree();
               $this->ajaxReturn($list);
           }
           $this->display('joblist');
       }
       /**
        * 添加打卡
        */
       function adddaka(){
           if(IS_POST){
               $data = I('data');
               $uid=$data['uid'];
               $type=$data['type'];
               $list=M('user')->where("uid=$uid")->find();
               if(!$list){
                   $this->error('请输入正确uid!');
               }
               if($type!=0){
                   if($_FILES){
                       $img=upload_multiple('Daka/',0,'');
                       foreach ($img as $k=>$v){
                           $path = $v['originUrl'];
                           if(strstr($path, ".mp4") || strstr($path, ".MP4")) {
                               $data['content'] = makeHttpHead($v['imgurl']);
                               $data['video']=makeHttpHead($v['smallUrl']);
                           }else{
                               $data['content'] = makeHttpHead($path);
                           }
                           break;
                       }
                   }
               }
               $data['name']=$list['nickname'];
               $data['headsmall']=$list['headsmall'];
               $data['createtime']=NOW_TIME;
               $id = M('daka')->add($data);
               if($id){
                   $this->success('添加成功');
               }else {
                   $this->error('添加失败');
               }
           }
           $this->display('adddaka');
       }
       /**
        * 删除打卡
        */
       function del($id){
           if($id && IS_POST){
               $result = M('daka')->where(array('id'=>$id))->delete();
               if($result){
                   $this->success('删除成功');
               }else {
                   $this->error('删除失败');
               }
           }else{
               $this->error('删除失败');
           }
       }
       /**
        * 打卡列表
        */
       function dakalist($page=1,$rows=10,$search=array()){
           if(IS_POST){
               $map=array();
               if($search){
                   if($search['name']){
                       $map['name'] = array('like','%'.$search['name'].'%');
                   }
               }
               $limit=($page-1)*$rows.','.$rows;
               $total=M('daka')->where($map)->count();
               $list=$total?M('daka')->where($map)->limit($limit)->order('createtime desc')->select():array();
                foreach ($list as $key=>$value){
    	            //格式化时间
    	            $list[$key]['createtime'] = date('Y-m-d H:i', $value['createtime']);
    	            $list[$key]['headsmall'] =makeHttpHead($value['headsmall']);
    	        }
               $this->ajaxReturn(array('total'=>$total,'rows'=>$list));
               
           }
           $this->currentpos = $this->menu_db->currentPos(I('menuid'));  //栏目位置
           $this->display('dakalist');
       }
       
	//职业列表
	function getTree($parentId = 0) {
	    $field = array('id','`name`');
		$order = '`id` DESC';
	    $data = M('job')->field($field)->where(array('parentId'=>$parentId))->order($order)->select();
	    if (is_array($data)){
	        foreach ($data as &$arr){
	            $arr['children'] = $this->getTree($arr['id']);
	        }
	    }
	    return $data;
	} 
       
	//添加
	function add($parentId = 0){
	    if(IS_POST){
	        $data = I('info');
	        if(empty($_FILES['file']['tmp_name'])){
	            $this->error('请选择文件!');
	        }
	        if($_FILES){
	            $img=upload('/Picture/adv/',0,'');
	            $data['icon']=makeHttpHead($img['0']['smallUrl']);
	        }
	        $id = M('job')->add($data);
	        if($id){
	            $this->success('添加成功');
	        }else {
	            $this->error('添加失败');
	        }
	    }else{
	        $this->assign('parentid', $parentId);
	        $this->display('addjob');
	    }
	}
	//编辑
	function edit($id = 0){
	    if(!$id) $this->error('未选择');
	    if(IS_POST){
	        $data = I('info');
	        if($_FILES){
	            $img=upload('/Picture/adv/',0,'');
	            $data['icon']=makeHttpHead($img['0']['smallUrl']);
	        }
	        $result = M('job')->where(array('id'=>$id))->save($data);
	        if($result){
	            $this->success('修改成功');
	        }else {
	            $this->error('修改失败');
	        }
	    }else{
	        $data = M('job')->where(array('id'=>$id))->find();
	        $this->assign('data', $data);
	        $this->display('editjob');
	    }
	}
	//删除
	function delete($id = 0){
	    if($id && IS_POST){
	        $result = M('job')->where(array('id'=>$id))->delete();
	        if($result){
	            $this->success('删除成功');
	        }else {
	            $this->error('删除失败');
	        }
	    }else{
	        $this->error('删除失败');
	    }
	}
    function public_selectTree(){
        $data = $this->getSelectTree();
        $data = array(0=>array('id'=>0,'text'=>'作为一级菜单','children'=>$data));
        $this->ajaxReturn($data);
    }
    //下拉列表
    public function getSelectTree($parentid = 0){
        $field = array('id','`name` as `text`');
        $order = '`id` DESC';
        $data = M('job')->field($field)->where(array('parentId'=>$parentid))->order($order)->select();
        if (is_array($data)){
            foreach ($data as &$arr){
                $arr['children'] = $this->getSelectTree($arr['id']);
            }
        }
        return $data;
    }   
       
    
    
    
       
       
      function jubao($page=1,$rows=10,$search=array()){
          if(IS_POST){
              $map=array();
              if($search){
                   if($search['name']){
                       $map['fid'] = array('EQ',$search['name']);
                   }
              }
              $limit=($page-1)*$rows.','.$rows;
              $total=M('jubao')->where($map)->count();
              $list=$total?M('jubao')->where($map)->limit($limit)->order('createtime desc')->select():array();
              $type=M(jubao_type);
              foreach ($list as $k=>$v){
                  $list[$k]['createtime']=date('Y-m-d H:i',$v['createtime']);
                  $id=$v['type'];
                  $jubaotype=$type->field('name')->where("id=$id")->find();
                  $list[$k]['type']=$jubaotype['name'];
              }
              $this->ajaxReturn(array('total'=>$total,'rows'=>$list));
              
          }
          $this->currentpos = $this->menu_db->currentPos(I('menuid'));  //栏目位置
          $this->display('jubao');
      }
      function jubaotype($page=1,$rows=10,$search=array()){
          if(IS_POST){
              $map=array();
              if($search){
      
              }
              $limit=($page-1)*$rows.','.$rows;
              $total=M('jubao_type')->where($map)->count();
              $list=$total?M('jubao_type')->where($map)->limit($limit)->select():array();
              $this->ajaxReturn(array('total'=>$total,'rows'=>$list));
      
          }
          $this->currentpos = $this->menu_db->currentPos(I('menuid'));  //栏目位置
          $this->display('jubaotype');
      }
      function deletetype($id){
          if($id){
              $data=M('jubao_type')->where("id=$id")->delete();
              if($data){
                  $this->success('删除成功');
              }else {
                  $this->error('删除失败');
              }
          }
      }
      function addtype($name=''){
          if(IS_POST){
              if($name){
                  $data['name']=$name;
                  $list=M('jubao_type')->add($data);
                  if($list){
                      $this->success('添加成功');
                  }else {
                      $this->error('添加失败');
                  }
              }
          }
          $this->display('addtype');
      }
      function updatetype($id){
          if(IS_POST){
              $name=I('data','');
              if($name){
                  $list=M('jubao_type')->where("id=$id")->save($name);
                  if($list){
                      $this->success('修改成功');
                  }else {
                      $this->error('修改失败');
                  }
              }
          }
          $data=M('jubao_type')->where("id=$id")->find();
          $this->assign('data',$data);
          $this->display('updatetype');
      }
      function appunload(){
          if(IS_POST){
              $data=I('data','');
              if($_FILES){
                  $img=upload_multiple('/Picture/Map/',0,'');
                  $data['mapurl']=$img['0']['originUrl'];
              }
              if(empty($data['mapurl'])){
                  $this->error("请上传正确的文件");
                  return ;
              }
              $data['createtime']=NOW_TIME;
              $re=M('map')->add($data);
              if($re){
                  $this->success('添加成功');
              }else{
                  $this->error('添加失败');
              }
          }
          $this->currentpos = $this->menu_db->currentPos(I('menuid'));  //栏目位置
          $this->display('addmap');
      }
      
      
      
      
      
}