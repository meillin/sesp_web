var contextPath;

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

function errorAlarmDetails(data) {
	alert(i18nerrorChartError);
}

function fillDomains(data) {
	var items;
	items += '<option value=null>' + i18nSelectDomain + '</option>';
	$.each(data, function(i, item) {
		items += '<option value="' + item.id + '">' + item.name + '</option>';
	});
	$("#domains").html(items);
}

function errorAutoFill(data) {
	alert("ERROR : " + data.responseText);
}

function fillAreaTypes(data) {
	var items;
	items += '<option value=null>' + i18nSelectAreaType + '</option>';
	$.each(data, function(i, item) {
		items += '<option value="' + item.id + '">' + item.name + '</option>';
	});
	$("#areatypes").html(items);
}

function fillEventTypes(data) {
	var items;
	items += '<option value=null>' + i18nSelectEventType + '</option>';
	if (data != "") {
		items += '<option value=all>' + i18nAll + '</option>';
	}
	$.each(data, function(i, item) {
		items += '<option value="' + item.id + '">' + item.name + '</option>';
	});
	$("#eventtypes").html(items);
}

function fillUtilityTypes(data) {
	var items;
	items += '<option value=null>' + i18nSelectUtilityType + '</option>';
	if (data != "") {
		items += '<option value=all>' + i18nAll + '</option>';
	}
	$.each(data, function(i, item) {
		items += '<option value="' + item.id + '">' + item.name + '</option>';
	});
	$("#utilitytypes").html(items);
}

function fillUnitCommTypes(data) {
	var items;
	items += '<option value=null>' + i18nSelectCommType + '</option>';
	if (data != "") {
		items += '<option value=all>' + i18nAll + '</option>';
	}
	$.each(data, function(i, item) {
		items += '<option value="' + item.id + '">' + item.name + '</option>';
	});
	$("#unitCommTypes").html(items);
}

function fillAreas(data) {
	var items;
	items += '<option value=null>' + i18nSelectArea + '</option>';
	if (data != "") {
		items += '<option value=all>' + i18nAll + '</option>';
	}
	$.each(data, function(i, item) {
		items += '<option value="' + item.id + '">' + item.name + '</option>';
	});
	$("#areas").html(items);
}

function fillDeviceModels(data) {
	var items;
	items += '<option value=null>' + i18nSelectDeviceModel + '</option>';
	if (data != "") {
		items += '<option value=all>' + i18nAll + '</option>';
	}
	$.each(data, function(i, item) {
		items += '<option value="' + item.id + '">' + item.name + '</option>';
	});
	$("#DeviceModels").html(items);
}

function getDomains() {
	var obj = {};
	obj.url = contextPath + "/std/AlertManagementDomains.action";
	obj.successfunc = fillDomains;
	obj.errorfunc = errorAutoFill;
	run_ajax_json(obj);
	return;
}

function getAreaTypes() {
	var obj = {};
	obj.url = contextPath + "/std/AlertManagementAreaTypes.action";
	obj.successfunc = fillAreaTypes;
	obj.errorfunc = errorAutoFill;
	run_ajax_json(obj);
	return;
}

function getEventTypes() {
	var obj = {};
	obj.url = contextPath + "/std/AlertManagementEventTypes.action";
	obj.successfunc = fillEventTypes;
	obj.errorfunc = errorAutoFill;
	run_ajax_json(obj);
	return;

}

function getUtilityTypes() {
	var obj = {};
	obj.url = contextPath + "/std/AlertManagementUtilityTypes.action";
	obj.successfunc = fillUtilityTypes;
	obj.errorfunc = errorAutoFill;
	run_ajax_json(obj);
	return;
}

function getUnitCommTypes() {

	var obj = {};
	obj.url = contextPath + "/std/AlertManagementUnitCommTypes.action";
	obj.successfunc = fillUnitCommTypes;
	obj.errorfunc = errorAutoFill;
	run_ajax_json(obj);
	return;

}

function getAreas(domainCode, areaCode) {
	var obj = {};
	obj.url = contextPath + "/std/AlertManagementAreas.action";
	obj.pdata = "domainCode=" + domainCode + "&areaTypeCode=" + areaCode;
	obj.successfunc = fillAreas;
	obj.errorfunc = errorAutoFill;
	run_ajax_json(obj);
	return;
}

function getDeviceModels(domainCode) {
	var obj = {};
	obj.url = contextPath + "/std/AlertManagementDeviceModels.action";
	obj.pdata = "domainCode=" + domainCode;
	obj.successfunc = fillDeviceModels;
	obj.errorfunc = errorAutoFill;
	run_ajax_json(obj);
	return;
}

var chartType;
function drawChart(data) {
	
	var ls_domain = $("#domains").val();
   	var ls_areatypes = $("#areatypes").val();   			
   	var ls_areas = $("#areas").val();   				   		
   	var ls_eventtypes = $("#eventtypes").val();   			
   	var ls_utilitytypes = $("#utilitytypes").val();   			
   	var ls_unitCommTypes = $("#unitCommTypes").val();   			
   	var ls_devicemodels = $("#DeviceModels").val();   			
   	var ls_breakup = $('input:radio[name=breakup]:checked').val();   			
   	var ls_fromdate = $("#loadFromDate").val();   			
   	var ls_todate = $("#loadToDate").val();
   	
	var alertChart;
	if (data != "" || data != null) {
		if (chartType == 'A') {
			alertChart = new FusionCharts(contextPath
					+ "/js/fusioncharts/charts/FCF_StackedColumn3D.swf",
					"amchartId", "400", "506");
		} else if (chartType == 'E') {
			alertChart = new FusionCharts(contextPath
					+ "/js/fusioncharts/charts/FCF_Column3D.swf", "amchartId",
					"400", "506");
		} else {
			alertChart = new FusionCharts(contextPath
					+ "/js/fusioncharts/charts/FCF_Line.swf", "amchartId",
					"400", "506");
		}
		alertChart.setDataXML(data);
		alertChart.render("alertchartdiv");
	}
	loadPoints(ls_domain, ls_fromdate, ls_todate, ls_areatypes, ls_areas, ls_unitCommTypes, ls_devicemodels, ls_utilitytypes);
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
	html += "<div> measurepoint:" + o.measurePointCode + "</div> ";
	html += "<div> start:" + o.startTimestamp + "</div> ";
	html += "<div> end:" + o.endTimestamp + "</div> ";
	html += "<div> type:" + o.eventType + "</div> ";
	html += "<div> device model:" + o.modelName + "</div> ";
	html += "</div>";
	data = html;
}

function infoDataCallback(id) {

	var obj = {};
	obj.url = contextPath + "/std/AlertManagementEventInfo.action";
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