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
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/styles/content-installation.css" />
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/styles/style.tidy.css" />

		<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-1.9.1.min.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-migrate-1.1.1.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/sesp_ajax.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/init.js"></script>

		<script type="text/javascript" src="<%=request.getContextPath()%>/js/vendor/jquery.nicescroll.js"></script>

		<script type="text/javascript" src="<%=request.getContextPath()%>/js/common.js"></script>

		<script type="text/javascript" src="<%=request.getContextPath()%>/js/colResizable-1.3.min.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/installation.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/search-results.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/OpenLayers.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/map.js"></script>

		<script src="<%=request.getContextPath()%>/js/spin.js"></script>
		<script src="<%=request.getContextPath()%>/js/ajax-loader.js"></script>
		<script type="text/javascript">
			$(function(){
				renderTable("#overview-table");
				renderTable("#block-cases-table");
				renderTable("#block-multipoint-measurepoints-table");
			});
		</script>

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
		id="<%=request.getAttribute("id")%>";
		mapServerUrl= "<%=application.getAttribute("MAP_SERVER_URL")%>";
		isAjaxSearch = false;
	</script>
	<div id="wrapper">
		<%@ include file="headerv311.inc"%>
		<div id="main-content">
			<div class="big-row">
				<div class="large-12 columns">
					<h3 class="page-name-heading-search">
						<s:text name="webportal.installation.installationid"/>: <span id="installation-id" class=" text-light-grey">458785</span>
					</h3>
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
							<ul id="overview-table">
								<li><span><s:text name="webportal.installation.installationcode"/></span><span id="block-overview-installation-code"></span></li>
								<li> <span><s:text name="webportal.installation.externalcode"/></span><span id="block-overview-external-code"></span></li>
								<li><span><s:text name="webportal.installation.type"/></span><span id="block-overview-type"></span></li>
								<li><span><s:text name="webportal.installation.domain"/></span><span id="block-overview-domain"></span></li>
								<li><span><s:text name="webportal.installation.keynumber"/></span><span id="block-overview-key-number"></span></li>
								<li><span><s:text name="webportal.installation.keyinfo"/></span><span id="block-overview-key-info"></span></li>
								<li><span><s:text name="webportal.installation.accessibletotech"/></span><span id="block-overview-accessible-tech"></span></li>
							</ul>
							<span>Status:</span><h3 class="status text-green" id="block-overview-status"></h3>
						</div>
					</div>
				</div>
				<div class="large-6 columns">
					<div class="panel-outer">
						<h4 class="panel-heading">
							<i class="fi-graph-trend colorHeading"></i>
							<span class="block-title-name text-blue"><s:text name="webportal.common.location"/></span>
						</h4>
						<div class="panel-inner">
							<div id="osmap" style="height:300px">
								<!-- <iframe width="444" height="195" frameborder="0" scrolling="no" marginheight="0" marginwidth="0" src="http://www.openstreetmap.org/export/embed.html?bbox=-1.55302,47.19581,-1.50817,47.22307&amp;layer=mapnik&amp;marker=47.21659,-1.53457"></iframe>  -->
							</div>
							<div>
								<strong><s:text name="webportal.installation.address"/>:</strong>
								<span id="block-location-address"></span>
							</div>
							<div>
								<strong><s:text name="webportal.installation.area"/>:</strong>
								<span id="block-location-area"></span>
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
							<span><s:text name='webportal.device.overview.device.title'/></span>
							<span id="block-cases-number-value"></span>
						</h4>
						<div class="panel-inner">
							<table class="big-table cases" id="block-cases-table">
								<thead>
									<tr class="table-title">
										<th><s:text name="webportal.installation.cases.id"/></th>
										<th><s:text name="webportal.installation.cases.externalid"/></th>
										<th><s:text name="webportal.installation.cases.casetype"/></th>
										<th><s:text name="webportal.installation.cases.user"/></th>
										<th><s:text name="webportal.installation.cases.domain"/></th>
										<th><s:text name="webportal.installation.cases.lastchanged"/></th>
										<th><s:text name="webportal.installation.cases.status"/></th>
									</tr>
								</thead>
								<tbody>
								</tbody>
							</table>
							<div class="center-wrapper">
								<a href="javascript:showMoreInstCases();" id="block-cases-link-more" class="text-blue"><s:text name="webportal.installation.cases.showmore"/></a>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="big-row">
				<div class="large-12 columns">
					<div class="panel-outer"><h4 class="panel-heading"><i class="fi-graph-trend colorHeading"></i>
						<span class="block-title-name text-blue"><s:text name="webportal.installation.multimeasurepoint.multipointandmeasurepoints"/></span>
						<span id="block-multipoint-measurepoints-number-value"></span>
					</h4>
					<div class="panel-inner">
						<table class="big-table cases" id="block-multipoint-measurepoints-table">
							<thead>
								<tr class="table-title">
									<th><s:text name="webportal.installation.multimeasurepoint.id"/></th>
									<th><s:text name="webportal.installation.multimeasurepoint.code"/></th>
									<th><s:text name="webportal.installation.multimeasurepoint.type"/></th>
									<th><s:text name="webportal.installation.multimeasurepoint.utility"/></th>
									<th><s:text name="webportal.installation.multimeasurepoint.status"/></th>
								</tr>
							</thead>
							<tbody>
							</tbody>
						</table>
						<div class="center-wrapper">
							<a href="javascript:showMoreInstMultiMeasurePoints();" id="block-multipoint-measurepoints-link-more" class="text-blue"><s:text name="webportal.installation.multimeasurepoint.showmore"/></a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<script>
	initInstallation();
</script>

	<!--[if lt IE 9]>
	<script type="text/javascript" src="https://raw.githubusercontent.com/chuckcarpenter/REM-unit-polyfill/master/js/rem.min.js"></script>
	<![endif]-->
</body>
</html>
