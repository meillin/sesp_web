var i18nMeasurePoint;
var i18nStart;
var i18nEnd;
var i18nDeviceModel;
var i18nSelectDomain;
var i18nSelectAreaType;
var i18nSelectArea;
var i18nSelectEventType;
var i18nSelectUtilityType;
var i18nSelectCommType;
var i18nSelectDeviceModel;
var i18nAll;
var i18nerrorEnterValidPeriod;
var i18nerrorAreaTypeRequired;
var i18nerrorDomainRequired;
var i18nerrorSelectArea;
var i18nerrorSelectEvent;
var i18nerrorSelectEventType;
var i18nerrorChartError;
var pageCode = "6";


function populateFilters(){
	getDomains();
	getAreaTypes();
	getAlarmTypes();
	getAreas(null,null);
	getUtilityTypes();
	getCommTypes();
	getDeviceModels(null);
}

function errorAlarmDetails(data) {
	alert(i18nerrorChartError);
}

function errorAutoFill(data) {
	alert("ERROR : " + data.responseText);
}

//Populate the multi-select box with the given data for the given id
function populateSavedMultiSelectBox(idName, items, savedData){

	$(idName).find('option').remove();
	$(idName).multiselect('refresh');
	var selectData = $(idName).multiselect();
	selectData.append(items);

	//var savedData = $.cookie(pageCode+idName);
	if(savedData!=null && savedData!='') {
		var dataArray = savedData.split(",");
		$(idName).val(dataArray);
	}

	selectData.multiselect('refresh');
}

function getDomains() {
	var obj = {};
	obj.url = contextPath + "/std/AlarmManagementDomains.action";
	obj.successfunc = fillDomains;
	obj.errorfunc = errorAutoFill;
	run_ajax_json(obj);
	return;
}

function fillDomains(data) {
	var items;
	var savedData = $.cookie(pageCode + "al_domain");
	var selected = '">';
	if(savedData === null || savedData === ''){ selected = '"selected > '; }

	$.each(data, function(i, item) {
		items += '<option value="' + item.id +selected + item.name + '</option>';
	});

	populateSavedMultiSelectBox("#domains", items, savedData);
}

function getAreaTypes() {
	var obj = {};
	obj.url = contextPath + "/std/AlarmManagementAreaTypes.action";
	obj.successfunc = fillAreaTypes;
	obj.errorfunc = errorAutoFill;
	run_ajax_json(obj);
	return;
}

function fillAreaTypes(data) {
	var items;
	$.each(data, function(i, item) {
		items += '<option value="' + item.id + '">' + item.name + '</option>';
	});
	var msareatypes = $("#areaTypes").multiselect();
	msareatypes.append(items);
	msareatypes.multiselect('refresh');
}

function getAlarmTypes() {
	var obj = {};
	obj.url = contextPath + "/std/AlarmManagementEventTypes.action";
	obj.successfunc = fillAlarmTypes;
	obj.errorfunc = errorAutoFill;
	run_ajax_json(obj);
	return;

}

function fillAlarmTypes(data) {
	var items;
	//items += '<option value=null>' + i18nSelectEventType + '</option>';
	/*if (data != "") {
		items += '<option value=all>' + i18nAll + '</option>';
	}*/
	$.each(data, function(i, item) {
		items += '<option value="' + item.id + '">' + item.name + '</option>';
	});
	var msalarmtypes = $("#alarmTypes").multiselect();
	msalarmtypes.append(items);
	msalarmtypes.multiselect('refresh');
}

function getUtilityTypes() {
	var obj = {};
	obj.url = contextPath + "/std/AlarmManagementUtilityTypes.action";
	obj.successfunc = fillUtilityTypes;
	obj.errorfunc = errorAutoFill;
	run_ajax_json(obj);
	return;
}

function fillUtilityTypes(data) {
	var items;
	/*if (data != "") {
		items += '<option value=all>' + i18nAll + '</option>';
	}*/
	$.each(data, function(i, item) {
		items += '<option value="' + item.id + '">' + item.name + '</option>';
	});
	var msutilitytypes = $("#utilitytypes").multiselect();
	msutilitytypes.append(items);
	msutilitytypes.multiselect('refresh');
}

function getCommTypes() {

	var obj = {};
	obj.url = contextPath + "/std/AlarmManagementUnitCommTypes.action";
	obj.successfunc = fillCommTypes;
	obj.errorfunc = errorAutoFill;
	run_ajax_json(obj);
	return;
}

function fillCommTypes(data) {
	var items;
	$.each(data, function(i, item) {
		items += '<option value="' + item.id + '">' + item.name + '</option>';
	});
	var mscommtypes = $("#commtypes").multiselect();
	mscommtypes.append(items);
	mscommtypes.multiselect('refresh');
}

function getAreas(domainCode, areaCode) {
	var obj = {};
	obj.url = contextPath + "/std/AlarmManagementAreas.action";
	domainCode= (domainCode==null ? null : domainCode.join(","));
	areaCode = (areaCode==null ? null : areaCode.join(","));
	obj.pdata = "domainCode=" + domainCode + "&areaTypeCode=" + areaCode;
	obj.successfunc = fillAreas;
	obj.errorfunc = errorAutoFill;
	run_ajax_json(obj);
	return;
}

function fillAreas(data) {
	var items;
	$("#areas").find('option').remove();
	$("#areas").multiselect('refresh');
	var msareas = $("#areas").multiselect();
	var msoptions = $("#areas").multiselect('option');
	/*if (data != "") {
		items += '<option value=all>' + i18nAll + '</option>';
	}*/
	$.each(data, function(i, item) {
		items += '<option value="' + item.id + '">' + item.name + '</option>';
	});
	msareas.append(items);
	msareas.multiselect('refresh');
}

function getDeviceModels(domainCode) {
	var obj = {};
	obj.url = contextPath + "/std/AlarmManagementDeviceModels.action";
	domainCode= (domainCode==null ? null : domainCode.join(","));
	obj.pdata = "domainCode=" + domainCode;
	obj.successfunc = fillDeviceModels;
	obj.errorfunc = errorAutoFill;
	run_ajax_json(obj);
	return;
}

function fillDeviceModels(data) {
	var items;
	$("#devicemodels").find('option').remove();
	$("#devicemodels").multiselect('refresh');
	/*if (data != "") {
		items += '<option value=all>' + i18nAll + '</option>';
	}*/
	$.each(data, function(i, item) {
		items += '<option value="' + item.id + '">' + item.name + '</option>';
	});
	var msdevicemodels = $("#devicemodels").multiselect();
	msdevicemodels.append(items);
	msdevicemodels.multiselect('refresh');
}

function onChangeData()	{
	var ls_domain = $("#domains").val();
	var ls_areatype = $("#areaTypes").val();
	getDeviceModels(ls_domain);
	getAreas(ls_domain, ls_areatype);
}


function getdaterange() {

	if ($("#filter-select-date-interval").val()=="custominterval") {
		$("#filter-date-from").show();
		$("#filter-date-to").show();
	} else {
		$("#filter-date-from").hide();
		$("#filter-date-to").hide();
	}
	return true;
}

function validateAlarmFilters(al_fromdate, al_todate,al_areatypes,al_domain, al_areas, al_alarmtypes, al_utilitytypes, al_unitCommTypes, al_devicemodels, al_dateinterval,al_breakup)
{
	if(al_domain == 'null' || al_domain == null )
	{
	alert(i18nerrorDomainRequired);
	return false;
	}

	if ((al_fromdate =='' || al_fromdate == 'null' || al_fromdate == null)  && al_dateinterval=="custominterval") {
   	alert(i18nerrorEnterValidPeriod);
   	return false ;
	}

	if ((al_todate =='' || al_todate == 'null' || al_todate == null ) && al_dateinterval=="custominterval") {
   	alert(i18nerrorEnterValidPeriod);
   	return false;
	}

	if (al_areatypes =='null' || al_areatypes == null) {
	   	alert(i18nerrorAreaTypeRequired);
	   	return false;
	}

	// This is modified to accept all areas
	if(al_breakup =="E" && ( al_areas =='null' || al_areas == null ))
	{
	alert(i18nerrorSelectArea);
	return false;
	}

	if(al_breakup =="E" && ( al_alarmtypes=='null' || al_alarmtypes == null ))
	{
	alert(i18nerrorSelectArea);
	return false;
	}

	if(al_breakup =="A" && ( al_areas=='null' || al_areas == null))
	{
	alert(i18nerrorSelectArea);
	return false;
	}

	if(al_breakup =="A" && (al_alarmtypes=='null' || al_alarmtypes == null))
	{
	alert(i18nerrorSelectEvent);
	return false;
	}

	return true;

}


var chartType;
function drawChart(data) {
}

function onSubmit()
{
	var al_domain = $("#domains").val() === null ? null:$("#domains").val().join(",");
	var al_areatypes = $("#areaTypes").val() === null ? null:$("#areaTypes").val().join(",");
	var al_areas = $("#areas").val() === null ? null:$("#areas").val().join(",");
	var al_alarmtypes = $("#alarmTypes").val() === null ? null: $("#alarmTypes").val().join(",");
	var al_utilitytypes = $("#utilitytypes").val() === null ? null:$("#utilitytypes").val().join(",");
	var al_unitCommTypes = $("#commtypes").val() === null ? null:$("#commtypes").val().join(",");
	var al_devicemodels = $("#devicemodels").val() === null ? null:$("#devicemodels").val().join(",");
	var al_breakup = $('input:radio[name=block-alarm-charts-radio]:checked').val();
	var al_fromdate = $("#filter-date-from").val();
	var al_todate = $("#filter-date-to").val();
	var al_dateinterval = $("#filter-select-date-interval").val();

	saveAlarmManagementFilter('al_domain', al_domain);
	saveAlarmManagementFilter('al_areatypes', al_areatypes);
	saveAlarmManagementFilter('al_areas', al_areas);
	saveAlarmManagementFilter('al_alarmtypes', al_areas);
	saveAlarmManagementFilter('al_utilitytypes', al_utilitytypes);
	saveAlarmManagementFilter('al_unitCommTypes', al_unitCommTypes);
	saveAlarmManagementFilter('al_devicemodels', al_devicemodels);
	saveAlarmManagementFilter('al_fromdate', al_fromdate);
	saveAlarmManagementFilter('al_todate', al_todate);

	chartType=al_breakup;
	var dateInterval = {};
	dateInterval['lastweek'] = 'Last Week';
	dateInterval['today'] = 'Today';
	dateInterval['lastmonth'] = 'Last Month';
	dateInterval['lastquarter'] = 'Last Quarter';
	dateInterval['lastyear'] = 'Last Year';
	dateInterval['custominterval'] =   al_fromdate+ ' - ' +al_todate;

	if(validateAlarmFilters(al_fromdate, al_todate,al_areatypes,al_domain, al_areas, al_alarmtypes, al_utilitytypes, al_unitCommTypes, al_devicemodels, al_dateinterval,al_breakup)){
		loadPoints(al_domain, al_fromdate, al_todate, al_areatypes, al_areas, al_unitCommTypes, al_devicemodels, al_utilitytypes,al_dateinterval, al_alarmtypes);

		$("#block-alarm-charts-period").text(dateInterval[al_dateinterval]);

		var obj= {};
		obj.url=contextPath+"/std/AlarmManagementChart.action";
		obj.pdata = "alarmfromdate="+al_fromdate+"&alarmtodate="+al_todate+"&domains="+al_domain+"&areatypes="+al_areatypes+"+&areas="+al_areas+"&alarmtypes="+al_alarmtypes+"&utilitytypes="+al_utilitytypes+"&commtypes="+al_unitCommTypes+"&devicemodels="+al_devicemodels+"&breakup="+al_breakup+"&dateinterval="+al_dateinterval;// post variable data
		obj.successfunc = drawChart;
		obj.errorfunc = resetMapNChart;
		run_ajax(obj);

		//Draw a dummy data chart to see the result. To be removed
		//drawTestChart();

		//Get all the new areas in the map
		var obj1= {};
		obj1.url=contextPath+"/std/AlarmManagementMapAreas.action";
		obj1.pdata = "domains="+al_domain+"&areatypes="+al_areatypes;
		obj1.successfunc = createAreaJSON;
		obj1.errorfunc = errorAlarmDetails;
		run_ajax(obj1);
		return;
	}
}

function saveAlarmManagementFilter(key,value){
	$.cookie(pageCode+key,value,{ expires: 7 });
}

function drawTestChart(){
	//Work Order Progress
		//Generate Javascript Fusion chart with a dummy data
	var myChart = new FusionCharts("Column2D","testing-chart", "100%", "300", "0" );
			myChart.setJSONUrl(contextPath + "/data/dummydata.json");
			myChart.render("block-alarm-charts-view");
}

function loadPoints(domain, from, to, areaT, area, unitCommT, unitModel, InstMepUtilityT, dateInterval,alarmTypes){
		var obj= {};
		obj.url=contextPath+"/std/AlarmManagementMapPoints.action";
		obj.pdata = "domain="+domain+"&alarmfromdate="+from+"&alarmtodate="+to+"&areatypes="+areaT+"&commtypes="+unitCommT+"&devicemodels="+unitModel+"&utilitytypes="+InstMepUtilityT+"&dateinterval="+dateInterval+"&alarmTypes="+alarmTypes;
		obj.successfunc = loadPointsSuccess;
		obj.errorfunc = errorAlarmDetails;
		run_ajax(obj);
		return;
}


function getChartTitle(title)
{
	if(title=="E") {
	$("#block-alarm-charts-title").text("Alarms per type");
	}else
	{
	$("#block-alarm-charts-title").text("Alarms per area");
	}
}


var data;
function fillEventInfo(msg) {
	if (msg == "") {
		return;
	}
	var o = eval(msg);
	if (o == null)
		return;

	html = "<div style=\"font-size:.8em;background-color:#ffffff;filter:alpha(opacity=80);opacity:.8;border-radius: 5px; \">";
	html += "<div id='bubble-header'></div>";
	html += "<div> <b>Measurepoint Id : </b><a href='"+contextPath+"/std/ViewMeasurepoint?id="+o.id+"' class='text-blue'>"+o.id+"</a></div> ";
	html += "<div> <b>Alarm Type : </b>" + o.eventType + "</div> ";
	html += "<div> <b>From : </b>" + o.startTimestamp + "</div> ";
	html += "<div> <b>To : </b>" + o.endTimestamp + "</div> ";
	html += "</div>";
	data = html;
}

function infoDataCallback(id) {

	var obj = {};
	obj.url = contextPath + "/std/AlarmManagementEventInfo.action";
	obj.pdata = "id=" + id;
	obj.successfunc = fillEventInfo;
	obj.errorfunc = errorAlarmDetails;
	run_ajax_Sync(obj);
	return data;
}

var selectedImagejs=[];
var unselectedImagejs=[];
var unitEventArray =[];
var symbolCounterjs = 0;

var symbolsjs = new Array("blue","green","orange","pink","purple","red","yellow");

//var symbolsjs = new Array("blue","red","green","purple","yellow","pink","ltblue");

// Below methods can be used to display events on page load.
function fillUnitEventsOnLoad(data) {
	var mapDetails = '';
	$.each(data, function(i, item) {
		symbolCounterjs++;
		unitEventArray.push( {
			id : item.id,
			name : item.name
		});

		selectedImagejs.push( {
			id : item.id,
			link : contextPath + "/images/silk/bullet_"
					+ symbolsjs[symbolCounterjs % symbolsjs.length] + ".png"
		});
		unselectedImagejs.push( {
			id : item.id,
			link : contextPath + "/images/silk/flag_"
					+ symbolsjs[symbolCounterjs % symbolsjs.length] + ".png"
		});
	});

	for (i = 0; i < unitEventArray.length; i++) {
		for (k = 0; k < unselectedImagejs.length; k++) {
			if (unitEventArray[i].id == unselectedImagejs[k].id) {
				mapDetails += '<img src="' + unselectedImagejs[k].link + '"/>';
				break;
			}
		}
		for (j = 0; j < selectedImagejs.length; j++) {
			if (unitEventArray[i].id == selectedImagejs[j].id) {
				mapDetails += '<img src="' + selectedImagejs[j].link + '"/>';
				break;
			}
		}
		mapDetails += '<span>' + unitEventArray[i].name + '</span>';
		$("#mapindicationDetails").html(mapDetails);
	}
}

function loadUnitEvents() {
	var obj = {};
	obj.url = contextPath + "/std/AlertManagementEventTypes.action";
	obj.successfunc = fillUnitEventsOnLoad;
	obj.errorfunc = errorAlarmDetails;
	run_ajax_json(obj);
}