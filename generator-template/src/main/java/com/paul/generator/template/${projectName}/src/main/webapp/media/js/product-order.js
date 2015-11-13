$(function(){

});

function orderOp(node){
		$("#orderOp .modal-title").text($(node).text());
		$("#orderOp form").attr("action",$(node).attr("action"));
		var op = $(node).attr("op");
		var modalBodyHtml = "";
		if(op=="1"){//修改快递运费
			var shipAmount = $(node).attr("shipAmount")|"";
			modalBodyHtml = '<div class="control-group">\
								<label class="control-label " style="width: 80px;">运费\
								</label>\
								<div class="controls" style="margin-left: 102px;">\
									<input name="shipAmount" type="text" data-required="1"\
										value="'+shipAmount+'" class="m-wrap float" />\
								</div>\
							</div>';
		}else if(op=="2"){//关闭订单
			modalBodyHtml = '<div class="control-group">\
								<label class="control-label " style="width: 80px;">登录密码<span class="required">*</span>\
								</label>\
								<div class="controls" style="margin-left: 102px;">\
									<input name="password" type="password" data-required="1"\
										value="" class="m-wrap required" />\
								</div>\
							</div>';
			modalBodyHtml +='<div class="control-group">\
								<label class="control-label " style="width: 80px;">关闭理由<span class="required">*</span>\
								</label>\
								<div class="controls" style="margin-left: 102px;">\
									<textarea rows="5" class="required" cols="10" name="orderStatusMark"></textarea>\
								</div>\
							</div>';
		}else if(op=="3"){//发货
			modalBodyHtml ='<div class="control-group">\
								<label class="control-label " style="width: 80px;">物流公司<span class="required">*</span>\
								</label>\
								<div class="controls" style="margin-left: 102px;">\
									<select id="logistics" name="logisticsCodeId" class="select2" style="width:150px">\
									</select>\
								</div>\
							</div>';
			modalBodyHtml +='<div class="control-group">\
								<label class="control-label " style="width: 80px;">运单号<span class="required">*</span>\
								</label>\
								<div class="controls" style="margin-left: 102px;">\
									<input name="mailId" type="text" data-required="1"\
										value="" class="m-wrap required" />\
								</div>\
							</div>';
			
		}else if(op=="4"){//修改报名订单人数
			var number = $(node).attr("number")|"";
			modalBodyHtml = '<div class="control-group">\
								<label class="control-label " style="width: 80px;">人数\
								</label>\
								<div class="controls" style="margin-left: 102px;">\
									<input name="number" type="text" data-required="1"\
										value="'+number+'" class="m-wrap num" />\
								</div>\
							</div>';
		}
		modalBodyHtml +=' <div> <span class="error" style="color: red;font-size: 12 ;margin-top: 4px"></span></div>	';
		$("#orderOp .modal-body").html(modalBodyHtml);
		$("#logistics").logisticsCode();
		$("#orderOp").modal({
			modalOverflow : true,
			height : "200px",
			width : "550px"
		});
	}