var contextPath;
var i18nerrorPleaseselectdomain;
var i18nerrorPleaseselectarea;
var i18nerrorPleaseselectteam;
var i18nerrorPleaseselecttechnician;
var i18nerrorPleaseselectfromdate;
var i18nerrorPleaseselecttodate;
var i18nerrorPleaseselectdateinterval;
var i18nerrorChartError;
var analysisGrid;

function errorChartData(data) {
	alert(i18nerrorChartError);
}

function loadData()
{
	/* On Page Load disable from and to date controls	 */
	
	/*$("span#fromLabel").hide();
	$("span#toLabel").hide();*/
	
	$("input#filter-date-from").hide();
	$("input#filter-date-to").hide();
	
	loadDomainList();	
	
	
	/*data = "<chart bgImageAlpha='1' bgImage='"+contextPath+"/images/favicon.png' bgImageScale='0' showYAxisValues='0' showXAxisValues='0' bgColor='FFFFFF' numDivLines='0' caption='Working Times Per Work Order Type'  xAxisName='Month' yAxisName='Sales' numberPrefix='$' showValues='1'>" +
			"<categories><category name='Meter Roll Out'/>" +
			"<category name='Concentrator Installation'/>" +
			"<category name='Meter Change'/> " +
			"</categories>" +
			"<dataset seriesName='Expected Working Time' color='#2E9AFE' plotBorderColor='B1D1DC'>" +
			"<set value='27400' />" +
			"<set value='25800' />" +
			"<set value='26800' />" +			
			"</dataset>" +
			"<dataset seriesName='Actual Working Time' color='#FF0000' plotBorderColor='B1D1DC'>" +
			"<set value='21900' />" +
			"<set value='24800' />" +
			"<set value='25800' />" +			
			"</dataset>" +
			"<dataset seriesName='Travel Time' color='#74DF00' plotBorderColor='B1D1DC'>" +
			"<set value='29800' />" +
			"<set value='29800' />" +
			"<set value='28800' />" +			
			"</dataset>" +
			"</chart>";*/
	//drawAnalysisChart("");
}
/** To Populate Domain List*/
function loadDomainList() {	
	var obj= {};
	obj.url=contextPath+"/std/GetDomains.action";
	//alert(obj.url);
	obj.successfunc = function(data) {
		var items;
		$.each(data, function(i, item) {
			items += '<option value="' + item.id + '">'	+ item.name + '</option>';
			});
		$("#filter-multiselect-domain").html(items);
		$("#filter-multiselect-domain").multiselect("refresh");

	};
	obj.errorfunc = errorDetails;
	
	run_ajax_json(obj);
	return;	
}

/** to disable date picker (From and To) when we select the custom date interval*/
function disbaleDateFilter()
{
	var customDateInterval=$("#filter-select-date-interval").val();
	
	//alert(customDateInterval);
	
	if(customDateInterval=="custominterval")
	{
		$("input#filter-date-from").show();
		$("input#filter-date-to").show();	
	/*	$("span#fromLabel").show();
		$("span#toLabel").show();
	*/	
	}
	else
	{
/*		$("span#fromLabel").hide();
		$("span#toLabel").hide();
*/		$("input#filter-date-from").hide();
		$("input#filter-date-to").hide();
	}
}

/** On Domain Select */
function onDomainSelect()
{
	/** On Domain Select populate Areas,Teams*/
	
	var ls_domain = $("#filter-multiselect-domain").val();	
	
	if(ls_domain !=null && ls_domain!="")
	{
		onDomainSelectPopulateAreas(ls_domain);
		onDomainSelectPopulateTeams(ls_domain);
	}
	else{
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

/** Populate Areas*/
function onDomainSelectPopulateAreas(domain)
{
	var url=contextPath+"/std/AnalyzeFieldWorkEfficiencyAreas.action";
	var area_multiselect="filter-multiselect-area";
	onDomainSelectExecute(url,area_multiselect,domain);
}

/** Populate Teams*/
function onDomainSelectPopulateTeams(domain)
{
	var url=contextPath+"/std/AnalyzeFieldWorkEfficiencyTeams.action";
	var team_multiselect="filter-multiselect-team";
	onDomainSelectExecute(url,team_multiselect,domain);
}

/** Generalized function  to Populate Values */
function onDomainSelectExecute(url,multiselect,ls_domain) {	

//alert(ls_domain);
	var obj= {};
	obj.url=url;
	obj.pdata="domainCodes="+ ls_domain;
	obj.successfunc = function(data) {
		var items;
		$.each(data, function(i, item) {
			items += '<option value="' + item.id + '">'	+ item.name + '</option>';
			});
		$("#"+multiselect).html(items);
		$("#"+multiselect).multiselect("refresh");

	};
	obj.errorfunc = errorDetails;
	
	run_ajax_json(obj);
	return;	
}

/** Populate User Teams (Technicians) */
function onTeamSelectPopulateTechnicians()
{
	var ls_team = $("#filter-multiselect-team").val();
	var url=contextPath+"/std/AnalyzeFieldWorkEfficiencyTechnicians.action";
	var team_multiselect="filter-multiselect-technician";
	if(null != ls_team) {
		onTeamSelectExecute(url,team_multiselect,ls_team);
	}
}

/** Generalized function  to Populate Technicians (user team) Values */
function onTeamSelectExecute(url,multiselect,ls_team) {	

//alert(ls_team);
	var obj= {};
	obj.url=url;
	obj.pdata="teamCodes="+ ls_team;
	obj.successfunc = function(data) {
		var items;

		$.each(data, function(i, item) {
			items += '<option value="' + item.id + '">'	+ item.userName + '</option>';
		
			});
		$("#"+multiselect).html(items);
		$("#"+multiselect).multiselect("refresh");

	};
	obj.errorfunc = errorDetails;
	
	run_ajax_json(obj);
	return;	
}

/* Appending Child Divs to show Filter Areas,Teams and Technicians */
function appendChildDivs(multiSelectValues,divClassName, parentDivId )
{
	/*var remDiv = document.getElementById('testElem');
	var parent = remDiv.parentNode;
	parent.removeChild(remDiv);*/
	for ( var i = 0; i < multiSelectValues.options.length; i++) 
	{
		if (multiSelectValues.options[i].selected) 
		{
			appendDynamicChildDiv(divClassName,multiSelectValues.options[i].text,parentDivId);
		}
	}		
}

function appendDynamicChildDiv(divClassName,divText,parentDivId){
    
    var iDiv = document.createElement('div');
    iDiv.className = divClassName;
    iDiv.innerHTML = divText;
    document.getElementById(parentDivId).appendChild(iDiv);
}


function update()
{
	//var obj={};
		
	if(validateFieldWorkEfficiency())
	{/*
		alert("validation is successfull");*/
		
		
		var dateInterval=$("#filter-select-date-interval").val();
		
		var fromDate,toDate;
		
		if(dateInterval=='custominterval')
		{
			fromDate=$("#filter-date-from").val();
			toDate=$("#filter-date-to").val();
		}
		var domains=$("#filter-multiselect-domain").val();
		var areas=$("#filter-multiselect-area").val();
		var teams=$("#filter-multiselect-team").val();
		var technicians=$("#filter-multiselect-technician").val();
		
		//alert("date Interval"+dateInterval);
		//alert("domains"+domains);
		//alert("areas"+areas);
		//alert("teams"+teams);
		//alert("date Interval"+dateInterval);
		//alert("technicians"+technicians);
		
		
		
		//var divId = 'filter-block-areas';
		var divClassName = 'filter-block-content';
		var divTitleClassName='filter-block-title';
		var parentDivId = 'filter-block-areas'; 
		
		/* To clear table and chart*/
		$("#block-work-order-type-analysis-table > tbody").empty();
		$("#block-work-order-type-analysis-chart").empty();
		
		//removeChildDivs(parentDivId);
		document.getElementById(parentDivId).innerHTML = '';
	    appendDynamicChildDiv(divTitleClassName,'Areas:',parentDivId);
		appendChildDivs(document.getElementById('filter-multiselect-area'),divClassName,parentDivId);
		
		parentDivId = "filter-block-teams";		
		document.getElementById(parentDivId).innerHTML = '';
		appendDynamicChildDiv(divTitleClassName,'Teams:',parentDivId);
		appendChildDivs(document.getElementById('filter-multiselect-team'),divClassName,parentDivId);
		
		parentDivId = "filter-block-technicians";
		document.getElementById(parentDivId).innerHTML = '';
		appendDynamicChildDiv(divTitleClassName,'Technicians:',parentDivId);
		appendChildDivs(document.getElementById('filter-multiselect-technician'),divClassName,parentDivId);
		
				
		
		var obj= {};
		var parameterData="domains="+domains+"&areas="+areas+"+&teams="+teams+"&technicians="+technicians;
			obj.url=contextPath+"/std/AnalyzeFieldWorkEfficiencyChart.action";
						
			if(fromDate!=null && toDate!=null)
			{
				obj.pdata = parameterData+"&loadFromDate="+fromDate+"&loadToDate="+toDate;// post variable data
			}
			else
			{
			obj.pdata =parameterData+"&dateInterval="+dateInterval;
			}
			obj.successfunc = populateAnalysisData;
			obj.errorfunc = errorChartData;
			run_ajax_json(obj);
			
			//return;
	}
	else
	{
/*		alert("not success");*/
		/*var url=contextPath+"/jsp/analyze_field_work_efficiency.jsp";
		obj.url=url;
		run_ajax_json(obj);*/
	}
}

function populateAnalysisData(data)
{
/*	alert("populateAnalysisData");*/
	data = eval(data);
	drawAnalysisChart(data.xmlData);
	populateAnalysisTable(data.efficiencyList);
	
}

function populateAnalysisTable(tableDataList) {
			
	/*alert("populate table data starts");*/
	//analysisGridData.clearAll();
	var analysisGridData="";
			if (tableDataList != null) {
				
				var currentLength = tableDataList.length;
						
				for ( var i = 0; i < currentLength; i++) {
					var trClass = '';
					var statusClass = 'good';
					if (i == 0 || i % 2 == 0) {
						trClass = 'table-line line-grey';
					} else {
						trClass = 'table-line';
					}
					var tableDataDetail = tableDataList[i];
					
					if (null == tableDataDetail.workOrderType || 'undefined' == typeof (tableDataDetail.workOrderType)) {
						tableDataDetail.workOrderType = "";
					}
					if (null == tableDataDetail.expectedWorkingTime || 'undefined' == typeof (tableDataDetail.expectedWorkingTime)) {
						tableDataDetail.expectedWorkingTime = "";
					}
					if (null == tableDataDetail.actualWorkingTime || 'undefined' == typeof (tableDataDetail.actualWorkingTime)) {
						tableDataDetail.actualWorkingTime = "";
					}
					if (null == tableDataDetail.travelTime || 'undefined' == typeof (tableDataDetail.travelTime)) {
						tableDataDetail.travelTime = "";
					}
					if (null == tableDataDetail.travelDistance || 'undefined' == typeof (tableDataDetail.travelDistance)) {
						tableDataDetail.travelDistance = "";
					}
					if (null == tableDataDetail.outcome || 'undefined' == typeof (tableDataDetail.outcome)) {
						tableDataDetail.outcome = "";
					}
					/*if (null == tableDataDetail.status || 'undefined' == typeof (tableDataDetail.status)) {
						tableDataDetail.status = "";
					}
					
					if (tableDataDetail.status == "In Progress") {
						statusClass = "info";
					} else if (tableDataDetail.status == "Cancelled") {
						statusClass = "ok";
					} else if (tableDataDetail.status == "Closed") {
						statusClass = "ok";
					} else if (tableDataDetail.status == "Error") {
						statusClass = "error";
					} else if (tableDataDetail.status == "Scheduled") {
						statusClass = "ok";
					}		*/	
					
					if (tableDataDetail.outcome >= 0) {
					statusClass = "good";
				} else if (tableDataDetail.outcome < 0) {
					statusClass = "bad";
				} 
				
				
				if(analysisGridData == ""){
					analysisGridData= "['"+tableDataDetail.workOrderType+"','"+tableDataDetail.expWorkTime+"','"+tableDataDetail.actWorkTime+"','"+tableDataDetail.travTime+"','"+tableDataDetail.outcome+"','"+tableDataDetail.travelDistance+"']";
				}
				else{					
					analysisGridData= analysisGridData + ",['"+tableDataDetail.workOrderType+"','"+tableDataDetail.expWorkTime+"','"+tableDataDetail.actWorkTime+"','"+tableDataDetail.travTime+"','"+tableDataDetail.outcome+"','"+tableDataDetail.travelDistance+"']";
				}		
				
				if(tableDataDetail.workOrderType=="Average")
				{
					//analysisGridData= analysisGridData + ",['"+tableDataDetail.workOrderType+"','"+tableDataDetail.expWorkTime+"','"+tableDataDetail.actWorkTime+"','"+tableDataDetail.travTime+"','"+tableDataDetail.outcome+"','"+tableDataDetail.travelDistance+"']";
					
				$("#block-work-order-type-analysis-table > tbody").append(						
						
						"<tr class='table-line line-average'>" +
						"<td>"
								+ tableDataDetail.workOrderType + "</td><td>"
								+ tableDataDetail.expWorkTime + "</td><td>"
								+ tableDataDetail.actWorkTime + "</td><td>"
								+ tableDataDetail.travTime + "</td><td>"
								+ tableDataDetail.outcome + "</td><td>"
								+ tableDataDetail.travelDistance + "</td>"								
								+"</tr>");
				}
				else
				{
					$("#block-work-order-type-analysis-table > tbody").append(						
							
							"<tr class='" + trClass
									+ "'><td class='text-blue'> <a href='"+contextPath+"/std/ViewAnalyzeWorkOrder.action?workOrderType="+tableDataDetail.workOrderType+"'> "
									+ tableDataDetail.workOrderType + "</a></td><td>"
									+ tableDataDetail.expWorkTime + "</td><td>"
									+ tableDataDetail.actWorkTime + "</td><td>"
									+ tableDataDetail.travTime + "</td><td>"
									+ tableDataDetail.outcome + "</td><td>"
									+ tableDataDetail.travelDistance + "</td>"								
									+"</tr>");		
				}
			}
		}
		
		tableDataList="";
				initAnalysisGrid();
				
	setAnalysisGridData(analysisGridData);
/*	alert("populate table data ends");*/
}

function setAnalysisGridData(analysisGridData){
	var griddata = eval('['+analysisGridData+']');	
	analysisGrid.clearAll();	
	analysisGrid.parse(griddata,"jsarray");
}



function drawAnalysisChart(data)
{
	//FusionCharts("workOrderEfficiencyAnalysisChart").dispose();
	
	if(FusionCharts("workOrderEfficiencyAnalysisChart")){
	    FusionCharts("workOrderEfficiencyAnalysisChart").dispose();
	}


		var	alertChart = new FusionCharts(contextPath
					+ "/js/fusionchartsxt/charts/StackedBar2D.swf",
					"workOrderEfficiencyAnalysisChart", "630", "606");		
		alertChart.setDataXML(data);
		alertChart.render("block-work-order-type-analysis-chart");
	
}


/* Code for pdf generation for table data and chart  starts*/
function exportAsPDF() {		
	saveChart("workOrderEfficiencyAnalysisChart");
	
}

var exportImgNames="";
var exportSummaryImgName="";
//var docUrl = (document.URL).replace("/cgi1/GroupReports", "/images/");
var docUrl = (document.URL).replace("/std/AnalyzeFieldWorkEfficiency", "/images/");


 	
function saveChart(id) {
	var chartObject = getChartFromId(id);
	if( chartObject.hasRendered() ) 
		chartObject.exportChart();		
	return;
}


function exportWorkOrderEfficiencyAnalysisCallbackFn(exportResult) {		
	
	
		exportSummaryImgName = exportResult.fileName;
		exportSummaryImgName = exportSummaryImgName.replace(new RegExp(docUrl,"g"),"");
		
		
		if(exportSummaryImgName!="") {
			exportImgNames = exportSummaryImgName ;		
			//alert(exportImgNames);
			document.getElementById('imgfilenames').value=exportImgNames;
			/*analysisGrid.toExcel(contextPath+'/std/DownloadPDF.action','analysisGrid','color','HEADER');*/
			analysisGrid.toExcel(contextPath+'/std/DownloadPDF.action','Field Work Analysis PDF','color','HEADER');
		}
	
}
/* Code for pdf generation for table data and chart  ends*/

function validateFieldWorkEfficiency()
{
	//alert("Inside validateFieldWorkEfficiency ");

		
	if($("#filter-multiselect-domain").val()==null||$("#filter-multiselect-domain").val()=="" )
	{
		
		alert(i18nerrorPleaseselectdomain);	
		return false;
	}
	
	if($("#filter-multiselect-area").val()=="" || $("#filter-multiselect-area").val()==null)
	{
		alert(i18nerrorPleaseselectarea);	
		return false;
	}
	
	if($("#filter-multiselect-team").val()=="" || $("#filter-multiselect-team").val()==null)
	{
		alert(i18nerrorPleaseselectteam);	
		return false;
	}
	
	if($("#filter-multiselect-technician").val()=="" ||$("#filter-multiselect-technician").val()==null)
	{
		alert(i18nerrorPleaseselecttechnician);	
		return false;
	}
	
	if($("#filter-select-date-interval").val()=="" || $("#filter-select-date-interval").val()==null)
	{
		alert(i18nerrorPleaseselecttechnician);	
		return false;
	}
	
	if($("#filter-select-date-interval").val()=="custominterval")
	{
		if($("#filter-date-from").val()=="" ||$("#filter-date-from").val()==null)
		{
			alert("from date is required");
			return false;
		}
		
		if($("#filter-date-to").val()=="" || $("#filter-date-to").val()==null)
		{
			alert("to date is required");
			return false;
		}

		/*var fromDate=new Date($("#filter-date-from").val());
		var toDate=new Date($("#filter-date-to").val());
		
		if(fromDate > toDate)
		{
			alert("fromdate should not be greater than to date");
			return false;
		}*/
		
	}

	return true;
	
}


function errorDetails(data) {
	alert("Loading Error");
}
