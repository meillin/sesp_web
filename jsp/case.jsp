<!DOCTYPE html>
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
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/styles/foundation.css" />
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/foundation-icons/foundation-icons.css">

		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/styles/color.css"/>
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/styles/general.css" />
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/styles/header.css" />
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/styles/content-block.css" />
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/styles/footer.css" />
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/styles/content-case.css" />
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/js/dhtmlxGrid/codebase/dhtmlxgrid.css" />
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/styles/style.tidy.css" />
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/styles/colResizable.css" />

		<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-1.9.1.min.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-migrate-1.1.1.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/colResizable-1.3.min.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/init.js"></script>

		<script type="text/javascript" src="<%=request.getContextPath()%>/js/common.js"></script>

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
				<div class="big-row">
					<div class="large-12 columns">
						<h2 class="page-name-heading">
							<s:text name="webportal.case.results.text.description"/> : <span id="case-id"> </span>
						</h2>
					</div>
				</div>
				<div class="big-row">
					<div class="large-6 columns">
						<div class="panel-outer">
							<h4 class="panel-heading">
								<i class="fi-graph-trend colorHeading"></i>
								<span><s:text name="webportal.case.overview.title"/></span>
							</h4>
							<div class="panel-inner">
								<table id="overview-table">	
									<tr>
										<td><div><s:text name="webportal.case.overview.case.type"/> : </div></td>
										<td><div id="block-overview-case-type"></div></td>
									</tr>
									<tr >
										<td><div><s:text name="webportal.case.overview.case.user"/> : </div></td>
										<td><div id="block-overview-user"></div></td>
									</tr>
									<tr >
										<td><div><s:text name="webportal.case.overview.external.id"/> : </div></td>
										<td><div id="block-overview-external-id"></div></td>
									</tr>
									<tr >
										<td><div ><s:text name="webportal.case.overview.orginal.id"/> : </div></td>
										<td><div id="block-overview-original-id"></div></td>
									</tr>
									<tr >
										<td><div><s:text name="webportal.case.overview.domain"/> : </div></td>
										<td><div id="block-overview-domain"></div></td>
									</tr>
									<tr >
										<td><div><s:text name="webportal.case.overview.create.timestamp"/> : </div></td>
										<td><div id="block-overview-creat-timestamp"></div></td>
									</tr>
									<tr >
										<td><div><s:text name="webportal.case.overview.last.changed"/> : </div></td>
										<td><div id="block-overview-last-changed"></div></td>
									</tr>
									<tr >
										<td><div><s:text name="webportal.case.overview.field.company"/> : </div></td>
										<td><div id="block-overview-field-company"></div></td>
									</tr>
									<tr>
										<td><div><s:text name="webportal.case.overview.reason"/> : </div></td>
										<td><div id="block-overview-reason"></div></td>
									</tr>
									<tr>
										<td><div><s:text name="webportal.case.overview.case.result"/> : </div></td>
										<td><div id="block-overview-case-result"></div></td>
									</tr>
								</table>
								<div id="block-overview-status">  </div>
							</div>
						</div>
					</div>
					<div class="large-6 columns">
						<div class="panel-outer">
							<h4 class="panel-heading">
								<i class="fi-graph-trend colorHeading"></i>
								<s:text name="webportal.case.location.title"/>
							</h4>
							<div class="panel-inner">
								<div id="block-case-location-map-wrapper" style="height:300px">
									<!-- <iframe width="444" height="264" frameborder="0" scrolling="no" marginheight="0" marginwidth="0" src="http://www.openstreetmap.org/export/embed.html?bbox=-1.55302,47.19581,-1.50817,47.22307&amp;layer=mapnik&amp;marker=47.21659,-1.53457"></iframe>  -->
								</div>
								<div class="legend">
									<div>
										<div><s:text name="webportal.case.location.address"/> :</div>
										<div id="block-location-adress"></div>
									</div>
									<div>
										<div><s:text name="webportal.case.location.area"/> :</div>
										<div id="block-location-area"></div>									
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="big-row">
					<div class="large-12 columns">
						<div class="panel-outer">
							<h4 class="panel-heading">
								<i class="fi-graph-trend colorHeading"></i>
								<s:text name="webportal.case.installation.title"/>
								<span id="block-installations-number"></span>
							</h4>
							<div class="panel-inner">
								<table id="caseInstallation">
									<thead>
										<tr class="table-title">
											<th><s:text name="webportal.case.installation.id"/></th>
											<th><s:text name="webportal.case.installation.code"/></th>
											<th><s:text name="webportal.case.installation.extcode"/></th>
											<th><s:text name="webportal.case.lastchanged"/></th>
											<th><s:text name="webportal.case.installation.region"/></th>
											<th><s:text name="webportal.case.installation.milestone.area"/></th>
											<th><s:text name="webportal.case.installation.net.area"/></th>
											<th><s:text name="webportal.case.installation.status"/></th>
										</tr>
									</thead>
									<tbody>
									</tbody>
								</table>
								<div class="center-wrapper">
									<a href="javascript:showMoreResults('INST')" id="block-case-installation-link-more"><s:text name="webportal.case.installation.options.showmore"/></a>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="big-row">
					<div class="large-8 columns">
						<div class="panel-outer">
							<h4 class="panel-heading">
								<i class="fi-graph-trend colorHeading"></i>
								<span><s:text name="webportal.case.sla.title"/></span>
								<span><span id="block-sla-number"></span></span>
							</h4>
							<div class="panel-inner">
								<table id="caseSla">
									<thead>
										<tr class="table-title">
											<th><s:text name="webportal.case.sla.name"/></th>
											<th><s:text name="webportal.case.sla.ordering.company"/></th>
											<th><s:text name="webportal.case.sla.executing.company"/></th>
											<th><s:text name="webportal.case.sla.start"/></th>
											<th><s:text name="webportal.case.sla.end"/></th>
											<th><s:text name="webportal.case.sla.deadline"/></th>
											<th><s:text name="webportal.case.sla.start.earliest"/></th>
											<th><s:text name="webportal.case.sla.start.latest"/></th>
										</tr>
									</thead>
									<tbody>
									</tbody>
								</table>
								<div class="center-wrapper">
									<a href="javascript:showMoreResults('SLA')" id="block-case-sla-link-more"><s:text name="webportal.case.sla.options.showmore"/></a>
								</div>	
							</div>
						</div>
					</div>
					<div class="large-4 columns">
						<div class="panel-outer">
							<h4 class="panel-heading">
								<i class="fi-graph-trend colorHeading"></i>
								<span><s:text name="webportal.case.information.title"/></span>
								<span><span id="block-information-number"></span></span>
							</h4>
							<div class="panel-inner">
								<table id="caseInformation">
									<thead>
										<tr class="table-title">
											<th><s:text name="webportal.case.information.info.type"/></th>
											<th><s:text name="webportal.case.information.text"/></th>
											<th><s:text name="webportal.case.information.timestamp"/></th>
											<th><s:text name="webportal.case.information.user.signature"/></th>
											<th><s:text name="webportal.case.information.source"/></th>
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
				</div>
				<div class="big-row">
					<div class="large-6 columns">
						<div class="panel-outer">
							<h4 class="panel-heading">
								<i class="fi-graph-trend colorHeading"></i>
								<span><s:text name="webportal.case.messages.title"/></span>
								<span><span id="block-messages-number"></span></span>
							</h4>
							<div class="panel-inner">
								<table id="caseMessages" class="text-grey owner-table big-table">
									<thead>
										<tr class="table-title">
											<th><s:text name="webportal.case.messages.id"/></th>
											<th><s:text name="webportal.case.messages.type"/></th>
											<th><s:text name="webportal.case.messages.status"/></th>
											<th><s:text name="webportal.case.messages.execute.timestamp"/></th>
											<th><s:text name="webportal.case.messages.create.signature"/></th>
											<th><s:text name="webportal.case.messages.create.timestamp"/></th>
										</tr>
									</thead>
									<tbody>
									</tbody>
								</table>
								<div class="center-wrapper">
									<a href="javascript:showMoreResults('MESSAGES')" id="block-case-messages-link-more"><s:text name="webportal.case.messages.options.showmore"/></a>
								</div>	
							</div>
						</div>
					</div>
					<div class="large-6 columns">
						<div class="panel-outer">
							<h4 class="panel-heading">
								<i class="fi-graph-trend colorHeading"></i>
								<span class="block-title-name text-blue"><s:text name="webportal.case.work.order.events.title"/></span>
								<span class="block-title-number text-blue"><span id="block-work-order-events-number" class="number"></span>	
							</h4>
							<div class="panel-inner">
								<table id="caseWoEvents">
									<thead>
										<tr class="table-title" >
											<th><s:text name="webportal.case.work.order.events.type"/></th>
											<th><s:text name="webportal.case.work.order.events.timestamp"/></th>
											<th><s:text name="webportal.case.work.order.events.result"/></th>
											<th><s:text name="webportal.case.work.order.events.source"/></th>
											<th><s:text name="webportal.case.work.order.events.create.signature"/></th>
											<th><s:text name="webportal.case.work.order.events.create.timestamp"/></th>
										</tr>
									</thead>
									<tbody>
									</tbody>
								</table>
								<div class="center-wrapper">
									<a href="javascript:showMoreResults('WORK_ORDER')" id="block-case-wo-events-link-more" class="link-more text-blue"><s:text name="webportal.case.work.order.events.options.showmore"/></a>
									<span id="block-work-order-events-export-link">
										<a href="#" onclick="javascript:woEventsExportGrid.toExcel('<%=request.getContextPath()%>/std/DownloadWoEventsExcel.action','WO Case Event','color','HEADER');" align="right">Export to Excel</a>
									</span>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="big-row">
					<div class="large-12 columns">
						<div class="panel-outer">
							<h4 class="panel-heading">
								<i class="fi-graph-trend colorHeading"></i>
								<span><s:text name="webportal.case.history.title"/></span>
							</h4>
							<div class="panel-inner">
								<span class="accordion-title"><span class="accordion-title-name">
									<s:text name="webportal.case.history.status.title"/></span> <span id="block-case-status-history-number" class="number"></span><div class="accordion-arrow close"></div></span>
									<table id="caseStatusHistory">
										<thead>
											<tr class="table-title">
												<th><s:text name="webportal.case.history.status.case.status"/></th>
												<th><s:text name="webportal.case.history.status.start.timestamp"/></th>
												<th><s:text name="webportal.case.history.status.end.timestamp"/></th>
												<th><s:text name="webportal.case.history.status.created.by"/></th>
												<th><s:text name="webportal.case.history.status.changed.by"/></th>
												<th><s:text name="webportal.case.history.status.create.timestamp"/></th>
												<th><s:text name="webportal.case.history.status.change.timestamp"/></th>
											</tr>
										</thead>
										<tbody>
										</tbody>
									</table>
									<div class="center-wrapper">
										<a href="javascript:showMoreResults('HISTORY_STATUS')" id="block-case-history-status-link-more"><s:text name="webportal.case.history.status.options.showmore"/></a>
									</div>
									<span><span><s:text name="webportal.case.action.history.title"/></span> <span id="block-case-status-action-number"> </span></span>
									<table id="caseActionHistory">
										<thead>
											<tr>
												<th><s:text name="webportal.case.action.history.action"/></th>
												<th><s:text name="webportal.case.action.history.timestamp"/></th>
												<th><s:text name="webportal.case.action.history.create.signature"/></th>
												<th><s:text name="webportal.case.action.history.create.timestamp"/></th>
											</tr>
										</thead>
										<tbody>
										</tbody>
									</table>
									<div class="center-wrapper">
										<a href="javascript:showMoreResults('HISTORY_ACTION')" id="block-case-history-action-link-more">
											<s:text name="webportal.case.action.history.options.showmore"/></a>
										</div>
										<span><span><s:text name="webportal.case.customer.contact.history.title"/></span> 
										<span id="block-case-cust-contact-number"></span></span>
										<table id="caseCustContactHistory">
											<thead>
												<tr class="table-title">
													<th><s:text name="webportal.case.customer.contact.history.contact.type"/></th>
													<th><s:text name="webportal.case.customer.contact.history.comm.type"/></th>
													<th><s:text name="webportal.case.customer.contact.history.local.date"/></th>
													<th><s:text name="webportal.case.customer.contact.history.customer.date"/></th>
													<th><s:text name="webportal.case.customer.contact.history.result"/></th>
													<th><s:text name="webportal.case.customer.contact.history.note"/></th>
													<th><s:text name="webportal.case.customer.contact.history.create.signature"/></th>
													<th><s:text name="webportal.case.customer.contact.history.create.timestamp"/></th>
												</tr>
											</thead>
											<tbody>
											</tbody>
										</table>
										<div class="center-wrapper">
											<a href="javascript:showMoreResults('HISTORY_CONTACT')" id="block-case-history-customer-contact-link-more"><s:text name="webportal.case.customer.contact.options.showmore"/></a>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<!-- Footer -->
				</div>
				<iframe id="myIFrm" name="myIFrm" src="" style="height: 0px; visibility: hidden"> </iframe>
			</body>
			</html>
