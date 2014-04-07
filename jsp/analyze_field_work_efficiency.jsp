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
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/styles/foundation.css" />
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/foundation-icons/foundation-icons.css">


		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/styles/jquery.multiselect.css"/>
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/styles/general.css" />
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/styles/header.css" />


		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/styles/datepicker.css" />
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/styles/content-analyze-field-work-efficiency.css" />
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/js/dhtmlxGrid/codebase/dhtmlxgrid.css" />
		<link rel="shortcut icon" type="image/png" href="<%=request.getContextPath()%>/images/favicon.png" />

		<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-1.9.1.min.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-migrate-1.1.1.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-ui-1.10.2.custom.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/bootstrap-datepicker.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.multiselect.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/colResizable-1.3.min.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/init.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/common.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/sesp_ajax.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/search-results.js"></script>
		<script src="<%=request.getContextPath()%>/js/fusionchartsxt/charts/FusionCharts.js"></script>
		<script src="<%=request.getContextPath()%>/js/dhtmlxGrid/codebase/dhtmlxcommon.js"></script>
		<script src="<%=request.getContextPath()%>/js/dhtmlxGrid/codebase/dhtmlxgrid.js"></script>
		<script src="<%=request.getContextPath()%>/js/dhtmlxGrid/codebase/dhtmlxgridcell.js"></script>
		<script src="<%=request.getContextPath()%>/js/dhtmlxGrid/codebase/customdhtmlxgrid_export.js"></script>
		<script src="<%=request.getContextPath()%>/js/spin.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/ajax-loader.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/analyze_field_work_efficiency.js"></script>

		<script type="text/javascript" src="<%=request.getContextPath()%>/js/highchart/highcharts.js"></script>

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
									<label><s:text name="webportal.fieldworkefficiencyanalysis.filters.dateinterval"/></label>
										<select id="filter-select-date-interval"  onchange="javascript:disbaleDateFilter()" >
											<option value="lastweek"><s:text name="webportal.fieldworkefficiencyanalysis.filters.dateinterval.lastweek"/></option>
											<option value="today"><s:text name="webportal.fieldworkefficiencyanalysis.filters.dateinterval.today"/></option>
											<option value="lastmonth"><s:text name="webportal.fieldworkefficiencyanalysis.filters.dateinterval.lastmonth"/></option>
											<option value="lastquarter"><s:text name="webportal.fieldworkefficiencyanalysis.filters.dateinterval.lastquarter"/></option>
											<option value="lastyear"><s:text name="webportal.fieldworkefficiencyanalysis.filters.dateinterval.lastyear"/></option>
											<option value="custominterval"><s:text name="webportal.fieldworkefficiencyanalysis.filters.dateinterval.custominterval"/></option>
										</select>
									<label id="fromLabel"><s:text  name="webportal.fieldworkefficiencyanalysis.filters.from"/>: </label>
									<div class="custom-input-datepicker input-append date" data-date="2012-02-12" data-date-format="yyyy-mm-dd">
										<input id="filter-date-from" type="text" class="input-datepicker text-red"  readonly="readonly"/>
									</div>
									<label id="toLabel"><s:text  name="webportal.fieldworkefficiencyanalysis.filters.to"/> :</label>
									<div class="custom-input-datepicker input-append date"  data-date="12-02-2012" data-date-format="yyyy-mm-dd">
										<input id="filter-date-to" type="text" class="input-datepicker text-red"  readonly="readonly"/>
									</div>
								</div>
								<div class="large-4 columns">
									<label><s:text name="webportal.fieldworkefficiencyanalysis.filters.domain"/></label>
									<select id="filter-multiselect-domain" class="custom-multi-select" name="multiselect-domain" multiple="multiple" onchange="onDomainSelect()"></select>
									<label><s:text name="webportal.fieldworkefficiencyanalysis.filters.area"/></label>
									<select id="filter-multiselect-area" class="custom-multi-select" name="multiselect-area" multiple="multiple"></select>
								</div>
								<div class="large-4 columns">
									<label><s:text name="webportal.fieldworkefficiencyanalysis.filters.team"/></label>
									<select id="filter-multiselect-team" class="custom-multi-select" name="multiselect-team" multiple="multiple" onchange="onTeamSelectPopulateTechnicians()"></select>
									<label><s:text name="webportal.fieldworkefficiencyanalysis.filters.technician"/></label>
									<select id="filter-multiselect-technician" class="custom-multi-select" name="multiselect-technician" multiple="multiple"></select>
								</div>
							</div>
							<div class="big-row">
									<div class="large-12 columns text-center">
										<a id="block-filter-button-update" class="button" href="javascript:update()">Update</a>
									</div>
							</div>
						</div>
					</div>


					<div class="big-row">
						<div class="large-12 columns">
							<div class="big-row">
								<h4><i class="fi-filter colorHeading"></i> <s:text name="webportal.fieldworkefficiencyanalysis"/></h4>
								<div class="large-8 columns">
									<div class="panel-outer">
										<h4 class="panel-heading"><i class="fi-graph-trend colorHeading"></i> Work order type analysis</h4>
										<div class="panel-inner" id="block-work-order-type-analysis-chart"></div>
									</div>

									<div class="panel-outer">
										<h5 class="panel-heading text-right">
											<a href="javascript:analysisGrid.toExcel('<%=request.getContextPath()%>/std/DownloadExcel.action','Field Work Analysis','color','HEADER');" id="block-work-order-type-analysis-export-excel" class="button tiny">Export to Excel</a>
											<a href="javascript:exportAsPDF();" id="block-work-order-type-analysis-export-pdf" class="button tiny">Export to pdf</a>
										</h5>
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
										</div>
									</div>
								</div>
								<div class="large-4 columns">
									<div class="panel-outer" id="block-work-order-type-analysis-chart-filter">
										<h4 class="panel-heading">Filter</h4>
										<div class="panel-inner" id="block-work-order-type-analysis-chart-filter-content">
											<div id="filter-block-areas">
												<strong>Areas:</strong><br/>
												Kungsbacka 1 <br/>
												Goteborg 2 1<br/>
											</div>
											<hr>
											<div id= "filter-block-teams">
												<strong>Teams:</strong><br/>
												Team #1<br/>
												Team #2<br/>
											</div>
											<hr>
											<div id= "filter-block-technicians">
												<strong>Technicians:</strong><br />
												Mark Frick<br/>
												Conny Andersson<br/>
												Christian Isetjarn<br/>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</form>
	</div>
	<iframe id="myIFrm" name="myIFrm" src="" style="height: 0px; visibility: hidden"> </iframe>
	<input type="hidden" name="imgfilenames" id="imgfilenames"/>
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/highchart/field-work-chart.js"></script>
</body>
</html>
