<?php
namespace Home\Controller;
use Think\Controller;
class IndexController extends Controller {
	/**
	 * 首页
	 */
	public function index() {
		/* if(file_exists('./Application/Install/Data/install.lock')){
			$this->redirect('admin/Index/login');
		}else {
			$this->redirect('install/Index/index');
		} */
		
		$this->display();
	}
	
	public function htmlcontent() {
		$key = I('key', '');
		$output = "";
		if($key) {
			$info = M('htmlcontent')->where(Array('key'=>$key))->find();
			if($info)
				$output = $info['content'];
		}
		$this->content = $output;
		
		$this->display("htmlcontent");
	}
	public function android_download(){
	    $url = 'http://www.yimisns.com/yimisns.com/Uploads/Download/YiMi(12).apk';
	    Header("Location:$url");
	}

}