<?php
/**
 * banner管理
 * @author yangdong
 */
namespace Messages\Model;
use Think\Model;
class BannerModel extends Model {
    protected $tableName = 'banner';
    protected $pk        = 'id';
    
    /**
     * 列表
     */
    function lists() {
        $action = trim(I('action', 0));//0-大家帮 1-关注 2-动态
        $list = $this->where(array('action'=>$action))->select();
        if ($list){
            foreach ($list as $k=>&$v){
                $v['image'] = SITE_PROTOCOL.SITE_URL.$v['image'];
                $v['imagelarge'] = str_replace('/s_', '/', $v['image']);
                if (!$v['type']){
                    $v['content'] = SITE_PROTOCOL.SITE_URL.'/index.php/user/html/ad/id/'.$v['id'].'.html';
                }
            }
        }
        $data = $list ? $list : array();
        return showData($data);
    }
}