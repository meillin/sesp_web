<!DOCTYPE html>

<%@page import="java.util.*,java.text.*"%>
<%@page import="com.capgemini.sesp.ast_sep.webclient.util.*"%>
<%@page import="com.capgemini.sesp.ast_sep.webclient.util.to.*"%>

<%@page import="com.skvader.rsp.cft.webservice_client.service.provider.ServiceProvider" %>
<%@page import="com.capgemini.sesp.ast_sep.webclient.service.StockService"%>
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

		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/styles/foundation.css" />
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/foundation-icons/foundation-icons.css">
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/styles/jquery.multiselect.css"/>
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/styles/general.css" />

		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/styles/content-stock-management.css" />
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/styles/style.tidy.css" />
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/styles/bubble-map.css"/>


		<script src="<%=request.getContextPath()%>/js/jquery-1.9.1.min.js"></script>
		<script src="<%=request.getContextPath()%>/js/vendor/jquery.nicescroll.js"></script>
		<script src="<%=request.getContextPath()%>/js/jquery-migrate-1.1.1.js"></script>
		<script src="<%=request.getContextPath()%>/js/jquery.cookie.js"></script>
		<script src="<%=request.getContextPath()%>/js/jquery-ui-1.10.2.custom.js"></script>
		<script src="<%=request.getContextPath()%>/js/bootstrap-datepicker.js"></script>
		<script src="<%=request.getContextPath()%>/js/jquery.multiselect.js"></script>
		<script src="<%=request.getContextPath()%>/js/stock-management.js"></script>
		<script src="<%=request.getContextPath()%>/js/search-results.js"></script>
		<script src="<%=request.getContextPath()%>/js/OpenLayers.js"></script>
		<script src="<%=request.getContextPath()%>/js/common.js"></script>

		<script src="<%=request.getContextPath()%>/js/map.js"></script>
		<script src="<%=request.getContextPath()%>/js/sesp_ajax.js"></script>
		<script src="<%=request.getContextPath()%>/js/spin.js"></script>
		<script src="<%=request.getContextPath()%>/js/ajax-loader.js"></script>

		<script src="<%=request.getContextPath()%>/js/highchart/highcharts.js"></script>

		<link rel="shortcut icon" type="image/png" href="<%=request.getContextPath()%>/images/favicon.png" />

		<!--[if lt IE 9]>
		<link rel="stylesheet" href="<%=request.getContextPath()%>/styles/ie8.css">
		<script src="//cdnjs.cloudflare.com/ajax/libs/html5shiv/3.6.2/html5shiv.js"></script>
		<script src="//s3.amazonaws.com/nwapi/nwmatcher/nwmatcher-1.2.5-min.js"></script>
		<script src="//html5base.googlecode.com/svn-history/r38/trunk/js/selectivizr-1.0.3b.js"></script>
		<script src="//cdnjs.cloudflare.com/ajax/libs/respond.js/1.1.0/respond.min.js"></script>
		<![endif]-->
	</head>
	<body onload="onLoadSpecial(),initmap('<%=request.getSession().getAttribute("MAP_SERVER_URL")%>'),onChangeEntity()">
		<script>
			contextPath = "<%=request.getContextPath()%>";
			mapServerUrl= "<%=application.getAttribute("MAP_SERVER_URL")%>";
			isAjaxSearch = false;
		</script>
		<div id="wrapper">
			<%@ include file="headerv311.inc" %>

			<%
				StockService stockService = ServiceProvider.getInstance().getService(StockService.class);
				List<StockTTO> stockTypes = stockService.getStockTypes();
				Map<Long, String> selectedImage = new HashMap<Long, String>();
				Map<Long, String> unselectedImage = new HashMap<Long, String>();
				String[] symbols = new String[] {"blue","green","orange","pink","purple","red","yellow"};

				int symbolCounter = 0;
				for(StockTTO stockTTO : stockTypes) {
					unselectedImage.put(stockTTO.getId(), ((HttpServletRequest)pageContext.getRequest()).getContextPath() + "/images/marker-icon-blue.png");
					selectedImage.put(stockTTO.getId(),  ((HttpServletRequest)pageContext.getRequest()).getContextPath() + "/images/marker-icon-blue.png");
					symbolCounter++;
				}
			%>
			<script>
					contextPath = "<%=request.getContextPath()%>";
					i18nSelectDeviceType="<s:text name='webportal.stock.selectdevicetype'/>";
					i18nSelectDomain="<s:text name='webportal.stock.selectdomain'/>";
					i18nSelectDeviceModel="<s:text name='webportal.stock.selectdevicemodel'/>";
					i18nSelectStockSite="<s:text name='webportal.stock.selectstock'/>";
					i18nerrorPleaseChooseCategory="<s:text name='webportal.error.choosecategory'/>";
					i18nerrorPleaseChooseBreakup="<s:text name='webportal.error.choosebreakup'/>";
					i18nerrorChartError="<s:text name='webportal.error.nodataavailable'/>";
					i18nId="<s:text name='webportal.stock.id'/>";
					i18nName="<s:text name='webportal.stock.name'/>";
					i18nType="<s:text name='webportal.stock.type'/>";
					i18nInfo="<s:text name='webportal.stock.info'/>";
					i18nAddress="<s:text name='webportal.stock.address'/>";
					i18nPostCode="<s:text name='webportal.stock.postcode'/>";
					i18nPostAddress="<s:text name='webportal.stock.postaddress'/>";
					i18nContactPerson="<s:text name='webportal.stock.contactperson'/>";
					i18nContactWorkPhone="<s:text name='webportal.stock.contactworkphone'/>";
					i18nContactMobilePhone="<s:text name='webportal.stock.contactmobilephone'/>";
					i18nStockAll="<s:text name='webportal.alert.all'/>";
					i18nerrorPleaseChooseMandatoryFields="<s:text name='webportal.error.choosemandatory'/>";

					i18nInStockTab="<s:text name='webportal.stock.instock'/>";
					i18nStockPalletTab="<s:text name='webportal.stock.onpallet'/>";
					i18nStockSupplierTab="<s:text name='webportal.stock.fromsupplier'/>";

					i18nOptionSelectEntityShown =
					"<option value='M'><s:text name='webportal.stock.category.devicemodel'/></option>"+
					"<option value='UT'><s:text name='webportal.stock.category.devicetype'/></option>"+
					"<option value='US'><s:text name='webportal.stock.category.status'/></option>"+
					"<option value='W'><s:text name='webportal.stock.category.stocksite'/></option>";

					i18nOptionSelectEntityShownFromSupplier =
					"<option value='M'><s:text name='webportal.stock.category.devicemodel'/></option>"+
					"<option value='UT'><s:text name='webportal.stock.category.devicetype'/></option>"+
					"<option value='US'><s:text name='webportal.stock.category.status'/></option>";

					i18nOptionSelectDivideEntity =
					"<option value='N'><s:text name='webportal.stock.breakup.none'/></option>"+
					"<option value='M'><s:text name='webportal.stock.category.devicemodel'/></option>"+
					"<option value='UT'><s:text name='webportal.stock.category.devicetype'/></option>"+
					"<option value='US'><s:text name='webportal.stock.category.status'/></option>"+
					"<option value='W'><s:text name='webportal.stock.category.stocksite'/></option>";

					function loadPoints(domainCode,stockId) {
						var obj= {};
						obj.url=contextPath+"/std/GetStockMapPoints.action";
						obj.pdata = "dc="+domainCode+"&stockId="+stockId;
						obj.successfunc = loadPointsSuccess;
						obj.errorfunc = errorDetails;
						run_ajax(obj);
						return;
					}

					function loadPointsSuccess(data) {
						function getPointCollection(object, pointCollections) {
							var pointCollection = pointCollections[object.idStockT];
							if(typeof pointCollection == "undefined") {
								<%
								for(StockTTO stockTTO : stockTypes) {
									String selectedIcon = selectedImage.get(stockTTO.getId());
									String unSelectedIcon = unselectedImage.get(stockTTO.getId());
									%>
									if(object.idStockT == <%=stockTTO.getId()%>) {
										pointCollection = createPointsCollection(<%="\"" + unSelectedIcon+"\""%>,<%="\"" + selectedIcon+"\""%>);
									}
									<%}	%>
									pointCollections[object.idStockT] = pointCollection;
									if(typeof pointCollections.objectlist == "undefined") {
										pointCollections.objectlist  = [];
									}
									pointCollections.objectlist.push(pointCollection);
									return pointCollection;
								} else {
									return pointCollection;
								}
							};
							var pointCollections = [];
							addPoints(data, getPointCollection, pointCollections, displayInfo, infoDataCallback);
				}
			</script>

			<div class="big-row">
				<div class="large-12 columns filterHeader">
					<div class="big-row">
						<div class="large-12 columns">
							<h4><i class="fi-filter colorHeading"></i> Filters</h4>
						</div>
					</div>
					<div class="medium-3 columns">
						<label><s:text name="webportal.stock.domain"/></label>
						<select id="filter-multiselect-domain" onchange="onChangeDomain()" class="custom-multi-select" name="filter-multiselect-domain" multiple="multiple">
						</select>
					</div>
					<div class="medium-3 columns">
						<label><s:text name="webportal.stock.category.stocksite"/></label>
						<select id="filter-multiselect-stock-site" class="custom-multi-select" name="multiselect-domain" multiple="multiple">
						</select>
					</div>
					<div class="medium-3 columns">
						<label><s:text name="webportal.stock.category.devicemodel"/></label>
						<select id="filter-multiselect-device-model" class="custom-multi-select" name="multiselect-area" multiple="multiple">
						</select>
					</div>
					<div class="medium-3 columns">
						<label><s:text name="webportal.stock.category.devicetype"/></label>
						<select id="filter-multiselect-device-type" class="custom-multi-select" name="multiselect-alarm-type" multiple="multiple">
						</select>
					</div>

					<div>
						<div class="large-12 columns text-center">
							<a href="javascript:submitLogistics();" id="filter-button-update" class="button small">
								<s:text name="webportal.stock.updatebutton"/>
							</a>
						</div>
					</div>
				</div><!-- end of filter panel -->
			</div>

			<div class="big-row">
				<div class="large-10 columns">
					<div class="big-row">
					<div class="large-12 columns">
							<ul class="page-name-heading sub-menu">
								<span>STOCK MANAGEMENT</span>
								<li class="progress-chart-li active"><i class="icon-shipping"></i> From Supplier</li>
								<li class="status-chart"><i class="icon-cube"></i> In Stock</li>
								<li class="details-chart"><i class="icon-layout5"></i> On Pallet</li>
							</ul>
					</div>
					</div>
					<div class="big-row">
						<div class="large-6 columns">
							<div class="panel-outer">
								<h4 class="panel-heading"><i class="fi-marker size-24 colorHeading"></i><span> On pallet</span></h4>
								<div class="panel-inner">
									<div style="width: 100%; height: 550px; opacity:0.99;" id="map-wrapper" ></div>
								</div>
							</div>
						</div>
						<div class="large-6 columns">
							<div class="panel-outer">
								<h4 class="panel-heading"><i class="fi-graph-bar size-24 colorHeading"></i><span> Device type</span></h4>
								<div class="panel-inner">
									<div class="row">
										<div class="large-12 columns" id="on-pallet-chart-view">
										</div>
									</div>
									<div class="row">
										<div class="large-6 medium-6 columns">
											<span><s:text name="webportal.stock.entityshowninchart"/></span>
											<div>
												<select id="block-on-pallet-select-entity-shown" onchange="onChangeEntity()">
												</select>
											</div>
										</div>

										<div class="large-6 medium-6 columns">
											<span><s:text name="webportal.stock.divideentityby"/></span>
											<div>
												<select id="block-on-pallet-select-divide-entity">
												</select>
											</div>
										</div>

										<div class="large-12 columns">
											<a href="javascript:submitLogistics();" id="chart-legend-button-update" class="button">
												<s:text name="webportal.stock.updatebutton"/>
											</a>
										</div>
										</div><!-- end of chart-filter -->
									</div><!-- end of chart-filter row -->
								</div>
							</div>
						</div>
					</div>
				</div>

				<div class="large-2 columns filtered show-for-large-up">
					<h5 class="text-center">YOU HAVE FILTERED</h5>
					<dl class="accordion" data-accordion>
						<dd id="selected-domain">
							<a>Domain<span class="round label"></span></a>
							<div id="panel1" class="content">
								<ul></ul>
							</div>
						</dd>

						<dd id="selected-stocksite">
							<a>Stocksite <span class="round label"></span></a>
							<div class="content">
								<ul></ul>
							</div>
						</dd>

						<dd id="device-model">
							<a>Device model <span class="round label"></span></a>
							<div class="content">
								<ul></ul>
							</div>
						</dd>

						<dd id="device-type">
							<a>Device type <span class="round label"></span></a>
							<div class="content">
								<ul></ul>
							</div>
						</dd>

					</dl>
				</div>
			</div>

			<div class="wrapper-blur"></div>

		</div><!-- end of wrapper -->

	<!--[if lt IE 9]>
	<script type="text/javascript" src="https://raw.githubusercontent.com/chuckcarpenter/REM-unit-polyfill/master/js/rem.min.js"></script>
	<![endif]-->
	</body>
	<script>
		function onChangeEntity()
		{
			var optionStr = "<option value='N'><s:text name='webportal.stock.breakup.none'/></option>"
			+"<option value='M'><s:text name='webportal.stock.category.devicemodel'/></option>"
			+"<option value='UT'><s:text name='webportal.stock.category.devicetype'/></option>"
			+"<option value='US'><s:text name='webportal.stock.category.status'/></option>"
			+"<option value='W'><s:text name='webportal.stock.category.stocksite'/></option>";


			var fromSupplierOptions = "<option value='N'><s:text name='webportal.stock.breakup.none'/></option>"
			+"<option value='M'><s:text name='webportal.stock.category.devicemodel'/></option>"
			+"<option value='UT'><s:text name='webportal.stock.category.devicetype'/></option>"
			+"<option value='US'><s:text name='webportal.stock.category.status'/></option>";

			$("#block-on-pallet-select-divide-entity").html('');


			if(deviceStatus == "fromSupplier"){
				$("#block-on-pallet-select-divide-entity").html(fromSupplierOptions);
			}else{
				$("#block-on-pallet-select-divide-entity").html(optionStr);
			}

			var ls_entity = $("#block-on-pallet-select-entity-shown").val();
			$("#block-on-pallet-select-divide-entity > option ").each(function()
			{
				if($(this.val==ls_entity))
				{
					$("#block-on-pallet-select-divide-entity option[value=" + ls_entity + "]").remove();
				}
			});
		}
	</script>
	<script src="<%=request.getContextPath()%>/js/highchart/stock-management-chart.js"></script>
</html>
