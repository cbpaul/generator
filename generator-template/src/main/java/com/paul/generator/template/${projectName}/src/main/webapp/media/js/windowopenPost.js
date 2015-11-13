function jQueryOpenPostWindow(url,arg,argname,name){
		//创建表单对象
		var _form = $("<form></form>",{
		'id':'tempForm',
		'method':'post',
		'action':url,
		'target':name,
		'style':'display:none'
		}).appendTo($("body"));

		//将隐藏域加入表单
		_form.append($("<input>",{'type':'hidden','name':argname,'value':arg}));

		//绑定提交触发事件
		_form.bind('submit',function(){
		window.open("about:blank",name);
		});

		//触发提交事件
		_form.trigger("submit");
		//表单删除
		_form.remove();
		} 