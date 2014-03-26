var contextPath;
var i18nerrorInvalidSearchInput;
var i18nerrorNoDataForSearch;
var multipointId;
var caseLength = 0;
var caseOffset = 0;
var deviationLength = 0;
var deviationOffset = 0;
var deviceLength = 0;
var deviceOffset = 0;
var eventLength = 0;
var eventOffset = 0;
var mapServerUrl;

$(function(){	
	$(".accordion ul.subMenu").show();
	renderTable("#overview-table");
	renderTable("#caseresults");
	renderTable("#deviationresults");
	renderTable("#deviceresults");
	renderTable("#eventresults");
	$(".accordion ul.subMenu").hide();

});	


function multipointDetails() {

	$('#multipoint-id').html(multipointId);
	getMupOverview();
	getMupLocation();
	getMupCases();
	getMupDeviations();
	getMupDevices();
	getMupEvents();
}

function getMupOverview() {
	var obj = {};
	obj.url = contextPath + "/std/MultipointOverview.action";
	obj.pdata = "id=" + multipointId;
	obj.successfunc = populateMupOverview;
	obj.errorfunc = errorsearchresults;
	run_ajax_json(obj);
	return;
}

function getMupCases() {
	var obj = {};
	obj.url = contextPath + "/std/MultipointCases.action";
	obj.pdata = "id=" + multipointId;
	obj.successfunc = populateMupCases;
	obj.errorfunc = errorsearchresults;
	run_ajax_json(obj);
	return;
}

function getMupDeviations() {
	var obj = {};
	obj.url = contextPath + "/std/MultipointDeviations.action";
	obj.pdata = "id=" + multipointId;
	obj.successfunc = populateMupDeviations;
	obj.errorfunc = errorsearchresults;
	run_ajax_json(obj);
	return;
}

function getMupDevices() {
	var obj = {};
	obj.url = contextPath + "/std/MultipointDevices.action";
	obj.pdata = "id=" + multipointId;
	obj.successfunc = populateMupDevices;
	obj.errorfunc = errorsearchresults;
	run_ajax_json(obj);
	return;
}

function getMupEvents() {
	var obj = {};
	obj.url = contextPath + "/std/MultipointEvents.action";
	obj.pdata = "id=" + multipointId;
	obj.successfunc = populateMupEvents;
	obj.errorfunc = errorsearchresults;
	run_ajax_json(obj);
	return;
}

function getMupLocation() {
	var obj = {};
	obj.url = contextPath + "/std/MultipointLocation.action";
	obj.pdata = "id=" + multipointId;
	obj.successfunc = populateMupLocation;
	obj.errorfunc = errorsearchresults;
	run_ajax_json(obj);
	return;
}
function validatesearchinput(searchInputTxt) {

	var regexp = /^[0-9]{1,6}$/;
	return regexp.test(searchInputTxt);

}

function populateMupOverview(data) {
	if (data != null || data != "") {
		var mupOverviewVTO = eval(data);

		if (null == mupOverviewVTO.instCode
				|| 'undefined' == typeof (mupOverviewVTO.instCode)) {
			mupOverviewVTO.instCode = "";
		}
		if (null == mupOverviewVTO.instEcode
				|| 'undefined' == typeof (mupOverviewVTO.instEcode)) {
			mupOverviewVTO.instEcode = "";
		}
		if (null == mupOverviewVTO.devicePlacement
				|| 'undefined' == typeof (mupOverviewVTO.devicePlacement)) {
			mupOverviewVTO.devicePlacement = "";
		}
		
		$("#block-overview-installation-id").html("<a href='"+contextPath+"/std/ViewInstallation.action?id="+mupOverviewVTO.instId+"' class='text-blue'> "+mupOverviewVTO.instId+" </a>");
		$("#block-overview-installation-code").text(mupOverviewVTO.instCode);
		$("#block-overview-external-code").text(mupOverviewVTO.instEcode);
		$("#block-overview-domain").text(mupOverviewVTO.domain);
		$("#block-overview-multipoint-code")
				.text(mupOverviewVTO.multipointCode);
		$("#block-overview-device-placement").text(
				mupOverviewVTO.devicePlacement);
		$("#block-overview-status").text(mupOverviewVTO.instMupStatus);
	}
}

function populateMupCases(data) {
	if (data != "" || data != null) {
		var caseList = eval(data);
		if (caseList != null) {
			var currentLength = caseList.length;
			caseLength = caseLength + currentLength;
			
			if(currentLength > 10){
				$('#block-multipoint-information-cases-link-more').show();
				currentLength = 10;
				caseLength = caseLength - 1;
			}
			else{
				$('#block-multipoint-information-cases-link-more').hide();				
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
				if (null == caseDetail.externalId
						|| 'undefined' == typeof (caseDetail.externalId)) {
					caseDetail.externalId = "";
				}
				if (null == caseDetail.userName
						|| 'undefined' == typeof (caseDetail.userName)) {
					caseDetail.userName = "";
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
								+ "'><td><a href='"+contextPath+"/std/ViewCase?id="+caseDetail.caseId+"' class='text-blue'>"
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
			$('#block-multipoint-information-cases-link-more').hide();				
		}
		$('#block-multipoint-information-cases-number').html(
				" (" + caseLength + ")");
	}
}

function populateMupDeviations(data) {
	if (data != "" || data != null) {
		var deviationList = eval(data);
		if (deviationList != null) {			
			var currentLength = deviationList.length;
			deviationLength = deviationLength + currentLength;
			
			if(currentLength > 10){
				$('#block-multipoint-information-deviations-link-more').show();
				currentLength = 10;
				deviationLength = deviationLength - 1;
			}
			else{
				$('#block-multipoint-information-deviations-link-more').hide();				
			}
			
			for ( var i = 0; i < currentLength; i++) {
				var trClass = '';
				var statusClass = '';
				if (i == 0 || i % 2 == 0) {
					trClass = 'table-line line-grey';
				} else {
					trClass = 'table-line';
				}
				var deviationDetail = deviationList[i];
				$("#deviationresults > tbody").append(
						"<tr class='" + trClass
								+ "'> <td>&nbsp;&nbsp;&nbsp;"
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
			$('#block-multipoint-information-deviations-link-more').hide();				
		}
		$('#block-multipoint-information-deviations-number').html(
				" (" + deviationLength + ")");
	}
}

function populateMupDevices(data) {
	if (data != "" || data != null) {
		var deviceList = eval(data);
		if (deviceList != null) {			
			var currentLength = deviceList.length;
			deviceLength = deviceLength + currentLength;
			
			if(currentLength > 10){
				$('#block-multipoint-information-devices-link-more').show();
				currentLength = 10;
				deviceLength = deviceLength - 1;
			}
			else{
				$('#block-multipoint-information-devices-link-more').hide();				
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
				if (null == deviceDetail.giai
						|| 'undefined' == typeof (deviceDetail.giai)) {
					deviceDetail.giai = "";
				}
				if (null == deviceDetail.serialNo
						|| 'undefined' == typeof (deviceDetail.serialNo)) {
					deviceDetail.serialNo = "";
				}
				if (null == deviceDetail.propNo
						|| 'undefined' == typeof (deviceDetail.propNo)) {
					deviceDetail.propNo = "";
				}
				if (null == deviceDetail.type
						|| 'undefined' == typeof (deviceDetail.type)) {
					deviceDetail.type = "";
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
			$('#block-multipoint-information-devices-link-more').hide();				
		}
		$('#block-multipoint-information-devices-number').html(
				" (" + deviceLength + ")");
	}
}

function populateMupEvents(data) {
	if (data != "" || data != null) {
		var eventList = eval(data);
		if (eventList != null) {
			
			var currentLength = eventList.length;
			eventLength = eventLength + currentLength;
			
			if(currentLength > 10){
				$('#block-multipoint-information-events-link-more').show();
				currentLength = 10;
				eventLength = eventLength - 1;
			}
			else{
				$('#block-multipoint-information-events-link-more').hide();				
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
				if (null == eventDetail.phase
						|| 'undefined' == typeof (eventDetail.phase)) {
					eventDetail.phase = "";
				}
				$("#eventresults > tbody").append(
						"<tr class='" + trClass
								+ "'><td>"
								+ eventDetail.type + "</td><td>"
								+ eventDetail.deviceId + "</td><td>"
								+ eventDetail.phase + "</td><td>"
								+ eventDetail.startTimestamp + "</td><td>"
								+ eventDetail.endTimestamp + "</td><td>"
								+ eventDetail.receiveTimestamp + "</td></tr>");
			}
		}
		else{
			$('#block-multipoint-information-events-link-more').hide();				
		}
		$('#block-multipoint-information-events-number').html(
				" (" + eventLength + ")");
	}
}

function populateMupLocation(data) {
	if (data != null || data != "") {
		var mupLocationVTO = eval(data);
		if (null == mupLocationVTO.street
				|| 'undefined' == typeof mupLocationVTO.street) {
			mupLocationVTO.street = "";
		}
		if (null == mupLocationVTO.postcode
				|| 'undefined' == typeof (mupLocationVTO.postcode)) {
			mupLocationVTO.postcode = "";
		}
		if (null == mupLocationVTO.city
				|| 'undefined' == typeof (mupLocationVTO.city)) {
			mupLocationVTO.city = "";
		}
		if (null == mupLocationVTO.xcoordinate
				|| 'undefined' == typeof (mupLocationVTO.xcoordinate)) {
			mupLocationVTO.xcoordinate = "";
		}
		if (null == mupLocationVTO.ycoordinate
				|| 'undefined' == typeof (mupLocationVTO.ycoordinate)) {
			mupLocationVTO.ycoordinate = "";
		}
		$("#block-location-adress").text(
				mupLocationVTO.street + ', ' + mupLocationVTO.postcode + ' '
						+ mupLocationVTO.city);
		$("#block-location-area").text(mupLocationVTO.areaName);
		loadMapPoint(mapServerUrl, "block-location-map-wrapper",
				mupLocationVTO.xcoordinate, mupLocationVTO.ycoordinate); // For Testing [8654746.61603, 1457601.52359][77.34119, 13.23865]
	}
}

function showmorecase() {
	caseOffset = caseOffset + 10;
	var obj = {};
	obj.url = contextPath + "/std/ShowMoreCase.action";
	obj.pdata = "id=" + multipointId + "&offset=" + caseOffset;
	obj.successfunc = populateMupCases;
	obj.errorfunc = errorsearchresults;
	run_ajax_json(obj);
	return;
}

function showmoredeviation() {
	deviationOffset = deviationOffset + 10;
	var obj = {};
	obj.url = contextPath + "/std/ShowMoreDeviation.action";
	obj.pdata = "id=" + multipointId + "&offset=" + deviationOffset;
	obj.successfunc = populateMupDeviations;
	obj.errorfunc = errorsearchresults;
	run_ajax_json(obj);
	return;
}

function showmoredevice() {
	deviceOffset = deviceOffset + 10;
	var obj = {};
	obj.url = contextPath + "/std/ShowMoreDevice.action";
	obj.pdata = "id=" + multipointId + "&offset=" + deviceOffset;
	obj.successfunc = populateMupDevices;
	obj.errorfunc = errorsearchresults;
	run_ajax_json(obj);
	return;
}

function showmoreevent() {
	eventOffset = eventOffset + 10;
	var obj = {};
	obj.url = contextPath + "/std/ShowMoreEvent.action";
	obj.pdata = "id=" + multipointId + "&offset=" + eventOffset;
	obj.successfunc = populateMupEvents;
	obj.errorfunc = errorsearchresults;
	run_ajax_json(obj);
	return;
}


function errorsearchresults(data) {
	// alert(data);
}