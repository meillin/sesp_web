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
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-1.9.1.min.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-migrate-1.1.1.js"></script>
		<script src="<%=request.getContextPath()%>/js/fusionchartsxt/charts/FusionCharts.js"></script>
		<script src="<%=request.getContextPath()%>/js/sesp_ajax.js"></script>
		<script src="<%=request.getContextPath()%>/js/spin.js"></script>
		<script src="<%=request.getContextPath()%>/js/ajax-loader.js"></script>

		<script type="text/javascript" src="<%=request.getContextPath()%>/js/system_dashboard.js"></script>
		<link rel="shortcut icon" type="image/png" href="<%=request.getContextPath()%>/images/favicon.png" />

	</head>
	<script>
		contextPath = "<%=request.getContextPath()%>";
		refreshInterval = "<%=request.getAttribute("refreshInterval")%>";
	</script>
	<body>

		<div class="big-row">

			<div class="large-3 columns full-height">

				<div class="row height-40">
					<div class="medium-6 large-12 columns column-body">
						<div class="row column-header">
							<div class="large-12 columns"><i class="fi-graph-pie"></i> Import servers</div>
						</div>
						<div class="row">
							<div class="small-6 columns">
								<label>CPU</label>
								<div id="import-servers-cpu"></div>
							</div>
							<div class="small-6 columns">
								<label>Import threads</label>
								<div id="import-servers-import-threads"></div>
							</div>
						</div>
						<div class="row">
							<div class="large-12 columns">
								<label>Memory</label>
								<div id="import-servers-memory" ></div>
							</div>
						</div>
					</div>
				</div>

				<div class="row height-40">
					<div class="medium-6 large-12 columns column-body">
						<div class="row column-header">
							<div class="large-12 columns"><i class="fi-graph-pie"></i> Export servers</div>
						</div>
						<div class="row">
							<div class="small-6 columns">
								<label>CPU</label>
								<div id="export-servers-cpu"></div>
							</div>
							<div class="small-6 columns">
								<label>Export threads</label>
								<div id="export-servers-export-threads"></div>
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

				<div class="row height-20">
					<div class="large-12 columns column-body">
						<div class="row column-header">
							<div class="large-12 columns"><i class="fi-graph-pie"></i> Transaction servers</div>
						</div>
						<div class="row">
							<div class="small-6 columns">
								<label>CPU</label>
								<div id="transaction-servers-cpu"></div>
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
				<div class="row height-50">
					<div class="large-12 columns column-body">

						<div class="row column-header">
							<div class="large-12 columns"><i class="fi-graph-trend"></i> Import statistics</div>
						</div>

						<div class="row">
							<div class="large-6 columns">
								<div>Files</div>
								<div id="import-statistics-files"></div>
								<div class="row">
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
								<div>Messages</div>
								<div id="import-statistics-messages"></div>
								<div class="row">
									<div class="large-12 columns">
										<div>Messages received</div>
										<div id="import-statistics-messages-received">110</div>
									</div>
								</div>
							</div>
						</div>

						<div class="row">
						<!--<table id="import-statistics-table"> use this table element when there is real data -->
						<div class="large-12 columns">
							<table>
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

				<div class="row height-50">
					<div class="large-12 columns column-body">
						<div class="row column-header">
							<div class="large-12 columns"><i class="fi-graph-trend"></i> Export statistics</div>
						</div>

						<div class="row">
							<div class="large-6 columns">
								<div>Files</div>
								<div id="export-statistics-files"></div>
								<div class="row">
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
								<div>Messages</div>
								<div id="export-statistics-messages"></div>
								<div class="row">
									<div class="large-12 columns">
										<div>Messages received</div>
										<div id="export-statistics-messages-received">110</div>
									</div>
								</div>
							</div>
						</div>

						<div class="row">
							<div class="large-12 columns">
						<!--<table id="export-statistics-table"> use this table element when there is real data -->
							<table>
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
			</div>

			<div class="large-4 columns full-height">
				<div class="row height-45">
					<div class="large-12 columns column-body">
						<div class="row column-header">
							<div class="large-12 columns"><i class="fi-torsos-all"></i> Users</div>
						</div>
						<div class="row">
							<div class="large-12 columns">
								<div>Users in system</div>
								<div id="users-system"></div>
							</div>
						</div>
						<div class="row">
							<div class="large-12 columns">
								<div>Authentications today</div>
								<div id="users-authentifications-today"></div>
							</div>
						</div>
					</div>
				</div>

				<div class="row height-45">
					<div class="large-12 columns column-body">
						<div class="row column-header">
							<div class="large-12 columns"><i class="fi-alert"></i> Errors</div>
						</div>
						<div class="row">
							<div class="large-12 columns">
								<div>Errors today</div>
								<div id="errors-today"></div>
							</div>
						</div>
						<div class="row">
							<div class="large-12 columns">
							<!--<table id="errors-table"> use this table element when there is real data -->
								<table>
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

				<div class="row height-10">
					<div class="large-12 columns column-body">
						<div class="row column-header">
							<div class="large-12 columns"><i class="fi-wrench"></i> Work orders</div>
						</div>
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

	</body>
</html>
