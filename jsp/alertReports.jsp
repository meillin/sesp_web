<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="java.sql.*"%>
<%@page import="java.util.*, java.text.*" %>
<%@page import="com.capgemini.sesp.ast_sep.webclient.util.*"%>
<%@page import="com.capgemini.sesp.ast_sep.webclient.util.to.*"%>
<%@page import="com.capgemini.sesp.ast_sep.webclient.util.DBConnection"%>
<%@page import="com.capgemini.sesp.ast_sep.webclient.service.*" %>
<%@page import="com.skvader.rsp.cft.webservice_client.service.provider.*" %>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta http-equiv="CACHE-CONTROL" content="NO-CACHE" />
<title><s:text name="webportal.head.title"/></title>
<%
	//Connect ion con = DBConnection.getConnection();
	//List<UnitEventTTO> unitEventTypes = ServiceClass.getUnitEventTypes(con);
	AlertService alertService = ServiceProvider.getInstance().getService(AlertService.class);
	List<UnitEventTTO> unitEventTypes = alertService.getEventTypes();
	Map<Long, String> selectedImage = new HashMap<Long, String>();
	Map<Long, String> unselectedImage = new HashMap<Long, String>();
	String[] symbols = new String[] {"blue","green","orange","pink","purple","red","yellow"};

	int symbolCounter = 0;
	for(UnitEventTTO unitEventTTO : unitEventTypes) {
		unselectedImage.put(unitEventTTO.getId(), ((HttpServletRequest)pageContext.getRequest()).getContextPath() + "/images/silk/bullet_" + symbols[symbolCounter%symbols.length] + ".png");
		selectedImage.put(unitEventTTO.getId(),  ((HttpServletRequest)pageContext.getRequest()).getContextPath() + "/images/silk/flag_" +symbols[symbolCounter%symbols.length] + ".png");
		symbolCounter++;
	}
%>

<link href="<%=request.getContextPath()%>/styles/stock_style.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath()%>/styles/application-styles-min.css" rel="stylesheet" />
<link href="<%=request.getContextPath()%>/styles/jquery/jquery.ui.all.css" rel="stylesheet" type="text/css" />
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<script src="<%=request.getContextPath()%>/js/jquery.min.js"></script>
<script src="<%=request.getContextPath()%>/js/global-scripts-min.js"></script>
<script src="<%=request.getContextPath()%>/js/jquery.selectBox.js"></script>
<script src="<%=request.getContextPath()%>/js/jquery.jqtransform.js"></script>
<script src="<%=request.getContextPath()%>/js/jquery.ui.core.js"></script>
<script src="<%=request.getContextPath()%>/js/jquery.ui.datepicker.js"></script>

<script src="<%=request.getContextPath()%>/js/application-scripts-min.js"></script>
<link rel="stylesheet" href="<%=request.getContextPath()%>/styles/style.tidy.css" type="text/css" />
<script src="<%=request.getContextPath()%>/js/OpenLayers.js"></script>
<script src="<%=request.getContextPath()%>/js/map.js"></script>
<script src="<%=request.getContextPath()%>/js/sesp_alert.js"></script>
<script src="<%=request.getContextPath()%>/js/sesp_ajax.js"></script>
<script src="<%=request.getContextPath()%>/js/fusioncharts/charts/FusionCharts.js"></script>
<script src="<%=request.getContextPath()%>/js/spin.js"></script>
<script src="<%=request.getContextPath()%>/js/ajax-loader.js"></script>
<script type ="text/javascript">
    $(document).ready(function(){
        $('.head').click(function(e){
            e.preventDefault();
            $(this).closest('li').find('.contentMT').slideToggle();
        });
    });

    contextPath = "<%=request.getContextPath()%>";

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

    		function displayInfo(id) {
   				//alert(id);
   			}

   			function loadPoints(idDomain, from, to, idAreaT, idArea, idUnitCommT, idUnitModel, idInstMepUtilityT) {
   				$.get(
   					"<%=request.getContextPath()%>/jsp/alert-management-get-data.jsp?rt=getMapPoints" +
   							"&domainCode=" + idDomain +
   							"&areaTypeCode=" + idAreaT +
   							"&areaCode=" + idArea +
   							"&commTypeCode=" + idUnitCommT +
   							"&deviceModelCode=" + idUnitModel +
   							"&utilityCode=" + idInstMepUtilityT +
   							"&from=" + from +
   							"&to=" + to
   						,function(data) {
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
   					}
   				);

   				//Get all the new areas in the map
				var obj= {};
			    obj.url=contextPath+"/std/AlertManagementMapAreas.action";
			    obj.pdata = "domainCode="+idDomain+"&areaTypeCode="+idAreaT;
			 	obj.successfunc = createAreaJSON;
			    obj.errorfunc = errorAlarmDetails;
				run_ajax(obj);
			    //return;

   			}

   			function onChangeData()
   	   		{
   	   			var ls_domain = $("#domains").val();
   	   			var ls_areatype = $("#areatypes").val();
   	   			getDeviceModels(ls_domain);
   	   			getAreas(ls_domain, ls_areatype);
   	   		}

   			function onLoadSpecial() {
   			 $('#loadFromDate').datepicker({
	    			//dateFormat: 'DD, MM dd, yy',
	    			dateFormat: 'yymmdd',
	    			showOn: "button",
	    			buttonImage: "<%=request.getContextPath()%>/images/calendar.gif",
	    			buttonImageOnly: true
	    			});
	            $('#loadToDate').datepicker({
	    			//dateFormat: 'DD, MM dd, yy',
	    			dateFormat: 'yymmdd',
	    			showOn: "button",
	    			buttonImage: "<%=request.getContextPath()%>/images/calendar.gif",
	    			buttonImageOnly: true
	    			});
   	   				getDomains();
   	   				getAreaTypes();
   	   				getEventTypes();
   	   				getUtilityTypes();
   	   				getUnitCommTypes();
   	   				getDeviceModels(null);
                    getAreas(null,null);
					init("<%=request.getSession().getAttribute("MAP_SERVER_URL")%>");
					loadUnitEvents();
				}

   		function submitAlert()  		{
	   		var ls_domain = $("#domains").val();
	   		var ls_areatypes = $("#areatypes").val();
	   		var ls_areas = $("#areas").val();
	   		var ls_eventtypes = $("#eventtypes").val();
	   		var ls_utilitytypes = $("#utilitytypes").val();
	   		var ls_unitCommTypes = $("#unitCommTypes").val();
	   		var ls_devicemodels = $("#DeviceModels").val();
	   		var ls_breakup = $('input:radio[name=breakup]:checked').val();
	   		var ls_fromdate = $("#loadFromDate").val();
	   		var ls_todate = $("#loadToDate").val();
	   		if (ls_fromdate =="") {
		   		alert(i18nerrorEnterValidPeriod);
		   		return;
	   		}

	   		if (ls_todate =="") {
		   		alert(i18nerrorEnterValidPeriod);
		   		return;
	   		}

	   		if (ls_areatypes =="null") {
		   		alert(i18nerrorAreaTypeRequired);
		   		return;
	   		}

	   		$('#graph').attr('src', '');

	   		$.getJSON('/ast_sep_webportal/jsp/generate-graph.jsp?domain='+ls_domain+
	   		   		'&areatypes='+ls_areatypes+'&areas='+ls_areas+'&eventtypes='+ls_eventtypes+
	   		   		'&utilitytypes='+ls_utilitytypes+'&unitcommtypes='+ls_unitCommTypes+
	   		   		'&devicemodels='+ls_devicemodels+'&yaxis='+ls_breakup+'&loadFromDate='+ls_fromdate+
	   		   		'&loadToDate='+ls_todate+'&frmsrc=Alarm'
	   		   		, function(data) {
	   		 $('#graph').attr('src', '/ast_sep_webportal/Alarm/index.html');
	        	});

	   		loadPoints(ls_domain, ls_fromdate, ls_todate, ls_areatypes, ls_areas, ls_unitCommTypes, ls_devicemodels, ls_utilitytypes);

   		}

   		function onSubmit()
   		{
   			var ls_domain = $("#domains").val();
   			var ls_areatypes = $("#areatypes").val();
   			var ls_areas = $("#areas").val();
   			var ls_eventtypes = $("#eventtypes").val();
   			var ls_utilitytypes = $("#utilitytypes").val();
   			var ls_unitCommTypes = $("#unitCommTypes").val();
   			var ls_devicemodels = $("#DeviceModels").val();
   			var ls_breakup = $('input:radio[name=breakup]:checked').val();
   			var ls_fromdate = $("#loadFromDate").val();
   			var ls_todate = $("#loadToDate").val();
   		    chartType=ls_breakup;

   			if (ls_fromdate =='') {
   		   	alert(i18nerrorEnterValidPeriod);
   		   	return;
   			}

   			if (ls_todate =='') {
   		   	alert(i18nerrorEnterValidPeriod);
   		   	return;
   			}

   			if(ls_domain == 'null')
   			{
   			alert(i18nerrorDomainRequired);
   			return;
   			}

   			if (ls_areatypes =='null') {
   		   	alert(i18nerrorAreaTypeRequired);
   		   	return;
   			}

   			if(ls_breakup =="E" && (ls_areas=='all' || ls_areas =='null') )
   			{
   			alert(i18nerrorSelectArea);
   			return;
   			}

   			if(ls_breakup =="A" && ls_areas=='null')
   			{
   			alert(i18nerrorSelectArea);
   			return;
   			}

   			if(ls_breakup =="A" && ls_eventtypes=='null')
   			{
   			alert(i18nerrorSelectEvent);
   			return;
   			}


   			if(ls_breakup =="AE" && (ls_areas=='all' || ls_areas =='null'))
   			{
   			alert(i18nerrorSelectArea);
   			return;
   			}

   			if(ls_breakup =="AE" && (ls_eventtypes =='all' || ls_eventtypes == 'null'))
   			{
   			alert(i18nerrorSelectEventType);
   			return;
   			}

   			//loadPoints(ls_domain, ls_fromdate, ls_todate, ls_areatypes, ls_areas, ls_unitCommTypes, ls_devicemodels, ls_utilitytypes);

   			var obj= {};
   			obj.url=contextPath+"/std/AlertManagementChart.action";
   			obj.pdata = "loadFromDate="+ls_fromdate+"&loadToDate="+ls_todate+"&domains="+ls_domain+"&areatypes="+ls_areatypes+"+&areas="+ls_areas+"&eventtypes="+ls_eventtypes+"&utilitytypes="+ls_utilitytypes+"&unitCommTypes="+ls_unitCommTypes+"&DeviceModels="+ls_devicemodels+"&breakup="+ls_breakup;// post variable data
   			obj.successfunc = drawChart;
   			obj.errorfunc = errorAlarmDetails;
   			run_ajax(obj);
   			return;

   			}
   		</script>
</head>
<body class="pagebg" onload="onLoadSpecial()">

<div id="wrapper">
<%@ include file="header.inc"%>


<div id="middlecontainer">
<div class="headSearch">
<h2 class="mainHead"><s:text name="webportal.alert.header"/></h2>
</div>

<div id="content_1">
	<!-- tab start here -->
	<form name="alertForm" method="get" action="/ast_sep_webportal/AlertServlet" >
    <div id="formLogistic">
	<table width="100%" border="0" cellspacing="1" cellpadding="5">
	<tr>
    <td>
    <input type="text"  name="loadFromDate" id="loadFromDate" class="text ui-widget-content ui-corner-all"></input> <font color="red">*</font> </td>
    <td>
    <input type="text"  name="loadToDate" id="loadToDate" class="text ui-widget-content ui-corner-all"></input><font color="red">*</font></td>
    <td><select name="domains" id="domains" onchange="onChangeData()"></select></td>
    	<td>	<select name="areatypes" id="areatypes" onchange="onChangeData()"></select><font color="red">*</font></td>
    <td valign="top"> </td>
	</tr>

    <tr>
		<td><select name="areas" id="areas"></select></td>
		<td><select name="eventtypes" id="eventtypes"></select></td>
    	<td><select name="utilitytypes" id="utilitytypes"></select></td>
    	</tr>
    	<tr>
    	<td><select name="unitCommTypes" id="unitCommTypes"></select></td>
    	<td><select name="DeviceModels" id="DeviceModels"></select></td>
    	<td><div class="suboptioncheckbox alertbreakup">

            <input type="radio" name="breakup" value="A" checked="checked" /><s:text name="webportal.alert.breakup.area"/>&nbsp;
            <input type="radio" name="breakup" value="E"/><s:text name="webportal.alert.breakup.event"/>&nbsp;
            <input type="radio" name="breakup" value="AE"/><s:text name="webportal.alert.breakup.areaneventbydate"/>

		</div></td>
          <td><a href="javascript:onSubmit()"><img title="<s:text name='webportal.reports.viewgraph_tooltip'/>" src="<%=request.getContextPath()%>/images/viewgraph.png" alt="<s:text name='webportal.reports.viewgraph_tooltip'/>" border="0"/></a></td>
      </tr>
      </table>   </div>
	  </form>

	  </div>
	  <div class="column1ME">
	  <div id="basicMap" style="width: 430px; height: 445px; border: 1px solid #ccc;"></div>
	  <div class="mapindicationDetails" style="width: 430px; height =200; border: 2px solid;">
			<%for(UnitEventTTO unitEventTTO : unitEventTypes) {%>
						        				<img src="<%=unselectedImage.get(unitEventTTO.getId())%>"/>
						        				<img src="<%=selectedImage.get(unitEventTTO.getId())%>"/>
						        				<span>
							        				<%=unitEventTTO.getName()%>
							        			</span>
							        			<%
						        			}
						        		%>
	</div>
	</div>
	<div class="column1ME">
	<div class="graphLogistics">
	<!-- <iframe id="graph" src="" height="513" width="511" scrolling="no" frameborder="0" ></iframe>  -->
	 <div id="alertchartdiv"></div>
	</div> </div>
</div>


<%@ include file="footer.inc"%>
</div>

</body>
</html>
