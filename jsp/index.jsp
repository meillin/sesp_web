<!DOCTYPE html>
<%@ taglib prefix="s" uri="/struts-tags"%>
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
		<%String contextPath = request.getContextPath(); %>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/styles/foundation.css" />
		<link rel="stylesheet" type="text/css" href="<%=contextPath%>/styles/general.css" />
		<link rel="stylesheet" type="text/css" href="<%=contextPath%>/styles/header.css" />
		<link rel="stylesheet" type="text/css" href="<%=contextPath%>/styles/content-block.css" />
		<link rel="stylesheet" type="text/css" href="<%=contextPath%>/styles/content-search-results.css" />
    <link rel="stylesheet" type="text/css" href="<%=contextPath%>/styles/hex2.css"> 
		<link rel="shortcut icon" type="image/png" href="<%=contextPath%>/js/images/favicon.png" />
		<link rel="shortcut icon" type="image/png" href="<%=contextPath%>/images/favicon.png" />		
		<link rel="stylesheet" type="text/css" href="<%=contextPath%>/styles/style.tidy.css" />
		<link rel="stylesheet" type="text/css" href="<%=contextPath%>/js/dhtmlxGrid/codebase/dhtmlxgrid.css" />
		
		<link rel="stylesheet" type="text/css" href="<%=contextPath%>/styles/jquery.multiselect.css"/>
		<link rel="stylesheet" type="text/css" href="<%=contextPath%>/styles/bubble-map.css"/>
		
		<script type="text/javascript" src="<%=contextPath%>/js/jquery-1.9.1.min.js"></script>
		<script type="text/javascript" src="<%=contextPath%>/js/jquery-migrate-1.1.1.js"></script>
		<script type="text/javascript" src="<%=contextPath%>/js/index-init.js"></script>
<%-- 		<script type="text/javascript" src="<%=contextPath%>/js/search-results.js"></script>
 --%>
    <script type="text/javascript" src="<%=contextPath%>/js/jquery-ui-1.10.2.custom.js"></script>		
		<script type="text/javascript" src="<%=contextPath%>/js/jquery.cookie.js"></script>		
		
		<script src="<%=contextPath%>/js/sesp_ajax.js"></script>
		<script src="<%=contextPath%>/js/spin.js"></script>
		<script src="<%=contextPath%>/js/ajax-loader.js"></script>


  <!--[if lt IE 9]>
  <script src="//cdnjs.cloudflare.com/ajax/libs/html5shiv/3.6.2/html5shiv.js"></script>
  <script src="//s3.amazonaws.com/nwapi/nwmatcher/nwmatcher-1.2.5-min.js"></script>
  <script src="//html5base.googlecode.com/svn-history/r38/trunk/js/selectivizr-1.0.3b.js"></script>
  <script src="//cdnjs.cloudflare.com/ajax/libs/respond.js/1.1.0/respond.min.js"></script>
  <![endif]-->
		
</head>
<body>
<div id="wrapper">
  <script>
    contextPath = "<%=request.getContextPath()%>";     
    isAjaxSearch = false;
    i18nerrorInvalidSearchInput = "<s:text name='webportal.search.results.error.invalidsearchinput'/>";
    i18nerrorInvalidSearchAction = "<s:text name='webportal.search.results.error.invalidsearchaction'/>";
    i18nerrorNoDataForSearch = "<s:text name='webportal.search.results.error.nosearchresults'/>";
  </script>

<%@ include file="headerv311.inc" %>

<div id="main-content-index">
  <div class="row">
    <div class="large-12 columns welcome-text text-center">
      Welcome to the dashboard
    </div>
  </div>

  <div class="row">
    <div class="large-12 columns">

     <ul class="small-block-grid-2 medium-block-grid-3 large-block-grid-4">

      <li>
        <div>
          <a class="patch" href="<%=contextPath%>/std/ViewResourceProjectionAction" alt="RESOURCE PROJECTIONS" title="RESOURCE PROJECTIONS">
            <img src="../images/chart_line_64.png" />
          <h3>RESOURCE PROJECTIONS</h3>
          </a>
        </div>
      </li>

      <li>
        <div>
          <a class="patch" href="<%=contextPath%>/std/AreaProgress" alt="AREA PROGRESS" title="AREA PROGRESS">
            <img src="../images/chart_line_64.png" />
            <h3>AREA PROGRESS</h3>
          </a>
        </div>
      </li>

      <li>
        <div>
            <a class="patch" href="<%=contextPath%>/std/StockManagement1" alt="LOGISTICS" title="LOGISTICS">
              <img src="../images/chart_line_64.png" />
              <h3>LOGISTICS</h3>
            </a>
        </div>
      </li>

      <li>
        <div>
          <a class="patch" href="<%=contextPath%>/std/AlarmManagementReports" alt="ALARM MANAGEMENT" title="ALARM MANAGEMENT">
            <img src="../images/chart_line_64.png" />
            <h3>ALARM MANAGEMENT</h3>
          </a>
        </div>
      </li>

      <li>
        <div>
          <a class="patch" href="javascript: openDashboard();" alt="SYSTEM UTILIZATION" title="SYSTEM UTILIZATION">
            <img src="../images/chart_line_64.png" />
            <h3>SYSTEM UTILIZATION</h3>
          </a>
        </div>
      </li>

     <li>
        <div>
          <a class="patch" href="<%=contextPath%>/std/WorkOrderProgress" alt="WORK ORDER PROGRESS" title="WORK ORDER PROGRESS">
            <img src="../images/chart_line_64.png" />
            <h3>WORK ORDER PROGRESS</h3>
          </a>
        </div>
      </li>

    <li>
      <div>
        <a class="patch" href="<%=contextPath%>/std/AnalyzeFieldWorkEfficiency" alt="FIELD WORK EFFICIENCY" title="FIELD WORK EFFICIENCY">
          <img src="../images/chart_line_64.png" />
          <h3>RESOURCE PROJECTIONS</h3>
        </a>
      </div>
    </li>

      <li>
        <div>
          <a class="patch" href="<%=contextPath%>/std/TimeReservationCallList" alt="TIME RESERVATION CALL LIST" title="TIME RESERVATION CALL LIST">
            <img src="../images/chart_line_64.png" />
            <h3>RESOURCE PROJECTIONS</h3>
          </a>
        </div>
      </li>

    </ul>
  </div>
  </div>
</div>

<!--
<div class="inner"> 
<ul id="skills-list" class="skills">

  <li class="">
  <div class="graphic">
   <div class="progress-ring">
    <span>
     <span>
       <a class="patch" style="background-image:url(<%=contextPath%>/images/resourceprojection.png)" href="<%=contextPath%>/std/ViewResourceProjectionAction" alt="RESOURCE PROJECTIONS" title="RESOURCE PROJECTIONS"></a>
     </span>
    </span>
   </div>
  </div>
  <div class="info">
  <h3 class="title">
  <a href="<%=contextPath%>/std/ViewResourceProjectionAction">RESOURCE PROJECTIONS</a>
  </h3>

  </div>
  </li>

  <li class="">
  <div class="graphic">
   <div class="progress-ring">
    <span>
     <span>
       <a class="patch" style="background-image:url(<%=contextPath%>/images/areabased.png)" href="<%=contextPath%>/std/AreaProgress" alt="AREA PROGRESS" title="AREA PROGRESS"></a>
     </span>
    </span>
   </div>
  </div>
  <div class="info">
  <h3 class="title">
  <a href="<%=contextPath%>/std/AreaProgress">AREA PROGRESS</a>
  </h3>

  </div>
  </li>

<li class="">
<div class="graphic">
 <div class="progress-ring">
  <span>
   <span>
     <a class="patch" style="background-image:url(<%=contextPath%>/images/logistics.png)" href="<%=contextPath%>/std/StockManagement1" alt="LOGISTICS" title="LOGISTICS"></a>
   </span>
  </span>
 </div>
</div>
<div class="info">
<h3 class="title">
<a href="<%=contextPath%>/std/StockManagement1">LOGISTICS</a>
</h3>

</div>
</li>

<li class="">
<div class="graphic">
 <div class="progress-ring">
  <span>
   <span>
     <a class="patch" style="background-image:url(<%=contextPath%>/images/alert_new.png)" href="<%=contextPath%>/std/AlarmManagementReports" alt="ALARM MANAGEMENT" title="ALARM MANAGEMENT"></a>
   </span>
  </span>
 </div>
</div>
<div class="info">
<h3 class="title">
<a href="<%=contextPath%>/std/AlarmManagementReports">ALARM MANAGEMENT</a>
</h3>

</div>
</li>

<li class="">
<div class="graphic">
 <div class="progress-ring">
  <span>
   <span>
     <a class="patch" style="background-image:url(<%=contextPath%>/images/network.png)" href="javascript: openDashboard();" alt="SYSTEM UTILIZATION" title="SYSTEM UTILIZATION"></a>
   </span>
  </span>
 </div>
</div>
<div class="info">
<h3 class="title">
<a href="javascript: openDashboard();">SYSTEM UTILIZATION</a>
</h3>

</div>
</li>

<li class="">
<div class="graphic">
 <div class="progress-ring">
  <span>
   <span>
     <a class="patch" style="background-image:url(<%=contextPath%>/images/metermaintanance.png)" href="<%=contextPath%>/std/WorkOrderProgress" alt="WORK ORDER PROGRESS" title="WORK ORDER PROGRESS"></a>
   </span>
  </span>
 </div>
</div>
<div class="info">
<h3 class="title">
<a href="<%=contextPath%>/std/WorkOrderProgress">WORK ORDER PROGRESS</a>
</h3>

</div>
</li>

<li class="">
<div class="graphic">
 <div class="progress-ring">
  <span>
   <span>
     <a class="patch" style="background-image:url(<%=contextPath%>/images/technicianperformance.png)" href="<%=contextPath%>/std/AnalyzeFieldWorkEfficiency" alt="FIELD WORK EFFICIENCY" title="FIELD WORK EFFICIENCY"></a>
   </span>
  </span>
 </div>
</div>
<div class="info">
<h3 class="title">
<a href="<%=contextPath%>/std/AnalyzeFieldWorkEfficiency">FIELD WORK EFFICIENCY</a>
</h3>

</div>
</li>

<li class="">
  <div class="graphic">
    <div class="progress-ring">
      <span>
        <span>
        <a class="patch" style="background-image:url(<%=contextPath%>/images/timedurationcalllist.png)" href="<%=contextPath%>/std/TimeReservationCallList" alt="TIME RESERVATION CALL LIST" title="TIME RESERVATION CALL LIST"></a>
        </span>
      </span>
    </div>
  </div>
  <div class="info">
    <h3 class="title">
      <a href="<%=contextPath%>/std/TimeReservationCallList">TIME RESERVATION CALL LIST</a>
    </h3>
  </div>
</li> 
</ul>
</div>
-->
  <%@ include file="footerv311.inc" %>
</div>
    <script type="text/javascript" src="https://raw.githubusercontent.com/chuckcarpenter/REM-unit-polyfill/master/js/rem.min.js"></script>
</body>
</html>