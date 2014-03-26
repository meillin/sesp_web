	
	var contextPath ;
	var i18nerrorPleaseEnterUsername;
	var i18nerrorPleaseEnterPassword;			
	
	function submitLogin(formRef)
	{
		if(formRef.username.value=="")
		{
			alert(i18nerrorPleaseEnterUsername);
			formRef.username.focus();
			return;
		} if(formRef.password.value=="")
		{
			alert(i18nerrorPleaseEnterPassword);
			formRef.password.focus();
			return;
		}
		document.getElementById("divenable").style.display="none";
		document.getElementById("divdisable").style.display="block";
		loginSpinner();
		formRef.submit();	
	}
	
	function submitOnEnter(myfield,e)
	{
	    var keycode;
	    if (window.event) keycode = window.event.keyCode;
	    else if (e) keycode = e.which;
	    else return true;

	    if (keycode == 13){
	    	submitLogin(document.loginForm);
	        return false;
	    } else {
	    	return true;
	    }      
	}
	
	
	function getLoginFocus(formRef)
	{
		formRef.username.focus();		
	}
	