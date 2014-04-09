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

	</head>
	<script>
		contextPath = "<%=request.getContextPath()%>";
		refreshInterval = "<%=request.getAttribute("refreshInterval")%>";
	</script>
	<body>

		<div class="big-row">

			<div class="large-3 columns full-height">

				<div class="row height-40 panel-outer">
						<h4 class="panel-heading">
							<i class="fi-graph-pie"></i> Import servers
						</h4>
						<div class="panel-inner">
							<!--
							<div class="row">
								<div class="small-6 columns">
									<div id="import-servers"></div>
								</div>
								<div class="small-6 columns">
									<div id="import-servers-threads"></div>
								</div>
							</div>
							<div class="row">
								<div class="large-12 columns">
									<label>Memory</label>
									<div id="import-servers-memory" ></div>
								</div>
							</div>
							-->
							<div class="row">
								<div class="large-4 columns">
									<div id="import-servers"></div>
									<label>Memory</label>
									<div id="import-servers-memory" ></div>
								</div>
								<div class="large-8 columns">
									<div id="import-servers-threads"></div>
								</div>
							</div>

						</div>
				</div>

				<div class="row height-40 panel-outer">
						<h4 class="panel-heading">
							<i class="fi-graph-pie"></i> Export servers
						</h4>
						<div class="panel-inner">
							<div class="row">
								<div class="small-6 columns">
									<div id="export-servers"></div>
								</div>
								<div class="small-6 columns">
									<div id="export-servers-threads"></div>
								</div>
							</div>
							<div class="row">
								<div class="large-12 columns">
									<label>Memory</label>
									<div id="export-servers-memory" ></div>
									</div>
							</div>
						</div>
					</div>

				<div class="row height-20 panel-outer">
					<h4 class="panel-heading">
						<i class="fi-graph-pie"></i> Transaction servers
					</h4>
					<div class="panel-inner">
						<div class="row">
								<div class="small-6 columns">
									<div id="transaction-servers"></div>
								</div>
								<div class="small-6 columns">
									<label>Memory</label>
									<div id="transaction-servers-memory"></div>
								</div>
							</div>
						</div>
					</div>
			</div>

			<div class="large-5 columns full-height">
				<div class="row height-50 panel-outer">

						<div class="panel-heading">
							<h4><i class="fi-graph-trend"></i> Import statistics</h4>
						</div>
						<div class="height-50 panel-inner">
							<div class="large-6 columns">
								<div id="import-files"></div>
								<div class="row info text-center">
									<div class="small-6 columns">
											<div>Files imported</div>
											<div id="import-statistics-files-imported">123</div>
									</div>
									<div class="small-6 columns">
											<div>Data imported</div>
											<div id="import-statistics-data-imported">321</div>
									</div>
								</div>
							</div>

							<div class="large-6 columns">
								<div id="import-messages"></div>
								<div class="row info text-center">
									<div class="large-12 columns">
											<div>Messages received</div>
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
					<div class="panel-heading">
						<h4><i class="fi-graph-trend"></i> Export statistics</h4>
					</div>
					<div class="panel-inner">
							<div class="large-6 columns">
								<div id="export-files"></div>
								<div class="row info text-center">
									<div class="small-6 columns">
										<div>Files exported</div>
										<div id="export-statistics-files-exported">123</div>
									</div>
									<div class="small-6 columns">
										<div>Data exported</div>
										<div id="export-statistics-data-exported">321</div>
									</div>
								</div>
							</div>

							<div class="large-6 columns">
								<div id="export-messages"></div>
								<div class="row info text-center">
									<div class="large-12 columns">
										<div>Messages received</div>
										<div id="export-statistics-messages-received">110</div>
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
					<h4 class="panel-heading"><i class="fi-torsos-all"></i> Users</h4>
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
					<h4 class="panel-heading"><i class="fi-alert"></i> Errors</h4>
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
					<h4 class="panel-heading"><i class="fi-wrench"></i> Work orders</h4>
					<div class="panel-inner">
						<div class="row">
							<div class="large-12 columns">
								<div>Sent to PDAs today</div>
								<div id="work-orders-sent-to-pda"></div>
							</div>
						</div>
					</div>
				</div>
			</div>

		</div><!-- end of big-row -->
		 <script>
		 startDashboard();
		 </script>
		<script src="<%=request.getContextPath()%>/js/highchart/system-dashboard-chart.js"></script>
	</body>
</html>
