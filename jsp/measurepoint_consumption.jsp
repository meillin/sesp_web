<!DOCTYPE html>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title><s:text name="webportal.head.title"/></title>

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
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/styles/datepicker.css" />
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/styles/modal.css" />
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/styles/content-measurepoint-consumption.css" />

		<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-1.9.1.min.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-migrate-1.1.1.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-ui-1.10.2.custom.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/bootstrap-datepicker.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.multiselect.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/sesp_ajax.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/search-results.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/common.js"></script>

		<script type="text/javascript" src="<%=request.getContextPath()%>/js/measurepoint-consumption.js"></script>
		<link rel="shortcut icon" type="image/png" href="<%=request.getContextPath()%>/images/favicon.png" />
		<script src="<%=request.getContextPath()%>/js/spin.js"></script>
		<script src="<%=request.getContextPath()%>/js/ajax-loader.js"></script>

		<script>
			mepId = "<%=request.getAttribute("mepId")%>";
			contextPath = "<%=request.getContextPath()%>";
			i18nerrorInvalidSearchInput="<s:text name='webportal.error.invalidsearchinput'/>";
			i18nerrorNoDataForSearch="<s:text name='webportal.error.nosearchresults'/>";
			i18nerrorMandatoryMessage="<s:text name='webportal.error.choosemandatory'/>";
			i18ncomparetoText="<s:text name='webportal.measurepoint.consumption.compareto'/>";
			i18nlastweekText="<s:text name='webportal.measurepoint.consumption.lastweek'/>";
			i18ntodayText="<s:text name='webportal.measurepoint.consumption.today'/>";
			i18nlastmonthText="<s:text name='webportal.measurepoint.consumption.lastmonth'/>";
			i18nlastquarterText="<s:text name='webportal.measurepoint.consumption.lastquarter'/>";
			i18nlastyearText="<s:text name='webportal.measurepoint.consumption.lastyear'/>";
			i18ncustomintervalText="<s:text name='webportal.measurepoint.consumption.custominterval'/>";
			i18nyesterdayText="<s:text name='webportal.measurepoint.consumption.yesterday'/>";
			i18to="<s:text name='webportal.measurepoint.consumption.to'/>";
			i18jan="<s:text name='webportal.reports.daily.selectjan'/>";
			i18feb="<s:text name='webportal.reports.daily.selectfeb'/>";
			i18mar="<s:text name='webportal.reports.daily.selectmar'/>";
			i18apr="<s:text name='webportal.reports.daily.selectapr'/>";
			i18may="<s:text name='webportal.reports.daily.selectmay'/>";
			i18jun="<s:text name='webportal.reports.daily.selectjun'/>";
			i18jul="<s:text name='webportal.reports.daily.selectjul'/>";
			i18aug="<s:text name='webportal.reports.daily.selectaug'/>";
			i18sep="<s:text name='webportal.reports.daily.selectsep'/>";
			i18oct="<s:text name='webportal.reports.daily.selectoct'/>";
			i18nov="<s:text name='webportal.reports.daily.selectnov'/>";
			i18dec="<s:text name='webportal.reports.daily.selectdec'/>";
			isAjaxSearch = false;
		</script>

	<!--[if lt IE 9]>
	<script src="//cdnjs.cloudflare.com/ajax/libs/html5shiv/3.6.2/html5shiv.js"></script>
	<script src="//s3.amazonaws.com/nwapi/nwmatcher/nwmatcher-1.2.5-min.js"></script>
	<script src="//html5base.googlecode.com/svn-history/r38/trunk/js/selectivizr-1.0.3b.js"></script>
	<script src="//cdnjs.cloudflare.com/ajax/libs/respond.js/1.1.0/respond.min.js"></script>
	<![endif]-->
	</head>
	<body onload="onLoadDefault()">
		<div id="wrapper">
			<%@ include file="headerv311.inc"%>
			<div id="main-content">
				<div class="big-row">
					<div class="large-12 columns">
						<h2 class="page-name-heading">
							<span class="block-title-name text-blue"><s:text name="webportal.measurepoint.consumption.profile"/></span>
						</h2>
					</div>
				</div>
				<div class="big-row">
					<div class="large-4 columns">
						<div class="panel-outer">
							<h4 class="panel-heading">
								<i class="fi-graph-trend colorHeading"></i>
								<span class="block-title-name text-blue"><s:text name="webportal.measurepoint.consumption.profile"/></span>
							</h4>
							<div class="panel-inner">
								<div id="block-daily-consumption-profile-charts-title">
								</div>
								<div id="block-daily-consumption-profile-charts-period">
									<s:text name="webportal.measurepoint.consumption.comparedtolastmonth"/>
								</div>
								<div id="block-daily-consumption-profile-charts-options">
									<a href="#" class="text-blue"><s:text name="webportal.measurepoint.consumption.chartoptions"/></a>
								</div>
								<div id="block-daily-consumption-profile-charts-view">
								</div>
							</div>
						</div>
					</div>
					<div class="large-4 columns">
						<div class="panel-outer">
							<h4 class="panel-heading">
								<i class="fi-graph-trend colorHeading"></i>
								<span class="block-title-name text-blue"><s:text name="webportal.measurepoint.consumption.consumptionreport"/></span>
							</h4>
							<div class="panel-inner">
								<div id="block-consumption-report-charts-title"></div>
								<div id="block-consumption-report-charts-period">
									<s:text name="webportal.measurepoint.consumption.lastmonth"/>
								</div>
								<div id="block-consumption-report-charts-options">
									<a class="text-blue" href="#"><s:text name="webportal.measurepoint.consumption.chartoptions"/></a>
								</div>
								<div id="block-consumption-report-charts-view"></div>
								<div id="block-consumption-report-charts-legend">
									<div class="data">
										<div class="data-title text-grey"><s:text name="webportal.measurepoint.consumption.totalenergyconsumption"/>&#32:</div>
										<div class="data-value text-light-grey" id="totalenergyconsumption"></div>
									</div>
									<div class="data">
										<div class="data-title text-grey"><s:text name="webportal.measurepoint.consumption.averageconsumption"/>&#32:</div>
										<div class="data-value text-light-grey" id="averageconsumption"></div>
									</div>
									<div class="data">
										<div class="data-title text-grey"><s:text name="webportal.measurepoint.consumption.minimumconsumption"/>&#32:</div>
										<div class="data-value text-light-grey" id="minimumconsumption"></div>
									</div>
									<div class="data">
										<div class="data-title text-grey"><s:text name="webportal.measurepoint.consumption.maximumconsumption"/>&#32:</div>
										<div class="data-value text-light-grey" id="maximumconsumption"></div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="large-4 columns">
						<div class="panel-outer">
							<h4 class="panel-heading">
								<i class="fi-graph-trend colorHeading"></i>
								<span class="block-title-name text-blue"><s:text name="webportal.measurepoint.consumption.loadprofile"/></span>
							</h4>
							<div class="panel-inner">
								<div id="block-load-profile-charts-title">
									<s:text name="webportal.measurepoint.consumption.lastmonth"/>
								</div>
								<div id="block-load-profile-charts-options">
									<a class="text-blue" href="#"><s:text name="webportal.measurepoint.consumption.chartoptions"/></a>
								</div>
								<div id="block-load-profile-charts-view"></div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>




		<div id="overlay"></div>


		<!--
			MODAL OF DAILY CONSUMPTION PROFILE
		-->
		<div id="modal-daily-consumption-profile" class="modal">
			<a class="button-quit" href="#"></a>
			<div class="modal-title text-grey"><s:text name="webportal.measurepoint.consumption.chartoptions"/></div>


			<div class="select-wrapper consumption-date-select">
				<span class="select-title text-grey"><s:text name="webportal.measurepoint.consumption.consumptiondate"/>&#32:</span>
				<div class="custom-select">
					<div class="custom-input-datepicker-wide input-append date" data-date="2012-02-12" data-date-format="yyyy-mm-dd">
						<input id="modal-daily-consumption-profile-input-consumption-date" type="text" class="input-datepicker text-grey"  readonly="readonly"/>
					</div>
				</div>
			</div>

			<div class="select-wrapper">
				<span class="select-title text-grey"><s:text name="webportal.measurepoint.consumption.compareto"/>&#32:</span>
				<div class="custom-select">
					<select id="modal-daily-consumption-profile-select-date-interval" onchange="onChangeDateInterval('modal-daily-consumption-profile-select-date-interval','modal-daily-consumption-profile-input-date-from','modal-daily-consumption-profile-input-date-to')">
						<option value="lastweek"><s:text name="webportal.measurepoint.consumption.lastweek"/></option>
						<option value="today"><s:text name="webportal.measurepoint.consumption.today"/></option>
						<option value="lastmonth" selected="selected"><s:text name="webportal.measurepoint.consumption.lastmonth"/></option>
						<option value="lastquarter"><s:text name="webportal.measurepoint.consumption.lastquarter"/></option>
						<option value="lastyear"><s:text name="webportal.measurepoint.consumption.lastyear"/></option>
						<option value="custominterval"><s:text name="webportal.measurepoint.consumption.custominterval"/></option>
					</select>
				</div>
			</div>

			<div class="select-wrapper">
				<div class="small-select-wrapper left-select">
					<span class="select-title text-red"><s:text name="webportal.measurepoint.consumption.from"/>:</span>
					<div class="custom-input-datepicker input-append date" data-date="2012-02-12" data-date-format="yyyy-mm-dd">
						<input id="modal-daily-consumption-profile-input-date-from" type="text" class="input-datepicker text-red"  readonly="readonly"/>
					</div>
				</div>
				<div class="small-select-wrapper right-select">
					<span class="select-title text-red"><s:text name="webportal.measurepoint.consumption.to"/>:</span>
					<div class="custom-input-datepicker input-append date"  data-date="12-02-2012" data-date-format="yyyy-mm-dd">
						<input id="modal-daily-consumption-profile-input-date-to" type="text" class="input-datepicker text-red"  readonly="readonly"/>
					</div>
				</div>
			</div>

			<div class="select-wrapper included-weekdays-select">
				<span class="select-title text-grey"><s:text name="webportal.measurepoint.consumption.includedweekdays"/>&#32:</span>
				<div class="radio-wrapper">
					<input type="radio" name="weekdays-radio" value="allweekday" id="modal-daily-consumption-profile-input-all-weekdays" checked="checked"><label class="text-light-grey" for="all-weekdays"><s:text name="webportal.measurepoint.consumption.allweekdays"/></label>
					<input type="radio" name="weekdays-radio" value="sameweekday" id="modal-daily-consumption-profile-input-same-weekday"><label class="text-light-grey" for="same-weekday"><s:text name="webportal.measurepoint.consumption.sameweekday"/></label>
				</div>
			</div>

			<div class="select-wrapper button-select">
				<div class="button-wrapper left">
					<a id="modal-daily-consumption-profile-button-cancel" class="text-red custom-button"><s:text name="webportal.measurepoint.consumption.cancel"/></a>
				</div>

				<div class="button-wrapper right">
					<a id="modal-daily-consumption-profile-button-ok" class="text-blue custom-button" onclick="javascript:updateMepConsumptionProfile();"><s:text name="webportal.measurepoint.consumption.ok"/></a>
				</div>

			</div>
		</div>


		<!--
			MODAL OF CONSUMPTION REPORT
		-->
		<div id="modal-consumption-report" class="modal">
			<a class="button-quit" href="#"></a>
			<div class="modal-title text-grey"><s:text name="webportal.measurepoint.consumption.chartoptions"/></div>

			<div class="select-wrapper">
				<span class="select-title text-grey"><s:text name="webportal.measurepoint.consumption.dateinterval"/>&#32:</span>
				<div class="custom-select">
					<select id="modal-consumption-report-select-date-interval" onchange="onChangeDateInterval('modal-consumption-report-select-date-interval','modal-consumption-report-input-date-from','modal-consumption-report-input-date-to')">
						<option value="lastweek"><s:text name="webportal.measurepoint.consumption.lastweek"/></option>
						<option value="today"><s:text name="webportal.measurepoint.consumption.today"/></option>
						<option value="yesterday"><s:text name="webportal.measurepoint.consumption.yesterday"/></option>
						<option value="lastmonth" selected="selected"><s:text name="webportal.measurepoint.consumption.lastmonth"/></option>
						<option value="lastquarter"><s:text name="webportal.measurepoint.consumption.lastquarter"/></option>
						<option value="lastyear"><s:text name="webportal.measurepoint.consumption.lastyear"/></option>
						<option value="custominterval"><s:text name="webportal.measurepoint.consumption.custominterval"/></option>
					</select>
				</div>
			</div>

			<div class="select-wrapper">
				<div class="small-select-wrapper left-select">
					<span class="select-title text-red"><s:text name="webportal.measurepoint.consumption.from"/>:</span>
					<div class="custom-input-datepicker input-append date" data-date="2012-02-12" data-date-format="yyyy-mm-dd">
						<input id="modal-consumption-report-input-date-from" type="text" class="input-datepicker text-red"  readonly="readonly"/>
					</div>
				</div>
				<div class="small-select-wrapper right-select">
					<span class="select-title text-red"><s:text name="webportal.measurepoint.consumption.to"/>:</span>
					<div class="custom-input-datepicker input-append date"  data-date="12-02-2012" data-date-format="yyyy-mm-dd">
						<input id="modal-consumption-report-input-date-to" type="text" class="input-datepicker text-red"  readonly="readonly"/>
					</div>
				</div>
			</div>

		<%--<div class="select-wrapper">
				<span class="select-title text-grey"><s:text name="webportal.measurepoint.consumption.groupby"/>&#32:</span>
				<div class="custom-select">
					<select id="modal-consumption-report-select-groupby">
						<option><s:text name="webportal.measurepoint.consumption.days"/></option>
						<option><s:text name="webportal.measurepoint.consumption.weeks"/></option>
						<option><s:text name="webportal.measurepoint.consumption.months"/></option>
						<option><s:text name="webportal.measurepoint.consumption.years"/></option>
					</select>
				</div>
			</div> --%>

			<div class="select-wrapper included-weekdays-select">
				<span class="select-title text-grey"><s:text name="webportal.measurepoint.consumption.includedweekdays"/>&#32:</span>
				<div class="radio-wrapper">
					<table class="text-grey">
						<tr>
							<td class="day">
								<span class="day-name"><s:text name="webportal.measurepoint.consumption.mo"/></span>
								<input type="checkbox" name="weekdays-checkbox-report" value="2" checked id="modal-consumption-report-checkbox-mo">
							</td>
							<td class="day">
								<span class="day-name"><s:text name="webportal.measurepoint.consumption.tu"/></span>
								<input type="checkbox" name="weekdays-checkbox-report" value="3" checked id="modal-consumption-report-checkbox-tu">
							</td>
							<td class="day">
								<span class="day-name"><s:text name="webportal.measurepoint.consumption.we"/></span>
								<input type="checkbox" name="weekdays-checkbox-report" value="4" checked id="modal-consumption-report-checkbox-we">
							</td>
							<td class="day">
								<span class="day-name"><s:text name="webportal.measurepoint.consumption.th"/></span>
								<input type="checkbox" name="weekdays-checkbox-report" value="5" checked id="modal-consumption-report-checkbox-th">
							</td>
							<td class="day">
								<span class="day-name"><s:text name="webportal.measurepoint.consumption.fr"/></span>
								<input type="checkbox" name="weekdays-checkbox-report" value="6" checked id="modal-consumption-report-checkbox-fr">
							</td>
							<td class="day">
								<span class="day-name"><s:text name="webportal.measurepoint.consumption.sa"/></span>
								<input type="checkbox" name="weekdays-checkbox-report" value="7" checked id="modal-consumption-report-checkbox-sa">
							</td>
							<td class="day">
								<span class="day-name"><s:text name="webportal.measurepoint.consumption.su"/></span>
								<input type="checkbox" name="weekdays-checkbox-report" value="1" checked id="modal-consumption-report-checkbox-su">
							</td>
						</tr>
					</table>
				</div>
			</div>

			<div class="select-wrapper button-select">
				<div class="button-wrapper left">
					<a id="modal-consumption-report-button-cancel" class="text-red custom-button"><s:text name="webportal.measurepoint.consumption.cancel"/></a>
				</div>

				<div class="button-wrapper right">
					<a id="modal-consumption-report-button-ok" class="text-blue custom-button" onclick="javascript:updateMepConsumptionReport();"><s:text name="webportal.measurepoint.consumption.ok"/></a>
				</div>

			</div>

		</div>


		<!--
			MODAL OF LOAD PROFILE
		-->
		<div id="modal-load-profile" class="modal">
			<a class="button-quit" href="#"></a>
			<div class="modal-title text-grey"><s:text name="webportal.measurepoint.consumption.chartoptions"/></div>

			<div class="select-wrapper">
				<span class="select-title text-grey"><s:text name="webportal.measurepoint.consumption.dateinterval"/>&#32:</span>
				<div class="custom-select">
					<select id="modal-load-profile-select-date-interval" onchange="onChangeDateInterval('modal-load-profile-select-date-interval','modal-load-profile-input-date-from','modal-load-profile-input-date-to')">
						<option value="lastweek"><s:text name="webportal.measurepoint.consumption.lastweek"/></option>
						<option value="today"><s:text name="webportal.measurepoint.consumption.today"/></option>
						<option value="yesterday"><s:text name="webportal.measurepoint.consumption.yesterday"/></option>
						<option value="lastmonth" selected="selected"><s:text name="webportal.measurepoint.consumption.lastmonth"/></option>
						<option value="lastquarter"><s:text name="webportal.measurepoint.consumption.lastquarter"/></option>
						<option value="lastyear"><s:text name="webportal.measurepoint.consumption.lastyear"/></option>
						<option value="custominterval"><s:text name="webportal.measurepoint.consumption.custominterval"/></option>
					</select>
				</div>
			</div>

			<div class="select-wrapper">
				<div class="small-select-wrapper left-select">
					<span class="select-title text-red"><s:text name="webportal.measurepoint.consumption.from"/>:</span>
					<div class="custom-input-datepicker input-append date" data-date="2012-02-12" data-date-format="yyyy-mm-dd">
						<input id="modal-load-profile-input-date-from" type="text" class="input-datepicker text-red"  readonly="readonly"/>
					</div>
				</div>
				<div class="small-select-wrapper right-select">
					<span class="select-title text-red"><s:text name="webportal.measurepoint.consumption.to"/>:</span>
					<div class="custom-input-datepicker input-append date"  data-date="12-02-2012" data-date-format="yyyy-mm-dd">
						<input id="modal-load-profile-input-date-to" type="text" class="input-datepicker text-red"  readonly="readonly"/>
					</div>
				</div>
			</div>

			<div class="select-wrapper included-weekdays-select">
				<span class="select-title text-grey">Included weekdays :</span>
				<div class="radio-wrapper">
					<table class="text-grey">
						<tr>
							<td class="day">
								<span class="day-name"><s:text name="webportal.measurepoint.consumption.mo"/></span>
								<input type="checkbox" name="weekdays-checkbox-lp" value="2" checked id="modal-load-profile-checkbox-mo">
							</td>
							<td class="day">
								<span class="day-name"><s:text name="webportal.measurepoint.consumption.tu"/></span>
								<input type="checkbox" name="weekdays-checkbox-lp" value="3" checked id="modal-load-profile-checkbox-tu">
							</td>
							<td class="day">
								<span class="day-name"><s:text name="webportal.measurepoint.consumption.we"/></span>
								<input type="checkbox" name="weekdays-checkbox-lp" value="4" checked id="modal-load-profile-checkbox-we">
							</td>
							<td class="day">
								<span class="day-name"><s:text name="webportal.measurepoint.consumption.th"/></span>
								<input type="checkbox" name="weekdays-checkbox-lp" value="5" checked id="modal-load-profile-checkbox-th">
							</td>
							<td class="day">
								<span class="day-name"><s:text name="webportal.measurepoint.consumption.fr"/></span>
								<input type="checkbox" name="weekdays-checkbox-lp" value="6" checked id="modal-load-profile-checkbox-fr">
							</td>
							<td class="day">
								<span class="day-name"><s:text name="webportal.measurepoint.consumption.sa"/></span>
								<input type="checkbox" name="weekdays-checkbox-lp" value="7" checked id="modal-load-profile-checkbox-sa">
							</td>
							<td class="day">
								<span class="day-name"><s:text name="webportal.measurepoint.consumption.su"/></span>
								<input type="checkbox" name="weekdays-checkbox-lp" value="1" checked id="modal-load-profile-checkbox-su">
							</td>
						</tr>
					</table>
				</div>
			</div>

			<div class="select-wrapper button-select">
				<div class="button-wrapper left">
					<a id="modal-load-profile-button-cancel" class="text-red custom-button"><s:text name="webportal.measurepoint.consumption.cancel"/></a>
				</div>

				<div class="button-wrapper right">
					<a id="modal-load-profile-button-ok" class="text-blue custom-button" onclick="javascript:updateMepConsumptionLoadProfile();"><s:text name="webportal.measurepoint.consumption.ok"/></a>
				</div>

			</div>
		</div>

	<!--[if lt IE 9]>
	<script type="text/javascript" src="https://raw.githubusercontent.com/chuckcarpenter/REM-unit-polyfill/master/js/rem.min.js"></script>
	<![endif]-->
	</body>
</html>
