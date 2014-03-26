<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib prefix="s" uri="/struts-tags"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta http-equiv="CACHE-CONTROL" content="NO-CACHE" />
<title><s:text name="webportal.head.title"/></title>
<link href="<%=request.getContextPath()%>/styles/style.css" rel="stylesheet" type="text/css" />

<link href="<%=request.getContextPath()%>/styles/application-styles-min.css" rel="stylesheet"/>
<script src="<%=request.getContextPath()%>/js/jquery-1.8.2.min.js"></script>
<style>
	.checkbox-font{ font-size:10px}
	.nav {
		margin-bottom: 0px;
	}  
	.nav-tabs {
	border-bottom: 1px solid #D6E9C6;
	}
	
	.nav-tabs > li > a {
	border-color: #D6E9C6 #D6E9C6 #D6E9C6; 
	background-color: #bbe796;
	color: #468847;
	font-weight:bold;
	}
	
	.nav-tabs{padding-left:20px}
	
	.nav-tabs > li > a:hover {
	border-color: #D6E9C6 #D6E9C6 #D6E9C6;
	}
	.nav > li > a:hover {
	text-decoration: none;
	background-color: white;
	}
	
	.nav-tabs > .active > a, .nav-tabs > .active > a:hover {
	color: #468847;
	cursor: default;
	background-color: #D6E9C6;
	border: 1px solid #D6E9C6;
	border-bottom-color: transparent;
	}
	.search-box{color:#424242; font-weight:bold;}
	.tab-content{padding:0px 10px 10px 10px}
</style>
</head>

<body class="pagebg">

<div id="wrapper">
<%@ include file ="header.inc" %>
	
<div id="middlecontainer">

	<div class="reportslist">
		<div class="reportListicon">
			<ul>				
				<li class="iconConsumption"><a href="<%=request.getContextPath()%>/std/ConsumptionReports"><s:text name="webportal.menu.reports"/></a></li>
				<li class="iconStock"><a href="<%=request.getContextPath()%>/std/StockManagement"><s:text name="webportal.menu.stockmgmt"/></a></li>
				<li class="iconAlert"><a href="<%=request.getContextPath()%>/std/AlertManagementReports"><s:text name="webportal.menu.alertmgmt"/></a></li>
				<li class="iconSearch"><a href="<%=request.getContextPath()%>/std/ViewSearch">Search Results</a></li>
				<li class="iconSearch"><a href="<%=request.getContextPath()%>/std/ViewMeasurepointConsumptionReportAction?id=367">Measurepoint Consumption</a></li>
				<li class="iconSearch"><a href="<%=request.getContextPath()%>/std/AreaProgress">Area Progress</a></li>
				<li class="iconSearch"><a href="<%=request.getContextPath()%>/std/WorkOrderProgress">Work Order Progress</a></li>																	
				<!--<li class="iconSearch"><a href="<%=request.getContextPath()%>/std/ViewAnalyzeWorkOrder">Analyze Work Order</a></li>			
				--><!-- <li class="iconWorkorder">Work Order Status</li>
				<li class="iconperformance last">Performance Management</li>  -->
				<li class="iconConsumption"><a href="<%=request.getContextPath()%>/std/TimeReservationCallList">Time Reservation Call List</a></li>
			</ul>
		</div>
	</div>	

</div>
	
<%@ include file ="footer.inc" %>
</div>
</body>
</html>
