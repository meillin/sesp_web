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
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/styles/content-device.css" />
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/styles/style.tidy.css" />

	<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-1.9.1.min.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-migrate-1.1.1.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.treeTable.js"></script>

	<script type="text/javascript" src="<%=request.getContextPath()%>/js/vendor/jquery.nicescroll.js"></script>

	<script type="text/javascript" src="<%=request.getContextPath()%>/js/common.js"></script>

	<script type="text/javascript" src="<%=request.getContextPath()%>/js/sesp_ajax.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/search-results.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/device.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/OpenLayers.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/map.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/spin.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/ajax-loader.js"></script>


	<!--[if lt IE 9]>
	<script src="//cdnjs.cloudflare.com/ajax/libs/html5shiv/3.6.2/html5shiv.js"></script>
	<script src="//s3.amazonaws.com/nwapi/nwmatcher/nwmatcher-1.2.5-min.js"></script>
	<script src="//html5base.googlecode.com/svn-history/r38/trunk/js/selectivizr-1.0.3b.js"></script>
	<script src="//cdnjs.cloudflare.com/ajax/libs/respond.js/1.1.0/respond.min.js"></script>
	<![endif]-->
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
					<h3 class="page-name-heading-search">
						<s:text name='webportal.device.results.title'/> : <span id="device-id"></span>
					</h3>
				</div>
			</div>
			<div class="big-row">
				<div class="large-6 columns">
					<div class="panel-outer">
						<h4 class="panel-heading">
							<i class="fi-eye colorHeading"></i>
							<span> <s:text name='webportal.device.overview.device.title'/> </span>
						</h4>
						<div class="panel-inner">
							<ul id="overview-table">
								<li><span><s:text name='webportal.device.overview.device.type'/></span><span id="block-overview-device-type"></span></li>
								<li> <span><s:text name='webportal.device.overview.device.model'/></span><span id="block-overview-device-model"></span></li>
								<li><span id="block-measurepoint-multipoint-title"></span> <span id="block-overview-measurepoint-id"></span></li>
								<li><span><s:text name='webportal.device.overview.device.giai'/></span><span id="block-overview-giai"></span></li>
								<li><span><s:text name='webportal.device.overview.device.serial.number'/></span><span id="block-overview-serial-number"></span></li>
								<li><span><s:text name='webportal.device.overview.device.property.number'/></span><span id="block-overview-property-number"></span></li>
								<li><span><s:text name='webportal.device.overview.device.domain'/></span><span id="block-overview-domain"></span></li>
								<li><span><s:text name='webportal.device.overview.device.pallet'/></span><span id="block-overview-pallet"></span></li>
								<li><span><s:text name='webportal.device.overview.device.stock'/></span><span id="block-overview-stock-site"></span></li>
							</ul>
							<span>Status:</span><h3 class="status text-green" id="block-overview-status"></h3>
						</div>
					</div>
				</div>
				<div class="large-6 columns">
					<div class="panel-outer">
						<h4 class="panel-heading">
							<i class="fi-marker colorHeading"></i>
							<span><s:text name='webportal.device.location.title'/></span>
						</h4>
						<div class="panel-inner">
							<div id="block-device-location-map-wrapper" style="width:400px; height:278px"></div>
							<div class="legend">
								<br/>
								<div class="address legend-block">
									<span><strong><s:text name='webportal.device.location.address'/> :</strong></span>
									<span id="block-device-location-adress"></span>
								</div>
								<div class="area legend-block">
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
							<i class="fi-list colorHeading"></i>
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
						<h3 class="page-name-heading-nomargin">
							<s:text name='webportal.device.history.title'/>
						</h3>
					</div>
				</div>
				<div class="big-row">
					<div class="large-12 columns">
						<div class="panel-outer">
							<h4 class="panel-heading">
								<i class="fi-list colorHeading"> </i>
								<span><s:text name='webportal.device.history.installation.title'/></span>
								<span id="block-device-installations-number"> </span>
							</h4>
							<div class="panel-inner">
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
						</div>
						<div class="panel-outer">
							<h4 class="panel-heading">
								<i class="fi-list colorHeading"> </i>
								<span><s:text name='webportal.device.history.status.title'/></span>
								<span id="block-device-status-number"></span>
							</h4>
							<div class="panel-inner">
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
						</div>
						<div class="panel-outer">
							<h4 class="panel-heading">
								<i class="fi-list colorHeading"> </i>
								<span><s:text name='webportal.device.history.pallet.title'/></span>
								<span id="block-device-pallet-number"> </span>
							</h4>
							<div class="panel-inner">
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
									<a href="javascript:showMoreDeviceResults('PALLET')" id="block-device-pallet-link-more">
										<s:text name='webportal.device.history.pallet.options.showmore'/>
									</a>
								</div>
							</div>
						</div>

						<div class="panel-outer">
							<h4 class="panel-heading">
								<i class="fi-list colorHeading"></i>
								<span><s:text name='webportal.device.history.stocksite.title'/></span>
								<span id="block-device-stock-site-number"></span>
							</h4>

							<div class="panel-inner">
								<table id="device-stock-site-table">
									<thead>
										<tr>
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
						</div>
						<div class="panel-outer">
							<h4 class="panel-heading">
								<i class="fi-list colorHeading"> </i>
								<span><s:text name='webportal.device.history.owner.title'/></span>
								<span id="block-device-owner-number"></span>
							</h4>
							<div class="panel-inner">
								<table id="device-owner-table">
									<thead>
										<tr>
											<th><s:text name='webportal.device.history.owner.name'/></th>
											<th><s:text name='webportal.device.history.owner.start.timestamp'/></th>
											<th><s:text name='webportal.device.history.owner.end.timestamp'/></th>
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
			</div>

	<!--[if lt IE 9]>
	<script type="text/javascript" src="https://raw.githubusercontent.com/chuckcarpenter/REM-unit-polyfill/master/js/rem.min.js"></script>
	<![endif]-->
	</body>
</html>
