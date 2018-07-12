<?php
namespace User\Controller;
use Common\Api\Api;
use Think\Controller;

class IndexController extends Api{

	/* public function _initialize(){
		parent::_initialize();

	} */
	//首页
	function index() {
	    $loc_url='http://'.$_SERVER['HTTP_HOST'].$_SERVER['REQUEST_URI'];
	    S('loc_url',$loc_url);
	    $device_id = I("device_id",0);
	    $isShare=I('isShare',0);
	    if($isShare){
	        $mes['isShare']=1;
	    }else{
	        $mes['isShare']=0;
	    }
	    $id = M("statistics")->where(array("device_id"=>$device_id))->find();
	    if($id){
	        $result = M("statistics")->where(array("device_id"=>$device_id))->setInc('wxtimes',1);
	    }else{
	        $data['device_id']     =$device_id;
	        $data['scress']        =0;
	        $data['parking_path']  =0;
	        $data['parking_spaces']=0;
	        $data['adv']           =0;
	        $data['business']      =0;
	        $data['wxtimes']      =1;
	        $result = M("statistics")->add($data);
	    }
	    $type=I('type',0);
	    $mapid=floor($device_id/10000);
	    $map = M("map")->where(array("id"=>$mapid))->find();
	    $data=file_get_contents(".".$map['mapurl']);
	    // 	           $data=file_get_contents(makeHttpHead($map['mapurl']));
	    $encoding = mb_detect_encoding($data, array('GB2312','GBK','UTF-16','UCS-2','UTF-8','BIG5','ASCII'));
	    $str = iconv($encoding, 'UTF-8', $data);
	    $point=M('map_msg')->field('floor,rotate,location')->where(array('device_id'=>$device_id))->find();
	    $str=json_decode($str,true);
	    $mes['map']=$str;
	    $mes['point']=$point; 
	    $mes['standardScale']=$map['standardScale'];
	    //$mes=[$str,$point];
	    if($type){
	        $data=showData($mes);
	        $this->jsonOutput($data);
	    }else{
	        S('data',$mes);
	        $this->display('index');
	    }
	}
	function map() {
	    $this->display('map');
	}
	/**
	 * 扫描二维码
	 */
	function codeMsg(){
	    $loc_url='http://'.$_SERVER['HTTP_HOST'].$_SERVER['REQUEST_URI'];
	    S('loc_url',$loc_url);
	    $device_id = I("device_id",0);
	    $isShare=I('isShare',0);
	    if($isShare){
	        $mes['isShare']=1;
	    }else{
	        $mes['isShare']=0;
	    }
	    $id = M("statistics")->where(array("device_id"=>$device_id))->find();
	    if($id){
	        $result = M("statistics")->where(array("device_id"=>$device_id))->setInc('wxtimes',1);
	    }else{
	        $data['device_id']     =$device_id;
	        $data['scress']        =0;
	        $data['parking_path']  =0;
	        $data['parking_spaces']=0;
	        $data['adv']           =0;
	        $data['business']      =0;
	        $data['wxtimes']      =1;
	        $result = M("statistics")->add($data);
	    }
	    $type=I('type',0);
	    $mapid=floor($device_id/10000);
	    $map = M("map")->where(array("id"=>$mapid))->find();
	    $data=file_get_contents(".".$map['mapurl']);
	    // 	           $data=file_get_contents(makeHttpHead($map['mapurl']));
	    $encoding = mb_detect_encoding($data, array('GB2312','GBK','UTF-16','UCS-2','UTF-8','BIG5','ASCII'));
	    $str = iconv($encoding, 'UTF-8', $data);

	    $point=M('map_msg')->field('floor,rotate,location,name')->where(array('device_id'=>$device_id))->find();
	    $str=json_decode($str,true);
	    $mes['map']=$str;
	    $mes['point']=$point; 
	    $mes['standardScale']=$map['standardScale'];
	    //$mes=[$str,$point];
	    if($type){
	        $data=showData($mes);
	        $this->jsonOutput($data);
	    }else{
	        S('data',$mes);
	        $this->display('map');
	    }
	}
	function getMsg(){
	    $data=S('data');
	    $data=showData($data);
	    $this->jsonOutput($data);
	}
	function getSign(){
	    $access_token = S('access_token');
	    if($access_token==false){
	        $url='https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=wxd75116f337fba084&secret=748b50d1a9486dc6e153949ae1e73262';
	        $html = file_get_contents($url);
	        $html = json_decode($html, true);
	        S('access_token',$html['access_token'],7200);//缓存7200秒
	        $access_token = S('access_token');
	    }
	    $jsapi_ticket=S('jsapi_ticket');
	    if($jsapi_ticket==false){
	        $ticket_url='https://api.weixin.qq.com/cgi-bin/ticket/getticket?access_token='.$access_token.'&type=jsapi';
	        $mess = file_get_contents($ticket_url);
	        $mess = json_decode($mess, true);
	        S('jsapi_ticket',$mess['ticket'],7200);//缓存7200秒
	        $jsapi_ticket=S('jsapi_ticket');
	    }
	    $loc_url=S('loc_url');
	    $randNumber=$this->getRandChar(10);
	    $curtime=time();
	    $str="jsapi_ticket=".$jsapi_ticket."&noncestr=".$randNumber."&timestamp=".$curtime."&url=".$loc_url;
	    $signature=sha1($str);
	    $data['timestamp']=$curtime;
	    $data['nonceStr']=$randNumber;
	    $data['signature']=$signature;
	    $data['jsapi_ticket']=$jsapi_ticket;
	    $data['str']=$str;
	    $data=showData($data);
	    $this->jsonOutput($data);
	}
	function twotime(){
	    $device_id = I("device_id",0);
	    $id = M("statistics")->where(array("device_id"=>$device_id))->find();
	    if($id){
	        $result = M("statistics")->where(array("device_id"=>$device_id))->setInc('wxtimes',1);
	    }else{
	        $data['device_id']     =$device_id;
	        $data['scress']        =0;
	        $data['parking_path']  =0;
	        $data['parking_spaces']=0;
	        $data['adv']           =0;
	        $data['business']      =0;
	        $data['wxtimes']      =1;
	        $result = M("statistics")->add($data);
	    }
	    $mapid=floor($device_id/10000);
	    $map = M("map")->where(array("id"=>$mapid))->find();
	    $data=file_get_contents(".".$map['mapurl']);
	    // 	           $data=file_get_contents(makeHttpHead($map['mapurl']));
	    $encoding = mb_detect_encoding($data, array('GB2312','GBK','UTF-16','UCS-2','UTF-8','BIG5','ASCII'));
	    $str = iconv($encoding, 'UTF-8', $data);
	    $str=json_decode($str,true);
	    $point=M('map_msg')->field('floor,location,rotate')->where(array('device_id'=>$device_id))->find();
	    //$mes['point']=$point;
	    $point['map']=$str;
	    $data=showData($point);
	    $this->jsonOutput($data);
	}
}