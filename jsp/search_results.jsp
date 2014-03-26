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
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/styles/color.css"/>
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/styles/general.css" />
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/styles/header.css" />
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/styles/content-block.css" />
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/styles/footer.css" />
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/styles/content-search-results.css" />
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/styles/colResizable.css" />
		
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-1.9.1.min.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-migrate-1.1.1.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/colResizable-1.3.min.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/init.js"></script>
	
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

				<div class="title-large-block large-block text-grey">
					<s:text name="webportal.search.results.text.description"/> :<span id="result-id" class=" text-light-grey"></span>
					 
				</div> 

				<div class="large-block block block-accordion" id="block-search-results">
					<div class="block-title">
						<span class="block-title-picto"></span>
						<span class="block-title-name text-blue"><s:text name="webportal.search.results.title"/></span>
						<a href="#" class="block-title-button-open-all text-blue"><s:text name="webportal.search.results.options.openall"/></a>
						<a href="#" class="block-title-button-close-all text-blue"><s:text name="webportal.search.results.options.closeall"/></a>
					</div>
					<div class="content-wrapper">
						<div class="content">

							<ul class="accordion">
								<li class="toggleSubMenu" id="block-search-results-installations">
									<span class="accordion-title">&#149; <span class="accordion-title-name"><s:text name="webportal.search.results.installation.title"/></span> <span id="block-search-results-installations-number" class="number"></span><div id="block-search-results-installations-arrow" class="accordion-arrow open"></div></span>
									<ul class="subMenu" id="block-search-results-installations-submenu">
										<table id="instresults" class="text-grey installation-table" cellpadding="0" cellspacing="5">
											<thead>
											<tr class="table-title">
												<th class="col1"> &nbsp;&nbsp;&nbsp; <s:text name="webportal.search.results.installation.id"/></th>
												<th class="col2"><s:text name="webportal.search.results.installation.code"/></th>
												<th class="col3"><s:text name="webportal.search.results.installation.extcode"/></th>
												<th class="col4"><s:text name="webportal.search.results.installation.domain"/></th>
												<th class="col5"><s:text name="webportal.search.results.installation.lastchanged"/></th>
												<th class="col6"><s:text name="webportal.search.results.installation.region"/></th>
												<th class="col7"><s:text name="webportal.search.results.installation.milestone"/></th>
												<th class="col8"><s:text name="webportal.search.results.installation.netarea"/></th>
												<th class="col9"><s:text name="webportal.search.results.installation.status"/></th>
											</tr>
											</thead>
											<tbody>											
											</tbody>
										</table>
										<div class="center-wrapper">
											<a href="javascript:showMoreResults('INST');" id="block-search-results-installations-link-more" class="link-more text-blue"><s:text name="webportal.search.results.installation.options.showmore"/></a>
										</div>
									</ul>
								</li>
								<li class="toggleSubMenu" id="block-search-results-measurepoints">
									<span class="accordion-title">&#149; <span class="accordion-title-name"><s:text name="webportal.search.results.measurepoint.title"/></span> <span id="block-search-results-measurepoints-number" class="number"></span><div id="block-search-results-measurepoints-arrow" class="accordion-arrow open"></div></span>
									<ul class="subMenu" id="block-search-results-measurepoints-submenu">
										<table id="instMepResults" class="text-grey installation-table">
										<thead>
											<tr class="table-title">
												<th class="col1"> &nbsp;&nbsp;&nbsp; <s:text name="webportal.search.results.measurepoint.id"/></th>
												<th class="col2"><s:text name="webportal.search.results.measurepoint.code"/></th>
												<th class="col3"><s:text name="webportal.search.results.measurepoint.extcode"/></th>
												<th class="col4"><s:text name="webportal.search.results.measurepoint.domain"/></th>
												<th class="col5"><s:text name="webportal.search.results.measurepoint.gsrn"/></th>
												<th class="col6"><s:text name="webportal.search.results.measurepoint.utility"/></th>
												<th class="col7"><s:text name="webportal.search.results.measurepoint.region"/></th>
												<th class="col8"><s:text name="webportal.search.results.measurepoint.milestone"/></th>
												<th class="col9"><s:text name="webportal.search.results.measurepoint.netarea"/></th>
												<th class="col10"><s:text name="webportal.search.results.measurepoint.status"/></th>
											</tr>
										</thead>
										<tbody>											
										</tbody>
										</table>
										<div class="center-wrapper">
											<a href="javascript:showMoreResults('MEP')" id="block-search-results-measurepoints-link-more" class="link-more text-blue"><s:text name="webportal.search.results.measurepoint.options.showmore"/></a>
										</div>
									</ul>
								</li>
								<li class="toggleSubMenu" id="block-search-results-multipoints">
									<span class="accordion-title">&#149; <span class="accordion-title-name"><s:text name="webportal.search.results.multipoint.title"/></span> <span id="block-search-results-multipoints-number" class="number"></span> <div id="block-search-results-multipoints-arrow" class="accordion-arrow open"></div></span>
									<ul class="subMenu" id="block-search-results-multipoints-submenu">
										<table id="instMupResults" class="text-grey installation-table">
										<thead>
											<tr class="table-title">
												<th class="col1"> &nbsp;&nbsp;&nbsp; <s:text name="webportal.search.results.multipoint.id"/></th>
												<th class="col2"><s:text name="webportal.search.results.multipoint.code"/></th>
												<th class="col3"><s:text name="webportal.search.results.multipoint.domain"/></th>
												<th class="col4"><s:text name="webportal.search.results.multipoint.netstation"/></th>
												<th class="col5"><s:text name="webportal.search.results.multipoint.street"/></th>
												<th class="col6"><s:text name="webportal.search.results.multipoint.region"/></th>
												<th class="col7"><s:text name="webportal.search.results.multipoint.milestone"/></th>
												<th class="col8"><s:text name="webportal.search.results.multipoint.netarea"/></th>
											</tr>
										</thead>
										<tbody>											
										</tbody>
										</table>
										<div class="center-wrapper">
											<a href="javascript:showMoreResults('MUP')" id="block-search-results-multipoints-link-more" class="link-more text-blue"><s:text name="webportal.search.results.multipoint.options.showmore"/></a>
										</div>
									</ul>
								</li>
								<li class="toggleSubMenu" id="block-search-results-devices">									
									<span class="accordion-title">&#149; <span class="accordion-title-name"><s:text name="webportal.search.results.device.title"/></span> <span id="block-search-results-devices-number" class="number"></span> <div id="block-search-results-devices-arrow" class="accordion-arrow open"></div></span>
									<ul class="subMenu" id="block-search-results-devices-submenu">
										<table id="deviceResults"  class="text-grey installation-table">
										<thead>
											<tr class="table-title">
												<th class="col1"> &nbsp;&nbsp;&nbsp; <s:text name="webportal.search.results.device.id"/></th>
												<th class="col2"><s:text name="webportal.search.results.device.giai"/></th>
												<th class="col3"><s:text name="webportal.search.results.device.serial"/></th>
												<th class="col4"><s:text name="webportal.search.results.device.propno"/></th>
												<th class="col5"><s:text name="webportal.search.results.device.type"/></th>
												<th class="col6"><s:text name="webportal.search.results.device.devicemodel"/></th>
												<th class="col7"><s:text name="webportal.search.results.device.timestamp"/></th>
												<th class="col8"><s:text name="webportal.search.results.device.status"/></th>
											</tr>
										</thead>
										<tbody>											
										</tbody>		
										</table>
										<div class="center-wrapper">
											<a href="javascript:showMoreResults('DEVICE')" id="block-search-results-devices-link-more" class="link-more text-blue"><s:text name="webportal.search.results.device.options.showmore"/></a>
										</div>
									</ul>
								</li>
								<li class="toggleSubMenu" id="block-search-results-cases">
									<span class="accordion-title">&#149; <span class="accordion-title-name"><s:text name="webportal.search.results.case.title"/></span> <span id="block-search-results-cases-number" class="number"></span> <div id ="block-search-results-cases-arrow" class="accordion-arrow open"></div></span>
									<ul class="subMenu" id="block-search-results-cases-submenu">
										<table id="caseResults" class="text-grey installation-table">
										<thead>
											<tr class="table-title">
												<th class="col1"> &nbsp;&nbsp;&nbsp; <s:text name="webportal.search.results.case.id"/></th>
												<th class="col2"><s:text name="webportal.search.results.case.casetype"/></th>
												<th class="col3"><s:text name="webportal.search.results.case.user"/></th>
												<th class="col4"><s:text name="webportal.search.results.case.lastchanged"/></th>
												<th class="col5"><s:text name="webportal.search.results.case.status"/></th>
											</tr>
										</thead>
										<tbody>											
										</tbody>	
										</table>
										<div class="center-wrapper">
											<a href="javascript:showMoreResults('CASE')" id="block-search-results-cases-link-more" class="link-more text-blue"><s:text name="webportal.search.results.case.options.showmore"/></a>
										</div>
									</ul>
								</li>
							</ul>

						</div>
					</div>
				</div>

			</div>
			
			<%@ include file="footerv311.inc"%>
			<script>
			var searchid = "<%=request.getAttribute("id")%>";
			if(searchid!="null") {
				$("#search-input").val(searchid);
				//searchentities();
			}

			$('#block-search-results-installations-link-more').hide();
			$('#block-search-results-measurepoints-link-more').hide();
			$('#block-search-results-multipoints-link-more').hide();
			$('#block-search-results-devices-link-more').hide();	
			$('#block-search-results-cases-link-more').hide();
    		</script>

		</div>
	</body>
</html>
