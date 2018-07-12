<?php
/**
 * 资讯管理
 */
namespace News\Controller;
use Admin\Controller\CommonController;
use News\Model\NewsModel;
class NewsController extends CommonController {
    protected $db;
    function _initialize() {
        parent::_initialize();
        $this->db = new NewsModel();
    }
    
    /**
     * 列表
     * @param number $page
     * @param number $rows
     * @param unknown $search
     */
    function index($page=1, $rows=10, $search=array()){
        if (IS_POST) {
            $map = array();
            if ($search) {
                if ($search['name']) {
                    $map['title|description'] = array('like','%'.$search['name'].'%');
                }
            }
            $limit = ($page - 1) * $rows . "," . $rows;
            $total = $this->db->where($map)->count();
            $list  = $total ? $this->db->public_list(0, $map, $limit) : array();
            foreach ($list as $key=>$value){
                //格式化时间
                $list[$key]['createtime'] = date('Y-m-d H:i', $value['createtime']);
            }
            $this->ajaxReturn(array('total'=>$total, 'rows'=>$list));
        }else {
            $this->currentpos = $this->menu_db->currentPos(I('menuid'));  //栏目位置
            $this->display('list');
        }
    }
    /**
     * 添加
     */
    function add(){
        if (IS_POST) {
            $data = $_REQUEST;
            $data['images'] = urldecode(json_encode(utf8_to_urlencode($data['images'])));
            $data['createtime'] = NOW_TIME;
            if ($this->db->add($data)){
                $this->success('添加成功');
            }
            $this->error('添加失败');
        }else {
            $this->rand  = I('rand');
            $this->cate1 = M('news_cate_one')->select();
            $this->cate2 = M('news_cate_two')->select();
            $this->city  = M('city')->select();
            $this->display('add');
        }
    }
    /**
     * 上传群组logo图片
     */
    function public_upload(){
        $image = upload('/Picture/news/', 0, 'news');
        if (is_array($image)){
            $this->ajaxReturn(array('info'=>'success', 'url'=>$image['0']['smallUrl'], 'status'=>1, 'show'=>C('HTTP_URL').$image['0']['smallUrl']));
        }else {
            $this->error($image);
        }
    }
}