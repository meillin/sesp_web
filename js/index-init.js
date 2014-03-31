var contextPath ;
var i18nerrorInvalidSearchInput;
var i18nerrorInvalidSearchAction;
var isAjaxSearch;

function validateSearchInput(searchInputTxt) {
	
	var regexp = /^[0-9a-zA-Z ,_]{0,50}$/;	
	return regexp.test(searchInputTxt);
}

function submitOnEnter(myfield,e)
{
    var keycode;
    if (window.event) keycode = window.event.keyCode;
    else if (e) keycode = e.which;
    else return true;

    if (keycode == 13){
    	searchentities();
        return false;
    } else {
    	return true;
    }      
}

function searchentities() {

	var searchInputTxt=$("#search-input").val();
	if(searchInputTxt == null || searchInputTxt.length == 0|| searchInputTxt.replace(/^\s+|\s+$/g,"").length == 0){
		errorInvalidSearchInput();
	} else {	
	
		if(validateSearchInput(searchInputTxt)) {
			window.location.replace(contextPath+"/std/ViewSearch?id="+searchInputTxt);
		} else {
			errorInvalidSearchInput();
		}
	}

}

function errorInvalidSearchInput() {
	alert(i18nerrorInvalidSearchInput);
}