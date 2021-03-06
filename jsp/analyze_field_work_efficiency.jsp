<!DOCTYPE html>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title><s:text name="webportal.head.title"/></title>

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
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/styles/datepicker.css" />
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/styles/content-analyze-field-work-efficiency.css" />
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/js/dhtmlxGrid/codebase/dhtmlxgrid.css" />
	<link rel="shortcut icon" type="image/png" href="<%=request.getContextPath()%>/images/favicon.png" />

	<script src="<%=request.getContextPath()%>/js/jquery-1.9.1.min.js"></script>
	<script src="<%=request.getContextPath()%>/js/vendor/jquery.nicescroll.js"></script>
	<script src="<%=request.getContextPath()%>/js/jquery-migrate-1.1.1.js"></script>
	<script src="<%=request.getContextPath()%>/js/jquery-ui-1.10.2.custom.js"></script>
	<script src="<%=request.getContextPath()%>/js/bootstrap-datepicker.js"></script>
	<script src="<%=request.getContextPath()%>/js/jquery.multiselect.js"></script>
	<script src="<%=request.getContextPath()%>/js/jquery.cookie.js"></script>
	<script src="<%=request.getContextPath()%>/js/common.js"></script>
	<script src="<%=request.getContextPath()%>/js/sesp_ajax.js"></script>
	<script src="<%=request.getContextPath()%>/js/search-results.js"></script>
	<script src="<%=request.getContextPath()%>/js/dhtmlxGrid/codebase/dhtmlxcommon.js"></script>
	<script src="<%=request.getContextPath()%>/js/dhtmlxGrid/codebase/dhtmlxgrid.js"></script>
	<script src="<%=request.getContextPath()%>/js/dhtmlxGrid/codebase/dhtmlxgridcell.js"></script>
	<script src="<%=request.getContextPath()%>/js/dhtmlxGrid/codebase/customdhtmlxgrid_export.js"></script>
	<script src="<%=request.getContextPath()%>/js/spin.js"></script>
	<script src="<%=request.getContextPath()%>/js/ajax-loader.js"></script>
	<script src="<%=request.getContextPath()%>/js/analyze_field_work_efficiency.js"></script>

	<script src="<%=request.getContextPath()%>/js/highchart/highcharts.js"></script>
	<!--[if lt IE 9]>
	<link rel="stylesheet" href="<%=request.getContextPath()%>/styles/ie8.css">
	<script src="//cdnjs.cloudflare.com/ajax/libs/html5shiv/3.6.2/html5shiv.js"></script>
	<script src="//s3.amazonaws.com/nwapi/nwmatcher/nwmatcher-1.2.5-min.js"></script>
	<script src="//html5base.googlecode.com/svn-history/r38/trunk/js/selectivizr-1.0.3b.js"></script>
	<script src="//cdnjs.cloudflare.com/ajax/libs/respond.js/1.1.0/respond.min.js"></script>
	<![endif]-->
</head>
	<body onload="loadData()">

		<script type ="text/javascript">
			contextPath="<%=request.getContextPath()%>";
			i18nerrorPleaseselectdomain="<s:text name='webportal.error.choosedomain'/>";
			i18nerrorPleaseselectarea="<s:text name='webportal.error.selectarea'/>";
			i18nerrorPleaseselectteam="<s:text name='webportal.error.selectteam'/>";
			i18nerrorPleaseselecttechnician="<s:text name='webportal.error.selecttechnician'/>";
			i18nerrorPleaseselectdateinterval="<s:text name='webportal.error.choosedate'/>";
			i18nerrorPleaseselectfromdate="<s:text name='webportal.error.choosefromdate'/>";
			i18nerrorPleaseselecttodate="<s:text name='webportal.error.choosetodate'/>";
			i18nerrorChartError="<s:text name='webportal.error.nodataavailable'/>";

			function initAnalysisGrid(){
				if(analysisGrid)
				{
					analysisGrid.clearAll();
					analysisGrid.destructor();
				}

				analysisGrid = new dhtmlXGridObject('meterValuesGridDiv');
				analysisGrid.setImagePath("<%=request.getContextPath()%>/js/dhtmlxGrid/codebase/imgs/");
				analysisGrid.setHeader("<s:text name='webportal.fieldworkefficiencyanalysis.workordertypeanalysis.workordertype'/>,"+
					"<s:text name='webportal.fieldworkefficiencyanalysis.workordertypeanalysis.expectedworkingtime'/>,"+
					"<s:text name='webportal.fieldworkefficiencyanalysis.workordertypeanalysis.actualworkingtime'/>,"+
					"<s:text name='webportal.fieldworkefficiencyanalysis.workordertypeanalysis.traveltime'/>,"+
					"<s:text name='webportal.fieldworkefficiencyanalysis.workordertypeanalysis.outcome'/>,"+
					"<s:text name='webportal.fieldworkefficiencyanalysis.workordertypeanalysis.drivingdistance'/>");
				analysisGrid.setInitWidths("200,150,150,150,150,150");
				analysisGrid.setColAlign("center,center,center,center,center,center");
				analysisGrid.setSkin("xp");
				analysisGrid.init();
			}
		</script>
		<div id="wrapper">

		<%@ include file="headerv311.inc"%>
			<form name="analyzeFieldWorkEfficiencyForm" method="post" action="<%=request.getContextPath()%>/std/AnalyzeFieldWorkEfficiency">

				<div class="big-row">
					<div class="large-12 columns filterHeader">
						<div class="big-row">
							<div class="large-12 columns">
								<h4><i class="fi-filter colorHeading"></i> Filters</h4>
							</div>
						</div>
						<div class="big-row">
							<div class="large-4 columns">
									<div class="medium-12 columns">
										<label>Date interval</label>
										<select id="filter-select-date-interval"  onchange="javascript:disbaleDateFilter()" >
												<option value="lastweek">Last week</option>
												<option value="today">Today</option>
												<option value="lastmonth">Last month</option>
												<option value="lastquarter">Last quarter</option>
												<option value="lastyear">Last year</option>
												<option value="custominterval">Custom interval</option>
										</select>
									</div>

									<div class="small-6 columns">
										<label id="fromLabel">From: </label>
										<div class="custom-input-datepicker input-append date" data-date="2012-02-12" data-date-format="yyyy-mm-dd">
											<input id="filter-date-from" type="text" class="input-datepicker text-red"  readonly="readonly"/>
										</div>
									</div>

									<div class="small-6 columns">
											<label id="toLabel">To:</label>
											<div class="custom-input-datepicker input-append date"  data-date="12-02-2012" data-date-format="yyyy-mm-dd">
												<input id="filter-date-to" type="text" class="input-datepicker text-red"  readonly="readonly"/>
											</div>
									</div>
							</div>

							<div class="large-4 columns">
								<div class="large-12 medium-6 columns">
									<label>Domain</label>
									<select id="filter-multiselect-domain" class="custom-multi-select" name="multiselect-domain" multiple="multiple" onchange="onDomainSelect()"></select>
								</div>
								<div class="large-12 medium-6 columns">
									<label>Area</label>
									<select id="filter-multiselect-area" class="custom-multi-select" name="multiselect-area" multiple="multiple"></select>
								</div>
							</div>

							<div class="large-4 columns">
									<div class="large-12 medium-6 columns">
										<label>Team</label>
										<select id="filter-multiselect-team" class="custom-multi-select" name="multiselect-team" multiple="multiple" onchange="onTeamSelectPopulateTechnicians()"></select>
									</div>
									<div class="large-12 medium-6 columns">
										<label>Technician</label>
										<select id="filter-multiselect-technician" class="custom-multi-select" name="multiselect-technician" multiple="multiple"></select>
									</div>
							</div>
						</div>
						<div class="big-row">
							<div class="large-12 columns text-center">
								<a id="block-filter-button-update" class="button small" href="javascript:update()">Update</a>
							</div>
						</div>
					</div>
				</div>

				<div class="big-row">
					<div class="large-10 columns">
						<div class="big-row">
							<div class="large-12 columns">
								<ul class="page-name-heading sub-menu field-work-submenu">
									<span>FIELD WORK EFFIENCY ANALYSIS</span>
								</ul>
							</div>
						</div>

						<div class="big-row">
							<div class="large-12 columns">
								<div class="panel-outer">
									<h4 class="panel-heading"><i class="fi-graph-horizontal colorHeading"></i><span> Work order type analysis</span></h4>
									<div class="panel-inner" id="block-work-order-type-analysis-chart"></div>
								</div>
							</div>
							<div class="large-12 columns">
								<div class="panel-outer">
									<h4 class="panel-heading"><i class="fi-list colorHeading"></i><span>Table view</span></h4>
									<div id="meterValuesGridDiv"></div>
									<div class="panel-inner">
											<table id="block-work-order-type-analysis-table">
												<thead>
													<tr id="table-header">
														<th>Work order type</th>
														<th>Expected working time</th>
														<th>Actual working time</th>
														<th>Travel time</th>
														<th>Outcome</th>
														<th>Driving distance</th>
													</tr>
												</thead>
												<tbody>
													<tr>
													<td>Meter change</td>
													<td>01:24</td>
													<td>01:00</td>
													<td>00:20</td>
													<td>-29%</td>
													<td>14.2km</td>
													</tr>
														<tr>
													<td>Meter change</td>
													<td>01:24</td>
													<td>01:00</td>
													<td>00:20</td>
													<td>-29%</td>
													<td>14.2km</td>
													</tr>
														<tr>
													<td>Meter change</td>
													<td>01:24</td>
													<td>01:00</td>
													<td>00:20</td>
													<td>-29%</td>
													<td>14.2km</td>
													</tr>
												</tbody>
											</table>
											<div class="text-right">
												<a href="javascript:analysisGrid.toExcel('<%=request.getContextPath()%>/std/DownloadExcel.action','Field Work Analysis','color','HEADER');" id="block-work-order-type-analysis-export-excel" class="button tiny">Export to Excel</a>
												<a href="javascript:exportAsPDF();" id="block-work-order-type-analysis-export-pdf" class="button tiny">Export to pdf</a>
											</div>
									</div>
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
			</form>
		<div class="wrapper-blur"></div>
	</div>
	<iframe id="myIFrm" name="myIFrm" src="" style="height: 0px; visibility: hidden"> </iframe>
	<input type="hidden" name="imgfilenames" id="imgfilenames"/>
	<script src="<%=request.getContextPath()%>/js/highchart/field-work-chart.js"></script>

	<!--[if lt IE 9]>
	<script type="text/javascript" src="https://raw.githubusercontent.com/chuckcarpenter/REM-unit-polyfill/master/js/rem.min.js"></script>
	<![endif]-->
</body>
</html>
