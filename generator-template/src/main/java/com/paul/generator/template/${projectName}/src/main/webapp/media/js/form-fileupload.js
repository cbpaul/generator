var FormFileUpload = function () {


    return {
        //main function to initiate the module
        init: function (uploadUrl,param) {

            // Initialize the jQuery File Upload widget:
            $('#fileupload').fileupload({
                // Uncomment the following to send cross-domain cookies:
                //xhrFields: {withCredentials: true},
                url: uploadUrl+'?'+param,
                previewMaxWidth:"200",
                previewMaxHeight:"150",
            });
            // Load existing files:
            // Demo settings:
            $.ajax({
                // Uncomment the following to send cross-domain cookies:
                //xhrFields: {withCredentials: true},
                url: $('#fileupload').fileupload('option', 'url'),
                dataType: 'json',
                context: $('#fileupload')[0],
                maxFileSize: 5000000,
                acceptFileTypes: /(\.|\/)(gif|jpe?g|png)$/i,
                process: [{
                        action: 'load',
                        fileTypes: /^image\/(gif|jpeg|png)$/,
                        maxFileSize: 20000000 // 20MB
                    }, {
                        action: 'resize',
                        maxWidth: 1600,
                    	maxHeight: 1200,
                   		minWidth: 800,
                    	minHeight: 600
                    }, {
                        action: 'save'
                    }
                ]
            }).done(function (result) {
                $(this).fileupload('option', 'done')
                    .call(this, null, {
                    result: result
                });
            });

            // Upload server status check for browsers with CORS support:
            if ($.support.cors) {
                $.ajax({
                    url: uploadUrl,
                    type: 'HEAD'
                }).fail(function () {
                    $('<span class="alert alert-error"/>')
                        .text('Upload server currently unavailable - ' +
                        new Date())
                        .appendTo('#fileupload');
                });
            }

            // initialize uniform checkboxes  
            App.initUniform('.fileupload-toggle-checkbox');
        }

    };

}();