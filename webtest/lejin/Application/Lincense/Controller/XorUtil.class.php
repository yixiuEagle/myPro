<?php

namespace Lincense\Controller;

/**
 * 异或加解密
 * @author Administrator
 *
 */
class XorUtil {
	private static function pass($b, $str) {
		$tmp="";
		
		for($i=0;$i<strlen($str);$i++){
			$tmp .= substr($str,$i,1) ^ $b;
		}
		
		return $tmp;
	}
	
	// 加密
	public static function compose($code, $key) {
// 		$tcode = $code;
		
// 		for($i = 0; $i < strlen($key); $i++) {
// 			$b = substr($key, $i, 1);
// 			$tcode = XorUtil::pass($b, $tcode);
// 		}
		
// 		return $tcode;

		return $code;
	}
	
	// 解密
	public static function parse($code, $key) {
// 		$tcode = $code;
		
// 		for($i = strlen($key); $i > 0; $i--) {
// 			$b = substr($key, $i-1, 1);
// 			$tcode = XorUtil::pass($b, $tcode);
// 		}
		
// 		return $tcode;

		return $code;
	}
	
	// 加密
	public static function compose_lincense($code, $key) {
				$tcode = $code;
	
				for($i = 0; $i < strlen($key); $i++) {
					$b = substr($key, $i, 1);
					$tcode = XorUtil::pass($b, $tcode);
				}
	
				return $tcode;
	
	}
	
	// 解密
	public static function parse_lincense($code, $key) {
				$tcode = $code;
	
				for($i = strlen($key); $i > 0; $i--) {
					$b = substr($key, $i-1, 1);
					$tcode = XorUtil::pass($b, $tcode);
				}
	
				return $tcode;
	
	}
}

?>