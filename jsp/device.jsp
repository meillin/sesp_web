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

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/styles/general.css" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/styles/header.css" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/styles/content-block.css" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/styles/footer.css" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/styles/content-device.css" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/styles/style.tidy.css" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/styles/colResizable.css" />

<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-migrate-1.1.1.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/colResizable-1.3.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.treeTable.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/init.js"></script>

<script type="text/javascript" src="<%=request.getContextPath()%>/js/common.js"></script>

<script type="text/javascript" src="<%=request.getContextPath()%>/js/sesp_ajax.js"></script>		
<script type="text/javascript" src="<%=request.getContextPath()%>/js/search-results.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/device.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/OpenLayers.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/map.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/spin.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/ajax-loader.js"></script>


</head>
<body>
	<script>
		contextPath = "<%=request.getContextPath()%>";   
		deviceId="<%=request.getAttribute("id")%>";  
		mapServerUrl= "<%=application.getAttribute("MAP_SERVER_URL")%>";    
		overviewPalletTitle = "<s:text name='webportal.device.overview.device.pallet'/>";
		overviewStockTitle = "<s:text name='webportal.device.overview.device.stock'/>";
		overviewMeasurepointTitle = "<s:text name='webportal.device.overview.device.mep.id'/>";
		overviewMultipointTitle = "<s:text name='webportal.device.overview.device.mup.id'/>";
		i18nerrorNoDeviceData = "<s:text name='webportal.device.results.error.noresults'/>";        
	</script>

	<div id="wrapper">

		<!--  Header -->
		<%@ include file="headerv311.inc"%>			

		<div id="main-content">
			<div class="big-row">
				<div class="large-12 columns">
					<h2 class="page-name-heading">
						<s:text name='webportal.device.results.title'/> : <span id="device-id"></span>
					</h2>
				</div>
			</div>
			<div class="big-row">
				<div class="large-6 columns">
					<div class="panel-outer">
						<h4 class="panel-heading">
							<i class="fi-graph-trend colorHeading"></i>
							<span> <s:text name='webportal.device.overview.device.title'/> </span>
						</h4>
						<div class="panel-inner">
							<ul id="overview-table">
								<li><span><s:text name='webportal.device.overview.device.type'/>: </span><span id="block-overview-device-type"></span></li>
								<li> <span><s:text name='webportal.device.overview.device.model'/>: </span><span id="block-overview-device-model"></span></li>
								<li><span id="block-measurepoint-multipoint-title"></span> <span id="block-overview-measurepoint-id"></span></li>
								<li><span><s:text name='webportal.device.overview.device.giai'/>: </span><span id="block-overview-giai"></span></li>
								<li><span><s:text name='webportal.device.overview.device.serial.number'/>: </span><span id="block-overview-serial-number"></span></li>
								<li><span> <s:text name='webportal.device.overview.device.property.number'/>: </span><span id="block-overview-property-number"></span></li>
								<li><span> <s:text name='webportal.device.overview.device.domain'/>: </span><span id="block-overview-domain"></span></li>
								<li><span> <s:text name='webportal.device.overview.device.pallet'/>: </span><span id="block-overview-pallet"></span></li>
								<li><span> <s:text name='webportal.device.overview.device.stock'/>: </span><span id="block-overview-stock-site"></span></li>	
							</ul>
							<div class="status text-green" id="block-overview-status"></div>
						</div>
					</div>
				</div>
				<div class="large-6 columns">
					<div class="panel-outer">
						<h4 class="panel-heading">
							<i class="fi-graph-trend colorHeading"></i>
							<span><s:text name='webportal.device.location.title'/></span>
						</h4>
						<div class="panel-inner">
						<div id="block-device-location-map-wrapper" style="width:444px; height:300px">
								<!-- <iframe width="444" height="204" frameborder="0" scrolling="no" marginheight="0" marginwidth="0" src="http://www.openstreetmap.org/export/embed.html?bbox=-1.55302,47.19581,-1.50817,47.22307&amp;layer=mapnik&amp;marker=47.21659,-1.53457"></iframe> -->
							</div>
							<div class="legend">
								<div class="address legend-block text-grey">
									<span><strong><s:text name='webportal.device.location.address'/> :</strong></span>
									<span id="block-device-location-adress"></span>
								</div>
								<div class="area legend-block text-grey">
									<span><strong><s:text name='webportal.device.location.area'/> :</strong></span>
									<span id="block-device-location-area"></span>									
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
							<span class="block-title-name text-blue">
								<s:text name='webportal.device.hardwareconfig.title'/></span>
							</h4>
							<div class="panel-inner">
								<table id="hardware-configuration-table">
									<thead>	
										<tr>
											<th><s:text name='webportal.device.hardwareconfig.type'/></th>
											<th><s:text name='webportal.device.hardwareconfig.id'/></th>
											<th><s:text name='webportal.device.hardwareconfig.code'/></th>
											<th><s:text name='webportal.device.hardwareconfig.info'/></th>
										</tr>
									</thead>
									<tbody>
									</tbody>
								</table>
							</div>
						</div>
					</div>
				</div>
				<div class="big-row">
					<div class="large-12 columns">
						<div class="panel-outer">
							<h4 class="panel-heading">
								<i class="fi-graph-trend colorHeading"></i>
								<s:text name='webportal.device.history.title'/>
							</h4>
							<div class="panel-inner">
								<p class="status-color">
									<s:text name='webportal.device.history.installation.title'/> 
									<span id="block-device-installations-number"> </span> 
								</p>
								<table id="device-installation-table">
									<thead>	
										<tr class="table-title">
											<th><s:text name='webportal.device.history.installation.id'/></th>
											<th><s:text name='webportal.device.history.installation.code'/></th>
											<th><s:text name='webportal.device.history.installation.mepid'/></th>
											<th><s:text name='webportal.device.history.installation.mepcode'/></th>
										</tr>
									</thead>
									<tbody>
									</tbody>
								</table>
								<div class="center-wrapper">
									<a href="javascript:showMoreDeviceResults('INST')" id="block-device-installation-link-more">
										<s:text name='webportal.device.history.installation.options.showmore'/>
									</a>
								</div>
							</div>
							<div class="panel-inner">
								<p class="status-color">
									<s:text name='webportal.device.history.status.title'/>
									<span id="block-device-status-number"></span>
								</p>
								<table id="device-status-table">
									<thead>	
										<tr>
											<th><s:text name='webportal.device.history.status.type'/></th>
											<th><s:text name='webportal.device.history.status.start.timestamp'/></th>
											<th><s:text name='webportal.device.history.status.end.timestamp'/></th>
											<th><s:text name='webportal.device.history.status.reason'/></th>
										</tr>
									</thead>
									<tbody>
									</tbody>
								</table>
								<div class="center-wrapper">
									<a href="javascript:showMoreDeviceResults('STATUS')" id="block-device-status-link-more">
										<s:text name='webportal.device.history.status.options.showmore'/>
									</a>
								</div>
							</div>
							<div class="panel-inner">
								<p class="status-color">
									<s:text name='webportal.device.history.pallet.title'/>
									<span id="block-device-pallet-number"></span>
								</p>
								<table id="device-pallet-table">
									<thead>
										<tr>
											<th><s:text name='webportal.device.history.pallet.code'/></th>
											<th><s:text name='webportal.device.history.pallet.type'/></th>
											<th><s:text name='webportal.device.history.pallet.status'/></th>
											<th><s:text name='webportal.device.history.pallet.sending'/></th>
											<th><s:text name='webportal.device.history.pallet.destination'/></th>
											<th><s:text name='webportal.device.history.pallet.receiving'/></th>
											<th><s:text name='webportal.device.history.pallet.start.timestamp'/></th>
											<th><s:text name='webportal.device.history.pallet.end.timestamp'/></th>
										</tr>
									</thead>
									<tbody>
									</tbody>
								</table>
								<div class="center-wrapper">
									<a href="javascript:showMoreDeviceResults('PALLET')" id="block-device-pallet-link-more" class="link-more text-blue">
										<s:text name='webportal.device.history.pallet.options.showmore'/>
									</a>
								</div>
							</div>
							<div class="panel-inner">
								<p class="status-color">
									<s:text name='webportal.device.history.stocksite.title'/>
									<span id="block-device-stock-site-number"></span>
								</p>
								<table id="device-stock-site-table">
									<thead>
										<tr class="table-title">
											<th><s:text name='webportal.device.history.stocksite.stock.id'/></th>
											<th><s:text name='webportal.device.history.stocksite.stock.name'/></th>
											<th><s:text name='webportal.device.history.stocksite.start.timestamp'/></th>
											<th><s:text name='webportal.device.history.stocksite.end.timestamp'/></th>
										</tr>
									</thead>
									<tbody>
									</tbody>
								</table>
								<div class="center-wrapper">
									<a href="javascript:showMoreDeviceResults('STOCK_SITE')" id="block-device-stock-site-link-more" class="link-more text-blue">
										<s:text name='webportal.device.history.stocksite.options.showmore'/>
									</a>
								</div>
							</div>
							<div class="panel-inner">
								<p class="status-color">
									<s:text name='webportal.device.history.owner.title'/>
									<span id="block-device-owner-number"></span>
								</p>
								<table id="device-owner-table"  class="text-grey history-table">
									<thead>	
										<tr class="table-title">
											<th class="col1"><s:text name='webportal.device.history.owner.name'/></th>
											<th class="col2"><s:text name='webportal.device.history.owner.start.timestamp'/></th>
											<th class="col3"><s:text name='webportal.device.history.owner.end.timestamp'/></th>
										</tr>
									</thead>
									<tbody>
									</tbody>
								</table>
								<div class="center-wrapper">
									<a href="javascript:showMoreDeviceResults('OWNER')" id="block-device-owner-link-more" class="link-more text-blue">
										<s:text name='webportal.device.history.owner.options.showmore'/>
									</a>
								</div>
							</div>
						</div>
					</div>
				</div>
			</body>
			</html>
