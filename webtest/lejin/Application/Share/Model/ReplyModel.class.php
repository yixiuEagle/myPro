<?php/** * 留言的回复 */namespace Share\Model;use Think\Model;class ReplyModel extends Model {    protected $tableName = 'share_reply';    protected $pk        = 'id';        public $join            = '';    public $string          = '';    public $field           = '';        /**     * 数据格式化     * @param array $list     * @param int   $uid     */    private function _format($list, $uid=0){        $_list = array();        if ($list) {            foreach ($list as $k=>$v){                $tmp = $v;                //用户                $user = new \User\Model\UserModel();                $userTemp = $user->getUserName($v['uid']);                $tmp['user'] = $userTemp ? $userTemp : new \stdClass();                $fuserTemp = $user->getUserName($v['fuid']);                $tmp['fuser'] = $fuserTemp ? $fuserTemp : new \stdClass();                               $_list[] = $tmp;            }        }        return $_list;    }    /**     * 列表     * @param int $uid     * @param array $map     * @param string $limit     * @param string $order     * @return array     */    function public_list($uid, $map, $limit, $order='createtime desc'){        $join = '';        //自定义字段        if ($this->field) {            $field = $this->field;        }else {            $field = 's.*';        }        //自定义联合查询        if ($this->join) $join .= $this->join;        //自定义条件        if ($this->string) $map['_string'] = $this->string;                $list  = $this->alias('s')->field($field)->where($map)->join($join)->order($order)->limit($limit)->select();        $_list = self::_format($list,$uid);        if (($limit == 1) && $_list) {            return $_list['0'];        }else {            return $_list;        }    }    /**     * 公共的用户列表     */    private function _list($map, $uid, $order='s.createtime desc'){        //自定义条件        if ($this->string) $map['_string'] = $this->string;        $total = $this->alias('s')->where($map)->count();        if ($total) {            $page  = page($total);            $limit = $page['offset'] .','. $page['limit'];        }else {            $page  = '';        }        $list = $total ? self::public_list($uid, $map, $limit, $order) : array();        return showData($list, '', 0, $page);    }    /**     * 发布回复     * @param int $uid     */    function addReply($uid, $fuid, $id){        $data = array(            'shareid'   => $id,            'uid'       => $uid,            'fuid'      => $fuid,            'content'   => trim(I('content')),            'createtime'=> NOW_TIME        );        if (!$data['content']) {            return showData(new \stdClass(), '请输入回复内容', 1);        }else {            $rule   = '[emoji_[\d]{0,3}]';            $result = preg_replace($rule, 'a', $data['content']);            $result = str_replace('[a]', 'a', $result);            //            if (iconv_strlen($result,"UTF-8") > 60) return showData(new \stdClass(), '回复内容太长了', 1);        }        if ($this->add($data)){            return showData(new \stdClass(), '回复成功');        }        return showData(new \stdClass(), '回复失败', 1);    }    /**     * 回复列表     */    function replyList($uid, $id) {        $map = array('shareid'=>$id);        return self::_list($map, $uid);    }}