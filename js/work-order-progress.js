var contextPath = "";
var criteria ="";
var pgCode = 8;

var from_err_msg="";
var to_err_msg="";
var domain_err_msg="";
var areatype_err_msg="";
var area_err_msg="";
var workordertype_err_msg="";
var dateinterval_err_msg="";
var filters_msg="";
var bubbleChartData = "";
var i18nerrorFromDateOlderThanToDate;
var areaWOMapInfoRParams;
var selected = "";
var defaultStr = "default";
jQuery(document).ready(function($){

$('.sub-menu li').click(function(){
	var active = $(this);
	if(!active.hasClass('active')){
		$('.sub-menu li').removeClass('active');
		active.addClass('active');
	}
	if( active.hasClass('progress-chart-li')) {
		$('.status, .details').hide();
		$('.progress-chart').show();

	} else if (active.hasClass('status-chart')) {
		$('.progress-chart, .details').hide();
		$('.status').show();
	} else {
		$('.details').show();
		$('.progress-chart, .status').hide();
	}
});

	/*
	 * tabs managing
	 */
    $("#block-work-order-tab1").click(function(){

    	if( !$(this).hasClass("selected")){
	    	$(".tab").removeClass("selected");
	    	$(this).addClass("selected");

	    	/**
	    	 * TODO
	    	 * action on the first tab
	    	 */

    	}
    });

    $("#block-work-order-tab2").click(function(){

    	if( !$(this).hasClass("selected")){
	    	$(".tab").removeClass("selected");
	    	$(this).addClass("selected");

	    	/**
	    	 * TODO
	    	 * action on the second tab
	    	 */

    	 }
    });

});

function loadvalues(){

	populateAPDateIntervalFilters();
	loadDomainList();
	loadAreaTypes();
	getAreas(defaultStr);
	loadWorkOrderTypes();

}


function domainChanged(){
	getAreas("Domain changed");
}

function areaTypeChanged(){
	getAreas("Area type changed");
}

function populateAPDateIntervalFilters() {

	var ap_dateInterval = $.cookie(pgCode+"ap_dateInterval");
	if(ap_dateInterval!=null && ap_dateInterval!='') {
		//var dataarray = ap_dateInterval.split(",");
		$("#filter-select-date-interval").val(ap_dateInterval);
	}


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

	show();

	var ap_unplanned = $.cookie(pgCode+"ap_unplanned");
	$("#filter-checkbox-unplanned").attr('checked', ap_unplanned);

	return true;
}

function loadDomainList() {
	var obj= {};
	obj.url=contextPath+"/std/GetDomains.action";
	obj.successfunc = function(data) {
		var items;
		var savedData = $.cookie(pgCode+"ap_domain");
		selected = '" > ';

		if(savedData == null || savedData == ''){
			selected = '" selected > ';
		}


		$.each(data, function(i, item) {
			items += '<option value="' + item.id + selected	+ item.name + '</option>';
			});
		/*$("#filter-multiselect-domain").html(items);


		if(ap_domain!=null && ap_domain!='') {
			var dataarray = ap_domain.split(",");
			$("#filter-multiselect-domain").val(dataarray);
		}

		$("#filter-multiselect-domain").multiselect("refresh"); */

		populateSavedMultiSelectBox("#filter-multiselect-domain",items,savedData);

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
	/*var items1;
	$.each(data, function(i, item1) {
		items1 += '<option value="' + item1.id + '">' + item1.name + '</option>';
	});
	$("#filter-multiselect-area-type").html(items1);*/

	/*var ap_areaType = $.cookie(pgCode+"ap_areaType");
	if(ap_areaType!=null && ap_areaType!='') {
		var dataarray = ap_areaType.split(",");
		$("#filter-multiselect-area-type").val(dataarray);
	}

	$("#filter-multiselect-area-type").multiselect("refresh");*/
	  var items;
	  var savedData = $.cookie(pgCode+"ap_areaType");
	  selected = '" > ';

		if(savedData == null || savedData == ''){
			selected = '" selected > ';
		}


		$.each(data, function(i, item) {
			items += '<option value="' + item.id + selected	+ item.name + '</option>';
			});

	populateSavedMultiSelectBox("#filter-multiselect-area-type",items,savedData);


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
	/*var items2;
	$.each(data, function(i, item2) {
		items2 += '<option value="' + item2.id + '">' + item2.name + '</option>';
	});
	$("#filter-multiselect-work-order-type").html(items2);

	var ap_workOrderType = $.cookie(pgCode+"ap_workOrderType");
	if(ap_workOrderType!=null && ap_workOrderType!='') {
		var dataarray = ap_workOrderType.split(",");
		$("#filter-multiselect-work-order-type").val(dataarray);
	}

	$("#filter-multiselect-work-order-type").multiselect("refresh");*/

	 var items;
	  var savedData = $.cookie(pgCode+"ap_workOrderType");
	  selected = '" > ';

		if(savedData == null || savedData == ''){
			selected = '" selected > ';
		}


		$.each(data, function(i, item) {
			items += '<option value="' + item.id + selected	+ item.name + '</option>';
			});

	populateSavedMultiSelectBox("#filter-multiselect-work-order-type",items,savedData);
}

function getAreas(requestType) {

	var ap_domain = $("#filter-multiselect-domain").val();
	var ap_areaType = $("#filter-multiselect-area-type").val();

	if(requestType != null && requestType == defaultStr){
		ap_domain = ap_areaType = requestType;
	}

	var obj = {};
	obj.url = contextPath + "/std/AlarmManagementAreas.action";
//	var domainCode= (ap_domain==null ? null : ap_domain.join(","));
//	var areaCode = (ap_areaType==null ? null : ap_areaType.join(","));
	obj.pdata = "domainCode=" + ap_domain + "&areaTypeCode=" + ap_areaType;
	obj.successfunc = fillAreas;
	obj.errorfunc = errorDetails;
	run_ajax_json(obj);
	return;
}

function fillAreas(data) {
	/*var items;
	$("#filter-multiselect-area").find('option').remove();
	$("#filter-multiselect-area").multiselect('refresh');
	var msareas = $("#filter-multiselect-area").multiselect();
	$.each(data, function(i, item) {
		items += '<option value="' + item.id + '">' + item.name + '</option>';
	});
	msareas.append(items);


	var ap_area = $.cookie(pgCode+"ap_area");
	if(ap_area!=null && ap_area!='') {
		var dataarray = ap_area.split(",");
		$("#filter-multiselect-area").val(dataarray);
	}

	msareas.multiselect('refresh');	*/
	var items;
	  var savedData = $.cookie(pgCode+"ap_area");
	  selected = '" > ';

		if(savedData == null || savedData == ''){
			selected = '" selected > ';
		}


		$.each(data, function(i, item) {
			items += '<option value="' + item.id + selected	+ item.name + '</option>';
			});

	populateSavedMultiSelectBox("#filter-multiselect-area",items,savedData);
}


function filter_submit() {

	var validation = false;
	validation = submitValidation();
	if(validation) {
		var ap_dateInterval = $("#filter-select-date-interval").val();
		var ap_dateFrom = $("#filter-date-from").val();
		var ap_dateTo = $("#filter-date-to").val();
		var ap_domain = $("#filter-multiselect-domain").val().join(",");
		var ap_areaType = $("#filter-multiselect-area-type").val().join(",");
		var ap_workOrderType = $("#filter-multiselect-work-order-type").val().join(",");
		var ap_area = $("#filter-multiselect-area").val().join(",");
		var ap_unplanned = $("#filter-checkbox-unplanned").prop('checked');
		//alert(ap_unplanned);

		saveWOProgressFilters(ap_dateInterval,ap_dateFrom,ap_dateTo,ap_domain,ap_areaType,ap_workOrderType,ap_unplanned,ap_area);



		var obj3= {};
		obj3.url=contextPath+"/std/WorkOrderStatusChart.action";
		obj3.pdata = 'dateInterval='+ap_dateInterval+'&dateFrom='+ap_dateFrom+'&dateTo='+ap_dateTo+'&domain='+ap_domain+
		   		'&areaType='+ap_areaType+'&workOrderType='+ap_workOrderType+'&unplanned='+ap_unplanned+'&area='+ap_area;
		obj3.successfunc = drawChart1;
		obj3.errorfunc = errorDetails;
		run_ajax(obj3);

		/*var obj4= {};
		obj4.url=contextPath+"/std/ProgressOverviewChart.action";
		obj4.pdata = 'dateInterval='+ap_dateInterval+'&dateFrom='+ap_dateFrom+'&dateTo='+ap_dateTo+'&domain='+ap_domain+
   		'&areaType='+ap_areaType+'&workOrderType='+ap_workOrderType;
		obj4.successfunc = drawChart2;
		obj4.errorfunc = errorDetails;
		run_ajax(obj4);*/


		loadPointsForAreaMap(ap_domain,ap_areaType,ap_workOrderType,ap_unplanned,ap_dateInterval,ap_dateFrom,ap_dateTo,ap_area);

		return;
	}


}

function submitValidation() {
	/*var dateInterval = $("#filter-select-date-interval").val();
	var dateFrom = $("#filter-date-from").val();
	var dateTo = $("#filter-date-to").val();
	var domain = $("#filter-multiselect-domain").val();
	var areaType = $("#filter-multiselect-area-type").val();
	var workOrderType = $("#filter-multiselect-work-order-type").val();
	var area = $("#filter-multiselect-area").val();*/




	/*if((dateInterval=='Custom interval' && dateFrom==null)||(dateInterval=='Custom interval'&&dateFrom=='')) {
		criteria += from_err_msg;
		bool = false;
	}
	if((dateInterval=='Custom interval'&&dateTo==null)||(dateInterval=='Custom interval'&&dateTo=='')) {
		criteria += to_err_msg;
		bool = false;
	}
	if(domain==null||domain=='') {
		criteria += domain_err_msg;
		bool = false;
	}
	if(areaType==null||areaType=='') {
		criteria += areatype_err_msg;
		bool = false;
	}
	if(workOrderType==null||workOrderType=='') {
		criteria += workordertype_err_msg;
		bool = false;
	}
	if(dateInterval=='Custom interval'&&dateFrom!=null&&dateTo!=null&&!(dateFrom <= dateTo)) {
		criteria += dateinterval_err_msg;
		bool = false;
	}*/

	if ($("#filter-select-date-interval").val() == "custominterval") {

		if(!validateMultiSelectBox("#filter-date-from",from_err_msg)){
			return false;
		}

		if(!validateMultiSelectBox("#filter-date-to",to_err_msg)){
			return false;
		}

		if(new Date($("#filter-date-from").val()) > new Date($("#filter-date-to").val())){
			alert(i18nerrorFromDateOlderThanToDate);
			return false;
		}
	}

	if(!validateMultiSelectBox("#filter-multiselect-domain",domain_err_msg)){
		return false;
	}

	if(!validateMultiSelectBox("#filter-multiselect-area-type",areatype_err_msg)){
		return false;
	}

	if(!validateMultiSelectBox("#filter-multiselect-work-order-type",workordertype_err_msg)){
		return false;
	}

	if(!validateMultiSelectBox("#filter-multiselect-area",area_err_msg)){
		return false;
	}

	/*if(domain==null||domain=='') {
		criteria += domain_err_msg;
		bool = false;
	}
	if(areaType==null||areaType=='') {
		criteria += areatype_err_msg;
		bool = false;
	}
	if(area==null||area=='') {
		criteria += area_err_msg;
		bool = false;
	}
	if(workOrderType==null||workOrderType=='') {
		criteria += workordertype_err_msg;
		bool = false;
	}*/

    return true;
}

function show(){
	if($("#filter-select-date-interval").val()=="custominterval"){
	//document.getElementById("filter-custom-date-interval").style.visibility="visible";
		showDate();
		//$('#filter-custom-date-interval').css("visibility","visible");
		//$('#filter-date-to').css("visibility","visible");

	} else {
		hideDate();
		//document.getElementById("filter-custom-date-interval").style.visibility="hidden";
		//$('#filter-custom-date-interval').css("visibility","hidden");
		//$('#filter-date-to').css("visibility","hidden");
		//$('#filter-date-to').css("visibility","hidden");

	}
}


function hideDate()
{


	//$("#block_from_and_to_date").hide();

	$("#filter-date-from").hide();
	$("#filter-date-to").hide();
}

function showDate(){

	//$("#block_from_and_to_date").show();
	$("#filter-date-from").show();
	$("#filter-date-to").show();
}

function drawChart1(data) {
	if (data != "" || data != null) {
		var stockChart = new FusionCharts(contextPath+"/js/fusionchartsxt/charts/Pie2D.swf", "workOrderStatusChartId", "560", "445");
		stockChart.setDataXML(data.workOrderStatus);
		//alert("Work Order status xml " + data.workOrderStatus);
		stockChart.render("block-work-order-status-chart");

		var stockChart1 = new FusionCharts(contextPath+"/js/fusionchartsxt/charts/StackedColumn2D.swf", "notPerformedChartId","370","445");
		stockChart1.setDataXML(data.notPerformedDetail);
		//alert("Work Order NP " + data.notPerformedDetail);
		stockChart1.render("block-work-order-status-chart-right");
		}
	if (data != "" || data != null) {

		/*//Work Order Status Overview
		var stockChart = new FusionCharts(contextPath+"/js/fusionchartsxt/charts/Pie2D.swf", "workOrderStatusChartId", "680", "545");
		stockChart.setDataXML(data.workOrderStatus);
		//alert("Work Order status xml " + data.workOrderStatus);
		stockChart.render("block-work-order-status-chart");*/

		var randomNum = Math.random();
		//Work Order Status Overview
		var stockChart = new FusionCharts(contextPath+"/js/fusionchartsxt/charts/Pie2D.swf", "workOrderStatusChartId"+randomNum, "680", "545");
		stockChart.setDataXML(data.workOrderStatus);
		//alert("Work Order status xml " + data.workOrderStatus);
		stockChart.render("block-work-order-status-chart");

		//Work Order Status - Not Performed
		var stockChart1 = new FusionCharts(contextPath+"/js/fusionchartsxt/charts/StackedColumn2D.swf", "notPerformedChartId"+randomNum,"260","500");
		stockChart1.setDataXML(data.notPerformedDetail);
		//alert("Work Order NP " + data.notPerformedDetail);
		stockChart1.render("block-work-order-status-chart-right");

		//totalProgressOverview
		stockChart = new FusionCharts(contextPath+"/js/fusionchartsxt/charts/StackedBar2D.swf", "totalProgressChartId"+randomNum,"930","200");
		stockChart.setDataXML(data.totalProgressOverview);
		stockChart.render("block-progress-overview-total-progress");

		//Work Order Progress
		stockChart = new FusionCharts(contextPath+"/js/fusionchartsxt/charts/Doughnut2D.swf", "workOrderProgressChartId"+randomNum,"930","513");
		stockChart.setDataXML(data.workOrderProgress);
		stockChart.render("block-progress-overview-work-order-progress");
		//bubbleChartData = data;

		// Detailed  Progress
		stockChart = new FusionCharts(contextPath+"/js/fusionchartsxt/charts/MSCombi2D.swf", "detailedWeeklyProgressChartId"+randomNum,"930","513");
		stockChart.setDataXML(data.detailedProgress);
		stockChart.render("block-progress-overview-detailed-progress");

		//Detailed Timebased Performance - work orders

		stockChart = new FusionCharts(contextPath+"/js/fusionchartsxt/charts/StackedBar2D.swf", "detailedTimebasedWorkorders"+randomNum,"930","200");
		stockChart.setDataXML(data.detailedTimebasedWorkOrders);
		stockChart.render("block-progress-overview-detailed-timebased-perfomance-workorders");

		stockChart = new FusionCharts(contextPath+"/js/fusionchartsxt/charts/StackedBar2D.swf", "detailedTimebasedNotPerformed"+randomNum,"930","400");
		stockChart.setDataXML(data.detailedTimebasedNotPerformed);
		stockChart.render("block-progress-overview-detailed-timebased-perfomance-notperformed");
		}
}

function drawChart2(data) {

	//stockChart = new FusionCharts(contextPath+"/js/fusionchartsxt/charts/StackedBar2D.swf", "totalProgressChartId","930","200");
	//stockChart.setDataXML(eval(data).totalProgress);
	//stockChart.render("block-progress-overview-total-progress");

	/*stockChart = new FusionCharts(contextPath+"/js/fusionchartsxt/charts/Doughnut2D.swf", "workOrderProgressChartId","930","513");
	stockChart.setDataXML(eval(data).workOrderProgress);
	stockChart.render("block-progress-overview-work-order-progress");	*/

	stockChart = new FusionCharts(contextPath+"/js/fusionchartsxt/charts/MSCombi2D.swf", "detailedProgressChartId","930","513");
	stockChart.setDataXML(eval(data).detailedProgress);
	stockChart.render("block-progress-overview-detailed-progress");
}



//Common method for validating the inputs
function validateMultiSelectBox(selectName,errorMessage){
	var inputVal = $(selectName).val();
	if(inputVal == null || inputVal == ""){
		alert(errorMessage);
		return false;
	}
	return true;
}


function createWOAreaJSON(json) {
	var layers = map.getLayersByName("AreasLayer");
	for(var i = 0; i<layers.length; i++) {
		var layer = layers[i];
		layer.destroy();
	}

	if(json == "[]") {
		return;
	}

	var features = [];
	var areas = eval(json);
	for(var i=0; i<areas.length; i++) {
		area = areas[i];
		var areaPoints = [];

		for(var j = 0; j<area.areaCoordinates.length; j++) {

			point = new OpenLayers.Geometry.Point(area.areaCoordinates[j].y, area.areaCoordinates[j].x);
			point.transform(
				projections[area.areaCoordinates[j].coordinateSystem].projection,
				toProjection // to Spherical Mercator Projection
			);
			areaPoints.push(point);
		}

		var linear_ring = new OpenLayers.Geometry.LinearRing(areaPoints);
		var polygonFeature = new OpenLayers.Feature.Vector(
				new OpenLayers.Geometry.Polygon([linear_ring]),
				null,
				null
		);
		polygonFeature.attributes = {
				 id:area.id,
	             name: area.areaName,
	             closed:''
		};
		features.push(polygonFeature);
	}
	var areaVector =     	new OpenLayers.Layer.Vector(
    		"AreasLayer",
    		{styleMap: new OpenLayers.StyleMap(areaStyle)}

    );
	/* wo map areas */

	var selectControl;
	var selectedFeature;

    selectControl = new OpenLayers.Control.SelectFeature(areaVector,
    {
    	hover:false,
        onSelect: onPopupFeatureSelect,
        onUnselect: onPopupFeatureUnselect
    });
    map.addControl(selectControl);
    selectControl.activate();

	function onPopupClose(evt) {
	    selectControl.unselect(selectedFeature);
	}
	function onPopupFeatureSelect(feature) {
	    selectedFeature = feature;
	    var anchor = {'size': new OpenLayers.Size(0,0), 'offset': new OpenLayers.Pixel(-5,5)};
	    var popup = new OpenLayers.Popup.Anchored("popup",
                //OpenLayers.LonLat.fromString(feature.geometry.toString()),
	    		feature.geometry.bounds.getCenterLonLat(),
	    		new OpenLayers.Size(350, 350),
                woAreaProgressCallback(feature.attributes.name,feature.attributes.id),
                null,
                false
            );

	    //popup.autoSize = true;
	    popup.minSize = new OpenLayers.Size(350,350);
        popup.maxSize = new OpenLayers.Size(350,350);
        popup.fixedRelativePosition = true;
	    popup.setSize(new OpenLayers.Size(350, 350));
	    feature.popup = popup;
	    map.addPopup(popup);

	    fetchBubbleContent(feature.attributes.id);

	}
	function onPopupFeatureUnselect(feature) {
	    map.removePopup(feature.popup);
	    feature.popup.destroy();
	    feature.popup = null;
	}
	map.addLayer(areaVector);
	areaVector.addFeatures(features);
}

//Populate the multi-select box with the given data for the given id
function populateSavedMultiSelectBox(idName, items,savedData){

	/*$(idName).html(items);
	$(idName).multiselect("refresh");*/

	$(idName).find('option').remove();
	$(idName).multiselect('refresh');
	var selectData = $(idName).multiselect();
	/*$.each(data, function(i, item) {
		items += '<option value="' + item.id + '">' + item.name + '</option>';
	});	*/
	selectData.append(items);

	//var savedData = $.cookie(pageCode+idName);
	if(savedData!=null && savedData!='') {
		var dataArray = savedData.split(",");
		$(idName).val(dataArray);
	}

	selectData.multiselect('refresh');

}

function saveWOProgressFilters(ap_dateInterval,ap_dateFrom,ap_dateTo,ap_domain,ap_areaType,ap_workOrderType,ap_unplanned,ap_area) {
	$.cookie(pgCode+"ap_dateInterval",ap_dateInterval,{ expires: 7 });
	$.cookie(pgCode+"ap_dateFrom",ap_dateFrom,{ expires: 7 });
	$.cookie(pgCode+"ap_dateTo",ap_dateTo,{ expires: 7 });
	$.cookie(pgCode+"ap_domain",ap_domain,{ expires: 7 });
	$.cookie(pgCode+"ap_areaType",ap_areaType,{ expires: 7 });
	$.cookie(pgCode+"ap_workOrderType",ap_workOrderType,{ expires: 7 });
	$.cookie(pgCode+"ap_unplanned",ap_unplanned,{ expires: 7 });
	$.cookie(pgCode+"ap_area",ap_area,{ expires: 7 });
}

function saveAreaProgressFilters(ap_dateInterval,ap_dateFrom,ap_dateTo,ap_domain,ap_areaType,ap_workOrderType,ap_unplanned,ap_area) {
	$.cookie("9ap_dateInterval",ap_dateInterval,{ expires: 7 });
	$.cookie("9ap_dateFrom",ap_dateFrom,{ expires: 7 });
	$.cookie("9ap_dateTo",ap_dateTo,{ expires: 7 });
	$.cookie("9ap_domain",ap_domain,{ expires: 7 });
	$.cookie("9ap_areaType",ap_areaType,{ expires: 7 });
	$.cookie("9ap_workOrderType",ap_workOrderType,{ expires: 7 });
	$.cookie("9ap_unplanned",ap_unplanned,{ expires: 7 });
	$.cookie("9ap_area",ap_area,{ expires: 7 });
}
