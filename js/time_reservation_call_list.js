var contextPath ;
var callListExportHeader;
var callListExportGrid;
var callListExportData;

var selectListAccesibility;
var selectListLockedOrders;

var idDomainList;
var idCasetypeList;  
var idAreaList;  
var idAccessibilityList;   
var idLanguageList;  
var idLockedordersList;  
var idCallAttemptsSlider; 
var idSearchResultsTable; 
var idDivExportLink;

var domainVal;
var caseTypeVal;  
var areaVal;  
var accessibilityVal;   
var languageVal;  
var lockedOrdersVal;  
var callAttemptsVal; 

var i18nSelectDomain;

var rangeSliderMin = 0;
var rangeSliderMax = 10;


//////////////////////////////
/// On Load
//////////////////////////////

jQuery(document).ready(function($){
	
	init();
	
});

$(function(){	
	
	renderTable("#block-time-reservation-call-list-table");

});	

function init() {

	// Slider Creation
	$(""+idCallAttemptsSlider+"").rangeSlider({
	  bounds: {min:0, max: 10}
	});
	$(""+idCallAttemptsSlider+"").rangeSlider({step: 1});
	$(""+idCallAttemptsSlider+"").rangeSlider("values", rangeSliderMin, rangeSliderMax);
	
	$(""+idDivExportLink+"").hide();
	
	loadDomainList();
}


function loadDomainList() {	
	
	var obj= {};
	obj.url=contextPath+"/std/GetDomains.action";		
	obj.successfunc = function(data) {
		var items='';	
		$.each(data, function(i, item) {
			items += '<option value="' + item.id + '">'	+ item.name + '</option>';
			});
		$(""+idDomainList+"").html(items);
		$(""+idDomainList+"").multiselect("refresh");	
	};
	obj.errorfunc = errorDetails;
	run_ajax_json(obj);
	return;	
}


function onChangeDomain()
{
	updateFilterValues();
	
	if(domainVal != null) {		
		
		if(accessibilityVal == null) { 
			loadAccesibilitySelectModelList(); 
		}
		if(lockedOrdersVal == null)  { 
			loadLockedOrderSelectModelList();  
		}
		
		loadDynamicSelectModelList(idAreaList, "AnalyzeFieldWorkEfficiencyAreas.action");
		loadDynamicSelectModelList(idCasetypeList, "GetCaseType.action");
		loadDynamicSelectModelList(idLanguageList, "GetContactLanguages.action");
		
	} else {				
		resetFilters();
	}
}


function loadDynamicSelectModelList(selectModelListId, actionPath)
{
	var obj= {};
	obj.url=contextPath+"/std/"+actionPath;
	obj.pdata="domainCodes="+ domainVal;
	obj.successfunc = function(data) {
		var items = "";
		$.each(data, function(i, item) {
			items += '<option value="' + item.id + '">'	+ item.name + '</option>';
		});
		populateSelectModelsList(selectModelListId, items);
	};
	obj.errorfunc = errorSelectModel;	
	run_ajax_json(obj);
	return;	
}


function loadAccesibilitySelectModelList() {
	
	var items = "";
	items += '<option value="accesopt1">Inaccessible meter before field work started. </option>';
	items += '<option value="accesopt2">Inaccessible meter confirmed in field.</option>';
	items += '<option value="accesopt3">Accessible meter.</option>';
	
	populateSelectModelsList(idAccessibilityList, items);
}

function loadLockedOrderSelectModelList() {
	
	var items = "";
	items += '<option value="1"> Yes </option>';
	items += '<option value="0"> No </option>';
	
	populateSelectModelsList(idLockedordersList, items);
}


function populateSelectModelsList(modelListId, items) {
	
	$(""+modelListId+"").empty();
	$(""+modelListId+"").html(items);
	$(""+modelListId+"").multiselect("refresh");
}


function clearSelectModelsList(modelListId) {
	
	$(""+modelListId+"").empty();
	$(""+modelListId+"").multiselect("refresh");
}

//////////////////////////////
/// On Submit Functions
//////////////////////////////

function validateOnSubmit() {

	$(idSearchResultsTable+" > tbody").empty();
	
	if($(""+idDomainList+"").val() != null) {
		submitForm(); 	
	} else {
	    alert(i18nSelectDomain);
	}	 
}

function submitForm() {
	
	var param  = prepareParamQueryString();
		
	var obj= {};
	obj.url=contextPath+"/std/TimeReservationCallListResults.action";
	obj.pdata=param;
	obj.successfunc = populateTimeReservationCallListResults;
	obj.errorfunc = errorSelectModel;	
	run_ajax_json(obj);
	return;	
}

function prepareParamQueryString() {
	
	var array = [];
	var index = 0;

	updateFilterValues();
	
	if(domainVal != null) {
		array[index] = "domain="+domainVal;  				index++; 
	}
	if(caseTypeVal != null) { 
		array[index] = "&casetype="+caseTypeVal; 			index++;
	}
	if(areaVal != null) { 
		array[index] = "&area="+areaVal; 					index++; 
	}
	if(accessibilityVal != null) { 
		array[index] = "&accessibility="+accessibilityVal; 	index++; 
	}
	if(languageVal != null)	{ 
		array[index] = "&contactlanguage="+languageVal; 	index++; 
	}
	if(lockedOrdersVal != null)	{ 
		array[index] = "&lockedorders="+lockedOrdersVal; 	index++; 
	}
	if(callAttemptsVal != null)	{ 	
		if(callAttemptsVal.min != null && callAttemptsVal.max != null) {
			if( callAttemptsVal.min > rangeSliderMin || callAttemptsVal.max < rangeSliderMax)	{ 		
				array[index] = "&vcalatmptmin="+callAttemptsVal.min; 	index++; 
				array[index] = "&vcalatmptmax="+callAttemptsVal.max; 	index++;
			}
		}	
	}	
	return array.join ('');
}


function populateTimeReservationCallListResults(callListData) {
	
	if(callListData != "" || callListData!=null) {
		
		callListExportData = null;	
		var callListDataLength = callListData.length;	
		if(callListDataLength > 0) {
			
			for(var i=0; i<callListDataLength; i++) {		
				
				var callListDetail = callListData[i];
				var trClass = '';
				if(i==0||i%2==0) {
					trClass = 'table-line line-grey';
				} else {
					trClass = 'table-line';
				}
	
				if(callListDetail.caseId == null || typeof (callListDetail.caseId) == 'undefined') {
					callListDetail.caseId = "" ;
				} 	
				if(callListDetail.lockedBy == null || typeof (callListDetail.lockedBy) == 'undefined') {
					callListDetail.lockedBy = "" ;
				} 
				if(callListDetail.lastContact == null || typeof (callListDetail.lastContact) == 'undefined') {
					callListDetail.lastContact = "" ;
				} 
				if(callListDetail.caseType == null || typeof (callListDetail.caseType) == 'undefined') {
					callListDetail.caseType = "" ;
				} 
				if(callListDetail.customerName == null || typeof (callListDetail.customerName) == 'undefined') {
					callListDetail.customerName = "" ;
				} 
				if(callListDetail.milestoneArea == null || typeof (callListDetail.milestoneArea) == 'undefined') {
					callListDetail.milestoneArea = "" ;
				} 
				if(callListDetail.caBefFv == null || typeof (callListDetail.caBefFv) == 'undefined') {
					callListDetail.caBefFv = "" ;
				} 
				if(callListDetail.caAftFv == null || typeof (callListDetail.caAftFv) == 'undefined') {
					callListDetail.caAftFv = "" ;
				} 
				if(callListDetail.dtcAftFv == null || typeof (callListDetail.dtcAftFv) == 'undefined') {
					callListDetail.dtcAftFv = "" ;
				} 	
	
				if(callListExportData == null || typeof (callListExportData) == 'undefined'){
					callListExportData= "['"+callListDetail.caseId+"','"+callListDetail.lockedBy+"','"+callListDetail.lastContact+"','"+callListDetail.caseType+"','"+callListDetail.customerName+"','"+callListDetail.milestoneArea+"','"+callListDetail.caBefFv+"','"+callListDetail.caAftFv+"','"+callListDetail.dtcAftFv+"']";
				} else { 	
					callListExportData = callListExportData + ",['"+callListDetail.caseId+"','"+callListDetail.lockedBy+"','"+callListDetail.lastContact+"','"+callListDetail.caseType+"','"+callListDetail.customerName+"','"+callListDetail.milestoneArea+"','"+callListDetail.caBefFv+"','"+callListDetail.caAftFv+"','"+callListDetail.dtcAftFv+"']";
				}
				 
				
				$(idSearchResultsTable+" > tbody").append(
					"<tr class='" + trClass+ "'> " +
						"<td> &nbsp;&nbsp;&nbsp; <a href='"+contextPath+"/std/ViewCase?id="+callListDetail.caseId+"' class='text-blue'>" + callListDetail.caseId + "</a></td>" +
						"<td>" + callListDetail.lockedBy + "</td>" +
						"<td>" + callListDetail.lastContact + "</td>" +
						"<td>" + callListDetail.caseType + "</td>" +
						"<td>" + callListDetail.customerName + "</td>" +
						"<td>" + callListDetail.milestoneArea + "</td>" +
						"<td>" + callListDetail.caBefFv + "</td>" +
						"<td>" + callListDetail.caAftFv + "</td>" +
						"<td>" + callListDetail.dtcAftFv + "</td>" +
					"</tr>");	
			}
		
			initCallListExportGrid();	
			setCallListExportGrid(callListExportData);
			
			$(""+idDivExportLink+"").show();
			
		} else {
			$(""+idDivExportLink+"").hide();
		}
	}
}

function initCallListExportGrid(){    
	
	callListExportGrid = new dhtmlXGridObject('callListGridDiv');            
	callListExportGrid.setImagePath(contextPath+"/js/dhtmlxGrid/codebase/imgs/");          
	callListExportGrid.setHeader(callListExportHeader);                    
	callListExportGrid.setInitWidths("*,*,*,*,*,*,*,*,*"); 
	callListExportGrid.setColAlign("center,center,center,center,center,center,center,center,center"); 
	callListExportGrid.setSkin("xp"); 
	callListExportGrid.init();
 }     	       

function setCallListExportGrid(data){	
	var griddata = eval('['+data+']');
	callListExportGrid.clearAll();	
	callListExportGrid.parse(griddata,"jsarray");
}



//////////////////////////////
/// Private Functions
//////////////////////////////

function updateFilterValues() {
	
	domainVal 			= $(""+idDomainList+"").val();
	caseTypeVal			= $(""+idCasetypeList+"").val();  
	areaVal 			= $(""+idAreaList+"").val();  
	accessibilityVal 	= $(""+idAccessibilityList+"").val();   
	languageVal	 		= $(""+idLanguageList+"").val();  
	lockedOrdersVal 	= $(""+idLockedordersList+"").val();  
	callAttemptsVal 	= $(""+idCallAttemptsSlider+"").rangeSlider("values");
}



function resetFilters() {	

	$(""+idCallAttemptsSlider+"").rangeSlider({step: 1});
	$(""+idCallAttemptsSlider+"").rangeSlider("values", 0, 10);
	
	clearSelectModelsList(""+idCasetypeList+"");
	clearSelectModelsList(""+idAreaList+"");
	clearSelectModelsList(""+idAccessibilityList+"");
	clearSelectModelsList(""+idLanguageList+"");
	clearSelectModelsList(""+idLockedordersList+"");
}



//////////////////////////////
/// Error Functions
//////////////////////////////

function errorDetails() {
	//alert(" Error ");
}

function errorSelectModel() {
	//alert(" Error 2 ");
}

	
