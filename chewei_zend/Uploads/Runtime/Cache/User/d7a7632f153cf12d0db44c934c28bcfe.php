<?php if (!defined('THINK_PATH')) exit();?><!DOCTYPE html>
<html lang="en">
<head>
	<meta name="viewport" content="width=device-width,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
	<!-- <meta name="viewport" content="width=device-width, initial-scale=0.5, minimum-scale=0.3, maximum-scale=2.0, user-scalable=yes" /> -->
	<meta content="yes" name="apple-mobile-web-app-capable" />
	<meta content="black" name="apple-mobile-web-app-status-bar-style" />
	<meta content="telephone=no" name="format-detection" />
	<meta charset="UTF-8">
	<title>map</title>
	<!-- <script src="http://code.jquery.com/jquery-1.7.2.min.js"></script> -->
	<script type="text/javascript" src='/chewei_zend/Public/js/jquery.min.js'></script>
	<style>
		*{
			margin: 0;
			padding:0;
		}
		html,body{
			padding: 0;
			margin: 0;
			height: 100%;
			width: 100%;
			font-size:62.5%;
		}
		.header{
			height: 10%;
			width: 100%;
			background-color: #ccc;
		}
		.header input{
			height: 6%;
			width: 60%;
			position: absolute;
			left:6%;
			top:1.5%;
			border:none;
			box-sizing: content-box;
			font-size: 1.5rem;
			font-family:'微软雅黑';
		}	
		.header button{
			height: 6%;
			width: 14%;
			position: absolute;
			left:66%;
			top:1.5%;
			border:none;
			box-sizing: content-box;
			background-color: rgba(249, 99, 55, 0.84);
			color: white;
			font-size: 1.5rem;
			font-family:'微软雅黑';
		}
		.map{
			height: 90%;
			width: 100%;
			/*background-image: url('./timg.jpg');*/
		}
		.cvs{
			background-color: green;
			width: 100%;
			height: 100%;

		}	
	</style>
</head>
<body>
	<div class='header'>
		<input type="text" placeholder="请输入商家名称或车位号">
		<button>搜 索</button>
	</div>
    <div class='map'>
		<canvas id="cvs" style="margin: 0;padding: 0;display: block;">
		您的浏览器不支持canvas
		</canvas>
    </div>
    <script type="text/javascript">
    	var cvs=document.querySelector("#cvs");
		var cxt=cvs.getContext("2d");
		var beishu=20;
		var xmove=-130;
		var ymove=30;
		/** 
		 * @description 绘制线段(主要分为：绘制填充线段和绘制空心线段利用isFill变量来标记） 
		 * 主要是使用的是canvas原生的API: 
		 * lineTo(x,y):表示从某点连线到该坐标点 
		 *moveTo(x,y):表示将路径移动到画布中的该坐标点 
		 * x:画布中某点的X坐标 
		 * y:画布中某点的Y坐标 
		 * 注意：如果开始没有调用moveTo,那么第一个lineTo的功能就相当于一个moveTo 
		 * 自己封装的API:drawLine(startX,startY,endX,endY,lineWidth,bgcolor) 
		 *  
		 * startX:表示线的起点的X坐标 
		 * startY:表示起点的Y坐标 
		 * endX:表示线的终点的X坐标 
		 * endY:表示线的终点的Y坐标 
		 * lineWidth:表示线段的宽度 
		 * bgColor:线的颜色 
		 * */  
		function drawLine(startX, startY, endX, endY, lineWidth, bgColor) {  
		    cxt.beginPath();   
		    cxt.lineWidth = lineWidth;  
		    cxt.strokeStyle = bgColor;//经过测试不管是fillStyle还是StrokeStyle都是一样的  
		    cxt.moveTo(startX, startY);  
		    cxt.lineTo(endX, endY);  
		    cxt.stroke(); 

		} 
		/** 
		 * 绘制矩形(主要分为:绘制填充矩形和绘制边框矩形和清除矩形区域(利用isClear标记是否绘制清除矩形，实际上就是绘制一个与画布背景色一致的矩形区域),利用isFill变量来标记) 
		 * 主要使用canvas原生的API:FillRect(x,y,width,height),StrokeRect(x,y,width,height),ClearRect(x,y,width,height) 
		 * 自己封装的参数:drawRect(x,y,width,height,isClear,isFill,bgColor) 
		 * x:矩形起点的X坐标(注意：相对坐标系是以画布的左上角为原点，向右为X坐标正方向，向下为Y坐标的正方向) 
		 * y:矩形终点的Y坐标 
		 * width:矩形的宽度 
		 * height:矩形的高度 
		 * isClear:是否绘制清除画布的矩形区域，true则就是绘制一个清除画布矩形区域，false就是绘制其他两种矩形 
		 * isFill:是否是填充，false为绘制边框，true为绘制填充 
		 * bgColor:矩形的颜色，若为填充则为整个矩形背景色，边框则为边框色 
		 * */  
		function drawRect(x, y, width, height, isClear, isFill, bgColor,angle) {  
		    if (isClear) { //为true表示绘制清除画布的矩形区域,那么传入的isFill, bgColor值可以为任意值  
		        cxt.clearRect(x, y, width, height);  
		    } else { //false  
		        if (isFill) { //为true，则绘制填充矩形
		        	if(angle!=0){
		        		cxt.save(); 
		        		cxt.translate(x+width/2, y+height/2);
						cxt.rotate(angle*Math.PI/180);
						cxt.translate(-(x+width/2), -(y+height/2));
						cxt.fillStyle =bgColor;
						cxt.fillRect(x, y, width, height);
						/*if(name){
							cxt.font = "1pt";
							cxt.strokeStyle ='white';
							cxt.strokeText(name, x,y);
						}*/
						cxt.restore();
		        	}else{
		        		cxt.fillStyle = bgColor;  
			            cxt.fillRect(x, y, width, height);
			            /*if(name){
			            	cxt.font = "1pt";
							cxt.strokeStyle ='white';
							cxt.strokeText(name, x,y);
						}  */
		            }  
		        } else { //为false,则绘制边框矩形  
		            cxt.strokeStyle = bgColor;  
		            cxt.strokeRect(x, y, width, height);  
		        }  
		    }  
		  
		}
		$(document).ready(function(){
			//var viewHeight=window.innerHeight||document.documentElement.clientHeight;
    		//var viewWidth=window.innerWidth||document.documentElement.clientWidth;
			$("#cvs").attr("width", screen.availWidth);
			$("#cvs").attr("height", screen.availHeight*0.9);
			$.ajax({
			   url: "/chewei_zend/Public/map.json",//json文件位置
			   type: "GET",//请求方式为get
			   dataType: "json", //返回数据格式为json
			   success: function(data){
			       //$.each(data.floors, function(i, item) {
			       		$.each(data.floors[1].list, function(i1, item1) {
				            if(item1.type=='线墙'){
				            	$.each(item1.lines,function(k,v){
				            		var arr=[];
				            		arr=v.start.split(',');
				            		var arr1=[];
				            		arr1=v.end.split(',');
				            		drawLine(arr[0]/beishu+xmove,arr[1]/beishu+ymove,arr1[0]/beishu+xmove,arr1[1]/beishu+ymove,1,'gray');
				            	})
				            }
				            if(item1.type=='通道'){
				            	$.each(item1.lines,function(k,v){
				            		if(v.hide!=1){
				            			var arr=[];
					            		arr=v.start.split(',');
					            		var arr1=[];
					            		arr1=v.end.split(',');
					            		drawLine(arr[0]/beishu+xmove,arr[1]/beishu+ymove,arr1[0]/beishu+xmove,arr1[1]/beishu+ymove,2,'orange');
				            		}
				            	})
				            }
				            if(item1.type=='车位' || item1.type=='电梯'){
				            	var arrs=[];
				            	arrs=item1.locations.split(';');
				            	arr0=arrs[0];
				            	arr1=arrs[1];
				            	var x0=arr0.split(',')[0]/beishu+xmove;
				            	var y0=arr0.split(',')[1]/beishu+ymove;
				            	var x1=arr1.split(',')[0]/beishu+xmove;
				            	var y1=arr1.split(',')[1]/beishu+ymove;
				            	var h=y1-y0;
				            	var w=x1-x0;
				            	if(item1.type=='车位'){
				            		drawRect(x0,y0,w,h,false,true,'#09F7C7',item1.angle);
				            	}
				            	if(item1.type=='电梯'){
				            		drawRect(x0,y0,w,h,false,true,'#08E761',item1.angle);
				            	}
				            	
				            }
				        })
			       //})
   				}
			})
		});   
    </script>
</body>
</html>