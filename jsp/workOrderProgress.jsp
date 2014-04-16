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

	<script src="<%=contextPath%>/js/jquery-1.9.1.min.js"></script>
	<script src="<%=contextPath%>/js/jquery-migrate-1.1.1.js"></script>
	<script src="<%=contextPath%>/js/jquery-ui-1.10.2.custom.js"></script>
	<script src="<%=contextPath%>/js/bootstrap-datepicker.js"></script>
	<script src="<%=contextPath%>/js/jquery.multiselect.js"></script>
	<script src="<%=contextPath%>/js/jquery.cookie.js"></script>
	<script src="<%=contextPath%>/js/init.js"></script>
	<script src="<%=contextPath%>/js/common.js"></script>
	<script src="<%=contextPath%>/js/fusionchartsxt/charts/FusionCharts.js"></script>
	<script src="<%=contextPath%>/js/OpenLayers.js"></script>
	<script src="<%=contextPath%>/js/sesp_ajax.js"></script>
	<script src="<%=contextPath%>/js/spin.js"></script>
	<script src="<%=contextPath%>/js/map.js"></script>
	<script src="<%=contextPath%>/js/ajax-loader.js"></script>
	<script src="<%=contextPath%>/js/work-order-progress.js"></script>
	<script src="<%=contextPath%>/js/search-results.js"></script>

	<script src="<%=contextPath%>/js/highchart/highcharts.js"></script>

	<!--[if lt IE 9]>
	<script src="//cdnjs.cloudflare.com/ajax/libs/html5shiv/3.6.2/html5shiv.js"></script>
	<script src="//s3.amazonaws.com/nwapi/nwmatcher/nwmatcher-1.2.5-min.js"></script>
	<script src="//html5base.googlecode.com/svn-history/r38/trunk/js/selectivizr-1.0.3b.js"></script>
	<script src="//cdnjs.cloudflare.com/ajax/libs/respond.js/1.1.0/respond.min.js"></script>
	<![endif]-->
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
						<div class="row">
							<div class="medium-12 columns">
								<label>Date interval</label>
								<select id="filter-select-date-interval" onchange="show()">
									<option value="lastweek" selected="selected">Last week</option>
									<option value="today">Today</option>
									<option value="lastmonth">Last month</option>
									<option value="lastquarter">Last quarter</option>
									<option value="lastyear">Last year</option>
									<option value="custominterval">Custom interval</option>
								</select>
							</div>
						</div>
						<div class="row">
							<div class="medium-6 columns">
								<label>From:</label>
								<div class="custom-input-datepicker input-append date" data-date="2012-02-12" data-date-format="yyyy-mm-dd">
									<input id="filter-date-from" type="text" class="input-datepicker text-red"  readonly="readonly"/>
								</div>
							</div>
							<div class="medium-6 columns">
								<label>To:</label>
								<div class="custom-input-datepicker input-append date"  data-date="12-02-2012" data-date-format="yyyy-mm-dd">
									<input id="filter-date-to" type="text" class="input-datepicker text-red"  readonly="readonly"/>
								</div>
							</div>
						</div>
					</div>

					<div class="large-4 columns">
						<lable>Domain</lable>
						<select id="filter-multiselect-domain" class="custom-multi-select" onchange="domainChanged()" name="multiselect-domain" multiple="multiple">
						</select>
						<lable>Work order type</lable>
						<select id="filter-multiselect-work-order-type" class="custom-multi-select" name="multiselect-work-order-type" multiple="multiple">
						</select>
					</div>

					<div class="large-4 columns">
						<lable>Area type</lable>
						<select id="filter-multiselect-area-type" onchange="areaTypeChanged()">
						</select>

						<lable>Area</lable>
						<select id="filter-multiselect-area" class="custom-multi-select" name="multiselect-area" multiple="multiple"></select>
						<lable>Unplanned <input type="checkbox" id="filter-checkbox-unplanned" name="unplanned" value="checked"/></lable>
					</div>
				</div>

				<div class="big-row"><!-- start of new full width row -->
					<div class="large-12 columns fillter text-center">
						<a class="button" id="block-filter-button-update" onclick="filter_submit()">Update</a>
					</div><!-- end of filter -->
				</div><!-- end of new full width row -->
			</div>
		</div>

		<div class="big-row">

			<div class="large-10 columns">
				<div class="big-row">
					<div class="large-12 columns">
						<ul class="page-name-heading sub-menu">
							<span>WORK ORDER/AREA</span>
							<li class="progress-chart-li active"><i class="fi-graph-bar"></i> Progress</li>
							<li class="status-chart"><i class="fi-check"></i> Status</li>
							<li class="details-chart"><i class="fi-page-search"></i> Details</li>
						</ul>
					</div>
				</div>

				<div class="big-row show progress-chart">
					<div class="large-6 columns">
						<div class="panel-outer">
							<h4 class="panel-heading"><i class="fi-graph-pie colorHeading"></i><span> Work order progress</span></h4>
							<div class="panel-inner" id="work-order-progress"></div>
						</div>
					</div>

					<div class="large-6 columns">
						<div class="panel-outer">
							<h4 class="panel-heading"><i class="fi-graph-horizontal colorHeading"></i><span> Area progress</span></h4>
							<div class="panel-inner" id="area-progress"></div>
						</div>
					</div>
				</div>

				<div class="big-row hide status">
					<div class="large-6 columns">
						<div class="panel-outer">
							<h4 class="panel-heading"><i class="fi-graph-pie colorHeading"></i><span> Work order status</span></h4>
							<div class="panel-inner" id="work-order-status">
								<!--
								<div id="block-work-order-status-chart"></div>
								<div id="block-work-order-status-chart-right" class="right"></div>-->
							</div>
						</div>
					</div>

					<div class="large-6 columns">
						<div class="panel-outer">
							<h4 class="panel-heading"><i class="fi-graph-pie colorHeading"></i><span> Area status</span></h4>
							<div class="panel-inner" id="area-status"></div>
						</div>
					</div>
				</div>

				<div class="big-row hide details">
					<div class="large-6 columns">
								<!--
							<div class="panel-outer">
								<h4 class="panel-heading"><i class="fi-graph-horizontal"></i> Total progress</h4>
								<div class="panel-inner" id="total-progress"></div>
							</div>
						-->
						<div class="panel-outer">
							<h4 class="panel-heading">
								<div class="large-9 columns">
									<i class="fi-graph-bar colorHeading"></i><span>Detailed progress</span>
								</div>
								<div class="large-3 columns">
									<select>
										<option>Week</option>
										<option>Month</option>
										<option>Year</option>
									</select>
								</div>
							</h4>
								<div class="panel-inner" id="detailed-progress"></div>
						</div>
					</div>
				</div>
			</div>

			<div class="large-2 columns filtered show-for-large-up">
									<h5 class="text-center">YOU HAVE FILTERED</h5>
					<dl class="accordion" data-accordion>
						<dd>
							<a href="#panel1">Domain<span class="round label">3</span></a>
							<div id="panel1 selected-domain" class="content">
								<ul>
									<li>Domain1</li>
									<li>Domain2</li>
									<li>Domain3</li>
								</ul>
							</div>
						</dd>
						<dd>
							<a href="#panel2">Planning period type</a>
							<div id="panel2 selected-period-type" class="content">
								<ul>
									<li>Week</li>
								</ul>
							</div>
						</dd>
						<dd>
							<a href="#panel3">Date interval</a>
							<div id="panel3 selected-date" class="content">
								<ul>
									<li>From: 2009-01-01</li>
									<li>To: 2017-12-31</li>
								</ul>
							</div>
						</dd>
						<dd>
							<a href="#panel4">Planning periods <span class="round label">6</span></a>
							<div id="panel4 selected-date" class="content">
								<ul>
									<li>BG46 2013-11-10/2013-11-17 Eon-Eltel</li>
									<li>BG46 2013-11-10/2013-11-17 Eon-Eltel</li>
									<li>BG46 2013-11-10/2013-11-17 Eon-Eltel</li>
									<li>BG46 2013-11-10/2013-11-17 Eon-Eltel</li>
									<li>BG46 2013-11-10/2013-11-17 Eon-Eltel</li>
									<li>BG46 2013-11-10/2013-11-17 Eon-Eltel</li>
								</ul>
							</div>
						</dd>
						<dd>
							<a href="#panel4">Utlity type <span class="round label">4</span></a>
							<div id="panel4 selected-date" class="content">
								<ul>
									<li>Electrical</li>
									<li>Gas</li>
									<li>Heat</li>
									<li>Water</li>
								</ul>
							</div>
						</dd>
					</dl>

			</div>

		</div>
	<div class="wrapper-blur"></div>
	</div><!-- end of wrapper -->
	<script src="<%=contextPath%>/js/highchart/work-order-chart.js"></script>

	<!--[if lt IE 9]>
	<script type="text/javascript" src="https://raw.githubusercontent.com/chuckcarpenter/REM-unit-polyfill/master/js/rem.min.js"></script>
	<![endif]-->
</body>
</html>