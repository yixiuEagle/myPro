<?php
/**
 * banner管理
 * @author yangdong
 */
namespace News\Model;
use Think\Model;
class BannerModel extends Model {
    protected $tableName = 'news_banner';
    protected $pk        = 'id';
    
    /**
     * 列表
     */
    function lists() {
        $list = $this->select();
        if ($list){
            foreach ($list as $k=>&$v){
                $v['image'] = SITE_PROTOCOL.SITE_URL.$v['image'];
                $v['imagelarge'] = str_replace('/s_', '/', $v['image']);
            }
        }
        $data = $list ? $list : array();
        return showData($data);
    }
}