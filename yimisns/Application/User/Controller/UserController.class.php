<?php
namespace User\Controller;
use Admin\Controller\CommonController;
use User\Model\UserModel;
use Lincense\Controller\Thinkchat;
use Think\Log;
class UserController extends CommonController {
	private $user_db;
	function _initialize(){
		parent::_initialize();
		$this->user_db = new UserModel();
	}
	/**
	 * 管理机器人浏览
	 */
	function robtmanage(){
	    if(IS_POST){
	        $type=I('data');
	        $type['time']=NOW_TIME;
	        $info=M("manage")->where("id=1")->save($type);
	        if ($info!==false){
	            $this->success('编辑成功');
	        }else{
	            $this->error("编辑失败");
	        }
	    }
	    $data=M('manage')->find();
	    $this->assign('data', $data); 
	    $this->display('manage');
	}
	/**
	 * 现场视频管理
	 */
	function videolist($page=1,$rows=10,$search=array()){
	    if(IS_POST){
	        $map=array();
	        if($search){
	            if ($search['name']){
	                $uid=$search['name'];
	                $map['uid']=array('like','%'.$uid.'%');
	            }
	        }
	        $limit=($page-1)*$rows.','.$rows;
	        $total=M('kuaipai')->where($map)->count();
	        $list=$total?M('kuaipai')->where($map)->limit($limit)->order('createtime desc')->select():array();
	        foreach ($list as $key=>$value){
	            //格式化时间
	            $list[$key]['createtime'] = date('Y-m-d H:i', $value['createtime']);
	            $list[$key]['img'] = makeHttpHead($value['img']);
	        }
	        $this->ajaxReturn(array('total'=>$total,'rows'=>$list));
	    }
	    $this->currentpos = $this->menu_db->currentPos(I('menuid'));  //栏目位置
	    $this->display('videolist');
	}
	/**
	 * 删除现场视频
	 */
	function delvideo(){
	    $id=I('id',0);
	    $list=M('kuaipai')->where("id=$id")->delete();
	    if($list){
	        $this->success('删除成功');
	    }else{
	        $this->error('删除失败');
	    }
	}
	/**
	 * 添加现场视频
	 */
	function addvideo(){
	    if(IS_POST){
	        $uid=I('uid',0);
	        if($uid){
	        $user=new UserModel();
	        $ee=$user->publish_kuaipai($uid,1);
	        if($ee['code']==0){
	            $this->success('发布成功');
	        }else{
	            $this->error($ee['msg']);
	        }
	       }
	    }
	    $this->display('addvideo');
	}
	/**
	 * 收益列表
	 */
	function worth($page=1,$rows=10,$search=array()){
	    if(IS_POST){
	        $map=array();
	        if($search){
	            if ($search['name']){
	                $map['name'] = array('like','%'.$search['name'].'%');
	            }
	            if($search['starttime']&&$search['endtime']){
	                $starttime=strtotime($search['starttime']);
	                $endtime=strtotime($search['endtime']);
	                $map['createtime']=array(array('EGT',$starttime),array('ELT',$endtime));
	            }
	        }
	        $limit=($page-1)*$rows.','.$rows;
	        $total=M('worth')->where($map)->count();
	        $list=$total?M('worth')->where($map)->limit($limit)->order('createtime desc')->select():array();
	        foreach ($list as $key=>$value){
	            //格式化时间
	            $list[$key]['createtime'] = date('Y-m-d H:i', $value['createtime']);
	            $list[$key]['value'] =$value['value']/100;
	        }
	        $this->ajaxReturn(array('total'=>$total,'rows'=>$list));
	    }
	    $this->currentpos = $this->menu_db->currentPos(I('menuid'));  //栏目位置
	    $this->display('worthlist');
	}

	/**
	 * 删除动态
	 */
    function deletedynamic($id){
        if($id!=undefined){
        $result=D("dynamic")->where("id=$id")->delete();
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
	 * 查询动态列表
	 */
	function dynamiclist($uid=0,$page=1, $rows=10, $search = array()){
	  if (IS_POST){
	        $map   = array();
	        $m=M('dynamic');
	        if ($search) {
	            if ($search['name']){
	                $map['name'] = array('like','%'.$search['name'].'%');
	            }
	        }
	        $limit=($page - 1) * $rows ."," .$rows;
	        $total=$m->where("uid=$uid")->count();
	        $list=$total?$m->where("uid=$uid")->limit($limit)->order('createtime desc')->select():array();
	        $pic=M('dynamic_pic');
	        foreach ($list as $key=>$value){
	            //格式化时间
	            $list[$key]['createtime'] = date('Y-m-d H:i', $value['createtime']);
	            $tu=$pic->where(array('dynamicid'=>$value['id']))->find();
	            $list[$key]['video']=makeHttpHead($tu['video']);
	            $list[$key]['path']=makeHttpHead($tu['path']);
	        }
	         $this->ajaxReturn(array('total'=>$total,'rows'=>$list));
 	    }else{
     	    $nickname=$this->user_db->field("nickname")->where("uid=$uid")->find();
     	    $nickname['nickname'] ? $this->currentpos = $nickname['nickname']."的动态列表" : $this->currentpos = "动态列表";//栏目位置
     	    $data=$this->assign("data",$uid);
     	    $this->display("dynamic");
 	    }
	  }
	
	/**
	 * 机器人添加动态
	 */
	function addDynamic($uid){
	    if(IS_POST){
	        if($uid){
	            $user=new UserModel();
	            log::write('robtfile='.json_encode($_FILES).$uid);
	            $ee=$user->publish_dynamic($uid,1);
	           if($ee['code']==0){
	                $this->success('发布成功');
	            }else{
	                $this->error($ee['msg']);
	            }
	        }
	   }
	   $this->display('adddynamic');
	}
	/**
	 * 添加机器人对话框
	 */
	function addr(){
	    $this->display('addrobt');
	}
	
	/**
	 * 机器人列表
	 */
	function robt($page=1, $rows=10, $search = array()){
	    if (IS_POST){
 	        $map['usertype']   = array('EQ',1);
	        if ($search) {
	            if ($search['name']){
	                $map['nickname'] = array('like','%'.$search['name'].'%');
	            }
	        }
	        $limit = ($page - 1) * $rows . "," . $rows;
			$total = $this->user_db->where($map)->count();
	        $list  = $total ? $this->user_db->where($map)->public_list(0, $map, $limit) : array();
	        $this->ajaxReturn(array('total'=>$total, 'rows'=>$list));
	    }
	    $this->currentpos = $this->menu_db->currentPos(I('menuid'));//栏目位置
	    $this->display("robt");
	}
	/**
	 * 添加机器人
	 */
	function addRobt($num){
	    if(is_numeric($num)){
     	    $lat=I("post.lat",0);
     	    $lng=I("post.lng",0);
     	    $gender=I("post.gender");
     	    $usertype=1;
    	    for($i=0;$i<$num;$i++){
    	        $nickname=$this->user_db->getRandChar();//随机昵称
    	        $headsmall=$this->user_db->getRobtPrcture();//随机头像
	    if($lng!=''&&$lat!=''){
    	        $latdata=$this->user_db->returnSquarePoint($lat,$lng);//随机周围2公里地理位置
    	        $lat=$latdata["latloc"];//获取到随机纬度
    	        $lng=$latdata["lngloc"];//获取到随机经度
     	        }
    	        $dataList[] = array('nickname'=>"$nickname",'headsmall'=>"$headsmall",
    	            'gender'=>"$gender",'usertype'=>"$usertype",'lat'=>"$lat",'lng'=>"$lng");
    	    }
    	    $robt = $this->user_db->addAll($dataList);
    	        if($robt){
    	            $this->success('添加成功');
    	        }else {
    	            $this->error('添加失败');
    	        }
	    }else{
	        $this->error('请输入正确数量');
	    }    
	}
	/**
	 * 删除机器人
	 * 
	 */
    function deleterobt($uid){
        if($uid && IS_POST){
            $result = $this->user_db->where("uid=$uid")->delete();
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
     * 编辑机器人
     */
	function editrobt($uid=0){
	    if(IS_POST){
            $data = I('data');
            if (!$data['headsmall']) unset($data['headsmall']);
            $info=$this->user_db->where(array('uid'=>$uid))->save($data);
            if ($info){
                $this->success('编辑成功');
            }else{
                $this->error('编辑失败');
            }
	    }else{	
         	$data = $this->user_db->where(array('uid'=>$uid))->find();
	        //加上网址前缀
	     	$data['headsmall'] =makeHttpHead($data['headsmall']);
	        
			$this->assign('data', $data);
			$this->display("editrobt");
	    }       
	}
    /**
     * 职业列表
     */
	function box(){
	    if(S('joblist')){
	        $data = S('joblist');
	    }else{
    	    $job=D("job")->select();
    	    $data=json_encode($job,JSON_UNESCAPED_UNICODE);
    	    S('joblist', $data);
	    }
	    echo $data;
	}
	
	/**
	 * 星座列表
	 */
	function xingzuo(){
	    if(S('xingzuolist')){
	        $data = S('xingzuolist');
	    }else{
    	    $xingzuo=D("user_xingzuo")->select();
    	    $data=json_encode($xingzuo,JSON_UNESCAPED_UNICODE);
    	    S('xingzuolist', $data);
	    }
    	    echo $data;
	}
	/**
	 * 城市列表
	 */
	function citylist(){
	    if(S('citylist')){
	        $data = S('citylist');
	    }else{
	    $city=D("hometown")->where("parentId<>0")->select();
	    $data=json_encode($city,JSON_UNESCAPED_UNICODE);
	    S('çitylist',$data);
	    }
	    echo $data;
	}
	/**
	 * 用户列表
	 * @param number $page
	 * @param number $rows
	 * @param array  $search
	 */
	function index($page=1, $rows=10, $search = array()){
		if (IS_POST){
			$map['usertype']   = array('EQ',0);
			if ($search) {
				if ($search['name']){
					$map['nickname|uid'] = array('like','%'.$search['name'].'%');
				}
			}
			$limit = ($page - 1) * $rows . "," . $rows;
			$total = $this->user_db->where($map)->count();
			$list  = $total ? $this->user_db->public_list(0, $map, $limit) : array();
			$this->ajaxReturn(array('total'=>$total, 'rows'=>$list));
		}else {
			$this->currentpos = $this->menu_db->currentPos(I('menuid'));  //栏目位置
			$this->display('list');
		}
	}
	/**
	 * 编辑
	 * @param unknown $uid
	 */
	function edit($uid=0){
		if (IS_POST) {
			$data = I('info');
			if (!$data['headsmall']) unset($data['headsmall']);
			if ($this->user_db->where(array('uid'=>$uid))->save($data)){
				$this->success('编辑成功');
			}else {
				$this->error('编辑失败');
			}
		}else {
			$this->info = $this->user_db->public_list($uid, array('uid'=>$uid), 1);
			$this->rand = I('rand');
			$this->display('edit');
		}
	}
	/**
	 * 
	 * 会员管理
	 */
	function userManage($uid=0){
	    if(IS_POST){
	        $member=I('data');
	        $level=$member['memberlevel'];
	        if($level==0){
	                 $user_member = M('user_member')->where(Array('uid'=>$uid))->find();
	            if($user_member) {
	                M('user_member')->where(Array('uid'=>$uid))->delete();
	            }
	            $endTime=0;
	            $data['uid'] = $uid;
	            M('user')->where(Array('uid'=>$uid))->save(Array('memberenddate'=>$endTime, 'memberlevel'=>$level));
	       
	        }else{
	            $this->user_db->updateUserMember_newmember($uid,$level);
	        }
	        if($uid&&$level!=''){
	           $this->success('编辑成功');
	        }else{
	           $this->success('编辑失败');
	        }
	    }
	    $data=M('user')->where("uid=$uid")->find();
	    $this->assign('data',$data);
	    $this->display('usermanage');
	}
	/**
	 * 消费记录
	 */
	function tab($uid,$page=1, $rows=10,$search=array()){
	    if(IS_POST){
	        $map   = array('uid'=>$uid);
	        if ($search) {
	            if ($search['name']){
	                $map['name'] = array('like','%'.$search['name'].'%');
	            }
	        }
	        $limit = ($page - 1) * $rows . "," . $rows;
	        $total = M('hongbao')->where($map)->count();
	        $list=$total ? M('hongbao')->where("uid=$uid")->order('createtime desc')->limit($limit)->select():array();
	        foreach ($list as $k=>$v){
	            $list[$k]['money']='-'.$v['money'];
	            $list[$k]['createtime']=date('Y-m-d H:i', $v['createtime']);
	        }
	        $this->ajaxReturn(array('total'=>$total, 'rows'=>$list));
    	   
	    }
	    $this->display('tab');
	}
	/**
	 * 删除
	 * @param unknown $uid
	 */
	function delete($uid){
		$this->error('用户uid='.$uid);
	}
	/**
	 * 昵称相同
	 * @param unknown $email
	 */
	function public_checkNickname($nickname){
		if (I('default') == $nickname) {
			$this->error('昵称相同');
		}
		$exists = $this->user_db->where(array('nickname'=>$nickname))->field('nickname')->find();
		if ($exists) {
			$this->success('昵称存在');
		}else{
			$this->error('昵称不存在');
		}
	}
	/**
	 * 上传头像
	 * @param unknown $uid
	 */
	function public_uploadHead($uid=0){
		$data = upload('/Picture/avatar/', $uid, 'user');
		if (is_string($data)) {
			$this->ajaxReturn(array('info'=>$data, 'status'=>0));
		}else {
			$this->ajaxReturn(array('info'=>'上传成功', 'url'=>$data['0']['smallUrl'], 'status'=>1));
		}
	}
	/**
	 * 提现列表
	 * @param int $page
	 * @param int $rows
	 * @param array $search
	 */
	function extract($page=1, $rows=10, $search = array()){
	    if (IS_POST){
	        $map   = array();
	        if ($search) {
	            if ($search['name']){
	                $map['u.nickname'] = array('like','%'.$search['name'].'%');
	            }
	        }
	        $limit = ($page - 1) * $rows . "," . $rows;
	        $total = M('withdraw')->alias("w")->join("left join ".C('DB_PREFIX')."user u on w.uid=u.uid")->where($map)->count();
	        $list  = $total ? $this->extract_list($map, $limit) : array();
	        foreach ($list as &$item){
	            $item['createtime'] = date('Y-m-d H:i:s',$item['createtime']);
	        }
	        $this->ajaxReturn(array('total'=>$total, 'rows'=>$list));
	    }else {
	        $this->currentpos = $this->menu_db->currentPos(I('menuid'));  //栏目位置
	        $this->display('extract');
	    }
	}
	/**
	 * 提现审核
	 * @param unknown $uid
	 */
	function extractCheck($id,$status){
	    $withdraw = M('withdraw')->where(array('id'=>$id))->find();
	    //        $balance = M('user')->where(array('uid'=>$withdraw['uid']))->getField('balance');
	    //        if($balance < $withdraw['price'] && $status == 1){
	    //            $this->success('余额不足，审核失败');
	    //        }
	    M('withdraw')->where(array('id'=>$id))->save(array('status'=>$status));
	    $content = "您好！您的提现平台已处理，请注意查收！";
	    if($status == 2){
	        M('user')->where(array('uid'=>$withdraw['uid']))->setInc('money',$withdraw['fee']);
	        $content = "您好！您本次提现未处理成功，相应金额已退回到您的余额中";
	    }
	    $message = new \Message\Model\MessageModel();
	    $tag = getMillisecond();
	    $return = $message->message('10000000',"管理员",$withdraw['uid'],$content,$tag);
	    $this->success('操作成功');
	}
	function extract_list($map, $limit, $order='w.createtime asc'){
	    $join = '';
	    //自定义字段
	    if ($this->field) {
	        $field = $this->field;
	    }else {
	        $field = 'w.*,u.nickname,u.alipay_account';
	    }
	    //自定义联合查询
	    if ($this->join) $join = $this->join;
	    $join = "left join tc_user u on w.uid=u.uid";
	    //自定义条件
	    if ($this->string) $map['_string'] = $this->string;
	
	    $list  = M('withdraw')->alias('w')->field($field)->join($join)->where($map)->order($order)->limit($limit)->select();
	    if ($list && $limit == 1) {
	        return $list['0'];
	    }else {
	        return $list;
	    }
	}
}