var productId="";
	var subIndex = 0;
	var delSubIdStr=[];
	$(function() {
		//复制dom节点
		var cloneNode = $("#subCategory"+subIndex).clone();
		subIndex = getSubCateGoryLength();
		//清除表单数据
		cloneNode.find("input").val('');
		productId = $("input[name='id']").val();
		
		$('.redactor').redactor({
			lang : "zh_cn",
			imageUpload : 'upload/uploadFileEditor',
			fileUpload : 'upload/uploadFileEditor',
			autoresize : false,
		    //plugins: ['advanced']
		});
		$(".select2").select2({
			allowClear : true
		});
		$("#classify").change(function(){//一级类别改变
			var index = $(this).get(0).selectedIndex;
			$(".subClassify").removeClass("hide");
			$(".subClassify").hide();
			$("#s2id_subClassfiy"+index).show();
			$("#subClassfiy"+index).show();
			$("select.subClassify").removeClass("required");
			$("#subClassfiy"+index).addClass('required');
			$("#subClassfiy"+index).select2({
				allowClear:true
			});
			var selectValue=$("select.subClassify:visible").val();
			classifyParam(selectValue);
		});
		$("select.subClassify").change(function(){//二级类别改变
			classifyParam($(this).val());
		});
		var selectValue=$("select.subClassify:visible").val();
		classifyParam(selectValue);
		
		$("#addSubCategory").click(function(){//添加子类别
			var newNode = cloneNode.clone();
			newNode.find("input").each(function(index) {//修改表单名字，表单验证
			  $(this).attr("name",$(this).attr("name")+(subIndex+1));
			});
			newNode.find(".delSubCategory").click(function(){
				if($("div[id^=subCategory]").length==1){
					alert("子类别必须存在一个");
					return;
				}
				$("#subCategory"+$(this).attr("btnId")).remove();
				updateSubCategoryIndex();
			});
			$("#subCategory"+(getSubCateGoryLength()-1)).after(newNode);
			subIndex++;
			updateSubCategoryIndex();
		});
		$(".delSubCategory").click(function(){//删除子类别
			if($("div[id^=subCategory]").length==1){
				alert("子类别必须存在一个");
				return;
			}
			var hiddenIdNode = $("#subCategory"+$(this).attr("btnId")).find("input[key=id]");
			if(hiddenIdNode.length>0){
				delSubIdStr.push(parseInt(hiddenIdNode.val()));
			}
			$("#subCategory"+$(this).attr("btnId")).remove();
			updateSubCategoryIndex();
		});
		$("#saveProduct").click(function(){
			if($("#form-save").valid()){
				var oneClassifyIndex=$("#classify").get(0).selectedIndex;//选中的一级类别索引
				var subClassifyNode = $("#subClassfiy"+oneClassifyIndex);//二级类别
				var productAttr = getProductBaseAttr()+"&classifyId="+subClassifyNode.val();
				var forwordUrl = "controller/Product/list";
				var url = "controller/Product/add?"+productAttr+"&params="+JSON.stringify(getParams())+"&subCategories="+JSON.stringify(getSubCategory());
				if(delSubIdStr.length>0){
					url +="&delSubIdStr="+delSubIdStr;
				}
				TableCommon.saveComfirm(url,forwordUrl);
				/**$.ajax({
					"type":"POST",
					"contentType" : "application/json",
					"dataType" : "json",
					"url" :url,
					"success" : function(res){
						
					}
				});**/
			}
			
		});
		
	});
	//异步请求类别对应参数
	function classifyParam(classifyId){
		if(classifyId){
			var url = "controller/Product/paramAndValue?classifyId="+classifyId;
			if(productId!='' ){
				url =url+"&productId="+productId;
			}
		   $.ajax({
			   "type" : "GET",
				"contentType" : "application/json",
				"url" : url,
				"dataType" : "json",
				"success" : function(res) {
					$(".param-control").remove();
					if(res){
						var str = '';
						for(var i=0 ;i<res.length;i++){
							var obj = res[i];
							if(i%2==0){
								str +='<div class="row-fluid">';
							}
							str +='<div class="span4 ">';
							str +='<div style="margin-top: 6px;" class="param-control control-group">';
							str +='<label class="control-label">'+obj.name+'</label>';
							str +='<div class="controls"  style="margin-left: 187px;">';
							if(obj.isRadio=="1"){
								var radioValues=obj.radioValus;
								for(var j=0 ;j<radioValues.length;j++){
									if(productId!=''&& obj.paramRadioId &&  obj.paramRadioId == radioValues[j].id){
										str +='<label class="radio"><input type="radio" checked="true" paramId="'+obj.id+'" name="param'+obj.id+'" class="m-wrap" paramRadioId="'+radioValues[j].id+'" value="'+radioValues[j].value+'"/>'+radioValues[j].value+'</label>';
									}else{
										str +='<label class="radio"><input type="radio" paramId="'+obj.id+'" name="param'+obj.id+'" class="m-wrap" paramRadioId="'+radioValues[j].id+'" value="'+radioValues[j].value+'"/>'+radioValues[j].value+'</label>';
									}
								}
							}else{
								if(productId!='' && obj.value){
									str +='<input paramId="'+obj.id+'" value="'+obj.value+'" name="param'+obj.id+'" type="text"   class="large m-wrap" />';
								}else{
									str +='<input paramId="'+obj.id+'"  name="param'+obj.id+'" type="text"   class="large m-wrap" />';
								}
							}
							str +='</div></div></div>';
							if((i+1)%2==0){
								str +="</div>";
							}
						}
						if(res.length%2==0){
							str +="<div>";
						}
						$("#params").html(str);
						$("#params").css({border:"1px solid green"});
					}else{
						$("#params").html("");
						$("#params").css({border:"0px"});
					}
				}
				
		   });
		}else{
			$("#params").html("");
			$("#params").css({border:"0px"});
		}
	}
	//得到子类别JSON对象
	function getSubCategory(){
		var subNodeDiv = $("div[id^=subCategory]");
		var subCategoryArray = new Array();
		subNodeDiv.each(function(){
			var subInputs = $(this).find("input");
			var obj={};
			subInputs.each(function(){
				obj[$(this).attr("key")] = $(this).val();
			});
			subCategoryArray.push(obj);
		});
		return subCategoryArray;
	}
	//得到参数对应值JSON对象
	function getParams(){
		var inputParams=$("#params input");
		var paramArray = new Array();
		inputParams.each(function(){
			var obj;
			if($(this).attr("type")=='radio'){
				if($(this).attr("checked")){
					obj = {"classifyParamId":$(this).attr("paramId"),"value":$(this).val(),"paramRadioId":$(this).attr("paramRadioId")};
					paramArray.push(obj);
				}
			}else{
				if($(this).val()!=""){
					obj = {"classifyParamId":$(this).attr("paramId"),"value":$(this).val()};
					paramArray.push(obj);
				}
			}
			
		});
		return paramArray;
	}
	
	function getProductBaseAttr(){
		var params = $("#form-save .product,input[name='descriptionUrl']").serialize();
		return params;
	}
	
	function updateSubCategoryIndex(){
		$("div[id^='subCategory']").each(function(index) {
		  $(this).attr("id","subCategory"+index);
		  $(this).find(".delSubCategory").attr("btnId",index);
		});
	}
	
	function getSubCateGoryLength(){
		return $("div[id^='subCategory']").length;
	}
	