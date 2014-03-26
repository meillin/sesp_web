var contextPath;
var instCasesLength=0;
var instCaseOffset=0;
var instMmLength=0;
var instMmOffset=0;


var resolutionArray = 
	[
	     156543.0339280410,
	     78271.51696402048,
	     39135.75848201023,
	     19567.87924100512,
	     9783.939620502561,
	     4891.969810251280,
	     2445.984905125640,
	     1222.992452562820,
	     611.4962262814100,
	     305.7481131407048,
	     152.8740565703525,
	     76.43702828517624,
	     38.21851414258813,
	     19.10925707129406,
	     9.554628535647032,
	     4.777314267823516,
	     2.388657133911758,
	     1.194328566955879,
	     0.5971642834779395
	];

function initInstallation()
{
	loadOverview();
	loadLocation();
	loadCases();
	loadMultiMeasurePoints();
}

function loadOverview()
{
	var obj= {};
	obj.url=contextPath+"/std/ViewInstallationOverview.action";
	obj.pdata = "id="+id;
	obj.successfunc = populateoverview;
	obj.errorfunc = errorsearchresults;
	run_ajax_json(obj);
	return;
}

function populateoverview(data)
{
	if(data!=""||data!=null) {
		var overviewDetails = eval(data);				
		$("#installation-id").text(overviewDetails.id);			
		$("#block-overview-installation-code").text(overviewDetails.code);
		$("#block-overview-external-code").text(overviewDetails.ecode);
		$("#block-overview-type").text(overviewDetails.type);
		$("#block-overview-domain").text(overviewDetails.domain);
		$("#block-overview-key-number").text(overviewDetails.keyNumber);
		$("#block-overview-key-info").text(overviewDetails.keyInfo);
		$("#block-overview-accessible-tech").text(overviewDetails.accessToTechnician);
		$("#block-overview-status").text(overviewDetails.status);
	}
}

function loadLocation()
{
	var obj= {};
	obj.url=contextPath+"/std/ViewInstallationLocation.action";
	obj.pdata = "id="+id;
	obj.successfunc = populatelocation;
	obj.errorfunc = errorsearchresults;
	run_ajax_json(obj);
	return;
}

function populatelocation(data)
{
	if(data!=""||data!=null) {
	var locationDetails = eval(data);	
	$("#block-location-address").text(locationDetails.street + ',' + locationDetails.postcode + ' ' + locationDetails.city);
	$("#block-location-area").text(locationDetails.areaName);	
	//loadMap(mapServerUrl, 'osmap', locationDetails.xcoordinate, locationDetails.ycoordinate); // For Testing  [8654746.61603, 1457601.52359] [77.34119, 13.23865] [8652754.47598,1458485.32673]
	loadMapPoint(mapServerUrl, 'osmap', locationDetails.xcoordinate, locationDetails.ycoordinate);
	}
}

function loadCases()
{
	var obj= {};
	obj.url=contextPath+"/std/ViewInstallationCases.action";
	obj.pdata = "id="+id;
	obj.successfunc = populatecases;
	obj.errorfunc = errorsearchresults;
	run_ajax_json(obj);
	return;
}

function showMoreInstCases()
{
	instCaseOffset = instCaseOffset + 10;
	var obj= {};
	obj.url=contextPath+"/std/ShowMoreInstallationCases.action";
	obj.pdata = "id="+id+"&offset="+instCaseOffset;
	obj.successfunc = populatecases;
	obj.errorfunc = errorsearchresults;
	run_ajax_json(obj);
	return;
}

function populatecases(data)
{
	if(data!=""||data!=null) {		
		var instCaseList = eval(data);	
		if (instCaseList != null) {
		var currentLength = instCaseList.length;
        instCasesLength = instCasesLength + currentLength;
		if(instCasesLength!=0) {
			if(instCasesLength%10>0) {
				$('#block-cases-link-more').hide();
			} else {
				$('#block-cases-link-more').show();
			}
		} else {
			$('#block-cases-link-more').hide();
		}
		for(var i=0; i<instCaseList.length; i++) {
			var trClass = '';
			var statusClass='';
			if(i==0||i%2==0) {
				trClass = 'table-line line-grey';
			} else {
				trClass = 'table-line';
			}
			 var instCaseDetail = instCaseList[i];
			 if(instCaseDetail.status=="In Progress") {
				 statusClass="info";
			 } else if(instCaseDetail.status=="Error") {
				 statusClass="error";
			 } else {
				 statusClass="ok";
			 }
			 var instCaseDetail_user = (typeof instCaseDetail.user=='undefined' ? '': instCaseDetail.user);
			 var instCaseDetail_externalID = (typeof instCaseDetail.externalId=='undefined' ? '': instCaseDetail.externalId);
			 var instCaseDetail_lastChanged = (typeof instCaseDetail.lastChanged=='undefined' ? '': instCaseDetail.lastChanged); 
			
			 $("#block-cases-table > tbody").append("<tr class='"+trClass+"'>" +
			 		"<td> &nbsp;&nbsp;&nbsp; <a href='"+contextPath+"/std/ViewCase?id="+instCaseDetail.caseId+"' class='text-blue'>"+instCaseDetail.caseId+"</td>" +
			 		"<td>"+instCaseDetail_externalID+"</td>" +
			 		"<td>"+instCaseDetail.caseType+"</td>" +
			 		"<td>"+instCaseDetail_user+"</td>" +
			 		"<td>"+instCaseDetail.domain+"</td>" +
			 		"<td>"+instCaseDetail_lastChanged+"</td>" +
			 		"<td class='"+statusClass+"'>"+instCaseDetail.status+"</td>" +
			 		"</tr>");			 
		}
		$('#block-cases-number-value').html("("+instCasesLength+")");
	  }		
	}
}

function loadMultiMeasurePoints()
{
	var obj= {};
	obj.url=contextPath+"/std/ViewInstallationMultiMeasurePoints.action";
	obj.pdata = "id="+id;
	obj.successfunc = populatemultimeasurepoints;
	obj.errorfunc = errorsearchresults;
	run_ajax_json(obj);
	return;
}

function showMoreInstMultiMeasurePoints()
{
	instMmOffset = instMmOffset+10;
	var obj= {};
	obj.url=contextPath+"/std/ShowMoreInstallationMultiMeasurePoints.action";
	obj.pdata = "id="+id+"&offset="+instMmOffset;
	obj.successfunc = populatemultimeasurepoints;
	obj.errorfunc = errorsearchresults;
	run_ajax_json(obj);
	return;
}


function populatemultimeasurepoints(data)
{
	if(data!=""||data!=null) {
		
		var instMmList = eval(data);	
		if (instMmList != null) {
		var currentLength = instMmList.length;
		instMmLength = instMmLength + currentLength;
		if(instMmLength!=0) {
			if(instMmLength%10>0) {
				$('#block-multipoint-measurepoints-link-more').hide();
			} else {
				$('#block-multipoint-measurepoints-link-more').show();
			}
		} else {
			$('#block-multipoint-measurepoints-link-more').hide();
		}
		
		for(var i=0; i<instMmList.length; i++) {
			
			var trClass = '';
			var statusClass='';
			var iconType='';
			var aLink='';
			
			if(i==0||i%2==0) {
				trClass = 'table-line line-grey';
			} else {
				trClass = 'table-line';
			}
			 var instMmDetail = instMmList[i];
			 if(instMmDetail.status=="Active") {
				 statusClass="ok";
			 } else {
				 statusClass="ok"; // Check the status for Closed 
			 }			 
			 if(instMmDetail.utility=="Electrical") {
				 iconType = 'icon elect';
			 } else 	if(instMmDetail.utility=="Gas") {
				 iconType = 'icon gas';
			 } else if(instMmDetail.utility=="Water") {
				 iconType = 'icon water';
			 } else {
				 iconType = 'icon commun';
			 }
			 
			 // START : Fix for JIRA SESPSTD-2492
			 if(instMmDetail.type != null || typeof (instMmDetail.type) != 'undefined') {
				 var instType = instMmDetail.type.toUpperCase();
				 if(instType == "MEASUREPOINT") {
					 aLink = contextPath+"/std/ViewMeasurepoint?id="+instMmDetail.mupmepId;
				 } else if(instType == "MULTIPOINT") {
					 aLink = contextPath+"/std/ViewMultipoint?id="+instMmDetail.mupmepId;
				 } else {
					 aLink = "#";
				 }
			 } else {
				 instMmDetail.type = "" ;
			 }

			 $("#block-multipoint-measurepoints-table > tbody").append(
					"<tr class='"+trClass+"'>" +
			 		"<td> <span class='"+iconType+"'></span></td>" +
			 		"<td> <a href='"+aLink+"' class='text-blue'>"+instMmDetail.mupmepId+"</td>" +
			 		"<td>"+instMmDetail.code+"</td>" +
			 		"<td>"+instMmDetail.type+"</td>" +
			 		"<td>"+instMmDetail.utility+"</td>" +
			 		"<td class='"+statusClass+"'>"+instMmDetail.status+"</td>" +
			 		"</tr>");
		}
		
	}
		$('#block-multipoint-measurepoints-number-value').html("("+instMmLength+")");
	}
}


function errorsearchresults(data) {
	//alert(data);
}

