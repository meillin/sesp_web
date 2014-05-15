jQuery(document).ready(function($){

	$("#block-planning-periods .table-line").click(function() {
		if($(this).hasClass("selected")){
			$(this).removeClass("selected");
		}else{
			$(this).addClass("selected");
		}
	});

	$(".block-title-button-select-all").click(function(e){
		$("#block-planning-periods .table-line").addClass("selected");

		e.stopPropagation();
		return false;
	});

	$(".block-title-button-select-none").click(function(e){
		$("#block-planning-periods .table-line").removeClass("selected");
		e.stopPropagation();
		return false;
	});
});

var i18nErrorSelectArea;
var i18nErrorSelectDomain;
var i18nErrorSelectAreaType;
var i18nErrorSelectUtilityType;
var i18nErrorSelectDeviceType;
var i18nErrorSelectWorkOrderType;
var i18nErrorSelectDeviceModel;
var i18nErrorSelectPlanningPeriod;
var contextPath="";
var pageCode = "Res_Proj";
var domainCodes = "";
var deviceAssertChart;
var devAssetPieChart;
var SELECTED = "selected";
//var allRowIds = "";


function loadDefaultData(){
	//alert("loading");
	defaultDateInterval();
	getDomainList();
	getUtilityTypes();
	getWorkOrderTypes();
	getArea();
	getAreaType();
	getDeviceType();
	getDeviceModels();
}

function defaultDateInterval(){

	populateSavedValue("#block-time-select-date-interval",$.cookie(pageCode+"block-time-select-date-interval"));
	populateSavedValue("#block-time-date-from",$.cookie(pageCode+"block-time-date-from"));
	populateSavedValue("#block-time-date-to",$.cookie(pageCode+"block-time-date-to"));

	onDateIntervalSelect();
}

function onDateIntervalSelect() {
	if ($("#block-time-select-date-interval").val() == "custominterval") {
		showDate();
	} else {
		hideDate();
	}
}

function hideDate(){
	$("#block-time-date-from").hide();
	$("#block-time-date-to").hide();
}

function showDate(){
	$("#block-time-date-from").show();
	$("#block-time-date-to").show();
}

function getDomainList() {
	var obj= {};
	obj.url=contextPath+"/std/GetDomains.action";
	obj.successfunc = fillDomain;
	obj.errorfunc = errorAutoFill;
	run_ajax_json(obj);
	return;
}

function getArea() {

	if(domainCodes == null || domainCodes == ""){
		return false;
	}
	var obj= {};
	obj.url=contextPath+"/std/AnalyzeWorkOrderArea.action";
	obj.pdata = "domainCodes=" + domainCodes;
	obj.successfunc = fillArea;
	obj.errorfunc = errorAutoFill;
	run_ajax_json(obj);
	return;
}

function getUtilityTypes(){

	var obj= {};
	obj.url=contextPath+"/std/AlertManagementUtilityTypes.action";

	obj.successfunc = fillUtilityTypes;
	obj.errorfunc = errorAutoFill;
	run_ajax_json(obj);
	return;

}

function getAreaType(){
	var obj= {};
	obj.url=contextPath+"/std/AlarmManagementAreaTypes.action";

	obj.successfunc = fillAreaType;
	obj.errorfunc = errorAutoFill;
	run_ajax_json(obj);
	return;
}

function getDeviceType(){
	var obj= {};
	obj.url=contextPath+"/std/GetDeviceTypes.action";

	obj.successfunc = fillDeviceType;
	obj.errorfunc = errorAutoFill;
	run_ajax_json(obj);
	return;
}

function getWorkOrderTypes(){
	var obj= {};
	obj.url=contextPath+"/std/getWorkOrderTypes.action";

	obj.successfunc = fillWorkOrderTypes;
	obj.errorfunc = errorAutoFill;
	run_ajax_json(obj);
	return;
}

function getDeviceModels(){

	if(domainCodes == null || domainCodes == ""){
		return false;
	}
	var obj= {};
	obj.url=contextPath+"/std/GetDeviceModels.action";
	obj.pdata = "dc="+domainCodes;
	obj.successfunc = fillDeviceModels;
	obj.errorfunc = errorAutoFill;
	run_ajax_json(obj);
	return;
}

function fillDeviceModels(data){

	var items;
	var savedData = $.cookie(pageCode+"filter-multiselect-device-model");
	var selected = '" > ';

	if(savedData == null || savedData == ''){
		selected = '" selected > ';
	}

	$.each(data, function(i, item) {
		items += '<option value="' + item.id +selected + item.name + '</option>';

	});

	populateSavedMultiSelectBox("#filter-multiselect-device-model", items,savedData);
}

function fillWorkOrderTypes(data){

	var items;
	var savedData = $.cookie(pageCode+"filter-multiselect-work-order-type");
	var selected = '" > ';

	if(savedData == null || savedData == ''){
		selected = '" selected > ';
	}

	$.each(data, function(i, item) {
		items += '<option value="' + item.id +selected + item.name + '</option>';

	});

	populateSavedMultiSelectBox("#filter-multiselect-work-order-type", items,savedData);
}

function fillDeviceType(data){
	var items;
	var savedData = $.cookie(pageCode+"filter-multiselect-device-type");
	var selected = '" > ';

	if(savedData == null || savedData == ''){
		selected = '" selected > ';
	}

	$.each(data, function(i, item) {
		items += '<option value="' + item.id +selected + item.name + '</option>';

	});

	populateSavedMultiSelectBox("#filter-multiselect-device-type", items,savedData);
}

function fillArea(data){
	var items;
	var savedData = $.cookie(pageCode+"filter-multiselect-area");
	var selected = '" > ';

	if(savedData == null || savedData == ''){
		selected = '" selected > ';
	}

	$.each(data, function(i, item) {
		items += '<option value="' + item.id +selected + item.name + '</option>';

	});

	populateSavedMultiSelectBox("#filter-multiselect-area", items,savedData);
}

function fillAreaType(data){
	var items;
	var savedData = $.cookie(pageCode+"filter-multiselect-area-type");
	var selected = '" > ';

	if(savedData == null || savedData == ''){
		selected = '" selected > ';
	}

	$.each(data, function(i, item) {
		items += '<option value="' + item.id +selected + item.name + '</option>';

	});

	populateSavedMultiSelectBox("#filter-multiselect-area-type", items,savedData);
}

function fillUtilityTypes(data){
	var items;
	var savedData = $.cookie(pageCode+"filter-multiselect-utility-type");
	var selected = '" > ';

	if(savedData == null || savedData == ''){
		selected = '" selected > ';
	}

	$.each(data, function(i, item) {
		items += '<option value="' + item.id +selected + item.name + '</option>';
	});

	populateSavedMultiSelectBox("#filter-multiselect-utility-type", items,savedData);
}

function domainChanged(){

	domainCodes = $("#block-time-multiselect-domain").val();
	if(domainCodes != null && domainCodes != ""){
		getArea();
		getDeviceModels();
	}else{
		refreshMultiSelectBox("#filter-multiselect-area");
		refreshMultiSelectBox("#filter-multiselect-device-model");
	}
}

function updatePlanningPeriod(){

	var paramData = "";

	//Remove the old table for Planning periods
	$("#block-planning-periods-table").children().remove();

	if(!validateInputs("#block-time-multiselect-domain",i18nErrorSelectDomain)){
		return false;
	}

	 domainChanged();

	 var dateInterval = $("#block-time-select-date-interval").val();
	 paramData = "domains="+domainCodes+"&dateInterval="+dateInterval;

	 saveResourceProjectionFilter("block-time-multiselect-domain",domainCodes);
	 saveResourceProjectionFilter("block-time-select-date-interval",dateInterval);

	 if(dateInterval == "custominterval"){

		if(!validateInputs("#block-time-date-from",i18nerrorPleaseselectfromdate)){
			return false;
		}

		if(!validateInputs("#block-time-date-to",i18nerrorPleaseselecttodate)){
			return false;
		}

		if(new Date($("#block-time-date-from").val()) > new Date($("#block-time-date-to").val())){
			alert(i18nerrorFromDateOlderThanToDate);
			return false;
		}

		paramData = paramData + "&loadFromDate="+$("#block-time-date-from").val()+
		            "&loadToDate="+$("#block-time-date-to").val();
	}

	 saveResourceProjectionFilter("block-time-date-from",$("#block-time-date-from").val());
	 saveResourceProjectionFilter("block-time-date-to",$("#block-time-date-to").val());
	//paramData = paramData + "&domains="+domainCodes;

	var obj= {};
	obj.url=contextPath+"/std/getResourceProjectionPlanningPeriods.action";
	obj.pdata = paramData;
	obj.successfunc = fillPlanningPeriodsData;
	obj.errorfunc = errorAutoFill;
	run_ajax_json(obj);
	return;
}

function fillPlanningPeriodsData(data){

	if(data !== null){
		var tableHeader = "<thead><tr><th>Name</th><th>Start date</th><th>End date</th><th>Domain</th></tr></thead>";
		$('#block-planning-periods-table').html( tableHeader );
		for(var i=0; i < data.length; i++){
			var planningPeriod = data[i];
			var tableData = '<tr onclick="selectRow('+planningPeriod.planningPeriodId+');" id="'+ planningPeriod.planningPeriodId +
			'">'+
			'<td>'+planningPeriod.planningName+'</td>'+
			'<td>'+planningPeriod.planningStartDate.substring(0,10)+'</td>'+
			'<td>'+planningPeriod.planningEndDate.substring(0,10)+'</td>'+
			'<td>'+planningPeriod.domainName+'</td>';
			$('#block-planning-periods-table').append( tableData );

		}
	}
}

function fillDomain(data){
	//alert("filling domain");
	var items;

	var savedData = $.cookie(pageCode+"block-time-multiselect-domain");
	var selected = '" > ';
	if(savedData == null || savedData == ''){
		selected = '" selected > ';
	}

	$.each(data, function(i, item) {
		items += '<option value="' + item.id +selected + item.name + '</option>';

	});

	populateSavedMultiSelectBox("#block-time-multiselect-domain", items,savedData);
}

//Populate the multi-select box with the given data for the given id
function populateSavedMultiSelectBox(idName, items,savedData){

	$(idName).find('option').remove();
	$(idName).multiselect('refresh');
	var selectData = $(idName).multiselect();
	/*$.each(data, function(i, item) {
		items += '<option value="' + item.id + '">' + item.name + '</option>';
	});	*/
	selectData.append(items);

	//var savedData = $.cookie(pageCode+idName);
	if(savedData!=null && savedData!='') {
		var dataArray = savedData.split(",");
		$(idName).val(dataArray);
	}

	selectData.multiselect('refresh');

}

//Populate the multi-select box with the given data for the given id
function populateMultiSelectBox(idName, items){
	$(idName).html(items);
	$(idName).multiselect("refresh");
}

function errorAutoFill(data) {
	alert("Error : " + data.responseText);
}

var numOfRow = 0;
function selectRow(id){
	var rowId = "#"+id;
	if($(rowId).hasClass(SELECTED) === true){
		$(rowId).removeClass(SELECTED);
		$( "#selected-date ul"  + " " + rowId ).remove();
		numOfRow--;
	}else{
		$(rowId).addClass(SELECTED);
		$(rowId).clone().appendTo('#selected-date ul');
		numOfRow++;
	}
	$('#selected-date span.label').html(numOfRow);
}

function processProjections(){
	//Insert value in the "YOU HAVE FILTERED" columns
	insertInfiltered();

/*
	drawStackedBarChart();
	drawPieChart();

	drawStackedBarChart();
	drawPieChart();
*/
	//Getting the selected Planning Period IDs
	var table = document.getElementById("block-planning-periods-table");

	var rowId = "";
	var selectRowIds = "";
	var selectRowValues = "";

	for(i = 0; i < table.rows.length ; i++ ){
		rowId = table.rows[i].id;
		if($('#'+rowId).hasClass(SELECTED) == true){
			selectRowIds = selectRowIds.length == 0 ? rowId : ( selectRowIds + "," + rowId );
		}
	}

	if(selectRowIds.length == 0){
		alert(i18nErrorSelectPlanningPeriod);
		return;
	}

	if(!validateInputs("#filter-multiselect-utility-type",i18nErrorSelectUtilityType)){
		return ;
	}

	if(!validateInputs("#filter-multiselect-area-type",i18nErrorSelectAreaType)){
		return ;
	}

	if(!validateInputs("#filter-multiselect-work-order-type",i18nErrorSelectWorkOrderType)){
		return ;
	}

	if(!validateInputs("#filter-multiselect-area",i18nErrorSelectArea)){
		return ;
	}

	if(!validateInputs("#filter-multiselect-device-type",i18nErrorSelectDeviceType)){
		return ;
	}

	if(!validateInputs("#filter-multiselect-device-model",i18nErrorSelectDeviceModel)){
		return ;
	}

	var utilityType = $("#filter-multiselect-utility-type").val();
	insertValues(utilityType, 'filter-multiselect-utility-type','selected-utility-type');

	var area = $("#filter-multiselect-area").val();
	insertValues(area, 'filter-multiselect-area','selected-area');

	var areaType = $("#filter-multiselect-area-type").val();
	insertValues(areaType, 'filter-multiselect-area-type','selected-area-type');

	var workOrderType = $("#filter-multiselect-work-order-type").val();
	insertValues(workOrderType, 'filter-multiselect-work-order-type','selected-work-order-type');

	var deviceType = $("#filter-multiselect-device-type").val();
	insertValues(deviceType, 'filter-multiselect-device-type','selected-device-type');

	var deviceModel = $("#filter-multiselect-device-model").val();
	insertValues(deviceModel, 'filter-multiselect-device-model','selected-device-model');

	saveResourceProjectionFilter("filter-multiselect-utility-type", utilityType);
	saveResourceProjectionFilter("filter-multiselect-area", area);
	saveResourceProjectionFilter("filter-multiselect-area-type", areaType);
	saveResourceProjectionFilter("filter-multiselect-work-order-type", workOrderType);
	saveResourceProjectionFilter("filter-multiselect-device-type", deviceType);
	saveResourceProjectionFilter("filter-multiselect-device-model", deviceModel);

	var paramData = "utilityType="+utilityType+"&area="+area+"&areaType="+areaType+"&workOrderType="+workOrderType+
	"&deviceType="+deviceType+"&deviceModel="+deviceModel+"&planningPeriodIds="+selectRowIds;
	//alert("param data for Projections:"+paramData);

	var obj= {};
	obj.url=contextPath+"/std/getResourceProjectionsData.action";
	obj.pdata = paramData;
	obj.successfunc = fillResourceProjectsData;
	obj.errorfunc = errorAutoFill;
	run_ajax_json(obj);
	return;

}

function insertInfiltered(){
	insertValues(domainCodes, 'block-time-multiselect-domain','selected-domain');
	insertPeriod();
}

function insertValues(value, context, divId){
	var values = '';
	for(var i = 0 ; i < value.length ; i++){
		values +='<li>' + $("#"+context+" option[value="+value[i]+"]").text()+ "</li>";
	}
	$('#'+divId+' ul').html(values);
	$('#'+divId+' span.label').html(value.length);
}

function insertPeriod(){
	var periodType ='<li>Type: ' + $('#period-type option:selected').text() + '</li>';
	var from = '<li>From: ' + $('#block-time-date-from').val() + '</li>';
	var to = '<li>To: ' + $('#block-time-date-to').val() + '</li>';
	$('#selected-period-type').html(periodType + from + to);
}

function fillResourceProjectsData(data){

	//alert("filling rp");
	if(data != null){

	//Assets
	var monthlyAssets = data.deviceAssetsPerMonth;
	var totalAssets = data.totalDeviceAssets;

	//Resources
	var monthlyResources = data.resouresPerMonth;
	var totalResoures = data.totalResources;

	//Assets
    //device-assets-projections-per-month
    drawStackedBarChart(monthlyAssets,"block-device-assets-projections-per-month-view","75%","500");
	//device-assets-projections-total
    drawPieChart(totalAssets,"block-device-assets-projections-total-view","75%","500");

    //Resources
    //resource-projections-per-month
    drawStackedBarChart(monthlyResources,"block-resource-projections-per-month-view","75%","500");
    //resource-projections-total
		drawPieChart(totalResoures,"block-resource-projections-total-view","75%","500");

	}
}

//Generic method for Stacked Bar 2D chart
function drawStackedBarChart(data,idName,percentage, hight){
	var randomNum = Math.random();
	//alert(randomNum);
	deviceAssertChart = new FusionCharts(contextPath+"/js/fusionchartsxt/charts/StackedBar2D.swf", idName+randomNum, percentage,hight);
	deviceAssertChart.setDataXML(data);
	deviceAssertChart.render(idName);
}
//Generic method for Pie chart
function drawPieChart(data,idName,percentage, hight){
	var randomNum = Math.random();
	//alert(randomNum);
	devAssetPieChart = new FusionCharts(contextPath+"/js/fusionchartsxt/charts/Pie2D.swf", idName+randomNum, percentage,hight);
	devAssetPieChart.setDataXML(data);
	devAssetPieChart.render(idName);
}

//Common method for validating the inputs
function validateInputs(idName,errorMessage){
	var tempVal = $(idName).val();
	if(tempVal == null || tempVal == ""){
		alert(errorMessage);
		return false;
	}
	return true;
}

function refreshMultiSelectBox(idName){

	$(idName).empty();
	$(idName).multiselect("refresh");
}

function saveResourceProjectionFilter(key,value){
	$.cookie(pageCode+key,value,{ expires: 7 });
}

function populateSavedValue(nameId,value){

	if( value != null && value !=''){
		$(nameId).val(value);
		return true;
	}
	return false;
}