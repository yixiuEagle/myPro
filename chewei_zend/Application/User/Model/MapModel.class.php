<?php
namespace User\Model;
use Think\Model;
use Common\Model\CommonModel;
class MapModel extends CommonModel {
    /**
     * 附近停车场
     */
    function nearby(){
        $lat=I('lat',0);
        $lng=I('lng',0);
        if($lat&&lng){
            $where="getDistance('$lng', '$lat', lng, lat)<=500000 and stat=1";
            $data=M('map')->field('mapname,address,offhand,forever,lng,lat')->where($where)->select();
            if(!$data){
                return  showData(new \stdClass(), '您周围没有车库地图', 1);
            }
            return showData($data);
        }else{
            return  showData(new \stdClass(), '没有获取到你的位置信息', 1);
        }
    }
    /**
     * 搜索
     */
    function search_map(){
        $name=I('name','');
        if($name){
            $where['stat'] = array('EQ',1);
            $where['mapname'] = array('like','%'.$name.'%');
            $data=M('map')->field('mapname,address,offhand,forever,lng,lat')->where($where)->select();
            if($data){
                return  showData($data);
            }else{
                return  showData(new \stdClass(), '没有此地图', 1);
            }
        }else{
            return  showData(new \stdClass(), '请输入地图名称', 1);
        }
    }
    /**
     * 地图下载
     */
    function map_download($uid){
        $id=I('id',0);
        if($id){
            $where=array('id'=>$id);
            //检测是否已经购买
            $pu=$this->checkmap($uid,$id);
            if($pu['data']['check']['type']==0) return $pu;
            if($pu['data']['check']['type']==1){
                $data=M('map')->field('id,mapname,mapurl')->where($where)->find();
                $li['list']=$data;
                $mo['type']=1;
                $li['check']=$mo;
                if ($data){
                    //下载记录                    
                    $this->map_record($id,3,0);//3-下载记录
                    //统计下载次数
                    M('map')->where($where)->setInc('downloadcount');
                }
            }
            return showData($li);
        }
    }
    /**
     * 地图记录
     */
    function map_record($mapid,$type,$money){
        $record['mapid']=$mapid;
        $record['type']=$type;
        $record['money']=$money;
        $record['createtime']=NOW_TIME;
        $data=M('map_record')->add($record);
        return $data;
    }
    /**
     * 添加购买地图记录
     */
    function purchase($uid,$id,$type){
        $purch['uid']=$uid;
        $purch['mapid']=$id;
        $purch['type']=$type;
        $purch['createtime']=NOW_TIME;
        M('purchase')->add($purch);
    }
    /**
     * 已购地图列表
     */
    function purchaseList($uid){
        //检测是否到期    到期删除   type=1-临时下载
        $data=M('purchase')->where(array('uid'=>$uid,'type'=>1))->select();
        $pur=M('purchase');
        if($data){
            $time=NOW_TIME;
            foreach ($data as $k=>$v){
                if($time<=$v['createtime']+(3600*24*7)){
                    $pur->where(array('id'=>$v['id']))->delete();
                }                
            }
        }
        
        $where  = "p.uid=$uid and p.mapid=m.id";
        $field  = "m.mapname,m.id,m.address,p.type,p.createtime";
        $table  = 'purchase p,' .$this->tablePrefix. 'map m';
        $order  = 'p.createtime desc';
        $list=$this->m_db_getlistpage($table, $where, $field,$order);
        return $list;
    }
    /**
     * 检测地图是否已购
     * 
     */
    function checkmap($uid,$mapid){
        if($mapid){
            $data=M('purchase')->where(array('uid'=>$uid,'mapid'=>$mapid))->find();
            //是否临时下载，是否到期
            if($data['type']==1){
                $time=NOW_TIME;
                if($time<=$data['createtime']+(3600*24*7)){
                    M('purchase')->where(array('id'=>$data['id']))->delete();
                    $data='';
                }
            }
            if($data){
                $list=array('type'=>1);
                $li['check']=$list;
            }else{
                $mo['type']=0;
                $list=M('map')->field('id,mapname,address,offhand,forever')->where(array('id'=>$mapid))->find();
                $li['list']=$list;
                $li['check']=$mo;
            }
            return showData($li);
        }else{
            return  showData(new \stdClass(), '地图id不存在', 1);
        }
    }
 
    /**
     * 地图收入
     * @return unknown[]
     */
    function mapIncome($uid){
        if($uid){
            //获取当月地图收入
            $beginThismonth=mktime(0,0,0,date('m'),1,date('Y'));
            $endThismonth=mktime(23,59,59,date('m'),date('t'),date('Y'));
            $where['createtime']=array(array('EGT',$beginThismonth),array('ELT',$endThismonth));
            //获取用户地图列表
            $map=M('map');
            $list=$map->field('id,mapname,moneycount')->where(array('uid'=>$uid,'stat'=>1))->select();
            $monthmoney=0;
            //地图月收入总和
            foreach ($list as $k=>$v){
                $where['mapid']=$v['id'];
                $month=M('map_record')->where($where)->sum('money');
                $monthmoney+=$month;
            }
            //获取用户总收入
            $countmoney=$map->where(array('uid'=>$uid,'stat'=>1))->sum('moneycount');
            $li['list']=$list;
            $li['count']=array('mapMonthMoney'=>$monthmoney,'mapCountMoney'=>$countmoney);
            
            return showData($li);            
        }
    }
  
}