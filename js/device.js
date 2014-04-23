var contextPath;
var deviceId;
var mapServerUrl;

var overviewMeasurepointTitle;
var overviewMultipointTitle;
var overviewPalletTitle;
var overviewStockTitle;

var i18nerrorNoDeviceData;

var displayDataLimit = 10;

var instHistLength = 0;
var statusHistLength = 0;
var ownerHistLength  = 0;
var stockSiteHistLength = 0;
var palletHistLength = 0;

var instHistOffset = 0;
var statusHistOffset = 0;
var ownerHistOffset = 0;
var stockSiteHistOffset = 0;
var palletHistOffset = 0;

//////////////////////////////
///  INIT
//////////////////////////////

jQuery(document).ready(function($){  
	
	initDevice();
	$(".accordion ul.subMenu").show();
});

$(function(){	
	
	renderTable("#overview-table");
	renderTable("#device-installation-table");
	renderTable("#device-status-table");
	renderTable("#device-stock-site-table");
	renderTable("#device-pallet-table");
	renderTable("#device-owner-table");
	renderTable("#hardware-configuration-table");
	$(".accordion ul.subMenu").hide();

});	

function initDevice()
{ 
	clearAll();
	reset();
	
	loadDeviceOverview();
	loadDeviceHardware();
	loadInstallationHistory();
	loadStatusHistory();
	loadStockSiteHistory();
	loadPalletHistory();
	loadOwnerHistory();
	loadDeviceLocation();
}


//////////////////////////////
///  Device Overview
//////////////////////////////

function loadDeviceOverview()
{	
	var obj= {};
	obj.url=contextPath+"/std/DeviceOverview.action";
	obj.pdata = "id="+deviceId;
	obj.successfunc = populateDeviceOverview;
	obj.errorfunc = errorDeviceSearchResults;
	run_ajax_json(obj);
	return;
}

function populateDeviceOverview(data)
{
	$("#device-id").text(deviceId);			
	if(data!="" || data!=null) {
		
		var overviewDetails = eval(data);				
		$("#block-overview-device-type").text(overviewDetails.type);
		$("#block-overview-device-model").text(overviewDetails.model);
		$("#block-overview-giai").text(overviewDetails.giai);
		$("#block-overview-serial-number").text(overviewDetails.serialNumber);
		$("#block-overview-property-number").text(overviewDetails.propertyNumber);
		$("#block-overview-domain").text(overviewDetails.domain);
		$("#block-overview-status").text(overviewDetails.status);	
		$("#block-overview-pallet").text(overviewDetails.pallet);
		$("#block-overview-stock-site").text(overviewDetails.stockSite);
		
		if(overviewDetails.mepId != null) {	
			$("#block-measurepoint-multipoint-title").html(overviewMeasurepointTitle);
			$("#block-overview-measurepoint-id").html("<a href='"+contextPath+"/std/ViewMeasurepoint?id="+overviewDetails.mepId+"' class='text-blue'> "+overviewDetails.mepId+" </a>");
		} else if(overviewDetails.mupId != null) {
			$("#block-measurepoint-multipoint-title").html(overviewMultipointTitle);
			$("#block-overview-measurepoint-id").html("<a href='"+contextPath+"/std/ViewMultipoint?id="+overviewDetails.mupId+"' class='text-blue'> "+overviewDetails.mupId+" </a>");
		} else {
			$("#block-measurepoint-multipoint-title").html(overviewMeasurepointTitle);
			$("#block-overview-measurepoint-id").html(" ");
		}
		
	}
}

//////////////////////////////
///  Device Location
//////////////////////////////

function loadDeviceLocation()
{
	var obj= {};
	obj.url=contextPath+"/std/DeviceLocation.action";
	obj.pdata = "id="+deviceId;
	obj.successfunc = populateDeviceLocation;
	obj.errorfunc = errorDeviceMapResults;
	run_ajax_json(obj);
	return;
}

function populateDeviceLocation(data)
{
	if(data!=""||data!=null) {
		var locationDetails = eval(data);	
		$("#block-device-location-adress").text(locationDetails.street + ',' + locationDetails.postcode + ' ' + locationDetails.city);
		$("#block-device-location-area").text(locationDetails.areaName);	
		loadMapPoint(mapServerUrl, "block-device-location-map-wrapper", locationDetails.xcoordinate, locationDetails.ycoordinate);  
	}
}

//////////////////////////////
///  Device Hardware
//////////////////////////////

function loadDeviceHardware()
{
	var obj= {};
	obj.url=contextPath+"/std/DeviceHardware.action";
	obj.pdata = "id="+deviceId;
	obj.successfunc = populateDeviceHardware;
	obj.errorfunc = errorDeviceSearchResults;
	run_ajax_json(obj);
	return;
}

function populateDeviceHardware(data)
{
	if(data!=""||data!=null) {
		var str = '';
		var deviceHardwareList = eval(data);	
		for(var i=0; i<deviceHardwareList.length; i++) {
			
			var trClass = '';
			var statusClass='';
			var idLink = '';
		
			if(i==0||i%2==0) {
				trClass = 'table-line line-grey';
			} else {
				trClass = 'table-line';
			}
		
			var deviceHardwareDetail = deviceHardwareList[i];
			var info = (typeof deviceHardwareDetail.information=='undefined' ? '': deviceHardwareDetail.information);
		    var hardwaretype = (typeof deviceHardwareDetail.type=='undefined' ? null: deviceHardwareDetail.type);
			 
		    if(hardwaretype!=null) {	    	
		    	hardwaretype = hardwaretype.toUpperCase();   	
				if(hardwaretype == 'INSTALLATION') { 
					idLink = "<a href='"+contextPath+"/std/ViewInstallation?id="+deviceHardwareDetail.id+"' class='text-blue'> "+deviceHardwareDetail.id+" </a>" ;
				} else if(hardwaretype == 'MEASUREPOINT') {					 
					idLink = "<a href='"+contextPath+"/std/ViewMeasurepoint?id="+deviceHardwareDetail.id+"' class='text-blue'> "+deviceHardwareDetail.id+" </a>" ;
			    } else if(hardwaretype == 'MULTIPOINT') {
					idLink = "<a href='"+contextPath+"/std/ViewMultipoint?id="+deviceHardwareDetail.id+"' class='text-blue'> "+deviceHardwareDetail.id+" </a>" ;		
				} else {
					idLink = " "+deviceHardwareDetail.id+" " ;
				}
		    }
			
    		 $("#hardware-configuration-table > tbody").append( 
				    "<tr data-level='"+i+"' class='"+trClass+"'>" +
			 		"<td> &nbsp;&nbsp;&nbsp; "+deviceHardwareDetail.type+"  </td>" +
			 		"<td> "+idLink+" </td>" +
			 		"<td> "+deviceHardwareDetail.code+" </td>" +
			 		"<td> "+info+" </td>" +
			 		"</tr>");
		   
		}
		renderTree();
	}
}


//////////////////////////////
///  Installation History
//////////////////////////////

function loadInstallationHistory()
{
	var obj= {};
	obj.url=contextPath+"/std/DeviceInstallationHistory.action";
	obj.pdata = "id="+deviceId;
	obj.successfunc = populateInstallationHistory;
	obj.errorfunc = errorDeviceSearchResults;
	run_ajax_json(obj);
	return;
}

function populateInstallationHistory(data)
{
	if(data!=""||data!=null) {
		
		var instHistList = eval(data);	
		var currentLength = instHistList.length;
		instHistLength = instHistLength + currentLength;	
		
		if(currentLength > 10){
			$('#block-device-installation-link-more').show();
		    currentLength = displayDataLimit;
		    instHistLength = instHistLength - 1;	          
		} else {
			$('#block-device-installation-link-more').hide(); 
		}  
		
		for(var i=0; i<currentLength; i++) {
			
			var trClass = '';
			var statusClass='';
			if(i==0||i%2==0) {
				trClass = 'table-line line-grey';
			} else {
				trClass = 'table-line';
			}
			
			 var instHistDetail = instHistList[i];
			 var instCode = (typeof instHistDetail.code=='undefined' ? '': instHistDetail.code);
			 var instMep = (typeof instHistDetail.mepId=='undefined' ? '': instHistDetail.mepId);
			 var instMepCode = (typeof instHistDetail.mepCode=='undefined' ? '': instHistDetail.mepCode);
					 
			 $("#device-installation-table > tbody").append("<tr class='"+trClass+"'>" +
			 		"<td><a href='"+contextPath+"/std/ViewInstallation?id="+instHistDetail.id+"' class='text-blue'>"+instHistDetail.id+" </a></td>" +
			 		"<td>"+instCode+"</td>" +
			 		"<td><a href='"+contextPath+"/std/ViewMeasurepoint?id="+instMep+"' class='text-blue'>"+instMep+"</a></td>" +
			 		"<td>"+instMepCode+"</td></tr>");		
		 
		}
	}
	
	$('#block-device-installations-number').html("("+instHistLength+")");
}


//////////////////////////////
///  Status History
//////////////////////////////

function loadStatusHistory()
{
	var obj= {};
	obj.url=contextPath+"/std/DeviceStatusHistory.action";
	obj.pdata = "id="+deviceId;
	obj.successfunc = populateStatusHistory;
	obj.errorfunc = errorDeviceSearchResults;
	run_ajax_json(obj);
	return;
}


function populateStatusHistory(data)
{
	if(data!=""||data!=null) {
		
		var statusHistList = eval(data);	
		var currentLength = statusHistList.length;
		statusHistLength = statusHistLength + currentLength;		
		
		if(currentLength > 10){
			$('#block-device-status-link-more').show();
		    currentLength = displayDataLimit;
		    statusHistLength = statusHistLength - 1;          
		} else {
			$('#block-device-status-link-more').hide();   
		}  
	
		for(var i=0; i<currentLength; i++) {
			
			var trClass = '';
			var statusClass='';
			if(i==0||i%2==0) {
				trClass = 'table-line line-grey';
			} else {
				trClass = 'table-line';
			}
			
			 var statusHistDetail = statusHistList[i];
			 var endTimestamp = (typeof statusHistDetail.endTimestamp=='undefined' ? '': statusHistDetail.endTimestamp);
			 
			 $("#device-status-table > tbody").append("<tr class='"+trClass+"'>" +
			 		"<td> &nbsp;&nbsp;&nbsp; "+statusHistDetail.status+"</td>" +
			 		"<td>"+statusHistDetail.startTimestamp+"</td>" +
			 		"<td>"+endTimestamp+"</td>" +
			 		"<td>"+statusHistDetail.reason+"</td></tr>");			 
		}
	}
	$('#block-device-status-number').html("("+statusHistLength+")");
}


//////////////////////////////
/// Stock Site
//////////////////////////////

function loadStockSiteHistory()
{
	var obj= {};
	obj.url=contextPath+"/std/DeviceStockSiteHistory.action";
	obj.pdata = "id="+deviceId;
	obj.successfunc = populateStockSiteHistory;
	obj.errorfunc = errorDeviceSearchResults;
	run_ajax_json(obj);
	return;
}


function populateStockSiteHistory(data)
{
	if(data!="" || data!=null) {
		
		var stockSiteHistList = eval(data);	
		var currentLength = stockSiteHistList.length;
		stockSiteHistLength = stockSiteHistLength + currentLength;
		
		if(currentLength > 10){
			$('#block-device-stock-site-link-more').show();
		    currentLength = displayDataLimit;
		    stockSiteHistLength = stockSiteHistLength - 1;	          
		} else {
		   $('#block-device-stock-site-link-more').hide();      
		}  
		
		for(var i=0; i<currentLength; i++) {
			
			var trClass = '';
			var statusClass='';
			if(i==0||i%2==0) {
				trClass = 'table-line line-grey';
			} else {
				trClass = 'table-line';
			}
			
			var stockSiteDetail = stockSiteHistList[i];
			var endTimestamp = (typeof stockSiteDetail.endTimestamp=='undefined' ? '': stockSiteDetail.endTimestamp);
			 
			$("#device-stock-site-table > tbody").append("<tr class='"+trClass+"'>" +
			 		"<td> &nbsp;&nbsp;&nbsp; "+stockSiteDetail.stockId+"</td>" +
			 		"<td>"+stockSiteDetail.stockSiteName+"</td>" +
			 		"<td>"+stockSiteDetail.startTimestamp+"</td>" +
			 		"<td>"+endTimestamp+"</td></tr>");			 
		}
	}
	$('#block-device-stock-site-number').html("("+stockSiteHistLength+")");
}



//////////////////////////////
/// Pallet History
//////////////////////////////

function loadPalletHistory()
{
	var obj= {};
	obj.url=contextPath+"/std/DevicePalletHistory.action";
	obj.pdata = "id="+deviceId;
	obj.successfunc = populatePalletHistory;
	obj.errorfunc = errorDeviceSearchResults;
	run_ajax_json(obj);
	return;
}


function populatePalletHistory(data)
{
	if(data!="" || data!=null) {
		
		var palletHistList = eval(data);	
		var currentLength = palletHistList.length;
		palletHistLength = palletHistLength + currentLength;
			
        if(currentLength > 10){
           	$('#block-device-pallet-link-more').show();	
           	currentLength = displayDataLimit;
            palletHistLength = palletHistLength - 1;     
        } else {
        	$('#block-device-pallet-link-more').hide();         
      	}  
    	      
        for(var i=0; i<currentLength; i++) {
			
			var trClass = '';
			var statusClass='';
			if(i==0||i%2==0) {
				trClass = 'table-line line-grey';
			} else {
				trClass = 'table-line';
			}
			
			var palletDetail = palletHistList[i];
			var sendingId = (typeof palletDetail.sending=='undefined' ? '': palletDetail.sending);
			var destinationId = (typeof palletDetail.destination=='undefined' ? '': palletDetail.destination);
			var receivingId = (typeof palletDetail.receiving=='undefined' ? '': palletDetail.receiving);
			var endTimestamp = (typeof palletDetail.endTimestamp=='undefined' ? '': palletDetail.endTimestamp);
			 	
			$("#device-pallet-table > tbody").append("<tr class='"+trClass+"'>" +
			 		"<td> &nbsp;&nbsp;&nbsp; "+palletDetail.code+"</td>" +
			 		"<td>"+palletDetail.type+"</td>" +
			 		"<td>"+palletDetail.status+"</td>" +
			 		"<td>"+sendingId+"</td>" +
			 		"<td>"+destinationId+"</td>" +
			 		"<td>"+receivingId+"</td>" +
			 		"<td>"+palletDetail.startTimestamp+"</td>" +
			 		"<td>"+endTimestamp+"</td></tr>");			 
		}
	}
	$('#block-device-pallet-number').html("("+palletHistLength+")");	
}



//////////////////////////////
/// Owner History
//////////////////////////////

function loadOwnerHistory()
{
	var obj= {};
	obj.url=contextPath+"/std/DeviceOwnerHistory.action";
	obj.pdata = "id="+deviceId;
	obj.successfunc = populateOwnerHistory;
	obj.errorfunc = errorDeviceSearchResults;
	run_ajax_json(obj);
	return;
}


function populateOwnerHistory(data)
{
	if(data!=""||data!=null) {
		
		var ownerHistList = eval(data);	
		var currentLength = ownerHistList.length;
		ownerHistLength = ownerHistLength + currentLength;
		
		if(currentLength > 10){
		   $('#block-device-owner-link-more').show();
	       currentLength = displayDataLimit;
	       ownerHistLength = ownerHistLength - 1;          
	    } else {
	       $('#block-device-owner-link-more').hide();         
	    }  
				
		for(var i=0; i<currentLength; i++) {
			
			var trClass = '';
			var statusClass='';
			if(i==0||i%2==0) {
				trClass = 'table-line line-grey';
			} else {
				trClass = 'table-line';
			}
			
			 var ownerHistDetail = ownerHistList[i];
			 var endTimestamp = (typeof ownerHistDetail.endTimestamp=='undefined' ? '': ownerHistDetail.endTimestamp);
			 
			 $("#device-owner-table > tbody").append("<tr class='"+trClass+"'>" +
			 		"<td> &nbsp;&nbsp;&nbsp; "+ownerHistDetail.owner+"</td>" +
			 		"<td>"+ownerHistDetail.startTimestamp+"</td>" +
			 		"<td>"+endTimestamp+"</td></tr>");			 
		}
	}
	$('#block-device-owner-number').html("("+ownerHistLength+")");
}


//////////////////////////////
/// Show More Functions
//////////////////////////////

function showMoreDeviceResults(resultType) {
	
	if(deviceId!= null && resultType != null) {
		
		var obj= {};	
		switch (resultType)
		{
			case "INST":
							instHistOffset = instHistOffset + displayDataLimit;
							obj.url=contextPath+"/std/ShowMoreDeviceInstallationHistory.action";
							obj.pdata = "id="+deviceId+"&offset="+instHistOffset;
							obj.successfunc = populateInstallationHistory;
							break;						
			case "STATUS":
							statusHistOffset = statusHistOffset + displayDataLimit;
							obj.url=contextPath+"/std/ShowMoreDeviceStatusHistory.action";
							obj.pdata = "id="+deviceId+"&offset="+statusHistOffset;
							obj.successfunc = populateStatusHistory;
							break;					
			case "STOCK_SITE":
							stockSiteHistOffset = stockSiteHistOffset + displayDataLimit;
							obj.url=contextPath+"/std/ShowMoreDeviceStockSiteHistory.action";
							obj.pdata = "id="+deviceId+"&offset="+stockSiteHistOffset;
							obj.successfunc = populateStockSiteHistory;
							break;
			case "PALLET":
							palletHistOffset = palletHistOffset + displayDataLimit;
							obj.url=contextPath+"/std/ShowMoreDevicePalletHistory.action";
							obj.pdata = "id="+deviceId+"&offset="+palletHistOffset;
							obj.successfunc = populatePalletHistory;
							break;
			case "OWNER":
							ownerHistOffset = ownerHistOffset + displayDataLimit;
							obj.url=contextPath+"/std/ShowMoreDeviceOwnerHistory.action";
							obj.pdata = "id="+deviceId+"&offset="+ownerHistOffset;
							obj.successfunc = populateOwnerHistory;
							break;
			default:
							errorDeviceSearchResults();
	    }
		
		obj.errorfunc = errorDeviceSearchResults;
		run_ajax_json(obj);
		return;
		
	} else {
		alert(i18nerrorInvalidCaseInput);
	}	
}


//////////////////////////////
/// Tree Functions
//////////////////////////////

function renderTree() {
	$("table.tree").treeTable({
		   ignoreClickOn: "input, a, img"
	});
}

function clearAll() {
	
	// Resetting table contents.
	$('#block-hardware-configuration-table > tbody').html(' ');    
	$('#device-installation-table > tbody').html(' ');
	$('#device-status-table > tbody').html(' ');    
	$('#device-stock-site-table > tbody').html(' ');    
	$('#device-pallet-table > tbody').html(' ');   
	$('#device-owner-table > tbody').html(' ');   
	
	// Disabling show more options
	$('#block-device-installation-link-more').hide();
	$('#block-device-status-link-more').hide();
	$('#block-device-stock-site-link-more').hide();
	$('#block-device-pallet-link-more').hide();
	$('#block-device-owner-link-more').hide();
	
	// Default Texts	
	$("#block-measurepoint-multipoint-title").html(overviewMeasurepointTitle);
    $("#block-stock-pallet-title").html(overviewPalletTitle);	
 
}

function reset() {
	
	// Resetting data length
	instHistLength = 0;
	statusHistLength = 0;
	ownerHistLength  = 0;
	stockSiteHistLength = 0;
	palletHistLength = 0;
	
	// Resetting offsets
	instHistOffset = 0;
	statusHistOffset = 0;
	ownerHistOffset = 0;
	stockSiteHistOffset = 0;
	palletHistOffset = 0;
}

//////////////////////////////
/// Error Functions
//////////////////////////////

function errorDeviceSearchResults() {
	//alert(i18nerrorNoDeviceData);
}

function errorDeviceMapResults() {
	//alert(i18nerrorNoDeviceData);
	$('#block-device-location-map-wrapper').html(' ');    
	
}