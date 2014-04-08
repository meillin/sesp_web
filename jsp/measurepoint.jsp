<!DOCTYPE html>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title><s:text name="webportal.head.title"/></title>
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
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/styles/content-measurepoint.css" />
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
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/measurepoint.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/OpenLayers.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/map.js"></script>

		<script src="<%=request.getContextPath()%>/js/fusionchartsxt/charts/FusionCharts.js"></script>		
		<script src="<%=request.getContextPath()%>/js/dhtmlxGrid/codebase/dhtmlxcommon.js"></script>
		<script src="<%=request.getContextPath()%>/js/dhtmlxGrid/codebase/dhtmlxgrid.js"></script>
		<script src="<%=request.getContextPath()%>/js/dhtmlxGrid/codebase/dhtmlxgridcell.js"></script>
		<script src="<%=request.getContextPath()%>/js/dhtmlxGrid/codebase/customdhtmlxgrid_export.js"></script>	
		<script src="<%=request.getContextPath()%>/js/spin.js"></script>
		<script src="<%=request.getContextPath()%>/js/ajax-loader.js"></script>		
		<script>
			mepId = "<%=request.getAttribute("mepId")%>";  
			contextPath = "<%=request.getContextPath()%>";   
			i18nerrorInvalidSearchInput="<s:text name='webportal.error.invalidsearchinput'/>";     
			i18nerrorNoDataForSearch="<s:text name='webportal.error.nosearchresults'/>";  
			mapServerUrl= "<%=application.getAttribute("MAP_SERVER_URL")%>";  
			isAjaxSearch = false;
			function initMeterValueGrid(){            	
				meterValueGrid = new dhtmlXGridObject('meterValuesGridDiv');		
				meterValueGrid.setImagePath("<%=request.getContextPath()%>/js/dhtmlxGrid/codebase/imgs/");		   
				meterValueGrid.setHeader("<s:text name='webportal.measurepoint.metervalue.register'/>,<s:text name='webportal.measurepoint.metervalue.tariff'/>,<s:text name='webportal.measurepoint.metervalue.readtimestamp'/>,<s:text name='webportal.measurepoint.metervalue.receivetimestamp'/>,<s:text name='webportal.measurepoint.metervalue.consumption'/>,<s:text name='webportal.measurepoint.metervalue.status'/>");				
				meterValueGrid.setInitWidths("*,*,*,*,*,*"); 
				meterValueGrid.setColAlign("center,center,center,center,center,center"); 
				meterValueGrid.setSkin("xp"); 
				meterValueGrid.init();
			}			
		</script>

	</head>
	<body onload="javascript:measurepointDetails()">
		
		<div id="wrapper">

			<%@ include file="headerv311.inc"%>
			
			<div id="main-content">
				<div class="big-row">
					<div class="large-12 columns">
						<h2 class="page-name-heading">
							<s:text name="webportal.measurepoint.measurepointid"/>&#32: <span id="measurepoint-id" class=" text-light-grey"></span>
						</h2>
					</div>
				</div>
				<div class="big-row">
					<div class="large-4 columns">
						<div class="panel-outer">
							<h4 class="panel-heading">
								<i class="fi-graph-trend colorHeading"></i>
								<span class="block-title-name text-blue"><s:text name="webportal.common.overview"/></span>
							</h4>
							<div class="panel-inner">
								<table id="overview-table">
									<tr>	
										<td><div class="legend-block-title"><s:text name="webportal.measurepoint.installationid"/>&#32:</div></td>
										<td> <div class="legend-block-content text-light-grey" id="block-overview-installation-id"></div></td>									
									</tr>
									<tr>	
										<td><div class="legend-block-title"><s:text name="webportal.measurepoint.installationcode"/>&#32:</div></td>
										<td><div class="legend-block-content text-light-grey" id="block-overview-installation-code"></div></td>
									</tr>
									<tr>
										<td><div class="legend-block-title"><s:text name="webportal.measurepoint.externalcode"/>&#32:</div></td>
										<td><div class="legend-block-content text-light-grey" id="block-overview-external-code"></div></td>
									</tr>
									<tr>
										<td><div class="legend-block-title"><s:text name="webportal.measurepoint.utility"/>&#32:</div></td>
										<td>
											<table class="text-light-grey" align="left">
												<tr>
													<td width="30" ><span id="iconUtility"></span></td>
													<td valign="middle"><span id="block-overview-utility"></span></td>
												</tr>
											</table>
										</td>									
									</tr>
									<tr>	
										<td><div class="legend-block-title"><s:text name="webportal.measurepoint.domain"/>&#32:</div></td>
										<td><div class="legend-block-content text-light-grey" id="block-overview-domain"></div></td>
									</tr>
									<tr>	
										<td><div class="legend-block-title"><s:text name="webportal.measurepoint.meterplacement"/>&#32:</div></td>
										<td><div class="legend-block-content text-light-grey" id="block-overview-meter-placement"></div></td>
									</tr>
									<tr>	
										<td><div class="legend-block-title"><s:text name="webportal.measurepoint.measurepointcode"/>&#32:</div></td>
										<td><div class="legend-block-content text-light-grey" id="block-overview-measurepoint-code"></div></td>
									</tr>
									<tr>	
										<td><div class="legend-block-title"><s:text name="webportal.measurepoint.gsrn"/>&#32:</div></td>
										<td><div class="legend-block-content text-light-grey" id="block-overview-gsrn"></div></td>
									</tr>
									<tr>	
										<td><div class="legend-block-title"><s:text name="webportal.measurepoint.powerstatus"/>&#32:</div></td>
										<td><div class="legend-block-content text-light-grey" id="block-overview-power-status"></div></td>
									</tr>
								</table>
								<div class="status text-green" id="block-overview-status"></div>
							</div>
						</div>
					</div>
					<div class="large-4 columns">
						<div class="panel-outer">
							<h4 class="panel-heading">
								<i class="fi-graph-trend colorHeading"></i>
								<span class="block-title-name text-blue"><s:text name="webportal.common.location"/></span>
							</h4>
							<div class="panel-inner">
								<div id="block-location-map-wrapper" style="width:444px; height:264px">								
								</div>
								<div class="legend">
									<div class="address legend-block text-grey">
										<div class="legend-block-title"><s:text name="webportal.measurepoint.address"/>&#32:</div>
										<div class="legend-block-content text-light-grey" id="block-location-adress"></div>
									</div>
									<div class="area legend-block text-grey">
										<div class="legend-block-title"><s:text name="webportal.measurepoint.area"/>&#32:</div>
										<div class="legend-block-content text-light-grey" id="block-location-area"></div>									
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="large-4 columns">
						<div class="panel-outer">
							<h4 class="panel-heading">
								<i class="fi-graph-trend colorHeading"></i>
								<span class="block-title-name text-blue"><s:text name="webportal.measurepoint.consumption"/></span>
							</h4>
							<div class="panel-inner">
								<div id="block-consumption-chart-wrapper">								
								</div>
								<div class="center-wrapper">
									<a href="<%=request.getContextPath()%>/std/ViewMeasurepointConsumptionReportAction?id=<%=request.getAttribute("mepId")%>">
										<span class="text-light-grey" ><s:text name="webportal.measurepoint.viewdetailedreports"/></span>
									</a>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="big-row">
					<div class="large-12 columns">
						<h2 class="page-name-heading">
							<span class="block-title-name text-blue"><s:text name="webportal.measurepoint.measurepointinformation"/></span>
						</h2>
					</div>
				</div>
				<div class="big-row">
					<div class="large-4 columns">
						<div class="panel-outer">
							<h4 class="panel-heading">
								<i class="fi-graph-trend colorHeading"></i>
								<span class="accordion-title-name"><s:text name="webportal.measurepoint.metervalues"/></span>
							</h4>
							<div class="panel-inner">
								<div id="meterValuesGridDiv"></div>
								<table id="metervaluesresults" class="text-grey big-table">
									<thead>
										<tr class="table-title">
											<th class="col1"> &nbsp;&nbsp;&nbsp; <s:text name="webportal.measurepoint.metervalue.register"/></th>
											<th class="col2"><s:text name="webportal.measurepoint.metervalue.tariff"/></th>
											<th class="col3"><s:text name="webportal.measurepoint.metervalue.readtimestamp"/></th>
											<th class="col4"><s:text name="webportal.measurepoint.metervalue.receivetimestamp"/></th>
											<th class="col5"><s:text name="webportal.measurepoint.metervalue.consumption"/></th>
												<!--<th class="col6"><s:text name="webportal.measurepoint.metervalue.reading"/></th>
											--><th class="col7"><s:text name="webportal.measurepoint.metervalue.status"/></th>
										</tr>
									</thead>	
									<tbody>											
									</tbody>											
								</table>

								<div class="center-wrapper">
									<a href="javascript:showmoremetervalue()" id="block-measurepoint-information-meter-value-link-more" class="link-more text-blue">
										<s:text name="webportal.measurepoint.case.showmoremetervalues"/></a>
										<a href="javascript:meterValueGrid.toExcel('<%=request.getContextPath()%>/std/DownloadExcel.action','Meter Values Data','color','HEADER')" id="meter-value-excel-export">Export to Excel</a>
									</div>
								</div>
							</div>
						</div>
						<div class="large-4 columns">
							<div class="panel-outer">
								<h4 class="panel-heading">
									<i class="fi-graph-trend colorHeading"></i>
									<span class="accordion-title"> &#149; <span class="accordion-title-name">
									<s:text name="webportal.measurepoint.cases"/></span>
									<span id="block-measurepoint-information-cases-number" class="number"></span>
									<div class="accordion-arrow close"></div></span>
								</h4>
								<div class="panel-inner">
									<table id="caseresults" class="text-grey big-table">
										<thead>
											<tr class="table-title">
												<th class="col1"> &nbsp;&nbsp;&nbsp; <s:text name="webportal.measurepoint.case.id"/></th>
												<th class="col2"><s:text name="webportal.measurepoint.case.externalid"/></th>
												<th class="col3"><s:text name="webportal.measurepoint.case.casetype"/></th>
												<th class="col4"><s:text name="webportal.measurepoint.case.user"/></th>
												<th class="col4"><s:text name="webportal.measurepoint.case.domain"/></th>
												<th class="col4"><s:text name="webportal.measurepoint.case.lastchanged"/></th>
												<th class="col4"><s:text name="webportal.measurepoint.case.status"/></th>												
											</tr>
										</thead>	
										<tbody>											
										</tbody>												
									</table>
									<div class="center-wrapper">
										<a href="javascript:showmoremepcase()" id="block-measurepoint-information-cases-link-more"><s:text name="webportal.measurepoint.case.showmorecases"/></a>
									</div>
								</div>
							</div>
						</div>
						<div class="large-4 columns">
							<div class="panel-outer">
								<h4 class="panel-heading">
									<i class="fi-graph-trend colorHeading"></i>
									<span class="accordion-title">&#149; <span class="accordion-title-name"><s:text name="webportal.measurepoint.deviations"/></span>
									<span id="block-measurepoint-information-deviations-number" class="number"></span><div class="accordion-arrow close"></div></span>
								</h4>
								<div class="panel-inner">
									<table id="deviationresults" class="text-grey big-table">
										<thead>
											<tr class="table-title">
												<th class="col1"> &nbsp;&nbsp;&nbsp; <s:text name="webportal.measurepoint.deviations.id"/></th>
												<th class="col2"><s:text name="webportal.measurepoint.deviations.type"/></th>
												<th class="col3"><s:text name="webportal.measurepoint.deviations.source"/></th>
												<th class="col4"><s:text name="webportal.measurepoint.deviations.valid"/></th>
												<th class="col4"><s:text name="webportal.measurepoint.deviations.starttimestamp"/></th>
												<th class="col4"><s:text name="webportal.measurepoint.deviations.endtimestamp"/></th>
												<th class="col4"><s:text name="webportal.measurepoint.deviations.deviationgroup"/></th>
											</tr>	
										</thead>	
										<tbody>											
										</tbody>										
									</table>
									<div class="center-wrapper">
										<a href="javascript:showmoremepdeviation()" id="block-measurepoint-information-deviations-link-more" class="link-more text-blue"><s:text name="webportal.measurepoint.deviations.showmoredeviations"/></a>
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
									<span class="accordion-title">&#149; <span class="accordion-title-name"><s:text name="webportal.measurepoint.devices"/></span>
									<span id="block-measurepoint-information-devices-number" class="number"></span><div class="accordion-arrow close"></div></span>
								</h4>
								<div class="panel-inner">
									<table id="deviceresults" class="text-grey big-table">
										<thead>
											<tr class="table-title">
												<th class="col1"> &nbsp;&nbsp;&nbsp; <s:text name="webportal.measurepoint.deviations.id"/></th>
												<th class="col2"><s:text name="webportal.measurepoint.devices.giai"/></th>
												<th class="col3"><s:text name="webportal.measurepoint.devices.serialno"/>.</th>
												<th class="col4"><s:text name="webportal.measurepoint.devices.propno"/>.</th>
												<th class="col5"><s:text name="webportal.measurepoint.devices.type"/></th>
												<th class="col6"><s:text name="webportal.measurepoint.devices.model"/></th>
												<th class="col7"><s:text name="webportal.measurepoint.devices.starttimestamp"/></th>
												<th class="col8"><s:text name="webportal.measurepoint.devices.endtimestamp"/></th>
												<th class="col9"><s:text name="webportal.measurepoint.devices.status"/></th>
											</tr>
										</thead>	
										<tbody>											
										</tbody>											
									</table>
									<div class="center-wrapper">
										<a href="javascript:showmoremepdevice()" id="block-measurepoint-information-devices-link-more" class="link-more text-blue"><s:text name="webportal.measurepoint.devices.showmoredevices"/></a>
									</div>
								</div>
							</div>
						</div>
						<div class="large-6 columns">
							<div class="panel-outer">
								<h4 class="panel-heading">
									<i class="fi-graph-trend colorHeading"></i>
									<span class="accordion-title">&#149; <span class="accordion-title-name"><s:text name="webportal.measurepoint.events"/></span>
									<span id="block-measurepoint-information-events-number" class="number"></span></span>
								</h4>
								<div class="panel-inner">
									<table id="eventresults" class="text-grey big-table">
										<thead>
											<tr class="table-title">
												<th class="col1"> &nbsp;&nbsp;&nbsp; <s:text name="webportal.measurepoint.events.type"/></th>
												<th class="col2"><s:text name="webportal.measurepoint.events.deviceid"/></th>
												<th class="col3"><s:text name="webportal.measurepoint.events.phase"/></th>
												<th class="col4"><s:text name="webportal.measurepoint.events.starttimestamp"/></th>
												<th class="col5"><s:text name="webportal.measurepoint.events.endtimestamp"/></th>
												<th class="col6"><s:text name="webportal.measurepoint.events.receivetimestamp"/></th>
											</tr>
										</thead>	
										<tbody>											
										</tbody>											
									</table>
									<div class="center-wrapper">
										<a href="javascript:showmoremepevent()" id="block-measurepoint-information-events-link-more" class="link-more text-blue">
										<s:text name="webportal.measurepoint.events.showmoreevents"/></a>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<iframe id="myIFrm" name="myIFrm" src="" style="height: 0px; visibility: hidden"> </iframe>
		</body>
		</html>
