<!DOCTYPE html>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title><s:text name='webportal.head.title'/></title>

		<% String contextPath = request.getContextPath(); %>

		<link rel="stylesheet" type="text/css" href="<%=contextPath%>/styles/foundation.css" />
		<link rel="stylesheet" type="text/css" href="<%=contextPath%>/foundation-icons/foundation-icons.css">
		<link rel="stylesheet" type="text/css" href="<%=contextPath%>/styles/jquery.multiselect.css"/>
		<link rel="stylesheet" type="text/css" href="<%=contextPath%>/styles/general.css" />

		<link rel="stylesheet" type="text/css" href="<%=contextPath%>/styles/datepicker.css" />
		<link rel="stylesheet" type="text/css" href="<%=contextPath%>/styles/content-resource-projections.css" />
		<link rel="stylesheet" type="text/css" href="<%=contextPath%>/styles/style.tidy.css" />
		<link rel="stylesheet" type="text/css" href="<%=contextPath%>/styles/bubble-map.css"/>
		<link rel="stylesheet" type="text/css" href="<%=contextPath%>/js/dhtmlxGrid/codebase/dhtmlxgrid.css" />

		<script src="<%=contextPath%>/js/jquery-1.9.1.min.js"></script>
		<script src="<%=contextPath%>/js/highchart/highcharts.js"></script>

		<script src="<%=contextPath%>/js/jquery-migrate-1.1.1.js"></script>
		<script src="<%=contextPath%>/js/jquery-ui-1.10.2.custom.js"></script>
		<script src="<%=contextPath%>/js/bootstrap-datepicker.js"></script>
		<script src="<%=contextPath%>/js/vendor/jquery.nicescroll.js"></script>
		<script src="<%=contextPath%>/js/common.js"></script>

		<script src="<%=contextPath%>/js/jquery.multiselect.js"></script>
		<script src="<%=contextPath%>/js/jquery.cookie.js"></script>
		<script src="<%=contextPath%>/js/resource_projections.js"></script>

		<link rel="shortcut icon" type="image/png" href="<%=contextPath%>/js/images/favicon.png" />
		<script src="<%=contextPath%>/js/OpenLayers.js"></script>
		<script src="<%=contextPath%>/js/map.js"></script>
		<script src="<%=contextPath%>/js/sesp_ajax.js"></script>
		<script src="<%=contextPath%>/js/spin.js"></script>
		<script src="<%=contextPath%>/js/ajax-loader.js"></script>
		<script src="<%=contextPath%>/js/search-results.js"></script>

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
		<!--[if lt IE 9]>
		<link rel="stylesheet" href="<%=contextPath%>/styles/ie8.css">
		<script src="//cdnjs.cloudflare.com/ajax/libs/html5shiv/3.6.2/html5shiv.js"></script>
		<script src="//s3.amazonaws.com/nwapi/nwmatcher/nwmatcher-1.2.5-min.js"></script>
		<script src="//html5base.googlecode.com/svn-history/r38/trunk/js/selectivizr-1.0.3b.js"></script>
		<script src="//cdnjs.cloudflare.com/ajax/libs/respond.js/1.1.0/respond.min.js"></script>
		<![endif]-->
	</head>
	<body onload="loadDefaultData()">
		<div id="wrapper">
			<%@ include file="headerv311.inc" %>
			<div class="big-row">
				<div class="large-12 columns filterHeader">
					<div class="big-row">
						<div class="large-3 columns">
							<h4><s:text name="webportal.resourceprojections.time.first"/></h4>
								<div class="large-12 columns">
									<label><s:text name="webportal.resourceprojections.time.domain.title"/></label>
									<select id="block-time-multiselect-domain" class="custom-multi-select" name="multiselect-domain" multiple="multiple" onchange="domainChanged()">
									</select>
								</div>

								<div class="small-6 columns">
									<label><s:text name="webportal.resourceprojections.planningperiods.type" /></label>
									<select id="period-type">
										<option value="week"><s:text name="webportal.week"/></option>
										<option value="month"><s:text name="webportal.month"/></option>
										<option value="quarter"><s:text name="webportal.quarter"/></option>
										<option value="year"><s:text name="webportal.year"/></option>
									</select>
								</div>

								<div class="small-6 columns">
									<label><s:text name="webportal.resourceprojections.time.dateinterval.title"/></label>
									<select id="block-time-select-date-interval" onchange="onDateIntervalSelect()">
										<option value="upcomingweek"><s:text name="webportal.resourceprojections.time.dateinterval.upcomingweek"/></option>
										<option value="upcomingmonth"><s:text name="webportal.resourceprojections.time.dateinterval.upcomingmonth"/></option>
										<option value="upcomingquarter"><s:text name="webportal.resourceprojections.time.dateinterval.upcomingquarter"/></option>
										<option value="upcomingyear"><s:text name="webportal.resourceprojections.time.dateinterval.upcomingyear"/></option>
										<option value="custominterval"><s:text name="webportal.resourceprojections.time.dateinterval.custominterval"/></option>
									</select>
								</div>
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

								<div class="small-12 columns text-right">
									<br/>
									<a id="block-time-button-update" onclick="javascript:updatePlanningPeriod()" class="button tiny"><s:text name="webportal.resourceprojections.filters.search"/></a>
								</div>
						</div>

						<div class="large-5 columns nice-scroll">
							<h4>
								2 Select <span style="text-decoration:underline">weekly</span> planning periods
								<small>
									<a href="#"><s:text name="webportal.resourceprojections.planningperiods.selectall"/> | </a>
									<a href="#"><s:text name="webportal.resourceprojections.planningperiods.selectnone"/></a>
								</small>
							</h4>
							<table id="block-planning-periods-table">
								<thead>
									<tr>
										<th>
											<s:text name="webportal.resourceprojections.planningperiods.errorMessage" />
										</th>
									</tr>
								</thead>
							</table>
						</div>

						<div class="large-4 columns">
							<h4><s:text name="webportal.resourceprojections.time.third"/></h4>

							<div class="row">
								<div class="small-6 columns">

									<label><s:text name="webportal.resourceprojections.filters.utilitytype" /></label>
									<div>
										<select id="filter-multiselect-utility-type" class="custom-multi-select" name="multiselect-utility-type" multiple="multiple"></select>
									</div>


									<label><s:text name="webportal.resourceprojections.filters.area" /></label>
									<div>
										<select id="filter-multiselect-area" class="custom-multi-select" name="multiselect-area" multiple="multiple"></select>
									</div>

									<label><s:text name="webportal.resourceprojections.filters.areatype" /></label>
									<div>
										<select id="filter-multiselect-area-type" class="custom-multi-select" name="multiselect-area-type" multiple="multiple"></select>
									</div>
								</div>
								<div class="small-6 columns">

									<label><s:text name="webportal.resourceprojections.filters.workordertype" /></label>
									<div>
										<select id="filter-multiselect-work-order-type" class="custom-multi-select" name="multiselect-work-order-type" multiple="multiple"></select>
									</div>

									<label><s:text name="webportal.resourceprojections.filters.devicetype" /></label>
									<div>
										<select id="filter-multiselect-device-type" class="custom-multi-select" name="multiselect-device-type" multiple="multiple"></select>
									</div>

									<label><s:text name="webportal.resourceprojections.filters.devicemodel" /></label>
									<div>
										<select id="filter-multiselect-device-model" class="custom-multi-select" name="multiselect-device-model" multiple="multiple"></select>
									</div>
								</div>
								<div class="large-12 columns text-right">
									<a class="button tiny" id="block-filter-button-update" onclick="javascript:processProjections()">
										<s:text name="webportal.resourceprojections.filters.update"/></a>
								</div>
							</div>
						</div>
					</div>
				</div> <!-- end of time columns -->
			</div><!-- end of header container -->

			<div class="big-row">
				<div class="large-10 columns">
					<div class="big-row">
						<div class="large-12 columns" >
							<ul class="page-name-heading sub-menu">
								<span>RESOURCE PROJECTIONS / DEVICE ASSETS PROJECTIONS</span>
							</ul>
						</div>
					</div>

					<div class="big-row">
						<div class="large-6 columns">
							<div class="panel-outer">
								<h4 class="panel-heading">
									<i class="fi-graph-horizontal colorHeading test"></i>
									<span> <s:text name="webportal.resourceprojections.deviceassets.permonth"/></span>
								</h4>
								<div class="panel-inner" id="device-assets-projections-per-month-view">
									<!-- IDs for real data chart
									<div class="large-6 columns" id="block-device-assets-projections-per-month-view"></div>
									-->
								</div>
							</div>
						</div>

						<div class="large-6 columns">
							<div class="panel-outer">
								<h4 class="panel-heading"><i class="fi-graph-pie colorHeading"></i>
									<span> <s:text name="webportal.resourceprojections.deviceassets.total"/>
									</span>
								</h4>
								<div class="panel-inner" id="device-assets-projections-total-view">
										<!-- IDs for real data chart
										<div class="large-6 columns" id="block-device-assets-projections-total-view"></div>
										-->
								</div>
							</div>
						</div>

						<div class="big-row">
							<div class="large-6 columns">
								<div class="panel-outer">
									<h4 class="panel-heading">
										<i class="fi-graph-horizontal colorHeading"></i>
										<span> <s:text name="webportal.resourceprojections.resourceprojections.permonth" /></span>
									</h4>
									<div class="panel-inner" id="resource-projections-per-month-view">
										<!-- IDs for real data chart
										<div class="large-6 columns" id="block-resource-projections-per-month-view"></div>
										-->
										<div class="large-6 columns" id="resource-projections-total-view"></div>
									</div>
								</div>
							</div>

							<div class="large-6 columns">
								<div class="panel-outer">
									<h4 class="panel-heading">
										<i class="fi-graph-pie colorHeading"></i>
										<span> <s:text name="webportal.resourceprojections.resourceprojections.total" /></span>
									</h4>
									<div class="panel-inner" id="resource-projections-total-view">
										<!-- IDs for real data chart
										<div class="large-6 columns" id="block-resource-projections-total-view"></div>
										-->
									</div>
								</div>
							</div>
						</div>
					</div>

					<div class="big-row">
						<div class="large-6 columns">
							<div class="panel-outer">
								<h4 class="panel-heading">
									<i class="fi-graph-bar size-24 colorHeading"></i>
									<span> <s:text name="webportal.resourceprojections.resourceprojections.key" /></span>
								</h4>
								<div class="panel-inner" id="resource-projections-kpi"></div>
							</div>
						</div>
					</div>
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
							<a>Planning period</a>
							<div id="" class="content">
								<ul id="selected-period-type"></ul>
							</div>
						</dd>

						<dd id="selected-date">
							<a>Selected planning periods <span class="round label"></span></a>
							<div class="content">
								<ul></ul>
							</div>
						</dd>

						<dd id="selected-utility-type">
							<a>Utility type <span class="round label"></span></a>
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

						<dd id="selected-area-type">
							<a>Area type <span class="round label"></span></a>
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

						<dd id="selected-device-type">
							<a>Device type <span class="round label"></span></a>
							<div class="content">
								<ul></ul>
							</div>
						</dd>

						<dd id="selected-device-model">
							<a>Device model <span class="round label"></span></a>
							<div class="content">
								<ul></ul>
							</div>
						</dd>

					</dl>
				</div>
			</div>

			<div class="wrapper-blur"></div>

		</div><!--end of wrapper -->
		<script src="<%=contextPath%>/js/highchart/resource-projection-chart.js"></script>

	<!--[if lt IE 9]>
	<script type="text/javascript" src="https://raw.githubusercontent.com/chuckcarpenter/REM-unit-polyfill/master/js/rem.min.js"></script>
	<![endif]-->
	</body>
	</html>
