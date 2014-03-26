var contextPath = "";

var i18nSelectDeviceType;
var i18nSelectDomain;
var i18nSelectDeviceModel;
var i18nSelectStockSite;
var i18nerrorPleaseChooseMandatoryFields
var i18nerrorPleaseChooseCategory;
var i18nerrorPleaseChooseBreakup;
var i18nerrorChartError;
var i18nId;
var i18nName;
var i18nType;
var i18nInfo;
var i18nAddress;
var i18nPostCode;
var i18nPostAddress;
var i18nContactPerson;
var i18nContactWorkPhone;
var i18nContactMobilePhone;
var i18nStockAll;

$(document).ready(function() {
	$('.head').click(function(e) {
		e.preventDefault();
		$(this).closest('li').find('.contentMT').slideToggle();
	});
});

function onLoadSpecial() {			  			
	//init();
	loadDomainList();	
	loadDeviceTypesList();		
}

function errorDetails(data) {
	alert(i18nerrorChartError);
}

function clearWarehousesList() {
	var items = '<option value=null>'+i18nSelectStockSite+'</option>';
	$("#warehouses").empty();
	$("#warehouses").html(items);
}

function clearDeviceModelsList() {
	var items = '<option value=null>'+i18nSelectDeviceModel+'</option>';
	$("#devicemodels").empty();
	$("#devicemodels").html(items);
}

function loadDomainList() {	
	var obj= {};
	obj.url=contextPath+"/std/GetDomains.action";		
	obj.successfunc = function(data) {
		var items;
		items += '<option value=null>'+i18nSelectDomain+'</option>';
		items += '<option value=all>'+i18nStockAll+'</option>';
		$.each(data, function(i, item) {
			items += '<option value="' + item.id + '">'	+ item.name + '</option>';
			});
		$("#domains").html(items);

	};
	obj.errorfunc = errorDetails;
	run_ajax_json(obj);
	return;	
}

function loadDeviceModelsList(domainCode) {
	
	var obj= {};
	obj.url=contextPath+"/std/GetDeviceModels.action";
	obj.pdata = "dc="+domainCode;
	obj.successfunc = function(data) {
	
			var items;			

			items += '<option value=null>'+i18nSelectDeviceModel+'</option>';
			items += '<option value=all>'+i18nStockAll+'</option>';
			$.each(data, function(i, item) {
				items += '<option value="' + item.id + '">'
						+ item.name + '</option>';
			});

			$("#devicemodels").html(items);

		};
	obj.errorfunc = errorDetails;
	run_ajax_json(obj);
	return;
					
}

function loadDeviceTypesList() {
	var obj= {};
	obj.url=contextPath+"/std/GetDeviceTypes.action";		
	obj.successfunc = function(data) {
		var items;
		items += '<option value=null>'+i18nSelectDeviceType+'</option>';
		items += '<option value=all>'+i18nStockAll+'</option>';
		$.each(data, function(i, item) {
			items += '<option value="' + item.id + '">'	+ item.name + '</option>';
			});
		$("#devicetypes").html(items);

	};
	obj.errorfunc = errorDetails;
	run_ajax_json(obj);
	return;	
}

function loadWarehousesList(domainCode) {
	
	var obj= {};
	obj.url=contextPath+"/std/GetWarehouses.action";
	obj.pdata = "dc="+domainCode;
	obj.successfunc = function(data) {
	
			var items;			

			items += '<option value=null>'+i18nSelectStockSite+'</option>';
			items += '<option value=all>'+i18nStockAll+'</option>';
			$.each(data, function(i, item) {
				items += '<option value="' + item.id + '">'
						+ item.name + '</option>';
			});

			$("#warehouses").html(items);

		};
	obj.errorfunc = errorDetails;
	run_ajax_json(obj);
	return;
}

$(document).ready(function() {

	$("input[name$='category']").click(function() {
		var ls_category = $(this).val();
		setBreakupvalue(ls_category);
	});
});

function setBreakupvalue(as_category) {
	jQuery("input[name='breakup']").each(function(i) {
		var as_brkup = $(this).val();

		$("label[name$='" + as_brkup + "_T']").hide();

		if (as_brkup == 'N') {
			jQuery(this).attr('checked', 'checked');
		}

		if (as_category != as_brkup) {
			if (as_brkup == 'IE') {
				if (as_category == 'UT' || as_category == 'M') {
					$("label[name$='" + as_brkup + "_T']").show();
				}
			} else {
				$("label[name$='" + as_brkup + "_T']").show();
			}
		}

	});
}

function displayInfo(id) {
		// alert(id);
		$("#warehouses").val(id);
		//submitLogistics();
	}


function infoDataCallback(id) {
	var returnData;
	var obj= {};
	obj.url=contextPath+"/std/GetStockInformation.action";
	obj.pdata = "id="+id;
	obj.successfunc = function(msg){ 
   		if(msg == "") {
			return;
		}
		var o = eval(msg);
		if(o == null)
			return;
		
		
		html = "<div style=\"font-size:.8em;background-color:#ffffff;filter:alpha(opacity=80);opacity:.8;border-radius: 5px;\">";
		html += "<div> "+i18nId+":" + v(o.id) +"</div> ";
		html += "<div> "+i18nName+":" + v(o.name) +"</div> ";
		html += "<div> "+i18nType+":" + v(o.type) +"</div> ";
		html += "<div> "+i18nInfo+":" + v(o.info) +"</div> ";
		html += "<div> "+i18nAddress+":" + v(o.address) +"</div> ";
		html += "<div> "+i18nPostCode+":" + v(o.postCode) +"</div> ";
		html += "<div> "+i18nPostAddress+":" + v(o.postAddress) +"</div> ";
		html += "<div> "+i18nContactPerson+":" + v(o.contactPerson) +"</div> ";
		html += "<div> "+i18nContactMobilePhone+":" + v(o.cellPhone) +"</div> ";
		html += "<div> "+i18nContactWorkPhone+":" + v(o.workPhone) +"</div> ";
		html += "</div>";
		returnData =  html;
		
		function v(d) {
			if(d == null || d == "undefined") {
				return "";
			}
			return d;
		}		
   };
	obj.errorfunc = errorDetails;
	run_ajax_Sync(obj);
	return returnData;
}

	function onChangeDomain()
	{
		var ls_domain = $("#domains").val();
		if(ls_domain!='null') {			
			loadDeviceModelsList(ls_domain);
			loadWarehousesList(ls_domain);
		} else {			
			clearDeviceModelsList();
			clearWarehousesList();
		}
		loadPoints(ls_domain);
	}
	
		
	

	function submitLogistics() {
		
		var validation = false; 
		validation = stockValidation();
		if(validation) {
			var ls_domain = $("#domains").val();
			var ls_devicetypes = $("#devicetypes").val();
			var ls_devicemodels = $("#devicemodels").val();
			var ls_warehouses = $("#warehouses").val();
			var ls_breakup = $('input:radio[name=breakup]:checked').val();
			var ls_category = $('input:radio[name=category]:checked').val();
			
			if(ls_breakup=='IE') {
				chartType="Multiseries3D";
			} else {
				chartType="Stacked3D";
			}
			
			var obj= {};
			obj.url=contextPath+"/std/GetStockChart.action";
			obj.pdata = 'domain='+ls_domain+'&xaxis='+ls_category+'&yaxis='+ls_breakup+'&warehouses='+ls_warehouses+
			   		'&devicemodels='+ls_devicemodels+'&devicetypes='+ls_devicetypes;
			obj.successfunc = drawChart;	
			obj.errorfunc = errorDetails;
			run_ajax(obj);
			return;	
		}

	}
	
	function stockValidation() {
		
		var ls_domain = $("#domains").val();
		var ls_devicetypes = $("#devicetypes").val();
		var ls_devicemodels = $("#devicemodels").val();
		var ls_warehouses = $("#warehouses").val();
		
		if(ls_domain=='null'||ls_warehouses=='null'||ls_warehouses=='') {
			alert(i18nerrorPleaseChooseMandatoryFields);
			return false;
		}
		
		if($('input:radio[name=category]:checked').val()== null || $('input:radio[name=category]:checked').val()== 'undefined'){
			alert(i18nerrorPleaseChooseCategory);			
			return false;
		}
		
		if($('input:radio[name=breakup]:checked').val()== null || $('input:radio[name=breakup]:checked').val()== 'undefined'){
			alert(i18nerrorPleaseChooseBreakup);			
			return false;
		}
		
		return true;		
	}
	
	var stockChart;
	var chartType = "Stacked3D";
	
	function drawChart(data) {
		
		if(chartType=="Stacked3D") {
			stockChart = new FusionCharts(contextPath+"/js/fusioncharts/charts/FCF_StackedColumn3D.swf", "stockchartId", "560", "445");
		} else if(chartType=="Multiseries3D") {
			stockChart = new FusionCharts(contextPath+"/js/fusioncharts/charts/FCF_MSColumn3D.swf", "stockchartId", "560", "445");
		} else {
			stockChart = new FusionCharts(contextPath+"/js/fusioncharts/charts/FCF_StackedColumn3D.swf", "stockchartId", "560", "445");
		}
		
		stockChart.setDataXML(data);
		//myChart.setDataXML("<graph caption='Business Results 2005 v 2006' PYAxisName='Revenue' SYAxisName='Quantity'xAxisName='Month' showValues='0' decimalPrecision='0' bgcolor='F3f3f3' bgAlpha='70' showColumnShadow='1' divlinecolor='c5c5c5' divLineAlpha='60' showAlternateHGridColor='1' alternateHGridColor='f8f8f8' alternateHGridAlpha='60' SYAxisMaxValue='750'> <categories><category name='Jan' /><category name='Feb' /><category name='Mar' /><category name='Apr' /><category name='May' /><category name='Jun' /><category name='Jul' /><category name='Aug' /> <category name='Sep' /> <category name='Oct' /><category name='Nov' /><category name='Dec' /></categories><dataset seriesName='2006' parentYAxis='P' color='c4e3f7' numberPrefix='$'><set value='27400' /><set value='29800' /><set value='25800' /><set value='26800' /><set value='29600' /><set value='32600' /><set value='31800' /><set value='36700' /><set value='29700' /><set value='31900' /><set value='34800' /><set value='24800' /></dataset><dataset seriesName='2005' parentYAxis='P' color='Fad35e' numberPrefix='$'><set value='10000' /><set value='11500' /><set value='12500' /><set value='15000' /><set value='11000' /><set value='9800'  /><set value='11800' /><set value='19700' /><set value='21700' /><set value='21900' /><set value='22900' /><set value='20800' /></dataset><dataset seriesName='Total Quantity' parentYAxis='S' color='8BBA00' anchorSides='10' anchorRadius='3' anchorBorderColor='009900' ><set value='270' /><set value='320' /><set value='290' /><set value='320' /><set value='310' /><set value='320' /><set value='340' /><set value='470' /><set value='420' /><set value='440' /><set value='480 '/><set value='360' /> </dataset></graph>");
		//myChart.setDataXML("<graph caption='Monthly Unit Sales' xAxisName='Month' yAxisName='Units' showNames='1' decimalPrecision='0' formatNumberScale='0'><set name='Jan' value='462' color='AFD8F8' /><set name='Feb' value='857' color='F6BD0F' /><set name='Mar' value='671' color='8BBA00' /><set name='Apr' value='494' color='FF8E46'/><set name='May' value='761' color='008E8E'/><set name='Jun' value='960' color='D64646'/><set name='Jul' value='629' color='8E468E'/><set name='Aug' value='622' color='588526'/><set name='Sep' value='376' color='B3AA00'/><set name='Oct' value='494' color='008ED6'/><set name='Nov' value='761' color='9D080D'/><set name='Dec' value='960' color='A186BE'/></graph>");
		stockChart.render("chartdiv");
	}