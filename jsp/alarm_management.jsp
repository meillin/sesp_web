<!DOCTYPE html>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@page import="java.util.*,java.text.*" %>
<%@page import="com.capgemini.sesp.ast_sep.webclient.util.*"%>
<%@page import="com.capgemini.sesp.ast_sep.webclient.util.to.*"%>
<%@page import="com.skvader.rsp.cft.webservice_client.service.provider.ServiceProvider" %>
<%@page import="com.capgemini.sesp.ast_sep.webclient.service.AlertService"%>
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
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/styles/content-alarm-management.css" />
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/styles/style.tidy.css" />
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/styles/bubble-map.css"/>
		
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-1.9.1.min.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-migrate-1.1.1.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-ui-1.10.2.custom.js"></script>		
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.selectBox.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/bootstrap-datepicker.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.multiselect.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/colResizable-1.3.min.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/init.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/sesp_ajax.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/search-results.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/alarm-management.js"></script>		
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/fusionchartsxt/charts/FusionCharts.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/OpenLayers.js"></script>
		
		<script src="<%=request.getContextPath()%>/js/map.js"></script>
		<script src="<%=request.getContextPath()%>/js/spin.js"></script>
		<script src="<%=request.getContextPath()%>/js/ajax-loader.js"></script>
		
	</head>	
	<body onload="populateFilters(),getdaterange(),initmap('<%=request.getSession().getAttribute("MAP_SERVER_URL")%>')">	
	
	<%
	AlertService alertService = ServiceProvider.getInstance().getService(AlertService.class);
	List<UnitEventTTO> unitEventTypes = alertService.getEventTypes(null);
	Map<Long, String> selectedImage = new HashMap<Long, String>();
	Map<Long, String> unselectedImage = new HashMap<Long, String>();
	//String[] symbols = new String[] {"blue","green","orange","pink","purple","red","yellow"};
	String[] symbols = new String[] {"blue","red","green","purple","yellow","pink","ltblue"};
	
	int imageCount = 1;
	int symbolCounter = 0;
	String imagePath = null;
	
	for(UnitEventTTO unitEventTTO : unitEventTypes) {
		
		//unselectedImage.put(unitEventTTO.getId(), ((HttpServletRequest)pageContext.getRequest()).getContextPath() + "/images/marker-icon-blue.png");
		//selectedImage.put(unitEventTTO.getId(),  ((HttpServletRequest)pageContext.getRequest()).getContextPath() + "/images/marker-icon-blue.png");
		
		switch(imageCount){
		case 1:
			imagePath = "/images/marker-icon-blue-dot.png";		
			break;
		
		case 2:
			imagePath = "/images/marker-icon-red-dot.png";
			break;
		
		case 3:
			imagePath = "/images/marker-icon-green-dot.png";
			break;
		
		case 4:
			imagePath = "/images/marker-icon-purple-dot.png";
			break;
		
		case 5:
			imagePath = "/images/marker-icon-yellow-dot.png";
			break;
		
		case 6:
			imagePath = "/images/marker-icon-pink-dot.png";
			break;
		
		case 7:
			imagePath = "/images/marker-icon-ltblue-dot.png";
			break;
		
		default:
			imagePath = "/images/marker-icon-blue-dot.png";
			break;
		}
		
		unselectedImage.put(unitEventTTO.getId(), ((HttpServletRequest)pageContext.getRequest()).getContextPath() + imagePath);
		selectedImage.put(unitEventTTO.getId(),  ((HttpServletRequest)pageContext.getRequest()).getContextPath() + imagePath);
		
		imageCount = imageCount >= 7 ? 1 : ++imageCount ;
		
		
		symbolCounter++;	
	}	
	%>
	<script>
        contextPath = "<%=request.getContextPath()%>";
        mapServerUrl= "<%=application.getAttribute("MAP_SERVER_URL")%>";
        isAjaxSearch = false;  

        i18nMeasurePoint="<s:text name='webportal.alert.measurepoint'/>";
        i18nStart="<s:text name='webportal.alert.start'/>";
        i18nEnd="<s:text name='webportal.alert.end'/>";
        i18nEventType="<s:text name='webportal.alert.eventtype'/>";
        i18nDeviceModel="<s:text name='webportal.alert.devicemodel'/>";
        i18nSelectDomain="<s:text name='webportal.alert.selectdomain'/>";
        i18nSelectAreaType="<s:text name='webportal.alert.selectareatype'/>";
        i18nSelectArea="<s:text name='webportal.alert.selectarea'/>";
        i18nSelectEventType="<s:text name='webportal.alert.selecteventtype'/>";
        i18nSelectUtilityType="<s:text name='webportal.alert.selectutilitytype'/>";
        i18nSelectCommType="<s:text name='webportal.alert.selectcommtype'/>";
        i18nSelectDeviceModel="<s:text name='webportal.alert.selectdevicemodel'/>";
        i18nAll="<s:text name='webportal.alert.all'/>";
        i18nerrorEnterValidPeriod="<s:text name='webportal.error.enterperiod'/>";
        i18nerrorAreaTypeRequired="<s:text name='webportal.error.chooseareatype'/>";
        i18nerrorDomainRequired="<s:text name='webportal.error.choosedomain'/>";
        i18nerrorSelectArea="<s:text name='webportal.error.selectarea'/>";
        i18nerrorSelectEvent="<s:text name='webportal.error.selectevent'/>";
        i18nerrorSelectEventType="<s:text name='webportal.error.selecteventtype'/>";
        i18nerrorChartError="<s:text name='webportal.error.nodataavailable'/>";

        function loadPoints(domain, from, to, areaT, area, unitCommT, unitModel, InstMepUtilityT, dateInterval, alarmTypes)
        {
        	var obj= {};
			obj.url=contextPath+"/std/AlarmManagementMapPoints.action";
			obj.pdata = "domain="+domain+"&alarmfromdate="+from+"&alarmtodate="+to+"&areatypes="+areaT+"&commtypes="+unitCommT+"&devicemodels="+unitModel+"&utilitytypes="+InstMepUtilityT+"&dateinterval="+dateInterval+"&alarmTypes="+alarmTypes;
			obj.successfunc = loadPointsSuccess;
			obj.errorfunc = errorAlarmDetails;
			run_ajax(obj);
			return;
        }

        function displayInfo(id) {
				//alert(id);
			}

		function resetMapNChart(data) {
			$("#map-wrapper").html('');
			initmap('<%=request.getSession().getAttribute("MAP_SERVER_URL")%>');
			$("#block-alarm-charts-view").html('');
			alert(i18nerrorChartError);
		}

        function loadPointsSuccess(data) {
			//var data1 = eval(data);
        	function getPointCollection(object, pointCollections) {
					var pointCollection = pointCollections[object.idUnitEventT];
					if(typeof pointCollection == "undefined") {
						<%
							for(UnitEventTTO unitEventTTO : unitEventTypes) {
								String selectedIcon = selectedImage.get(unitEventTTO.getId());
								String unSelectedIcon = unselectedImage.get(unitEventTTO.getId());
						%>
								if(object.idUnitEventT == <%=unitEventTTO.getId()%>) {
									pointCollection = createPointsCollection(
   		   										<%="\"" + unSelectedIcon+"\""%>, 
   		   										<%="\"" + selectedIcon+"\""%>
		   							);
								}
						<%
							}
						%>
						pointCollections[object.idUnitEventT] = pointCollection;
						if(typeof pointCollections.objectlist == "undefined") {
							pointCollections.objectlist  = [];
						}
						pointCollections.objectlist.push(pointCollection);
						return pointCollection;					 
					} else {
						return pointCollection;
					}
				}
			
				var pointCollections = [];
				addPoints(data, getPointCollection, pointCollections, displayInfo, infoDataCallback);
		  		//alert("PointData:\r\n" + data);
		  		
		  		var al_domain = $("#domains").val()==null ? null:$("#domains").val().join(",");	
				var al_areatypes = $("#areaTypes").val()==null ? null:$("#areaTypes").val().join(",");	

		  		//Get all the new areas in the map
				var obj= {};
			    obj.url=contextPath+"/std/AlarmManagementMapAreas.action";   				
			    obj.pdata = "domains="+al_domain+"&areatypes="+al_areatypes;
			 	obj.successfunc = createAreaJSON;
			    obj.errorfunc = errorAlarmDetails;
				run_ajax(obj);
			    //return;
			}
                
    </script>

		<div id="wrapper">
			
			<%@ include file="headerv311.inc"%>	
			
			<div id="main-content">

				<div class="large-block block" id="block-alarm-map">
					
					<div class="content-wrapper full-height">
						<div class="content text-grey">
							<div style = "height:660px;width:930px;opacity:0.99;" id="map-wrapper">
								 <!-- <iframe width="930" height="660" frameborder="0" scrolling="no" marginheight="0" marginwidth="0" src="http://www.openstreetmap.org/export/embed.html?bbox=-1.55302,47.19581,-1.50817,47.22307&amp;layer=mapnik&amp;marker=47.21659,-1.53457"></iframe>  
							 --> </div> 
							<div class="block inside-small-block retractable map-filter">
								<div class="block-title">
									<span class="block-title-picto"></span>
									<span class="block-title-name text-blue"><s:text name="webportal.alarm.filters"/></span>
									<span class="block-arrow open"></span>
								</div>
								<div class="content-wrapper">
									<div class="content text-grey">		
									
									<div class="select-wrapper">
											<span class="select-title text-grey"><s:text name="webportal.alarm.domain"/></span>
											<div class="custom-select">
											<select id="domains" onchange="onChangeData()" class="custom-multi-select" name="multiselect-domain" multiple="multiple">													
											</select>
											</div>
										</div>								
										
										<div class="select-wrapper">
											<span class="select-title text-grey"><s:text name="webportal.alarm.dateinterval"/></span>
											<div class="custom-select">
												<select id="filter-select-date-interval" onchange="javascript:getdaterange();">
													<option value="lastweek" selected="selected"><s:text name="webportal.alarm.dateinterval.lastweek"/></option>
													<option value="today"><s:text name="webportal.alarm.dateinterval.today"/></option>													
													<option value="lastmonth"><s:text name="webportal.alarm.dateinterval.lastmonth"/></option>
													<option value="lastquarter"><s:text name="webportal.alarm.dateinterval.lastquarter"/></option>
													<option value="lastyear"><s:text name="webportal.alarm.dateinterval.lastyear"/></option>
													<option value="custominterval"><s:text name="webportal.alarm.dateinterval.custominterval"/></option>
												</select>
											</div>
										</div>
										<div class="select-wrapper">
											<table>
										 <tr>
											<td>
												<div class="small-select-wrapper left-select">
													<span class="select-title text-red" id="fromlabel"><s:text name="webportal.alarm.from"/>:</span>
													<div class="custom-input-datepicker input-append date" data-date="2012-02-12" data-date-format="yyyy-mm-dd">
														<input id="filter-date-from" type="text" class="input-datepicker text-red"  readonly="readonly"/>
													</div>
												</div>
											</td>
											<td>
												<div class="small-select-wrapper right-select">
													<span class="select-title text-red" id="tolabel"><s:text name="webportal.alarm.to"/>:</span>
													<div class="custom-input-datepicker input-append date"  data-date="12-02-2012" data-date-format="yyyy-mm-dd">
														<input id="filter-date-to" type="text" class="input-datepicker text-red"  readonly="readonly"/>
													</div>
												</div>
											</td>
										 </tr>
										</table>
										</div>
										<div class="select-wrapper">
											<span class="select-title text-grey"><s:text name="webportal.alarm.areatype"/></span>
											<div class="custom-select">
												<select id="areaTypes" onchange="onChangeData()" class="custom-multi-select" name="multiselect-area-type" multiple="multiple">													
												</select>
											</div>
										</div>										
										<div class="select-wrapper">
											<span class="select-title text-grey"><s:text name="webportal.alarm.area"/></span>
											<div class="custom-select">
												<select id="areas" class="custom-multi-select" name="multiselect-area" multiple="multiple">													
												</select>
											</div>
										</div>
										<div class="select-wrapper">
											<span class="select-title text-grey"><s:text name="webportal.alarm.alarmtype"/></span>
											<div class="custom-select">
												<select id="alarmTypes" class="custom-multi-select" name="multiselect-alarm-type" multiple="multiple">													
												</select>
											</div>
										</div>
										<div class="select-wrapper">
											<span class="select-title text-grey"><s:text name="webportal.alarm.utilitytype"/></span>
											<div class="custom-select">
												<select id="utilitytypes" class="custom-multi-select" name="multiselect-utility-type" multiple="multiple">													
												</select>
											</div>
										</div>
										<div class="select-wrapper">
											<span class="select-title text-grey"><s:text name="webportal.alarm.communicationtype"/></span>
											<div class="custom-select">
												<select id="commtypes" class="custom-multi-select" name="multiselect-communication-type" multiple="multiple">
													
												</select>
											</div>
										</div>
										<div class="select-wrapper">
											<span class="select-title text-grey"><s:text name="webportal.alarm.devicemodel"/></span>
											<div class="custom-select text-grey">
												<select id="devicemodels" class="custom-multi-select" name="multiselect-device-model" multiple="multiple">													
												</select>
											</div>
										</div>
										
										<div class="button-wrapper">
											<a href="javascript:onSubmit();" id="filter-button-update" class="text-blue custom-button" ><s:text name="webportal.alarm.update"/></a>						
										</div>					
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				
				<div class="large-block block retractable" id="block-alarm-charts">
					<div class="block-title">
						<span class="block-title-picto"></span>
						<span class="block-title-name text-blue"><s:text name="webportal.alarm.alarms"/></span>
						<span class="block-arrow open"></span>
					</div>
					<div class="content-wrapper">
						<div class="content text-grey">
							<div id="block-alarm-charts-title">								
							</div>
							<div id="block-alarm-charts-period" class="text-light-grey">
								
							</div>
							<div id="block-alarm-charts-view">
								
							</div>
							<div id="block-alarm-charts-groupBy">
								<s:text name="webportal.alarm.groupchartby"/>
							</div>
							<div id="block-alarm-charts-radioBox" class="text-light-grey">
								<form id="chart-form">
									<input id="block-alarm-charts-radio-area" type="radio" name="block-alarm-charts-radio" value="A" checked="checked" onclick="getChartTitle(this.value); onSubmit();">
									<label for="block-alarm-charts-radio-area" class="radio-legend legend1"><s:text name="webportal.alarm.area"/></label>
									<input id="block-alarm-charts-radio-alarm-type" type="radio" name="block-alarm-charts-radio" value="E" onclick="getChartTitle(this.value); onSubmit();">
									<label for="block-alarm-charts-radio-alarm-type" class="radio-legend legend2"><s:text name="webportal.alarm.alarmtype"/></label>
								</form>
							</div>							
						</div>
					</div>
				</div>

			</div>
			<%@ include file="footerv311.inc"%>
		</div>
		<script>		
		getChartTitle("A");
		</script>
		
	</body>
</html>