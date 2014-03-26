var mepId;
var contextPath;
var i18nerrorInvalidSearchInput;
var i18nerrorNoDataForSearch;
var i18nerrorMandatoryMessage;
var headingFromDate;
var headingToDate;
var i18to;
var i18jan;
var i18feb;
var i18mar;
var i18apr;
var i18may;
var i18jun;
var i18jul;
var i18aug;
var i18sep;
var i18oct;
var i18nov;
var i18dec;

jQuery(document).ready(function($){
	
	/*
	 * Opening the modal of daily consumption profile
	 */
    $('#block-daily-consumption-profile-charts-options a').click(function() {
    	var left = $('#overlay').width() /2 -140;
    	var top = $('#overlay').height() / 2 - ($('#modal-daily-consumption-profile').height()/2);
    	
    	$('#modal-daily-consumption-profile').css('top',top+'px');
    	$('#modal-daily-consumption-profile').css('left',left+'px');
    	
    	$('#overlay').css('display','block');
    	$('#modal-daily-consumption-profile').css('display','block'); 
    	return false;
    });
    
    
    /*
	 * Closing the modal of daily consumption profile from the top right quit button
	 */
    $('#modal-daily-consumption-profile .button-quit').click(function() {
    	$('#overlay').css('display','none');
    	$('#modal-daily-consumption-profile').css('display','none');
    	return false; 
    });
    
    
    /*
	 * Closing the modal of daily consumption profile from the cancel button
	 */
    $('#modal-daily-consumption-profile-button-cancel').click(function() {
    	$('#overlay').css('display','none');
    	$('#modal-daily-consumption-profile').css('display','none');
    	return false; 
    });
    
    
    /*
	 * Valid chart options daily consumption profile with the Ok button
	 */
    $('#modal-daily-consumption-profile-button-ok').click(function() {
    	
    	return false; 
    });
    
    
    
    /*
	 * Opening the modal of consumption report
	 */
    $('#block-consumption-report-charts-options a').click(function() {
    	var left = $('#overlay').width() /2 -140;
    	var top = $('#overlay').height() / 2 - ($('#modal-consumption-report').height()/2);
    	
    	$('#modal-consumption-report').css('top',top+'px');
    	$('#modal-consumption-report').css('left',left+'px');
    	
    	$('#overlay').css('display','block');
    	$('#modal-consumption-report').css('display','block');
    	return false; 
    });
    
    /*
	 * Closing the modal of consumption report from the top right quit button
	 */
    $('#modal-consumption-report .button-quit').click(function() {
    	$('#overlay').css('display','none');
    	$('#modal-consumption-report').css('display','none');
    	return false; 
    });
    
    
    /*
	 * Closing the modal of consumption report from the cancel button
	 */
    $('#modal-consumption-report-button-cancel').click(function() {
    	$('#overlay').css('display','none');
    	$('#modal-consumption-report').css('display','none');
    	return false; 
    });
    
    
    /*
	 * Valid chart options consumption report with the Ok button
	 */
    $('#modal-consumption-report-button-ok').click(function() {
    	
    	return false; 
    });
    
    
    
    /*
	 * Opening the modal of load profile
	 */
    $('#block-load-profile-charts-options a').click(function() {
    	var left = $('#overlay').width() /2 -140;
    	var top = $('#overlay').height() / 2 - ($('#modal-load-profile').height()/2);
    	
    	$('#modal-load-profile').css('top',top+'px');
    	$('#modal-load-profile').css('left',left+'px');
    	
    	$('#overlay').css('display','block');
    	$('#modal-load-profile').css('display','block');
    	return false; 
    });
    
    /*
	 * Opening the modal of load profile from the top right quit button
	 */
    $('#modal-load-profile .button-quit').click(function() {
    	$('#overlay').css('display','none');
    	$('#modal-load-profile').css('display','none'); 
    	return false;
    });
    
    
    /*
	 * Closing the modal of load profile from the cancel button
	 */
    $('#modal-load-profile-button-cancel').click(function() {
    	$('#overlay').css('display','none');
    	$('#modal-load-profile').css('display','none');
    	return false; 
    });
    
    
    /*
	 * Valid chart options load profile with the Ok button
	 */
    $('#modal-load-profile-button-ok').click(function() {
    	
    	return false; 
    }); 
    
});

function onChangeDateInterval(selectID,fromDate,toDate)	{			
	var selectVal = $('#'+selectID+' :selected').val();	
	if(selectVal == "custominterval"){				
		$('#'+fromDate).removeAttr("disabled");
		$('#'+toDate).removeAttr("disabled");				
	}
	else{
		$('#'+fromDate).val('');
		$('#'+toDate).val('');
		$('#'+fromDate).attr("disabled", "disabled");
		$('#'+toDate).attr("disabled", "disabled");
	}
}

function onLoadDefault(){	
	
	$("#modal-daily-consumption-profile-input-date-from").attr("disabled", "disabled");
	$("#modal-daily-consumption-profile-input-date-to").attr("disabled", "disabled");
	$("#modal-consumption-report-input-date-from").attr("disabled", "disabled");
	$("#modal-consumption-report-input-date-to").attr("disabled", "disabled");			
	$("#modal-load-profile-input-date-from").attr("disabled", "disabled");
	$("#modal-load-profile-input-date-to").attr("disabled", "disabled");		
	//$("#modal-daily-consumption-profile-input-consumption-date").val(currentDate); //getCurrentDate()	
	//updateMepConsumptionProfile();
	updateMepConsumptionReport();
	updateMepConsumptionLoadProfile();
}


function updateMepConsumptionProfile(){		
	var selectedDate = $("#modal-daily-consumption-profile-input-consumption-date").val();	
	$("#block-daily-consumption-profile-charts-title").text(getCurrentDateFormat(selectedDate));	
	$("#block-daily-consumption-profile-charts-period").text(getIntervalDateValue('modal-daily-consumption-profile-select-date-interval'));	
	var urlString = "id=" + mepId;
	if($("#modal-daily-consumption-profile-input-consumption-date").val().length > 0){		
		urlString = urlString + "&consumptionDate="+$("#modal-daily-consumption-profile-input-consumption-date").val();
	}
	else{
		alert(i18nerrorMandatoryMessage);
		return false;
	}
	if($("#modal-daily-consumption-profile-select-date-interval").val().length > 0){		
		urlString = urlString + "&dateInterval="+$("#modal-daily-consumption-profile-select-date-interval").val();
		
		if($("#modal-daily-consumption-profile-select-date-interval").val() == 'custominterval')
		{
			if($("#modal-daily-consumption-profile-input-date-from").val().length > 0){		
				urlString = urlString + "&fromDate="+$("#modal-daily-consumption-profile-input-date-from").val();
			}
			else{
				alert(i18nerrorMandatoryMessage);
				return false;
			}
			
			if($("#modal-daily-consumption-profile-input-date-to").val().length > 0){		
				urlString = urlString + "&toDate="+$("#modal-daily-consumption-profile-input-date-to").val();
			}
			else{
				alert(i18nerrorMandatoryMessage);
				return false;
			}
		}		
	}
	
	if($('input[name=weekdays-radio]:checked').val() != null){		
		urlString = urlString + "&includedWeekDays="+$('input[name=weekdays-radio]:checked').val();
	}	
	var obj = {};
	obj.url = contextPath + "/std/DailyConsumptionProfile.action";
	obj.pdata = urlString;
	obj.successfunc = dailyConsumptionProfileChart;
	obj.errorfunc = errorsearchresults;	;
	run_ajax(obj);
	
	$('#overlay').css('display','none');
	$('#modal-daily-consumption-profile').css('display','none');
	return;
}

var suffix = 0;
var chartname="profilechart";

function dailyConsumptionProfileChart(data) {
	
	/*data = "<chart legendBgColor='E9E9E9' legendBgAlpha='100' legendShadow='0' legendBorderColor='E9E9E9' showCanvasBg='1' canvasBgColor='FFFFFF' " +
			" canvasBorderThickness='0' canvasBorderAlpha='100' canvasBorderColor='81DAF5' showBorder='0'" +
			" showValues='0' limitsDecimalPrecision='2' " +
			" formatNumberScale='0' bgAlpha='100' bgColor='E9E9E9'  areaOverColumns='0' legendIconScale='2'>" +
			"<categories><category name='00:00' /><category name='01:00' /><category name='02:00' /><category name='03:00' />" +
			"<category name='04:00' /><category name='05:00' /><category name='06:00' /><category name='07:00' />" +
			"<category name='08:00' /><category name='09:00' /><category name='10:00' /><category name='11:00' />" +
			"<category name='12:00' /><category name='13:00' /><category name='14:00' /><category name='15:00' />" +
			"<category name='16:00' /><category name='17:00' /><category name='18:00' /><category name='19:00' />" +
			"<category name='20:00' /><category name='21:00' /><category name='22:00' /><category name='23:00' /></categories>" +
			"<dataset seriesname='July 1, 2013' renderAs='Area' color='3399FF'><set value='9.415' /><set value='14.795' />" +
			"<set value='6.725' /><set value='0.0' /><set value='13.45' /><set value='16.14' /><set value='21.52' />" +
			"<set value='5.38' /><set value='14.795' /><set value='12.105' /><set value='16.14' /><set value='17.485' />" +
			"<set value='1.345' /><set value='13.45' /><set value='6.725' /><set value='22.865' /><set value='13.45' />" +
			"<set value='2.69' /><set value='0.0' /><set value='24.21' /><set value='22.865' /><set value='10.76' />" +
			"<set value='24.21' /><set value='22.865' /></dataset>" +
			"<dataset seriesname='Maximum' renderAs = 'Line' color='EA1C1C'><set value='24.21' /><set value='16.14' />" +
			"<set value='18.83' /><set value='20.175' /><set value='22.865' /><set value='20.175' /><set value='12.105' />" +
			"<set value='20.175' /><set value='13.45' /><set value='18.83' /><set value='22.865' /><set value='4.035' />" +
			"<set value='21.52' /><set value='18.83' /><set value='14.795' /><set value='18.83' /><set value='17.485' />" +
			"<set value='20.175' /><set value='22.865' /><set value='17.485' /><set value='24.21' /><set value='14.795' />" +
			"<set value='17.485' /><set value='22.865' />" +
			"</dataset><dataset seriesname='Average' renderAs='Line' color='F77F07'><set value='13.001666' />" +
			"<set value='7.6216664' /><set value='9.863334' /><set value='12.105' /><set value='19.278334' />" +
			"<set value='13.898334' /><set value='9.415' /><set value='17.484999' /><set value='6.725' />" +
			"<set value='16.14' /><set value='15.691666' /><set value='3.5866668' /><set value='15.691667' />" +
			"<set value='13.45' /><set value='10.3116665' /><set value='10.759999' /><set value='9.863334' />" +
			"<set value='13.45' /><set value='9.415' /><set value='10.311667' /><set value='20.623331' />" +
			"<set value='12.553333' /><set value='6.7250004' /><set value='20.175001' />" +
			"</dataset><dataset  seriesname='Minumum' renderAs='Line' color='4EF512'><set value='0.0' /><set value='2.69' />" +
			"<set value='0.0' /><set value='2.69' /><set value='12.105' /><set value='6.725' /><set value='8.07' />" +
			"<set value='13.45' /><set value='0.0' /><set value='12.105' /><set value='6.725' /><set value='2.69' />" +
			"<set value='5.38' /><set value='4.035' /><set value='8.07' /><set value='0.0' /><set value='1.345' />" +
			"<set value='2.69' /><set value='1.345' /><set value='2.69' /><set value='14.795' /><set value='10.76' />" +
			"<set value='0.0' /><set value='17.485' /></dataset></chart>";*/
	
	//alert(data);
	
	var myChart  = new FusionCharts(contextPath+"/js/fusionchartsxt/charts/MSCombi2D.swf", chartname+suffix, "925", "500");
	myChart.setDataXML(data);
	myChart.setTransparent(true);
	myChart.render("block-daily-consumption-profile-charts-view");
	suffix=suffix+1;
}

function updateMepConsumptionReport(){
	
	var urlString = "id=" + mepId;
	
	$("#block-consumption-report-charts-period").text(getIntervalDateValue('modal-consumption-report-select-date-interval'));
	if($("#modal-consumption-report-select-date-interval").val().length > 0){		
		urlString = urlString + "&dateInterval="+$("#modal-consumption-report-select-date-interval").val();
		
		if($("#modal-consumption-report-select-date-interval").val() == 'custominterval'){
			if($("#modal-consumption-report-input-date-from").val().length > 0){		
				urlString = urlString + "&fromDate="+$("#modal-consumption-report-input-date-from").val();
			}
			else{
				alert(i18nerrorMandatoryMessage);
				return false;
			}
			
			if($("#modal-consumption-report-input-date-to").val().length > 0){		
				urlString = urlString + "&toDate="+$("#modal-consumption-report-input-date-to").val();
			}
			else{
				alert(i18nerrorMandatoryMessage);
				return false;
			}
		}
	}
	
	/*if($("#modal-consumption-report-select-groupby").val().length > 0){		
		urlString = urlString + "&groupBy="+$("#modal-consumption-report-select-groupby").val();
	}	*/
	
	var checkboxString = $('input[name=weekdays-checkbox-report]:checked').map(function() {return this.value;}).get().join(',');	
	if(checkboxString != null && checkboxString.length > 0){		
		urlString = urlString + "&includedWeekDays="+checkboxString;
	}
	else{
		alert(i18nerrorMandatoryMessage);
		return false;
	}	
	getReportHeading(urlString);
	var obj = {};
	obj.url = contextPath + "/std/ConsumptionReport.action";
	obj.pdata = urlString;
	obj.successfunc = consumptionReportChart;
	//obj.errorfunc = errorsearchresults;	;
	run_ajax(obj);
	
	$('#overlay').css('display','none');
	$('#modal-consumption-report').css('display','none');
	return;
}

function consumptionReportChart(data) {	
	
	data = eval(data);
	
	$("#totalenergyconsumption").text(data.summaryConsumption.totalEnergy+' Kwh');
	$("#averageconsumption").text(data.summaryConsumption.avgDailyEnergy+' Kwh');
	$("#minimumconsumption").text(data.summaryConsumption.minDailyEnergy+' Kwh ('+data.summaryConsumption.minDailyEnergyDate+')');
	$("#maximumconsumption").text(data.summaryConsumption.maxDailyEnergy+' Kwh ('+data.summaryConsumption.maxDailyEnergyDate+')');
	
	var myChart  = new FusionCharts(contextPath+"/js/fusionchartsxt/charts/MSArea.swf", "reportchart", "925", "500");
	
	/*data = "<chart plotGradientColor=' ' legendBgColor='E9E9E9' legendBgAlpha='100' legendShadow='0' " +
	"legendBorderColor='E9E9E9' showCanvasBg='1' canvasBgColor='FFFFFF'  " +
	"canvasBorderThickness='0' canvasBorderAlpha='100' canvasBorderColor='81DAF5' " +
	"showBorder='0' showValues='0' limitsDecimalPrecision='2'  formatNumberScale='0' " +
	"bgAlpha='100' bgColor='E9E9E9'  areaOverColumns='0' legendIconScale='2'>" +
	"<categories><category name='Mar 2013' /><category name='Jun 2013' /><category name='Jul 2013' /></categories>" +
	"<dataset seriesName='Maximum' alpha='100' color='EA1C1C' showValues='0'><set value='0.0' /><set value='344.32' /><set value='313.385' /></dataset>" +
	"<dataset seriesName='Average' alpha='100' color='F77F07' showValues='0'><set value='0.0' /><set value='291.92' /><set value='294.55' /></dataset>" +
	"<dataset seriesName='Minimum' alpha='100' color='4EF512' showValues='0'><set value='0.0' /><set value='248.89' /><set value='275.77' /></dataset>" +
	"</chart>";
	myChart.setDataXML(data);*/
	myChart.setDataXML(data.monthlyConsumption);
	
	myChart.setTransparent(true);
	myChart.render("block-consumption-report-charts-view");
}


function updateMepConsumptionLoadProfile(){		
	var urlString = "id=" + mepId;
	$("#block-load-profile-charts-title").text(getIntervalDateValue('modal-load-profile-select-date-interval'));	
	if($("#modal-load-profile-select-date-interval").val().length > 0){		
		urlString = urlString + "&dateInterval="+$("#modal-load-profile-select-date-interval").val();
		
		if($("#modal-load-profile-select-date-interval").val() == 'custominterval'){
			if($("#modal-load-profile-input-date-from").val().length > 0){		
				urlString = urlString + "&fromDate="+$("#modal-load-profile-input-date-from").val();
			}
			else{
				alert(i18nerrorMandatoryMessage);
				return false;
			}
			
			if($("#modal-load-profile-input-date-to").val().length > 0){		
				urlString = urlString + "&toDate="+$("#modal-load-profile-input-date-to").val();
			}
			else{
				alert(i18nerrorMandatoryMessage);
				return false;
			}
		}
	}
	
	var checkboxString = $('input[name=weekdays-checkbox-lp]:checked').map(function() {return this.value;}).get().join(',');	
	if(checkboxString != null && checkboxString.length > 0){		
		urlString = urlString + "&includedWeekDays="+checkboxString;
	}
	else{
		alert(i18nerrorMandatoryMessage);
		return false;
	}
	
	var obj = {};
	obj.url = contextPath + "/std/ConsumptionLoadProfile.action";
	obj.pdata = urlString;
	obj.successfunc = consumptionLoadProfileChart;
	obj.errorfunc = errorsearchresults;	;
	run_ajax(obj);
	
	$('#overlay').css('display','none');
	$('#modal-load-profile').css('display','none');
	
	return;
}

function consumptionLoadProfileChart(data) {		
	var myChart  = new FusionCharts(contextPath+"/js/fusionchartsxt/charts/MSArea.swf", "loadprofilechart", "925", "500");
	myChart.setDataXML(data);
	myChart.setTransparent(true);
	myChart.render("block-load-profile-charts-view");
}

function errorsearchresults(data) {
	//alert(data.responseText);
	if(data.responseText == '$NO_DATA_FOR_CONSUMPTION_PROFILE$') {
		dailyConsumptionProfileChart("No Data");
	}
	if(data.responseText == '$NO_DATA_FOR_CONSUMPTION_LOAD_PROFILE$'){
		consumptionLoadProfileChart("No Data");
	}
	if(data.responseText == '$NO_DATA_FOR_CONSUMPTION_REPORT$'){
		consumptionReportChart("No Data");
	}	
}

function getCurrentDate() {
	var d = new Date();
    var curr_date = d.getDate();
    var curr_month = d.getMonth() + 1; 
	if(curr_month < 10) {
		curr_month = "0"+curr_month;
	}
    var curr_year = d.getFullYear();
	return(curr_year + "/" + curr_month + "/" + curr_date);
}

function getCurrentDateFormat(dateVal) {	
	var monthNames = [i18jan, i18feb, i18mar, i18apr, i18may, i18jun, i18jul, i18aug, i18sep, i18oct, i18nov, i18dec];
    var curr_date = dateVal.substring(8,10);
    var curr_month = monthNames[dateVal.substring(5,7) - 1]; 	
    var curr_year = dateVal.substring(0,4);		
	return(curr_month + " " + curr_date +", "+curr_year) ;	
}

function getIntervalDateValue(selectID) {
	var i18nDateInterval = "";	
	if(selectID == "modal-daily-consumption-profile-select-date-interval")
	{
		i18nDateInterval = i18ncomparetoText;	
	}
	if($('#'+selectID).val() == "lastweek") {
		i18nDateInterval = i18nDateInterval +" "+i18nlastweekText;
	}
	else if($('#'+selectID).val() == "today") {
		i18nDateInterval = i18nDateInterval +" "+i18ntodayText;
	}
	else if($('#'+selectID).val() == "lastmonth") {
		i18nDateInterval = i18nDateInterval +" "+i18nlastmonthText;
	}
	else if($('#'+selectID).val() == "lastquarter") {
		i18nDateInterval = i18nDateInterval +" "+i18nlastquarterText;
	}
	else if($('#'+selectID).val() == "lastyear") {
		i18nDateInterval = i18nDateInterval +" "+i18nlastyearText;
	}
	else if($('#'+selectID).val() == "custominterval") {
		i18nDateInterval = i18nDateInterval +" "+i18ncustomintervalText;
	}
	else if($('#'+selectID).val() == "yesterday") {
		i18nDateInterval = i18nDateInterval +" "+i18nyesterdayText;
	}
	return i18nDateInterval;
}

function getReportHeading(urlString)
{
	var obj1 = {};
	obj1.url = contextPath + "/std/ConsumptionReportHeading.action";
	obj1.pdata = urlString;
	obj1.successfunc = consumptionReportHeading;
	obj1.errorfunc = errorsearchresults;
	run_ajax(obj1);	
}

function consumptionReportHeading(data) {
	var heading = data.split(";");		
	headingFromDate = getMonthYear(heading[0]);	
	headingToDate = getMonthYear(heading[1]);
	$("#block-consumption-report-charts-title").text(headingFromDate+' '+i18to+' '+headingToDate);
}

function getMonthYear(dateVal){
	var monthNames = [i18jan, i18feb, i18mar, i18apr, i18may, i18jun, i18jul, i18aug, i18sep, i18oct, i18nov, i18dec];	
	var curr_month = monthNames[dateVal.substring(4,6) - 1]; 	
    var curr_year = dateVal.substring(0,4);		
	return(curr_month +" "+curr_year) ;		
}