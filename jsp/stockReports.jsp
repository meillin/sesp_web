<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@page import="java.sql.*"%>
<%@page import="java.util.*,java.text.*"%>
<%@page import="com.capgemini.sesp.ast_sep.webclient.util.*"%>
<%@page import="com.capgemini.sesp.ast_sep.webclient.util.to.*"%>
<%@page import="com.capgemini.sesp.ast_sep.webclient.util.DBConnection"%>
<%@page import="com.skvader.rsp.cft.webservice_client.service.provider.ServiceProvider" %>
<%@page import="com.capgemini.sesp.ast_sep.webclient.service.StockService"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>  
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta http-equiv="CACHE-CONTROL" content="NO-CACHE" />
<title><s:text name="webportal.head.title"/></title>
<link href="<%=request.getContextPath()%>/styles/style.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath()%>/styles/application-styles-min.css" rel="stylesheet" />
<script src="<%=request.getContextPath()%>/js/jquery-1.8.2.min.js"></script>
<link rel="stylesheet" href="<%=request.getContextPath()%>/styles/style.tidy.css" type="text/css" />
<script src="<%=request.getContextPath()%>/js/OpenLayers.js"></script>
<script src="<%=request.getContextPath()%>/js/map.js"></script>
<script src="<%=request.getContextPath()%>/js/sesp_stock.js"></script>
<script src="<%=request.getContextPath()%>/js/sesp_ajax.js"></script>
<script src="<%=request.getContextPath()%>/js/fusioncharts/charts/FusionCharts.js"></script>
<script src="<%=request.getContextPath()%>/js/spin.js"></script>
<script src="<%=request.getContextPath()%>/js/ajax-loader.js"></script>
</head>
  
<% 	

	StockService stockService = ServiceProvider.getInstance().getService(StockService.class);	
	List<StockTTO> stockTypes = stockService.getStockTypes();
	Map<Long, String> selectedImage = new HashMap<Long, String>();
	Map<Long, String> unselectedImage = new HashMap<Long, String>();
	String[] symbols = new String[] {"blue","green","orange","pink","purple","red","yellow"};
	
	int symbolCounter = 0;
	for(StockTTO stockTTO : stockTypes) {
		unselectedImage.put(stockTTO.getId(), ((HttpServletRequest)pageContext.getRequest()).getContextPath() + "/images/silk/bullet_" + symbols[symbolCounter%symbols.length] + ".png");
		selectedImage.put(stockTTO.getId(),  ((HttpServletRequest)pageContext.getRequest()).getContextPath() + "/images/silk/flag_" +symbols[symbolCounter%symbols.length] + ".png");
		symbolCounter++;	
	}
	
%>
<script><!--
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
function loadPoints(domainCode) {
	
	var obj= {};
	obj.url=contextPath+"/std/GetStockMapPoints.action";
	obj.pdata = "dc="+domainCode;
	obj.successfunc = loadPointsSuccess;
	obj.errorfunc = errorDetails;
	run_ajax(obj);
	return;
					
}

function loadPointsSuccess(data) {
	//var data1 = eval(data);
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
		//alert("PointData:\r\n" + data);
	}

//function loadPoints(domainCode) {
//	$.get("<%=request.getContextPath()%>/std/GetStockMapPoints.action?dc=" + domainCode,
	//$.get("<%=request.getContextPath()%>/jsp/alert-management-get-data.jsp?rt=getStockPoints&domainCode=" + domainCode,
				
//		);
//	}
</script> 
<body class="pagebg" onload="onLoadSpecial(),init('<%=request.getSession().getAttribute("MAP_SERVER_URL")%>');">

<div id="wrapper"><%@ include file="header.inc"%>


<div id="middlecontainer">
<div class="headSearch">
<h2 class="mainHead"><s:text name="webportal.stock.header"/></h2>
</div>
<!-- tab start here -->
<div id="content_1">
<div id="formLogistic">
<form name="logisticsForm" method="get" action="/ast_sep_webclient/LogisticsServlet">
<table width="100%" border="0" cellspacing="1" cellpadding="5">
	<tr>
		<td><select name="domains" id="domains"	onchange="onChangeDomain()"></select> <font color="red">*</font></td>
		<td><select name="warehouses" id="warehouses"></select> <font color="red">*</font></td>
		<td><select name="devicemodels" id="devicemodels"></select></td>
		<td><select name="devicetypes" id="devicetypes"></select></td>
	</tr>
	<tr>
		<td colspan="4">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td style="width: auto">
				<table border="0" cellspacing="1" cellpadding="5">
					<tr>
						<td style="width: auto">
						<div class="suboptioncheckbox">
							<fieldset>
								<legend>&nbsp;<s:text name="webportal.stock.category"/>&nbsp; <font color="red">*</font></legend>								 
								<label><input name="category" type="radio" value="M" /><s:text name="webportal.stock.category.devicemodel"/></label>
							    <label><input name="category" type="radio" value="UT" /><s:text name="webportal.stock.category.devicetype"/> </label> 
							    <label><input name="category" type="radio" value="US" /><s:text name="webportal.stock.category.status"/></label> 
							    <label><input name="category" type="radio" value="W" /><s:text name="webportal.stock.category.stocksite"/></label>
							</fieldset>
						</div>
						</td>						
						
					</tr>
				</table>
				</td>
				<td rowspan="2" align="right">
					<a href="javascript:submitLogistics(document.logisticsForm)">
						<img title="<s:text name='webportal.reports.viewgraph_tooltip'/>" src="<%=request.getContextPath()%>/images/viewgraph.png" alt="<s:text name='webportal.reports.viewgraph_tooltip'/>" border="0" />
					</a>
				</td>
			</tr>
			<tr>
				<td>
				<table border="0" cellspacing="1" cellpadding="5">
					<tr>
						<td style="width: auto"> 
						<div class="suboptioncheckbox">
							<fieldset>
								<legend>&nbsp;<s:text name="webportal.stock.breakup"/>&nbsp; <font color="red">*</font></legend>								 
								<label name="M_T"><input type="radio" name="breakup" value="M" /><s:text name="webportal.stock.category.devicemodel"/> </label> 
								<label name="UT_T"><input type="radio" name="breakup" value="UT" /><s:text name="webportal.stock.category.devicetype"/> </label> 
								<label name="US_T"><input type="radio" name="breakup" value="US" /><s:text name="webportal.stock.category.status"/></label>
								<label name="W_T"><input type="radio" name="breakup" value="W" /><s:text name="webportal.stock.category.stocksite"/> </label>
								<label name="N_T"><input type="radio" name="breakup" value="N" /><s:text name="webportal.stock.breakup.none"/></label> 
								<label name="IE_T"><input type="radio" name="breakup" value="IE" /><s:text name="webportal.stock.breakup.inex"/></label>
							</fieldset>
						</div>
						</td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
</form>
</div>

<div class="column1ME toppadding">
<div id="basicMap"	style="width: 430px; height: 445px; border: 1px solid #ccc;"></div>
<div class="mapindicationDetails" style="width: 425px; height =200; border: 2px solid;">
<%for(StockTTO stockTTO : stockTypes) {%> 
<img src="<%=unselectedImage.get(stockTTO.getId())%>" />
<img src="<%=selectedImage.get(stockTTO.getId())%>" /> 
<span> <%=stockTTO.getName()%></span> 
<%}%>
</div>
</div>
<div class="column1ME">
	<div id="chartdiv">		
	</div>
</div>
</div>

</div>
<%@ include file="footer.inc"%>
</div>
</body>
</html>
