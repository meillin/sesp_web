jQuery(document).ready(function($){
	
	$("#information-new-ca").hide();
	$("#information-new-tr").hide();
	$("#information-confirm-tr").show();
	
	
	$("input:radio[name=register-outcome]").click(function() {
		
		var value = $('input:radio[name=register-outcome]:checked').val();
		
		if(value=="register-outcome-confirm-time-reservation"){
			$("#information-new-ca").hide();
			$("#information-new-tr").hide();
			$("#information-confirm-tr").show();
		}else if(value=="register-outcome-new-call-agreed"){
			$("#information-confirm-tr").hide();
			$("#information-new-tr").hide();
			$("#information-new-ca").show();
		}else if(value=="register-outcome-new-time-reservation"){
			$("#information-new-ca").hide();
			$("#information-confirm-tr").hide();
			$("#information-new-tr").show();			
		}
	});
});
