<!DOCTYPE html>
<%@ taglib prefix="s" uri="/struts-tags" %>
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>	
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>Smart Energy Services Platform</title>
		
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
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/js/dhtmlxGrid/codebase/dhtmlxgrid.css" />
		<link rel="stylesheet" type="text/css" href="<%=contextPath%>/styles/content-analyze-field-work-efficiency-per-work-order-type.css" />
		
		<script src="<%=request.getContextPath()%>/js/fusionchartsxt/charts/FusionCharts.js"></script>	
		<script type="text/javascript" src="<%=contextPath%>/js/jquery-1.9.1.min.js"></script>
		<script type="text/javascript" src="<%=contextPath%>/js/jquery-migrate-1.1.1.js"></script>
		<script type="text/javascript" src="<%=contextPath%>/js/jquery-ui-1.10.2.custom.js"></script>		
		<script type="text/javascript" src="<%=contextPath%>/js/bootstrap-datepicker.js"></script>
		<script type="text/javascript" src="<%=contextPath%>/js/jquery.multiselect.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/colResizable-1.3.min.js"></script>
		<script type="text/javascript" src="<%=contextPath%>/js/init.js"></script>
		<script src="<%=request.getContextPath()%>/js/dhtmlxGrid/codebase/dhtmlxcommon.js"></script>
		<script src="<%=request.getContextPath()%>/js/dhtmlxGrid/codebase/dhtmlxgrid.js"></script>
		<script src="<%=request.getContextPath()%>/js/dhtmlxGrid/codebase/dhtmlxgridcell.js"></script>
		<script src="<%=request.getContextPath()%>/js/dhtmlxGrid/codebase/customdhtmlxgrid_export.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/search-results.js"></script>	
		<script type="text/javascript" src="<%=contextPath%>/js/sesp_ajax.js"></script>
		<script type="text/javascript" src="<%=contextPath%>/js/analyze_field_work_efficiency_per_work_order_type.js"></script>
		<script type="text/javascript" src="<%=contextPath%>/js/OpenLayers.js"></script>
		<link rel="shortcut icon" type="image/png" href="<%=contextPath%>/images/favicon.png" />
		
		<script>
			contextPath = "<%=contextPath%>";
			workOrderType="<%= request.getParameter("workOrderType")%>";

			analysisAreaTitle = "<s:text name='webportal.analyzefieldwork.fieldworkefficiency.techniciananalysis.filter.areas'/>"+" :";
			analysisTeamTitle = "<s:text name='webportal.analyzefieldwork.fieldworkefficiency.techniciananalysis.filter.teams'/>"+" :";
			analysisTechTitle = "<s:text name='webportal.analyzefieldwork.fieldworkefficiency.techniciananalysis.filter.technicians'/>"+" :";
					
			

			i18nerrorPleaseselectdomain = "<s:text name='webportal.analyzefieldwork.fieldworkefficiency.filters.domainselect'/>";
			i18nerrorPleaseselectarea = "<s:text name='webportal.analyzefieldwork.fieldworkefficiency.filters.areaselect'/>";
			i18nerrorPleaseselectteam = "<s:text name='webportal.analyzefieldwork.fieldworkefficiency.filters.teamselect'/>";
			i18nerrorPleaseselecttechnician = "<s:text name='webportal.analyzefieldwork.fieldworkefficiency.filters.technicianselect'/>";
			i18nerrorPleaseselectdateinterval = "<s:text name='webportal.analyzefieldwork.fieldworkefficiency.filters.dateintervalselect'/>";
			i18nerrorPleaseselectfromdate = "<s:text name='webportal.analyzefieldwork.fieldworkefficiency.filters.fromdateselect'/>";
			i18nerrorPleaseselecttodate = "<s:text name='webportal.analyzefieldwork.fieldworkefficiency.filters.todateselect'/>";
			i18nerrorFromDateOlderThanToDate = "<s:text name='webportal.analyzefieldwork.fieldworkefficiency.filters.datesvalidation'/>";
			
			function initTechnicianAnalysisGrid(){            	

				if(technicianAnalysisGrid)
				{
					technicianAnalysisGrid.clearAll();
					technicianAnalysisGrid.destructor();
				}   
				technicianAnalysisGrid = new dhtmlXGridObject('technicianValuesGridDiv');
				technicianAnalysisGrid.setImagePath("<%=request.getContextPath()%>/js/dhtmlxGrid/codebase/imgs/");		   
				technicianAnalysisGrid.setHeader("<s:text name='webportal.analyzefieldwork.fieldworkefficiency.techniciananalysis.filter.technicians'/>,"+
						  			"<s:text name='webportal.fieldworkefficiencyanalysis.workordertypeanalysis.expectedworkingtime'/>,"+
						  			"<s:text name='webportal.fieldworkefficiencyanalysis.workordertypeanalysis.actualworkingtime'/>,"+
						  			"<s:text name='webportal.fieldworkefficiencyanalysis.workordertypeanalysis.traveltime'/>,"+
						  			"<s:text name='webportal.fieldworkefficiencyanalysis.workordertypeanalysis.outcome'/>,"+				  			
						  			"<s:text name='webportal.fieldworkefficiencyanalysis.workordertypeanalysis.drivingdistance'/>");				
				technicianAnalysisGrid.setInitWidths("*,*,*,*,*,*"); 
				technicianAnalysisGrid.setColAlign("center,center,center,center,center,center"); 
				technicianAnalysisGrid.setSkin("xp"); 
				technicianAnalysisGrid.init();

				
			}

			function initTeamAnalysisGrid()
			{
				if(teamAnalysisGrid)
				{
					teamAnalysisGrid.clearAll();
					teamAnalysisGrid.destructor();
				}   
				teamAnalysisGrid = new dhtmlXGridObject('teamValuesGridDiv');
				teamAnalysisGrid.setImagePath("<%=request.getContextPath()%>/js/dhtmlxGrid/codebase/imgs/");		   
				teamAnalysisGrid.setHeader("<s:text name='webportal.analyzefieldwork.fieldworkefficiency.teamanalysis.filter.teams'/>,"+
						  			"<s:text name='webportal.fieldworkefficiencyanalysis.workordertypeanalysis.expectedworkingtime'/>,"+
						  			"<s:text name='webportal.fieldworkefficiencyanalysis.workordertypeanalysis.actualworkingtime'/>,"+
						  			"<s:text name='webportal.fieldworkefficiencyanalysis.workordertypeanalysis.traveltime'/>,"+
						  			"<s:text name='webportal.fieldworkefficiencyanalysis.workordertypeanalysis.outcome'/>,"+				  			
						  			"<s:text name='webportal.fieldworkefficiencyanalysis.workordertypeanalysis.drivingdistance'/>");				
				teamAnalysisGrid.setInitWidths("*,*,*,*,*,*"); 
				teamAnalysisGrid.setColAlign("center,center,center,center,center,center"); 
				teamAnalysisGrid.setSkin("xp"); 
				teamAnalysisGrid.init();
				}
			
			
		</script>
		<style>
		.accordion ul.content-wrapper table {
			max-width: 930px;
			width: 100% !important;
			table-layout: fixed;
		}

		.accordion ul.subMenu table th {
			word-wrap: break-word;
			overflow: hidden;
		}

		.accordion ul.subMenu table td {
			word-wrap: break-word;
			overflow: hidden;
		}
		
		</style>
     
    </head>

	<body onload="onLoadSpecial()">

		<div id="wrapper">
		
			<%@ include file="headerv311.inc"%>	

			<div id="main-content">

				<div class="title-large-block large-block text-grey" >
					<s:text name="webportal.analyzefieldwork.fieldworkefficiency.title"/> : <span class="text-light-grey" id="field-work-efficiency-analysis"><%= request.getParameter("workOrderType")%></span>
				</div>
				
				<div class="large-block block retractable" id="block-filters">
					<div class="block-title">
						<span class="block-title-picto"></span>
						<span class="block-title-name text-blue"><s:text name="webportal.analyzefieldwork.fieldworkefficiency.filters.title"/></span>
						<span class="block-arrow open"></span>
					</div>
					<div class="content-wrapper full-height">
						<div class="content text-grey">
							<div class="third-column">
								<div class="select-wrapper">
									<span class="select-title text-grey"><s:text name="webportal.analyzefieldwork.fieldworkefficiency.filters.dateinterval.title"/></span>
									<div class="custom-select">
										<select id="filter-select-date-interval" onchange="onDateIntervalSelect()">
											<option value="lastweek"><s:text name="webportal.analyzefieldwork.fieldworkefficiency.filters.dateinterval.lastweek"/></option>
											<option value="today"><s:text name="webportal.analyzefieldwork.fieldworkefficiency.filters.dateinterval.today"/></option>													
											<option value="lastmonth"><s:text name="webportal.analyzefieldwork.fieldworkefficiency.filters.dateinterval.lastmonth"/></option>
											<option value="lastquarter"><s:text name="webportal.analyzefieldwork.fieldworkefficiency.filters.dateinterval.lastquarter"/></option>
											<option value="lastyear"><s:text name="webportal.analyzefieldwork.fieldworkefficiency.filters.dateinterval.lastyear"/></option>
											<option value="custominterval"><s:text name="webportal.analyzefieldwork.fieldworkefficiency.filters.dateinterval.custominterval"/></option>
										</select>
									</div>
								</div>
								
								<div class="select-wrapper">
								    <!-- from date	-->
									<div id="from_date" class="small-select-wrapper left-select">
										<span class="select-title text-red"><s:text name="webportal.analyzefieldwork.fieldworkefficiency.filters.fromdate"/> :</span>
										<div class="custom-input-datepicker input-append date" data-date="2012-02-12" data-date-format="yyyy-mm-dd">
											<input id="filter-date-from" type="text" class="input-datepicker text-red"  readonly="readonly"/>
										</div>
									</div><!-- to date	--><div id="to_date" class="small-select-wrapper right-select">
										<span class="select-title text-red"><s:text name="webportal.analyzefieldwork.fieldworkefficiency.filters.todate"/> :</span>
										<div class="custom-input-datepicker input-append date"  data-date="12-02-2012" data-date-format="yyyy-mm-dd">
											<input id="filter-date-to" type="text" class="input-datepicker text-red"  readonly="readonly"/>
										</div>
									</div>
								</div>
								
							</div><!--  Domain
							--><div class="third-column">
								<div class="select-wrapper">
									<span class="select-title text-grey"><s:text name="webportal.analyzefieldwork.fieldworkefficiency.filters.domain.title"/></span>
									<div class="custom-select">
										<select id="filter-multiselect-domain" class="custom-multi-select" name="multiselect-domain" multiple="multiple" onchange="onDomainSelect()">
											<!-- <option value="option_1"><s:text name="webportal.analyzefieldwork.fieldworkefficiency.filters.domain.milestonearea"/></option>
											<option value="option_2"><s:text name="webportal.analyzefieldwork.fieldworkefficiency.filters.domain.option2"/></option>								
											<option value="option_3"><s:text name="webportal.analyzefieldwork.fieldworkefficiency.filters.domain.option3"/></option>
											<option value="option_4"><s:text name="webportal.analyzefieldwork.fieldworkefficiency.filters.domain.option4"/></option>
											<option value="option_5"><s:text name="webportal.analyzefieldwork.fieldworkefficiency.filters.domain.option5"/></option>
											<option value="option_6"><s:text name="webportal.analyzefieldwork.fieldworkefficiency.filters.domain.option6"/></option>
											<option value="option_7"><s:text name="webportal.analyzefieldwork.fieldworkefficiency.filters.domain.option7"/></option> -->
										</select> 
									</div>
								</div><!-- Area
								
								--><div class="select-wrapper">
									<span class="select-title text-grey"><s:text name="webportal.analyzefieldwork.fieldworkefficiency.filters.area.title"/></span>
									<div class="custom-select">
										<select id="filter-multiselect-area" class="custom-multi-select" name="multiselect-area" multiple="multiple">
										<!-- <option value="option_1"><s:text name="webportal.analyzefieldwork.fieldworkefficiency.filters.area.milestonearea"/></option>
											<option value="option_2"><s:text name="webportal.analyzefieldwork.fieldworkefficiency.filters.area.option2"/></option>								
											<option value="option_3"><s:text name="webportal.analyzefieldwork.fieldworkefficiency.filters.area.option3"/></option>
											<option value="option_4"><s:text name="webportal.analyzefieldwork.fieldworkefficiency.filters.area.option4"/></option>
											<option value="option_5"><s:text name="webportal.analyzefieldwork.fieldworkefficiency.filters.area.option5"/></option>
											<option value="option_6"><s:text name="webportal.analyzefieldwork.fieldworkefficiency.filters.area.option6"/></option>
											<option value="option_7"><s:text name="webportal.analyzefieldwork.fieldworkefficiency.filters.area.option7"/></option>
											 -->
										</select>
										
									</div>
								</div>
							</div><!-- Team
							--><div class="third-column">	
								<div class="select-wrapper">
									<span class="select-title text-grey"><s:text name="webportal.analyzefieldwork.fieldworkefficiency.filters.team.title"/></span>
									<div class="custom-select">
										<select id="filter-multiselect-team" class="custom-multi-select" name="multiselect-team" multiple="multiple" onchange="onTeamSelect()">
										<!-- 	<option value="option_1"><s:text name="webportal.analyzefieldwork.fieldworkefficiency.filters.team.milestonearea"/></option>
											<option value="option_2"><s:text name="webportal.analyzefieldwork.fieldworkefficiency.filters.team.option2"/></option>								
											<option value="option_3"><s:text name="webportal.analyzefieldwork.fieldworkefficiency.filters.team.option3"/></option>
											<option value="option_4"><s:text name="webportal.analyzefieldwork.fieldworkefficiency.filters.team.option4"/></option>
											<option value="option_5"><s:text name="webportal.analyzefieldwork.fieldworkefficiency.filters.team.option5"/></option>
											<option value="option_6"><s:text name="webportal.analyzefieldwork.fieldworkefficiency.filters.team.option6"/></option>
											<option value="option_7"><s:text name="webportal.analyzefieldwork.fieldworkefficiency.filters.team.option7"/></option>
											 -->
										</select>
									</div>
								</div>
								<!-- Technician			-->
								<div class="select-wrapper">
									<span class="select-title text-grey"><s:text name="webportal.analyzefieldwork.fieldworkefficiency.filters.technician.title"/></span>
									<div class="custom-select">
										<select id="filter-multiselect-technician" class="custom-multi-select" name="multiselect-technician" multiple="multiple">
											<!--   <option value="option_1"><s:text name="webportal.analyzefieldwork.fieldworkefficiency.filters.technician.milestonearea"/></option>
											<option value="option_2"><s:text name="webportal.analyzefieldwork.fieldworkefficiency.filters.technician.option2"/></option>								
											<option value="option_3"><s:text name="webportal.analyzefieldwork.fieldworkefficiency.filters.technician.option3"/></option>
											<option value="option_4"><s:text name="webportal.analyzefieldwork.fieldworkefficiency.filters.technician.option4"/></option>
											<option value="option_5"><s:text name="webportal.analyzefieldwork.fieldworkefficiency.filters.technician.option5"/></option>
											<option value="option_6"><s:text name="webportal.analyzefieldwork.fieldworkefficiency.filters.technician.option6"/></option>
											<option value="option_7"><s:text name="webportal.analyzefieldwork.fieldworkefficiency.filters.technician.option7"/></option>
											
											-->
										</select>
									</div>
								</div>
							</div>
							
							<div class="center-wrapper">
								<div class="button-wrapper">
									<a id="block-filter-button-update" class="text-blue custom-button"  href="javascript:onUpdateClick()"><s:text name="webportal.analyzefieldwork.fieldworkefficiency.filters.update.title" /></a>						
								</div>	
							</div>
							
						</div>
					</div>
				</div>
				
				<div class="large-block block retractable" id="block-technician-analysis">
					<div class="block-title">
						<span class="block-title-picto"></span>
						<span class="block-title-name text-blue"><s:text name="webportal.analyzefieldwork.fieldworkefficiency.techniciananalysis.title"/></span>
						<span class="block-arrow open"></span>
					</div>
					<div class="content-wrapper full-height">
						<div class="content text-grey">
							<div id="block-technician-analysis-chart">
								<!--<img src="<%=contextPath %>/images/technician-analysis.jpg" />
							--></div>
							<div id="block-technician-analysis-chart-filter" class="text-grey">
								<div id="block-technician-analysis-chart-filter-content">
									<div class="title text-blue"><s:text name="webportal.analyzefieldwork.fieldworkefficiency.techniciananalysis.filter.title"/> :</div>
									<div id="filter-technician-block-area" class="filter-block">
										<div class="filter-block-title"><s:text name="webportal.analyzefieldwork.fieldworkefficiency.techniciananalysis.filter.areas"/> :</div>
										
										<!-- <div class="filter-block-content">Kungsbacka 1</div>
										<div class="filter-block-content">Goteborg 2 1</div>
										 -->
									</div>
									<div id="filter-technician-block-team" class="filter-block">
										<div class="filter-block-title"><s:text name="webportal.analyzefieldwork.fieldworkefficiency.techniciananalysis.filter.teams"/> :</div>
										<!-- <div class="filter-block-content">Team #1</div>
										<div class="filter-block-content">Team #2</div>
										 -->
									</div>
									<div id="filter-technician-block-technician" class="filter-block">
										<div class="filter-block-title"><s:text name="webportal.analyzefieldwork.fieldworkefficiency.techniciananalysis.filter.technicians"/> :</div>
										<!-- <div class="filter-block-content">Martin Frick</div>
										<div class="filter-block-content">Conny Andersson</div>
										<div class="filter-block-content">Christian Isetjärn</div>
										 -->
									</div>
								</div>
							</div>
							
							<div id="table-wrapper">		
										<div id="technicianValuesGridDiv">
								</div>		
								<table id="block-technician-analysis-table">										
									 <thead>										
									<tr id="table-header" class="blue-wrapper text-blue">
										<th class="table-header-text column1"><s:text name="webportal.analyzefieldwork.fieldworkefficiency.techniciananalysis.filter.technicians"/></th>
										<th class="table-header-text column2"><s:text name="webportal.analyzefieldwork.fieldworkefficiency.techniciananalysis.expectedworkingtime"/></th>
										<th class="table-header-text column3"><s:text name="webportal.analyzefieldwork.fieldworkefficiency.techniciananalysis.actualworkingtime"/></th>
										<th class="table-header-text column4"><s:text name="webportal.analyzefieldwork.fieldworkefficiency.techniciananalysis.traveltime"/></th>
										<th class="table-header-text column5"><s:text name="webportal.analyzefieldwork.fieldworkefficiency.techniciananalysis.outcome"/></th>
										<th class="table-header-text column6"><s:text name="webportal.analyzefieldwork.fieldworkefficiency.techniciananalysis.drivingdistance"/></th>
									</tr>
									</thead>
									  <tbody>											
									</tbody>	
									<!--<tr class="table-line">
										<td class="align-left"><a href="#"><s:text name="webportal.analyzefieldwork.fieldworkefficiency.techniciananalysis.meterchange"/></a></td>
										<td>01:24</td>
										<td>01:00</td>
										<td>00:20</td>
										<td class="good">-29%</td>
										<td>14,2km</td>
									</tr>
									<tr class="table-line line-grey">
										<td class="align-left"><a href="#"><s:text name="webportal.analyzefieldwork.fieldworkefficiency.techniciananalysis.concentratorinstallation"/></a></td>
										<td>01:24</td>
										<td>01:00</td>
										<td>00:20</td>
										<td class="bad">17%</td>
										<td>11,4km</td>
									</tr>
									<tr class="table-line">
										<td class="align-left"><a href="#"><s:text name="webportal.analyzefieldwork.fieldworkefficiency.techniciananalysis.meterrollout"/></a></td>
										<td>01:24</td>
										<td>01:00</td>
										<td>00:20</td>
										<td class="bad">25%</td>
										<td>10,2km</td>
									</tr>
									<tr class="table-line line-average">
										<td class="align-left"><a href="#"><s:text name="webportal.analyzefieldwork.fieldworkefficiency.techniciananalysis.average"/></a></td>
										<td>01:24</td>
										<td>01:00</td>
										<td>00:20</td>
										<td class="bad">4%</td>
										<td>12,3km</td>
									</tr>
									
								--></table>
							</div>
							
							<div id="block-technician-analysis-export">
								<a href="javascript:technicianAnalysisGrid.toExcel('<%=request.getContextPath()%>/std/DownloadExcel.action','Field Work Technician Analysis','color','HEADER');" id="block-technician-analysis-export-excel"><span class="text-blue"><s:text name="webportal.analyzefieldwork.fieldworkefficiency.techniciananalysis.exporttoexcel"/></span></a>
								<a href="javascript:exportTechnicianAsPDF();" id="block-technician-analysis-export-pdf"><span class="text-blue"><s:text name="webportal.analyzefieldwork.fieldworkefficiency.techniciananalysis.exporttopdf"/></span></a>
							</div>

						</div>
					</div>
				</div>
				
				<div class="large-block block retractable" id="block-team-analysis">
					<div class="block-title">
						<span class="block-title-picto"></span>
						<span class="block-title-name text-blue"><s:text name="webportal.analyzefieldwork.fieldworkefficiency.teamanalysis.title"/></span>
						<span class="block-arrow open"></span>
					</div>
					<div class="content-wrapper full-height">
						<div class="content text-grey">
							<div id="block-team-analysis-chart">
								<!--<img src="<%=contextPath %>/images/team-analysis.jpg" />
							--></div>
							<div id="block-team-analysis-chart-filter" class="text-grey">
								<div id="block-team-analysis-chart-filter-content">
									<div class="title text-blue"><s:text name="webportal.analyzefieldwork.fieldworkefficiency.teamanalysis.filter.title"/> :</div>
									<div id="filter-team-block-area" class="filter-block">
										<div class="filter-block-title"><s:text name="webportal.analyzefieldwork.fieldworkefficiency.techniciananalysis.filter.areas"/> :</div>
										<!-- <div class="filter-block-content">Kungsbacka 1</div>
										<div class="filter-block-content">Goteborg 2 1</div>
										 -->
									</div>
									<div id="filter-team-block-team" class="filter-block">
										<div class="filter-block-title"><s:text name="webportal.analyzefieldwork.fieldworkefficiency.techniciananalysis.filter.teams"/> :</div>
										<!-- <div class="filter-block-content">Team #1</div>
										<div class="filter-block-content">Team #2</div>
										 -->
									</div>
									<div id="filter-team-block-technician" class="filter-block">
										<div class="filter-block-title"><s:text name="webportal.analyzefieldwork.fieldworkefficiency.techniciananalysis.filter.technicians"/> :</div>
										<!-- <div class="filter-block-content">Martin Frick</div>
										<div class="filter-block-content">Conny Andersson</div>
										<div class="filter-block-content">Christian Isetjärn</div>
										 -->
									</div>
								</div>
							</div>
							
							<div id="table-wrapper">	
								<div id="teamValuesGridDiv"></div>						
								<table id="block-team-analysis-table">		
								<thead>								
									<tr id="table-header" class="blue-wrapper text-blue">
										<th class="table-header-text column1"><s:text name="webportal.analyzefieldwork.fieldworkefficiency.teamanalysis.filter.teams"/></th>
										<th class="table-header-text column2"><s:text name="webportal.analyzefieldwork.fieldworkefficiency.teamanalysis.expectedworkingtime"/></th>
										<th class="table-header-text column3"><s:text name="webportal.analyzefieldwork.fieldworkefficiency.teamanalysis.actualworkingtime"/></th>
										<th class="table-header-text column4"><s:text name="webportal.analyzefieldwork.fieldworkefficiency.teamanalysis.traveltime"/></th>
										<th class="table-header-text column5"><s:text name="webportal.analyzefieldwork.fieldworkefficiency.teamanalysis.outcome"/></th>
										<th class="table-header-text column6"><s:text name="webportal.analyzefieldwork.fieldworkefficiency.teamanalysis.drivingdistance"/></th>
									</tr>
									</thead>
									<tbody>
									</tbody>
									<!--<tr class="table-line">
										<td class="align-left"><a href="#"><s:text name="webportal.analyzefieldwork.fieldworkefficiency.teamanalysis.meterchange"/></a></td>
										<td>01:24</td>
										<td>01:00</td>
										<td>00:20</td>
										<td class="good">-29%</td>
										<td>14,2km</td>
									</tr>
									<tr class="table-line line-grey">
										<td class="align-left"><a href="#"><s:text name="webportal.analyzefieldwork.fieldworkefficiency.teamanalysis.concentratorinstallation"/></a></td>
										<td>01:24</td>
										<td>01:00</td>
										<td>00:20</td>
										<td class="bad">17%</td>
										<td>11,4km</td>
									</tr>
									<tr class="table-line">
										<td class="align-left"><a href="#"><s:text name="webportal.analyzefieldwork.fieldworkefficiency.teamalysis.meterrollout"/></a></td>
										<td>01:24</td>
										<td>01:00</td>
										<td>00:20</td>
										<td class="bad">25%</td>
										<td>10,2km</td>
									</tr>
									<tr class="table-line line-average">
										<td class="align-left"><a href="#"><s:text name="webportal.analyzefieldwork.fieldworkefficiency.teamanalysis.average"/></a></td>
										<td>01:24</td>
										<td>01:00</td>
										<td>00:20</td>
										<td class="bad">4%</td>
										<td>12,3km</td>
									</tr>
									
								--></table>
							</div>
							
							<div id="block-team-analysis-export">
								<a href="javascript:teamAnalysisGrid.toExcel('<%=request.getContextPath()%>/std/DownloadExcel.action','Field Work Technician Analysis','color','HEADER');" id="block-team-analysis-export-excel"><span class="text-blue"><s:text name="webportal.analyzefieldwork.fieldworkefficiency.teamanalysis.exporttoexcel"/></span></a>
								<a href="javascript:exportTeamAsPDF();" id="block-team-analysis-export-pdf"><span class="text-blue"><s:text name="webportal.analyzefieldwork.fieldworkefficiency.teamanalysis.exporttopdf"/></span></a>
							</div>

						</div>
					</div>
				</div>
				
			</div>
			<%@ include file="footerv311.inc"%>
		</div>
		<iframe id="myIFrm" name="myIFrm" src="" style="height: 0px; visibility: hidden"> </iframe>
		<input type="hidden" name="imgfilenames" id="imgfilenames"/>
	</body>
</html>
