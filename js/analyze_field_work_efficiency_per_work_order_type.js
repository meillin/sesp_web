var contextPath = "";
var workOrderType = "";	
var technicianAnalysisGrid="";
var teamAnalysisGrid="";

function onLoadSpecial() {
	//alert("body loading..");
	onDateIntervalSelect();	
	getDomainList();	
	}
function onDateIntervalSelect() {

	if ($("#filter-select-date-interval").val() == "custominterval") {
		showDates();
	} else {
		hideDates();
	}
}

function hideDates()
{
	$("#from_date").hide();
	$("#to_date").hide();
}

function showDates(){
	$("#from_date").show();
	$("#to_date").show();
}

function onDomainSelect(){
	
	var domainCodes = $("#filter-multiselect-domain").val();
	//alert("domain :"+domainCodes);
	if ( domainCodes != null && domainCodes != "" ) {
		getAreaList(domainCodes);
		getTeamList(domainCodes);
	}else{
		//Refresh Multiselect boxes 
		refreshMultiSelectBox("#filter-multiselect-area");
		refreshMultiSelectBox("#filter-multiselect-team");
		refreshMultiSelectBox("#filter-multiselect-technician");
	}
}

function refreshMultiSelectBox(selectName){
	
	$(selectName).empty();
	$(selectName).multiselect("refresh");	
}

function getDomainList() {	
	var obj= {};
	obj.url=contextPath+"/std/GetDomains.action";	
	obj.successfunc = fillDomain;	
	//obj.errorfunc = errorAutoFill;
	run_ajax_json(obj);
	return;	
}

function fillDomain(data){
	var items;
	$.each(data, function(i, item) {
		items += '<option value="' + item.id + '">' + item.name + '</option>';
	});
	populateMultiSelectBox("#filter-multiselect-domain", items);
}


function getAreaList(domainCodes) {
	var obj = {};
	obj.url = contextPath + "/std/AnalyzeWorkOrderArea.action";
	//alert("URL for Area list:"+obj.url);
	obj.pdata = "domainCodes=" + domainCodes;
	obj.successfunc = fillArea;
	//obj.errorfunc = errorAutoFill;
	run_ajax_json(obj);
	return;
}

function fillArea(data) {

	var items;
	$.each(data, function(i, item) {
		items += '<option value="' + item.id + '">' + item.name + '</option>';
	});
	populateMultiSelectBox("#filter-multiselect-area",items);
}

function getTeamList(domainCodes){
	
	var obj = {};
	obj.url = contextPath + "/std/AnalyzeWorkOrderTeam.action";
	obj.pdata = "domainCodes=" + domainCodes;
	obj.successfunc = fillTeam;
	//obj.errorfunc = errorAutoFill;
	run_ajax_json(obj);
	return;
	
}

function fillTeam(data) {

	var items;
	
	$.each(data, function(i, item) {
		items += '<option value="' + item.id + '">' + item.name + '</option>';
	});
	populateMultiSelectBox("#filter-multiselect-team",items);
}

function onTeamSelect(){
	
	var teamCodes = $("#filter-multiselect-team").val();
	//alert("teamCodes :"+teamCodes);
	if ( teamCodes != null && teamCodes != "" ) {
		getTechnicianList(teamCodes);
	}else{
		//Refresh MultiSelect technician
		refreshMultiSelectBox("#filter-multiselect-technician");
	}
}

function getTechnicianList(teamCodes){
	
	var obj = {};
	obj.url = contextPath + "/std/AnalyzeWorkOrderTechnician.action";
	//alert("URL for Technician list:"+obj.url);
	obj.pdata = "teamCodes=" + teamCodes;
	obj.successfunc = fillTechnician;
	//obj.errorfunc = errorAutoFill;
	run_ajax_json(obj);
	return;
}

function fillTechnician(data){
	var items;
	
	$.each(data, function(i, item) {
		items += '<option value="' + item.id + '">' + item.userName + '</option>';
	});
	populateMultiSelectBox("#filter-multiselect-technician",items);
}
//Populate the multi-select box with the given data for the given id
function populateMultiSelectBox(selectedNameId, items){
	
	$(selectedNameId).html(items);
	$(selectedNameId).multiselect("refresh");
}


function onUpdateClick(){

	//alert("On update");
	if(!validateFieldWorkEfficiency())
	{
		return;
	}
	
	var domains=$("#filter-multiselect-domain").val();
	var areas=$("#filter-multiselect-area").val();
	var teams=$("#filter-multiselect-team").val();
	var technicians=$("#filter-multiselect-technician").val();
	
	var divTitleClassName = 'filter-block-title';
	var divContentClassName = 'filter-block-content';
	
	
	$("#block-technician-analysis-chart").empty();
	$("#block-team-analysis-chart").empty();
	/* To clear the table */
	$("#block-team-analysis-table > tbody").empty();
	$("#block-technician-analysis-table > tbody").empty();
	
	
	//Area for Technician analysis filter block	
	var parentDivId = 'filter-technician-block-area';
	document.getElementById(parentDivId).innerHTML = ''; // refresh
	appendDynamicChildDiv(divTitleClassName,analysisAreaTitle,parentDivId);	 //Filter block title
	appendChildDivs(document.getElementById('filter-multiselect-area'),divContentClassName,parentDivId); // selected areas
	
	//Team for Technician analysis filter block
	parentDivId = "filter-technician-block-team";
	document.getElementById(parentDivId).innerHTML = ''; 
	appendDynamicChildDiv(divTitleClassName,analysisTeamTitle,parentDivId);
	appendChildDivs(document.getElementById('filter-multiselect-team'),divContentClassName,parentDivId);
	
	//Technician for Technician analysis filter block
	parentDivId = "filter-technician-block-technician";
	document.getElementById(parentDivId).innerHTML = '';
	appendDynamicChildDiv(divTitleClassName,analysisTechTitle,parentDivId);
	appendChildDivs(document.getElementById('filter-multiselect-technician'),divContentClassName,parentDivId);
	
	//Area for Team block filter
	parentDivId = 'filter-team-block-area';
	document.getElementById(parentDivId).innerHTML = '';
	appendDynamicChildDiv(divTitleClassName,analysisAreaTitle,parentDivId);	
	appendChildDivs(document.getElementById('filter-multiselect-area'),divContentClassName,parentDivId);
	
	//Team for Team block filter
	parentDivId = 'filter-team-block-team';
	document.getElementById(parentDivId).innerHTML = '';
	appendDynamicChildDiv(divTitleClassName,analysisTeamTitle,parentDivId);	
	appendChildDivs(document.getElementById('filter-multiselect-team'),divContentClassName,parentDivId);
	
	//Technician for Team block filter
	parentDivId = 'filter-team-block-technician';
	document.getElementById(parentDivId).innerHTML = '';
	appendDynamicChildDiv(divTitleClassName,analysisTechTitle,parentDivId);	
	appendChildDivs(document.getElementById('filter-multiselect-technician'),divContentClassName,parentDivId);
	
	//Refreshing the chars data
	$("#block-technician-analysis-chart").empty();
	$("#block-team-analysis-chart").empty();
	//Refreshing the tables data
	$("#block-technician-analysis-table > tbody").empty();
	$("#block-team-analysis-table > tbody").empty();	
	
	var dateInterval=$("#filter-select-date-interval").val();
	var fromDate,toDate;
	
	if(dateInterval=='custominterval')
	{
		fromDate=$("#filter-date-from").val();
		toDate=$("#filter-date-to").val();
	}
	processTechAnalysisData(domains,areas,teams,technicians,dateInterval,fromDate,toDate);
	processTeamAnalysisData(domains,areas,teams,technicians,dateInterval,fromDate,toDate);
}

//Populate the child elements to the Filter blocks 
function appendChildDivs(multiSelectValues,divClassName,parentDivId ){
	
	for ( var i = 0; i < multiSelectValues.options.length; i++) {
		if (multiSelectValues.options[i].selected) {
			appendDynamicChildDiv(divClassName,multiSelectValues.options[i].text,parentDivId);
		}
	}
	
}
//Creating dynamic div 
function appendDynamicChildDiv(divClassName,divText,parentDivId){
	
	var iDiv = document.createElement('div');
	iDiv.className = divClassName;
	iDiv.innerHTML = divText;
	document.getElementById(parentDivId).appendChild(iDiv);
}
//Processing Technician Analysis data
function processTechAnalysisData(domains,areas,teams,technicians,dateInterval,fromDate,toDate){
	
	var obj= {};
	var parameterData="domains="+domains+"&areas="+areas+"+&teams="+teams+"&technicians="+technicians+"&workOrderType="+workOrderType;
		obj.url=contextPath+"/std/AnalyzeWorkOrderTechnicianData.action";
		
		if(dateInterval=='custominterval')	{
			obj.pdata = parameterData+"&loadFromDate="+fromDate+"&loadToDate="+toDate;// post variable data
		}
		else {
			obj.pdata =parameterData+"&dateInterval="+dateInterval;		
		}
		obj.successfunc = populateTechAnalysisData;
		run_ajax_json(obj);
}

//Processing Team Analysis data
function processTeamAnalysisData(domains,areas,teams,technicians,dateInterval,fromDate,toDate){
	
	var obj= {};
	var parameterData1="domains="+domains+"&areas="+areas+"+&teams="+teams+"&technicians="+technicians+"&workOrderType="+workOrderType;
		obj.url=contextPath+"/std/AnalyzeWorkOrderTeamData.action";
		
		if(dateInterval=='custominterval')	{
			obj.pdata = parameterData1+"&loadFromDate="+fromDate+"&loadToDate="+toDate;// post variable data
		}
		else {
			obj.pdata =parameterData1+"&dateInterval="+dateInterval;		
		}
		obj.successfunc = populateTeamAnalysisData;
		run_ajax_json(obj);
}

//populating technician table data
function populateTechAnalysisData(data)
{
	data = eval(data);
	drawTechnicianFusionChart(data.xmlData,'block-technician-analysis-chart');
	populateTechnicianAnalysisTableData(data.efficiencyList, "#block-technician-analysis-table");
	
}
//populating team table data
function populateTeamAnalysisData(data)
{
	data = eval(data);
	drawTeamFusionChart(data.xmlData,'block-team-analysis-chart');
	populateTeamAnalysisTableData(data.efficiencyList, "#block-team-analysis-table");
}


//Draw fusion chart for the given data for the renderName 
function drawTechnicianFusionChart(data, renderName){
	if(FusionCharts("techniciantypechart")){
	    FusionCharts("techniciantypechart").dispose();
	}
	var	fusionChart = new FusionCharts(contextPath
			+ "/js/fusionchartsxt/charts/StackedBar2D.swf",
			"techniciantypechart", "630", "606");	
	fusionChart.setDataXML(data);
	fusionChart.render(renderName);
}

//Draw fusion chart for the given data for the renderName 
function drawTeamFusionChart(data, renderName){
	
	if(FusionCharts("teamtypechart")){
	    FusionCharts("teamtypechart").dispose();
	}
	var	fusionChart = new FusionCharts(contextPath
			+ "/js/fusionchartsxt/charts/StackedBar2D.swf",
			"teamtypechart", "630", "606");	
	fusionChart.setDataXML(data);
	fusionChart.render(renderName);
}

function setTechnicianAnalysisGridData(analysisGridData){
	var griddata = eval('['+analysisGridData+']');	
	technicianAnalysisGrid.clearAll();	
	technicianAnalysisGrid.parse(griddata,"jsarray");
}

function setTeamAnalysisGridData(analysisGridData){
	var griddata = eval('['+analysisGridData+']');	
	teamAnalysisGrid.clearAll();	
	teamAnalysisGrid.parse(griddata,"jsarray");
}


function populateTechnicianAnalysisTableData(tableDataList,tableDataId) {
var techniciananalysisdata="";
	
	if (tableDataList != null) {
		
		var currentLength = tableDataList.length;
		var statusClass = 'good';
		
		//var tableBodyId = block-technician-analysis-table"
		for ( var i = 0; i < currentLength; i++) {
			
			var tableDataDetail = tableDataList[i];
			
				
				tableDataDetail.firstName = validateNullPointer(tableDataDetail.firstName);
				tableDataDetail.lastName = validateNullPointer(tableDataDetail.lastName);			
				tableDataDetail.expectedWorkingTime = validateNullPointer(tableDataDetail.expectedWorkingTime);
				tableDataDetail.actualWorkingTime = validateNullPointer(tableDataDetail.actualWorkingTime);
				tableDataDetail.travelTime = validateNullPointer(tableDataDetail.travelTime);
				tableDataDetail.travelDistance = validateNullPointer(tableDataDetail.travelDistance);
				tableDataDetail.outcome = validateNullPointer(tableDataDetail.outcome);
			
			if (tableDataDetail.outcome >= 0) {
				statusClass = "good";
			} else {
				statusClass = "bad";
			} 
		
		
		if(techniciananalysisdata == ""){
			techniciananalysisdata= "['"+tableDataDetail.firstName+" "+tableDataDetail.lastName+"','"+tableDataDetail.expWorkTime+"','"+tableDataDetail.actWorkTime+"','"+tableDataDetail.travTime+"','"+tableDataDetail.outcome+"','"+tableDataDetail.travelDistance+"']";
		}
		else{					
			techniciananalysisdata= techniciananalysisdata + ",['"+tableDataDetail.firstName+" "+tableDataDetail.lastName+"','"+tableDataDetail.expWorkTime+"','"+tableDataDetail.actWorkTime+"','"+tableDataDetail.travTime+"','"+tableDataDetail.outcome+"','"+tableDataDetail.travelDistance+"']";
		}		
			
		var trClass = '';
		if(tableDataDetail.firstName == "Average"  )	{
			trClass = 	'table-line line-average';	
			$(tableDataId).append(			
					"<tr class='"+trClass+"'>" +"<td>"
							+ tableDataDetail.firstName+" "+tableDataDetail.lastName +" </td><td>"
							+ tableDataDetail.expWorkTime + "</td><td>"
							+ tableDataDetail.actWorkTime + "</td><td>"
							+ tableDataDetail.travTime + "</td><td>"
							+ tableDataDetail.outcome + "</td><td>"
							+ tableDataDetail.travelDistance + "</td>"								
							+"</tr>");
			
		}
		else
		{			
			if (i == 0 || i % 2 == 0) {
				trClass = 'table-line line-grey';
			} else {
				trClass = 'table-line';
			}
			$(tableDataId).append(			
					"<tr class='"+trClass+"'>" +"<td>"
							+ tableDataDetail.firstName+" "+tableDataDetail.lastName +" </td><td>"
							+ tableDataDetail.expWorkTime + "</td><td>"
							+ tableDataDetail.actWorkTime + "</td><td>"
							+ tableDataDetail.travTime + "</td><td>"
							+ tableDataDetail.outcome + "</td><td>"
							+ tableDataDetail.travelDistance + "</td>"								
							+"</tr>");
		}
		
	 }
   }
	initTechnicianAnalysisGrid();	
   setTechnicianAnalysisGridData(techniciananalysisdata);
}



function populateTeamAnalysisTableData(tableDataList,tableDataId) {
var teamanalysisdata="";
	
	if (tableDataList != null) {
		
		var currentLength = tableDataList.length;
		var statusClass = 'good';
		
		//var tableBodyId = block-technician-analysis-table"
		for ( var i = 0; i < currentLength; i++) {
			
			var tableDataDetail = tableDataList[i];
			
				
				tableDataDetail.teamName = validateNullPointer(tableDataDetail.teamName);				
				tableDataDetail.expectedWorkingTime = validateNullPointer(tableDataDetail.expectedWorkingTime);
				tableDataDetail.actualWorkingTime = validateNullPointer(tableDataDetail.actualWorkingTime);
				tableDataDetail.travelTime = validateNullPointer(tableDataDetail.travelTime);
				tableDataDetail.travelDistance = validateNullPointer(tableDataDetail.travelDistance);
				tableDataDetail.outcome = validateNullPointer(tableDataDetail.outcome);
			
			if (tableDataDetail.outcome >= 0) {
				statusClass = "good";
			} else {
				statusClass = "bad";
			} 
		
		
		if(teamanalysisdata == ""){
			teamanalysisdata= "['"+tableDataDetail.teamName+"','"+tableDataDetail.expWorkTime+"','"+tableDataDetail.actWorkTime+"','"+tableDataDetail.travTime+"','"+tableDataDetail.outcome+"','"+tableDataDetail.travelDistance+"']";
		}
		else{					
			teamanalysisdata= teamanalysisdata + ",['"+tableDataDetail.teamName+"','"+tableDataDetail.expWorkTime+"','"+tableDataDetail.actWorkTime+"','"+tableDataDetail.travTime+"','"+tableDataDetail.outcome+"','"+tableDataDetail.travelDistance+"']";
		}		
			
		var trClass = '';
		if(tableDataDetail.teamName == "Average"  )	{
			trClass = 	'table-line line-average';	
			$(tableDataId).append(			
					"<tr class='"+trClass+"'>" +"<td>"
							+ tableDataDetail.teamName +" </td><td>"
							+ tableDataDetail.expWorkTime + "</td><td>"
							+ tableDataDetail.actWorkTime + "</td><td>"
							+ tableDataDetail.travTime + "</td><td>"
							+ tableDataDetail.outcome + "</td><td>"
							+ tableDataDetail.travelDistance + "</td>"								
							+"</tr>");
			
		}
		else
		{			
			if (i == 0 || i % 2 == 0) {
				trClass = 'table-line line-grey';
			} else {
				trClass = 'table-line';
			}
			$(tableDataId).append(			
					"<tr class='"+trClass+"'>" +"<td>"
							+ tableDataDetail.teamName +" </td><td>"
							+ tableDataDetail.expWorkTime + "</td><td>"
							+ tableDataDetail.actWorkTime + "</td><td>"
							+ tableDataDetail.travTime + "</td><td>"
							+ tableDataDetail.outcome + "</td><td>"
							+ tableDataDetail.travelDistance + "</td>"								
							+"</tr>");
		}
		
	 }
   }
	initTeamAnalysisGrid();	
   setTeamAnalysisGridData(teamanalysisdata);
}

/* Code for pdf generation for table data and chart  starts*/
function exportTechnicianAsPDF() {		
	saveTechnicianChart("techniciantypechart");
	
}

function exportTeamAsPDF() {		
	saveTeamChart("teamtypechart");
	
}

 	
function saveTechnicianChart(id) {
	var chartObject = getChartFromId(id);
	if( chartObject.hasRendered() ) 
		chartObject.exportChart();		
	return;
}

function saveTeamChart(id) {
	var chartObject = getChartFromId(id);
	if( chartObject.hasRendered() ) 
		chartObject.exportChart();		
	return;
}


function exportTechinicanEfficiencyAnalysisCallbackFn(exportResult) {	

	var exportImgNames="";
var exportSummaryImgName="";
//var docUrl = (document.URL).replace("/cgi1/GroupReports", "/images/");
var docUrl = (document.URL).replace("/std/ViewAnalyzeWorkOrder", "/images/");

	
		exportSummaryImgName = exportResult.fileName;
		exportSummaryImgName = exportSummaryImgName.replace(new RegExp(docUrl,"g"),"");
		
		
		if(exportSummaryImgName!="") {
			exportImgNames = exportSummaryImgName ;		
			//alert(exportImgNames);
			document.getElementById('imgfilenames').value=exportImgNames;
			/*analysisGrid.toExcel(contextPath+'/std/DownloadPDF.action','analysisGrid','color','HEADER');*/
			technicianAnalysisGrid.toExcel(contextPath+'/std/DownloadPDF.action','Technician Analysis PDF','color','HEADER');
		}
	
}

function exportTeamEfficiencyAnalysisCallbackFn(exportResult) {	

	var exportImgNames="";
var exportSummaryImgName="";
//var docUrl = (document.URL).replace("/cgi1/GroupReports", "/images/");
var docUrl = (document.URL).replace("/std/ViewAnalyzeWorkOrder", "/images/");

	
		exportSummaryImgName = exportResult.fileName;
		exportSummaryImgName = exportSummaryImgName.replace(new RegExp(docUrl,"g"),"");
		
		
		if(exportSummaryImgName!="") {
			exportImgNames = exportSummaryImgName ;		
			//alert(exportImgNames);
			document.getElementById('imgfilenames').value=exportImgNames;
			/*analysisGrid.toExcel(contextPath+'/std/DownloadPDF.action','analysisGrid','color','HEADER');*/
			teamAnalysisGrid.toExcel(contextPath+'/std/DownloadPDF.action','Teamk Analysis PDF','color','HEADER');
		}
	
}
/* Code for pdf generation for table data and chart  ends*/


//Setting empty value for null or undefined variables 
function validateNullPointer(value){
	if (value == null || 'undefined' == typeof (value)) {
		return (value = "");
	}
	return value;
}



//Validate the inputs for Field work efficiency
function validateFieldWorkEfficiency() {
	
	if(!validateMultiSelectBox("#filter-select-date-interval",i18nerrorPleaseselectdateinterval)){
		return false;
	}
	
	if ($("#filter-select-date-interval").val() == "custominterval") {
		
		if(!validateMultiSelectBox("#filter-date-from",i18nerrorPleaseselectfromdate)){
			return false;
		}
		
		if(!validateMultiSelectBox("#filter-date-to",i18nerrorPleaseselecttodate)){
			return false;
		}
		
		if(new Date($("#filter-date-from").val()) > new Date($("#filter-date-to").val())){
			alert(i18nerrorFromDateOlderThanToDate);
			return false;
		}
	}
	
	if(!validateMultiSelectBox("#filter-multiselect-domain",i18nerrorPleaseselectdomain)){
		return false;
	}
	
	if(!validateMultiSelectBox("#filter-multiselect-area",i18nerrorPleaseselectarea)){
		return false;
	}
	
	if(!validateMultiSelectBox("#filter-multiselect-team",i18nerrorPleaseselectteam)){
		return false;
	}
	
	if(!validateMultiSelectBox("#filter-multiselect-technician",i18nerrorPleaseselecttechnician)){
		return false;
	}
	
	return true;

}
//Common method for validating the inputs
function validateMultiSelectBox(selectName,errorMessage){
	if($(selectName).val() == null || $(selectName).val() == ""){
		alert(errorMessage);
		return false;
	}	
	return true;
}

function errorAutoFill(data) {
	alert("Error : " + data.responseText);
}


