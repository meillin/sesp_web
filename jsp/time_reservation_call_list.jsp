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
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/styles/bootstrap.css"/>
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/styles/color.css"/>
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/styles/jquery.multiselect.css"/>
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/styles/general.css" />
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/styles/header.css" />
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/styles/content-block.css" />
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/styles/footer.css" />
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/styles/datepicker.css" />
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/styles/content-time-reservation-call-list.css" />
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/styles/classic-min.css" />
	    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/js/dhtmlxGrid/codebase/dhtmlxgrid.css" />
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/styles/style.tidy.css" />
		
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/styles/colResizable.css" />
				

		
		
		
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-1.9.1.min.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-migrate-1.1.1.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/colResizable-1.3.min.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-ui-1.10.2.custom.js"></script>		
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/bootstrap-datepicker.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.multiselect.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/init.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/sesp_ajax.js"></script>		
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/jQAllRangeSliders-min.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/search-results.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/time_reservation_call_list.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/dhtmlxGrid/codebase/dhtmlxcommon.js"></script>
        <script type="text/javascript" src="<%=request.getContextPath()%>/js/dhtmlxGrid/codebase/dhtmlxgrid.js"></script>
        <script type="text/javascript" src="<%=request.getContextPath()%>/js/dhtmlxGrid/codebase/dhtmlxgridcell.js"></script>
        <script type="text/javascript" src="<%=request.getContextPath()%>/js/dhtmlxGrid/codebase/customdhtmlxgrid_export.js"></script> 
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/spin.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/ajax-loader.js"></script>

		<style type="text/css">
			#main-content .large-block .big-table {
				width: 100% !important;
				max-width: 930px;
				table-layout: fixed;
			}
			
			#main-content .large-block .big-table td {
				padding-top: 8px;
				overflow: hidden;
				white-space: nowrap;
				text-overflow: ellipsis;
				border-left: 10px solid transparent;
			}
			
			#main-content .large-block .big-table th {
				padding-top: 8px;
				overflow: hidden;
				white-space: nowrap;
				text-overflow: ellipsis;
				border-left: 10px solid transparent;
			}
			#callListGridDiv{
				visibility:collapse;
				height: 1px;
			}
		</style>
	</head>
	<body>
	<script>
	 	contextPath 		 = "<%=request.getContextPath()%>";    
	 	i18nSelectDomain 	 = "<s:text name='webportal.time.reservation.call.list.error.domain'/>"; 	

	 	callListExportHeader = "<s:text name='webportal.time.reservation.call.list.results.case.id'/>," +
							 	"<s:text name='webportal.time.reservation.call.list.results.locked.by.user'/>," +
							 	"<s:text name='webportal.time.reservation.call.list.results.last.contact'/>," +
							 	"<s:text name='webportal.time.reservation.call.list.results.case.type'/>," +
							 	"<s:text name='webportal.time.reservation.call.list.results.customer.name'/>," +
							 	"<s:text name='webportal.time.reservation.call.list.results.milestone.area'/>," +
							 	"<s:text name='webportal.time.reservation.call.list.results.ca.bef.fv'/>," +
							 	"<s:text name='webportal.time.reservation.call.list.results.ca.aft.fv'/>," +
							 	"<s:text name='webportal.time.reservation.call.list.results.dtc.aft.fv'/>";
	 	
		idDomainList 		 = "#filter-multiselect-domain";
		idCasetypeList 		 = "#filter-multiselect-case-type";  
		idAreaList			 = "#filter-multiselect-area";  
		idAccessibilityList  = "#filter-multiselect-accessibility";   
		idLanguageList 		 = "#filter-multiselect-contact-language";  
		idLockedordersList 	 = "#filter-multiselect-locked-orders";  
		idCallAttemptsSlider = "#filter-slider"; 
		idSearchResultsTable = "#block-time-reservation-call-list-table";
		idDivExportLink  	 = "#block-search-results-export";
		                     	
    </script>

		<div id="wrapper">
			
			<!--  Header -->
			<%@ include file="headerv311.inc"%>			

			<div id="main-content">
				
				<div class="large-block block retractable" id="block-filter">
					
					<div class="block-title">
						<span class="block-title-picto"></span>
						<span class="block-title-name text-blue"><s:text name="webportal.time.reservation.call.list.filter.title"/></span>
						<span class="block-arrow open"></span>
					</div>					
				
					
					<div class="content-wrapper full-height">						
						<div class="content text-grey">						
							<div class="third-column">							
								
								<div class="select-wrapper">
									<span class="select-title text-grey"><s:text name="webportal.time.reservation.call.list.filter.domain"/></span>
									<div class="custom-select">
										<select id="filter-multiselect-domain" onchange="onChangeDomain()" class="custom-multi-select" name="multiselect-domain" multiple="multiple">
										</select>
									</div>
								</div>
								
								<div class="select-wrapper">
									<span class="select-title text-grey"><s:text name="webportal.time.reservation.call.list.filter.case.type"/></span>
									<div class="custom-select">
										<select id="filter-multiselect-case-type" class="custom-multi-select" name="multiselect-case-type" multiple="multiple">
										</select>
									</div>
								</div>
								
								<div class="select-wrapper">
									<span class="select-title text-grey"><s:text name="webportal.time.reservation.call.list.filter.area"/></span>
									<div class="custom-select">
										<select id="filter-multiselect-area" class="custom-multi-select" name="multiselect-area" multiple="multiple">
										</select>
									</div>
								</div>
							
								
							</div><!--
							--><div class="third-column">
								<div class="select-wrapper">
									<span class="select-title text-grey"><s:text name="webportal.time.reservation.call.list.filter.accessibility"/></span>
									<div class="custom-select">
										<select id="filter-multiselect-accessibility" class="custom-multi-select" name="multiselect-accessibility" multiple="multiple">
										</select>
									</div>
								</div>								
								<div class="select-wrapper">
									<span class="select-title text-grey"><s:text name="webportal.time.reservation.call.list.filter.contact.language"/></span>
									<div class="custom-select">
										<select id="filter-multiselect-contact-language" class="custom-multi-select" name="multiselect-contact-language" multiple="multiple">
										</select>
									</div>
								</div>
							</div><!--
							--><div class="third-column">	
								<div class="select-wrapper">
									<span class="select-title text-grey"><s:text name="webportal.time.reservation.call.list.filter.locked.orders"/></span>
									<div class="custom-select">
										<select id="filter-multiselect-locked-orders" class="custom-multi-select" name="multiselect-locked-orders" multiple="multiple" >
										</select>
									</div>
								</div>
								
								<div id="filter-slider-wrapper">
									<span class="select-title text-grey"><s:text name="webportal.time.reservation.call.list.filter.valid.call.attempts"/></span>
									<div id="filter-slider"></div>
								</div>
								
							</div>
							<div class="center-wrapper">
								<div class="button-wrapper">
									<a id="block-filter-button-update" onclick="validateOnSubmit()" class="text-blue custom-button"><s:text name="webportal.time.reservation.call.list.filter.update"/></a>						
								</div>	
							</div>
						</div>
					</div>
				</div>
				
			
				
				<div class="large-block block retractable" id="block-search-results">
					<div class="block-title">
						<span class="block-title-picto"></span>
						<span class="block-title-name text-blue"><s:text name="webportal.time.reservation.call.list.results.title"/></span>
						<span class="block-arrow open"></span>
					</div>
					<div class="content-wrapper">
						<div class="content">
						
							<div id="callListGridDiv"></div>
							
							<table class="big-table hardware-conf" id="block-time-reservation-call-list-table">
							<thead>
								<tr class="table-title">
									<th class="col1"> &nbsp;&nbsp;&nbsp; <s:text name="webportal.time.reservation.call.list.results.case.id"/></th>
									<th class="col2"><s:text name="webportal.time.reservation.call.list.results.locked.by.user"/></th>
									<th class="col3"><s:text name="webportal.time.reservation.call.list.results.last.contact"/></th>
									<th class="col4"><s:text name="webportal.time.reservation.call.list.results.case.type"/></th>
									<th class="col5"><s:text name="webportal.time.reservation.call.list.results.customer.name"/></th>
									<th class="col6"><s:text name="webportal.time.reservation.call.list.results.milestone.area"/></th>
									<th class="col7"><s:text name="webportal.time.reservation.call.list.results.ca.bef.fv"/></th>
									<th class="col8"><s:text name="webportal.time.reservation.call.list.results.ca.aft.fv"/></th>
									<th class="col9"><s:text name="webportal.time.reservation.call.list.results.dtc.aft.fv"/></th>
								</tr>
							</thead>
							<tbody>
							</tbody>
							</table>
							
							<div class="export-wrapprer">					
								<div id="block-search-results-export"> 
									<a href="#" id="block-search-results-export-excel" onclick="javascript:callListExportGrid.toExcel('<%=request.getContextPath()%>/std/TimeReservationCallListExcel.action','TimeReservationCallListResults','color','HEADER');" class="link-more text-blue" align="right">
									   <span class="text-blue"> <s:text name="webportal.time.reservation.call.list.results.export.excel"/> </span>
									</a>  
								</div>					
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
