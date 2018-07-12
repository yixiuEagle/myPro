<?php
namespace Admin\Controller;
use Admin\Controller\CommonController;
class AdvController extends CommonController {
     function advlist($page=1, $rows=10, $search = array()){
         if(IS_POST){
                $map   = array();
                if ($search) {
                    if ($search['type']){
                        $map['type'] = array('like','%'.$search['type'].'%');
                    }
                }
                $limit = ($page - 1) * $rows . "," . $rows;
                $total = M('adv')->count();
    		    $list  =$total ? M('adv')->where($map)->limit($limit)->select():array();
    		    $this->ajaxReturn(array('total'=>$total, 'rows'=>$list));
    	}else {
    			$this->currentpos = $this->menu_db->currentPos(I('menuid'));  //栏目位置
    			$this->display('advlist');
    	}
    }
	function advdel(){
	    $id=I('id',0);
	    if($id){
	        $data=M('adv')->where("id=$id")->delete();
	        if($data){
                $this->success('删除成功');
	        }else{
                $this->error("删除失败");
	        }
	    }else{
            $this->error("删除失败");
    	}
    }
	function edit($id){
	    if(IS_POST){
            $data=I('data','');
            $files = M('adv')->where(array('id'=>$id))->find();
            if($_FILES['file']['name']){
                 $re=unlink(".".$files['img']);
                 if(!$re){
                 $this->error('删除旧地图文件失败');
                 return;
                 }
                 $img=upload_multiple('/Picture/adv/',0,'');
                 $data['img']=makeHttpHead($img['0']['originUrl']);
                 $data['updatetime']=NOW_TIME;
             } 
            if($data){
                $list=M('adv')->where(array('id'=>$id))->save($data);
                if($data['img']){
                    M('adv')->where(array('img'=>$files['img']))->save(array('img'=>$data['img']));
                }
                if($list){
                    $this->success('编辑成功');
                }else{
                    $this->error('编辑失败');
                }
            }else{
                $this->error('编辑失败');
            }
	    }
	    $adv=M('adv')->field('id,type,sort,begintime,spacetime')->where(array('id'=>$id))->find();
	    $this->assign('data',$adv);
	    $this->display('editadv');
	}
    function add(){
        if(IS_POST){
            $data = I('data');
            if($data){
                if(empty($_FILES['file']['tmp_name']) && empty($data['img'])){
                    $this->error('请选择文件!');
                }
                if($_FILES){
                    $img=upload('/Picture/adv/',0,'');
                    //$da['img']=makeHttpHead($img['0']['smallUrl']);
                    $da['img']=makeHttpHead($img['0']['originUrl']);    
                }else{
                    $da['img']=$data['img'];
                }
                $da['begintime']=$data['begintime'];
                $da['spacetime']=$data['spacetime'];
                //$da['pos']=$data['pos'];
                //$da['sort']=$data['sort'];
                $da['type']=$data['type'];
                $da['createtime']=NOW_TIME;
                /* if($data['type']==1){
                    $da['advpage']=$data['advpage'];
                }else if($data['type']==0){
                     if(strpos($data['url'], "http://") === false&&$data['url']) {
                        $da['url'] =  SITE_PROTOCOL. $data['url'];
                    }else{
                        $da['url'] =  $data['url'];
                    }
                } */
                
                $list=M('adv')->add($da);
                /* if($list&&$data['type']==1){
                    $ad['url']=makeHttpHead('/index.php/Admin/Adv/advpage?id='.$list);
                    M('adv')->where("id=$list")->save($ad);
                } */
                if($list){
                    $this->success('添加成功');
                }else{
                    $this->error("添加失败");
                }
            }else{
                $this->error("添加失败");
            }
        } 
        $this->currentpos = $this->menu_db->currentPos(I('menuid'));  //栏目位置
        $pics=M('adv')->field("img")->select();
        $this->assign('data',$pics);
        $this->display('createadv');
    }
    //广告页面
    function advpage(){
        $id=I('id',0);
        if($id){
            $data=M('adv')->where("id=$id")->find();
            $this->assign('data',htmlspecialchars_decode($data['advpage']));
            $this->display('advpage');
        }
    }
    function pic(){
        $pics=M('adv')->field("img")->select();
        $this->ajaxReturn($pics);
    }
	
}