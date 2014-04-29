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
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/styles/jquery.multiselect.css"/>
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/styles/general.css" />
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/styles/header.css" />
		<!--[if IE 8]>
		<link rel="stylesheet" href="<%=request.getContextPath()%>/styles/ie8.css">
		<![endif]-->
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/styles/datepicker.css" />
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/styles/content-time-reservation-call-list.css" />
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/styles/classic-min.css" />
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/js/dhtmlxGrid/codebase/dhtmlxgrid.css" />
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/styles/style.tidy.css" />

		<script src="<%=request.getContextPath()%>/js/jquery-1.9.1.min.js"></script>
		<script src="<%=request.getContextPath()%>/js/vendor/jquery.nicescroll.js"></script>
		<script src="<%=request.getContextPath()%>/js/jquery-migrate-1.1.1.js"></script>
		<script src="<%=request.getContextPath()%>/js/jquery-ui-1.10.2.custom.js"></script>
		<script src="<%=request.getContextPath()%>/js/jquery.multiselect.js"></script>
		<script src="<%=request.getContextPath()%>/js/sesp_ajax.js"></script>
		<script src="<%=request.getContextPath()%>/js/jQAllRangeSliders-min.js"></script>
		<script src="<%=request.getContextPath()%>/js/search-results.js"></script>
		<script src="<%=request.getContextPath()%>/js/time_reservation_call_list.js"></script>
		<script src="<%=request.getContextPath()%>/js/dhtmlxGrid/codebase/dhtmlxcommon.js"></script>
		<script src="<%=request.getContextPath()%>/js/dhtmlxGrid/codebase/dhtmlxgrid.js"></script>
		<script src="<%=request.getContextPath()%>/js/dhtmlxGrid/codebase/dhtmlxgridcell.js"></script>
		<script src="<%=request.getContextPath()%>/js/common.js"></script>
		<script src="<%=request.getContextPath()%>/js/dhtmlxGrid/codebase/customdhtmlxgrid_export.js"></script>
		<script src="<%=request.getContextPath()%>/js/spin.js"></script>
		<script src="<%=request.getContextPath()%>/js/ajax-loader.js"></script>

	<!--[if lt IE 9]>
	<script src="//cdnjs.cloudflare.com/ajax/libs/html5shiv/3.6.2/html5shiv.js"></script>
	<script src="//s3.amazonaws.com/nwapi/nwmatcher/nwmatcher-1.2.5-min.js"></script>
	<script src="//html5base.googlecode.com/svn-history/r38/trunk/js/selectivizr-1.0.3b.js"></script>
	<script src="//cdnjs.cloudflare.com/ajax/libs/respond.js/1.1.0/respond.min.js"></script>
	<![endif]-->
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
			<div class="big-row">
				<div class="large-12 columns filterHeader">
					<div class="big-row">
						<div class="large-12 columns">
							<h4><i class="fi-filter colorHeading"></i> Filters</h4>
						</div>
					</div>
					<div class="big-row">
						<div class="large-4 columns">
							<div class="row">
								<div class="medium-12 columns">
									<label>Domain</label>
									<select id="filter-multiselect-domain" onchange="onChangeDomain()" class="custom-multi-select" name="multiselect-domain" multiple="multiple">
										</select>
								</div>
							</div>

							<div class="row">
								<div class="medium-12 columns">
									<label>Case type</label>
									<select id="filter-multiselect-case-type" class="custom-multi-select" name="multiselect-case-type" multiple="multiple"></select>
								</div>
							</div>

							<div class="row">
								<div class="medium-12 columns">
									<label>Area</label>
									<select id="filter-multiselect-area" class="custom-multi-select" name="multiselect-area" multiple="multiple"></select>
								</div>
							</div>
						</div>

						<div class="large-4 columns">
							<div class="row">
								<div class="medium-12 columns">
									<label>Accessibility</label>
									<select id="filter-multiselect-accessibility" class="custom-multi-select" name="multiselect-accessibility" multiple="multiple"></select>
								</div>
							</div>

							<div class="row">
								<div class="medium-12 columns">
									<label>Contact language</label>
									<select id="filter-multiselect-contact-language" class="custom-multi-select" name="multiselect-contact-language" multiple="multiple"></select>
								</div>
							</div>

							<div class="row">
								<div class="medium-12 columns">
									<label>Locked orders</label>
									<select id="filter-multiselect-locked-orders" class="custom-multi-select" name="multiselect-locked-orders" multiple="multiple" ></select>
								</div>
							</div>
						</div>

						<div class="large-4 columns">
							<div class="row">
								<div class="medium-12 columns">
									<label>Valid call attempts</label>
									<div id="filter-slider"></div>
								</div>
							</div>

							<div class="row">
								<div class="medium-12 columns text-center">
									<a id="block-filter-button-update" onclick="validateOnSubmit()" class="button small">Update</a>
								</div>
							</div>
						</div>
				</div>
			</div><!-- end of filterHeader -->

			<div class="big-row">
				<div class="large-10 column">
					<div class="big-row">
						<div class="large-12 columns">
							<ul class="page-name-heading sub-menu">
								<span>TIME RESERVATION CALL LIST</span>
							</ul>
						</div>
					</div>
					<div class="big-row">
						<div class="large-12 columns">
							<div class="panel-outer">
								<h4 class="panel-heading"><i class="fi-graph-trend colorHeading"></i><span>Search results</span></h4>
									<div class="panel-inner">
										<div id="callListGridDiv"></div>
										<table id="block-time-reservation-call-list-table">
											<thead>
												<tr>
													<th>Case ID</th>
													<th>Locked by user</th>
													<th>Last contact</th>
													<th>Case type</th>
													<th>Customer name</th>
													<th>Milestone area</th>
													<th>CA bef.FV</th>
													<th>CA aft.FV</th>
													<th>DTC aft.FV</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td>
														<a href="#">4324</a>
													</td>
													<td>admin</td>
													<td>2013-01-01 12:00</td>
													<td>Meter change</td>
													<td>Martin Frick</td>
													<td>Area #1</td>
													<td>1</td>
													<td>2</td>
													<td>4</td>
												</tr>
												<tr>
													<td>
														<a href="#">4324</a>
													</td>
													<td>admin</td>
													<td>2013-01-01 12:00</td>
													<td>Meter change</td>
													<td>Martin Frick</td>
													<td>Area #1</td>
													<td>1</td>
													<td>2</td>
													<td>4</td>
												</tr>
												<tr>
													<td>
														<a href="#">4324</a>
													</td>
													<td>admin</td>
													<td>2013-01-01 12:00</td>
													<td>Meter change</td>
													<td>Martin Frick</td>
													<td>Area #1</td>
													<td>1</td>
													<td>2</td>
													<td>4</td>
												</tr>
												<tr>
													<td>
														<a href="#">4324</a>
													</td>
													<td>admin</td>
													<td>2013-01-01 12:00</td>
													<td>Meter change</td>
													<td>Martin Frick</td>
													<td>Area #1</td>
													<td>1</td>
													<td>2</td>
													<td>4</td>
												</tr>
												<tr>
													<td>
														<a href="#">4324</a>
													</td>
													<td>admin</td>
													<td>2013-01-01 12:00</td>
													<td>Meter change</td>
													<td>Martin Frick</td>
													<td>Area #1</td>
													<td>1</td>
													<td>2</td>
													<td>4</td>
												</tr>
												<tr>
													<td>
														<a href="#">4324</a>
													</td>
													<td>admin</td>
													<td>2013-01-01 12:00</td>
													<td>Meter change</td>
													<td>Martin Frick</td>
													<td>Area #1</td>
													<td>1</td>
													<td>2</td>
													<td>4</td>
												</tr>
											</tbody>
										</table>

										<div class="text-right">
											<a href="#" id="block-search-results-export-excel" onclick="javascript:callListExportGrid.toExcel('<%=request.getContextPath()%>/std/TimeReservationCallListExcel.action','TimeReservationCallListResults','color','HEADER');" class="button">Export to Excel</a>
										</div>
									</div>
							</div>
						</div>
					</div>
				</div>
				<div class="large-2 columns filtered show-for-large-up">
					<h5 class="text-center">YOU HAVE FILTERED</h5>
					<dl class="accordion" data-accordion>
						<dd>
							<a href="#panel1">Domain<span class="round label">3</span></a>
							<div id="panel1 selected-domain" class="content">
								<ul>
									<li>Domain1</li>
									<li>Domain2</li>
									<li>Domain3</li>
								</ul>
							</div>
						</dd>
						<dd>
							<a href="#panel2">Planning period type</a>
							<div id="panel2 selected-period-type" class="content">
								<ul>
									<li>Week</li>
								</ul>
							</div>
						</dd>
						<dd>
							<a href="#panel3">Date interval</a>
							<div id="panel3 selected-date" class="content">
								<ul>
									<li>From: 2009-01-01</li>
									<li>To: 2017-12-31</li>
								</ul>
							</div>
						</dd>
						<dd>
							<a href="#panel4">Planning periods <span class="round label">6</span></a>
							<div id="panel4 selected-date" class="content">
								<ul>
									<li>BG46 2013-11-10/2013-11-17 Eon-Eltel</li>
									<li>BG46 2013-11-10/2013-11-17 Eon-Eltel</li>
									<li>BG46 2013-11-10/2013-11-17 Eon-Eltel</li>
									<li>BG46 2013-11-10/2013-11-17 Eon-Eltel</li>
									<li>BG46 2013-11-10/2013-11-17 Eon-Eltel</li>
									<li>BG46 2013-11-10/2013-11-17 Eon-Eltel</li>
								</ul>
							</div>
						</dd>
						<dd>
							<a href="#panel4">Utlity type <span class="round label">4</span></a>
							<div id="panel4 selected-date" class="content">
								<ul>
									<li>Electrical</li>
									<li>Gas</li>
									<li>Heat</li>
									<li>Water</li>
								</ul>
							</div>
						</dd>
						</dl>
				</div>
			</div>

			<div class="wrapper-blur"></div>

		</div>
		<iframe id="myIFrm" name="myIFrm" src="" style="height: 0px; visibility: hidden"> </iframe>

	<!--[if lt IE 9]>
	<script type="text/javascript" src="https://raw.githubusercontent.com/chuckcarpenter/REM-unit-polyfill/master/js/rem.min.js"></script>
	<![endif]-->
	</body>
</html>
