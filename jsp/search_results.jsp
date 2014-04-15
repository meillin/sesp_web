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

		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/styles/content-search-results.css" />
		<!--<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/styles/colResizable.css" />-->
		
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-1.9.1.min.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-migrate-1.1.1.js"></script>
		<!--<script type="text/javascript" src="<%=request.getContextPath()%>/js/colResizable-1.3.min.js"></script>-->
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/init.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/common.js"></script>

		<script type="text/javascript" src="<%=request.getContextPath()%>/js/sesp_ajax.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/search-results.js"></script>		
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/spin.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/ajax-loader.js"></script>
		
	</head>
	<body onload="searchentities()">	
		<script>
			contextPath = "<%=request.getContextPath()%>";   
			i18nerrorInvalidSearchInput = "<s:text name='webportal.search.results.error.invalidsearchinput'/>"; 
			i18nerrorInvalidSearchAction = "<s:text name='webportal.search.results.error.invalidsearchaction'/>";        
			i18nerrorNoDataForSearch = "<s:text name='webportal.search.results.error.nosearchresults'/>";   
			isAjaxSearch = true;      	
		</script>
		<div id="wrapper">
			<%@ include file="headerv311.inc" %>
			<div id="main-content">
				<div class="big-row">
					<div class="large-12 columns">
						<h3 class="page-name-heading-search">
							<s:text name="webportal.search.results.text.description"/> :<span id="result-id"></span>
						</h3>
					</div>
				</div>
				<div id="block-search-results">
					<div class="big-row">
						<div class="large-12 columns">
							<div class="panel-outer" id="block-search-results-installations" style="display: none;">
								<h4 class="panel-heading">
									<i class="fi-graph-trend colorHeading"></i> 
									<s:text name="webportal.search.results.installation.title"/> 
									<span id="block-search-results-installations-number"></span> 
								</h4>
								<div class="panel-inner">
									<table id="instresults">
										<thead>
											<tr>
												<th><s:text name="webportal.search.results.installation.id"/></th>
												<th><s:text name="webportal.search.results.installation.code"/></th>
												<th><s:text name="webportal.search.results.installation.extcode"/></th>
												<th><s:text name="webportal.search.results.installation.domain"/></th>
												<th><s:text name="webportal.search.results.installation.lastchanged"/></th>
												<th><s:text name="webportal.search.results.installation.region"/></th>
												<th><s:text name="webportal.search.results.installation.milestone"/></th>
												<th><s:text name="webportal.search.results.installation.netarea"/></th>
												<th><s:text name="webportal.search.results.installation.status"/></th>
											</tr>
										</thead>
										<tbody>											
										</tbody>
									</table>
									<a href="javascript:showMoreResults('INST');" id="block-search-results-installations-link-more"><s:text name="webportal.search.results.installation.options.showmore"/></a>
								</div>
							</div>
						</div>
					</div>
					<div class="big-row">
						<div class="large-12 columns">
							<div class="panel-outer" id="block-search-results-measurepoints" style="display: none;">
								<h4 class="panel-heading">
									<i class="fi-graph-trend colorHeading"></i> 
									<s:text name="webportal.search.results.measurepoint.title"/>
									<span id="block-search-results-measurepoints-number"></span>
								</h4>
								<div class="panel-inner">
									<table id="instMepResults">
										<thead>
											<tr>
												<th><s:text name="webportal.search.results.measurepoint.id"/></th>
												<th><s:text name="webportal.search.results.measurepoint.code"/></th>
												<th><s:text name="webportal.search.results.measurepoint.extcode"/></th>
												<th><s:text name="webportal.search.results.measurepoint.domain"/></th>
												<th><s:text name="webportal.search.results.measurepoint.gsrn"/></th>
												<th><s:text name="webportal.search.results.measurepoint.utility"/></th>
												<th><s:text name="webportal.search.results.measurepoint.region"/></th>
												<th><s:text name="webportal.search.results.measurepoint.milestone"/></th>
												<th><s:text name="webportal.search.results.measurepoint.netarea"/></th>
												<th><s:text name="webportal.search.results.measurepoint.status"/></th>
											</tr>
										</thead>
										<tbody>											
										</tbody>
									</table>
									<div class="center-wrapper">
										<a href="javascript:showMoreResults('MEP')" id="block-search-results-measurepoints-link-more" class="link-more text-blue"><s:text name="webportal.search.results.measurepoint.options.showmore"/></a>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="big-row">
						<div class="large-12 columns">
							<div class="panel-outer" id="block-search-results-multipoints" style="display: none;">
								<h4 class="panel-heading">
									<i class="fi-graph-trend colorHeading"></i>
									<s:text name="webportal.search.results.multipoint.title"/>
									<span id="block-search-results-multipoints-number"></span>
								</h4>
								<div class="panel-inner">
									<table id="instMupResults">
										<thead>
											<tr>
												<th><s:text name="webportal.search.results.multipoint.id"/></th>
												<th><s:text name="webportal.search.results.multipoint.code"/></th>
												<th><s:text name="webportal.search.results.multipoint.domain"/></th>
												<th><s:text name="webportal.search.results.multipoint.netstation"/></th>
												<th><s:text name="webportal.search.results.multipoint.street"/></th>
												<th><s:text name="webportal.search.results.multipoint.region"/></th>
												<th><s:text name="webportal.search.results.multipoint.milestone"/></th>
												<th><s:text name="webportal.search.results.multipoint.netarea"/></th>
											</tr>
										</thead>
										<tbody>											
										</tbody>
									</table>
									<div class="center-wrapper">
										<a href="javascript:showMoreResults('MUP')" id="block-search-results-multipoints-link-more" class="link-more text-blue"><s:text name="webportal.search.results.multipoint.options.showmore"/></a>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="big-row">
						<div class="large-12 columns">
							<div class="panel-outer" id="block-search-results-devices" style="display: none;">
								<h4 class="panel-heading">
									<i class="fi-graph-trend colorHeading"></i>
									<s:text name="webportal.search.results.device.title"/>
									<span id="block-search-results-devices-number"></span>
								</h4>
								<div class="panel-inner">
									<table id="deviceResults">
										<thead>
											<tr>
												<th><s:text name="webportal.search.results.device.id"/></th>
												<th><s:text name="webportal.search.results.device.giai"/></th>
												<th><s:text name="webportal.search.results.device.serial"/></th>
												<th><s:text name="webportal.search.results.device.propno"/></th>
												<th><s:text name="webportal.search.results.device.type"/></th>
												<th><s:text name="webportal.search.results.device.devicemodel"/></th>
												<th><s:text name="webportal.search.results.device.timestamp"/></th>
												<th><s:text name="webportal.search.results.device.status"/></th>
											</tr>
										</thead>
										<tbody>											
										</tbody>		
									</table>
									<div class="center-wrapper">
										<a href="javascript:showMoreResults('DEVICE')" id="block-search-results-devices-link-more" class="link-more text-blue"><s:text name="webportal.search.results.device.options.showmore"/></a>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="big-row">
						<div class="large-12 columns">
							<div class="panel-outer" id="block-search-results-cases" style="display: none;">
								<h4 class="panel-heading">
									<i class="fi-graph-trend colorHeading"></i>
									<s:text name="webportal.search.results.case.title"/>
									<span id="block-search-results-cases-number"></span>
								</h4>
								<div class="panel-inner">
									<table id="caseResults">
										<thead>
											<tr class="table-title">
												<th><s:text name="webportal.search.results.case.id"/></th>
												<th><s:text name="webportal.search.results.case.casetype"/></th>
												<th><s:text name="webportal.search.results.case.user"/></th>
												<th><s:text name="webportal.search.results.case.lastchanged"/></th>
												<th><s:text name="webportal.search.results.case.status"/></th>
											</tr>
										</thead>
										<tbody>											
										</tbody>	
									</table>
									<div class="center-wrapper">
										<a href="javascript:showMoreResults('CASE')" id="block-search-results-cases-link-more" class="link-more text-blue"><s:text name="webportal.search.results.case.options.showmore"/></a>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<script>
			var searchid = "<%=request.getAttribute("id")%>";
			if(searchid!="null") {
				$("#search-input").val(searchid);
				//searchentities();
			}
			/*$('#block-search-results-installations-link-more').hide();
			$('#block-search-results-measurepoints-link-more').hide();
			$('#block-search-results-multipoints-link-more').hide();
			$('#block-search-results-devices-link-more').hide();	
			$('#block-search-results-cases-link-more').hide();*/
		</script>
	</div>
</body>
</html>
