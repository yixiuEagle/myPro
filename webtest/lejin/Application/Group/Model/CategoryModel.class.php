<?php
namespace Group\Model;
use Think\Model;
class CategoryModel extends Model {
    protected $tableName = 'group_category';
    protected $pk        = 'id';
    
    /**
     * 类别列表
     * @return array
     */
    function public_list() {
        $list = $this->select();
        if ($list){
            foreach ($list as $k=>&$v){
                $v['logo'] = $v['logo'] ? SITE_PROTOCOL.SITE_URL.$v['logo'] : '';
            }
        }
        return $list ? $list : array();
    }
    
    /**
     * 类别列表
     */
    function lists() {
        $data = self::public_list();
        return showData($data);
    }
}