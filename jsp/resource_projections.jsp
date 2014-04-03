<!DOCTYPE html>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title><s:text name='webportal.head.title'/></title>

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
		<% String contextPath = request.getContextPath(); %>

		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/styles/foundation.css" />
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/foundation-icons/foundation-icons.css">

		<link rel="stylesheet" type="text/css" href="<%=contextPath%>/styles/jquery.multiselect.css"/>
		<link rel="stylesheet" type="text/css" href="<%=contextPath%>/styles/general.css" />
		<link rel="stylesheet" type="text/css" href="<%=contextPath%>/styles/header.css" />

		<link rel="stylesheet" type="text/css" href="<%=contextPath%>/styles/datepicker.css" />
		<link rel="stylesheet" type="text/css" href="<%=contextPath%>/styles/content-resource-projections.css" />
		<link rel="stylesheet" type="text/css" href="<%=contextPath%>/styles/style.tidy.css" />
		<link rel="stylesheet" type="text/css" href="<%=contextPath%>/styles/bubble-map.css"/>
		<link rel="stylesheet" type="text/css" href="<%=contextPath%>/js/dhtmlxGrid/codebase/dhtmlxgrid.css" />


		<script type="text/javascript" src="<%=contextPath%>/js/jquery-1.9.1.min.js"></script>
		<script type="text/javascript" src="<%=contextPath%>/js/jquery-migrate-1.1.1.js"></script>
		<script type="text/javascript" src="<%=contextPath%>/js/jquery-ui-1.10.2.custom.js"></script>
		<script type="text/javascript" src="<%=contextPath%>/js/bootstrap-datepicker.js"></script>
		<script type="text/javascript" src="<%=contextPath%>/js/colResizable-1.3.min.js"></script>


		<script type="text/javascript" src="<%=contextPath%>/js/jquery.multiselect.js"></script>
		<script type="text/javascript" src="<%=contextPath%>/js/jquery.cookie.js"></script>
		<script type="text/javascript" src="<%=contextPath%>/js/init.js"></script>
		<script type="text/javascript" src="<%=contextPath%>/js/common.js"></script>
		<script type="text/javascript" src="<%=contextPath%>/js/resource_projections.js"></script>
		<script src="<%=contextPath%>/js/fusionchartsxt/charts/FusionCharts.js"></script>

		<link rel="shortcut icon" type="image/png" href="<%=contextPath%>/js/images/favicon.png" />
		<script type="text/javascript" src="<%=contextPath%>/js/OpenLayers.js"></script>

		<script type="text/javascript" src="<%=contextPath%>/js/highchart/highcharts.js"></script>
		<script type="text/javascript" src="<%=contextPath%>/js/highchart/exporting.js"></script>

		<script src="<%=contextPath%>/js/map.js"></script>
		<script src="<%=contextPath%>/js/sesp_ajax.js"></script>
		<script src="<%=contextPath%>/js/spin.js"></script>
		<script src="<%=contextPath%>/js/ajax-loader.js"></script>
		<script type="text/javascript" src="<%=contextPath%>/js/search-results.js"></script>

		<script>
			contextPath = "<%=contextPath%>";

			i18nerrorFromDateOlderThanToDate = "<s:text name='webportal.analyzefieldwork.fieldworkefficiency.filters.datesvalidation'/>";
			i18nerrorPleaseselectfromdate = "<s:text name='webportal.analyzefieldwork.fieldworkefficiency.filters.fromdateselect'/>";
			i18nerrorPleaseselecttodate = "<s:text name='webportal.analyzefieldwork.fieldworkefficiency.filters.todateselect'/>";
			i18nErrorSelectDomain = "<s:text name='webportal.error.choosedomain'/>";

			i18nErrorSelectArea = "<s:text name='webportal.error.selectarea'/>";
			i18nErrorSelectAreaType = "<s:text name='webportal.error.chooseareatype'/>";
			i18nErrorSelectUtilityType = "<s:text name='webportal.error.chooseutilitytype'/>";
			i18nErrorSelectDeviceType = "<s:text name='webportal.error.choosedevicetype'/>";
			i18nErrorSelectWorkOrderType = "<s:text name='webportal.error.chooseworkorderype'/>";
			i18nErrorSelectDeviceModel = "<s:text name='webportal.error.choosedevicemodel'/>";
			i18nErrorSelectPlanningPeriod = "<s:text name='webportal.resourceprojections.planningperiods.errorMessage'/>";

			i18nplanningname="<s:text name="webportal.resourceprojections.planningperiods.name"/>";
			i18nplanningstartdate="<s:text name="webportal.resourceprojections.planningperiods.startdate"/>";
			i18nplanningenddate="<s:text name="webportal.resourceprojections.planningperiods.enddate"/>";
			i18nplanningdomain="<s:text name="webportal.resourceprojections.planningperiods.domain"/>";
		</script>

	</head>
	<body onload="loadDefaultData()">
		<div id="wrapper">
			<%@ include file="headerv311.inc" %>
			<div class="big-row">
				<div class="large-12 columns filterHeader">
					<div class="big-row">
						<div class="large-3 columns">
							<h4><i class="fi-clock colorHeading"> </i> Update planing periods</h4>
							<div class="row">
								<div class="small-12 columns">
									<label><s:text name="webportal.resourceprojections.time.domain.title"/></label>
									<select id="block-time-multiselect-domain" class="custom-multi-select" name="multiselect-domain" multiple="multiple" onchange="domainChanged()">
									</select>
								</div>
							</div>
							<div class="row">
								<div class="small-12 columns">
									<label><s:text name="webportal.resourceprojections.time.dateinterval.title"/></label>
									<select id="block-time-select-date-interval" onchange="onDateIntervalSelect()">
										<option value="upcomingweek"><s:text name="webportal.resourceprojections.time.dateinterval.upcomingweek"/></option>
										<option value="upcomingmonth"><s:text name="webportal.resourceprojections.time.dateinterval.upcomingmonth"/></option>
										<option value="upcomingquarter"><s:text name="webportal.resourceprojections.time.dateinterval.upcomingquarter"/></option>
										<option value="upcomingyear"><s:text name="webportal.resourceprojections.time.dateinterval.upcomingyear"/></option>
										<option value="custominterval"><s:text name="webportal.resourceprojections.time.dateinterval.custominterval"/></option>
									</select>
								</div>
							</div>
							<div class="row">
								<div class="small-6 columns">
									<label><s:text name="webportal.resourceprojections.time.fromdate.title"/>:</label>
									<div class="custom-input-datepicker input-append date" data-date="2012-02-12" data-date-format="yyyy-mm-dd">
										<input id="block-time-date-from" type="text" class="input-datepicker"  readonly="readonly"/>
									</div>
								</div>
								<div class="small-6 columns">
									<label><s:text name="webportal.resourceprojections.time.todate.title"/>:</label>
									<div class="custom-input-datepicker input-append date"  data-date="12-02-2012" data-date-format="yyyy-mm-dd">
										<input id="block-time-date-to" type="text" class="input-datepicker"  readonly="readonly"/>
									</div>
								</div>
							</div>

							<div class="row">
								<div class="small-12 columns">
									<a id="block-time-button-update" onclick="javascript:updatePlanningPeriod()" class="button tiny"><s:text name="webportal.resourceprojections.time.update"/></a>
								</div>
							</div>
						</div>

						<div class="large-5 columns">
							<h4>
								<i class="fi-calendar colorHeading"></i> Planning Periods
								<small>
									<a href="#"><s:text name="webportal.resourceprojections.planningperiods.selectall"/></a>
									<a href="#"><s:text name="webportal.resourceprojections.planningperiods.selectnone"/></a>
								</small>
							</h4>
							<table id="block-planning-periods-table">
								<thead>
									<tr>
										<th><s:text name="webportal.resourceprojections.planningperiods.name"/></th>
										<th><s:text name="webportal.resourceprojections.planningperiods.startdate"/></th>
										<th><s:text name="webportal.resourceprojections.planningperiods.enddate"/></th>
										<th><s:text name="webportal.resourceprojections.planningperiods.domain"/></th>
									</tr>
								</thead>
								<tbody>
										<tr class="table-line line-grey">
										<td>Month 2013 March</td>
										<td>2013-03-01</td>
										<td>2013-03-01</td>
										<td>Domain #1</td>
									</tr>
									<tr class="table-line">
										<td>Month 2013 April</td>
										<td>2013-03-01</td>
										<td>2013-03-01</td>
										<td>Domain #1</td>
									</tr>
									<tr class="table-line line-grey">
										<td>Month 2013 May</td>
										<td>2013-03-01</td>
										<td>2013-03-01</td>
										<td>Domain #1</td>
									</tr>
								</tbody>
							</table>
						</div>

						<div class="large-4 columns">
							<div class="row">
								<div class="large-6 columns">

									<label>Utility type</label>
									<div>
										<select id="filter-multiselect-utility-type" class="custom-multi-select" name="multiselect-utility-type" multiple="multiple"></select>
									</div>


									<label>Area</label>
									<div>
										<select id="filter-multiselect-area" class="custom-multi-select" name="multiselect-area" multiple="multiple"></select>
									</div>

									<label>Area type</label>
									<div>
										<select id="filter-multiselect-area-type" class="custom-multi-select" name="multiselect-area-type" multiple="multiple"></select>
									</div>
								</div>
								<div class="large-6 columns">

									<label>Work order type</label>
									<div>
										<select id="filter-multiselect-work-order-type" class="custom-multi-select" name="multiselect-work-order-type" multiple="multiple"></select>
									</div>

									<label>Device type</label>
									<div>
										<select id="filter-multiselect-device-type" class="custom-multi-select" name="multiselect-device-type" multiple="multiple"></select>
									</div>

									<label>Device model</label>
									<div>
										<select id="filter-multiselect-device-model" class="custom-multi-select" name="multiselect-device-model" multiple="multiple"></select>
									</div>

										<a class="button tiny" id="block-filter-button-update" onclick="javascript:processProjections()"><s:text name="webportal.resourceprojections.filters.update"/></a>
								</div>
							</div>
						</div>
					</div>
				</div> <!-- end of time columns -->
			</div><!-- end of header container -->

			<div class="big-row">
				<div class="large-12 columns" >
					<h2><s:text name="webportal.resourceprojections.title"/></h2>
				</div>
			</div>

			<div class="big-row">
				<div class="large-12 columns">
					<div class="panel-outer">
						<h4 class="panel-heading"><i class="fi-graph-trend colorHeading"></i> Device assets projections</h4>
						<div class="panel-inner">
							<!-- IDs for real data chart
							<div class="large-6 columns" id="block-device-assets-projections-per-month-view"></div>
							<div class="large-6 columns" id="block-device-assets-projections-total-view"></div>
							-->
							<div class="large-6 columns" id="device-assets-projections-per-month-view"></div>
							<div class="large-6 columns" id="device-assets-projections-total-view"></div>
						</div>
					</div>
				</div>
			</div>

			<div class="big-row">
				<div class="large-12 columns">
					<div class="panel-outer">
						<h4 class="panel-heading"><i class="fi-graph-trend colorHeading"></i> Resource projections per month</h4>
						<div class="panel-inner">
							<!-- IDs for real data chart
							<div class="large-6 columns" id="block-resource-projections-per-month-view"></div>
							<div class="large-6 columns" id="block-resource-projections-total-view"></div>
							-->
							<div class="large-6 columns" id="resource-projections-per-month-view"></div>
							<div class="large-6 columns" id="resource-projections-total-view"></div>
						</div>
					</div>
				</div>
			</div>

			<div class="big-row">
				<div class="large-4 columns">
					<div class="panel-outer">
						<h4 class="panel-heading"><i class="fi-graph-trend size-24 colorHeading"></i> Key performance indexes</h4>
						<div class="panel-inner">
						Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat. Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat.
						</div>
					</div>
				</div>
				<div class="large-8 columns">
					<div class="panel-outer">
						<h4 class="panel-heading"><i class="fi-graph-trend colorHeading"></i> Device assets projections</h4>
						<div class="panel-inner">
						Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat. Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi. Nam liber tempor cum soluta nobis eleifend option congue nihil imperdiet doming id quod mazim placerat facer possim assum. Typi non habent claritatem insitam; est usus legentis in iis qui facit eorum claritatem. Investigationes demonstraverunt lectores legere me lius quod ii legunt saepius. Claritas est etiam process
						</div>
					</div>
				</div>
			</div>
		</div><!--end of wrapper -->
		<script type="text/javascript" src="<%=contextPath%>/js/highchart/resource-projection-chart.js"></script>
	</body>
	</html>
