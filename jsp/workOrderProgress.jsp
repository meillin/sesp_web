<!DOCTYPE html>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>Smart Energy Services Platform</title>

		<!-- Enable html5 tags for 6-7-8 -->
		<!--[if lte IE 8]>
		<script type="text/javascript">
		document.createElement("header");
		document.createElement("footer");
		document.createElement("section");
		document.createElement("aside");
		document.createElement("nav");
		document.createElement("article");
		document.createElement("figure");
		</script>
		<![endif]-->
		<%  String contextPath = request.getContextPath(); %>
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/styles/foundation.css" />
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/foundation-icons/foundation-icons.css">
		<link rel="stylesheet" type="text/css" href="<%=contextPath%>/styles/jquery.multiselect.css"/>
		<link rel="stylesheet" type="text/css" href="<%=contextPath%>/styles/general.css" />
		<link rel="stylesheet" type="text/css" href="<%=contextPath%>/styles/header.css" />
		<link rel="stylesheet" type="text/css" href="<%=contextPath%>/styles/datepicker.css" />
		<link rel="stylesheet" type="text/css" href="<%=contextPath%>/styles/content-work-order-progress.css" />
		<link rel="stylesheet" type="text/css" href="<%=contextPath%>/styles/style.tidy.css" />
		<link rel="stylesheet" type="text/css" href="<%=contextPath%>/styles/bubble-map.css"/>
		<link rel="shortcut icon" type="image/png" href="<%=contextPath%>/images/favicon.png" />

		<script type="text/javascript" src="<%=contextPath%>/js/jquery-1.9.1.min.js"></script>
		<script type="text/javascript" src="<%=contextPath%>/js/jquery-migrate-1.1.1.js"></script>
		<script type="text/javascript" src="<%=contextPath%>/js/jquery-ui-1.10.2.custom.js"></script>
		<script type="text/javascript" src="<%=contextPath%>/js/bootstrap-datepicker.js"></script>
		<script type="text/javascript" src="<%=contextPath%>/js/jquery.multiselect.js"></script>
		<script type="text/javascript" src="<%=contextPath%>/js/jquery.cookie.js"></script>
		<script type="text/javascript" src="<%=contextPath%>/js/colResizable-1.3.min.js"></script>
		<script type="text/javascript" src="<%=contextPath%>/js/init.js"></script>
		<script type="text/javascript" src="<%=contextPath%>/js/common.js"></script>
		<script type="text/javascript" src="<%=contextPath%>/js/fusionchartsxt/charts/FusionCharts.js"></script>
		<script type="text/javascript" src="<%=contextPath%>/js/OpenLayers.js"></script>
		<script type="text/javascript" src="<%=contextPath%>/js/sesp_ajax.js"></script>
		<script type="text/javascript" src="<%=contextPath%>/js/spin.js"></script>
		<script type="text/javascript" src="<%=contextPath%>/js/map.js"></script>
		<script type="text/javascript" src="<%=contextPath%>/js/ajax-loader.js"></script>
		<script type="text/javascript" src="<%=contextPath%>/js/work-order-progress.js"></script>
		<script type="text/javascript" src="<%=contextPath%>/js/search-results.js"></script>

		<script type="text/javascript" src="<%=contextPath%>/js/highchart/highcharts.js"></script>
		<script type="text/javascript" src="<%=contextPath%>/js/highchart/exporting.js"></script>

	</head>
<script>
	contextPath = "<%=contextPath%>";
	from_err_msg="<s:text name='workorderprogress.filters.from.err.msg'/>";
	to_err_msg="<s:text name='workorderprogress.filters.to.err.msg'/>";
	i18nerrorFromDateOlderThanToDate = "<s:text name='webportal.analyzefieldwork.fieldworkefficiency.filters.datesvalidation'/>";
	domain_err_msg="<s:text name='workorderprogress.filters.domain.err.msg'/>";
	areatype_err_msg="<s:text name='workorderprogress.filters.areatype.err.msg'/>";
	workordertype_err_msg="<s:text name='workorderprogress.filters.workordertype.err.msg'/>";
	dateinterval_err_msg="<s:text name='workorderprogress.filters.dateinterval.err.msg'/>";
	filters_msg="<s:text name='workorderprogress.filters.msg'/>";
	area_err_msg="<s:text name='webportal.error.selectarea'/>";
	var apreqObject = {};

	function loadPointsForAreaMap(domain,areaType,workOrderType,unplanned,dateInterval,dateFrom,dateTo,area){

		apreqObject.dateInterval=dateInterval;
		apreqObject.dateFrom=dateFrom;
		apreqObject.dateTo=dateTo;
		apreqObject.domain=domain;
		apreqObject.areaType=areaType;
		apreqObject.workOrderType=workOrderType;
		apreqObject.unplanned=unplanned;
		apreqObject.area=area;

		    	var obj= {};
			    obj.url=contextPath+"/std/WOMapAreas.action";

			    obj.pdata = 'dateInterval='+dateInterval+'&dateFrom='+dateFrom+'&dateTo='+dateTo+'&domain='+domain+
		   		'&areatypes='+areaType+'&workOrderType='+workOrderType+'&unplanned='+unplanned+'&area='+area;
			    areaWOMapInfoRParams = 	'dateInterval='+dateInterval+'&dateFrom='+dateFrom+'&dateTo='+dateTo+'&domain='+domain+
		   		'&workOrderType='+workOrderType+'&unplanned='+unplanned+'&area='+area;
			    //obj.pdata = "domains="+domain+"&areatypes="+areaType;
		obj.successfunc = createWOAreaJSON;
		obj.errorfunc = errorDetails;

		run_ajax(obj);
		return;
	}


	function fetchBubbleContent(id) {
	var obj= {};
	obj.url=contextPath+"/std/WOMapAreasStatusInfo.action";
	obj.pdata = areaWOMapInfoRParams+"&area="+id;
	obj.successfunc = function(msg){
		if(msg == "") {
	return;
	}
	var o = eval(msg);
	if(o == null)
	return;

	populateBubbleContent(o);

	};
	obj.errorfunc = populateErrorBubbleContent;
	run_ajax_Sync(obj);
	return;
	}

	function woAreaProgressCallback(aname,aid) {
	var returnData;

	//areaprogressLink = contextPath+"/std/AreaProgress.action?"+areaWOMapInfoRParams+"&aid="+aid+"&aname="+aname;
		//alert(areaprogressLink);
		html = "<form id=\"bubbleForm\" name=\"bubbleForm\" method=\"post\" action=\""+contextPath+"/std/AreaProgress.action\">";
		html += "<div id=\"bubble\" class=\"bubble-chart text-grey\" style=\"width:350px; height:350px;\">";
		html +=	"<div id=\"bubble-header\"></div>";
		html += "<div class=\"bubble-title\">";
		html += "	<div class=\"bubble-category\">Area name :</div>";
		html +=	"	<div class=\"bubble-value text-light-grey\"><a href=\"javascript:document.getElementById('bubbleForm').submit();\">"+aname+"</a></div>";
		html +=	"</div>";
		html +=	"<div class=\"bubble-value text-light-grey\" id=\"bubble-content\">";
		html += "</div>";
		html += "<div id=\"bubble-arrow\">";

		html+= "<input type=\"hidden\" name=\"aid\" value=\""+aname+"\"/>";
		html+= "<input type=\"hidden\" name=\"aname\" value=\""+aid+"\"/>";
		html+= "<input type=\"hidden\" name=\"dateInterval\" value=\""+apreqObject.dateInterval+"\"/>";
		html+= "<input type=\"hidden\" name=\"dateFrom\" value=\""+apreqObject.dateFrom+"\"/>";
		html+= "<input type=\"hidden\" name=\"dateTo\" value=\""+apreqObject.dateTo+"\"/>";
		html+= "<input type=\"hidden\" name=\"domain\" value=\""+apreqObject.domain+"\"/>";
		html+= "<input type=\"hidden\" name=\"areaType\" value=\""+apreqObject.areaType+"\"/>";
		html+= "<input type=\"hidden\" name=\"workOrderType\" value=\""+apreqObject.workOrderType+"\"/>";
		html+= "<input type=\"hidden\" name=\"unplanned\" value=\""+apreqObject.unplanned+"\"/>";
		html+= "<input type=\"hidden\" name=\"area\" value=\""+apreqObject.area+"\"/>";

		html += "</div>";
		html += "</div></form>";

		returnData =  html;

		saveAreaProgressFilters(apreqObject.dateInterval,apreqObject.dateFrom,apreqObject.dateTo,apreqObject.domain,apreqObject.areaType,apreqObject.workOrderType,apreqObject.unplanned,apreqObject.area);

	return returnData;
	}

	function populateErrorBubbleContent(data) {
	document.getElementById("bubble-content").innerHTML=data.responseText;
	}


	function populateBubbleContent(data) {
	//Work Order Progress
	var bubbleWOAreaChart = new FusionCharts(contextPath+"/js/fusionchartsxt/charts/Doughnut2D.swf", "mapWOareaProgressChartId"+bci++,"300","300");
	bubbleWOAreaChart.setDataXML(data.workOrderProgress);
	bubbleWOAreaChart.render("bubble-content");
	}

	function submitWO2AreaProgress(formRef){
	if(formRef.username.value=="")
	{
	alert(i18nerrorPleaseEnterUsername);
	formRef.username.focus();
	return;
	} if(formRef.password.value=="")
	{
	alert(i18nerrorPleaseEnterPassword);
	formRef.password.focus();
	return;
	}
	document.getElementById("divenable").style.display="none";
	document.getElementById("divdisable").style.display="block";
	loginSpinner();
	formRef.submit();
	}
	var bci = 0;
</script>

<body onload="loadvalues(),initmap('<%=request.getSession().getAttribute("MAP_SERVER_URL")%>')">

	<div id="wrapper">
		<%@ include file="headerv311.inc"%>
		<div class="big-row">
			<div class="large-12 columns filterHeader">
				<div class="big-row">
					<div class="large-12 columns">
						<h4><i class="fi-filter colorHeading"></i> Filters</h4>
					</div>
				</div>
				<div class="big-row">
					<div class="large-4 columns">
						<label> <s:text name="workorderprogress.filters.dateinterval"/></label>
						<select id="filter-select-date-interval" onchange="show()">
							<option value="lastweek" selected="selected"><s:text name="webportal.alarm.dateinterval.lastweek"/></option>
							<option value="today"><s:text name="webportal.alarm.dateinterval.today"/></option>
							<option value="lastmonth"><s:text name="webportal.alarm.dateinterval.lastmonth"/></option>
							<option value="lastquarter"><s:text name="webportal.alarm.dateinterval.lastquarter"/></option>
							<option value="lastyear"><s:text name="webportal.alarm.dateinterval.lastyear"/></option>
							<option value="custominterval"><s:text name="webportal.alarm.dateinterval.custominterval"/></option>
						</select>
						<div class="row">
							<div class="medium-6 columns">
								<label><s:text name="workorderprogress.filters.from"/> :</label>
								<div class="custom-input-datepicker input-append date" data-date="2012-02-12" data-date-format="yyyy-mm-dd">
									<input id="filter-date-from" type="text" class="input-datepicker text-red"  readonly="readonly"/>
								</div>
							</div>
							<div class="medium-6 columns">
								<label><s:text name="workorderprogress.filters.to"/> :</label>
								<div class="custom-input-datepicker input-append date"  data-date="12-02-2012" data-date-format="yyyy-mm-dd">
									<input id="filter-date-to" type="text" class="input-datepicker text-red"  readonly="readonly"/>
								</div>
							</div>
						</div>
					</div>

					<div class="large-4 columns">
						<lable><s:text name="workorderprogress.filters.domain"/></lable>
						<select id="filter-multiselect-domain" class="custom-multi-select" onchange="domainChanged()" name="multiselect-domain" multiple="multiple">
						</select>
						<lable><s:text name="workorderprogress.filters.workordertype"/></lable>
						<select id="filter-multiselect-work-order-type" class="custom-multi-select" name="multiselect-work-order-type" multiple="multiple">
						</select>
					</div>

					<div class="large-4 columns">
						<lable><s:text name="workorderprogress.filters.areatype"/></lable>
						<select id="filter-multiselect-area-type" class="custom-multi-select" onchange="areaTypeChanged()" name="multiselect-area-type" multiple="multiple">
						</select>

						<lable><s:text name="webportal.alarm.area"/></lable>
						<select id="filter-multiselect-area" class="custom-multi-select" name="multiselect-area" multiple="multiple"></select>
						<lable>Unplanned<input type="checkbox" id="filter-checkbox-unplanned" name="unplanned" value="checked"/></lable>
					</div>
				</div>

				<div class="big-row"><!-- start of new full width row -->
					<div class="large-12 columns fillter">
						<div class="submit-button">
							<div class="row text-center">
								<div class="large-12 columns">
									<a class="button" id="block-filter-button-update" onclick="filter_submit()"><s:text name="workorderprogress.filters.update"/></a>
								</div>
							</div>
						</div><!-- end of submit-button -->
					</div><!-- end of filter -->
				</div><!-- end of new full width row -->
			</div>
		</div>

		<div class="big-row">

			<div class="large-6 columns">

					<div class="row">
						<div class="large-12 columns">
							<div class="row column-header">
								<div class="large-12 columns">
									<i class="fi-graph-pie"></i>
									<s:text name="workorderprogress.workorderstatus"/>
								</div>
							</div>
							<div class="row">
								<div id="work-order-status">
								</div>
								<!--
								<div id="block-work-order-status-chart"></div>
								<div id="block-work-order-status-chart-right" class="right"></div>-->
							</div>
						</div>
					</div>

					<div class="row">
						<div class="large-12 columns">
							<div class="row column-header">
								<div class="large-12 columns">
									<i class="fi-graph-pie"></i>
									<s:text name="workorderprogress.areaprogress"/>
								</div>
							</div>
							<div class="row">
								<div style = "height:660px;opacity:0.99;" id="map-wrapper"></div>
							</div>
					</div>
				</div>
			</div>

			<div class="large-6 columns">
				<div class="row column-header">
					<div class="large-12 columns">
						<i class="fi-graph-pie"></i>
						<s:text name="workorderprogress.progressoverview"/>
					</div>
				</div>
				<div class="row">
					<div id="total-progress"></div>
					<hr>
					<div id="work-order-progress"></div>
					<hr>
					<div id="detailed-progress"></div>

						<!--
						<div id="block-progress-overview-total-progress"></div>
						<div id="block-progress-overview-work-order-progress"></div>
						<div id="block-progress-overview-detailed-progress"></div>
						<div id="block-progress-overview-detailed-timebased-perfomance-workorders"></div>
						<div id="block-progress-overview-detailed-timebased-perfomance-notperformed"></div>
					-->
					</div>
			</div>

		</div><!--end of big-row -->
	</div>
	<script type="text/javascript" src="<%=contextPath%>/js/highchart/example-chart.js"></script>
</body>
</html>
