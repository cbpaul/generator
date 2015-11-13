jQuery(document).ready(function() {
		TableCommon.delayInit(
			"msgInfo_listTable",
			"controller/MsgInfo/list",
			null,[
				{
					"mData" : "id",
					"mRender" : function(data, type, full) {
						return '<input type="checkbox" class="checkboxes" value="'+data+'" />';
					}
				},
				{
					"mData" : "user.nickName"
					
				},
				{
					"mData" : "content",
					"mRender" : function(data, type, full) {
						return getMsgImage(data,full);
					}
				},
				{
					"mData" : "formatCreateOn"
				},
				{
					"mData" : "id",
					"mRender" : function(data, type, full) {
						var ret ='';
		   				
		   			 		ret += '<roleCheck:roleCheck url="${base}/edit"><a class="btn mini green ajaxDef" type="get" href="${base}/edit?id='+data+'"><i class="icon-edit"></i> 编辑</a> </roleCheck:roleCheck>';
		   				
		   				
		   					ret += '<roleCheck:roleCheck url="${base}/muteMsg"><a class="btn mini red" onclick="muteMsg('+full.user.id+')"><i class="icon-remove-circle"></i> 禁言</a> </roleCheck:roleCheck>';
			   		
		   					ret += '<roleCheck:roleCheck url="${base}/deleteMsgInfo"><a class="btn mini red deleteItem" action="${base}/deleteMsgInfo" fortableId="msgInfo_listTable" delId="'+data+'"><i class="icon-trash"></i> 删除</a> </roleCheck:roleCheck>';
						return ret;
					}
				} ], true);
	});
	
	function getMsgImage(data,full){
		function getMsgTypeHtml(text,color){
			return "<font color='"+color+"'><b>"+text+"</b></font>";
		}
		function createFancybox(img){
			var sufFixIndex = img.lastIndexOf(".");
			var img160 = img.substring(0, sufFixIndex)+"_160"+img.substring(sufFixIndex,img.length);
			var ret = '';
			ret += '<div class="item" style="width:65px;float: left;">';
			ret += '<a class="fancybox-button-msginfo" data-rel="fancybox-button-'+full.id+'" href="'+img+'">';
			ret += '	<div class="zoom" style="width:65px;">';
			ret += '		<img src="'+img160+'" alt="Photo" width="60" height="60" />';                             
			ret += '		<div class="zoom-icon" style="width:65px;"></div>';
			ret += '	</div>';
			ret += '</a> ';
			ret += '</div>';
			return ret;
		}
		var ret = "";
		var type = full.type;
		if(type==1){
			ret += getMsgTypeHtml("【首发帖】：","blue");
		}else if(type ==2){
			ret += getMsgTypeHtml("【转发帖】：","orange");
		}else if(type == 64){
			ret += getMsgTypeHtml("【评论帖】：","green");
		}
		ret += data;
		
		//展示首发贴内容
		if(type == 2 || type == 64){
			ret +='<hr class="clearfix" /><i>';
			ret += getMsgTypeHtml("【原帖】：","black");
			if(full.retweetedMsg){
				ret += full.retweetedMsg.content;
			}else{
				ret += "“原帖被删除”";
			}
			ret += "</i>";
		}
		
		//展示首发贴图片
		var extraContent = "";
		if(type == 1){
			extraContent = full.extraContent;
		}else if(type == 2 || type == 64){
			if(full.retweetedMsg){
				extraContent = full.retweetedMsg.extraContent;
			}
		}
		if(extraContent){
			var extra = eval("("+extraContent+")");
			if(extra.img && extra.img.length > 0){
				ret +='<div class="row-fluid">';
				var imgs = extra.img;
				for(var i=0;i<imgs.length;i++){
					var img = imgs[i];
					ret += createFancybox(img);
				}
				ret += '</div>';
			}
		}
		if(ret){
			//替换表情
			var es = "嘻嘻,哈哈,喜欢,晕,泪,馋嘴,抓狂,哼,可爱,怒,汗,微笑,睡觉,钱,偷笑,酷,衰,吃惊,怒骂,鄙视,挖鼻屎,色,鼓掌,悲伤,思考,生病,亲亲,抱抱,白眼,右哼哼,左哼哼,嘘,委屈,哈欠,敲打,疑问,挤眼,害羞,快哭了,拜拜,黑线,强,弱,给力,浮云,围观,威武,相机,汽车,飞机,爱心,奥特曼,兔子,熊猫,不要,ok,赞,勾引,耶,爱你,拳头,差劲,握手,玫瑰,心,伤心,猪头,咖啡,麦克风,月亮,太阳,啤酒,萌,礼物,互粉,钟,自行车,蛋糕,围巾,手套,雪花,雪人,帽子,树叶,足球".split(",");
			for (var i = 0, k = es.length, e = es[0]; i < k; i++, e = es[i]) {
				if (ret.indexOf("[" + e+"]") > -1) {
					var u = (i*1+1);
					if(u <10){
						u = "00"+u;
					}else if(u<100){
						u = "0"+u;
					}
					ret = ret.replace(new RegExp("\\["+e+"\\]","g"), "<img src='media/image/face/"+u+".png' title='"+e+"'>");
				}
			}
			
			//替换昵称
			ret = ret.replace(/(@[\u4e00-\u9fa5_a-zA-Z0-9_]{1,30})\s/g,"<a title='$1'>$1</a>");
		}
		return ret;
	}
	
	function muteMsg(id){
		var confirm = TableCommon.confirm('确认是否将该用户禁言?',function(){
			$.get('${base}/muteMsg?id='+id, {}, function (res) {
				  			if(res.code == 200){
	                        	TableCommon.success(res.info);//提示操作成功
				  			}else{
				  				TableCommon.error(res.info);//提示操作失败
				  			}
				  			confirm.close();//关闭确认框
	                    },'json');
		});
		confirm.show();
	}