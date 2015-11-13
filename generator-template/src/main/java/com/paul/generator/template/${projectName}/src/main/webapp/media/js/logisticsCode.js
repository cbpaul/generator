(function($) {
	var logisticsCodes = "[{\"id\":1,\"code\":\"shunfeng\",\"name\":\"顺丰快递\"},{\"id\":2,\"code\":\"shentong\",\"name\":\"申通快递\"},{\"id\":3,\"code\":\"yuantong\",\"name\":\"圆通快递\"},{\"id\":4,\"code\":\"yunda\",\"name\":\"韵达快递\"},{\"id\":5,\"code\":\"youzhengguonei\",\"name\":\"邮政包裹\"},{\"id\":6,\"code\":\"zhongtong\",\"name\":\"中通快递\"},{\"id\":7,\"code\":\"zhaijisong\",\"name\":\"宅急送\"},{\"id\":8,\"code\":\"guotongkuaidi\",\"name\":\"国通快递\"},{\"id\":9,\"code\":\"huitongkuaidi\",\"name\":\"汇通快递\"},{\"id\":10,\"code\":\"youzhengguonei\",\"name\":\"挂号信\"},{\"id\":11,\"code\":\"ems\",\"name\":\"EMS国内\"},{\"id\":12,\"code\":\"emsguoji\",\"name\":\"EMS国际\"},{\"id\":13,\"code\":\"ems\",\"name\":\"E邮宝\"},{\"id\":14,\"code\":\"huiqiangkuaidi\",\"name\":\"汇强快递\"},{\"id\":15,\"code\":\"jiajiwuliu\",\"name\":\"佳吉快运\"},{\"id\":16,\"code\":\"jiayiwuliu\",\"name\":\"佳怡物流\"},{\"id\":17,\"code\":\"canpost\",\"name\":\"加拿大邮政\"},{\"id\":18,\"code\":\"kuaijiesudi\",\"name\":\"快捷速递\"},{\"id\":19,\"code\":\"longbanwuliu\",\"name\":\"龙邦速递\"},{\"id\":20,\"code\":\"lianbangkuaidi\",\"name\":\"联邦快递\"},{\"id\":21,\"code\":\"lianhaowuliu\",\"name\":\"联昊通\"},{\"id\":22,\"code\":\"ganzhongnengda\",\"name\":\"能达速递\"},{\"id\":23,\"code\":\"rufengda\",\"name\":\"如风达\"},{\"id\":24,\"code\":\"ruidianyouzheng\",\"name\":\"瑞典邮政\"},{\"id\":25,\"code\":\"quanyikuaidi\",\"name\":\"全一快递\"},{\"id\":26,\"code\":\"quanfengkuaidi\",\"name\":\"全峰快递\"},{\"id\":27,\"code\":\"quanritongkuaidi\",\"name\":\"全日通\"},{\"id\":28,\"code\":\"suer\",\"name\":\"速尔快递\"},{\"id\":29,\"code\":\"tnt\",\"name\":\"TNT快递\"},{\"id\":30,\"code\":\"tiantian\",\"name\":\"天天快递\"},{\"id\":31,\"code\":\"tiandihuayu\",\"name\":\"天地华宇\"},{\"id\":32,\"code\":\"ups\",\"name\":\"UPS快递\"},{\"id\":33,\"code\":\"usps\",\"name\":\"USPS(美国邮政)\"},{\"id\":34,\"code\":\"xinbangwuliu\",\"name\":\"新邦物流\"},{\"id\":35,\"code\":\"neweggozzo\",\"name\":\"新蛋物流\"},{\"id\":36,\"code\":\"hkpost\",\"name\":\"香港邮政\"},{\"id\":37,\"code\":\"youshuwuliu\",\"name\":\"优速快递\"},{\"id\":38,\"code\":\"zhongtiewuliu\",\"name\":\"中铁快运\"},{\"id\":39,\"code\":\"zhongyouwuliu\",\"name\":\"中邮物流\"},{\"id\":40,\"code\":\"anxindakuaixi\",\"name\":\"安信达\"},{\"id\":41,\"code\":\"auspost\",\"name\":\"澳大利亚邮政\"},{\"id\":42,\"code\":\"youzhengguonei\",\"name\":\"包裹平邮\"},{\"id\":43,\"code\":\"bangsongwuliu\",\"name\":\"邦送物流\"},{\"id\":44,\"code\":\"dhl\",\"name\":\"DHL快递\"},{\"id\":45,\"code\":\"datianwuliu\",\"name\":\"大田物流\"},{\"id\":46,\"code\":\"debangwuliu\",\"name\":\"德邦物流\"},{\"id\":47,\"code\":\"gongsuda\",\"name\":\"共速达\"},{\"id\":48,\"code\":\"youzhengguoji\",\"name\":\"国际小包\"},{\"id\":49,\"code\":\"tiandihuayu\",\"name\":\"华宇物流\"},{\"id\":50,\"code\":\"rufengda\",\"name\":\"凡客配送\"},{\"id\":51,\"code\":\"fedex\",\"name\":\"FedEx(国际件)\"}]";
	var logisticsCodeJson = $.parseJSON(logisticsCodes);
	$.extend($.fn, {
		logisticsCode:function(defaultValue){
			if($(this[0]).is('select')){
				var appendHtml = "<option value=''>---请选择---</option>";
				for(var i=0 ;i<logisticsCodeJson.length;i++){
					if(defaultValue == logisticsCodeJson[i].id){
						appendHtml +='<option selected="selected" value="'+logisticsCodeJson[i].id+'">'+logisticsCodeJson[i].name+'</option>';
					}else{
						appendHtml +='<option value="'+logisticsCodeJson[i].id+'">'+logisticsCodeJson[i].name+'</option>';
					}
					
				}
				$(this[0]).html(appendHtml);
			}
		},
	});
}(jQuery));

