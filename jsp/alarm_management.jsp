<!DOCTYPE html>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@page import="java.util.*,java.text.*" %>
<%@page import="com.capgemini.sesp.ast_sep.webclient.util.*"%>
<%@page import="com.capgemini.sesp.ast_sep.webclient.util.to.*"%>
<%@page import="com.skvader.rsp.cft.webservice_client.service.provider.ServiceProvider" %>
<%@page import="com.capgemini.sesp.ast_sep.webclient.service.AlertService"%>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

		<title><s:text name='webportal.head.title'/></title>
		<link rel="shortcut icon" type="image/png" href="<%=request.getContextPath()%>/images/favicon.png" />

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
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/styles/foundation.css" />
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/foundation-icons/foundation-icons.css">
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/styles/jquery.multiselect.css"/>
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/styles/general.css" />
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/styles/header.css" />
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/styles/datepicker.css" />
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/styles/content-alarm-management.css" />
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/styles/style.tidy.css" />
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/styles/bubble-map.css"/>

		<script src="<%=request.getContextPath()%>/js/jquery-1.9.1.min.js"></script>
		<script src="<%=request.getContextPath()%>/js/jquery-migrate-1.1.1.js"></script>
		<script src="<%=request.getContextPath()%>/js/jquery-ui-1.10.2.custom.js"></script>
		<script src="<%=request.getContextPath()%>/js/jquery.selectBox.js"></script>
		<script src="<%=request.getContextPath()%>/js/bootstrap-datepicker.js"></script>
		<script src="<%=request.getContextPath()%>/js/jquery.multiselect.js"></script>
		<script src="<%=request.getContextPath()%>/js/common.js"></script>
		<script src="<%=request.getContextPath()%>/js/init.js"></script>
		<script src="<%=request.getContextPath()%>/js/sesp_ajax.js"></script>
		<script src="<%=request.getContextPath()%>/js/search-results.js"></script>
		<script src="<%=request.getContextPath()%>/js/alarm-management.js"></script>
		<script src="<%=request.getContextPath()%>/js/fusionchartsxt/charts/FusionCharts.js"></script>
		<script src="<%=request.getContextPath()%>/js/OpenLayers.js"></script>

		<script src="<%=request.getContextPath()%>/js/map.js"></script>
		<script src="<%=request.getContextPath()%>/js/spin.js"></script>
		<script src="<%=request.getContextPath()%>/js/ajax-loader.js"></script>

	</head>
	<body onload="populateFilters(),getdaterange(),initmap('<%=request.getSession().getAttribute("MAP_SERVER_URL")%>')">
	<%
		AlertService alertService = ServiceProvider.getInstance().getService(AlertService.class);
		List<UnitEventTTO> unitEventTypes = alertService.getEventTypes(null);
		Map<Long, String> selectedImage = new HashMap<Long, String>();
		Map<Long, String> unselectedImage = new HashMap<Long, String>();
		String[] symbols = new String[] {"blue","red","green","purple","yellow","pink","ltblue"};
		int imageCount = 1;
		int symbolCounter = 0;
		String imagePath = null;
		for(UnitEventTTO unitEventTTO : unitEventTypes) {
			switch(imageCount){
			case 1:
				imagePath = "/images/marker-icon-blue-dot.png";
				break;

			case 2:
				imagePath = "/images/marker-icon-red-dot.png";
				break;

			case 3:
				imagePath = "/images/marker-icon-green-dot.png";
				break;

			case 4:
				imagePath = "/images/marker-icon-purple-dot.png";
				break;

			case 5:
				imagePath = "/images/marker-icon-yellow-dot.png";
				break;

			case 6:
				imagePath = "/images/marker-icon-pink-dot.png";
				break;

			case 7:
				imagePath = "/images/marker-icon-ltblue-dot.png";
				break;

			default:
				imagePath = "/images/marker-icon-blue-dot.png";
				break;
			}

			unselectedImage.put(unitEventTTO.getId(), ((HttpServletRequest)pageContext.getRequest()).getContextPath() + imagePath);
			selectedImage.put(unitEventTTO.getId(),  ((HttpServletRequest)pageContext.getRequest()).getContextPath() + imagePath);

			imageCount = imageCount >= 7 ? 1 : ++imageCount ;


			symbolCounter++;
		}
	%>
		<script>
			contextPath = "<%=request.getContextPath()%>";
			mapServerUrl= "<%=application.getAttribute("MAP_SERVER_URL")%>";
			isAjaxSearch = false;

			i18nMeasurePoint="<s:text name='webportal.alert.measurepoint'/>";
			i18nStart="<s:text name='webportal.alert.start'/>";
			i18nEnd="<s:text name='webportal.alert.end'/>";
			i18nEventType="<s:text name='webportal.alert.eventtype'/>";
			i18nDeviceModel="<s:text name='webportal.alert.devicemodel'/>";
			i18nSelectDomain="<s:text name='webportal.alert.selectdomain'/>";
			i18nSelectAreaType="<s:text name='webportal.alert.selectareatype'/>";
			i18nSelectArea="<s:text name='webportal.alert.selectarea'/>";
			i18nSelectEventType="<s:text name='webportal.alert.selecteventtype'/>";
			i18nSelectUtilityType="<s:text name='webportal.alert.selectutilitytype'/>";
			i18nSelectCommType="<s:text name='webportal.alert.selectcommtype'/>";
			i18nSelectDeviceModel="<s:text name='webportal.alert.selectdevicemodel'/>";
			i18nAll="<s:text name='webportal.alert.all'/>";
			i18nerrorEnterValidPeriod="<s:text name='webportal.error.enterperiod'/>";
			i18nerrorAreaTypeRequired="<s:text name='webportal.error.chooseareatype'/>";
			i18nerrorDomainRequired="<s:text name='webportal.error.choosedomain'/>";
			i18nerrorSelectArea="<s:text name='webportal.error.selectarea'/>";
			i18nerrorSelectEvent="<s:text name='webportal.error.selectevent'/>";
			i18nerrorSelectEventType="<s:text name='webportal.error.selecteventtype'/>";
			i18nerrorChartError="<s:text name='webportal.error.nodataavailable'/>";

			function displayInfo(id) {}
			function resetMapNChart(data) {
				//Remove comment in production
				/*
				$("#map-wrapper").html('');
				initmap('<%=request.getSession().getAttribute("MAP_SERVER_URL")%>');
				$("#block-alarm-charts-view").html('');
				alert(i18nerrorChartError);
				*/
			}

			function loadPointsSuccess(data) {
				function getPointCollection(object, pointCollections) {
					var pointCollection = pointCollections[object.idUnitEventT];
					if(typeof pointCollection == "undefined") {
						<%
							for(UnitEventTTO unitEventTTO : unitEventTypes) {
								String selectedIcon = selectedImage.get(unitEventTTO.getId());
								String unSelectedIcon = unselectedImage.get(unitEventTTO.getId());
							%>
							if(object.idUnitEventT == <%=unitEventTTO.getId()%>) {
								pointCollection = createPointsCollection(<%="\"" + unSelectedIcon+"\""%>,<%="\"" + selectedIcon+"\""%>);
							}
							<%
						}
						%>
						pointCollections[object.idUnitEventT] = pointCollection;
						if(typeof pointCollections.objectlist == "undefined") {
							pointCollections.objectlist  = [];
						}
						pointCollections.objectlist.push(pointCollection);
						return pointCollection;
					} else {
						return pointCollection;
						}
				}

					var pointCollections = [];
					addPoints(data, getPointCollection, pointCollections, displayInfo, infoDataCallback);

					var al_domain = $("#domains").val()==null ? null:$("#domains").val().join(",");
					var al_areatypes = $("#areaTypes").val()==null ? null:$("#areaTypes").val().join(",");

					//Get all the new areas in the map
					var obj= {};
					obj.url=contextPath+"/std/AlarmManagementMapAreas.action";
					obj.pdata = "domains="+al_domain+"&areatypes="+al_areatypes;
					obj.successfunc = createAreaJSON;
					obj.errorfunc = errorAlarmDetails;
					run_ajax(obj);
			}
		</script>

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
						<div class="large-3 columns">
							<div class="row">
								<div class="large-12 columns">
									<label>Domain</label>
									<select id="domains" onchange="onChangeData()" class="custom-multi-select" name="multiselect-domain" multiple="multiple">
									</select>
								</div>
							</div>
							<div class="row">
								<div class="large-12 columns">
									<label>Date interval</label>
									<select id="filter-select-date-interval" onchange="javascript:getdaterange();">
										<option value="today">Today</option>
										<option value="lastweek" selected="selected">Last week</option>
										<option value="lastmonth">Last month</option>
										<option value="lastquarter">Last quarter</option>
										<option value="lastyear">Last year</option>
										<option value="custominterval">Custom interval</option>
									</select>
								</div>
							</div>
							<div class="row">
								<div class="small-6 columns">
									<label id="fromlabel">From:</label>
									<div class="custom-input-datepicker input-append date" data-date="2012-02-12" data-date-format="yyyy-mm-dd">
										<input id="filter-date-from" type="text" class="input-datepicker" readonly="readonly"/>
									</div>
								</div>
								<div class="small-6 columns">
									<label id="tolabel">To:</label>
									<div class="custom-input-datepicker input-append date"  data-date="12-02-2012" data-date-format="yyyy-mm-dd">
										<input id="filter-date-to" type="text" class="input-datepicker" readonly="readonly"/>
									</div>
								</div>
							</div>
						</div><!-- end of domain, date interval and daypicker wrapper -->

						<div class="large-3 columns">
							<div class="row">
								<label>Area type</label>
								<select id="areaTypes" onchange="onChangeData()" class="custom-multi-select" name="multiselect-area-type" multiple="multiple">
								</select>
							</div>
							<div class="row">
								<label>Area</label>
								<select id="areas" class="custom-multi-select" name="multiselect-area" multiple="multiple">
								</select>
							</div>
						</div>

						<div class="large-3 columns">
							<div class="row">
								<label>Alarm type</label>
								<select id="alarmTypes" class="custom-multi-select" name="multiselect-alarm-type" multiple="multiple">
								</select>
							</div>
							<div class="row">
								<label>Utility type</label>
								<select id="utilitytypes" class="custom-multi-select" name="multiselect-utility-type" multiple="multiple">
								</select>
							</div>
						</div>

						<div class="large-3 columns">
							<div class="row">
								<label>Communication type</label>
								<select id="commtypes" class="custom-multi-select" name="multiselect-communication-type" multiple="multiple">
								</select>
							</div>
							<div class="row">
								<label>Device model</label>
								<select id="devicemodels" class="custom-multi-select" name="multiselect-device-model" multiple="multiple">
								</select>
							</div>
						</div>

					</div><!-- end of input fields -->

					<div class="big-row"><!-- start of new full width row -->
							<div class="large-12 columns text-center">
									<a class="button" href="javascript:onSubmit();" id="filter-button-update">Update</a>
							</div>
					</div><!-- end of submitbutton wrapper -->
				</div><!-- end of filterheader -->
			</div><!-- end of headerwrapper -->

			<div class="big-row">
				<div class="large-10 columns">
					<div class="big-row">
						<div class="large-12 columns" >
							<ul class="page-name-heading sub-menu">
									<span><strong>ALARM MANAGEMENT</strong></span>
							</ul>
						</div>
					</div>

						<div class="big-row"><!-- start of new full width row -->
							<div class="large-6 columns">
								<div class="panel-outer">
									<h4 class="panel-heading"><i class="fi-marker colorHeading"></i> Map view</h4>
									<div class="panel-inner">
										<div style = "height:660px;width:100%;opacity:0.99;" id="map-wrapper"></div>
									</div>
									</div>
								</div>

							<div class="large-6 columns chart-container">
								<div class="panel-outer">
									<h4 class="panel-heading">
										<i class="fi-graph-bar colorHeading"></i>
										<span id="block-alarm-charts-title"></span>
										<span id="block-alarm-charts-period"></span>
									</h4>
									<div class="panel-innner">
										<div class="row">
											<div class="large-12 columns">
												<div id="block-alarm-charts-view">chart</div>
											</div>
										</div>

										<div class="row chart-filter">
											<div class="large-12 columns">
													<label>Group chart by</label>
													<div id="block-alarm-charts-radioBox">
														<form id="chart-form">
															<input id="block-alarm-charts-radio-area" type="radio" name="block-alarm-charts-radio" value="A" checked="checked" onclick="getChartTitle(this.value); onSubmit();">
															<label for="block-alarm-charts-radio-area" class="radio-legend legend1"><s:text name="webportal.alarm.area"/></label>
															<input id="block-alarm-charts-radio-alarm-type" type="radio" name="block-alarm-charts-radio" value="E" onclick="getChartTitle(this.value); onSubmit();">
															<label for="block-alarm-charts-radio-alarm-type" class="radio-legend legend2"><s:text name="webportal.alarm.alarmtype"/></label>
														</form>
													</div>
											</div>
										</div><!-- end of chart-filter -->

									</div>
								</div>
							</div><!-- end of chart-container -->
						</div><!-- end of big-row -->
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
		<script>
		getChartTitle("A");
		</script>
	</body>
</html>