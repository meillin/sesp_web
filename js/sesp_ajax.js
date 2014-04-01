function run_ajax_json(obj) {
    $.ajax({
    	type:"POST",
        url: obj.url,
        data: obj.pdata,
        dataType: 'json',
        //contentType: 'application/x-javascript;charset=UTF-8',
        async:true,
        error: function(data) {
	    	if(obj.errorfunc){
	            obj.errorfunc(data);
	        }
        },
        success: function(data) {
            if(obj.successfunc){
                obj.successfunc(data);
            }
        }
    });
}

function run_ajax(obj) {
    $.ajax({
        type:"POST",
        url: obj.url,
        data: obj.pdata,
        async:true,
        error: function(data) {
            if(obj.errorfunc){
                obj.errorfunc(data);
            }
        },
        success: function(data) {
            if(obj.successfunc){
                obj.successfunc(data);
            }
        }
    });
}

function run_ajax_Sync(obj) {
    $.ajax({
        type:"POST",
        url: obj.url,
        data: obj.pdata,
        async:false,
        error: function(data) {
	    	if(obj.errorfunc){
	            obj.errorfunc(data);
	        }
    	},
    	success: function(data) {
	        if(obj.successfunc){
	            obj.successfunc(data);
	        }
    	}
});
}

function download_ajax(obj) {
    $.ajax({
    	type:"POST",
        url: obj.url,
        data: obj.pdata,
        contentType: 'application/x-javascript;charset=UTF-8',
        async:true,
        error: function(data) {
	    	if(obj.errorfunc){
	            obj.errorfunc(data);
	        }
        },
        success: function(data) {
            if(obj.successfunc){
                obj.successfunc(data);
            }
        }
    });
}