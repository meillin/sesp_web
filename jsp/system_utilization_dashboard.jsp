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
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-1.9.1.min.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-migrate-1.1.1.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/colResizable-1.3.min.js"></script>
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

			<div class="large-3 columns">

				<div class="row">
					<div class="medium-12 columns panel">
						<div class="row">
							<div class="large-12 columns">Import servers</div>
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

				<div class="row">
					<div class="large-12 columns panel">
						<div class="row">
							<div class="large-12 columns">Export servers</div>
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

				<div class="row">
					<div class="large-12 columns panel">
						<div class="row">
							<div class="large-12 columns">Transaction servers</div>
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

			<div class="large-5 columns">
				<div class="row">
					<div class="large-12 columns panel">

						<div class="row">
							<div class="large-12 columns">Import statistics</div>
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
							<hr>
						<!--<table id="import-statistics-table"> use this table element when there is real data -->
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

				<div class="row">
					<div class="large-12 columns panel">
						<div class="row">
							<div class="large-12 columns">Export statistics</div>
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
						<hr>
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

			<div class="large-4 columns">
				<div class="row">
					<div class="large-12 columns panel">
						<div class="row">
							<div class="large-12 columns">Users</div>
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

				<div class="row">
					<div class="large-12 columns panel">
						<div class="row">
							<div class="large-12 columns">Errors</div>
						</div>
						<div class="row">
							<div class="large-12 columns">
								<div>Errors today</div>
								<div id="errors-today"></div>
							</div>
						</div>
						<div class="row">
							<div class="large-12 columns">
							<hr>
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

				<div class="row">
					<div class="large-12 columns">
							<div class="dashboard-block-title text-blue">Work orders</div>
						<div class="dashboard-block-content text-grey">
							<div class="dashboard-block-content-title">Sent to PDAs today</div>
							<div class="dashboard-block-content-data">
								<div id="work-orders-sent-to-pda"></div>
							</div>
					</div>
				</div>
			</div>

		</div><!-- end of big-row -->


		<!--
		<div id="main-content">

			<div class="col1 column">
			<div id="block-import-server" class="dashboard-block">
				<div class="dashboard-block-inner">
					<div class="dashboard-block-title text-blue">Import servers</div>
					<div class="dashboard-block-content text-grey">
						<div  class="sub-line1" >
							<div class="sub-col1">
								<div class="dashboard-block-content-title">CPU</div>
								<div id="import-servers-cpu" class="dashboard-block-content-data" ></div>
							</div>
							<div class="sub-col2" >
								<div class="dashboard-block-content-title">Memory</div>
								<div id="import-servers-memory" ></div>
							</div>
						</div>
						<div class="sub-line2">
								<div class="dashboard-block-content-title">Import threads</div>
								<div id="import-servers-import-threads" class="dashboard-block-content-data" ></div>
						</div>
					</div>
				</div>
			</div>

			<div id="block-export-server" class="dashboard-block">
				<div class="dashboard-block-inner">
					<div class="dashboard-block-title text-blue">Export servers</div>
					<div class="dashboard-block-content text-grey">
						<div  class="sub-line1" >
							<div class="sub-col1">
								<div class="dashboard-block-content-title">CPU</div>
								<div id="export-servers-cpu" class="dashboard-block-content-data" ></div>
							</div>
							<div class="sub-col2" >
								<div class="dashboard-block-content-title">Memory</div>
								<div id="export-servers-memory" ></div>
							</div>
						</div>
						<div class="sub-line2">
								<div class="dashboard-block-content-title">Export threads</div>
								<div id="export-servers-export-threads" class="dashboard-block-content-data" ></div>
						</div>
					</div>
				</div>
			</div>
<div id="block-transaction-server" class="dashboard-block">
					<div class="dashboard-block-inner">
						<div class="dashboard-block-title text-blue">Transaction server</div>
						<div class="dashboard-block-content text-grey">
							<div class="sub-col1 sub-col">
								<div class="dashboard-block-content-title">CPU</div>
								<div id="transaction-servers-cpu" class="dashboard-block-content-data">

								</div>
							</div>
						<div class="sub-col2 sub-col">
								<div class="dashboard-block-content-title">Memory</div>
								<div class="dashboard-block-content-data">
									<div id="transaction-servers-memory"></div>
								</div>
							</div>
						</div>
					</div>
				</div>

			</div>

		 <div class="col2 column">
			 <div id="block-import-statistics" class="dashboard-block">
					<div class="dashboard-block-inner">
						<div class="dashboard-block-title text-blue">Import statistics</div>
						<div class="dashboard-block-content text-grey">
							<div class="sub-line1 sub-line">
								<div class="sub-col1 sub-col">
									<div class="sub-line1 sub-line">
										<div class="dashboard-block-content-title">Files</div>
										<div id="import-statistics-files" class="dashboard-block-content-data">

										</div>
									</div>
								 <div class="sub-line2 sub-line">
										<div class="sub-col1 sub-col">
											<div class="dashboard-block-content-title">Files imported</div>
											<div class="dashboard-block-content-data">
												<div id="import-statistics-files-imported"></div>
											</div>
										</div>
									 <div class="sub-col2 sub-col">
											<div class="dashboard-block-content-title">Data imported</div>
											<div class="dashboard-block-content-data">
												<div id="import-statistics-data-imported"></div>
											</div>
										</div>
									</div>
								</div>
							 <div class="sub-col2 sub-col">
									<div class="sub-line1 sub-line">
										<div class="dashboard-block-content-title">Messages</div>
										<div id="import-statistics-messages" class="dashboard-block-content-data">

										</div>
									</div>
								 <div class="sub-line2 sub-line" >
										<div class="dashboard-block-content-title">Messages received</div>
										<div class="dashboard-block-content-data">
											<div id="import-statistics-messages-received">110</div>
										</div>
									</div>
								</div>
							</div>
						 <div class="sub-line2 sub-line">
								<table id="import-statistics-table">
									<tr>
										<th class="col1">ID</th>
										<th class="col2">Timestamp</th>
										<th class="col3">File type</th>
										<th class="col4">Status</th>
										<th class="col5">Size</th>
										<th class="col6">Rec.count</th>

									</tr>
								</table>
							</div>
						</div>
					</div>
				</div>
			 <div id="block-export-statistics" class="dashboard-block">
					<div class="dashboard-block-inner">
						<div class="dashboard-block-title text-blue">Export statistics</div>
						<div class="dashboard-block-content text-grey">
							<div class="sub-line1 sub-line">
								<div class="sub-col1 sub-col">
									<div class="sub-line1 sub-line">
										<div class="dashboard-block-content-title">Files</div>
										<div id="export-statistics-files" class="dashboard-block-content-data">
										</div>
									</div>
								 <div class="sub-line2 sub-line">
										<div class="sub-col1 sub-col">
											<div class="dashboard-block-content-title">Files exported</div>
											<div class="dashboard-block-content-data">
												<div id="export-statistics-files-exported"></div>
											</div>
										</div>
									 <div class="sub-col2 sub-col">
											<div class="dashboard-block-content-title">Data exported</div>
											<div class="dashboard-block-content-data">
												<div id="export-statistics-data-exported"></div>
											</div>
										</div>
									</div>
								</div>
							 <div class="sub-col2 sub-col">
									<div class="sub-line1 sub-line">
										<div class="dashboard-block-content-title">Messages</div>
										<div id="export-statistics-messages" class="dashboard-block-content-data">
										</div>
									</div>
								 <div class="sub-line2 sub-line">
										<div class="dashboard-block-content-title">Messages sent</div>
										<div class="dashboard-block-content-data">
											<div id="export-statistics-messages-sent"></div>
										</div>
									</div>
								</div>
							</div>
						 <div class="sub-line2 sub-line">
								<table id="export-statistics-table">
									<tr>
										<th class="col1">ID</th>
										<th class="col2">Timestamp</th>
										<th class="col3">File type</th>
										<th class="col4">Status</th>
									</tr>
								</table>
							</div>
						</div>
					</div>
				</div>
		 </div>

		 <div class="col3 column">
			 <div id="block-users" class="dashboard-block">
					<div class="dashboard-block-inner">
						<div class="dashboard-block-title text-blue">Users</div>
						<div class="dashboard-block-content text-grey">
							<div class="sub-line1 sub-line">
								<div class="dashboard-block-content-title">Users in system</div>
								<div id="users-system" class="dashboard-block-content-data">

								</div>
							</div>
						 <div class="sub-line2 sub-line">
								<div class="dashboard-block-content-title">Authentications today</div>
								<div id="users-authentifications-today" class="dashboard-block-content-data">

								</div>
							</div>
						</div>
					</div>
				</div>
			<div id="block-errors" class="dashboard-block">
					<div class="dashboard-block-inner">
						<div class="dashboard-block-title text-blue">Errors</div>
						<div class="dashboard-block-content text-grey">
							<div class="sub-line1 sub-line">
								<div class="dashboard-block-content-title">Errors today</div>
								<div id="errors-today" class="dashboard-block-content-data">
								</div>
							</div>
					<div class="sub-line2 sub-line">
								<table id="errors-table">
									<tr>
										<th class="col1">ID</th>
										<th class="col2">Timestamp</th>
										<th class="col3">Criticality</th>
										<th class="col4">Source</th>
										<th class="col5">Group</th>
									</tr>
								</table>
							</div>
						</div>
					</div>
				</div>
			<div id="block-work-orders" class="dashboard-block">
					<div class="dashboard-block-inner">
						<div class="dashboard-block-title text-blue">Work orders</div>
						<div class="dashboard-block-content text-grey">
							<div class="dashboard-block-content-title">Sent to PDAs today</div>
							<div class="dashboard-block-content-data">
								<div id="work-orders-sent-to-pda"></div>
							</div>
						</div>
					</div>
				</div>
		 </div>

		 </div>-->
		 <script>
		 startDashboard();
		 </script>

	</body>
</html>
