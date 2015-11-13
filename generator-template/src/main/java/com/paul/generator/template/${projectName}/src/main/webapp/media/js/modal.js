$(function(){
	var modal=$("[data-target='modal']");
	
	$("body").append('<div class="modal fade">'+
	  '<div class="modal-dialog">'+
	    '<div class="modal-content">'+
	      '<div class="modal-header">'+
	        '<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>'+
	        '<h4 class="modal-title">'+title+'</h4>'+
	      '</div>'+
	      '<div class="modal-body">'+
	      '</div>'+
	      '<div class="modal-footer">'+
	        '<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>'+
	        '<button type="button" class="btn btn-primary">确定</button>'+
	     ' </div>'+
	    '</div><!-- /.modal-content -->'+
	  '</div><!-- /.modal-dialog -->'+
	'</div><!-- /.modal -->');
});
