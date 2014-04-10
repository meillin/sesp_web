var contextPath = "";
var criteria ="";
var from_err_msg="";
var to_err_msg="";
var i18nerrorFromDateOlderThanToDate;
var domain_err_msg="";
var areatype_err_msg="";
var area_err_msg="";
var workordertype_err_msg="";
var dateinterval_err_msg="";
var filters_msg="";
var areaWOMapInfoRParams;
var pgCode = 9;
var area_name1 = "";
var defaultStr = "default";

function loadvalues(){
	if(area_name1!=null&&area_name1!='') {
		$("#area-name").val(area_name1);
	}
	populateAPDateIntervalFilters();
	loadDomainList();
	loadAreaTypes2();
	getAreas(defaultStr);
	loadWorkOrderTypes();
	loadDefaultTabs();

	//filter_submit();
	//getAreas();
	//Meilan added this function. tobe removed
}

function populateAPDateIntervalFilters() {

	var ap_dateInterval = $.cookie(pgCode+"ap_dateInterval");
	if(ap_dateInterval!=null && ap_dateInterval!='') {
		$("#filter-select-date-interval").val(ap_dateInterval);
	}
	show();

	if(ap_dateInterval == "custominterval") {
		var ap_dateFrom = $.cookie(pgCode+"ap_dateFrom");
		if(ap_dateFrom!=null && ap_dateFrom!='') {
			//var dataarray = ap_dateFrom.split(",");
			$("#filter-date-from").val(ap_dateFrom);
		}

		var ap_dateTo = $.cookie(pgCode+"ap_dateTo");
		if(ap_dateTo!=null && ap_dateTo!='') {
			//var dataarray = ap_dateFrom.split(",");
			$("#filter-date-to").val(ap_dateTo);
		}
	}

	var ap_unplanned = $.cookie(pgCode+"ap_unplanned");
	$("#filter-checkbox-unplanned").attr('checked', ap_unplanned);

	return true;
}

function domainChanged(){
	getAreas("Domain changed");
}

function areaTypeChanged(){
	getAreas("Area type changed");
}


function loadDomainList() {
	var obj= {};
	obj.url=contextPath+"/std/GetDomains.action";
	obj.successfunc = function(data) {
		var items;
		var savedData = $.cookie(pgCode+"ap_domain");
		var selected = '" > ';

		if(savedData == null || savedData == ''){
			selected = '" selected > ';
		}

		$.each(data, function(i, item) {
			items += '<option value="' + item.id +selected + item.name + '</option>';
		});

		populateSavedMultiSelectBox("#filter-multiselect-domain", items,savedData);
	};
	obj.errorfunc = errorDetails;
	run_ajax_json(obj);
	return;
}

function errorDetails(data) {
	alert("Error : " + data.responseText);
}

function loadAreaTypes(){
	var obj1= {};
	obj1.url=contextPath+"/std/AlertManagementAreaTypes.action";
	obj1.successfunc = function(data){

	var items;
	var savedData = $.cookie(pgCode+"ap_areaType");
	var selected = '" > ';

	if(savedData == null || savedData == ''){
		selected = '" selected > ';
	}

	$.each(data, function(i, item) {
		items += '<option value="' + item.id +selected + item.name + '</option>';
	});

	populateSavedMultiSelectBox("#filter-multiselect-area-type", items,savedData);
	};
	obj1.errorfunc = errorDetails;
	run_ajax_json(obj1);
	return;
}


function loadAreaTypes2(){
	var obj1= {};
	obj1.url=contextPath+"/std/AlertManagementAreaTypes.action";
	obj1.successfunc = function(data){
		var items;
		var savedData = $.cookie(pgCode+"ap_areaType");
		var selected = '" > ';

		if(savedData === null || savedData === ''){
			selected = '" selected > ';
		}

		$.each(data, function(i, item) {
			items += '<option value="' + item.id +selected + item.name + '</option>';
		});

		$('#filter-multiselect-area-type').html(items);
	};
	obj1.errorfunc = errorDetails;
	run_ajax_json(obj1);
	return;
}

function loadWorkOrderTypes(){
	var obj2= {};
	obj2.url=contextPath+"/std/getWorkOrderTypes.action";
	obj2.successfunc = populateWorkOrderTypes;
	obj2.errorfunc = errorDetails;
	run_ajax_json(obj2);

	return;
}

function populateWorkOrderTypes(data){
	var items;
	var savedData = $.cookie(pgCode+"ap_workOrderType");
	var selected = '" > ';

	if(savedData == null || savedData == ''){
		selected = '" selected > ';
	}

	$.each(data, function(i, item) {
		items += '<option value="' + item.id +selected + item.name + '</option>';

	});

	populateSavedMultiSelectBox("#filter-multiselect-work-order-type", items,savedData);
}

function getAreas(requestType) {

	var ap_domain = $("#filter-multiselect-domain").val();
	var ap_areaType = $("#filter-multiselect-area-type").val();

	if(requestType == defaultStr){
		ap_domain = ap_areaType = requestType;
	}

	var obj = {};
	obj.url = contextPath + "/std/AlarmManagementAreas.action";
	/*var domainCode= (ap_domain==null ? null : ap_domain);
	var areaCode = (ap_areaType==null ? null : ap_areaType);*/

	obj.pdata = "domainCode=" + ap_domain + "&areaTypeCode=" + ap_areaType;
	obj.successfunc = fillAreas;
	obj.errorfunc = errorDetails;
	run_ajax_json(obj);

	return;
}

function fillAreas(data) {
	var items;
	var savedData = $.cookie(pgCode+"ap_area");
	var selected = '" > ';

	if(savedData == null || savedData == ''){
		selected = '" selected > ';
	}

	$.each(data, function(i, item) {
		items += '<option value="' + item.id +selected + item.name + '</option>';

	});

	populateSavedMultiSelectBox("#filter-multiselect-area", items,savedData);
}


function filter_submit() {

		//Give it default value in order to show chart on page load
		var ap_dateInterval = $("#filter-select-date-interval").val();
		var ap_dateFrom = $("#filter-date-from").val();
		var ap_dateTo = $("#filter-date-to").val();
		var ap_domain = $("#filter-multiselect-domain").val() || '6, 7, 8';
		var ap_areaType = $("#filter-multiselect-area-type").val() || '10,9,8,11,7,12,13';
		var ap_workOrderType = $("#filter-multiselect-work-order-type").val() || '41,44,81,51,53,55,57,59,61,63,65,112,130,152,128,140,460,207,107,126,136,173,462,110,256,147,168,149,143,464,145,466,211,68,69,70,82,135,154,74,77,78,84,179,180,183,184,185,186,187,188,189,190,191,192,193,194,195,175,196,197,176,198,199,200,177,178,201,202,203,204,205,181,182';
		var ap_unplanned = $("#filter-checkbox-unplanned").prop('checked');
		var ap_area = $("#filter-multiselect-area").val() || '7,8,9,10,11,12,13,14,15';

		if(ap_dateInterval == "custominterval"){
				if(!validateInputs(ap_dateFrom,from_err_msg)){
					return false;
				}
				if(!validateInputs(ap_dateTo,to_err_msg)){
					return false;
				}
				if(new Date(ap_dateFrom) > new Date(ap_dateTo)){
					alert(i18nerrorFromDateOlderThanToDate);
					return false;
				}
		}

		if(!validateInputs(ap_domain,domain_err_msg)){
			return false;
		}
		if(!validateInputs(ap_areaType,areatype_err_msg)){
			return false;
		}
		if(!validateInputs(ap_workOrderType,workordertype_err_msg)){
			return false;
		}
		if(!validateInputs(ap_area,area_err_msg)){
			return false;
		}

		if($("#filter-multiselect-area").text()!=null && $("#filter-multiselect-area").text()!='') {
				$("#area-name").val(area_name1);
		}
		saveAPFilters(ap_dateInterval,ap_dateFrom,ap_dateTo,ap_domain,ap_areaType,ap_workOrderType,ap_unplanned,ap_area);

		//Removing old data for summaryWorkOrder
		$("#block-summary-content-wo-count").html("");
		$("#summary-workordertypes-selected").html("");

		//Removing old charts
		//refreshChart1();
		//refreshChart2();

		var obj3= {};
		obj3.url=contextPath+"/std/WorkOrderStatusChart.action";
		obj3.pdata = 'dateInterval='+ap_dateInterval+'&dateFrom='+ap_dateFrom+'&dateTo='+ap_dateTo+'&domain='+ap_domain+
			'&areaType='+ap_areaType+'&workOrderType='+ap_workOrderType+'&unplanned='+ap_unplanned+'&area='+ap_area;

		var orderType = $.cookie(pgCode+"block-work-order-tab");

		if(orderType != "undefined" && orderType != null && orderType != ""){

			if(orderType == "progress"){
				updateStatusTab("#block-work-order-tab1","#block-work-order-tab2");
				obj3.successfunc = drawChart1;
				//run_ajax(obj3);

			}else if(orderType == "status"){
				updateStatusTab("#block-work-order-tab2","#block-work-order-tab1");
				obj3.successfunc = drawChart2;
				//run_ajax(obj3);
			}
		}else{
			obj3.successfunc = drawChart1;
			//run_ajax(obj3);
		}

		obj3.errorfunc = errorDetails;
		run_ajax(obj3);

		loadPoints(ap_dateInterval,ap_dateFrom,ap_dateTo,ap_domain,ap_areaType,ap_workOrderType,ap_unplanned,ap_area);
		return;
}

function cleanPage(){

}

function loadPoints(ap_dateInterval,ap_dateFrom,ap_dateTo,ap_domain,ap_areaType,ap_workOrderType,ap_unplanned,ap_area) {

	var obj= {};
	obj.url=contextPath+"/std/getAreaPoints.action";
	obj.pdata = 'dateInterval='+ap_dateInterval+'&dateFrom='+ap_dateFrom+'&dateTo='+ap_dateTo+'&domain='+ap_domain+
		'&areaType='+ap_areaType+'&workOrderType='+ap_workOrderType+'&unplanned='+ap_unplanned+'&area='+ap_area;
	obj.successfunc = loadPointsSuccess;
	obj.errorfunc = errorDetails;
	run_ajax(obj);
	return;

}

function xyz(data) {

	var respdata = eval(data);
	var noOfWorkOrders = respdata.noOfWorkOrders;
	var workOrderTypes = respdata.workOrderTypes;
	var areaProgressMap = respdata.areaProgressMap;
	var workOrderProgressChartxml = respdata.workOrderProgressChartxml;
	var detailedProgressxml = respdata.detailedProgressxml;

}

function show(){

	if($("#filter-select-date-interval").val()=="custominterval"){
		//document.getElementById("filter-custom-date-interval").style.visibility="visible";
		showDate();
			//$('#filter-custom-date-interval').css("visibility","visible");
		} else {
			hideDate();
			//document.getElementById("filter-custom-date-interval").style.visibility="hidden";
			//$('#filter-custom-date-interval').css("visibility","hidden");
		}
}

function hideDate()
{
	//$("#block_from_and_to_date").hide();

	$("#filter-date-from").hide();
	$("#filter-date-to").hide();
}

function showDate(){
	$("#filter-date-from").show();
	$("#filter-date-to").show();
}

function showWorkOrderTypes(data){
	var items2;
	$.each(data, function(i, item2) {
		items2 +='<div class="sub-block-summary-content">'+item2.workOrderTypeTOList+'</div>';
	});
	$("#filter-multiselect-work-order-type").html(items2);
	$("#filter-multiselect-work-order-type").multiselect("refresh");
}

function drawChart1(data) {
	drawAreaProgress();
	drawDetailedProgress();
}
function drawChart2(data){
	drawAreaStatus();
}
function refreshChart1(){

}
function refreshChart2(){

}

function updateWorkOrder(orderType){

	var ap_dateInterval = $("#filter-select-date-interval").val();
	var ap_dateFrom = $("#filter-date-from").val();
	var ap_dateTo = $("#filter-date-to").val();
	var ap_domain = $("#filter-multiselect-domain").val();
	var ap_areaType = $("#filter-multiselect-area-type").val();
	var ap_workOrderType = $("#filter-multiselect-work-order-type").val();
	var ap_unplanned = $("#filter-checkbox-unplanned").prop('checked');
	var ap_area = $("#filter-multiselect-area").val();

	if(ap_dateInterval == "custominterval"){
		if(!validateInputs(ap_dateFrom,from_err_msg)){
			return false;
		}
		if(!validateInputs(ap_dateTo,to_err_msg)){
			return false;
		}
		if(new Date(ap_dateFrom) > new Date(ap_dateTo)){
			alert(i18nerrorFromDateOlderThanToDate);
			return false;
		}
	}

	if(!validateInputs(ap_domain,domain_err_msg)){
		return false;
	}
	if(!validateInputs(ap_areaType,areatype_err_msg)){
		return false;
	}
	if(!validateInputs(ap_workOrderType,workordertype_err_msg)){
		return false;
	}
	if(!validateInputs(ap_area,area_err_msg)){
		return false;
	}

	saveAPFilters(ap_dateInterval,ap_dateFrom,ap_dateTo,ap_domain,ap_areaType,ap_workOrderType,ap_unplanned,ap_area);
	saveAreaProgressFilter("block-work-order-tab",orderType );

	//Removing old charts
	refreshChart1();
	refreshChart2();

	var obj3= {};
	obj3.url=contextPath+"/std/WorkOrderStatusChart.action";
	obj3.pdata = 'dateInterval='+ap_dateInterval+'&dateFrom='+ap_dateFrom+'&dateTo='+ap_dateTo+'&domain='+ap_domain+
	   		'&areaType='+ap_areaType+'&workOrderType='+ap_workOrderType+'&unplanned='+ap_unplanned+'&area='+ap_area;

	if(orderType != "undefined" && orderType != null && orderType != ""){
		var stockChart;
		if(orderType == "progress"){
			updateStatusTab("#block-work-order-tab1","#block-work-order-tab2");
			obj3.successfunc = drawChart1;
			obj3.errorfunc = errorDetails;
			run_ajax(obj3);

		}else if(orderType == "status"){
			updateStatusTab("#block-work-order-tab2","#block-work-order-tab1");

			obj3.successfunc = drawChart2;
			obj3.errorfunc = errorDetails;
			run_ajax(obj3);
		}

	}
	return;
}

//Common method for validating the inputs
function validateInputs(inputVal,errorMessage){
	if(inputVal == null || inputVal == ""){
		alert(errorMessage);
		return false;
	}
	return true;
}

function showWorkOrderStatusCharts(){
	//Hide Work Order Progress charts
	$("#block-work-order-chart-view").hide();
	$("#block-work-order-chart-view2").hide();
	//Show Work Order Status charts
	$("#block-work-order-status-chart").show();
	$("#block-work-order-status-chart-right").show();


}

function showWorkOrderProgressCharts(){

	//Hide Work Order Status charts
	$("#block-work-order-status-chart").hide();
	$("#block-work-order-status-chart-right").hide();

	//Show Work Order Progress charts
	$("#block-work-order-chart-view").show();
	$("#block-work-order-chart-view2").show();
	//$("#from_date").hide();

}

//Populate the multi-select box with the given data for the given id
function populateSavedMultiSelectBox(idName, items,savedData){

	$(idName).find('option').remove();
	$(idName).multiselect('refresh');

	var selectData = $(idName).multiselect();
	selectData.append(items);

	if(savedData!=null && savedData!='') {
		var dataArray = savedData.split(",");
		$(idName).val(dataArray);
	}

	selectData.multiselect('refresh');

}

function updateStatusTab(tabId1,tabId2){

	var tabSelected = "tab selected";
	$(tabId1).addClass(tabSelected);
	$(tabId2).removeClass(tabSelected);
	$(tabId2).addClass("tab");
}

function loadDefaultTabs(){
	var orderType = $.cookie(pgCode+"block-work-order-tab");
	if(orderType != "undefined" && orderType != null && orderType != ""){
		if(orderType == "progress"){
			updateStatusTab("#block-work-order-tab1","#block-work-order-tab2");
		}else if(orderType == "status"){
			updateStatusTab("#block-work-order-tab2","#block-work-order-tab1");
		}
	}
}

function saveAPFilters(ap_dateInterval,ap_dateFrom,ap_dateTo,ap_domain,ap_areaType,ap_workOrderType,ap_unplanned,ap_area) {
	$.cookie(pgCode+"ap_dateInterval",ap_dateInterval,{ expires: 7 });
	$.cookie(pgCode+"ap_dateFrom",ap_dateFrom,{ expires: 7 });
	$.cookie(pgCode+"ap_dateTo",ap_dateTo,{ expires: 7 });
	$.cookie(pgCode+"ap_domain",ap_domain,{ expires: 7 });
	$.cookie(pgCode+"ap_areaType",ap_areaType,{ expires: 7 });
	$.cookie(pgCode+"ap_workOrderType",ap_workOrderType,{ expires: 7 });
	$.cookie(pgCode+"ap_unplanned",ap_unplanned,{ expires: 7 });
	$.cookie(pgCode+"ap_area",ap_area,{ expires: 7 });
}

function saveAreaProgressFilter(key,value){
	$.cookie(pgCode+key,value,{ expires: 7 });
}

var colors = Highcharts.getOptions().colors;
function drawAreaProgress() {
    // Build the chart
    $('#work-order-chart-view').highcharts({
        chart: {
            plotBackgroundColor: null,
            plotBorderWidth: null,
            plotShadow: false,
            height: 225
        },
        legend: {
            layout: 'vertical',
            backgroundColor: '#FFFFFF',
            align: 'right',
            verticalAlign: 'top',
            floating: true,
            x: -10,
            y: 60
        },
        title: {
            text: ''
        },
        tooltip: {
            pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
        },
        plotOptions: {
            pie: {
                allowPointSelect: true,
                cursor: 'pointer',
                dataLabels: {
                    enabled: false
                },
                center: [80, 80],
                showInLegend: true
            }
        },
        series: [{
            type: 'pie',
            name: 'Work order progress',
            size: '100%',
            data: [
                ['Performed within plan', 2100],
                ['Unplanned', 500],
                {
                    name: 'Performed after plan',
                    y: 150,
                    sliced: true,
                    selected: true
                },
                ['Not yet performed after plan', 201],
                ['Not yet performed within plan', 1200]
            ]
        }]
    });
}
function drawDetailedProgress() {
    $('#detailed-progress').highcharts({
        chart: {
            height: 225
        },
        title: {
            text: ''
        },
        xAxis: [{
            categories: ['Week11', 'Week12', 'Week13', 'Week14', 'Week15', 'Week16',
                'Week17', 'Week18', 'Week19', 'Week20']
        }],
        yAxis: [{ // Primary yAxis
            labels: {
                format: '{value}',
                style: {
                    color: '#89A54E'
                }
            },
            title: {
                text: 'Planned work orders',
                style: {
                    color: '#89A54E'
                }
            }
        }, { // Secondary yAxis
            title: {
                text: 'Available resources',
                style: {
                    color: '#4572A7'
                }
            },
            labels: {
                format: '{value}',
                style: {
                    color: '#4572A7'
                }
            },
            opposite: true
        }],
        tooltip: {
            shared: true
        },
        legend: {
            layout: 'vertical',
            align: 'left',
            x: 120,
            verticalAlign: 'top',
            y: 100,
            floating: true,
            backgroundColor: '#FFFFFF'
        },
        series: [{
            name: 'Available resources',
            color: '#4572A7',
            type: 'column',
            yAxis: 1,
            data: [49.9, 71.5, 106.4, 129.2, 144.0, 176.0, 135.6, 148.5, 216.4, 194.1],
            tooltip: {
                valueSuffix: ' mm'
            }

        }, {
            name: 'Planned work orders',
            color: '#89A54E',
            type: 'spline',
            data: [7.0, 6.9, 9.5, 14.5, 18.2, 21.5, 25.2, 26.5, 23.3, 18.3],
            tooltip: {
                valueSuffix: '°C'
            }
        }]
    });
}
function drawAreaStatus() {
    $('#area-status').highcharts({
        chart: {
            type: 'bar',
            height: 550
        },
        title: {
            text: ''
        },
        xAxis: {
            categories: ['Area 1', 'Area 2', 'Area 3', 'Area 4', 'Area 5', 'Area 6', 'Area 7', 'Area 8', 'Area 9']
        },
        legend: {
            backgroundColor: '#FFFFFF'
        },
        plotOptions: {
            series: {
                stacking: 'normal'
            }
        },
        series: [{
                    name: 'Performed within plan',
                    data: [3, 4, 4, 3, 4, 4, 3, 4, 4]
                },{
                    name: 'Unplanned',
                    data: [5, 3, 4, 5, 3, 4, 5, 3, 4]
                }, {
                    name: 'Performed after plan',
                    data: [2, 2, 3, 5, 3, 4, 2, 2, 3]
                }, {
                    name: 'Not yet performed after plan',
                    data: [5, 3, 2, 2, 2, 3, 5, 3, 2]
                }, {
                    name: 'Not yet performed within plan',
                    data: [4, 2, 3, 5, 3, 2, 4, 2, 3]
                }]
        });
}