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
            Smart Energy Services Platform
            </div>
            </div>
            <div class="row">
              <div class="large-12 columns">

                <ul class="small-block-grid-2 medium-block-grid-3 large-block-grid-4">

                  <li>
                    <div>
                      <a class="patch" href="<%=contextPath%>/std/ViewResourceProjectionAction" alt="RESOURCE PROJECTIONS" title="RESOURCE PROJECTIONS">
                        <i class="fi-graph-bar size-74"></i></br>
                        <span>Resource Projections</span>
                      </a>
                    </div>
                  </li>

                  <li>
                    <div>
                      <a class="patch" href="<%=contextPath%>/std/AreaProgress" alt="AREA PROGRESS" title="AREA PROGRESS">
                        <i class="fi-loop size-74"></i></br>
                        <span>Area Progress</span>
                      </a>
                    </div>
                  </li>

                  <li>
                    <div class="logistics-icon-temp">
                        <a class="patch" href="<%=contextPath%>/std/StockManagement1" alt="LOGISTICS" title="LOGISTICS">
                          <i>
                          <svg class="logistics-icon-pos" version="1.1" id="Layer_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px"
                             width="74px" height="60px" viewBox="0 0 512 371" enable-background="new 0 0 512 371" xml:space="preserve">
                          <g>
                            <defs>
                              <rect class="bar" id="SVGID_1_" y="-68" width="512" height="512"/>
                            </defs>
                            <clipPath id="SVGID_2_">
                              <use xlink:href="#SVGID_1_"  overflow="visible"/>
                            </clipPath>
                            <path class="logistics-icon" clip-path="url(#SVGID_2_)" d="M435.303,81.064h-98.088v157.718c6.49-2.222,13.489-3.465,20.782-3.465
                              c30.004,0,55.184,20.733,61.983,48.691h50.23V165.729L435.303,81.064z M387.264,170.472l-23.691-64.454h55.039l26.566,64.454
                              H387.264z M286.919,37.7H65.512c-13.36,0-24.183,10.829-24.183,24.17v223.154h31.347c6.425-28.45,31.851-49.706,62.211-49.706
                              c30.414,0,55.839,21.256,62.25,49.706h98.612c2.52-11.086,7.882-21.092,15.353-29.168V61.87
                              C311.102,48.529,300.277,37.7,286.919,37.7 M134.887,260.266c-21.418,0-38.847,17.436-38.847,38.887s17.429,38.887,38.847,38.887
                              c21.469,0,38.901-17.436,38.901-38.887S156.356,260.266,134.887,260.266 M357.997,260.266c-21.452,0-38.901,17.436-38.901,38.887
                              s17.449,38.887,38.901,38.887s38.882-17.436,38.882-38.887S379.449,260.266,357.997,260.266"/>
                          </g>
                          </svg>
                          </i></br>
                          <span>Logistics</span>
                        </a>
                    </div>
                  </li>

                  <li>
                    <div>
                      <a class="patch" href="<%=contextPath%>/std/AlarmManagementReports" alt="ALARM MANAGEMENT" title="ALARM MANAGEMENT">
                        <i class="fi-alert size-74"></i></br>
                        <span>Alarm Management</span>
                      </a>
                    </div>
                  </li>

                  <li>
                    <div>
                      <a class="patch" href="javascript: openDashboard();" alt="SYSTEM UTILIZATION" title="SYSTEM UTILIZATION">
                        <i class="fi-monitor size-74"></i></br>
                        <span>System Utilization</span>
                      </a>
                    </div>
                  </li>

                 <li>
                    <div>
                      <a class="patch" href="<%=contextPath%>/std/WorkOrderProgress" alt="WORK ORDER PROGRESS" title="WORK ORDER PROGRESS">
                        <i class="fi-clock size-74"></i></br>
                        <span>Work Order/Area Monitor</span>
                      </a>
                    </div>
                  </li>

                <li>
                  <div>
                    <a class="patch" href="<%=contextPath%>/std/AnalyzeFieldWorkEfficiency" alt="FIELD WORK EFFICIENCY" title="FIELD WORK EFFICIENCY">
                      <i class="fi-wrench size-74"></i></br>
                      <span>Field Work Efficiency</span>
                    </a>
                  </div>
                </li>

                  <li>
                    <div>
                      <a class="patch" href="<%=contextPath%>/std/TimeReservationCallList" alt="TIME RESERVATION CALL LIST" title="TIME RESERVATION CALL LIST">
                        <i class="fi-list size-74"></i></br>
                        <span>Time Reservation Call List</span>
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