var contextPath;
var refreshInterval=1;

function startDashboard() {	
	getServerStats();
	
	getExportStatistics();
	getImportStatistics();
	getNoOfWOSent2PDA();
	getUserStatistics();	
	getErrorStatistics();
	
	
	startUpdateDashboard();
	//testImportStatistics("");
	//testExportStatistics("");
}

function startUpdateDashboard() {
	setInterval('updateServerStats()',refreshInterval*60000);
	setInterval('updateExportStatistics()',refreshInterval*60000);
	setInterval('updateImportStatistics()',refreshInterval*60000);
	setInterval('getNoOfWOSent2PDA()',refreshInterval*60000);
	setInterval('updateUserStatistics()',refreshInterval*60000);
	setInterval('updateErrorStatistics()',refreshInterval*60000);
}


/** 
 * Dashboard Column 1 Start
 */

function getServerStats() {
	var obj = {};
	obj.url = contextPath + "/std/ServerStats.action";	
	obj.successfunc = populateServerStats;
	obj.errorfunc = errorServerData;
	run_ajax_json(obj);
	return;
}

function populateServerStats(sysDashboardData) {
	
	populateImpServerStats(sysDashboardData);
	populateExpServerStats(sysDashboardData);
	populateTransServerStats(sysDashboardData);
	
}



function updateServerStats() {
	
	var obj = {};
	obj.url = contextPath + "/std/ServerStats.action";	
	obj.successfunc = updateServerStatsDashboard;
	obj.errorfunc = errorServerData;
	run_ajax_json(obj);
	return;
}

function updateServerStatsDashboard(sysDashboardData) {
	
	FusionCharts("impSvrCPUChartId").dispose();
	FusionCharts("impSvrThreadsChartId").dispose();
	FusionCharts("expSvrCPUChartId").dispose();
	FusionCharts("expSvrThreadsChartId").dispose();
	FusionCharts("trnsSvrCPUChartId").dispose();
	populateImpServerStats(sysDashboardData);
	populateExpServerStats(sysDashboardData);
	populateTransServerStats(sysDashboardData);
	
}


//Import Server stats start
//for chart
var impSvrCPUChart;
var impSvrThreadsChart;


function getImpServerStatData() {
	var obj = {};
	obj.url = contextPath + "/std/MeasurepointChart.action";
	obj.pdata = "id=" + mepId;
	obj.successfunc = populateServerStats;
	obj.errorfunc = errorServerData;
	run_ajax(obj);
	return;
}
 
function populateImpServerStats(sysDashboardData) {
		
	drawImportServerChart(sysDashboardData.impSvrCPU);
	updateImportServerMemory(sysDashboardData.impSvrMemory);
	drawImportServerThreadChart(sysDashboardData.impSvrThreadXML);
	
}

//draws the imports server cpu chart
function drawImportServerChart(data) {
	impSvrCPUChart = new FusionCharts(contextPath+"/js/fusionwidgetsxt/charts/AngularGauge.swf", "impSvrCPUChartId","100%", "100%");	
	impSvrCPUChart.setDataXML(data);
	impSvrCPUChart.setTransparent(true);
	impSvrCPUChart.render("import-servers-cpu");

}

//draws the imports server threads chart 
function drawImportServerThreadChart(data) {
	
	impSvrThreadsChart = new FusionCharts(contextPath+"/js/fusionwidgetsxt/charts/RealTimeStackedColumn.swf", "impSvrThreadsChartId","100%", "100%");
	//data="<chart labelDisplay='STAGGER' showRealTimeValue='0' plotGradientColor=' ' showBorder='0' numDivlines='0' showYAxisValues='0' caption='' showLabels='1' showvalues='0' numberPrefix='' showSum='0' decimals='0' useRoundEdges='0' legendBorderAlpha='0' legendShadow='0' legendNumColumns='2' legendBgColor='FFFFFF' legendBorderColor='FFFFFF' legendPosition='Bottom' canvasBgColor='FFFFFF'  canvasBgAlpha='0' canvasBorderColor='FFFFFF' canvasBorderThickness='0' canvasBorderAlpha='0' bgColor='FFFFFF' outCnvBaseFontColor='666666' showPlotBorder='0' showAlternateVGridColor='1' AlternateVGridColor='FFFFFF' divLineColor='FFFFFF' vdivLineColor='E9E9E9'><categories><category label='IMPORT_SERVER_DEFAULT' /></categories><dataset seriesName='Available' color='CCCCCC' ><set value='20' showValue='1'/> </dataset><dataset seriesName='In Progress' color='8BBA00' ><set value='9' showValue='1'/> </dataset><dataset seriesName='Waiting' color='AFD8F8' ><set value='4' showValue='1'/> </dataset><dataset seriesName='Scheduled' color='FF9933' ><set value='5' showValue='1'/> </dataset><styles><definition><style name='dataplot_width' width='120px'/></definition> <application><apply toObject='DATAPLOT' styles='dataplot_width' /></application></styles></chart>";
	impSvrThreadsChart.setDataXML(data);
	impSvrThreadsChart.setTransparent(true);
	impSvrThreadsChart.render("import-servers-import-threads");

}


//fills the imports server memory data
function updateImportServerMemory(data) {	
	
	$('#import-servers-memory').html(data+' Gb');
}

//Export Server stats start


//Import Server stats start
//for chart
var expSvrCPUChart;
var expSvrThreadsChart;

function getExpServerStatData() {
	var obj = {};
	obj.url = contextPath + "/std/MeasurepointChart.action";
	obj.pdata = "id=" + mepId;
	obj.successfunc = populateExpServerStats;
	obj.errorfunc = errorServerData;
	run_ajax(obj);
	return;
}

function populateExpServerStats(sysDashboardData) {	
	
	drawExportServerChart(sysDashboardData.expSvrCPU);
	updateExportServerMemory(sysDashboardData.expSvrMemory);
	drawExportServerThreadChart(sysDashboardData.expSvrThreadXML);
}

//draws the export server cpu chart
function drawExportServerChart(data) {
	expSvrCPUChart = new FusionCharts(contextPath+"/js/fusionwidgetsxt/charts/AngularGauge.swf", "expSvrCPUChartId","100%", "100%");
	expSvrCPUChart.setDataXML(data);
	expSvrCPUChart.setTransparent(true);
	expSvrCPUChart.render("export-servers-cpu");
}

//draws the export server threads chart 
function drawExportServerThreadChart(data) {
	
	expSvrThreadsChart = new FusionCharts(contextPath+"/js/fusionwidgetsxt/charts/RealTimeStackedColumn.swf", "expSvrThreadsChartId","100%", "100%");
	//data="<chart labelDisplay='STAGGER' showRealTimeValue='0' plotGradientColor=' ' showBorder='0' numDivlines='0' showYAxisValues='0' caption='' showLabels='1' showvalues='0' numberPrefix='' showSum='0' decimals='0' useRoundEdges='0' legendBorderAlpha='0' legendShadow='0' legendNumColumns='2' legendBgColor='FFFFFF' legendBorderColor='FFFFFF' legendPosition='Bottom' canvasBgColor='FFFFFF'  canvasBgAlpha='0' canvasBorderColor='FFFFFF' canvasBorderThickness='0' canvasBorderAlpha='0' bgColor='FFFFFF' outCnvBaseFontColor='666666' showPlotBorder='0' showAlternateVGridColor='1' AlternateVGridColor='FFFFFF' divLineColor='FFFFFF' vdivLineColor='E9E9E9'><categories><category label='IMPORT_SERVER_DEFAULT' /></categories><dataset seriesName='Available' color='CCCCCC' ><set value='20' showValue='1'/> </dataset><dataset seriesName='In Progress' color='8BBA00' ><set value='9' showValue='1'/> </dataset><dataset seriesName='Waiting' color='AFD8F8' ><set value='4' showValue='1'/> </dataset><dataset seriesName='Scheduled' color='FF9933' ><set value='5' showValue='1'/> </dataset><styles><definition><style name='dataplot_width' width='120px'/></definition> <application><apply toObject='DATAPLOT' styles='dataplot_width' /></application></styles></chart>";
	expSvrThreadsChart.setDataXML(data);
	expSvrThreadsChart.setTransparent(true);
	expSvrThreadsChart.render("export-servers-export-threads");

}


//fills the export server memory data
function updateExportServerMemory(data) {	
	
	$('#export-servers-memory').html(data+' Gb');
}
//Export Server stats end


//draws the export server cpu chart
function populateTransServerStats(sysDashboardData) {
	
	drawTrnsServerChart(sysDashboardData.trnsSvrCPU);
	updateTrnsServerMemory(sysDashboardData.trnsSvrMemory);
	
}

var trnsSvrCPUChart;
function drawTrnsServerChart(data) {
	
	trnsSvrCPUChart = new FusionCharts(contextPath+"/js/fusionwidgetsxt/charts/AngularGauge.swf", "trnsSvrCPUChartId","180","113");
	trnsSvrCPUChart.setDataXML(data);
	trnsSvrCPUChart.setTransparent(true);
	trnsSvrCPUChart.render("transaction-servers-cpu");

}

//fills the export server memory data
function updateTrnsServerMemory(data) {	
	
	$('#transaction-servers-memory').html(data+' Gb');
}

function errorServerData() {
	
}

/** 
 * Dashboard Column 1 End
 */



/**
 * Import Statistics : Dashboard Column 2 Row 1 Start
 */
function getExportStatistics() {
	var obj = {};
	obj.url = contextPath + "/std/MessageNFileStats.action?isImportStat=false";	
	obj.successfunc = populateExportStatistics;
	obj.errorfunc = errorServerData;
	run_ajax_json(obj);
	return;
}

function updateExportStatistics() {
	var obj = {};
	obj.url = contextPath + "/std/MessageNFileStats.action?isImportStat=false";	
	obj.successfunc = populateExportStatisticsUpdate;
	obj.errorfunc = errorServerData;
	run_ajax_json(obj);
	return;
}

function populateExportStatistics(sysDashboardData) {
	
	sysDashboardData = eval(sysDashboardData);
	drawExportFilesstatChart(sysDashboardData.expFileStatusXML);	
	drawExportMsgsstatChart(sysDashboardData.expMsgStatusXML);
	updateNoFilestExp(sysDashboardData.noOfFilesExp);
	updateNoBytesExp(sysDashboardData.noOfBytesExp);
	updateNoExMsgsRecvd(sysDashboardData.noOfExpMsgRec);
	populateExFilesDetails(sysDashboardData.expFileDetails);
}

function populateExportStatisticsUpdate(sysDashboardData) {
	
	FusionCharts("expFilesChartId").dispose();
	FusionCharts("expMsgsChartId").dispose();
	
	sysDashboardData = eval(sysDashboardData);
	drawExportFilesstatChart(sysDashboardData.expFileStatusXML);	
	drawExportMsgsstatChart(sysDashboardData.expMsgStatusXML);
	updateNoFilestExp(sysDashboardData.noOfFilesExp);
	updateNoBytesExp(sysDashboardData.noOfBytesExp);
	updateNoExMsgsRecvd(sysDashboardData.noOfExpMsgRec);
	populateExFilesDetails(sysDashboardData.expFileDetails);
}

function testExportStatistics(sysDashboardData) {	
	testdata= "<chart minimiseWrappingInLegend='0' legendBorderAlpha='0' legendShadow='0' legendNumColumns='2' legendBgColor='FFFFFF' legendBorderColor='FFFFFF' bgColor='FFFFFF' enableSmartLabels='1' manageLabelOverflow='1' showPercentInToolTip='0' plotBorderColor='FFFFFF' showBorder='0' showlabels='1' showValues='1' showLegend='0' legendPosition='bottom'>" +
	"<set value='673' label='Manual Import Parsed' color=''/>" +
	"<set value='897' label='Import started' color=''/>" +
	"<set value='122' label='Import Parsed' color=''/>" +
	"<set value='378' label='Import Error' color=''/>" +
	"<set value='545' label='Import Message Error' color=''/>" +
	"</chart>";
	drawExportFilesstatChart(testdata);	
	testdata= "<chart minimiseWrappingInLegend='0' legendBorderAlpha='0' legendShadow='0' legendNumColumns='2' legendBgColor='F4F4F4' legendBorderColor='CCCCCC' bgColor='F4F4F4' enableSmartLabels='1' manageLabelOverflow='1'  showPercentInToolTip='0' bgAlpha='100' plotBorderColor='F4F4F4' showBorder='0' showlabels='1' showValues='1' showLegend='0' legendPosition='bottom'>" +
	"<set value='673' label='Manual Import Parsed' color=''/>" +
	"<set value='897' label='Import started' color=''/>" +
	"<set value='122' label='Import Parsed' color=''/>" +
	"<set value='378' label='Import Error' color=''/>" +
	"<set value='545' label='Import Message Error' color=''/>" +
	"</chart>";
	drawExportMsgsstatChart(testdata);
	updateNoFilestExp("281");
	updateNoBytesExp("502");
	updateNoExMsgsRecvd("111");
	
	sysDashboardData = {"caseList":[{"id":"11","timeStamp":"2013-03-02 20:09","fileType":"FILE TYPE1","fileSize":"11","recCount":"12","status":"IMPORT ERROR"},{"id":"11","timeStamp":"2013-03-02 20:09","fileType":"FILE TYPE1","fileSize":"11","recCount":"12","status":"Manual Import Parsed"},{"id":"11","timeStamp":"2013-03-02 20:09","fileType":"FILE TYPE1","fileSize":"11","recCount":"12","status":"IMPORT ERROR"}],"mepList":[]};
	sysDashboardData = eval(sysDashboardData);
	//alert(sysDashboardData.caseList);
	
	populateExFilesDetails(sysDashboardData.caseList);
	
}


var expFilesChart;
var expMsgsChart;
function drawExportFilesstatChart(data) {
	
	expFilesChart = new FusionCharts(contextPath+"/js/fusionchartsxt/charts/Doughnut2D.swf", "expFilesChartId","100%","100%");
	expFilesChart.setDataXML(data);
	expFilesChart.render("export-statistics-files");	
	
	
}

function drawExportMsgsstatChart(data) {
	
	expMsgsChart = new FusionCharts(contextPath+"/js/fusionchartsxt/charts/Doughnut2D.swf", "expMsgsChartId","100%","100%");
	expMsgsChart.setDataXML(data);
	expMsgsChart.render("export-statistics-messages");
}

function updateNoFilestExp(data) {
	$('#export-statistics-files-exported').html(data);
}

function updateNoBytesExp(data) {
	$('#export-statistics-data-exported').html(data+' Mb');
}

function updateNoExMsgsRecvd(data) {
	$('#export-statistics-messages-sent').html(data);
}

function populateExFilesDetails(expFileData) {
	
	
	/**
	 * 								
	 *  <tr>
			<td>2</td>
			<td>2013-03-02 20:09</td>
			<td>File type #2</td>
			<td class="error">Import parse error</td>
			<td>32 kb</td>
			<td>7</td>
		</tr>
		
		.append("SELECT top 5 f.id, format(f.receive_timestamp,'yyyy-MM-dd hh:mm') timeStamp,"
		+ " (SELECT [name] FROM file_t WHERE id = f.id_file_t) fileType,"
		+ " (SELECT [name] FROM file_status_t WHERE id = f.id_file_status_t) status,"
	 */
	if(expFileData != null) {

		var currentexpFileLength = expFileData.length;	
		
		//$("export-statistics-table").empty();
		//$('#export-statistics-table tbody').empty();
		$('#export-statistics-table tr').not(function(){if ($(this).has('th').length){return true;}}).remove();
		if(currentexpFileLength > 0) {			
					
			var trString = new StringBuffer();
			for(var i=0; i<currentexpFileLength; i++) {				
				var statusClass='';				
				 
				var expFileDetail = expFileData[i];
				 if((expFileDetail.status).toLowerCase().indexOf("error")==-1) {
					 statusClass="ok";
				 } else {
					 statusClass="error";
				 }
				 
				 trString.append("<tr>");				
				 if(expFileDetail.id != null) {
					 trString.append("<td>"+expFileDetail.id+"</td>");	 
				 } else {
					 trString.append("<td></td>");
				 }
				 if(expFileDetail.timeStamp != null) {
					 trString.append("<td>"+expFileDetail.timeStamp+"</td>");	 
				 } else {
					 trString.append("<td></td>");
				 }
				 if(expFileDetail.fileType != null) {
					 trString.append("<td>"+expFileDetail.fileType+"</td>");	 
				 } else {
					 trString.append("<td></td>");
				 }
				 if(expFileDetail.status != null) {
					 trString.append("<td class='"+statusClass+"'>"+expFileDetail.status+"</td>");	 
				 } else {
					 trString.append("<td></td>");
				 }
				 
				 trString.append("</tr>");						 
				
			}
			$("#export-statistics-table > tbody").append(trString.toString());	
		
		} 
	}
	
}

/**
 * Export Statistics : Dashboard Column 2 Row 1 End
 */

/**
 * Import Statistics : Dashboard Column 2 Row 1 Start
 */
function getImportStatistics() {
	var obj = {};
	obj.url = contextPath + "/std/MessageNFileStats.action?isImportStat=true";	
	obj.successfunc = populateImportStatistics;
	obj.errorfunc = errorServerData;
	run_ajax_json(obj);
	return;
}

function updateImportStatistics() {
	var obj = {};
	obj.url = contextPath + "/std/MessageNFileStats.action?isImportStat=true";	
	obj.successfunc = populateImportStatisticsUpdate;
	obj.errorfunc = errorServerData;
	run_ajax_json(obj);
	return;
}

function populateImportStatistics(sysDashboardData) {	
	
	sysDashboardData = eval(sysDashboardData);
	drawImportFilesstatChart(sysDashboardData.impFileStatusXML);	
	drawImportMsgsstatChart(sysDashboardData.impMsgStatusXML);
	updateNoFilestImp(sysDashboardData.noOfFilesImp);
	updateNoBytesImp(sysDashboardData.noOfBytesImp);
	updateNoMsgsRecvd(sysDashboardData.noOfImpMsgRec);
	populateFilesDetails(sysDashboardData.impFileDetails);
}

function populateImportStatisticsUpdate(sysDashboardData) {	
	
	
	FusionCharts("impFilesChartId").dispose();
	FusionCharts("impMsgsChartId").dispose();
	
	sysDashboardData = eval(sysDashboardData);
	drawImportFilesstatChart(sysDashboardData.impFileStatusXML);	
	drawImportMsgsstatChart(sysDashboardData.impMsgStatusXML);
	updateNoFilestImp(sysDashboardData.noOfFilesImp);
	updateNoBytesImp(sysDashboardData.noOfBytesImp);
	updateNoMsgsRecvd(sysDashboardData.noOfImpMsgRec);
	populateFilesDetails(sysDashboardData.impFileDetails);
}

function testImportStatistics(sysDashboardData) {	
	testdata= "<chart minimiseWrappingInLegend='1' legendScrollBgColor='2E9AFE' legendScrollBtnColor='2E9AFE' legendBorderAlpha='0'" +
			" legendShadow='0' legendNumColumns='2' legendBgColor='FFFFFF' legendBorderColor='FFFFFF' bgColor='FFFFFF' " +
			"enableSmartLabels='0' manageLabelOverflow='1' showPercentInToolTip='0' plotBorderColor='FFFFFF' showBorder='0'" +
			" showlabels='0' showValues='0' showLegend='1' legendIconScale='0.5' legendPosition='right'>" +
	"<set value='673' label='Manual Import Parsed' color=''/>" +
	"<set value='897' label='Import started' color=''/>" +
	"<set value='122' label='Import Parsed' color=''/>" +
	"<set value='378' label='Import Error' color=''/>" +
	"<set value='545' label='Import Message Error' color=''/>" +
	"</chart>";
	drawImportFilesstatChart(testdata);	
	drawImportMsgsstatChart(testdata);
	updateNoFilestImp("281");
	updateNoBytesImp("502");
	updateNoMsgsRecvd("111");
	
	sysDashboardData = {"caseList":[{"id":"11","timeStamp":"2013-03-02 20:09","fileType":"FILE TYPE1","fileSize":"11","recCount":"12","status":"IMPORT ERROR"},{"id":"11","timeStamp":"2013-03-02 20:09","fileType":"FILE TYPE1","fileSize":"11","recCount":"12","status":"Manual Import Parsed"},{"id":"11","timeStamp":"2013-03-02 20:09","fileType":"FILE TYPE1","fileSize":"11","recCount":"12","status":"IMPORT ERROR"},{"id":"11","timeStamp":"2013-03-02 20:09","fileType":"FILE TYPE1","fileSize":"11","recCount":"12","status":"IMPORT ERROR"},{"id":"11","timeStamp":"2013-03-02 20:09","fileType":"FILE TYPE1","fileSize":"11","recCount":"12","status":"IMPORT ERROR"}],"mepList":[]};
	sysDashboardData = eval(sysDashboardData);
	//alert(sysDashboardData.caseList);
	
	populateFilesDetails(sysDashboardData.caseList);
	
}


var impFilesChart;
var impMsgsChart;
function drawImportFilesstatChart(data) {
	
	/*data = "<chart minimiseWrappingInLegend='1' legendIconScale='0.4' legendBorderAlpha='0' legendShadow='0' legendNumColumns='2'" +
			" legendBgColor='FFFFFF' legendBorderColor='FFFFFF' bgColor='FFFFFF' enableSmartLabels='0' manageLabelOverflow='1'" +
			" showPercentInToolTip='0' plotBorderColor='FFFFFF' showBorder='0' skipOverlapLabels='1' showlabels='0' placeValuesInside='1' showValues='1' showLegend='1'" +
			" legendPosition='bottom'>" +
			"<set value='51' label='Import parse error' color=''/>" +
			"<set value='2' label='Import parsed' color=''/>" +
			"<set value='4' label='Import message error' color=''/>" +
			"<set value='289' label='Import done' color=''/>" +
			"<set value='2' label='Manual Import Error' color=''/>" +
			"<styles><definition>" +
			"<style name='myLegendFont' type='font' size='7' bold='0' />" +
			"</definition><application><apply toObject='Legend' styles='myLegendFont' />" +
			"</application></styles>  "+
			"</chart>";*/
	
	impFilesChart = new FusionCharts(contextPath+"/js/fusionchartsxt/charts/Doughnut2D.swf", "impFilesChartId","100%","100%");
	impFilesChart.setDataXML(data);
	impFilesChart.render("import-statistics-files");	
	
	
}

function drawImportMsgsstatChart(data) {
	
	impMsgsChart = new FusionCharts(contextPath+"/js/fusionchartsxt/charts/Doughnut2D.swf", "impMsgsChartId","100%","100%");
	impMsgsChart.setDataXML(data);
	impMsgsChart.render("import-statistics-messages");
}

function updateNoFilestImp(data) {
	$('#import-statistics-files-imported').html(data);
}

function updateNoBytesImp(data) {
	$('#import-statistics-data-imported').html(data+' Mb');
}

function updateNoMsgsRecvd(data) {
	$('#import-statistics-messages-received').html(data);
}

function populateFilesDetails(impFileData) {
	
	
	/**
	 * 								
	 *  <tr>
			<td>2</td>
			<td>2013-03-02 20:09</td>
			<td>File type #2</td>
			<td class="error">Import parse error</td>
			<td>32 kb</td>
			<td>7</td>
		</tr>
	 */
	if(impFileData != null) {

		var currentimpFileLength = impFileData.length;	
		
		//$("import-statistics-table").empty();
		$('#import-statistics-table tr').not(function(){if ($(this).has('th').length){return true;}}).remove();
		//$('#import-statistics-table > tbody > tr').remove();;
		
		if(currentimpFileLength > 0) {			
					
			var trString = new StringBuffer();
			for(var i=0; i<currentimpFileLength; i++) {				
				var statusClass='';				
				 
				var impFileDetail = impFileData[i];
				 if((impFileDetail.status).toLowerCase().indexOf("error")==-1) {
					 statusClass="ok";
				 } else {
					 statusClass="error";
				 }
				 
				 trString.append("<tr>");				
				 if(impFileDetail.id != null) {
					 trString.append("<td>"+impFileDetail.id+"</td>");	 
				 } else {
					 trString.append("<td></td>");
				 }
				 if(impFileDetail.timeStamp != null) {
					 trString.append("<td>"+impFileDetail.timeStamp+"</td>");	 
				 } else {
					 trString.append("<td></td>");
				 }
				 if(impFileDetail.fileType != null) {
					 trString.append("<td>"+impFileDetail.fileType+"</td>");	 
				 } else {
					 trString.append("<td></td>");
				 }
				 if(impFileDetail.status != null) {
					 					 
					 if(impFileDetail.status.search("progress") != -1){
						 fileStatus = "prog"; 
					 }else{
						 slen = impFileDetail.status.length;
						 fileStatus=impFileDetail.status.substring(slen-5,slen);
					 }	 
					// fileStatus=impFileDetail.status.substring(slen-5,slen);
					 trString.append("<td class='"+statusClass+"'>"
							 +fileStatus+"</td>");	 
				 } else {
					 trString.append("<td></td>");
				 }
				 if(impFileDetail.fileSize != null) {
					 trString.append("<td>"+impFileDetail.fileSize+"</td>");	 
				 } else {
					 trString.append("<td></td>");
				 }
				 if(impFileDetail.recordCount != null) {
					 trString.append("<td>"+impFileDetail.recordCount+"</td>");	 
				 } else {
					 //trString.append("<td></td>");
				 }
				 trString.append("</tr>");						 
				
			}			
			$("#import-statistics-table > tbody").append(trString.toString());	
		
		} 
	}
	
}

/**
 * Import Statistics : Dashboard Column 2 Row 1 End
 */

/**
 * PDA Statistics : Dashboard Column 3 Row 3 Start
 */
function getNoOfWOSent2PDA() {
	var obj = {};
	obj.url = contextPath + "/std/NoOfWOsToPDA.action";	
	obj.successfunc = populatePDAStats;
	obj.errorfunc = errorServerData;
	run_ajax_json(obj);
	return;
}

function populatePDAStats(sysDashboardData) {
	
	sysDashboardData = eval(sysDashboardData);
	$('#work-orders-sent-to-pda').html(sysDashboardData.woSentToPda);
	
}
/**
 * PDA Statistics : Dashboard Column 3 Row 3 End
 */

/**
 * User Statistics : Dashboard Column 3 Row 1 Start 
 */
function getUserStatistics() {	
	var obj = {};
	obj.url = contextPath + "/std/UserStats.action";	
	obj.successfunc = populateUserStats;
	obj.errorfunc = errorServerData;
	run_ajax_json(obj);
	return;
}

function updateUserStatistics() {
	
	var obj = {};
	obj.url = contextPath + "/std/UserStats.action";	
	obj.successfunc = updateUserStats;
	obj.errorfunc = errorServerData;
	run_ajax_json(obj);
	return;
	
}

function populateUserStats(sysDashboardData) {
	sysDashboardData = eval(sysDashboardData);
	drawUserStats(sysDashboardData.userStatXML);
	drawLoginStats(sysDashboardData.loginStatXML);	
}

function updateUserStats(sysDashboardData) {
	
	FusionCharts("userStatsChartId").dispose();
	FusionCharts("loginStatsChartId").dispose();
	
	sysDashboardData = eval(sysDashboardData);
	drawUserStats(sysDashboardData.userStatXML);
	drawLoginStats(sysDashboardData.loginStatXML);	
}

var usrStatChart;
var loginStatChart;
function drawUserStats(data) {
	
	usrStatChart = new FusionCharts(contextPath+"/js/fusionchartsxt/charts/StackedBar2D.swf", "userStatsChartId","100%","100%");
	usrStatChart.setDataXML(data);
	usrStatChart.render("users-system");			
}

function drawLoginStats(data) {	

	loginStatChart = new FusionCharts(contextPath+"/js/fusionchartsxt/charts/StackedBar2D.swf", "loginStatsChartId","100%","100%");
	loginStatChart.setDataXML(data);
	loginStatChart.render("users-authentifications-today");			
	
}
/**
 * User Statistics : Dashboard Column 3 Row 1 End 
 */


/**
 * Error Statistics : Dashboard Column 2 Row 1 Start
 */
function getErrorStatistics() {
	var obj = {};
	obj.url = contextPath + "/std/ErrorStats.action";	
	obj.successfunc = populateErrorStatistics;
	obj.errorfunc = errorServerData;
	run_ajax_json(obj);
	return;
}

function updateErrorStatistics() {
	var obj = {};
	obj.url = contextPath + "/std/ErrorStats.action";	
	obj.successfunc = populateErrorStatisticsUpdate;
	obj.errorfunc = errorServerData;
	run_ajax_json(obj);
	return;
}

function populateErrorStatistics(sysDashboardData) {	
	
	sysDashboardData = eval(sysDashboardData);
	drawErrorStatsChart(sysDashboardData.errorStatisticsXML);	
	populateErrorStatDetails(sysDashboardData.errorList);
}

function populateErrorStatisticsUpdate(sysDashboardData) {	
	
	
	FusionCharts("errorStatChartId").dispose();	
	
	sysDashboardData = eval(sysDashboardData);
	drawErrorStatsChart(sysDashboardData.errorStatisticsXML);	
	populateErrorStatDetails(sysDashboardData.errorList);
}

var errorStatChart;

function drawErrorStatsChart(data) {	
	
	
	/*data = "<chart numDivlines='0' showYAxisValues='0' showBorder='0' showLabels='1' showValues='1' showLegend='0'" +
			" canvasBgColor='FFFFFF' canvasBgAlpha='100' canvasBorderColor='FFFFFF' " +
			" canvasBorderThickness='0' canvasBorderAlpha='100' " +
			" plotGradientColor='' bgColor='FFFFFF'>" +
			" <set label='Warning' value='23'/>" +
			" <set label='Medium' value='12' />" +
			" <set label='Severe' value='17' />" +
			" <set label='Fatal' value='14'  />" +
			" <set label='Info' value='12'  />" +
			"</chart>";*/
	errorStatChart = new FusionCharts(contextPath+"/js/fusionchartsxt/charts/Bar2D.swf", "errorStatChartId","100%","100%");
	errorStatChart.setDataXML(data);
	errorStatChart.render("errors-today");	
	
	
}

function populateErrorStatDetails(errorStatDetails) {	
	
	if(errorStatDetails != null) {

		var currentErrorDetailsLength = errorStatDetails.length;			
		
		$('#errors-table tr').not(function(){if ($(this).has('th').length){return true;}}).remove();
				
		if(currentErrorDetailsLength > 0) {			
					
			var trString = new StringBuffer();
			for(var i=0; i<currentErrorDetailsLength; i++) {				
				var statusClass='';				
				 
				var errorDetail = errorStatDetails[i];				
				 
				 trString.append("<tr>");				
				 if(errorDetail.id != null) {
					 trString.append("<td>"+errorDetail.id+"</td>");	 
				 } else {
					 trString.append("<td></td>");
				 }
				 if(errorDetail.createTimestamp != null) {
					 trString.append("<td>"+errorDetail.createTimestamp+"</td>");	 
				 } else {
					 trString.append("<td></td>");
				 }
				 if(errorDetail.criticality != null) {
					 trString.append("<td>"+errorDetail.criticality+"</td>");	 
				 } else {
					 trString.append("<td></td>");
				 }
				 
				 if(errorDetail.source != null) {
					 trString.append("<td>"+errorDetail.source+"</td>");	 
				 } else {
					 trString.append("<td></td>");
				 }
				 if(errorDetail.errorGroup != null) {
					 trString.append("<td>"+errorDetail.errorGroup+"</td>");	 
				 } else {
					 trString.append("<td></td>");
				 }
				 trString.append("</tr>");						 
				
			}			
			$("#errors-table > tbody").append(trString.toString());	
		
		} 
	}
	
}

/**
 * Import Statistics : Dashboard Column 2 Row 1 End
 */


//String Buffer Functions

function StringBuffer() {
	  this.buffer = [];
}

StringBuffer.prototype.append = function append(string) {
	  this.buffer.push(string);
	  return this;
};

StringBuffer.prototype.toString = function toString() {
		return this.buffer.join("");
}; 


