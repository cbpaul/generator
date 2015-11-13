	var photoPath = "";
	if(photoPath==""){
		photoPath="media/uploadPhoto/default_avatar.png";
	}
	var showImgDomID="";
	var newPathDomId="";
	var flashvars = {
	        js_handler:"jsfun",
	        swfID:"avatarEdit",
	        sourceAvatar:photoPath,
	        avatarLabel:"头像预览，请注意清晰度",
	        //sourcePicAPI:"http://asv5.sinaapp.com/widget/upload.php",
	        avatarAPI:"upload/uploadAvatar",
	        avatarSize:"180,180",
	        avatarSizeLabel:"180*180"
	    };
	 	var params = {
		        menu: "false",
		        scale: "noScale",
		        allowFullscreen: "true",
		        allowScriptAccess: "always",
		        bgcolor: "",
		        wmode: "transparent"
		    };
		var attributes = {
		        id:"AvatarUpload"
		    };

	    function jsfun(obj)
	    {
	        if(obj.type == "sourcePicSuccess") ;
	        if(obj.type == "sourcePicError") ;
	        if(obj.type == "avatarSuccess"){
				var newPath=obj.data.info;
				$("#"+newPathDomId).val(newPath);
				$("#"+showImgDomID).attr("src",newPath);
				$("#myModal").modal("hide");
	        }
	        if(obj.type == "avatarError") alert("上传失败");
	        //if(obj.type == "init") alert("flash初始化完成");
	        if(obj.type == "cancel")$("#myModal").modal("hide");
	        if(obj.type == "FileSelectCancel") {}
	        console.log(obj);
	    }