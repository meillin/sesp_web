var contextPath;
var i18nerrorInvalidSearchInput;
var i18nerrorNoDataForSearch;
var mepId;
var mapServerUrl;
var meterValueLength = 0;
var meterValueOffset = 0;
var caseLength = 0;
var caseOffset = 0;
var deviationLength = 0;
var deviationOffset = 0;
var deviceLength = 0;
var deviceOffset = 0;
var eventLength = 0;
var eventOffset = 0;
var meterValueGrid;
var meterValueGridData="";


$(function(){	
	$(".accordion ul.subMenu").show();
	renderTable("#overview-table");
	renderTable("#metervaluesresults");
	renderTable("#caseresults");
	renderTable("#deviationresults");
	renderTable("#deviceresults");
	renderTable("#eventresults");
	$(".accordion ul.subMenu").hide();

});	

function measurepointDetails() {	
	$('#measurepoint-id').html(mepId);
	getMepOverview();
	getMepLocation();
	getMepMeterValues();
	getMepCases();
	getMepDeviations();
	getMepDevices();
	getMepEvents();	
	getDCCompareData();
}

function getMepOverview() {	
	var obj = {};
	obj.url = contextPath + "/std/MeasurepointOverview.action";
	obj.pdata = "id=" + mepId;
	obj.successfunc = populateMepOverview;
	obj.errorfunc = errorsearchresults;
	run_ajax_json(obj);
	return;
}

function getMepMeterValues() {	
	var obj = {};
	obj.url = contextPath + "/std/MeasurepointMeterValues.action";
	obj.pdata = "id=" + mepId;
	obj.successfunc = populateMepMeterValues;
	obj.errorfunc = errorsearchresults;
	run_ajax_json(obj);
	return;
}

function getMepCases() {
	var obj = {};
	obj.url = contextPath + "/std/MeasurepointCases.action";
	obj.pdata = "id=" + mepId;
	obj.successfunc = populateMepCases;
	obj.errorfunc = errorsearchresults;
	run_ajax_json(obj);
	return;
}

function getMepDeviations() {
	var obj = {};
	obj.url = contextPath + "/std/MeasurepointDeviations.action";
	obj.pdata = "id=" + mepId;
	obj.successfunc = populateMepDeviations;
	obj.errorfunc = errorsearchresults;
	run_ajax_json(obj);
	return;
}


function getMepDevices() {
	var obj = {};
	obj.url = contextPath + "/std/MeasurepointDevices.action";
	obj.pdata = "id=" + mepId;
	obj.successfunc = populateMepDevices;
	obj.errorfunc = errorsearchresults;
	run_ajax_json(obj);
	return;
}

function getMepEvents() {
	var obj = {};
	obj.url = contextPath + "/std/MeasurepointEvents.action";
	obj.pdata = "id=" + mepId;
	obj.successfunc = populateMepEvents;
	obj.errorfunc = errorsearchresults;
	run_ajax_json(obj);
	return;
}

function getMepLocation() {
	var obj = {};
	obj.url = contextPath + "/std/MeasurepointLocation.action";
	obj.pdata = "id=" + mepId;
	obj.successfunc = populateMepLocation;
	obj.errorfunc = errorsearchresults;
	run_ajax_json(obj);
	return;
}

//for chart
function getDCCompareData() {
	var obj = {};
	obj.url = contextPath + "/std/MeasurepointChart.action";
	obj.pdata = "id=" + mepId;
	obj.successfunc = drawChart;
	obj.errorfunc = errorsearchresults;	;
	run_ajax(obj);
	return;
}
		

var myChart; 
function drawChart(data) {	
	myChart = new FusionCharts(contextPath+"/js/fusionchartsxt/charts/Area2D.swf", "dcchartId", "925", "500");
	myChart.setDataXML(data);
	myChart.setTransparent(true);
	myChart.render("block-consumption-chart-wrapper");
}


function validatesearchinput(searchInputTxt) {

	var regexp = /^[0-9]{1,6}$/;
	return regexp.test(searchInputTxt);

}

function populateMepOverview(data) {
	if (data != null || data != "") {
		var imageUtility='icon commun';
		var mepOverviewVTO = eval(data);
		if (null == mepOverviewVTO.idInst
				|| 'undefined' == typeof (mepOverviewVTO.idInst)) {
			mepOverviewVTO.idInst = "";
		}
		if (null == mepOverviewVTO.instCode
				|| 'undefined' == typeof (mepOverviewVTO.instCode)) {
			mepOverviewVTO.instCode = "";
		}
		if (null == mepOverviewVTO.instEcode
				|| 'undefined' == typeof (mepOverviewVTO.instEcode)) {
			mepOverviewVTO.instEcode = "";			
		}
		if (null == mepOverviewVTO.utility
				|| 'undefined' == typeof (mepOverviewVTO.utility)) {
			mepOverviewVTO.utility = "";			
		}
		else {
			if(mepOverviewVTO.utility == 'Electrical'){
				imageUtility="icon elect";
			}
			if(mepOverviewVTO.utility == 'Gas'){
				imageUtility="icon gas";
			}
			if(mepOverviewVTO.utility == 'Water'){
				imageUtility="icon water";
			}
		}
		if (null == mepOverviewVTO.domain
				|| 'undefined' == typeof (mepOverviewVTO.domain)) {
			mepOverviewVTO.domain = "";
		}
		if (null == mepOverviewVTO.meterPlacement
				|| 'undefined' == typeof (mepOverviewVTO.meterPlacement)) {
			mepOverviewVTO.meterPlacement = "";
		}
		if (null == mepOverviewVTO.multipointCode
				|| 'undefined' == typeof (mepOverviewVTO.multipointCode)) {
			mepOverviewVTO.multipointCode = "";
		}
		if (null == mepOverviewVTO.gsrn
				|| 'undefined' == typeof (mepOverviewVTO.gsrn)) {
			mepOverviewVTO.gsrn = "";
		}
		if (null == mepOverviewVTO.powerStatus
				|| 'undefined' == typeof (mepOverviewVTO.powerStatus)) {
			mepOverviewVTO.powerStatus = "";
		}
		if (null == mepOverviewVTO.instMepStatus
				|| 'undefined' == typeof (mepOverviewVTO.instMepStatus)) {
			mepOverviewVTO.instMepStatus = "";
		}
			
		$("#block-overview-installation-id").html("<a href='"+contextPath+"/std/ViewInstallation.action?id="+mepOverviewVTO.idInst+"' class='text-blue'> "+mepOverviewVTO.idInst+" </a>");
		$("#block-overview-installation-code").text(mepOverviewVTO.instCode);
		$("#block-overview-external-code").text(mepOverviewVTO.instEcode);
		$("#iconUtility").attr("class",imageUtility);
		$("#block-overview-utility").text(mepOverviewVTO.utility);
		$("#block-overview-domain").text(mepOverviewVTO.domain);
		$("#block-overview-meter-placement").text(mepOverviewVTO.meterPlacement);
		$("#block-overview-measurepoint-code").text(mepOverviewVTO.multipointCode);
		$("#block-overview-gsrn").text(mepOverviewVTO.gsrn);
		$("#block-overview-power-status").text(mepOverviewVTO.powerStatus);
		$("#block-overview-status").text(mepOverviewVTO.instMepStatus);
	}
}

function populateMepMeterValues(data) {
	if (data != "" || data != null) {
		var meterValueList = eval(data);		
		if (meterValueList != null) {
			
			var currentLength = meterValueList.length;
			meterValueLength = meterValueLength + currentLength;
			
			if(currentLength > 10){
				$('#block-measurepoint-information-meter-value-link-more').show();
				currentLength = 10;
				meterValueLength = meterValueLength - 1;
			}
			else{
				$('#block-measurepoint-information-meter-value-link-more').hide();				
			}
					
			for ( var i = 0; i < currentLength; i++) {
				var trClass = '';
				
				if (i == 0 || i % 2 == 0) {
					trClass = 'table-line line-grey';
				} else {
					trClass = 'table-line';
				}
				var meterValueDetail = meterValueList[i];
				
				if (null == meterValueDetail.register || 'undefined' == typeof (meterValueDetail.register)) {
					meterValueDetail.register = "";
				}
				if (null == meterValueDetail.tariff || 'undefined' == typeof (meterValueDetail.tariff)) {
					meterValueDetail.tariff = "";
				}
				if (null == meterValueDetail.readdate || 'undefined' == typeof (meterValueDetail.readdate)) {
					meterValueDetail.readdate = "";
				}
				if (null == meterValueDetail.receiveDate || 'undefined' == typeof (meterValueDetail.receiveDate)) {
					meterValueDetail.receiveDate = "";
				}
				if (null == meterValueDetail.totalConsumption || 'undefined' == typeof (meterValueDetail.totalConsumption)) {
					meterValueDetail.totalConsumption = "";
				}
				if (null == meterValueDetail.cumulative || 'undefined' == typeof (meterValueDetail.cumulative)) {
					meterValueDetail.cumulative = "";
				}
				else {
					var cumValue = meterValueDetail.cumulative;	
					meterValueDetail.cumulative = cumValue.substring(cumValue.lastIndexOf(";")+1);
				}				
				if (null == meterValueDetail.mvStatus || 'undefined' == typeof (meterValueDetail.mvStatus)) {
					meterValueDetail.mvStatus = "";
				}
				
				var statusClass = statuscheck(meterValueDetail.mvStatus);
				
				/*if (meterValueDetail.status == "In Progress") {
					statusClass = "info";
				} else if (meterValueDetail.status == "Cancelled") {
					statusClass = "ok";
				} else if (meterValueDetail.status == "Closed") {
					statusClass = "ok";
				} else if (meterValueDetail.status == "Error") {
					statusClass = "error";
				} else if (meterValueDetail.status == "Scheduled") {
					statusClass = "ok";
				}*/
				
				if(meterValueGridData == ""){
					meterValueGridData= "['"+meterValueDetail.register+"','"+meterValueDetail.tariff+"','"+meterValueDetail.readdate+"','"+meterValueDetail.receiveDate+"','"+meterValueDetail.totalConsumption+"','"+meterValueDetail.mvStatus+"']";
				}
				else{					
					meterValueGridData= meterValueGridData + ",['"+meterValueDetail.register+"','"+meterValueDetail.tariff+"','"+meterValueDetail.readdate+"','"+meterValueDetail.receiveDate+"','"+meterValueDetail.totalConsumption+"','"+meterValueDetail.mvStatus+"']";
				}
				$("#metervaluesresults > tbody").append(
						"<tr class='" + trClass
								+ "'><td><a href='#' class='text-blue'> "
								+ meterValueDetail.register + "</td><td>"
								+ meterValueDetail.tariff + "</td><td>"
								+ meterValueDetail.readdate + "</td><td>"
								+ meterValueDetail.receiveDate + "</td><td>"
								+ meterValueDetail.totalConsumption + "</td>"
								//+"<td>"	+ meterValueDetail.cumulative + "</td>
								+"<td class='"+ statusClass + "'>" + meterValueDetail.mvStatus
								+ "</td></tr>");
			}
		}
		else {
			$('#block-measurepoint-information-meter-value-link-more').hide();
		}
		$('#block-measurepoint-information-meter-value-number').html(
				" (" + meterValueLength + ")");
	}	
	if(meterValueLength <= 0){
		$('#meter-value-excel-export').hide();
	}
	else
	{
		$('#meter-value-excel-export').show();
	}
	initMeterValueGrid();	
	setmeterValueGrid(meterValueGridData);
}

function setmeterValueGrid(data){
	var griddata = eval('['+data+']');	
	meterValueGrid.clearAll();	
	meterValueGrid.parse(griddata,"jsarray");
}


function populateMepCases(data) {
	if (data != "" || data != null) {
		var caseList = eval(data);		
		if (caseList != null) {
			
			var currentLength = caseList.length;
			caseLength = caseLength + currentLength;
			
			if(currentLength > 10){
				$('#block-measurepoint-information-cases-link-more').show();
				currentLength = 10;
				caseLength = caseLength - 1;
			}
			else{
				$('#block-measurepoint-information-cases-link-more').hide();
			}
			
			for ( var i = 0; i < currentLength; i++) {
				var trClass = '';
				var statusClass = '';
				if (i == 0 || i % 2 == 0) {
					trClass = 'table-line line-grey';
				} else {
					trClass = 'table-line';
				}
				var caseDetail = caseList[i];
				
				
				if (null == caseDetail.externalId || 'undefined' == typeof (caseDetail.externalId)) {
					caseDetail.externalId = "";
				}
				if (null == caseDetail.userName || 'undefined' == typeof (caseDetail.userName)) {
					caseDetail.userName = "";
				}
				if (null == caseDetail.caseType || 'undefined' == typeof (caseDetail.caseType)) {
					caseDetail.caseType = "";
				}
				if (null == caseDetail.domain || 'undefined' == typeof (caseDetail.domain)) {
					caseDetail.domain = "";
				}
				if (null == caseDetail.status || 'undefined' == typeof (caseDetail.status)) {
					caseDetail.status = "";
				}
				if (null == caseDetail.lastChanged || 'undefined' == typeof (caseDetail.lastChanged)) {
					caseDetail.lastChanged = "";
				}

				if (caseDetail.status == "In Progress") {
					statusClass = "info";
				} else if (caseDetail.status == "Cancelled") {
					statusClass = "ok";
				} else if (caseDetail.status == "Closed") {
					statusClass = "ok";
				} else if (caseDetail.status == "Error") {
					statusClass = "error";
				} else if (caseDetail.status == "Scheduled") {
					statusClass = "ok";
				}

				$("#caseresults > tbody").append(
						"<tr class='" + trClass
								+ "'> <td><a href='"+contextPath+"/std/ViewCase?id="+caseDetail.caseId+"' class='text-blue'>"
								+ caseDetail.caseId + "</a></td><td>"
								+ caseDetail.externalId + "</td><td>"
								+ caseDetail.caseType + "</td><td>"
								+ caseDetail.userName + "</td><td>"
								+ caseDetail.domain + "</td><td>"
								+ caseDetail.lastChanged + "</td><td class='"
								+ statusClass + "'>" + caseDetail.status
								+ "</td></tr>");
			}
		}
		else{
			$('#block-measurepoint-information-cases-link-more').hide();
		}
		$('#block-measurepoint-information-cases-number').html(
				" (" + caseLength + ")");
	}
}

function populateMepDeviations(data) {
	if (data != "" || data != null) {
		var deviationList = eval(data);
		if (deviationList != null) {
			
			var currentLength = deviationList.length;
			deviationLength = deviationLength + currentLength;			
			
			if(currentLength > 10){
				$('#block-measurepoint-information-deviations-link-more').show();
				currentLength = 10;
				deviationLength = deviationLength - 1;
			}
			else{
				$('#block-measurepoint-information-deviations-link-more').hide();
			}
			
			for ( var i = 0; i < currentLength; i++) {
				var trClass = '';				
				if (i == 0 || i % 2 == 0) {
					trClass = 'table-line line-grey';
				} else {
					trClass = 'table-line';
				}
				var deviationDetail = deviationList[i];
				if (null == deviationDetail.devType || 'undefined' == typeof (deviationDetail.devType)) {
					deviationDetail.devType = "";
				}
				if (null == deviationDetail.devSource || 'undefined' == typeof (deviationDetail.devSource)) {
					deviationDetail.devSource = "";
				}
				if (null == deviationDetail.devValid || 'undefined' == typeof (deviationDetail.devValid)) {
					deviationDetail.devValid = "";
				}
				if (null == deviationDetail.devGroup || 'undefined' == typeof (deviationDetail.devGroup)) {
					deviationDetail.devGroup = "";
				}
				if (null == deviationDetail.startTimestamp || 'undefined' == typeof (deviationDetail.startTimestamp)) {
					deviationDetail.startTimestamp = "";
				}
				if (null == deviationDetail.endTimestamp || 'undefined' == typeof (deviationDetail.endTimestamp)) {
					deviationDetail.endTimestamp = "";
				}
				$("#deviationresults > tbody").append(
						"<tr class='" + trClass
								+ "'><td>&nbsp;&nbsp;&nbsp;"
								+ deviationDetail.devId + "</td><td>"
								+ deviationDetail.devType + "</td><td>"
								+ deviationDetail.devSource + "</td><td>"
								+ deviationDetail.devValid + "</td><td>"
								+ deviationDetail.startTimestamp + "</td><td>"
								+ deviationDetail.endTimestamp + "</td><td>"
								+ deviationDetail.devGroup + "</td></tr>");
			}
		}
		else{
			$('#block-measurepoint-information-deviations-link-more').hide();
		}
		$('#block-measurepoint-information-deviations-number').html(
				" (" + deviationLength + ")");

	}
}

function populateMepDevices(data) {
	if (data != "" || data != null) {
		var deviceList = eval(data);		
		if (deviceList != null) {
			
			var currentLength=deviceList.length;
			deviceLength = deviceLength + currentLength;
			
			if(currentLength > 10){
				$('#block-measurepoint-information-devices-link-more').show();
				currentLength = 10;
				deviceLength = deviceLength - 1;
			}
			else{
				$('#block-measurepoint-information-devices-link-more').hide();
			}
			
			for ( var i = 0; i < currentLength; i++) {
				var trClass = '';
				var statusClass = '';
				if (i == 0 || i % 2 == 0) {
					trClass = 'table-line line-grey';
				} else {
					trClass = 'table-line';
				}
				var deviceDetail = deviceList[i];
				if (null == deviceDetail.giai || 'undefined' == typeof (deviceDetail.giai)) {
					deviceDetail.giai = "";
				}
				if (null == deviceDetail.serialNo || 'undefined' == typeof (deviceDetail.serialNo)) {
					deviceDetail.serialNo = "";
				}
				if (null == deviceDetail.propNo || 'undefined' == typeof (deviceDetail.propNo)) {
					deviceDetail.propNo = "";
				}
				if (null == deviceDetail.type || 'undefined' == typeof (deviceDetail.type)) {
					deviceDetail.type = "";
				}
				if (null == deviceDetail.model || 'undefined' == typeof (deviceDetail.model)) {
					deviceDetail.model = "";
				}				
				if (null == deviceDetail.startTimestamp || 'undefined' == typeof (deviceDetail.startTimestamp)) {
					deviceDetail.startTimestamp = "";
				}
				if (null == deviceDetail.endTimestamp || 'undefined' == typeof (deviceDetail.endTimestamp)) {
					deviceDetail.endTimestamp = "";
				}
				if (null == deviceDetail.status || 'undefined' == typeof (deviceDetail.status)) {
					deviceDetail.status = "";
				}
				$("#deviceresults > tbody").append(
						"<tr class='" + trClass
								+ "'><td><a href='"+contextPath+"/std/ViewDevice?id="+deviceDetail.deviceId+"' class='text-blue'>"
								+ deviceDetail.deviceId + "</a></td><td>"
								+ deviceDetail.giai + "</td><td>"
								+ deviceDetail.serialNo + "</td><td>"
								+ deviceDetail.propNo + "</td><td>"
								+ deviceDetail.type + "</td><td>"
								+ deviceDetail.model + "</td><td>"
								+ deviceDetail.startTimestamp + "</td><td>"
								+ deviceDetail.endTimestamp + "</td><td>"
								+ deviceDetail.status + "</td></tr>");
			}
		}
		else{
			$('#block-measurepoint-information-devices-link-more').hide();
		}
		$('#block-measurepoint-information-devices-number').html(" (" + deviceLength + ")");
	}
}

function populateMepEvents(data) {
	if (data != "" || data != null) {
		var eventList = eval(data);
		if (eventList != null) {
			
			var currentLength=eventList.length;
			eventLength = eventLength + currentLength;
			
			if(currentLength > 10){
				$('#block-measurepoint-information-events-link-more').show();
				currentLength = 10;
				eventLength = eventLength - 1;
			}
			else{
				$('#block-measurepoint-information-events-link-more').hide();
			}
						
			for ( var i = 0; i < currentLength; i++) {
				var trClass = '';
				var statusClass = '';
				if (i == 0 || i % 2 == 0) {
					trClass = 'table-line line-grey';
				} else {
					trClass = 'table-line';
				}
				var eventDetail = eventList[i];
				if (null == eventDetail.type || 'undefined' == typeof (eventDetail.type)) {
					eventDetail.type = "";
				}
				if (null == eventDetail.deviceId || 'undefined' == typeof (eventDetail.deviceId)) {
					eventDetail.deviceId = "";
				}
				if (null == eventDetail.phase || 'undefined' == typeof (eventDetail.phase)) {
					eventDetail.phase = "";
				}
				if (null == eventDetail.startTimestamp || 'undefined' == typeof (eventDetail.startTimestamp)) {
					eventDetail.startTimestamp = "";
				}
				if (null == eventDetail.endTimestamp || 'undefined' == typeof (eventDetail.endTimestamp)) {
					eventDetail.endTimestamp = "";
				}
				if (null == eventDetail.receiveTimestamp || 'undefined' == typeof (eventDetail.receiveTimestamp)) {
					eventDetail.receiveTimestamp = "";
				}
				$("#eventresults > tbody").append(
						"<tr class='" + trClass
								+ "'><td>"
								+ eventDetail.type + "</td>" 
								+ "<td><a href='"+contextPath+"/std/ViewDevice?id="+eventDetail.deviceId+"' class='text-blue'>"
								+ eventDetail.deviceId + "</a></td><td>"
								+ eventDetail.phase + "</td><td>"
								+ eventDetail.startTimestamp + "</td><td>"
								+ eventDetail.endTimestamp + "</td><td>"
								+ eventDetail.receiveTimestamp + "</td></tr>");
			}
		}
		else{
			$('#block-measurepoint-information-events-link-more').hide();
		}
		$('#block-measurepoint-information-events-number').html(
				" (" + eventLength + ")");
	}
}

function populateMepLocation(data) {
	
	if (data != null || data != "") {
		var mepLocationVTO = eval(data);
		if (null == mepLocationVTO.street || 'undefined' == typeof mepLocationVTO.street) {
			mepLocationVTO.street = "";
		}
		if (null == mepLocationVTO.postcode || 'undefined' == typeof (mepLocationVTO.postcode)) {
			mepLocationVTO.postcode = "";
		}
		if (null == mepLocationVTO.city || 'undefined' == typeof (mepLocationVTO.city)) {
			mepLocationVTO.city = "";
		}
		if (null == mepLocationVTO.xcoordinate || 'undefined' == typeof (mepLocationVTO.xcoordinate)) {
			mepLocationVTO.xcoordinate = "";
		}
		if (null == mepLocationVTO.ycoordinate || 'undefined' == typeof (mepLocationVTO.ycoordinate)) {
			mepLocationVTO.ycoordinate = "";
		}
		$("#block-location-adress").text(mepLocationVTO.street + ', ' + mepLocationVTO.postcode + ' '+ mepLocationVTO.city);
		$("#block-location-area").text(mepLocationVTO.areaName);
		loadMapPoint(mapServerUrl, "block-location-map-wrapper",	mepLocationVTO.xcoordinate, mepLocationVTO.ycoordinate); // For Testing [8654746.61603, 1457601.52359][77.34119, 13.23865]
	}
}


function showmoremetervalue() {
	meterValueOffset = meterValueOffset + 10;
	var obj = {};
	obj.url = contextPath + "/std/ShowMoreMeterValue.action";
	obj.pdata = "id=" + mepId + "&offset=" + meterValueOffset;
	obj.successfunc = populateMepMeterValues;
	obj.errorfunc = errorsearchresults;
	run_ajax_json(obj);
	return;
}

function showmoremepcase() {
	caseOffset = caseOffset + 10;
	var obj = {};
	obj.url = contextPath + "/std/ShowMoreMepCase.action";
	obj.pdata = "id=" + mepId + "&offset=" + caseOffset;
	obj.successfunc = populateMepCases;
	obj.errorfunc = errorsearchresults;
	run_ajax_json(obj);
	return;
}

function showmoremepdeviation() {
	deviationOffset = deviationOffset + 10;
	var obj = {};
	obj.url = contextPath + "/std/ShowMoreMepDeviation.action";
	obj.pdata = "id=" + mepId + "&offset=" + deviationOffset;
	obj.successfunc = populateMepDeviations;
	obj.errorfunc = errorsearchresults;
	run_ajax_json(obj);
	return;
}

function showmoremepdevice() {
	deviceOffset = deviceOffset + 10;
	var obj = {};
	obj.url = contextPath + "/std/ShowMoreMepDevice.action";
	obj.pdata = "id=" + mepId + "&offset=" + deviceOffset;
	obj.successfunc = populateMepDevices;
	obj.errorfunc = errorsearchresults;
	run_ajax_json(obj);
	return;
}

function showmoreevent() {
	eventOffset = eventOffset + 10;
	var obj = {};
	obj.url = contextPath + "/std/ShowMoreMepEvent.action";
	obj.pdata = "id=" + mepId + "&offset=" + eventOffset;
	obj.successfunc = populateMepEvents;
	obj.errorfunc = errorsearchresults;
	run_ajax_json(obj);
	return;
}

function statuscheck(searchstr) {
	
	var status = "ok";
	if(searchstr != null && searchstr) {
		var str = searchstr.toUpperCase();
		var res = str.match(/VALID/g);	
		if(res == null) {
			var res2 = str.match(/MISSING/g);
			if(res2 != null) {
				status = "error";
			}			
		} else {
			if(res != null && res.length>1) {
				status = "info";
			}
		}
	}
	return status;
}

function errorsearchresults(data) {
	// alert(data);
}