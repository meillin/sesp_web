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
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/styles/content-system-utilization-dashboard.css" />
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/styles/general.css">
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-1.9.1.min.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-migrate-1.1.1.js"></script>
		<script src="<%=request.getContextPath()%>/js/fusionchartsxt/charts/FusionCharts.js"></script>
		<script src="<%=request.getContextPath()%>/js/sesp_ajax.js"></script>
		<script src="<%=request.getContextPath()%>/js/spin.js"></script>
		<script src="<%=request.getContextPath()%>/js/ajax-loader.js"></script>

		<script type="text/javascript" src="<%=request.getContextPath()%>/js/system_dashboard.js"></script>
		<link rel="shortcut icon" type="image/png" href="<%=request.getContextPath()%>/images/favicon.png" />

		<script src="<%=request.getContextPath()%>/js/highchart/highcharts.js"></script>
		<script src="<%=request.getContextPath()%>/js/highchart/highcharts-more.js"></script>

	<!--[if lt IE 9]>
	<script src="//cdnjs.cloudflare.com/ajax/libs/html5shiv/3.6.2/html5shiv.js"></script>
	<script src="//s3.amazonaws.com/nwapi/nwmatcher/nwmatcher-1.2.5-min.js"></script>
	<script src="//html5base.googlecode.com/svn-history/r38/trunk/js/selectivizr-1.0.3b.js"></script>
	<script src="//cdnjs.cloudflare.com/ajax/libs/respond.js/1.1.0/respond.min.js"></script>
	<![endif]-->
	</head>
	<script>
		contextPath = "<%=request.getContextPath()%>";
		refreshInterval = "<%=request.getAttribute("refreshInterval")%>";
	</script>
	<body>
		<div class="big-row containter">
			<div class="large-3 columns full-height">
				<div class="row height-40 panel-outer">
						<h4 class="panel-heading"><i class="icon-download colorHeading"></i><span> Import servers</span></h4>
						<div class="panel-inner">
							<div class="row cpu-container">
								<div class="large-7 columns" id="import-servers"></div>
								<div class="large-5 columns bold">
									<label>Memory</label>
									<div id="import-servers-memory" ></div>
								</div>
							</div>
							<div class="row">
								<div class="large-12 columns" id="import-servers-threads"></div>
							</div>
						</div>
				</div>
				<div class="row height-40 panel-outer">
					<h4 class="panel-heading">
						<i class="icon-upload colorHeading"></i><span> Export servers</span>
					</h4>
					<div class="panel-inner">
						<div class="row cpu-container">
							<div class="large-7 columns" id="export-servers"></div>
							<div class="large-5 columns bold">
								<label>Memory</label>
								<div id="export-servers-memory" ></div>
							</div>
						</div>
						<div class="row">
							<div class="large-12 columns" id="export-servers-threads"></div>
						</div>
					</div>
				</div>
				<div class="row height-20 panel-outer">
					<h4 class="panel-heading">
						<i class="icon-chart colorHeading"></i><span> Transaction servers</span>
					</h4>
					<div class="panel-inner">
						<div class="row">
								<div class="large-7 columns">
									<div id="transaction-servers"></div>
								</div>
								<div class="large-5 columns bold">
									<label>Memory</label>
									<div id="transaction-servers-memory"></div>
								</div>
							</div>
						</div>
					</div>
			</div>
			<div class="large-5 columns full-height">
				<div class="row height-50 panel-outer">
						<h4 class="panel-heading"><i class="icon-download colorHeading"></i><span> Import statistics</span></h4>
						<div class="height-50 panel-inner">
							<div class="large-6 columns">
								<div id="import-files"></div>
								<div class="row info text-center">
									<div class="small-6 columns">
											<label>Files imported</label>
											<span id="import-statistics-files-imported">123</span>
									</div>
									<div class="small-6 columns">
											<label>Data imported</label>
											<span id="import-statistics-data-imported">321</span>
									</div>
								</div>
							</div>

							<div class="large-6 columns">
								<div id="import-messages"></div>
								<div class="row info text-center">
									<div class="large-12 columns">
											<label>Messages received</label>
											<div id="import-statistics-messages-received">110</div>
									</div>
								</div>
							</div>

							<div class="row">
								<div class="large-12 columns">
									<table id="import-statistics-table">
											<thead>
												<tr>
												<th>ID</th>
												<th>Timestamp</th>
												<th>File type</th>
												<th>Status</th>
												<th>Size</th>
												<th>Rec.count</th>
												</tr>
											</thead>
											<tbody></tbody>
									</table>
								</div>
							</div>
						</div>
				</div>

				<div class="row height-50 panel-outer">
					<h4 class="panel-heading"><i class="icon-upload colorHeading"></i><span> Export statistics</span></h4>
					<div class="panel-inner">
							<div class="large-6 columns">
								<div id="export-files"></div>
								<div class="row info text-center">
									<div class="small-6 columns">
										<label>Files exported</label>
										<span id="export-statistics-files-exported">123</span>
									</div>
									<div class="small-6 columns">
										<label>Data exported</label>
										<span id="export-statistics-data-exported">321</span>
									</div>
								</div>
							</div>

							<div class="large-6 columns">
								<div id="export-messages"></div>
								<div class="row info text-center">
									<div class="large-12 columns">
										<label>Messages received</label>
										<span id="export-statistics-messages-received">110</span>
									</div>
							</div>
						</div>
						<div class="row">
							<div class="large-12 columns">
								<table id="export-statistics-table">
									<thead>
										<tr>
										<th>ID</th>
										<th>Timestamp</th>
										<th>File type</th>
										<th>Status</th>
										<th>Size</th>
										<th>Rec.count</th>
										</tr>
									</thead>
									<tbody></tbody>
								</table>
							</div>
						</div>
					</div>
				</div>
			</div>

			<div class="large-4 columns full-height">
				<div class="row height-45 panel-outer">
					<h4 class="panel-heading"><i class="icon-users colorHeading"></i><span> Users</span></h4>
					<div class="panel-inner">
						<div class="row">
							<div class="large-12 columns">
								<div id="users-system-chart"></div>
							</div>
						</div>
						<div class="row">
							<div class="large-12 columns">
								<div id="users-authentifications-chart"></div>
							</div>
						</div>
					</div>
				</div>

				<div class="row height-45 panel-outer">
					<h4 class="panel-heading"><i class="icon-warning colorHeading"></i><span> Errors</span></h4>
					<div class="panel-inner">
						<div class="row">
							<div class="large-12 columns">
								<div id="errors"></div>
							</div>
						</div>
						<div class="row">
							<div class="large-12 columns">
							<table id="errors-table">
									<thead>
										<tr>
										<th></th>
										<th>ID</th>
										<th>Timestamp</th>
										<th>File type</th>
										<th>Status</th>
										<th>Size</th>
										<th>Rec.count</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td>es Here</td>
											<td>longer ct</td>
											<td>es Here</td>
											<td>es Here</td>
											<td>es Here</td>
											<td>es Here</td>
										</tr>
										<tr>
											<td>es Here</td>
											<td>longer Co</td>
											<td>es Here</td>
											<td>es Here</td>
											<td>es Here</td>
											<td>es Here</td>
										</tr>
										<tr>
											<td>es Here</td>
											<td>longer Co</td>
											<td>es Here</td>
											<td>es Here</td>
											<td>es Here</td>
											<td>es Here</td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
					</div>
				</div>

				<div class="row height-10 panel-outer">
					<h4 class="panel-heading"><i class="icon-tools colorHeading"></i><span> Work orders</span></h4>
					<div class="panel-inner pda-order">
						<label>Sent to PDAs today</label>
							<span id="work-orders-sent-to-pda"></span>
					</div>
					</div>
				</div>
			</div>

		</div><!-- end of big-row -->
		 <script>
		 startDashboard();
		 </script>
		<script src="<%=request.getContextPath()%>/js/highchart/system-dashboard-chart.js"></script>

		<!--[if lt IE 9]>
		<script type="text/javascript" src="https://raw.githubusercontent.com/chuckcarpenter/REM-unit-polyfill/master/js/rem.min.js"></script>
		<![endif]-->
	</body>
</html>
