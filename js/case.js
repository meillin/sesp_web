var contextPath;
var caseId;
var searchId;

var i18nerrorInvalidCaseInput;
var i18nerrorInvalidCaseAction;
var i18nerrorNoCaseData;
var i18nerrorNoCaseMapData;

var displayDataLimit = 10;

var instSearchLength = 0;
var caseSlaLength = 0;
var caseInformationLength = 0;
var caseMessageLength = 0;
var caseWoEventsLength = 0;
var caseStatusHistLength = 0;
var caseActionHistLength = 0;
var caseCustContactHistLength = 0;

var instSearchOffset = 0;
var caseSlaOffset = 0;
var caseInformationOffset = 0;
var caseMessageOffset = 0;
var caseWoEventsOffset = 0;
var caseStatusHistOffset = 0;
var caseActionHistOffset = 0;
var caseCustContactHistOffset = 0;

var mapServerUrl;
var woEventsExportHeader;
var woEventsExportGrid;
var woEventsExportData;

//////////////////////////////
///  Init
//////////////////////////////


jQuery(document).ready(function($){
    
	initCase();
	$(".accordion ul.subMenu").show();
});

$(function(){
	renderTable("#overview-table");
	renderTable("#caseWoEvents");
	renderTable("#caseInstallation");
	renderTable("#caseSla");
	renderTable("#caseInformation");
	renderTable("#caseMessages");
	renderTable("#caseStatusHistory");
	renderTable("#caseActionHistory");
	renderTable("#caseCustContactHistory");
	$(".accordion ul.subMenu").hide();
});	

function initCase()
{
	loadCaseOverview();	
	loadCaseInstallation();
	loadCaseSla();
	loadCaseInformation();
	loadCaseMessage();
	loadCaseWoEvents();
	loadCaseStatusHistory();
	loadCaseActionHistory();
	loadCaseCustContactHistory();
	loadLocation();

}


//////////////////////////////
///  Case Location
//////////////////////////////


function loadLocation()
{
	var obj= {};
	obj.url=contextPath+"/std/CaseLocation.action";
	obj.pdata = "id="+caseId;
	obj.successfunc = populateLocation;
	obj.errorfunc = errorCaseMapLocation;
	run_ajax_json(obj);
	return;
}


function populateLocation(data)
{
	if(data!=" "||data!=null) {
		var locationDetails = eval(data);	
		$("#block-location-adress").text(locationDetails.street + ',' + locationDetails.postcode + ' ' + locationDetails.city);
		$("#block-location-area").text(locationDetails.areaName);	
		loadMapPoint(mapServerUrl, "block-case-location-map-wrapper", locationDetails.xcoordinate, locationDetails.ycoordinate); 
	} 
}

//////////////////////////////
///  Case Overview
//////////////////////////////

function loadCaseOverview()
{
	var obj= {};
	obj.url=contextPath+"/std/CaseOverview.action";
	obj.pdata = "id="+caseId;
	obj.successfunc = populateCaseOverview;
	obj.errorfunc = errorCaseSearchResults;
	run_ajax_json(obj);
	return;
}

function populateCaseOverview(data)
{
	$("#case-id").text(caseId);
	
	if(data!=""||data!=null) {	
		var overviewDetails = eval(data);	
		$("#block-overview-case-type").text(overviewDetails.caseType);			
		$("#block-overview-user").text(overviewDetails.userName);
		$("#block-overview-external-id").text(overviewDetails.externalId);
		$("#block-overview-original-id").text(overviewDetails.originalId);
		$("#block-overview-domain").text(overviewDetails.domain);
		$("#block-overview-creat-timestamp").text(overviewDetails.createTimestamp);
		$("#block-overview-last-changed").text(overviewDetails.lastChanged);
		$("#block-overview-field-company").text(overviewDetails.fieldCompany);
		$("#block-overview-reason").text(overviewDetails.reason);
		$("#block-overview-case-result").text(overviewDetails.caseResult);	
		
		 var colorClass = getStatusColor(overviewDetails.status);	
		$("#block-overview-status").html("<div class='status "+colorClass+"'>"+overviewDetails.status+"</div>");
	}
}


//////////////////////////////
///  Case Installation
//////////////////////////////

function loadCaseInstallation()
{
	var obj= {};
	obj.url=contextPath+"/std/CaseInstallation.action";
	obj.pdata = "id="+caseId;
	obj.successfunc = populateCaseInstallation;
	obj.errorfunc = errorCaseSearchResults;
	run_ajax_json(obj);
	return;
}

function populateCaseInstallation(instData) {
	
	if(instData != null) {
		
		var currentInstLength = instData.length;
		instSearchLength = instSearchLength + currentInstLength;
		
		if(currentInstLength > 0) {
			
			if(currentInstLength > displayDataLimit) {
			   $('#block-case-installation-link-more').show();
			   currentInstLength = displayDataLimit;
			   instSearchLength = instSearchLength - 1;	 
			} else {		
			   $('#block-case-installation-link-more').hide();
			}
			
			for(var i=0; i<currentInstLength; i++) {		
				
				var trClass = '';
				var statusClass='';
				if(i==0||i%2==0) {
					trClass = 'table-line line-grey';
				} else {
					trClass = 'table-line';
				}
				 
				var instDetail = instData[i];
				if(instDetail.status=="Active") {
					statusClass="ok";
				} else {
					statusClass="error";
				}
			 
				if(instDetail.id == null || typeof (instDetail.id) == 'undefined') {
					instDetail.id = "" ;
				} 
				if(instDetail.instCode == null || typeof (instDetail.instCode) == 'undefined') {
					instDetail.instCode = "" ;
				} 
				if(instDetail.instEcode == null || typeof (instDetail.instEcode) == 'undefined') {
					instDetail.instEcode = "" ;
				} 
				if(instDetail.lastChanged == null || typeof (instDetail.lastChanged) == 'undefined') {
					instDetail.lastChanged = "" ;
				} 
				if(instDetail.regionArea == null || typeof (instDetail.regionArea) == 'undefined') {
					instDetail.regionArea = "" ;
				} 
				if(instDetail.milestoneArea == null || typeof (instDetail.milestoneArea) == 'undefined') {
					instDetail.milestoneArea = "" ;
				} 
				if(instDetail.netArea == null || typeof (instDetail.netArea) == 'undefined') {
					instDetail.netArea = "" ;
				} 
				if(instDetail.status == null || typeof (instDetail.status) == 'undefined') {
					instDetail.status = "" ;
				} 
				
				$("#caseInstallation > tbody").append(
					"<tr class='" + trClass+ "'> " +
						"<td>  &nbsp;&nbsp;&nbsp; <a href='"+contextPath+"/std/ViewInstallation?id="+instDetail.id+"' class='text-blue'>" + instDetail.id + "</a></td>" +
						"<td>" + instDetail.instCode + "</td>" +
						"<td>" + instDetail.instEcode + "</td>" +
						"<td>" + instDetail.lastChanged + "</td>" +
						"<td>" + instDetail.regionArea + "</td>" +
						"<td>" + instDetail.milestoneArea + "</td>" +
						"<td>" + instDetail.netArea + "</td>" +
						"<td class='"+statusClass+"'>" + instDetail.status + "</td>" +
					"</tr>");	
				
			}
				
		} else {
			$('#block-case-installation-link-more').hide();
		}
		
		$('#block-installations-number').html("("+instSearchLength+")");	
	}
}

//////////////////////////////
///  Case Sla
//////////////////////////////

function loadCaseSla()
{
	var obj= {};
	obj.url=contextPath+"/std/CaseSla.action";
	obj.pdata = "id="+caseId;
	obj.successfunc = populateCaseSla;
	obj.errorfunc = errorCaseSearchResults;
	run_ajax_json(obj);
	return;
}

function populateCaseSla(slaData) {
	
	if(slaData!=null) {	
		
		var currentSlaLength = slaData.length;
		caseSlaLength = caseSlaLength + currentSlaLength;
			
		if(currentSlaLength > 0) {
			
			if(currentSlaLength > displayDataLimit) {
				$('#block-case-sla-link-more').show();
				currentSlaLength = displayDataLimit;
				caseSlaLength = caseSlaLength - 1;	 
			} else {		
				$('#block-case-sla-link-more').hide(); 
			}
		
			for(var i=0; i<currentSlaLength; i++) {		
				
				var trClass = '';
				if(i==0||i%2==0) {
					trClass = 'table-line line-grey';
				} else {
					trClass = 'table-line';
				}		
				
				var slaDetail = slaData[i];
				
				if(slaDetail.slaName == null || typeof (slaDetail.slaName) == 'undefined') {
					slaDetail.slaName = "" ;
				} 
				if(slaDetail.orderingCompany == null || typeof (slaDetail.orderingCompany) == 'undefined') {
					slaDetail.orderingCompany = "" ;
				} 
				if(slaDetail.executingCompany == null || typeof (slaDetail.executingCompany) == 'undefined') {
					slaDetail.executingCompany = "" ;
				} 
				if(slaDetail.slaStart == null || typeof (slaDetail.slaStart) == 'undefined') {
					slaDetail.slaStart = "" ;
				} 
				if(slaDetail.slaEnd == null || typeof (slaDetail.slaEnd) == 'undefined') {
					slaDetail.slaEnd = "" ;
				} 
				if(slaDetail.slaDeadline == null || typeof (slaDetail.slaDeadline) == 'undefined') {
					slaDetail.slaDeadline = "" ;
				} 
				if(slaDetail.slaStartEarliest == null || typeof (slaDetail.slaStartEarliest) == 'undefined') {
					slaDetail.slaStartEarliest = "" ;
				} 
				if(slaDetail.slaStartLatest == null || typeof (slaDetail.slaStartLatest) == 'undefined') {
					slaDetail.slaStartLatest = "" ;
				} 
				
				$("#caseSla > tbody").append(
					"<tr class='" + trClass+ "'> " +
						"<td> &nbsp;&nbsp;&nbsp; " + slaDetail.slaName + "</td>" +
						"<td>" + slaDetail.orderingCompany + "</td>" +
						"<td>" + slaDetail.executingCompany + "</td>" +
						"<td>" + slaDetail.slaStart + "</td>" +
						"<td>" + slaDetail.slaEnd + "</td>" +
						"<td>" + slaDetail.slaDeadline + "</td>" +
						"<td>" + slaDetail.slaStartEarliest + "</td>" +
						"<td>" + slaDetail.slaStartLatest + "</td>" +
					"</tr>");	
			}
			
		} else {
			$('#block-case-sla-link-more').hide();
		}
		
		$('#block-sla-number').html("("+caseSlaLength+")");	
	}
}

//////////////////////////////
///  Case Information
//////////////////////////////

function loadCaseInformation()
{
	var obj= {};
	obj.url=contextPath+"/std/CaseInformation.action";
	obj.pdata = "id="+caseId;
	obj.successfunc = populateCaseInformation;
	obj.errorfunc = errorCaseSearchResults;
	run_ajax_json(obj);
	return;
}

function populateCaseInformation(infoData) {
	
	if(infoData!=null) {

		var currentInfoLength = infoData.length;
		caseInformationLength = caseInformationLength + currentInfoLength;
		
		if(currentInfoLength > 0) {
			
			if(currentInfoLength > displayDataLimit) {
				$('#block-case-information-link-more').show();
				currentInfoLength = displayDataLimit;
				caseInformationLength = caseInformationLength - 1;	 
			} else {		
				$('#block-case-information-link-more').hide();
			}
			
			for(var i=0; i<currentInfoLength; i++) {		
				
				var trClass = '';
				if(i==0||i%2==0) {
					trClass = 'table-line line-grey';
				} else {
					trClass = 'table-line';
				}
				 
				var infoDetail = infoData[i];
				 
				if(infoDetail.infoType == null || typeof (infoDetail.infoType) == 'undefined') {
					infoDetail.infoType = "" ;
				} 
				if(infoDetail.text == null || typeof (infoDetail.text) == 'undefined') {
					infoDetail.text = "" ;
				} 
				if(infoDetail.timestamp == null || typeof (infoDetail.timestamp) == 'undefined') {
					infoDetail.timestamp = "" ;
				} 
				if(infoDetail.userSignature == null || typeof (infoDetail.userSignature) == 'undefined') {
					infoDetail.userSignature = "" ;
				} 		
				if(infoDetail.source == null || typeof (infoDetail.source) == 'undefined') {
					infoDetail.source = "" ;
				} 
				
				$("#caseInformation > tbody").append(
					"<tr class='" + trClass+ "'> " +
						"<td> &nbsp;&nbsp;&nbsp; " + infoDetail.infoType + "</td>" +
						"<td>" + infoDetail.text + "</td>" +
						"<td>" + infoDetail.timestamp + "</td>" +
						"<td>" + infoDetail.userSignature + "</td>" +
						"<td>" + infoDetail.source + "</td>" +
					"</tr>");					 
			}
			
		}  else {
			$('#block-case-information-link-more').hide();
		}
		
		$('#block-information-number').html("("+caseInformationLength+")");	
	}
}

//////////////////////////////
///  Case Message
//////////////////////////////

function loadCaseMessage()
{
	var obj= {};
	obj.url=contextPath+"/std/CaseMessages.action";
	obj.pdata = "id="+caseId;
	obj.successfunc = populateCaseMessage;
	obj.errorfunc = errorCaseSearchResults;
	run_ajax_json(obj);
	return;
}

function populateCaseMessage(messagesData) {
	
	if(messagesData!=null) {

		var currentMessageLength = messagesData.length;
		caseMessageLength = caseMessageLength + currentMessageLength;

		if(currentMessageLength > 0) {
			
			if(currentMessageLength > displayDataLimit) {
				$('#block-case-messages-link-more').show();
				currentMessageLength = displayDataLimit;
				caseMessageLength = caseMessageLength - 1;	 
			} else {		
				$('#block-case-messages-link-more').hide();
			}
			
			for(var i=0; i<currentMessageLength; i++) {		
				
				var trClass = '';
				if(i==0||i%2==0) {
					trClass = 'table-line line-grey';
				} else {
					trClass = 'table-line';
				}
				
				var messageDetail = messagesData[i];
		 
				if(messageDetail.id == null || typeof (messageDetail.id) == 'undefined') {
					messageDetail.id = "" ;
				} 
				if(messageDetail.type == null || typeof (messageDetail.type) == 'undefined') {
					messageDetail.type = "" ;
				} 
				if(messageDetail.status == null || typeof (messageDetail.status) == 'undefined') {
					messageDetail.status = "" ;
				} 
				if(messageDetail.executeTimestamp == null || typeof (messageDetail.executeTimestamp) == 'undefined') {
					messageDetail.executeTimestamp = "" ;
				} 
				if(messageDetail.createSignature == null || typeof (messageDetail.createSignature) == 'undefined') {
					messageDetail.createSignature = "" ;
				} 
				if(messageDetail.createTimestamp == null || typeof (messageDetail.createTimestamp) == 'undefined') {
					messageDetail.createTimestamp = "" ;
				} 
						
				$("#caseMessages > tbody").append(
					"<tr class='" + trClass+ "'> " +
						"<td> &nbsp;&nbsp;&nbsp; " + messageDetail.id + "</td>" +
						"<td>" + messageDetail.type + "</td>" +
						"<td>" + messageDetail.status + "</td>" +
						"<td>" + messageDetail.executeTimestamp + "</td>" +
						"<td>" + messageDetail.createSignature + "</td>" +
						"<td>" + messageDetail.createTimestamp + "</td>" +			
					"</tr>");	
			}		
		
		} else {
			$('#block-case-messages-link-more').hide();
		} 	
		
		$('#block-messages-number').html("("+caseMessageLength+")");	
	}
}



//////////////////////////////
///  Case Work Order Event
//////////////////////////////

function loadCaseWoEvents()
{
	var obj= {};
	obj.url=contextPath+"/std/CaseWoEvents.action";
	obj.pdata = "id="+caseId;
	obj.successfunc = populateCaseWoEvents;
	obj.errorfunc = errorCaseSearchResults;
	run_ajax_json(obj);
	return;
}

function populateCaseWoEvents(woEventsData) {
	
	if(woEventsData!=null) {

		var currentWoEventsLength = woEventsData.length;
		caseWoEventsLength = caseWoEventsLength + currentWoEventsLength;
		
		if(currentWoEventsLength > 0) {		
			
			if(currentWoEventsLength > displayDataLimit) {
				$('#block-case-wo-events-link-more').show();
				currentWoEventsLength = displayDataLimit;
				caseWoEventsLength = caseWoEventsLength - 1;	 
			} else {		
				$('#block-case-wo-events-link-more').hide();
			}
				
			for(var i=0; i<currentWoEventsLength; i++) {	
				
				var woEventsDetail = woEventsData[i];	
				
				var trClass = '';
				if(i==0||i%2==0) {
					trClass = 'table-line line-grey';
				} else {
					trClass = 'table-line';
				}
						
				if(woEventsDetail.type == null || typeof (woEventsDetail.type) == 'undefined') {
					woEventsDetail.type = "" ;
				} 
				if(woEventsDetail.timestamp == null || typeof (woEventsDetail.timestamp) == 'undefined') {
					woEventsDetail.timestamp = "" ;
				} 
				if(woEventsDetail.result == null || typeof (woEventsDetail.result) == 'undefined') {
					woEventsDetail.result = "" ;
				} 
				if(woEventsDetail.source == null || typeof (woEventsDetail.source) == 'undefined') {
					woEventsDetail.source = "" ;
				} 
				if(woEventsDetail.createSignature == null || typeof (woEventsDetail.createSignature) == 'undefined') {
					woEventsDetail.createSignature = "" ;
				} 
				if(woEventsDetail.createTimestamp == null || typeof (woEventsDetail.createTimestamp) == 'undefined') {
					woEventsDetail.createTimestamp = "" ;
				}  
				if(woEventsExportData == null || typeof (woEventsExportData) == 'undefined'){
					woEventsExportData= "['"+woEventsDetail.type+"','"+woEventsDetail.timestamp+"','"+woEventsDetail.result+"','"+woEventsDetail.source+"','"+woEventsDetail.createSignature+"','"+woEventsDetail.createTimestamp+"']";
				} else { 	
					woEventsExportData = woEventsExportData + ",['"+woEventsDetail.type+"','"+woEventsDetail.timestamp+"','"+woEventsDetail.result+"','"+woEventsDetail.source+"','"+woEventsDetail.createSignature+"','"+woEventsDetail.createTimestamp+"']";
				}
				 
				$("#caseWoEvents > tbody").append(
						"<tr class='" + trClass+ "'> " +
							"<td> &nbsp;&nbsp; " + woEventsDetail.type + "</td>" +
							"<td>" + woEventsDetail.timestamp + "</td>" +
							"<td>" + woEventsDetail.result + "</td>" +
							"<td>" + woEventsDetail.source + "</td>" +
							"<td>" + woEventsDetail.createSignature + "</td>" +
							"<td>" + woEventsDetail.createTimestamp + "</td>" +
						  "</tr>");			 
			}
			
			initWoEventsExportGrid();	
			setWoEventsExportGrid(woEventsExportData);
			
		} else {
			$('#block-case-wo-events-link-more').hide();
			$('#block-work-order-events-export-link').hide();	
		} 
		
		$('#block-work-order-events-number').html("("+caseWoEventsLength+")");	
	}
}

function initWoEventsExportGrid(){    
	
	woEventsExportGrid = new dhtmlXGridObject('woEventsGridDiv');            
	woEventsExportGrid.setImagePath(contextPath+"/js/dhtmlxGrid/codebase/imgs/");          
	woEventsExportGrid.setHeader(woEventsExportHeader);                    
	woEventsExportGrid.setInitWidths("*,*,*,*,*,*"); 
	woEventsExportGrid.setColAlign("center,center,center,center,center,center"); 
	woEventsExportGrid.setSkin("xp"); 
	woEventsExportGrid.init();
 }     	       

function setWoEventsExportGrid(data){	
	var griddata = eval('['+data+']');	
    woEventsExportGrid.clearAll();	
	woEventsExportGrid.parse(griddata,"jsarray");
}


//////////////////////////////
/// Case Status History
//////////////////////////////

function loadCaseStatusHistory()
{
	var obj= {};
	obj.url=contextPath+"/std/CaseStatusHistory.action";
	obj.pdata = "id="+caseId;
	obj.successfunc = populateCaseStatusHistory;
	obj.errorfunc = errorCaseSearchResults;
	run_ajax_json(obj);
	return;
}

function populateCaseStatusHistory(statusHistoryData) {
	
	if(statusHistoryData!=null) {

		var currentStatusHistLength = statusHistoryData.length;
		caseStatusHistLength = caseStatusHistLength + currentStatusHistLength;
			
		if(currentStatusHistLength > 0) {
		
			if(currentStatusHistLength > displayDataLimit) {		
				$('#block-case-history-status-link-more').show();
				currentStatusHistLength = displayDataLimit;
				caseStatusHistLength = caseStatusHistLength - 1;	 
			} else {		
				$('#block-case-history-status-link-more').hide();
			}
			
			for(var i=0; i<currentStatusHistLength; i++) {					
				
				var trClass = '';
				if(i==0||i%2==0) {
					trClass = 'table-line line-grey';
				} else {
					trClass = 'table-line';
				}
				
				var statusHistoryDetail = statusHistoryData[i];	 		
				
				if(statusHistoryDetail.caseStatus == null || typeof (statusHistoryDetail.caseStatus) == 'undefined') {
					statusHistoryDetail.caseStatus = "" ;
				} 
				if(statusHistoryDetail.startTimestamp == null || typeof (statusHistoryDetail.startTimestamp) == 'undefined') {
					statusHistoryDetail.startTimestamp = "" ;
				} 
				if(statusHistoryDetail.endTimestamp == null || typeof (statusHistoryDetail.endTimestamp) == 'undefined') {
					statusHistoryDetail.endTimestamp = "" ;
				} 
				if(statusHistoryDetail.createdBy == null || typeof (statusHistoryDetail.createdBy) == 'undefined') {
					statusHistoryDetail.createdBy = "" ;
				} 
				if(statusHistoryDetail.changedBy == null || typeof (statusHistoryDetail.changedBy) == 'undefined') {
					statusHistoryDetail.changedBy = "" ;
				} 
				if(statusHistoryDetail.createTimestamp == null || typeof (statusHistoryDetail.createTimestamp) == 'undefined') {
					statusHistoryDetail.createTimestamp = "" ;
				} 
				if(statusHistoryDetail.changeTimestamp == null || typeof (statusHistoryDetail.changeTimestamp) == 'undefined') {
					statusHistoryDetail.changeTimestamp = "" ;
				} 
						
				$("#caseStatusHistory > tbody").append(
					"<tr class='" + trClass+ "'> " +
						"<td> &nbsp;&nbsp;&nbsp; " + statusHistoryDetail.caseStatus + "</td>" +
						"<td>" + statusHistoryDetail.startTimestamp + "</td>" +
						"<td>" + statusHistoryDetail.endTimestamp + "</td>" +
						"<td>" + statusHistoryDetail.createdBy + "</td>" +
						"<td>" + statusHistoryDetail.changedBy + "</td>" +
						"<td>" + statusHistoryDetail.createTimestamp + "</td>" +	
						"<td>" + statusHistoryDetail.changeTimestamp + "</td>" +
					"</tr>");	
			}
			
		} else {
			$('#block-case-history-status-link-more').hide();
		} 
		
		$('#block-case-status-history-number').html("("+caseStatusHistLength+")");	
	}
}

//////////////////////////////
/// Case Action History
//////////////////////////////

function loadCaseActionHistory()
{
	var obj= {};
	obj.url=contextPath+"/std/CaseActionHistory.action";
	obj.pdata = "id="+caseId;
	obj.successfunc = populateCaseActionHistory;
	obj.errorfunc = errorCaseSearchResults;
	run_ajax_json(obj);
	return;
}

function populateCaseActionHistory(actionHistoryData) {
	
	if(actionHistoryData!=null) {

		var currentActionHistLength = actionHistoryData.length;
		caseActionHistLength = caseActionHistLength + currentActionHistLength;
		
		if(currentActionHistLength > 0) {
		
			if(currentActionHistLength > displayDataLimit) {		
				$('#block-case-history-action-link-more').show();
				currentActionHistLength = displayDataLimit;
				caseActionHistLength = caseActionHistLength - 1;	 
			} else {		
				$('#block-case-history-action-link-more').hide();
			}
		
			for(var i=0; i<currentActionHistLength; i++) {					
				
				var trClass = '';
				if(i==0||i%2==0) {
					trClass = 'table-line line-grey';
				} else {
					trClass = 'table-line';
				}
				
				var actionHistoryDetail = actionHistoryData[i];	 						
				if(actionHistoryDetail.action == null || typeof (actionHistoryDetail.action) == 'undefined') {
					actionHistoryDetail.action = "" ;
				} 
				if(actionHistoryDetail.timestamp == null || typeof (actionHistoryDetail.timestamp) == 'undefined') {
					actionHistoryDetail.timestamp = "" ;
				} 
				if(actionHistoryDetail.createSignature == null || typeof (actionHistoryDetail.createSignature) == 'undefined') {
					actionHistoryDetail.createSignature = "" ;
				} 
				if(actionHistoryDetail.createTimestamp == null || typeof (actionHistoryDetail.createTimestamp) == 'undefined') {
					actionHistoryDetail.createTimestamp = "" ;
				} 				
				
				$("#caseActionHistory > tbody").append(
					"<tr class='" + trClass+ "'> " +
						"<td> &nbsp;&nbsp;&nbsp; " + actionHistoryDetail.action + "</td>" +
						"<td>" + actionHistoryDetail.timestamp + "</td>" +
						"<td>" + actionHistoryDetail.createSignature + "</td>" +
						"<td>" + actionHistoryDetail.createTimestamp + "</td>" +		
					"</tr>");			
			}
						
		} else {
			$('#block-case-history-action-link-more').hide();
		} 
		
		$('#block-case-status-action-number').html("("+caseActionHistLength+")");	
	}
}

/////////////////////////////////////
/// Case Customer Contact History
/////////////////////////////////////

function loadCaseCustContactHistory()
{
	var obj= {};
	obj.url=contextPath+"/std/CaseCustContactHistory.action";
	obj.pdata = "id="+caseId;
	obj.successfunc = populateCaseCustContactHistory;
	obj.errorfunc = errorCaseSearchResults;
	run_ajax_json(obj);
	return;
}

function populateCaseCustContactHistory(custContactHistoryData) {
	
	if(custContactHistoryData!=null) {

		var currentCustContactHistLength = custContactHistoryData.length;
		caseCustContactHistLength = caseCustContactHistLength + currentCustContactHistLength;
		
		if(currentCustContactHistLength > 0) {
		
			if(currentCustContactHistLength > displayDataLimit) {
				$('#block-case-history-customer-contact-link-more').show();
				currentCustContactHistLength = displayDataLimit;
				caseCustContactHistLength = caseCustContactHistLength - 1;
			} else {		
				$('#block-case-history-customer-contact-link-more').hide();
			}
				
			for(var i=0; i<currentCustContactHistLength; i++) {					
				
				var trClass = '';
				if(i==0||i%2==0) {
					trClass = 'table-line line-grey';
				} else {
					trClass = 'table-line';
				}
				
				var custContactDetail = custContactHistoryData[i];	 		
								
				if(custContactDetail.contactType == null || typeof (custContactDetail.contactType) == 'undefined') {
					custContactDetail.contactType = "" ;
				} 
				if(custContactDetail.commType == null || typeof (custContactDetail.commType) == 'undefined') {
					custContactDetail.commType = "" ;
				} 
				if(custContactDetail.localDate == null || typeof (custContactDetail.localDate) == 'undefined') {
					custContactDetail.localDate = "" ;
				} 
				if(custContactDetail.customerDate == null || typeof (custContactDetail.customerDate) == 'undefined') {
					custContactDetail.customerDate = "" ;
				} 
				if(custContactDetail.result == null || typeof (custContactDetail.result) == 'undefined') {
					custContactDetail.result = "" ;
				} 
				if(custContactDetail.note == null || typeof (custContactDetail.note) == 'undefined') {
					custContactDetail.note = "" ;
				} 
				if(custContactDetail.createSignature == null || typeof (custContactDetail.createSignature) == 'undefined') {
					custContactDetail.createSignature = "" ;
				} 
				if(custContactDetail.createTimestamp == null || typeof (custContactDetail.createTimestamp) == 'undefined') {
					custContactDetail.createTimestamp = "" ;
				} 
						
				$("#caseCustContactHistory > tbody").append(
					"<tr class='" + trClass+ "'> " +
						"<td> &nbsp;&nbsp;&nbsp; " + custContactDetail.contactType + "</td>" +
						"<td>" + custContactDetail.commType + "</td>" +
						"<td>" + custContactDetail.localDate + "</td>" +
						"<td>" + custContactDetail.customerDate + "</td>" +
						"<td>" + custContactDetail.result + "</td>" +
						"<td>" + custContactDetail.note + "</td>" +			
						"<td>" + custContactDetail.createSignature + "</td>" +			
						"<td>" + custContactDetail.createTimestamp + "</td>" +					
					"</tr>");		
			}
		
		} else {
			$('#block-case-history-customer-contact-link-more').hide();
		} 
		
		$('#block-case-cust-contact-number').html("("+caseCustContactHistLength+")");	
	}
}

//////////////////////////////
/// Show More Functions
//////////////////////////////


function showMoreResults(resultType) {
	
	if(caseId!= null && resultType != null) {
		
		var obj= {};	
		switch (resultType)
		{
			case "INST":
							instSearchOffset = instSearchOffset + displayDataLimit;
							obj.url=contextPath+"/std/ShowMoreCaseInstallation.action";
							obj.pdata = "id="+caseId+"&offset="+instSearchOffset;
							obj.successfunc = populateCaseInstallation;
							break;
			case "SLA": 	
							caseSlaOffset = caseSlaOffset + displayDataLimit;
							obj.url=contextPath+"/std/ShowMoreCaseSla.action";
							obj.pdata = "id="+caseId+"&offset="+caseSlaOffset;
							obj.successfunc = populateCaseSla;						
							break;	
			case "INFO": 	
							caseInformationOffset = caseInformationOffset + displayDataLimit;
							obj.url=contextPath+"/std/ShowMoreCaseInformation.action";
							obj.pdata = "id="+caseId+"&offset="+caseInformationOffset;
							obj.successfunc = populateCaseInformation;						
							break;			
			case "MESSAGES": 	
							caseMessageOffset = caseMessageOffset + displayDataLimit;
							obj.url=contextPath+"/std/ShowMoreCaseMessages.action";
							obj.pdata = "id="+caseId+"&offset="+caseMessageOffset;
							obj.successfunc = populateCaseMessage;						
							break;		
			case "HISTORY_STATUS":	 	
							caseStatusHistOffset = caseStatusHistOffset + displayDataLimit;
							obj.url=contextPath+"/std/ShowMoreCaseStatusHistory.action";
							obj.pdata = "id="+caseId+"&offset="+caseStatusHistOffset;
							obj.successfunc = populateCaseStatusHistory;		
							break;
			case "HISTORY_ACTION": 
							caseActionHistOffset = caseActionHistOffset + displayDataLimit;
							obj.url=contextPath+"/std/ShowMoreCaseActionHistory.action";
							obj.pdata = "id="+caseId+"&offset="+caseActionHistOffset;
							obj.successfunc = populateCaseActionHistory;	
							break;
			case "HISTORY_CONTACT": 
							caseCustContactHistOffset = caseCustContactHistOffset + displayDataLimit;
							obj.url=contextPath+"/std/ShowMoreCaseCustContactHistory.action";
							obj.pdata = "id="+caseId+"&offset="+caseCustContactHistOffset;
							obj.successfunc = populateCaseCustContactHistory;	
							break;
			case "WORK_ORDER": 	
							caseWoEventsOffset = caseWoEventsOffset + displayDataLimit;
							obj.url=contextPath+"/std/ShowMoreCaseWoEvents.action";
							obj.pdata = "id="+caseId+"&offset="+caseWoEventsOffset;
							obj.successfunc = populateCaseWoEvents;						
							break;	
			default:
						alert(i18nerrorInvalidCaseAction);
	    }
		
		obj.errorfunc = errorCaseShowMoreResults;
		run_ajax_json(obj);
		return;
		
	} else {
		alert(i18nerrorInvalidCaseInput);
	}	
}


function getStatusColor(caseStatus) {
	var statusClass = "";
	 if(caseStatus != null) {
		 caseStatus =  caseStatus.toUpperCase();
		 if(caseStatus == "IN PROGRESS") {
			 statusClass="info";
		 } else if(caseStatus == "ERROR" || caseStatus == "ERROR STARTING") {
			 statusClass="error";
		 } else {
			 statusClass="ok";
		 } 
	 }
	 return statusClass;
}

//////////////////////////////
/// Error  Functions
//////////////////////////////

function errorCaseSearchResults() {
	
}

function errorCaseMapLocation() {
	$('#block-case-location-map-wrapper').html('');    
}

function errorCaseShowMoreResults() {
	
}


