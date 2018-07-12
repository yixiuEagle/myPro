<?php
namespace Admin\Controller;
use Admin\Controller\CommonController;
use Think\Think;
use User\Model\MapModel;
use User\Model\UserModel;
use Think\Log;
class MapController extends CommonController {
    /**
     * 地图列表
     */
    function maplist($page=1,$rows=10,$search=array()){
        if(IS_POST){
            $where=array('stat'=>1);
            if($search){
                if ($search['name']){
                        $where['mapname'] = array('like','%'.$search['name'].'%');
                    }
                }
            $limit=($page-1)*$rows.','.$rows;    
            $total=M('map')->where($where)->count();
            $list=$total?M('map')->where($where)->limit($limit)->order('createtime desc')->select():array();
            foreach ($list as $k=>$v){
                $list[$k]['createtime']=date('Y-m-d H:i',$v['createtime']);
                $list[$k]['Id']=$v['id'];
            }
            $this->ajaxReturn(array('total'=>$total, 'rows'=>$list));
        }
        $this->currentpos = $this->menu_db->currentPos(I('menuid'));  //栏目位置
        $this->display('maplist');
    }
    /**
     * 地图信息列表
     */
    function msg($page=1,$rows=10,$search=array()){
        if(IS_POST){
            if($search){
                if ($search['name']){
                    $where['device_id'] = array('like','%'.$search['name'].'%');
                }
            }
            $limit=($page-1)*$rows.','.$rows;
            $total=M('map_msg')->where($where)->count();
            $list=$total?M('map_msg')->where($where)->limit($limit)->select():array();
            /* foreach ($list as $k=>$v){
                $list[$k]['createtime']=date('Y-m-d H:i',$v['createtime']);
            } */
            $this->ajaxReturn(array('total'=>$total, 'rows'=>$list));
        }
        $this->currentpos = $this->menu_db->currentPos(I('menuid'));  //栏目位置
        $this->display('msg');
    }
    /**
     * 审核列表
     */
    function verifyList($page=1,$rows=10,$search=array()){
        if(IS_POST){
            $where=array('stat'=>0);
            if($search){
                if ($search['name']){
                    $where['mapname'] = array('like','%'.$search['name'].'%');
                }
            }
            $limit=($page-1)*$rows.','.$rows;
            $total=M('map')->where($where)->count();
            $list=$total?M('map')->where($where)->limit($limit)->order('createtime desc')->select():array();
            foreach ($list as $k=>$v){
                $list[$k]['createtime']=date('Y-m-d H:i',$v['createtime']);
            }
            $this->ajaxReturn(array('total'=>$total, 'rows'=>$list));
        }
        $this->currentpos = $this->menu_db->currentPos(I('menuid'));  //栏目位置
        $this->display('verifyList');
    }
    /**
     * 审核地图
     */
    function edit(){
        if(IS_POST){
            $id=I('id',0);
            if($id){
                $data['stat']=1;
                $data['createtime']=NOW_TIME;
                $re=M('map')->where(array('id'=>$id))->save($data);                
                if($re){
                    $this->success('审核成功');
                }else{
                    $this->error('审核失败');
                }
            }
        }
        $this->display('verifyMap');
    }
    /**
     * 审核编辑
     */
    function verifyedit($id){
        if(IS_POST){
            if($id){
                $data=I('info','');
                $re=M('map')->where(array('id'=>$id))->save($data);
                if($re){
                    $this->success('编辑成功');
                }else{
                    $this->error('编辑失败');
                }
            }
        }
        $data=M('map')->where(array('id'=>$id))->find();
        $this->assign('info',$data);
        $this->display('verifyEdit');
    }
    /**
     * 添加地图
     */
    function add(){
        if(IS_POST){
            $data=I('data','');
            /* //检测
             $r=M('map')->where(array('mapname'=>$data['mapname']))->find();
             if($r){
             $this->error('已存在同名称地图!');
             }
             $u=M('user')->where(array('uid'=>$data['uid']))->count();
             if(!$u){
             $this->error('没有此用户!');
             }
             if(empty($_FILES['file']['tmp_name'])){
             $this->error('请选择文件!');
            } */
    
            //上传文件
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
//             if($re){
//                 $map['mapid']=$re;
//                 $return=M('map_statistics')->add($map);
//             }
            if($re){
                $this->success('添加成功');
            }else{
                $this->error('添加失败');
            }
        }
        $this->currentpos = $this->menu_db->currentPos(I('menuid'));  //栏目位置
        $this->display('addmap');
    }
    /**
     * 上传信息
     */
    function upload(){
        if(IS_POST){
            $data=I('data','');
            /* //检测
             $r=M('map')->where(array('mapname'=>$data['mapname']))->find();
             if($r){
             $this->error('已存在同名称地图!');
             }
             $u=M('user')->where(array('uid'=>$data['uid']))->count();
             if(!$u){
             $this->error('没有此用户!');
             }
             if(empty($_FILES['file']['tmp_name'])){
             $this->error('请选择文件!');
             } */
    
            //上传文件
            /* if($_FILES){
                $img=upload_multiple('/Picture/Map/',0,'');
                $data['mapurl']=$img['0']['originUrl'];
            } */
            /* if($data['mapurl']){
                $this->error("请上传正确的文件");
                return ;
            }
            $data['createtime']=NOW_TIME; */
            $flag=M('map_msg')->where(array('device_id'=>$data['device_id']))->find();
            if($flag){
                $flag=M('map_msg')->where(array('device_id'=>$data['device_id']))->save($data);
                $this->success('添加成功');
                return showData(new \stdClass(), '上传成功');
            }
            $re=M('map_msg')->add($data);
            //             if($re){
            //                 $map['mapid']=$re;
            //                 $return=M('map_statistics')->add($map);
            //             }
            if($re){
                $this->success('添加成功');
            }else{
                $this->error('添加失败');
            }
        }
        $this->currentpos = $this->menu_db->currentPos(I('menuid'));  //栏目位置
        $this->display('upload');
    }
    /**
     * 编辑地图
     */
    function editmap($id){
        if(IS_POST){
            $da = I('info');
            $files = M('map')->where(array('id'=>$id))->find();
            if($_FILES['file']['name']){
                $re=unlink(".".$files['mapurl']);
                if(!$re){
                    $this->error('删除旧地图文件失败');
                    return;
                }
                $img=upload_multiple('/Picture/Map/',0,'');
                $da['mapurl']=$img['0']['originUrl'];
                $da['updatetime']=NOW_TIME;
            }
            if($files){
                $info=M('map')->where(array('id'=>$id))->save($da);
                if ($info){
                    $this->success('编辑成功');
                }else{
                    $this->error('编辑失败');
                }
            }else{
                $this->error('没有该地图');
            }
        }
        $data=M('map')->where(array('id'=>$id))->find();
        $this->assign('info',$data);
        $this->display('editMap');
    }
    /**
     * 编辑信息
     */
    function editmsg($id){
        if(IS_POST){
            $da = I('info');
            $files = M('map_msg')->where(array('id'=>$id))->find();
            /* if($_FILES['file']['name']){
                $re=unlink(".".$files['mapurl']);
                if(!$re){
                    $this->error('删除旧地图文件失败');
                    return;
                }
                $img=upload_multiple('/Picture/Map/',0,'');
                $da['mapurl']=$img['0']['originUrl'];
                $da['updatetime']=NOW_TIME;
            } */
            if($files){
                $info=M('map_msg')->where(array('id'=>$id))->save($da);
                if ($info){
                    $this->success('编辑成功');
                }else{
                    $this->error('编辑失败');
                }
            }else{
                $this->error('没有该地图');
            }
        }
        $data=M('map_msg')->where(array('id'=>$id))->find();
        $this->assign('info',$data);
        $this->display('editmsg');
    }
    /**
     * 删除地图
     */
    function mapdel($id){      
        if($id && IS_POST){
            M()->startTrans();//开启事物
            
            $files = M('map')->where(array('id'=>$id))->find();
            $result=unlink(".".$files['mapurl']);
            if(!$result){
                $this->error('删除地图文件失败');
                return;
            }
            $re=M('map_record')->where(array('mapid'=>$id))->delete();//删除记录
           // $return=M('map_statistics')->where(array('mapid'=>$id))->delete();//删除统计
            $result = M('map')->where(array('id'=>$id))->delete();//删除地图
            $r=M('purchase')->where(array('mapid'=>$id))->delete();//删除已购买的地图
            if($result){
                M()->commit();//成功提交
                $this->success('删除成功');
            }else {
                M()->rollback();//失败回滚
                $this->error('删除失败');
            }
        }else{
            $this->error('删除失败');
        }
    }
    /**
     * 删除信息
     */
    function msgdel($id){
        if($id && IS_POST){
            M()->startTrans();//开启事物
    
            //$files = M('map_msg')->where(array('id'=>$id))->find();
            /* $result=unlink(".".$files['mapurl']);
            if(!$result){
                $this->error('删除地图文件失败');
                return;
            }
            $re=M('map_record')->where(array('mapid'=>$id))->delete();//删除记录 */
            // $return=M('map_statistics')->where(array('mapid'=>$id))->delete();//删除统计
            $result = M('map_msg')->where(array('id'=>$id))->delete();//删除地图
            //$r=M('purchase')->where(array('mapid'=>$id))->delete();//删除已购买的地图
            if($result){
                M()->commit();//成功提交
                $this->success('删除成功');
            }else {
                M()->rollback();//失败回滚
                $this->error('删除失败');
            }
        }else{
            $this->error('删除失败');
        }
    }
    /**
     * 推送地图
     */
    function push_map($id){
        if($id){
            if(IS_POST){
                $uid=I('uid',0);
                $user=new UserModel();
                $mapdata=M('map')->where(array('id'=>$id))->find();
                $content="【".$mapdata['mapname']."】客服人员为您推荐的地图。";
                $data=$user->remsg($uid, $content, 2,$mapdata['id']);
                if($data){
                    $this->success('推送成功');
                }else{
                    $this->error('推送失败');
                }
            }
        $data=M('map')->field('id,mapname')->where(array('id'=>$id))->find();
        $this->assign('info',$data);
        $this->display('push_map');
        }
    }
    /**
     * 统计列表
     */
    function statisticsList($page=1,$rows=10,$search=array()){
        if(IS_POST){
            if($search){
                if($search['starttime']&&$search['endtime']){
                    $starttime=strtotime($search['starttime']);
                    $endtime=strtotime($search['endtime']);
                    $where['createtime']=array(array('EGT',$starttime),array('ELT',$endtime));
                }
            }
            $limit=($page-1)*$rows.','.$rows;
            $total=M('map')->where(array('stat'=>1))->count();
            $list=$total?M('map')->where(array('stat'=>1))->limit($limit)->order('createtime desc')->select():array();
            foreach ($list as $k=>$v){
                $list[$k]['createtime']=date('Y-m-d H:i',$v['createtime']);
                
                $where['mapid']=$v['id'];
                $where['type']=array('EQ',3);
                
                $da=M('map_record')->where($where)->count();
                $list[$k]['download']=$da?$da:0;
                
//                 $where['type']=1;
//                 $dat=M('map_record')->where($where)->count();
//                 $list[$k]['view']=$dat?$dat:0;
                
//                 $where['type']=array('NEQ',3);
                $where['type']=array(array('eq',1),array('eq',2),'OR');
                $data=M('map_record')->where($where)->sum('money');
                $list[$k]['money']=$data?$data:0;
            }
            $this->ajaxReturn(array('total'=>$total, 'rows'=>$list));
        }
        $this->currentpos = $this->menu_db->currentPos(I('menuid'));  //栏目位置
        $this->display('statisticsList');
    }
    /**
     * 统计
     */
    function statist(){
        $Todaymoney=$this->Today(1);
        $Todaydownload=$this->Today(2);
        $Monthmoney=$this->Thismonth(1);
        $Monthdownload=$this->Thismonth(2);
        $countmoney=$this->mapcount(1);
        $countdownload=$this->mapcount(2);
        
        $data=array('Todaymoney'=>$Todaymoney,'Todaydownload'=>$Todaydownload,
            'Monthmoney'=>$Monthmoney,'Monthdownload'=>$Monthdownload,
            'countmoney'=>$countmoney,'countdownload'=>$countdownload
        );
        $this->assign('data',$data);
        $this->display('statDialog');
    }
    //当天金额总量
    function Today($type=0){
        $beginToday=mktime(0,0,0,date('m'),date('d'),date('Y'));
        $endToday=mktime(0,0,0,date('m'),date('d')+1,date('Y'))-1;
        $where['createtime']=array(array('EGT',$beginToday),array('ELT',$endToday));
        if($type==1){
            $Today=M('map_record')->where($where)->sum('money');
        }else if($type==2){
            $Today=M('map_record')->where($where)->count();
        }
            return $Today?$Today:0;
    }
    //当月金额总量
    function Thismonth($type=0){
        $beginThismonth=mktime(0,0,0,date('m'),1,date('Y'));
        $endThismonth=mktime(23,59,59,date('m'),date('t'),date('Y'));
        $where['createtime']=array(array('EGT',$beginThismonth),array('ELT',$endThismonth));
        if($type==1){
            $Thismonth=M('map_record')->where($where)->sum('money');
        }else if($type==2){
            $Thismonth=M('map_record')->where($where)->count();
        }
        return $Thismonth?$Thismonth:0;
    }
    /**
     * type==1 money
     * type==2 download
     * @param number $type
     * @return unknown
     */
    function mapcount($type=0){
        if($type==1){
            $data=M('map')->where(array('stat'=>1))->sum('moneycount');
        }else if($type==2){
            $data=M('map')->where(array('stat'=>1))->sum('downloadcount');
        }
        return $data?$data:0;
    }
    //检测地图名是否存在
    function public_checkMapname($mapname){
        if($mapname){
            $exists = M('map')->where(array('mapname'=>$mapname))->field('mapname')->find();
            if ($exists) {
                $this->success('昵称存在');
            }else{
                $this->error('昵称不存在');
            }
        }else{
            $this->error('昵称不存在');
        }
    }
    //检测用户是否存在
    function public_checkUserid($uid){
        if($uid){
            $exists = M('user')->where(array('uid'=>$uid))->field('uid')->find();
            if ($exists) {
                $this->success('用户存在');
            }else{
                $this->error('用户不存在');
            }
        }else{
            $this->error('用户不存在');
        }
    }
    
    
    //列表
    function device_list($page=1,$rows=10,$search=array()){
        if(IS_POST){
            $map   = array();
            if ($search) {
                if ($search['name']){
                    $map['name'] = array('like','%'.$search['name'].'%');
                }
            }
            $limit = ($page - 1) * $rows . "," . $rows;
            $total = M('device')->count();
            $list  =$total? M('device')->where($map)->limit($limit)->select():array();
            foreach ($list as $k=>$v){
                $map = M("map")->where(array('id'=>$v['map_id']))->find();
                $list[$k]['mapname']=$map['mapname'];
            }
            $this->ajaxReturn(array('total'=>$total, 'rows'=>$list));
        }else {
            $this->currentpos = $this->menu_db->currentPos(I('menuid'));  //栏目位置
            $this->display("device_list");
        }
    }
    //添加
    function add_device(){
        if(IS_POST){
            $map_id = I("map_id",0);
            $device_id = I("device_id",0);
            if($map_id&&$device_id){
                $count=M("device")->where(array("map_id"=>$map_id,"device_id"=>$device_id))->count();
                if($count){
                    $this->error("此设备已与该地图关联！");
                    return;
                }
                $msg['map_id']=$map_id;
                $msg['device_id']=$device_id;
                $result = M("device")->add($msg);
                //初始化统计
                $con = M("statistics")->where(array('device_id'=>$device_id))->count();
                if(!$con){
                    $data['device_id']     =$device_id;
                    $data['scress']        =0;
                    $data['parking_path']  =0;
                    $data['parking_spaces']=0;
                    $data['adv']           =0;
                    $data['business']      =0;
                    $re = M("statistics")->add($data);
                }
                if($result){
                    $this->success("添加成功！");
                }else{
                    $this->error("添加失败！");
                }
            }else{
                $this->error("请填入数据！");
            }
         }
         $this->display("add_device");
       }
       
       function map_idlist(){
           $map=M("map")->select();
           $data=json_encode($map,JSON_UNESCAPED_UNICODE);
           echo $data;
       }
       //编辑
       function device_edit($id = 0){
           if(!$id) $this->error('未选择');
           if(IS_POST){
               $data = I('info');
               $result = M('device')->where(array('id'=>$id))->save($data);
               if($result){
                   $this->success('修改成功');
               }else {
                   $this->error('修改失败');
               }
           }else{
               $data = M('device')->where(array('id'=>$id))->find();
               $map  = M('map')->where(array('id'=>$data['map_id']))->find();
               $this->assign('map',$map);
               $this->assign('data', $data);
               $this->display('editDevice');
           }
       }
       //删除
       function devicedel($id = 0){
           if($id && IS_POST){
               $result = M('device')->where(array('id'=>$id))->delete();
               if($result){
                   $this->success('删除成功');
               }else {
                   $this->error('删除失败');
               }
           }else{
               $this->error('操作失败');
           }
       }
       /**
        * 统计报表
        */     
       function statistics_list($page=1,$rows=10,$search=array()){
           if(IS_POST){
               if($search){
                   if ($search['name']){
                       $where['device_id'] = array('like','%'.$search['name'].'%');
                   }
               }
               $limit=($page-1)*$rows.','.$rows;
               $total=M('statistics')->where($where)->count();
               $list=$total?M('statistics')->where($where)->limit($limit)->select():array();
               $this->ajaxReturn(array('total'=>$total, 'rows'=>$list));
           }
           $this->currentpos = $this->menu_db->currentPos(I('menuid'));  //栏目位置
           $this->display('statistics_list');
       }
}