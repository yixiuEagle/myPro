<?php
namespace User\Controller;
use Think\Controller;
class HtmlController extends Controller {
    
    function web(){
        $type    = trim(I('type', 0));
        $content = '';
        switch ($type) {
            case 1:
                $content = S('helpcenter') ? S('helpcenter') : '';
                break;
            case 2:
                $content = S('usement') ? S('usement') : '';
                break;
            case 3:
                $content = S('memberment') ? S('memberment') : '';
                break;
            case 4:
                $content = S('punishment') ? S('punishment') : '';
                break;
            case 5:
                $content = S('regist') ? S('regist') : '';
                break;
        }
        $this->content = $content;
        $this->display();
    }
    
    function ad() {
        $id = trim(I('id', 0));
        $content = M('banner')->where('id='.$id)->getField('content');
        $content = str_replace("/lejin/Uploads", "http://www.kmlejin.com/Uploads", $content);
        $this->content = $content ? $content : '';
        $this->display('web');
    }
}