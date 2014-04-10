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
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/foundation-icons/foundation-icons.css">
<link rel="stylesheet" type="text/css" href="<%=contextPath%>/styles/general.css" />
<link rel="stylesheet" type="text/css" href="<%=contextPath%>/styles/header.css" />
<link rel="stylesheet" type="text/css" href="<%=contextPath%>/styles/content-index.css" />
<link rel="stylesheet" type="text/css" href="<%=contextPath%>/styles/content-search-results.css" />
<link rel="stylesheet" type="text/css" href="<%=contextPath%>/styles/hex2.css">
<link rel="shortcut icon" type="image/png" href="<%=contextPath%>/images/favicon.png" />
<link rel="stylesheet" type="text/css" href="<%=contextPath%>/styles/style.tidy.css" />
<link rel="stylesheet" type="text/css" href="<%=contextPath%>/js/dhtmlxGrid/codebase/dhtmlxgrid.css" />

<link rel="stylesheet" type="text/css" href="<%=contextPath%>/styles/jquery.multiselect.css"/>
<link rel="stylesheet" type="text/css" href="<%=contextPath%>/styles/bubble-map.css"/>

<script type="text/javascript" src="<%=contextPath%>/js/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/jquery-migrate-1.1.1.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/index-init.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/common.js"></script>

<script type="text/javascript" src="<%=contextPath%>/js/jquery-ui-1.10.2.custom.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/jquery.cookie.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/foundation.min.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/foundation/foundation.offcanvas.js"></script>

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
        <%@ include file="headerv311.inc" %>

        <section class="main-section">
          <script>
            contextPath = "<%=request.getContextPath()%>";
            isAjaxSearch = false;
            i18nerrorInvalidSearchInput = "<s:text name='webportal.search.results.error.invalidsearchinput'/>";
            i18nerrorInvalidSearchAction = "<s:text name='webportal.search.results.error.invalidsearchaction'/>";
            i18nerrorNoDataForSearch = "<s:text name='webportal.search.results.error.nosearchresults'/>";
          </script>
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
                        <i class="fi-graph-bar size-74"></i></br>
                        <span>RESOURCE PROJECTIONS</span>
                      </a>
                    </div>
                  </li>

                  <li>
                    <div>
                      <a class="patch" href="<%=contextPath%>/std/AreaProgress" alt="AREA PROGRESS" title="AREA PROGRESS">
                        <i class="fi-loop size-74"></i></br>
                        <span>AREA PROGRESS</span>
                      </a>
                    </div>
                  </li>

                  <li>
                    <div>
                        <a class="patch" href="<%=contextPath%>/std/StockManagement1" alt="LOGISTICS" title="LOGISTICS">
                          <i class="fi-mountains size-74"></i></br>
                          <span>LOGISTICS</span>
                        </a>
                    </div>
                  </li>

                  <li>
                    <div>
                      <a class="patch" href="<%=contextPath%>/std/AlarmManagementReports" alt="ALARM MANAGEMENT" title="ALARM MANAGEMENT">
                        <i class="fi-alert size-74"></i></br>
                        <span>ALARM MANAGEMENT</span>
                      </a>
                    </div>
                  </li>

                  <li>
                    <div>
                      <a class="patch" href="javascript: openDashboard();" alt="SYSTEM UTILIZATION" title="SYSTEM UTILIZATION">
                        <i class="fi-monitor size-74"></i></br>
                        <span>SYSTEM UTILIZATION</span>
                      </a>
                    </div>
                  </li>

                 <li>
                    <div>
                      <a class="patch" href="<%=contextPath%>/std/WorkOrderProgress" alt="WORK ORDER PROGRESS" title="WORK ORDER PROGRESS">
                        <i class="fi-clock size-74"></i></br>
                        <span>WORK ORDER/AREA MONITOR</span>
                      </a>
                    </div>
                  </li>

                <li>
                  <div>
                    <a class="patch" href="<%=contextPath%>/std/AnalyzeFieldWorkEfficiency" alt="FIELD WORK EFFICIENCY" title="FIELD WORK EFFICIENCY">
                      <i class="fi-wrench size-74"></i></br>
                      <span>FIELD WORK EFFICIENCY</span>
                    </a>
                  </div>
                </li>

                  <li>
                    <div>
                      <a class="patch" href="<%=contextPath%>/std/TimeReservationCallList" alt="TIME RESERVATION CALL LIST" title="TIME RESERVATION CALL LIST">
                        <i class="fi-list size-74"></i></br>
                        <span>TIME RESERVATION CALL LIST</span>
                      </a>
                    </div>
                  </li>

                </ul>
              </div><!-- end of large-12 -->
            </div><!-- end of row -->
          </section>

    </div> <!-- end of wrap -->

    <script type="text/javascript">
      $(document).foundation('offcanvas');
    </script>
    
    <!--[if lt IE 9]>
    <script type="text/javascript" src="https://raw.githubusercontent.com/chuckcarpenter/REM-unit-polyfill/master/js/rem.min.js"></script>
    <![endif]-->

  </body>
  </html>