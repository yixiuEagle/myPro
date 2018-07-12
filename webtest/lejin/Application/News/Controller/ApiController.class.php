<?php
/**
 * 接口类
 */
namespace News\Controller;
use Common\Api\Api;
use News\Model\NewsModel;
class ApiController extends Api {
    protected $db;
    protected $id;
    function _initialize() {
        parent::_initialize();
        $this->db = new NewsModel();
        $this->id = trim(I('id', 0));//资讯id
    }
    /**
     * banner列表
     */
    function bannerList(){
        $db = new \News\Model\BannerModel();
        $data = $db->lists();
        $this->jsonOutput($data);
    }
	/**
	 * 城市列表
	 */
	function citylist(){
	    $db = new \News\Model\CityModel();
	    $data = $db->lists();
	    $this->jsonOutput($data);
	}
	/**
	 * 资讯列表
	 */
	function lists() {
	    if ($this->mid) self::isLogin();
	    $data = $this->db->lists($this->mid);
	    $this->jsonOutput($data);
	}
	/**
	 * 资讯详细
	 */
	function detail(){
	    if ($this->mid) self::isLogin();
	    $data = $this->db->detail($this->mid, $this->id);
	    $this->jsonOutput($data);
	}
	/**
	 * 家教资讯子类别列表（家长圈）
	 */
	function categoryList() {
	    $data = $this->db->categoryList();
	    $this->jsonOutput($data);
	}
	/**
	 * 资讯的添加赞和取消赞
	 */
	function praise(){
	    self::isLogin();
	    $data = $this->db->praise($this->mid, $this->id);
	    $this->jsonOutput($data);
	}
	/**
	 * 资讯的收藏
	 */
	function collect() {
	    self::isLogin();
	    $data = $this->db->collect($this->mid, $this->id);
	    $this->jsonOutput($data);
	}
}