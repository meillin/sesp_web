var contextPath = "";
var criteria ="";
var from_err_msg="";
var to_err_msg="";
var i18nerrorFromDateOlderThanToDate;
var domain_err_msg="";
var areatype_err_msg="";
var area_err_msg="";
var workordertype_err_msg="";
var dateinterval_err_msg="";
var filters_msg="";
var areaWOMapInfoRParams;
var pgCode = 9;
var area_name1 = "";
var defaultStr = "default";
jQuery(document).ready(function($){

	/*
	 * tabs managing
	 */
    $("#block-work-order-tab1").click(function(){

    	if( !$(this).hasClass("selected")){
	    	$(".tab").removeClass("selected");
	    	$(this).addClass("selected");
	    	/**
	    	 * TODO
	    	 * action on the first tab
	    	 */
    	}
    });

    $("#block-work-order-tab2").click(function(){
    	if( !$(this).hasClass("selected")){
	    	$(".tab").removeClass("selected");
	    	$(this).addClass("selected");
	    	/**
	    	 * TODO
	    	 * action on the second tab
	    	 */
    	 }
    });
});

function loadvalues(){
	if(area_name1!=null&&area_name1!='') {
		$("#area-name").val(area_name1);
	}
	populateAPDateIntervalFilters();
	loadDomainList();
	loadAreaTypes2();
	getAreas(defaultStr);
	loadWorkOrderTypes();
	loadDefaultTabs();

	//filter_submit();
	//getAreas();
	//Meilan added this function. tobe removed
}

function populateAPDateIntervalFilters() {

	var ap_dateInterval = $.cookie(pgCode+"ap_dateInterval");
	if(ap_dateInterval!=null && ap_dateInterval!='') {
		$("#filter-select-date-interval").val(ap_dateInterval);
	}
	show();

	if(ap_dateInterval == "custominterval") {
		var ap_dateFrom = $.cookie(pgCode+"ap_dateFrom");
		if(ap_dateFrom!=null && ap_dateFrom!='') {
			//var dataarray = ap_dateFrom.split(",");
			$("#filter-date-from").val(ap_dateFrom);
		}

		var ap_dateTo = $.cookie(pgCode+"ap_dateTo");
		if(ap_dateTo!=null && ap_dateTo!='') {
			//var dataarray = ap_dateFrom.split(",");
			$("#filter-date-to").val(ap_dateTo);
		}
	}

	var ap_unplanned = $.cookie(pgCode+"ap_unplanned");
	$("#filter-checkbox-unplanned").attr('checked', ap_unplanned);

	return true;
}

function domainChanged(){
	getAreas("Domain changed");
}

function areaTypeChanged(){
	getAreas("Area type changed");
}


function loadDomainList() {
	var obj= {};
	obj.url=contextPath+"/std/GetDomains.action";
	obj.successfunc = function(data) {
		var items;
		var savedData = $.cookie(pgCode+"ap_domain");
		var selected = '" > ';

		if(savedData == null || savedData == ''){
			selected = '" selected > ';
		}

		$.each(data, function(i, item) {
			items += '<option value="' + item.id +selected + item.name + '</option>';
		});

		populateSavedMultiSelectBox("#filter-multiselect-domain", items,savedData);
	};
	obj.errorfunc = errorDetails;
	run_ajax_json(obj);
	return;
}

function errorDetails(data) {
	alert("Error : " + data.responseText);
}

function loadAreaTypes(){
	var obj1= {};
	obj1.url=contextPath+"/std/AlertManagementAreaTypes.action";
	obj1.successfunc = function(data){

	var items;
	var savedData = $.cookie(pgCode+"ap_areaType");
	var selected = '" > ';

	if(savedData == null || savedData == ''){
		selected = '" selected > ';
	}

	$.each(data, function(i, item) {
		items += '<option value="' + item.id +selected + item.name + '</option>';
	});

	populateSavedMultiSelectBox("#filter-multiselect-area-type", items,savedData);
	};
	obj1.errorfunc = errorDetails;
	run_ajax_json(obj1);
	return;
}


function loadAreaTypes2(){
	var obj1= {};
	obj1.url=contextPath+"/std/AlertManagementAreaTypes.action";
	obj1.successfunc = function(data){

	var items;
	var savedData = $.cookie(pgCode+"ap_areaType");
	var selected = '" > ';

	if(savedData == null || savedData == ''){
		selected = '" selected > ';
	}

	$.each(data, function(i, item) {
		items += '<option value="' + item.id +selected + item.name + '</option>';
	});

	populateSavedMultiSelectBox("#filter-multiselect-area-type", items,savedData);

	};
	obj1.errorfunc = errorDetails;
	run_ajax_json(obj1);
	return;


	}

function loadWorkOrderTypes(){
	var obj2= {};
	obj2.url=contextPath+"/std/getWorkOrderTypes.action";
	obj2.successfunc = populateWorkOrderTypes;
	obj2.errorfunc = errorDetails;
	run_ajax_json(obj2);

	return;
}

function populateWorkOrderTypes(data){
	var items;
	var savedData = $.cookie(pgCode+"ap_workOrderType");
	var selected = '" > ';

	if(savedData == null || savedData == ''){
		selected = '" selected > ';
	}

	$.each(data, function(i, item) {
		items += '<option value="' + item.id +selected + item.name + '</option>';

	});

	populateSavedMultiSelectBox("#filter-multiselect-work-order-type", items,savedData);
}

function getAreas(requestType) {

	var ap_domain = $("#filter-multiselect-domain").val();
	var ap_areaType = $("#filter-multiselect-area-type").val();

	if(requestType == defaultStr){
		ap_domain = ap_areaType = requestType;
	}

	var obj = {};
	obj.url = contextPath + "/std/AlarmManagementAreas.action";
	/*var domainCode= (ap_domain==null ? null : ap_domain);
	var areaCode = (ap_areaType==null ? null : ap_areaType);*/

	obj.pdata = "domainCode=" + ap_domain + "&areaTypeCode=" + ap_areaType;
	obj.successfunc = fillAreas;
	obj.errorfunc = errorDetails;
	run_ajax_json(obj);

	return;
}

function fillAreas(data) {
	var items;
	var savedData = $.cookie(pgCode+"ap_area");
	var selected = '" > ';

	if(savedData == null || savedData == ''){
		selected = '" selected > ';
	}

	$.each(data, function(i, item) {
		items += '<option value="' + item.id +selected + item.name + '</option>';

	});

	populateSavedMultiSelectBox("#filter-multiselect-area", items,savedData);
}


function filter_submit() {

		//Give it default value in order to show chart on page load
		var ap_dateInterval = $("#filter-select-date-interval").val();
		var ap_dateFrom = $("#filter-date-from").val();
		var ap_dateTo = $("#filter-date-to").val();
		var ap_domain = $("#filter-multiselect-domain").val() || '6, 7, 8';
		var ap_areaType = $("#filter-multiselect-area-type").val() || '10,9,8,11,7,12,13';
		var ap_workOrderType = $("#filter-multiselect-work-order-type").val() || '41,44,81,51,53,55,57,59,61,63,65,112,130,152,128,140,460,207,107,126,136,173,462,110,256,147,168,149,143,464,145,466,211,68,69,70,82,135,154,74,77,78,84,179,180,183,184,185,186,187,188,189,190,191,192,193,194,195,175,196,197,176,198,199,200,177,178,201,202,203,204,205,181,182';
		var ap_unplanned = $("#filter-checkbox-unplanned").prop('checked');
		var ap_area = $("#filter-multiselect-area").val() || '7,8,9,10,11,12,13,14,15';

		if(ap_dateInterval == "custominterval"){
				if(!validateInputs(ap_dateFrom,from_err_msg)){
					return false;
				}
				if(!validateInputs(ap_dateTo,to_err_msg)){
					return false;
				}
				if(new Date(ap_dateFrom) > new Date(ap_dateTo)){
					alert(i18nerrorFromDateOlderThanToDate);
					return false;
				}
		}

		if(!validateInputs(ap_domain,domain_err_msg)){
			return false;
		}
		if(!validateInputs(ap_areaType,areatype_err_msg)){
			return false;
		}
		if(!validateInputs(ap_workOrderType,workordertype_err_msg)){
			return false;
		}
		if(!validateInputs(ap_area,area_err_msg)){
			return false;
		}

		if($("#filter-multiselect-area").text()!=null && $("#filter-multiselect-area").text()!='') {
				$("#area-name").val(area_name1);
		}
		saveAPFilters(ap_dateInterval,ap_dateFrom,ap_dateTo,ap_domain,ap_areaType,ap_workOrderType,ap_unplanned,ap_area);

		//Removing old data for summaryWorkOrder
		$("#block-summary-content-wo-count").html("");
		$("#summary-workordertypes-selected").html("");

		//Removing old charts
		//refreshChart1();
		//refreshChart2();

		var obj3= {};
		obj3.url=contextPath+"/std/WorkOrderStatusChart.action";
		obj3.pdata = 'dateInterval='+ap_dateInterval+'&dateFrom='+ap_dateFrom+'&dateTo='+ap_dateTo+'&domain='+ap_domain+
			'&areaType='+ap_areaType+'&workOrderType='+ap_workOrderType+'&unplanned='+ap_unplanned+'&area='+ap_area;

		var orderType = $.cookie(pgCode+"block-work-order-tab");

		if(orderType != "undefined" && orderType != null && orderType != ""){

			if(orderType == "progress"){
				updateStatusTab("#block-work-order-tab1","#block-work-order-tab2");
				obj3.successfunc = drawChart1;
				//run_ajax(obj3);

			}else if(orderType == "status"){
				updateStatusTab("#block-work-order-tab2","#block-work-order-tab1");
				obj3.successfunc = drawChart2;
				//run_ajax(obj3);
			}
		}else{
			obj3.successfunc = drawChart1;
			//run_ajax(obj3);
		}

		obj3.errorfunc = errorDetails;
		run_ajax(obj3);

		loadPoints(ap_dateInterval,ap_dateFrom,ap_dateTo,ap_domain,ap_areaType,ap_workOrderType,ap_unplanned,ap_area);
		return;
}

function cleanPage(){

}

function loadPoints(ap_dateInterval,ap_dateFrom,ap_dateTo,ap_domain,ap_areaType,ap_workOrderType,ap_unplanned,ap_area) {

	var obj= {};
	obj.url=contextPath+"/std/getAreaPoints.action";
	obj.pdata = 'dateInterval='+ap_dateInterval+'&dateFrom='+ap_dateFrom+'&dateTo='+ap_dateTo+'&domain='+ap_domain+
		'&areaType='+ap_areaType+'&workOrderType='+ap_workOrderType+'&unplanned='+ap_unplanned+'&area='+ap_area;
	obj.successfunc = loadPointsSuccess;
	obj.errorfunc = errorDetails;
	run_ajax(obj);
	return;

}

function xyz(data) {

	var respdata = eval(data);
	var noOfWorkOrders = respdata.noOfWorkOrders;
	var workOrderTypes = respdata.workOrderTypes;
	var areaProgressMap = respdata.areaProgressMap;
	var workOrderProgressChartxml = respdata.workOrderProgressChartxml;
	var detailedProgressxml = respdata.detailedProgressxml;

}

function show(){

	if($("#filter-select-date-interval").val()=="custominterval"){
		//document.getElementById("filter-custom-date-interval").style.visibility="visible";
		showDate();
			//$('#filter-custom-date-interval').css("visibility","visible");
		} else {
			hideDate();
			//document.getElementById("filter-custom-date-interval").style.visibility="hidden";
			//$('#filter-custom-date-interval').css("visibility","hidden");
		}
}

function hideDate()
{
	//$("#block_from_and_to_date").hide();

	$("#filter-date-from").hide();
	$("#filter-date-to").hide();
}

function showDate(){

	//$("#block_from_and_to_date").show();
	$("#filter-date-from").show();
	$("#filter-date-to").show();
}

function showWorkOrderTypes(data){
	var items2;
	$.each(data, function(i, item2) {
		items2 +='<div class="sub-block-summary-content">'+item2.workOrderTypeTOList+'</div>';
	});
	$("#filter-multiselect-work-order-type").html(items2);
	$("#filter-multiselect-work-order-type").multiselect("refresh");
	}

function drawChart1(data) {

	console.log('function drawChart1() called');

	showWorkOrderProgressCharts();
	$("#block-summary-content-wo-count").html(eval(data.totalNoOfWorkOrders));

	//$("#block-summary-content-wo-count").html('no data');
	var summaryWorkOrderId = "#summary-workordertypes-selected";
	//Removing old data for summaryWorkOrder
	$(summaryWorkOrderId).html("");

	var workOrderTypeVals = document.getElementById('filter-multiselect-work-order-type');
	var ordersLength = workOrderTypeVals.options.length;

	for ( var i = 0; i < ordersLength; i++) {
		if (workOrderTypeVals.options[i].selected) {
			$(summaryWorkOrderId).append('<li>' + workOrderTypeVals.options[i].text+"</li>");
		}
	}

	//Work Order Progress
		//Generate Javascript Fusion chart with a dummy data
	var myChart = new FusionCharts("Doughnut2D","order-progress", "100%", "300", "0" );
      myChart.setJSONUrl(contextPath + "/data/dummydata.json");
      myChart.render("block-work-order-chart-view");

  var myChart2 = new FusionCharts( "Line", "work-order-progress", "100%", "300" );
      myChart2.setJSONUrl(contextPath + "/data/dummydata.json");
			myChart2.render("block-work-order-chart-view2");
/*
	var stockChart = new FusionCharts(contextPath+"/js/fusionchartsxt/charts/Doughnut2D.swf", "Work Order Progress"+randomNum,"930","513");
	stockChart.setDataXML(data.workOrderProgress);
	stockChart.render("block-work-order-chart-view");

	stockChart = new FusionCharts(contextPath+"/js/fusionchartsxt/charts/MSCombi2D.swf", "Weekly DetailedProgress"+randomNum,"930","513");
	stockChart.setDataXML(data.detailedProgress);
	stockChart.render("block-work-order-chart-view2");
*/
}

function refreshChart1(){
	console.log('refreshchart1');

	//Generate Javascript Fusion chart with a dummy data
	var myChart = new FusionCharts("Doughnut2D","myChartId", "100%", "300", "0" );
      myChart.setXMLData("<chart caption='Weekly Sales Summary' xAxisName='Week' " +
        "yAxisName='Sales' numberPrefix='$'>" +
          "<set label='Week 1' value='14400' />" +
          "<set label='Week 2' value='19600' />" +
          "<set label='Week 3' value='24000' />" +
          "<set label='Week 4' value='15700' />" +
        "</chart>");
      myChart.render("block-work-order-chart-view");

      var myChart2 = new FusionCharts( "Line", "fakechart", "100%", "300" );
			myChart2.setXMLData("<chart caption='Weekly Sales Summary' xAxisName='Week' " +
        "yAxisName='Sales' numberPrefix='$'>" +
          "<set label='Week 1' value='14400' />" +
          "<set label='Week 2' value='19600' />" +
          "<set label='Week 3' value='24000' />" +
          "<set label='Week 4' value='15700' />" +
        "</chart>");
      myChart2.render("block-work-order-chart-view2");
	/*
	var randomNum = Math.random();
	//Work Order Progress

	var stockChart = new FusionCharts(contextPath+"/js/fusionchartsxt/charts/Doughnut2D.swf", "Work Order Progress"+randomNum,"930","513");
	stockChart.setDataXML("");
	stockChart.render("block-work-order-chart-view");

	stockChart = new FusionCharts(contextPath+"/js/fusionchartsxt/charts/MSCombi2D.swf", "Weekly DetailedProgress"+randomNum,"930","513");
	stockChart.setDataXML("");
	stockChart.render("block-work-order-chart-view2");
	*/
}

function updateWorkOrder(orderType){

	var ap_dateInterval = $("#filter-select-date-interval").val();
	var ap_dateFrom = $("#filter-date-from").val();
	var ap_dateTo = $("#filter-date-to").val();
	var ap_domain = $("#filter-multiselect-domain").val();
	var ap_areaType = $("#filter-multiselect-area-type").val();
	var ap_workOrderType = $("#filter-multiselect-work-order-type").val();
	var ap_unplanned = $("#filter-checkbox-unplanned").prop('checked');
	var ap_area = $("#filter-multiselect-area").val();

	if(ap_dateInterval == "custominterval"){
		if(!validateInputs(ap_dateFrom,from_err_msg)){
			return false;
		}
		if(!validateInputs(ap_dateTo,to_err_msg)){
			return false;
		}
		if(new Date(ap_dateFrom) > new Date(ap_dateTo)){
			alert(i18nerrorFromDateOlderThanToDate);
			return false;
		}
	}

	if(!validateInputs(ap_domain,domain_err_msg)){
		return false;
	}
	if(!validateInputs(ap_areaType,areatype_err_msg)){
		return false;
	}
	if(!validateInputs(ap_workOrderType,workordertype_err_msg)){
		return false;
	}
	if(!validateInputs(ap_area,area_err_msg)){
		return false;
	}

	saveAPFilters(ap_dateInterval,ap_dateFrom,ap_dateTo,ap_domain,ap_areaType,ap_workOrderType,ap_unplanned,ap_area);
	saveAreaProgressFilter("block-work-order-tab",orderType );

	//Removing old charts
	refreshChart1();
	refreshChart2();

	var obj3= {};
	obj3.url=contextPath+"/std/WorkOrderStatusChart.action";
	obj3.pdata = 'dateInterval='+ap_dateInterval+'&dateFrom='+ap_dateFrom+'&dateTo='+ap_dateTo+'&domain='+ap_domain+
	   		'&areaType='+ap_areaType+'&workOrderType='+ap_workOrderType+'&unplanned='+ap_unplanned+'&area='+ap_area;

	if(orderType != "undefined" && orderType != null && orderType != ""){
		var stockChart;
		if(orderType == "progress"){
			updateStatusTab("#block-work-order-tab1","#block-work-order-tab2");
			obj3.successfunc = drawChart1;
			obj3.errorfunc = errorDetails;
			run_ajax(obj3);

		}else if(orderType == "status"){
			updateStatusTab("#block-work-order-tab2","#block-work-order-tab1");

			obj3.successfunc = drawChart2;
			obj3.errorfunc = errorDetails;
			run_ajax(obj3);
		}

	}

	return;
}

function drawChart2(data){

	showWorkOrderStatusCharts();
	console.log("function drawChart2() called");
	$("#block-summary-content-wo-count").html(eval(data.totalNoOfWorkOrders));

	var summaryWorkOrderId = "#summary-workordertypes-selected";

	//Removing old data for summaryWorkOrder
	$(summaryWorkOrderId).html("");

	var workOrderTypeVals = document.getElementById('filter-multiselect-work-order-type');
	var ordersLength = workOrderTypeVals.options.length;

	for ( var i = 0; i < ordersLength; i++)
	{
		if (workOrderTypeVals.options[i].selected)
		{
			$(summaryWorkOrderId).append('<li>' + workOrderTypeVals.options[i].text+"</li>");
		}
	}

	var randomNum = Math.random();
	//Work Order Status Overview
	stockChart = new FusionCharts(contextPath+"/js/fusionchartsxt/charts/Pie2D.swf", "Work Order Status"+randomNum, "680", "545");
	stockChart.setDataXML(data.workOrderStatus);
	//alert("Work Order status xml " + data.workOrderStatus);
	stockChart.render("block-work-order-status-chart");

	//Work Order Status - Not Performed
	stockChart = new FusionCharts(contextPath+"/js/fusionchartsxt/charts/StackedColumn2D.swf", "Not Performed"+randomNum,"260","500");
	stockChart.setDataXML(data.notPerformedDetail);
	//alert("Work Order NP " + data.notPerformedDetail);
	stockChart.render("block-work-order-status-chart-right");

}

function refreshChart2(){
	console.log('refreshChart2');
	/*
	var randomNum = Math.random();
	//Work Order Status Overview
	stockChart = new FusionCharts(contextPath+"/js/fusionchartsxt/charts/Pie2D.swf", "Work Order Status"+randomNum, "680", "545");
	stockChart.setDataXML("");
	//alert("Work Order status xml " + data.workOrderStatus);
	stockChart.render("block-work-order-status-chart");

	//Work Order Status - Not Performed
	stockChart = new FusionCharts(contextPath+"/js/fusionchartsxt/charts/StackedColumn2D.swf", "Not Performed"+randomNum,"260","500");
	stockChart.setDataXML("");
	//alert("Work Order NP " + data.notPerformedDetail);
	stockChart.render("block-work-order-status-chart-right");
	*/
}


//Common method for validating the inputs
function validateInputs(inputVal,errorMessage){
	//var inputVal = $(selectName).val();
	if(inputVal == null || inputVal == ""){
		alert(errorMessage);
		return false;
	}
	return true;
}

function showWorkOrderStatusCharts(){
	//Hide Work Order Progress charts
	$("#block-work-order-chart-view").hide();
	$("#block-work-order-chart-view2").hide();
	//Show Work Order Status charts
	$("#block-work-order-status-chart").show();
	$("#block-work-order-status-chart-right").show();


}

function showWorkOrderProgressCharts(){

	//Hide Work Order Status charts
	$("#block-work-order-status-chart").hide();
	$("#block-work-order-status-chart-right").hide();

	//Show Work Order Progress charts
	$("#block-work-order-chart-view").show();
	$("#block-work-order-chart-view2").show();
	//$("#from_date").hide();

}

//Populate the multi-select box with the given data for the given id
function populateSavedMultiSelectBox(idName, items,savedData){

	$(idName).find('option').remove();
	$(idName).multiselect('refresh');

	var selectData = $(idName).multiselect();
	selectData.append(items);

	if(savedData!=null && savedData!='') {
		var dataArray = savedData.split(",");
		$(idName).val(dataArray);
	}

	selectData.multiselect('refresh');

}

function updateStatusTab(tabId1,tabId2){

	var tabSelected = "tab selected";
	$(tabId1).addClass(tabSelected);
	$(tabId2).removeClass(tabSelected);
	$(tabId2).addClass("tab");
}

function loadDefaultTabs(){

	var orderType = $.cookie(pgCode+"block-work-order-tab");
	if(orderType != "undefined" && orderType != null && orderType != ""){
		if(orderType == "progress"){
			updateStatusTab("#block-work-order-tab1","#block-work-order-tab2");
		}else if(orderType == "status"){
			updateStatusTab("#block-work-order-tab2","#block-work-order-tab1");
		}
	}
}

function saveAPFilters(ap_dateInterval,ap_dateFrom,ap_dateTo,ap_domain,ap_areaType,ap_workOrderType,ap_unplanned,ap_area) {
	$.cookie(pgCode+"ap_dateInterval",ap_dateInterval,{ expires: 7 });
	$.cookie(pgCode+"ap_dateFrom",ap_dateFrom,{ expires: 7 });
	$.cookie(pgCode+"ap_dateTo",ap_dateTo,{ expires: 7 });
	$.cookie(pgCode+"ap_domain",ap_domain,{ expires: 7 });
	$.cookie(pgCode+"ap_areaType",ap_areaType,{ expires: 7 });
	$.cookie(pgCode+"ap_workOrderType",ap_workOrderType,{ expires: 7 });
	$.cookie(pgCode+"ap_unplanned",ap_unplanned,{ expires: 7 });
	$.cookie(pgCode+"ap_area",ap_area,{ expires: 7 });
}

function saveAreaProgressFilter(key,value){
	$.cookie(pgCode+key,value,{ expires: 7 });
}
