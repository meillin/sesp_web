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
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/styles/content-multipoint.css" />
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/styles/style.tidy.css" />
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/styles/colResizable.css" />
		
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-1.9.1.min.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-migrate-1.1.1.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/colResizable-1.3.min.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/init.js"></script>	

		<script type="text/javascript" src="<%=request.getContextPath()%>/js/common.js"></script>	

		<script type="text/javascript" src="<%=request.getContextPath()%>/js/sesp_ajax.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/search-results.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/multipoint.js"></script>	
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/OpenLayers.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/map.js"></script>	
		<script src="<%=request.getContextPath()%>/js/spin.js"></script>
		<script src="<%=request.getContextPath()%>/js/ajax-loader.js"></script>
		<script>
			multipointId = "<%=request.getAttribute("multipointId")%>";  
			contextPath = "<%=request.getContextPath()%>";   
			i18nerrorInvalidSearchInput="<s:text name='webportal.error.invalidsearchinput'/>";     
			i18nerrorNoDataForSearch="<s:text name='webportal.error.nosearchresults'/>";  
			mapServerUrl= "<%=application.getAttribute("MAP_SERVER_URL")%>";  
			isAjaxSearch = false;   	
		</script>
	</head>
	<body onload="javascript:multipointDetails()">
		<div id="wrapper">
			<%@ include file="headerv311.inc"%>
			<div id="main-content">
				<div class="big-row">
					<div class="large-12 columns">
						<h2 style="margin-top: 50px;">
							<s:text name="webportal.multipoint.multipointid"/> : <span id="multipoint-id"></span>
						</h2>
					</div>
				</div>
				<div class="big-row">
					<div class="large-6 columns">
						<div class="panel-outer">
							<h4 class="panel-heading">
								<i class="fi-graph-trend colorHeading"></i>
								<span class="block-title-name text-blue"><s:text name="webportal.common.overview"/></span>
							</h4>
							<div class="panel-inner">
								<table id="overview-table">
									<tr>	
										<td><div class="legend-block-title"><s:text name="webportal.multipoint.installationid"/>&#32:</div> </td>
										<td><div class="legend-block-content text-light-grey" id="block-overview-installation-id">  </div></td>	
									</tr>
									<tr>	
										<td><div class="legend-block-title"><s:text name="webportal.multipoint.installationcode"/>&#32:</div></td>
										<td><div class="legend-block-content text-light-grey" id="block-overview-installation-code"></div></td>							
									</tr>							
									<tr>	
										<td><div class="legend-block-title"><s:text name="webportal.multipoint.externalcode"/>&#32:</div></td>
										<td><div class="legend-block-content text-light-grey" id="block-overview-external-code"></div></td>
									</tr>
									<tr>
										<td><div class="legend-block-title"><s:text name="webportal.multipoint.domain"/>&#32:</div></td>
										<td><div class="legend-block-content text-light-grey" id="block-overview-domain"></div></td>
									</tr>
									<tr>
										<td><div class="legend-block-title"><s:text name="webportal.multipoint.multipointcode"/>&#32:</div></td>
										<td><div class="legend-block-content text-light-grey" id="block-overview-multipoint-code"></div></td>
									</tr>
									<tr>
										<td><div class="legend-block-title"><s:text name="webportal.multipoint.deviceplacement"/>&#32:</div></td>
										<td><div class="legend-block-content text-light-grey" id="block-overview-device-placement"></div></td>
									</tr>	
								</table>
								<div class="status text-green" id="block-overview-status"></div>
							</div>
						</div>
					</div>
					<div class="large-6 columns">
						<div class="panel-outer">
							<h4 class="panel-heading">
								<i class="fi-graph-trend colorHeading"></i>
								<s:text name="webportal.common.location"/>
							</h4>
							<div class="panel-inner">
								<div id="block-location-map-wrapper" style="height:300px">								
								</div>
								<div class="legend">
									<div class="address legend-block text-grey">
										<div class="legend-block-title"><s:text name="webportal.multipoint.address"/> : </div>
										<div class="legend-block-content text-light-grey" id="block-location-adress"></div>
									</div>
									<div class="area legend-block text-grey">
										<div class="legend-block-title"><s:text name="webportal.multipoint.area"/> : </div>
										<div class="legend-block-content text-light-grey" id="block-location-area"></div>									
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="big-row">
					<div class="large-12 columns">
						<h2>
							<s:text name="webportal.multipoint.information"/>
						</h2>
					</div>
				</div>
				<div class="big-row">
					<div class="large-6 columns">
						<div class="panel-outer">
							<h4 class="panel-heading">
								<i class="fi-graph-trend colorHeading"></i>
								<span class="accordion-title"> <s:text name="webportal.multipoint.cases"/>
									<span id="block-multipoint-information-cases-number" class="number"></span>
								</span>
							</h4>
							<div class="panel-inner">
								<table id="caseresults">
									<thead>
										<tr class="table-title">
											<th><s:text name="webportal.multipoint.case.id"/></th>
											<th><s:text name="webportal.multipoint.case.externalid"/></th>
											<th><s:text name="webportal.multipoint.case.casetype"/></th>
											<th><s:text name="webportal.multipoint.case.user"/></th>
											<th><s:text name="webportal.multipoint.domain"/></th>
											<th><s:text name="webportal.multipoint.case.lastchanged"/></th>
											<th><s:text name="webportal.multipoint.case.status"/></th>
										</tr>
									</thead>	
									<tbody>											
									</tbody>										
								</table>
								<div class="center-wrapper">
									<a href="javascript:showmorecase();" id="block-multipoint-information-cases-link-more">
										<s:text name="webportal.multipoint.case.showmorecases"/>
									</a>										
								</div>
							</div>
						</div>
					</div>
					<div class="large-6 columns">
						<div class="panel-outer">
							<h4 class="panel-heading">
								<i class="fi-graph-trend colorHeading"></i>
								<span class="accordion-title"><s:text name="webportal.multipoint.deviations"/>
									<span id="block-multipoint-information-deviations-number" class="number"></span>
								</span>
							</h4>
							<div class="panel-inner">
								<table id="deviationresults">
									<thead>
										<tr class="table-title">
											<th><s:text name="webportal.multipoint.deviations.id"/></th>
											<th><s:text name="webportal.multipoint.deviations.type"/></th>
											<th><s:text name="webportal.multipoint.deviations.source"/></th>
											<th><s:text name="webportal.multipoint.deviations.valid"/></th>
											<th><s:text name="webportal.multipoint.deviations.starttimestamp"/></th>
											<th><s:text name="webportal.multipoint.deviations.endtimestamp"/></th>
											<th><s:text name="webportal.multipoint.deviations.deviationgroup"/></th>
										</tr>
									</thead>	
									<tbody>											
									</tbody>
								</table>
								<div class="center-wrapper">
									<a href="javascript:showmoredeviation()" id="block-multipoint-information-deviations-link-more" class="link-more text-blue">
										<s:text name="webportal.multipoint.deviations.showmoredeviations"/></a>
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
									<span class="accordion-title"> 
										<s:text name="webportal.multipoint.cases"/>
										<span id="block-multipoint-information-cases-number"></span>
									</span>
								</h4>
								<div class="panel-inner">
									<table id="deviceresults" class="text-grey big-table">
										<thead>
											<tr class="table-title">
												<th><s:text name="webportal.multipoint.devices.deviceid"/></th>
												<th><s:text name="webportal.multipoint.devices.giai"/></th>
												<th><s:text name="webportal.multipoint.devices.serialno"/>.</th>
												<th><s:text name="webportal.multipoint.devices.propno"/>.</th>
												<th><s:text name="webportal.multipoint.devices.type"/></th>
												<th><s:text name="webportal.multipoint.devices.model"/></th>
												<th><s:text name="webportal.multipoint.devices.starttimestamp"/></th>
												<th><s:text name="webportal.multipoint.devices.endtimestamp"/></th>
												<th><s:text name="webportal.multipoint.devices.status"/></th>
											</tr>
										</thead>	
										<tbody>											
										</tbody>
									</table>
									<div class="center-wrapper">
										<a href="javascript:showmoredevice()" id="block-multipoint-information-devices-link-more">
											<s:text name="webportal.multipoint.devices.showmoredevices"/>
										</a>
									</div>
								</div>
							</div>
						</div>
						<div class="large-6 columns">
							<div class="panel-outer">
								<h4 class="panel-heading">
									<i class="fi-graph-trend colorHeading"></i>
									<span class="accordion-title"> 
										<s:text name="webportal.multipoint.events"/>
										<span id="block-multipoint-information-events-number"></span>
									</span>
								</h4>
								<div class="panel-inner">
									<table id="eventresults">
										<thead>
											<tr class="table-title">
												<th><s:text name="webportal.multipoint.events.type"/></th>
												<th><s:text name="webportal.multipoint.events.deviceid"/></th>
												<th><s:text name="webportal.multipoint.events.phase"/></th>
												<th><s:text name="webportal.multipoint.events.starttimestamp"/></th>
												<th><s:text name="webportal.multipoint.events.endtimestamp"/></th>
												<th><s:text name="webportal.multipoint.events.receivetimestamp"/></th>
											</tr>
										</thead>	
										<tbody>											
										</tbody>											
									</table>
									<div class="center-wrapper">
										<a href="javascript:showmoreevent()" id="block-multipoint-information-events-link-more">
										<s:text name="webportal.multipoint.events.showmoreevents"/>
										</a>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</body>
		</html>
