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

		populateSavedMultiSelectBox("#filter-multiselect-domain", items, savedData);
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

	populateSavedMultiSelectBox("#filter-multiselect-area-type", items, savedData);
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

function insertPeriod(f, t, type){
	type = type === true ? 'Unplanned' : 'Planned';
	var periodType ='<li>Type: ' + type + '</li>';
	var from = '<li>From: ' + f + '</li>';
	var to = '<li>To: ' + t + '</li>';
	$('#selected-period-type').html(periodType + from + to);
}

function insertValues(value, context, divId){
	var values = '';
	for(var i = 0 ; i < value.length ; i++){
		values +='<li>' + $("#"+context+" option[value="+value[i]+"]").text()+ "</li>";
	}
	$('#'+divId+' ul').html(values);
	$('#'+divId+' span.label').html(value.length);
}

function filter_submit() {

		//Give it default value in order to show chart on page load
		var ap_dateInterval = $("#filter-select-date-interval").val();
		var ap_dateFrom = $("#filter-date-from").val();
		var ap_dateTo = $("#filter-date-to").val();
		var ap_unplanned = $("#filter-checkbox-unplanned").prop('checked');
		insertPeriod(ap_dateFrom, ap_dateTo, ap_unplanned);

		var ap_domain = $("#filter-multiselect-domain").val();
		insertValues(ap_domain, 'filter-multiselect-domain','selected-domain');

		var ap_areaType = $("#filter-multiselect-area-type").val();
		insertValues([ap_areaType], 'filter-multiselect-area-type','selected-area-type');

		var ap_workOrderType = $("#filter-multiselect-work-order-type").val();
		insertValues(ap_workOrderType, 'filter-multiselect-work-order-type','selected-work-order-type');

		var ap_area = $("#filter-multiselect-area").val();
		insertValues(ap_area, 'filter-multiselect-area','selected-area');


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
				obj3.successfunc = drawChart1;
			}else if(orderType == "status"){
				obj3.successfunc = drawChart2;
			}
		}else{
			obj3.successfunc = drawChart1;
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
		showDate();
	} else {
			hideDate();
	}
}

function hideDate()
{
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


Highcharts.setOptions({
//Green - #1abc9c //Blue - #428bca // Orange - #f0ad4e // Red - #d9534f //
 colors: ['#1abc9c', '#428bca', '#d9534f', '#f0ad4e', '#5bc0de', '#1d2939']
});
var colors = ['#1abc9c', '#428bca', '#d9534f', '#f0ad4e', '#5bc0de', '#1d2939'];
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
        series: [{
            name: 'Planned Work Order',
            color: '#4572A7',
            type: 'column',
            yAxis: 1,
            data: [49.9, 71.5, 106.4, 129.2, 144.0, 176.0, 135.6, 148.5, 216.4, 194.1],
            tooltip: {
                valueSuffix: ' mm'
            }

        },{
            name: 'Closed Work Order',
            color: '#1abc9c',
            type: 'column',
            yAxis: 1,
            data: [49.9, 71.5, 106.4, 129.2, 144.0, 176.0, 135.6, 148.5, 216.4, 194.1],
            tooltip: {
                valueSuffix: ' mm'
            }

        }, {
            name: 'Available resources',
            color: '#d9534f',
            type: 'spline',
            data: [7.0, 6.9, 9.5, 14.5, 18.2, 21.5, 25.2, 26.5, 23.3, 18.3],
            tooltip: {
                valueSuffix: '°C'
            }
        }]
    });
}
function drawAreaStatus() {
       var categories = ['Performed', 'Not performed', 'Not planned', 'Not performed final', 'Opera'],
        name = '',
        data = [{
                y: 10000,
                color: colors[0],
                drilldown: {
                    name: 'Performed versions',
                    categories: ['Performed'],
                    data: [10000],
                    color: colors[0]
                }
            }, {
                y: 1000,
                color: colors[1],
                drilldown: {
                    name: 'Not performed versions',
                    categories: ['Not performed'],
                    data: [1000],
                    color: colors[1]
                }
            }, {
                y: 1000,
                color: colors[2],
                drilldown: {
                    name: 'Not planned versions',
                    categories: ['Not planned versions'],
                    data: [1000],
                    color: colors[2]
                }
            }, {
                y: 5470,
                color: colors[3],
                drilldown: {
                    name: 'Not performed final versions',
                    categories: ['With time reservation', 'Missed time reservation', 'Planned', 'Saved with errors', 'Undefined'],
                    data: [2500, 2000, 470, 300, 200],
                    color: colors[3]
                }
            }];
        // Build the data arrays
        var browserData = [];
        var versionsData = [];
        for (var i = 0; i < data.length; i++) {

            // add browser data
            browserData.push({
                name: categories[i],
                y: data[i].y,
                color: data[i].color
            });

            // add version data
            for (var j = 0; j < data[i].drilldown.data.length; j++) {
                var brightness = 0.2 - (j / data[i].drilldown.data.length) / 5 ;
                versionsData.push({
                    name: data[i].drilldown.categories[j],
                    y: data[i].drilldown.data[j],
                    color: Highcharts.Color(data[i].color).brighten(brightness).get()
                    });
                }
        }
        // Create the chart
        $('#area-status').highcharts({
            chart: {
                type: 'pie',
                height: 550
            },
            title: {
                text: ''
            },
            yAxis: {
                title: {
                    text: 'Total percent market share'
                }
            },
            plotOptions: {
                pie: {
                    shadow: false,
                    center: ['55%', '50%'],
                    showInLegend: true

                },
            },
            tooltip: {
                valueSuffix: ''
            },
            series: [{
                name: 'Work Order',
                data: browserData,
                size: '50%',
                dataLabels: {
                    formatter: function() {
                        //return this.y > 5 ? this.point.name : null;
                    },
                    color: 'white',
                    distance: -30
                }
            }, {
                name: 'Versions',
                data: versionsData,
                size: '70%',
                innerSize: '50%',
                dataLabels: {
                    formatter: function() {
                        // display only if larger than 1
                        return this.y > 1 ? '<b>'+ this.point.name +':</b> '+ this.y +''  : null;
                    }
                }
            }]
        });
}