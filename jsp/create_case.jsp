<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="s" uri="/struts-tags"%>
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
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/styles/color.css"/>
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/styles/general.css" />
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/styles/content-block.css" />
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/styles/content-case.css" />
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/js/dhtmlxGrid/codebase/dhtmlxgrid.css" />
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/styles/style.tidy.css" />

		<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-1.9.1.min.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-migrate-1.1.1.js"></script>

		<script type="text/javascript" src="<%=request.getContextPath()%>/js/sesp_ajax.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/search-results.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/case.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/OpenLayers.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/map.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/dhtmlxGrid/codebase/dhtmlxcommon.js"></script>
        <script type="text/javascript" src="<%=request.getContextPath()%>/js/dhtmlxGrid/codebase/dhtmlxgrid.js"></script>
        <script type="text/javascript" src="<%=request.getContextPath()%>/js/dhtmlxGrid/codebase/dhtmlxgridcell.js"></script>
        <script type="text/javascript" src="<%=request.getContextPath()%>/js/dhtmlxGrid/codebase/customdhtmlxgrid_export.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/spin.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/ajax-loader.js"></script>

	</head>
	<body>
	<script>
        contextPath = "<%=request.getContextPath()%>";
        caseId="<%=request.getAttribute("id")%>";
        mapServerUrl= "<%=application.getAttribute("MAP_SERVER_URL")%>";
        i18nerrorNoCaseData = "<s:text name='webportal.case.results.error.nocaseresults'/>";
        i18nerrorInvalidCaseAction = "<s:text name='webportal.case.results.error.invalidcaseaction'/>";
		woEventsExportHeader = "<s:text name='webportal.case.work.order.events.type'/>, " +
					" <s:text name='webportal.case.work.order.events.timestamp'/>, " +
					" <s:text name='webportal.case.work.order.events.result'/>, " +
					" <s:text name='webportal.case.work.order.events.source'/>, " +
					" <s:text name='webportal.case.work.order.events.create.signature'/>, " +
					" <s:text name='webportal.case.work.order.events.create.timestamp'/> ";

    </script>

		<div id="wrapper">

			<!--  Header -->
			<%@ include file="headerv311.inc"%>

			<div id="main-content">

				<div class="title-large-block large-block text-grey">
					<s:text name="webportal.case.results.text.description"/> : <span id="case-id" class=" text-light-grey"> </span>
				</div>

				<div class="small-block block retractable" id="block-overview">

					<div class="block-title">
						<span class="block-title-picto"></span>
						<span class="block-title-name text-blue"><s:text name="webportal.case.overview.title"/></span>
						<span class="block-arrow open"></span>
					</div>

					<div class="content-wrapper">

						<div class="content">

						<div class="legend-block text-grey">

							<table id="overview-table">
								<tr>
									<td width="44%"><div class="legend-block-title"><s:text name="webportal.case.overview.case.type"/> : </div></td>
									<td width="55%"><div class="legend-block-content text-light-grey" id="block-overview-case-type"></div></td>
								</tr>
								<tr >
									<td><div class="legend-block-title"><s:text name="webportal.case.overview.case.user"/> : </div></td>
									<td><div class="legend-block-content text-light-grey" id="block-overview-user"></div></td>
								</tr>
								<tr >
									<td><div class="legend-block-title"><s:text name="webportal.case.overview.external.id"/> : </div></td>
									<td><div class="legend-block-content text-light-grey" id="block-overview-external-id"></div></td>
								</tr>
								<tr >
									<td><div class="legend-block-title"><s:text name="webportal.case.overview.orginal.id"/> : </div></td>
									<td><div class="legend-block-content text-light-grey" id="block-overview-original-id"></div></td>
								</tr>
								<tr >
									<td><div class="legend-block-title"><s:text name="webportal.case.overview.domain"/> : </div></td>
									<td><div class="legend-block-content text-light-grey" id="block-overview-domain"></div></td>
								</tr>
								<tr >
									<td><div class="legend-block-title"><s:text name="webportal.case.overview.create.timestamp"/> : </div></td>
									<td><div class="legend-block-content text-light-grey" id="block-overview-creat-timestamp"></div></td>
								</tr>
								<tr >
									<td><div class="legend-block-title"><s:text name="webportal.case.overview.last.changed"/> : </div></td>
									<td><div class="legend-block-content text-light-grey" id="block-overview-last-changed"></div></td>
								</tr>
								<tr >
									<td><div class="legend-block-title"><s:text name="webportal.case.overview.field.company"/> : </div></td>
									<td><div class="legend-block-content text-light-grey" id="block-overview-field-company"></div></td>
								</tr>
								<tr>
									<td><div class="legend-block-title"><s:text name="webportal.case.overview.reason"/> : </div></td>
									<td><div class="legend-block-content text-light-grey" id="block-overview-reason"></div></td>
								</tr>
								<tr>
									<td><div class="legend-block-title"><s:text name="webportal.case.overview.case.result"/> : </div></td>
									<td><div class="legend-block-content text-light-grey" id="block-overview-case-result"></div></td>
								</tr>
							</table>
							<div id="block-overview-status">  </div>

							</div>

						</div>
					</div>
				</div>


				<div class="small-block block retractable" id="block-location">
					<div class="block-title">
						<span class="block-title-picto"></span>
						<span class="block-title-name text-blue"><s:text name="webportal.case.location.title"/></span>
						<span class="block-arrow open"></span>
					</div>
					<div class="content-wrapper">

						<div class="content">

							<div id="block-case-location-map-wrapper" style="width:444px; height:288px">
								<!-- <iframe width="444" height="264" frameborder="0" scrolling="no" marginheight="0" marginwidth="0" src="http://www.openstreetmap.org/export/embed.html?bbox=-1.55302,47.19581,-1.50817,47.22307&amp;layer=mapnik&amp;marker=47.21659,-1.53457"></iframe>  -->
							</div>
							<div class="legend">
								<div class="address legend-block text-grey">
									<div class="legend-block-title"><s:text name="webportal.case.location.address"/> :</div>
									<div class="legend-block-content text-light-grey" id="block-location-adress"></div>
								</div>
								<div class="area legend-block text-grey">
									<div class="legend-block-title"><s:text name="webportal.case.location.area"/> :</div>
									<div class="legend-block-content text-light-grey" id="block-location-area"></div>
								</div>
							</div>
						</div>
					</div>
				</div>

				<div class="large-block block retractable" id="block-installations">
					<div class="block-title">
						<span class="block-title-picto"></span>
						<span class="block-title-name text-blue"><s:text name="webportal.case.installation.title"/></span>
						<span class="block-title-number text-blue"><span id="block-installations-number" class="number"></span></span>
						<span class="block-arrow open"></span>
					</div>
					<div class="content-wrapper">
						<div class="content">
							<table id="caseInstallation" class="text-grey installation-table big-table">
							<thead>
								<tr class="table-title">
									<th class="col1"> &nbsp;&nbsp;&nbsp; <s:text name="webportal.case.installation.id"/></th>
									<th class="col2"><s:text name="webportal.case.installation.code"/></th>
									<th class="col3"><s:text name="webportal.case.installation.extcode"/></th>
									<th class="col4"><s:text name="webportal.case.lastchanged"/></th>
									<th class="col5"><s:text name="webportal.case.installation.region"/></th>
									<th class="col6"><s:text name="webportal.case.installation.milestone.area"/></th>
									<th class="col7"><s:text name="webportal.case.installation.net.area"/></th>
									<th class="col8"><s:text name="webportal.case.installation.status"/></th>
								</tr>
							</thead>
							<tbody>
							</tbody>
							</table>
							<div class="center-wrapper">
								<a href="javascript:showMoreResults('INST')" id="block-case-installation-link-more" class="link-more text-blue"><s:text name="webportal.case.installation.options.showmore"/></a>
							</div>
						</div>
					</div>
				</div>

				<div class="large-block block retractable" id="block-sla">
					<div class="block-title">
						<span class="block-title-picto"></span>
						<span class="block-title-name text-blue"><s:text name="webportal.case.sla.title"/></span>
						<span class="block-title-number text-blue"><span id="block-sla-number" class="number"></span></span>
						<span class="block-arrow open"></span>
					</div>
					<div class="content-wrapper">
						<div class="content">
							<table id="caseSla" class="text-grey stock-site-table big-table">
							<thead>
								<tr class="table-title">
									<th class="col1"> &nbsp;&nbsp;&nbsp; <s:text name="webportal.case.sla.name"/></th>
									<th class="col2"><s:text name="webportal.case.sla.ordering.company"/></th>
									<th class="col3"><s:text name="webportal.case.sla.executing.company"/></th>
									<th class="col4"><s:text name="webportal.case.sla.start"/></th>
									<th class="col4"><s:text name="webportal.case.sla.end"/></th>
									<th class="col5"><s:text name="webportal.case.sla.deadline"/></th>
									<th class="col6"><s:text name="webportal.case.sla.start.earliest"/></th>
									<th class="col7"><s:text name="webportal.case.sla.start.latest"/></th>
								</tr>
							</thead>
							<tbody>
							</tbody>
							</table>
							<div class="center-wrapper">
								<a href="javascript:showMoreResults('SLA')" id="block-case-sla-link-more" class="link-more text-blue"><s:text name="webportal.case.sla.options.showmore"/></a>
							</div>

						</div>
					</div>
				</div>

				<div class="large-block block retractable" id="block-information">
					<div class="block-title">
						<span class="block-title-picto"></span>
						<span class="block-title-name text-blue"><s:text name="webportal.case.information.title"/></span>
						<span class="block-title-number text-blue"><span id="block-information-number" class="number"></span></span>
						<span class="block-arrow open"></span>
					</div>
					<div class="content-wrapper">
						<div class="content">
							<table id="caseInformation" class="text-grey pallet-table big-table">
							<thead>
								<tr class="table-title">
									<th class="col1"> &nbsp;&nbsp;&nbsp; <s:text name="webportal.case.information.info.type"/></th>
									<th class="col2"><s:text name="webportal.case.information.text"/></th>
									<th class="col3"><s:text name="webportal.case.information.timestamp"/></th>
									<th class="col4"><s:text name="webportal.case.information.user.signature"/></th>
									<th class="col5"><s:text name="webportal.case.information.source"/></th>
								</tr>
							</thead>
							<tbody>
							</tbody>
							</table>
							<div class="center-wrapper">
								<a href="javascript:showMoreResults('INFO')" id="block-case-information-link-more" class="link-more text-blue"><s:text name="webportal.case.information.options.showmore"/></a>
							</div>

						</div>
					</div>
				</div>

				<div class="large-block block retractable" id="block-messages">
					<div class="block-title">
						<span class="block-title-picto"></span>
						<span class="block-title-name text-blue"><s:text name="webportal.case.messages.title"/></span>
						<span class="block-title-number text-blue"><span id="block-messages-number" class="number"></span></span>
						<span class="block-arrow open"></span>
					</div>
					<div class="content-wrapper">
						<div class="content">
							<table id="caseMessages" class="text-grey owner-table big-table">
							<thead>
								<tr class="table-title">
									<th class="col1"> &nbsp;&nbsp;&nbsp; <s:text name="webportal.case.messages.id"/></th>
									<th class="col2"><s:text name="webportal.case.messages.type"/></th>
									<th class="col3"><s:text name="webportal.case.messages.status"/></th>
									<th class="col4"><s:text name="webportal.case.messages.execute.timestamp"/></th>
									<th class="col5"><s:text name="webportal.case.messages.create.signature"/></th>
									<th class="col6"><s:text name="webportal.case.messages.create.timestamp"/></th>
								</tr>
							</thead>
							<tbody>
							</tbody>
							</table>
							<div class="center-wrapper">
								<a href="javascript:showMoreResults('MESSAGES')" id="block-case-messages-link-more" class="link-more text-blue"><s:text name="webportal.case.messages.options.showmore"/></a>
							</div>

						</div>
					</div>
				</div>


					<div class="large-block block block-accordion" id="block-history">
					<div class="block-title">
						<span class="block-title-picto"></span>
						<span class="block-title-name text-blue"><s:text name="webportal.case.history.title"/></span>
						<a href="#" class="block-title-button-open-all text-blue"><s:text name="webportal.case.results.options.openall"/></a>
						<a href="#" class="block-title-button-close-all text-blue"><s:text name="webportal.case.results.options.closeall"/></a>
					</div>
					<div class="content-wrapper">
						<div class="content">

							<ul class="accordion">

								<li class="toggleSubMenu" id="block-history-status">
									<span class="accordion-title">&#149; <span class="accordion-title-name"><s:text name="webportal.case.history.status.title"/></span> <span id="block-case-status-history-number" class="number"></span><div class="accordion-arrow close"></div></span>
									<ul class="subMenu">
										<table id="caseStatusHistory" class="text-grey owner-table">
										<thead>
											<tr class="table-title">
												<th class="col1"> &nbsp;&nbsp;&nbsp; <s:text name="webportal.case.history.status.case.status"/></th>
												<th class="col2"><s:text name="webportal.case.history.status.start.timestamp"/></th>
												<th class="col3"><s:text name="webportal.case.history.status.end.timestamp"/></th>
												<th class="col4"><s:text name="webportal.case.history.status.created.by"/></th>
												<th class="col5"><s:text name="webportal.case.history.status.changed.by"/></th>
												<th class="col6"><s:text name="webportal.case.history.status.create.timestamp"/></th>
												<th class="col7"><s:text name="webportal.case.history.status.change.timestamp"/></th>
											</tr>
										</thead>
										<tbody>
										</tbody>
										</table>
										<div class="center-wrapper">
											<a href="javascript:showMoreResults('HISTORY_STATUS')" id="block-case-history-status-link-more" class="link-more text-blue"><s:text name="webportal.case.history.status.options.showmore"/></a>
										</div>
									</ul>
								</li>
								<li class="toggleSubMenu" id="block-history-action">
									<span class="accordion-title">&#149; <span class="accordion-title-name"><s:text name="webportal.case.action.history.title"/></span> <span id="block-case-status-action-number" class="number"> </span><div class="accordion-arrow close"></div></span>
									<ul class="subMenu">
										<table id="caseActionHistory" class="text-grey owner-table">
										<thead>
											<tr class="table-title">
												<th class="col1"> &nbsp;&nbsp;&nbsp; <s:text name="webportal.case.action.history.action"/></th>
												<th class="col2"><s:text name="webportal.case.action.history.timestamp"/></th>
												<th class="col3"><s:text name="webportal.case.action.history.create.signature"/></th>
												<th class="col4"><s:text name="webportal.case.action.history.create.timestamp"/></th>
											</tr>
										</thead>
										<tbody>
										</tbody>
										</table>
										<div class="center-wrapper">
											<a href="javascript:showMoreResults('HISTORY_ACTION')" id="block-case-history-action-link-more" class="link-more text-blue"><s:text name="webportal.case.action.history.options.showmore"/></a>
										</div>
									</ul>
								</li>
								<li class="toggleSubMenu" id="block-history-customer-contact">
									<span class="accordion-title">&#149; <span class="accordion-title-name"><s:text name="webportal.case.customer.contact.history.title"/></span> <span id="block-case-cust-contact-number" class="number"></span><div class="accordion-arrow close"></div></span>
									<ul class="subMenu">
										<table id="caseCustContactHistory" class="text-grey owner-table">
										<thead>
											<tr class="table-title">
												<th class="col1"> &nbsp;&nbsp;&nbsp; <s:text name="webportal.case.customer.contact.history.contact.type"/></th>
												<th class="col2"><s:text name="webportal.case.customer.contact.history.comm.type"/></th>
												<th class="col3"><s:text name="webportal.case.customer.contact.history.local.date"/></th>
												<th class="col4"><s:text name="webportal.case.customer.contact.history.customer.date"/></th>
												<th class="col5"><s:text name="webportal.case.customer.contact.history.result"/></th>
												<th class="col6"><s:text name="webportal.case.customer.contact.history.note"/></th>
												<th class="col6"><s:text name="webportal.case.customer.contact.history.create.signature"/></th>
												<th class="col6"><s:text name="webportal.case.customer.contact.history.create.timestamp"/></th>
											</tr>
										</thead>
										<tbody>
										</tbody>
										</table>
										<div class="center-wrapper">
											<a href="javascript:showMoreResults('HISTORY_CONTACT')" id="block-case-history-customer-contact-link-more" class="link-more text-blue"><s:text name="webportal.case.customer.contact.options.showmore"/></a>
										</div>
									</ul>
								</li>
							</ul>

						</div>
					</div>
				</div>

				<div class="large-block block retractable" id="block-work-order-events">
					<div class="block-title">
						<span class="block-title-picto"></span>
						<span class="block-title-name text-blue"><s:text name="webportal.case.work.order.events.title"/></span>
						<span class="block-title-number text-blue"><span id="block-work-order-events-number" class="number"></span>
						<span class="block-arrow open"></span>
					</div>

					<div class="content-wrapper">
						<div class="content">

							<div id="woEventsGridDiv"></div>
							<table id="caseWoEvents" class="text-grey owner-table big-table">
							<thead>
								<tr class="table-title" >
									<th class="col1"> &nbsp;&nbsp;&nbsp; <s:text name="webportal.case.work.order.events.type"/></th>
									<th class="col2"><s:text name="webportal.case.work.order.events.timestamp"/></th>
									<th class="col3"><s:text name="webportal.case.work.order.events.result"/></th>
									<th class="col4"><s:text name="webportal.case.work.order.events.source"/></th>
									<th class="col5"><s:text name="webportal.case.work.order.events.create.signature"/></th>
									<th class="col6"><s:text name="webportal.case.work.order.events.create.timestamp"/></th>
								</tr>
							</thead>
							<tbody>
							</tbody>
							</table>
							<div class="center-wrapper">
								<a href="javascript:showMoreResults('WORK_ORDER')" id="block-case-wo-events-link-more" class="link-more text-blue"><s:text name="webportal.case.work.order.events.options.showmore"/></a>
								<span id="block-work-order-events-export-link" style="position:absolute;right:20px;bottom:10px;">
								  <a href="#" onclick="javascript:woEventsExportGrid.toExcel('<%=request.getContextPath()%>/std/DownloadWoEventsExcel.action','WO Case Event','color','HEADER');" class="link-more text-blue" align="right">
								  	<img src="<%=request.getContextPath()%>/images/excel-icon.png" height="12px" width="11px" /> Export to Excel
								  </a>
							   </span>
							</div>
						</div>
					</div>
				</div>



			</div>

			<!-- Footer -->
			<%@ include file="footerv311.inc"%>

		</div>

		<iframe id="myIFrm" name="myIFrm" src="" style="height: 0px; visibility: hidden"> </iframe>

	</body>
</html>
