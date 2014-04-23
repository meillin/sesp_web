<!DOCTYPE html>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@page import="com.capgemini.sesp.ast_sep.webclient.service.WorkOrderProgressService"%>
<%@page import="com.skvader.rsp.cft.webservice_client.service.provider.ServiceProvider"%>
<%@page import="com.capgemini.sesp.ast_sep.webclient.util.to.WorkOrderStatusTO"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%><html xmlns="http://www.w3.org/1999/xhtml">
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
<link rel="stylesheet" type="text/css" href="<%=contextPath%>/styles/content-area-progress.css" />

<link rel="stylesheet" type="text/css" href="<%=contextPath%>/styles/style.tidy.css" />
<link rel="stylesheet" type="text/css" href="<%=contextPath%>/styles/bubble-map.css"/>
<link rel="shortcut icon" type="image/png" href="<%=contextPath%>/images/favicon.png" />

<script src="<%=contextPath%>/js/jquery-1.9.1.min.js"></script>
<script src="<%=contextPath%>/js/vendor/jquery.nicescroll.js"></script>
<script src="<%=contextPath%>/js/jquery-migrate-1.1.1.js"></script>
<script src="<%=contextPath%>/js/jquery-ui-1.10.2.custom.js"></script>
<script src="<%=contextPath%>/js/bootstrap-datepicker.js"></script>
<script src="<%=contextPath%>/js/jquery.multiselect.js"></script>
<script src="<%=contextPath%>/js/jquery.cookie.js"></script>
<script src="<%=contextPath%>/js/common.js"></script>
<script src="<%=contextPath%>/js/search-results.js"></script>
<script src="<%=contextPath%>/js/OpenLayers.js"></script>
<script src="<%=contextPath%>/js/highchart/highcharts.js"></script>
<script src="<%=contextPath%>/js/area-progress.js"></script>


<script src="<%=contextPath%>/js/map.js"></script>
<script src="<%=contextPath%>/js/sesp_ajax.js"></script>
<script src="<%=contextPath%>/js/spin.js"></script>
<script src="<%=contextPath%>/js/ajax-loader.js"></script>

	<!--[if lt IE 9]>
	<script src="//cdnjs.cloudflare.com/ajax/libs/html5shiv/3.6.2/html5shiv.js"></script>
	<script src="//s3.amazonaws.com/nwapi/nwmatcher/nwmatcher-1.2.5-min.js"></script>
	<script src="//html5base.googlecode.com/svn-history/r38/trunk/js/selectivizr-1.0.3b.js"></script>
	<script src="//cdnjs.cloudflare.com/ajax/libs/respond.js/1.1.0/respond.min.js"></script>
	<![endif]-->
</head>
<%
	WorkOrderProgressService woProgressService = ServiceProvider.getInstance().getService(WorkOrderProgressService.class);
	List<WorkOrderStatusTO> woStatusTypes = woProgressService.getWOStatusTypes();
	Map<String, String> selectedImage = new HashMap<String, String>();
	Map<String, String> unselectedImage = new HashMap<String, String>();

	String[] symbols = new String[] {"blue","red","green","purple","yellow","pink","ltblue"};

	int imageCount = 1;
	int symbolCounter = 0;
	String imagePath = null;

	/*
	10	CANCELLED	Cancelled
	9	CLOSED	Closed
	11	ERROR	Error
	12	ERROR_STARTING	Error Starting
	8	IN_PROGRESS	In Progress
	7	SCHEDULED	Scheduled*/

	for(WorkOrderStatusTO woStatusTTO : woStatusTypes) {
	if(woStatusTTO.getCode().equals("CANCELLED")) {
	imagePath = "/images/marker-icon-blue-dot.png";
	} else if (woStatusTTO.getCode().equals("CLOSED")) {
	imagePath = "/images/marker-icon-green-dot.png";
	}  else if (woStatusTTO.getCode().equals("ERROR"))  {
	imagePath = "/images/marker-icon-red-dot.png";
	}  else if (woStatusTTO.getCode().equals("ERROR_STARTING"))  {
	imagePath = "/images/marker-icon-red-dot.png";
	}  else if (woStatusTTO.getCode().equals("IN_PROGRESS"))  {
	imagePath = "/images/marker-icon-yellow-dot.png";
	} else if (woStatusTTO.getCode().equals("SCHEDULED"))  {
	imagePath = "/images/marker-icon-yellow-dot.png";
	}

	unselectedImage.put(woStatusTTO.getStatusId(), ((HttpServletRequest)pageContext.getRequest()).getContextPath() + imagePath);
	selectedImage.put(woStatusTTO.getStatusId(),  ((HttpServletRequest)pageContext.getRequest()).getContextPath() + imagePath);
	symbolCounter++;
	}
%>
<script>
	contextPath = "<%=request.getContextPath()%>";
	area_name1 = "<%=request.getAttribute("aname")%>";
	from_err_msg="<s:text name='areaprogress.filters.from.err.msg'/>";
	to_err_msg="<s:text name='areaprogress.filters.to.err.msg'/>";
	i18nerrorFromDateOlderThanToDate = "<s:text name='webportal.analyzefieldwork.fieldworkefficiency.filters.datesvalidation'/>";
	domain_err_msg="<s:text name='areaprogress.filters.domain.err.msg'/>";
	areatype_err_msg="<s:text name='areaprogress.filters.areatype.err.msg'/>";
	workordertype_err_msg="<s:text name='areaprogress.filters.workordertype.err.msg'/>";
	dateinterval_err_msg="<s:text name='areaprogress.filters.dateinterval.err.msg'/>";
	filters_msg="<s:text name='areaprogress.filters.msg'/>";
	area_err_msg="<s:text name='webportal.error.selectarea'/>";

	var ap_dateInterval = "<%=request.getAttribute("dateInterval")%>";
	var ap_dateFrom = "<%=request.getAttribute("dateFrom")%>";
	var ap_dateTo = "<%=request.getAttribute("dateTo")%>";
	var ap_domain = "<%=request.getAttribute("domain")%>";
	var ap_areaType = "<%=request.getAttribute("areaType")%>";
	var ap_workOrderType = "<%=request.getAttribute("workOrderType")%>";
	var ap_unplanned = "<%=request.getAttribute("unplanned")%>";
	var ap_area = "<%=request.getAttribute("area")%>";

	var apreqObject = {};

	function loadWOPointsForAreaMap(domain,areaType,workOrderType,unplanned,dateInterval,dateFrom,dateTo,area){

		apreqObject.dateInterval=dateInterval;
		apreqObject.dateFrom=dateFrom;
		apreqObject.dateTo=dateTo;
		apreqObject.domain=domain;
		apreqObject.areaType=areaType;
		apreqObject.workOrderType=workOrderType;
		apreqObject.unplanned=unplanned;
		apreqObject.area=area;

	}


	function loadPointsSuccess(data) {
	//var data1 = eval(data);
	function getPointCollection(object, pointCollections) {
		var pointCollection = pointCollections[object.idCase];
		if(typeof pointCollection == "undefined") {
			<%
			for(WorkOrderStatusTO woStatusTTO : woStatusTypes) {
				String selectedIcon = selectedImage.get(woStatusTTO.getStatusId());
				String unSelectedIcon = unselectedImage.get(woStatusTTO.getStatusId());
				%>
				if(object.status == "<%=woStatusTTO.getCode()%>") {
					pointCollection = createPointsCollection(<%="\"" + unSelectedIcon+"\""%>,<%="\"" + selectedIcon+"\""%>);
				}
				<%}	%>
				pointCollections[object.idCase] = pointCollection;
				if(typeof pointCollections.objectlist == "undefined") {
					pointCollections.objectlist  = [];
				}
				pointCollections.objectlist.push(pointCollection);
				return pointCollection;
			} else {
				return pointCollection;
			}
		};

		var pointCollections = [];
		addPoints(data, getPointCollection, pointCollections, displayInfo, infoDataCallback);
	//alert("PointData:\r\n" + data);
	}

	function displayInfo(id) {
		$("#area-name").val(id);
	}

	function infoDataCallback(id,woid,wostatus, woaddress) {
		var returnData;

		html = "<div style=\"font-size:.8em;background-color:#ffffff;filter:alpha(opacity=80);opacity:.8;border-radius: 5px;\">";
		html += "<div id='bubble-header'></div>";
		var orderType = $.cookie(pgCode+"block-work-order-tab");
		if(orderType == 'progress') {
			html += "<div> <b>Progress : </b>" +wostatus +"</div> ";
		} else if(orderType=='status') {
			html += "<div> <b>Status : </b>" +wostatus +"</div> ";
		} else {
			html += "<div> <b>Progress : </b>" +wostatus +"</div> ";
		}
		html += "<div> <b>ID : </b>" + woid +"</div> ";
		html += "<div> <b>Address : </b>" + woaddress +"</div> ";

		html += "</div>";
		returnData =  html;
		return returnData;
	}
</script>
<body onload="initmap('<%=request.getSession().getAttribute("MAP_SERVER_URL")%>')">
	<div id="wrapper">
		<%@include  file="headerv311.inc" %>
		<div class="big-row">
			<div class="large-12 columns filterHeader">
				<div class="big-row">
					<div class="large-12 columns">
						<h4><i class="fi-filter colorHeading"></i> Filters</h4>
					</div>
				</div>
				<div class="big-row">
					<div class="large-4 columns">
							<div class="large-12 columns">
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
							<div class="small-6 columns">
								<label>From:</label>
								<div class="custom-input-datepicker input-append date" data-date="2012-02-12" data-date-format="yyyy-mm-dd">
									<input id="filter-date-from" type="text" class="input-datepicker"  readonly="readonly"/>
								</div>
							</div>
							<div class="small-6 columns">
								<label>To:</label>
								<div class="custom-input-datepicker input-append date"  data-date="12-02-2012" data-date-format="yyyy-mm-dd">
									<input id="filter-date-to" type="text" class="input-datepicker"  readonly="readonly"/>
								</div>
							</div>
					</div>

					<div class="large-4 columns">
							<div class="medium-6 large-12 columns">
								<lable>Domain</lable>
								<select id="filter-multiselect-domain" class="custom-multi-select" onchange="domainChanged()" name="multiselect-domain" multiple="multiple">
								</select>
							</div>
							<div class="medium-6 large-12 columns">
								<lable>Work order type</lable>
								<select id="filter-multiselect-work-order-type" class="custom-multi-select" name="multiselect-work-order-type" multiple="multiple">
								</select>
							</div>
					</div>

					<div class="large-4 columns">
						<div class="medium-6 large-12 columns">
							<lable>Area type</lable>
							<select id="filter-multiselect-area-type" onchange="areaTypeChanged()"></select>
						</div>
						<div class="medium-6 large-12 columns">
							<lable>Area</lable>
							<select id="filter-multiselect-area" class="custom-multi-select" name="multiselect-area" multiple="multiple"></select>
						</div>
						<div class="large-12 columns text-right">
							<lable>Unplanned <input type="checkbox" id="filter-checkbox-unplanned" name="unplanned" value="checked"/></lable>
						</div>
					</div>
				</div>
				<div class="big-row"><!-- start of new full width row -->
					<div class="large-12 columns fillter text-center">
						<a class="button small" id="block-filter-button-update" onclick="filter_submit()">Update</a>
					</div><!-- end of filter -->
				</div><!-- end of new full width row -->
			</div>
		</div>

	<div class="big-row">
		<div class="large-10 columns">
			<div class="page-name">
				<div class="large-12 columns">
						<ul class="page-name-heading sub-menu">
							<span>AREA PROGRESS: <span id="area-name"></span>MISSING MILESTONE AREA</span>

							<li class="progress-chart-li active" onclick="javascript:updateWorkOrder('progress')"><i class="fi-graph-bar"></i> Progress</li>
							<li class="status" onclick="javascript:updateWorkOrder('status')"><i class="fi-check"></i> Status</li>
						</ul>
				</div>
			</div>
			<!-- start of new full width row -->
			<div class="big-row">
				<div class="large-6 columns map">
					<div class="panel-outer">
						<h4 class="panel-heading"><i class="fi-marker colorHeading"></i><span> Area progress</span></h4>
						<div class="panel-inner">
							<div style="width: 100%; height: 550px; opacity:0.99;" id="map-wrapper"></div>
						</div>
					</div>
				</div>
				<div class="large-6 columns">
							<div class="panel-outer progress-chart">
								<h4 class="panel-heading"><i class="fi-graph-pie colorHeading"></i><span> Area progress</span></h4>
								<div class="panel-inner" id="work-order-chart-view">
									<!--
										<div id="block-work-order-chart-view"></div>
										<div id="block-work-order-status-chart"></div>
									-->
								</div>
							</div>
							<div class="panel-outer detailed-chart">
								<h4 class="panel-heading"><i class="fi-graph-bar colorHeading"></i><span> Detailed progress</span></h4>
								<div class="panel-inner" id="detailed-progress">
									<!--
										<div id="block-work-order-chart-view2"></div>
										<div id="block-work-order-status-chart-right"></div>
									-->
								</div>
							</div>

							<div class="panel-outer status-chart hide">
								<h4 class="panel-heading"><i class="fi-graph-pie colorHeading"></i><span> Area status</span></h4>
								<div class="panel-inner" id="area-status">
									<!--
										<div id="block-work-order-chart-view"></div>
										<div id="block-work-order-status-chart"></div>
									-->
								</div>
							</div>
				</div><!-- end of charts -->
			</div><!-- end of new full width row -->
		</div>

				<div class="large-2 columns filtered show-for-large-up">
					<h5 class="text-center">YOU HAVE FILTERED</h5>
					<dl class="accordion" data-accordion>
						<dd id="selected-domain">
							<a>Domain<span class="round label"></span></a>
							<div id="panel1" class="content">
								<ul></ul>
							</div>
						</dd>

						<dd>
							<a>Period</a>
							<div id="" class="content">
								<ul id="selected-period-type"></ul>
							</div>
						</dd>

						<dd id="selected-area-type">
							<a>Area type <span class="round label"></span></a>
							<div class="content">
								<ul></ul>
							</div>
						</dd>

						<dd id="selected-area">
							<a>Area <span class="round label"></span></a>
							<div class="content">
								<ul></ul>
							</div>
						</dd>

						<dd id="selected-work-order-type">
							<a>Work order type <span class="round label"></span></a>
							<div class="content">
								<ul></ul>
							</div>
						</dd>

					</dl>
				</div>
	</div>


	<div class="wrapper-blur"></div>

</div><!-- end of wrapper -->
<script>
	loadvalues();
	drawAreaProgress();
	drawDetailedProgress();

	$('.sub-menu li').click(function(){
			var active = $(this);
			if(active.hasClass('progress-chart-li')){
				$('.progress-chart, .detailed-chart').show();
				$('.status-chart').hide();
			} else {
				$('.status-chart').show();
				drawAreaStatus();
				$('.progress-chart, .detailed-chart').hide();
			}
	});

</script>
<script src="<%=contextPath%>/js/highchart/area-progress-chart.js"></script>

<!--[if lt IE 9]>
<script type="text/javascript" src="https://raw.githubusercontent.com/chuckcarpenter/REM-unit-polyfill/master/js/rem.min.js"></script>
<![endif]-->
</body>
</html>
