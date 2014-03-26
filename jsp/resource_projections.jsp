<!DOCTYPE html>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title><s:text name='webportal.head.title'/></title>

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
		<% String contextPath = request.getContextPath(); %>
		
		<link rel="stylesheet" type="text/css" href="<%=contextPath%>/styles/bootstrap.css"/>
		<link rel="stylesheet" type="text/css" href="<%=contextPath%>/styles/color.css"/>
		<link rel="stylesheet" type="text/css" href="<%=contextPath%>/styles/jquery.multiselect.css"/>
		<link rel="stylesheet" type="text/css" href="<%=contextPath%>/styles/general.css" />
		<link rel="stylesheet" type="text/css" href="<%=contextPath%>/styles/header.css" />
		<link rel="stylesheet" type="text/css" href="<%=contextPath%>/styles/content-block.css" />
		<link rel="stylesheet" type="text/css" href="<%=contextPath%>/styles/footer.css" />
		<link rel="stylesheet" type="text/css" href="<%=contextPath%>/styles/datepicker.css" />
		<link rel="stylesheet" type="text/css" href="<%=contextPath%>/styles/content-resource-projections.css" />
		<link rel="stylesheet" type="text/css" href="<%=contextPath%>/styles/style.tidy.css" />
		<link rel="stylesheet" type="text/css" href="<%=contextPath%>/styles/bubble-map.css"/>
		<link rel="stylesheet" type="text/css" href="<%=contextPath%>/js/dhtmlxGrid/codebase/dhtmlxgrid.css" />
		
		<script type="text/javascript" src="<%=contextPath%>/js/jquery-1.9.1.min.js"></script>
		<script type="text/javascript" src="<%=contextPath%>/js/jquery-migrate-1.1.1.js"></script>
		<script type="text/javascript" src="<%=contextPath%>/js/jquery-ui-1.10.2.custom.js"></script>		
		<script type="text/javascript" src="<%=contextPath%>/js/bootstrap-datepicker.js"></script>
		<script type="text/javascript" src="<%=contextPath%>/js/jquery.multiselect.js"></script>
		<script type="text/javascript" src="<%=contextPath%>/js/jquery.cookie.js"></script>
		<script type="text/javascript" src="<%=contextPath%>/js/init.js"></script>		
		<script type="text/javascript" src="<%=contextPath%>/js/resource_projections.js"></script>
		<script src="<%=contextPath%>/js/fusionchartsxt/charts/FusionCharts.js"></script>
		
		<link rel="shortcut icon" type="image/png" href="<%=contextPath%>/js/images/favicon.png" />		
		
		<script type="text/javascript" src="<%=contextPath%>/js/OpenLayers.js"></script>
		
		<script src="<%=contextPath%>/js/map.js"></script>
		<script src="<%=contextPath%>/js/sesp_ajax.js"></script>
		<script src="<%=contextPath%>/js/spin.js"></script>
		<script src="<%=contextPath%>/js/ajax-loader.js"></script>
		<script type="text/javascript" src="<%=contextPath%>/js/search-results.js"></script>	
				
		<script>
			contextPath = "<%=contextPath%>";

			i18nerrorFromDateOlderThanToDate = "<s:text name='webportal.analyzefieldwork.fieldworkefficiency.filters.datesvalidation'/>";
			i18nerrorPleaseselectfromdate = "<s:text name='webportal.analyzefieldwork.fieldworkefficiency.filters.fromdateselect'/>";
			i18nerrorPleaseselecttodate = "<s:text name='webportal.analyzefieldwork.fieldworkefficiency.filters.todateselect'/>";
			i18nErrorSelectDomain = "<s:text name='webportal.error.choosedomain'/>";

			i18nErrorSelectArea = "<s:text name='webportal.error.selectarea'/>";
			i18nErrorSelectAreaType = "<s:text name='webportal.error.chooseareatype'/>";
			i18nErrorSelectUtilityType = "<s:text name='webportal.error.chooseutilitytype'/>";
			i18nErrorSelectDeviceType = "<s:text name='webportal.error.choosedevicetype'/>";
			i18nErrorSelectWorkOrderType = "<s:text name='webportal.error.chooseworkorderype'/>";
			i18nErrorSelectDeviceModel = "<s:text name='webportal.error.choosedevicemodel'/>";
			i18nErrorSelectPlanningPeriod = "<s:text name='webportal.resourceprojections.planningperiods.errorMessage'/>";
			
			
			
			
			i18nplanningname="<s:text name="webportal.resourceprojections.planningperiods.name"/>";
			i18nplanningstartdate="<s:text name="webportal.resourceprojections.planningperiods.startdate"/>";
			i18nplanningenddate="<s:text name="webportal.resourceprojections.planningperiods.enddate"/>";
			i18nplanningdomain="<s:text name="webportal.resourceprojections.planningperiods.domain"/>";	

			
		</script>
				
	</head>
	<body onload="loadDefaultData()">
		
		<div id="wrapper">
			<%@ include file="headerv311.inc" %>
			
			<div id="main-content">

				<div class="title-large-block large-block text-grey" >
					<s:text name="webportal.resourceprojections.title"/>
				</div>
				
				<div class="block retractable map-filter" id="block-time">
					<div class="block-title">
						<span class="block-title-picto"></span>
						<span class="block-title-name text-blue"><s:text name="webportal.resourceprojections.time.title"/></span>
						<span class="block-arrow open"></span>
					</div>
					<div class="content-wrapper">
						<div class="content text-grey">		
							
							<div class="select-wrapper">
								<span class="select-title text-grey"><s:text name="webportal.resourceprojections.time.domain.title"/></span>
								<div class="custom-select">
									<select id="block-time-multiselect-domain"  class="custom-multi-select" name="multiselect-domain" multiple="multiple" onchange="domainChanged()">
									</select>
								</div>
							</div>								
							
							<div class="select-wrapper">
								<span class="select-title text-grey"><s:text name="webportal.resourceprojections.time.dateinterval.title"/></span>
								<div class="custom-select">
									<select id="block-time-select-date-interval" onchange="onDateIntervalSelect()">
										
											<option value="upcomingweek"><s:text name="webportal.resourceprojections.time.dateinterval.upcomingweek"/></option>
											<option value="upcomingmonth"><s:text name="webportal.resourceprojections.time.dateinterval.upcomingmonth"/></option>													
											<option value="upcomingquarter"><s:text name="webportal.resourceprojections.time.dateinterval.upcomingquarter"/></option>
											<option value="upcomingyear"><s:text name="webportal.resourceprojections.time.dateinterval.upcomingyear"/></option>											
											<option value="custominterval"><s:text name="webportal.resourceprojections.time.dateinterval.custominterval"/></option>
										
									</select>
								</div>
							</div>
							<div class="select-wrapper" id="block_from_and_to_date">
								<div class="small-select-wrapper left-select">
									<span class="select-title text-red"><s:text name="webportal.resourceprojections.time.fromdate.title"/>:</span>
									<div class="custom-input-datepicker input-append date" data-date="2012-02-12" data-date-format="yyyy-mm-dd">
										<input id="block-time-date-from" type="text" class="input-datepicker text-red"  readonly="readonly"/>
									</div>
								</div>
								<div class="small-select-wrapper right-select">
									<span class="select-title text-red"><s:text name="webportal.resourceprojections.time.todate.title"/>:</span>
									<div class="custom-input-datepicker input-append date"  data-date="12-02-2012" data-date-format="yyyy-mm-dd">
										<input id="block-time-date-to" type="text" class="input-datepicker text-red"  readonly="readonly"/>
									</div>
								</div>
							</div>
							<div class="center-wrapper">
							<div class="button-wrapper">
								<a id="block-time-button-update" onclick="javascript:updatePlanningPeriod()" class="text-blue custom-button"><s:text name="webportal.resourceprojections.time.update"/></a>						
							</div>					
							</div>
						</div>
					</div>
				</div>
				
				<div class="large-block block retractable" id="block-planning-periods">
					<div class="block-title">
						<span class="block-title-picto"></span>
						<span class="block-title-name text-blue"><s:text name="webportal.resourceprojections.planningperiods.title"/></span>
						<a href="#" class="block-title-button-select-all text-blue"   ><s:text name="webportal.resourceprojections.planningperiods.selectall"/></a>
						<a href="#" class="block-title-button-select-none text-blue"  ><s:text name="webportal.resourceprojections.planningperiods.selectnone"/></a>
						<span class="block-arrow open"></span>
					</div>
					<div class="content-wrapper">
						<div class="content">
						
						<div style="height:234px; overflow:auto"> 
							<table class="big-table"  style="position:absolute;background-color:#fff;height:20px;">
								<tr class="table-title">
									<th class="col1" style="text-align:left !important;width:160px;overflow:hidden;"><s:text name="webportal.resourceprojections.planningperiods.name"/></th>
									<th class="col2" style="text-align:left !important;width:100px;overflow:hidden;"><s:text name="webportal.resourceprojections.planningperiods.startdate"/></th>
									<th class="col3" style="text-align:left !important;width:100px;overflow:hidden;"><s:text name="webportal.resourceprojections.planningperiods.enddate"/></th>
									<th class="col4" style="text-align:left !important;width:200px;overflow:hidden;"><s:text name="webportal.resourceprojections.planningperiods.domain"/></th>
								</tr>
							</table>
							<table class="big-table" id="block-planning-periods-table" style="margin-top:50px;">	
								<!--
								<tr class="table-line line-grey">
									<td>Month 2013 March</td>
									<td>2013-03-01</td>
									<td>2013-03-01</td>
									<td>Domain #1</td>
								</tr>
								<tr class="table-line">
									<td>Month 2013 April</td>
									<td>2013-03-01</td>
									<td>2013-03-01</td>
									<td>Domain #1</td>
								</tr>
								<tr class="table-line line-grey">
									<td>Month 2013 May</td>
									<td>2013-03-01</td>
									<td>2013-03-01</td>
									<td>Domain #1</td>
								</tr>
								
								
							--></table>
							</div>  
						</div>
					</div>
				</div>
				
				<div class="large-block block retractable" id="block-filters">
					<div class="block-title">
						<span class="block-title-picto"></span>
						<span class="block-title-name text-blue"><s:text name="webportal.resourceprojections.filters.title"/></span>
						<span class="block-arrow open"></span>
					</div>
					<div class="content-wrapper full-height">
						<div class="content text-grey">
							<div class="third-column">
								<div class="select-wrapper">
									<span class="select-title text-grey"><s:text name="webportal.resourceprojections.filters.utilitytype"/></span>
									<div class="custom-select">
										<select id="filter-multiselect-utility-type" class="custom-multi-select" name="multiselect-utility-type" multiple="multiple">
											<!--<option value="option_1">Electricity</option>
											<option value="option_2">Option 2</option>								
											<option value="option_3">Option 3</option>
											<option value="option_4">Option 4</option>
											<option value="option_5">Option 5</option>
											<option value="option_6">Option 6</option>
											<option value="option_7">Option 7</option>
										--></select>
									</div>
								</div>
								
								<div class="select-wrapper">
									<span class="select-title text-grey"><s:text name="webportal.resourceprojections.filters.area"/></span>
									<div class="custom-select">
										<select id="filter-multiselect-area" class="custom-multi-select" name="multiselect-area" multiple="multiple">
											<!--<option value="option_1">Option 1</option>
											<option value="option_2">Option 2</option>								
											<option value="option_3">Option 3</option>
											<option value="option_4">Option 4</option>
											<option value="option_5">Option 5</option>
											<option value="option_6">Option 6</option>
											<option value="option_7">Option 7</option>
										--></select>
									</div>
								</div>
								
							</div><!--
							--><div class="third-column">
								<div class="select-wrapper">
									<span class="select-title text-grey"><s:text name="webportal.resourceprojections.filters.areatype"/></span>
									<div class="custom-select">
										<select id="filter-multiselect-area-type" class="custom-multi-select" name="multiselect-area-type" multiple="multiple">
											<!--<option value="option_1">Milestone areas</option>
											<option value="option_2">Option 2</option>								
											<option value="option_3">Option 3</option>
											<option value="option_4">Option 4</option>
											<option value="option_5">Option 5</option>
											<option value="option_6">Option 6</option>
											<option value="option_7">Option 7</option>
										--></select>
									</div>
								</div><!--
								
								--><div class="select-wrapper">
									<span class="select-title text-grey"><s:text name="webportal.resourceprojections.filters.workordertype"/></span>
									<div class="custom-select">
										<select id="filter-multiselect-work-order-type" class="custom-multi-select" name="multiselect-work-order-type" multiple="multiple"><!--
											<option value="option_1">Option 1</option>
											<option value="option_2">Option 2</option>								
											<option value="option_3">Option 3</option>
											<option value="option_4">Option 4</option>
											<option value="option_5">Option 5</option>
											<option value="option_6">Option 6</option>
											<option value="option_7">Option 7</option>
										--></select>
									</div>
								</div>
							</div><!--
							--><div class="third-column">	
								<div class="select-wrapper">
									<span class="select-title text-grey"><s:text name="webportal.resourceprojections.filters.devicetype"/></span>
									<div class="custom-select">
										<select id="filter-multiselect-device-type" class="custom-multi-select" name="multiselect-device-type" multiple="multiple">
											<!--<option value="option_1">Option 1</option>
											<option value="option_2">Option 2</option>								
											<option value="option_3">Option 3</option>
											<option value="option_4">Option 4</option>
											<option value="option_5">Option 5</option>
											<option value="option_6">Option 6</option>
											<option value="option_7">Option 7</option>
										--></select>
									</div>
								</div>
								
								<div class="select-wrapper">
									<span class="select-title text-grey"><s:text name="webportal.resourceprojections.filters.devicemodel"/></span>
									<div class="custom-select">
										<select id="filter-multiselect-device-model" class="custom-multi-select" name="multiselect-device-model" multiple="multiple"><!--
											<option value="option_1">Option 1</option>
											<option value="option_2">Option 2</option>								
											<option value="option_3">Option 3</option>
											<option value="option_4">Option 4</option>
											<option value="option_5">Option 5</option>
											<option value="option_6">Option 6</option>
											<option value="option_7">Option 7</option>
										--></select>
									</div>
								</div>
							</div>
							
							<div class="center-wrapper">
								<div class="button-wrapper">
									<a id="block-filter-button-update" class="text-blue custom-button" onclick="javascript:processProjections()"><s:text name="webportal.resourceprojections.filters.update"/></a>						
								</div>	
							</div>
							
						</div>
					</div>
				</div>
								
				<div class="large-block block retractable" id="block-device-assets-projections">
					<div class="block-title">
						<span class="block-title-picto"></span>
						<span class="block-title-name text-blue"><s:text name="webportal.resourceprojections.deviceassets.title"/></span>
						<span class="block-arrow open"></span>
					</div>
					<div class="content-wrapper full-height">
						<div class="content text-grey">
							<div id="block-device-assets-projections-per-month">
								<div class="chart-title"><s:text name="webportal.resourceprojections.deviceassets.permonth"/></div>
								<div class="chart-view" id="block-device-assets-projections-per-month-view">
									<!--  <img src="<%=contextPath%>/images/resource-projection-per-month.jpg" /> -->
								</div>
							</div>
							
							<div id="block-device-assets-projections-total">
								<div class="chart-title"><s:text name="webportal.resourceprojections.deviceassets.total"/></div>
								<div class="chart-view" id="block-device-assets-projections-total-view">
									<!--  <img src="<%=contextPath%>/images/total-resource-projection.jpg" />  --> 
								</div>
							</div>
							
						</div>
					</div>
				</div>
								
				<div class="large-block block retractable" id="block-resource-projections-per-month">
					<div class="block-title">
						<span class="block-title-picto"></span>
						<span class="block-title-name text-blue"><s:text name="webportal.resourceprojections.resourceprojections.title"/></span>
						<span class="block-arrow open"></span>
					</div>
					<div class="content-wrapper full-height">
						<div class="content text-grey">
							<div id="block-resource-projections-per-month">
								<div class="chart-title"><s:text name="webportal.resourceprojections.resourceprojections.permonth"/></div>
								<div class="chart-view" id="block-resource-projections-per-month-view">
									<!-- <img src="<%=contextPath%>/images/resource-projection-per-month.jpg" />  -->
								</div>
							</div>
							
							<!--<div id="block-device-assets-projections-total">
								<div class="chart-title"><s:text name="webportal.resourceprojections.resourceprojections.total"/></div>
								<div class="chart-view" id="block-resource-projections-total-view">
									 <img src="<%=contextPath%>/images/total-resource-projection.jpg" />  
								</div>
							</div>
							
								--><div id="block-resource-projections-total">
								<div class="chart-title"><s:text name="webportal.resourceprojections.resourceprojections.total"/></div>
								<div class="chart-view" id="block-resource-projections-total-view">
									 <!-- <img src="<%=contextPath%>/images/total-resource-projection.jpg" />  --> 
								</div>
							</div>
							
							
						</div>
					</div>
				</div>
				
			</div>
			<%@ include file="footerv311.inc"%>

		</div>
	</body>
</html>
