<?php
namespace User\Controller;
use Think\Controller;
use User\Model\PushModel;
use User\Model\UserModel;
use Admin\Model\MenuModel;
use Message\Model\MessageModel;
class PushController extends Controller {
	function ios(){
		$push = new PushModel();
		//$push->pushtoios_offlinemsg();
		$push->handleIosPush();
	}
	function newpage(){
	    $id=I('id',0);
	    if($id){
            $data=M('pushmsg')->where("id=$id")->find();
            $this->assign('title',$data['content']);
            $this->assign('data',htmlspecialchars_decode($data['webpage']));
            $this->display('newpage');
	    }
	}
function pushlist($page=1,$rows=10,$search=array()){
	    if(IS_POST){
	        $map=array();
	        if($search){
	            if ($search['name']){
	                $map['name'] = array('like','%'.$search['name'].'%');
	            }
	        }
	        $limit=($page-1)*$rows."," .$rows;
	        $total=M('pushmsg')->where($map)->count();
	        $list=$total?M('pushmsg')->where($map)->limit($limit)->order('createtime desc')->select():array();
	        foreach ($list as $key=>$value){
	            //格式化时间
	            $list[$key]['createtime'] = date('Y-m-d H:i', $value['createtime']);
	        }
	        $this->ajaxReturn(array('total'=>$total,'rows'=>$list));
	    }
	    $mo=new MenuModel();
	    $this->currentpos = $mo->currentPos(I('menuid'));  //栏目位置
	    $this->display('pushlist');
	}
	//推送新闻消息
	function pushnew(){
	 if(IS_POST){
	        $data=I('data','');
	        $msg=$data['msg'];
	        if($data['uid']){
	            $u=M('user')->where(array('uid'=>$data['uid']))->find();
	            if(!$u){
	                $this->error('uid不正确!');
	            }
	            $fromdata = array(
		            'nickname' => $u['nickname'],
		          	'headsmall'	=> $u['headsmall']
		          );
	            $msgid=$this->message($msg,$data['webpage'],$data['uid']);
	            $url=M('pushmsg')->field('url')->where("id=$msgid")->find();
	            $mssage=new MessageModel();
	            $uid=$data['uid'];
	            $list=M('user')->where("usertype=0")->select();
	            foreach ($list as $k=>$v){
	                 $todata = array(
		                'nickname' => $v['nickname'],
		          		'headsmall'	=> $v['headsmall']
		               );
	                $mssage->msg($uid, $v['uid'],$url['url'], $fromdata, $todata);
	            }
	            $this->success('推送成功');
	        }else{
                $user=new UserModel();
                $msgid=$this->message($msg,$data['webpage']);
                $url=M('pushmsg')->field('url')->where("id=$msgid")->find();
                $fid=$user->field('uid')->where(array('usertype'=>0))->select();
                foreach ($fid as $k=>$v){  
                  $user->pushmsg($v['uid'],$msg,$url['url']);
                }
                    if($fid){
                        $this->success('推送成功');
                    }else{
                        $this->error('推送失败');
                    }
                }
	        }
	    $this->display('pushnew');
	}
    /**
     * 推送文字消息
     */
	function pushtext(){
	    if(IS_POST){
	        $data=I('data','');
	        $msg=$data['msg'];
	        if($data['uid']){
	            $u=M('user')->where(array('uid'=>$data['uid']))->find();
	            if(!$u){
	                $this->error('uid不正确!');
	            }
	            $fromdata = array(
		            'nickname' => $u['nickname'],
		          	'headsmall'	=> $u['headsmall']
		          );
	            $this->message($msg,0,$data['uid']);
	            $mssage=new MessageModel();
	            $uid=$data['uid'];
	            $list=M('user')->where("usertype=0")->select();
	            foreach ($list as $k=>$v){
	                 $todata = array(
		              'nickname' => $v['nickname'],
		          		'headsmall'	=> $v['headsmall']
		               );
	                $mssage->msg($uid, $v['uid'],$msg, $fromdata, $todata);
	            }
	            $this->success('推送成功');
	        }else{
	           $this->message($msg);
	           $user=new UserModel();
	           $fid=$user->field('uid')->where(array('usertype'=>0))->select();
	           foreach ($fid as $k=>$v){
	               $user->sendSysNotice($v['uid'],$msg,1016);
	           }
	           if($fid){
	               $this->success('推送成功');
	           }else{
	               $this->error('推送失败');
	           }
	        }
	    }
	    $this->display('pushtext');
	}
	function message($msg,$webpage='',$uid=0){
	    if($webpage&&$uid){
	        $da['webpage']=$webpage;
	        $da['type']=2;
	        $da['uid']=$uid;
	    }else if($webpage){
	        $da['webpage']=$webpage;
	        $da['type']=2;
	    }else if($uid){
	        $da['type']=1;
	        $da['uid']=$uid;
	    }else{
	        $da['type']=1;
	    }
        
	    $da['content']=$msg;
	    $da['createtime']=NOW_TIME;
	    $status=M('pushmsg')->add($da);
	    if($webpage&&$status){
	       $url=makeHttpHead('/index.php/User/Push/newpage?id='.$status);
	       M('pushmsg')->where("id=$status")->save(array('url'=>$url));
	    }
	    return $status;
	}
}