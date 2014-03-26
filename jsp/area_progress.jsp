<!DOCTYPE html>
<%@ taglib prefix="s" uri="/struts-tags"%>

<%@page import="com.capgemini.sesp.ast_sep.webclient.service.WorkOrderProgressService"%>
<%@page import="com.skvader.rsp.cft.webservice_client.service.provider.ServiceProvider"%>
<%@page import="com.capgemini.sesp.ast_sep.webclient.util.to.WorkOrderStatusTO"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%><html xmlns="http://www.w3.org/1999/xhtml">
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
		<%  String contextPath = request.getContextPath(); %>
		<link rel="stylesheet" type="text/css" href="<%=contextPath%>/styles/bootstrap.css"/>
		<link rel="stylesheet" type="text/css" href="<%=contextPath%>/styles/color.css"/>
		<link rel="stylesheet" type="text/css" href="<%=contextPath%>/styles/jquery.multiselect.css"/>
		<link rel="stylesheet" type="text/css" href="<%=contextPath%>/styles/general.css" />
		<link rel="stylesheet" type="text/css" href="<%=contextPath%>/styles/header.css" />
		<link rel="stylesheet" type="text/css" href="<%=contextPath%>/styles/content-block.css" />
		<link rel="stylesheet" type="text/css" href="<%=contextPath%>/styles/footer.css" />
		<link rel="stylesheet" type="text/css" href="<%=contextPath%>/styles/datepicker.css" />
		<link rel="stylesheet" type="text/css" href="<%=contextPath%>/styles/content-area-progress.css" />
		
		<link rel="stylesheet" type="text/css" href="<%=contextPath%>/styles/style.tidy.css" />
		<link rel="stylesheet" type="text/css" href="<%=contextPath%>/styles/bubble-map.css"/>
		<link rel="shortcut icon" type="image/png" href="<%=contextPath%>/images/favicon.png" />
		<link rel="stylesheet" type="text/css" href="<%=contextPath%>/styles/content-stock-management.css" />
		<link rel="shortcut icon" type="image/png" href="<%=contextPath%>/images/favicon.png" />
		
		<script type="text/javascript" src="<%=contextPath%>/js/jquery-1.9.1.min.js"></script>
		<script type="text/javascript" src="<%=contextPath%>/js/jquery-migrate-1.1.1.js"></script>
		<script type="text/javascript" src="<%=contextPath%>/js/jquery-ui-1.10.2.custom.js"></script>		
		<script type="text/javascript" src="<%=contextPath%>/js/bootstrap-datepicker.js"></script>
		<script type="text/javascript" src="<%=contextPath%>/js/jquery.multiselect.js"></script>
		<script type="text/javascript" src="<%=contextPath%>/js/jquery.cookie.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/colResizable-1.3.min.js"></script>
		<script type="text/javascript" src="<%=contextPath%>/js/init.js"></script>
		<script type="text/javascript" src="<%=contextPath%>/js/search-results.js"></script>
		<script type="text/javascript" src="<%=contextPath%>/js/OpenLayers.js"></script>
		<script src="<%=contextPath%>/js/fusionchartsxt/charts/FusionCharts.js"></script>
		
		<script type="text/javascript" src="<%=contextPath%>/js/area-progress.js"></script>
			
		
		<script src="<%=contextPath%>/js/map.js"></script>
		<script src="<%=contextPath%>/js/sesp_ajax.js"></script>
		<script src="<%=contextPath%>/js/spin.js"></script>
		<script src="<%=contextPath%>/js/ajax-loader.js"></script>				
		
			
				
		

	</head>
	<% 	

				WorkOrderProgressService woProgressService = ServiceProvider.getInstance().getService(WorkOrderProgressService.class);	
				List<WorkOrderStatusTO> woStatusTypes = woProgressService.getWOStatusTypes();
				Map<String, String> selectedImage = new HashMap<String, String>();
				Map<String, String> unselectedImage = new HashMap<String, String>();
				//String[] symbols = new String[] {"blue","green","orange","pink","purple","red","yellow"};
				String[] symbols = new String[] {"blue","red","green","purple","yellow","pink","ltblue"};
				
				int imageCount = 1;
				int symbolCounter = 0;
				String imagePath = null;
				
				/*
				10	CANCELLED	Cancelled
9	CLOSED	Closed
11	ERROR	Error
12	ERROR_STARTING	Error Starting
8	IN_PROGRESS	In Progress
7	SCHEDULED	Scheduled*/
				
				for(WorkOrderStatusTO woStatusTTO : woStatusTypes) {
					
					if(woStatusTTO.getCode().equals("CANCELLED")) {
						imagePath = "/images/marker-icon-blue-dot.png";	
					} else if (woStatusTTO.getCode().equals("CLOSED")) {					
						imagePath = "/images/marker-icon-green-dot.png";
					}  else if (woStatusTTO.getCode().equals("ERROR"))  {
						imagePath = "/images/marker-icon-red-dot.png";
					}  else if (woStatusTTO.getCode().equals("ERROR_STARTING"))  {
						imagePath = "/images/marker-icon-red-dot.png";
					}  else if (woStatusTTO.getCode().equals("IN_PROGRESS"))  {
						imagePath = "/images/marker-icon-yellow-dot.png";
					} else if (woStatusTTO.getCode().equals("SCHEDULED"))  {
						imagePath = "/images/marker-icon-yellow-dot.png";
					}				
					
					unselectedImage.put(woStatusTTO.getStatusId(), ((HttpServletRequest)pageContext.getRequest()).getContextPath() + imagePath);
					selectedImage.put(woStatusTTO.getStatusId(),  ((HttpServletRequest)pageContext.getRequest()).getContextPath() + imagePath);
					symbolCounter++;	
				}	
				%>
	<script>
        contextPath = "<%=request.getContextPath()%>";           
		area_name1 = "<%=request.getAttribute("aname")%>";
        from_err_msg="<s:text name='areaprogress.filters.from.err.msg'/>";
        to_err_msg="<s:text name='areaprogress.filters.to.err.msg'/>";
        i18nerrorFromDateOlderThanToDate = "<s:text name='webportal.analyzefieldwork.fieldworkefficiency.filters.datesvalidation'/>";
        domain_err_msg="<s:text name='areaprogress.filters.domain.err.msg'/>";
        areatype_err_msg="<s:text name='areaprogress.filters.areatype.err.msg'/>";
        workordertype_err_msg="<s:text name='areaprogress.filters.workordertype.err.msg'/>";
        dateinterval_err_msg="<s:text name='areaprogress.filters.dateinterval.err.msg'/>";
        filters_msg="<s:text name='areaprogress.filters.msg'/>"; 
        area_err_msg="<s:text name='webportal.error.selectarea'/>"; 

        var ap_dateInterval = "<%=request.getAttribute("dateInterval")%>";
		var ap_dateFrom = "<%=request.getAttribute("dateFrom")%>";
		var ap_dateTo = "<%=request.getAttribute("dateTo")%>";
		var ap_domain = "<%=request.getAttribute("domain")%>";
		var ap_areaType = "<%=request.getAttribute("areaType")%>";
		var ap_workOrderType = "<%=request.getAttribute("workOrderType")%>";
		var ap_unplanned = "<%=request.getAttribute("unplanned")%>";	
		var ap_area = "<%=request.getAttribute("area")%>";

		var apreqObject = {};       	

       	function loadWOPointsForAreaMap(domain,areaType,workOrderType,unplanned,dateInterval,dateFrom,dateTo,area){

        	apreqObject.dateInterval=dateInterval;
        	apreqObject.dateFrom=dateFrom;
        	apreqObject.dateTo=dateTo;
        	apreqObject.domain=domain;
        	apreqObject.areaType=areaType;
        	apreqObject.workOrderType=workOrderType;
        	apreqObject.unplanned=unplanned;
        	apreqObject.area=area;    	
    	
        } 


       	function loadPointsSuccess(data) {
			//var data1 = eval(data);
			function getPointCollection(object, pointCollections) {
				var pointCollection = pointCollections[object.idCase];
				if(typeof pointCollection == "undefined") {
					<%
						for(WorkOrderStatusTO woStatusTTO : woStatusTypes) {
							String selectedIcon = selectedImage.get(woStatusTTO.getStatusId());
							String unSelectedIcon = unselectedImage.get(woStatusTTO.getStatusId());
					%>
							if(object.status == "<%=woStatusTTO.getCode()%>") {
								pointCollection = createPointsCollection(<%="\"" + unSelectedIcon+"\""%>,<%="\"" + selectedIcon+"\""%>);
							}
					<%}	%>
					pointCollections[object.idCase] = pointCollection;
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


	


        function displayInfo(id) {
        		// alert(id);
        		$("#area-name").val(id);
        		// submitLogistics();
        	}


        function infoDataCallback(id,woid,wostatus, woaddress) {
        	var returnData;
        	    		
        		
        		html = "<div style=\"font-size:.8em;background-color:#ffffff;filter:alpha(opacity=80);opacity:.8;border-radius: 5px;\">";
        		html += "<div id='bubble-header'></div>";
        		var orderType = $.cookie(pgCode+"block-work-order-tab");
        		if(orderType == 'progress') {
        			html += "<div> <b>Progress : </b>" +wostatus +"</div> ";
        		} else if(orderType=='status') {
        			html += "<div> <b>Status : </b>" +wostatus +"</div> ";
        		} else {
        			html += "<div> <b>Progress : </b>" +wostatus +"</div> ";
        		}
        		html += "<div> <b>ID : </b>" + woid +"</div> ";
        		html += "<div> <b>Address : </b>" + woaddress +"</div> ";
        		
        		html += "</div>";
        		returnData =  html;
        		
        		
        	return returnData;
        }       	
    </script>
	<body onload="initmap('<%=request.getSession().getAttribute("MAP_SERVER_URL")%>')">

		<div id="wrapper">
			<%@include  file="headerv311.inc" %>

			<div id="main-content">

				
				<div class="title-large-block large-block text-grey" >
					<s:text name="areaprogress.area"/> : <span class="text-light-grey" id="area-name"></span>
				</div>
				
				<div class="large-block block retractable" id="block-filters">
					<div class="block-title">
						<span class="block-title-picto"></span>
						<span class="block-title-name text-blue"><s:text name="areaprogress.filters"/></span>
						<span class="block-arrow open"></span>
					</div>
					<div class="content-wrapper full-height">
						<div class="content text-grey">
							<div class="quarter-column">
								<div class="select-wrapper">
									<span class="select-title text-grey"> <s:text name="workorderprogress.filters.dateinterval"/></span>
									<div class="custom-select">
										<select id="filter-select-date-interval" onchange="show()">
											<option value="lastweek" selected="selected"><s:text name="webportal.alarm.dateinterval.lastweek"/></option>
											<option value="today"><s:text name="webportal.alarm.dateinterval.today"/></option>													
											<option value="lastmonth"><s:text name="webportal.alarm.dateinterval.lastmonth"/></option>
											<option value="lastquarter"><s:text name="webportal.alarm.dateinterval.lastquarter"/></option>
											<option value="lastyear"><s:text name="webportal.alarm.dateinterval.lastyear"/></option>
											<option value="custominterval"><s:text name="webportal.alarm.dateinterval.custominterval"/></option>
										</select>
									</div>
								</div>
								
								<div id="filter-custom-date-interval" class="select-wrapper" >
									<div class="small-select-wrapper left-select">
										<span class="select-title text-red"><s:text name="workorderprogress.filters.from"/> :</span>
										<div class="custom-input-datepicker input-append date" data-date="2012-02-12" data-date-format="yyyy-mm-dd">
											<input id="filter-date-from" type="text" class="input-datepicker text-red"  readonly="readonly"/>
										</div>
									</div><div class="small-select-wrapper right-select">
										<span class="select-title text-red"><s:text name="workorderprogress.filters.to"/> :</span>
										<div class="custom-input-datepicker input-append date"  data-date="12-02-2012" data-date-format="yyyy-mm-dd">
											<input id="filter-date-to" type="text" class="input-datepicker text-red"  readonly="readonly"/>
										</div>
									</div>
								</div>
								
							</div>
							<div class="quarter-column">
								<div class="select-wrapper">
									<span class="select-title text-grey"><s:text name="areaprogress.filters.domain"/></span>
									<div class="custom-select">
										<select id="filter-multiselect-domain" class="custom-multi-select" onchange="domainChanged()" name="multiselect-domain" multiple="multiple">
									<!-- 	<option value="option_1">Option 1</option>     
									     	<option value="option_2">Option 2</option>								
											<option value="option_3">Option 3</option>
											<option value="option_4">Option 4</option>
											<option value="option_5">Option 5</option>
											<option value="option_6">Option 6</option>
											<option value="option_7">Option 7</option>     -->
										</select>
									</div>
									<span class="select-title text-grey" style="margin-top:20px;"><s:text name="workorderprogress.filters.workordertype"/></span>
									<div class="custom-select">
										<select id="filter-multiselect-work-order-type" class="custom-multi-select"  name="multiselect-work-order-type" multiple="multiple">								
										</select>
									</div>
								</div>
								
							</div>
							<div class="quarter-column">	
								<div class="select-wrapper">
									<span class="select-title text-grey"><s:text name="areaprogress.filters.areatype"/></span>
									<div class="custom-select">
										<select id="filter-multiselect-area-type" class="custom-multi-select" onchange="areaTypeChanged()" name="multiselect-area-type" multiple="multiple">									
										</select>
									</div>
								</div>
								<div class="select-wrapper">
									<span class="select-title text-grey"><s:text name="webportal.alarm.area"/></span>
									<div class="custom-select">
										<select id="filter-multiselect-area" class="custom-multi-select" name="multiselect-area" multiple="multiple">													
										</select>
									</div>
									<div style="padding-right: 117px; padding-top: 1px; text-align: left;">
										<span class="select-title text-grey">Unplanned<input type="checkbox" id="filter-checkbox-unplanned" name="unplanned" value="checked"/> </span>
									</div>
								</div>
							</div>						
							
						</div>
						<div>
						<div class="button-wrapper" style="margin-top:0px;margin-left:420px;">
									<a id="block-filter-button-update" class="text-blue custom-button" onclick="filter_submit()"><s:text name="workorderprogress.filters.update"/></a>						
								</div>
						</div>
					</div>
				</div>
				
				<div class="large-block block" id="block-work-order">
					<div class="block-title">
						<span class="block-title-picto"></span>
						<span class="block-title-name text-blue"><s:text name="areaprogress.workorderprogress"/></span>
					</div>
					<div class="content-wrapper full-height">
						<div class="content text-grey">
							<div id="tabs-wrapper">
								<a id="block-work-order-tab1" class="tab selected" onclick="javascript:updateWorkOrder('progress')"> </a>
								<a id="block-work-order-tab2" class="tab" onclick="javascript:updateWorkOrder('status')"></a>
							</div>
							<div style="width: 930px; height: 660px; opacity:0.99;" id="map-wrapper" >
										<!--<iframe width="930" height="660" frameborder="0" scrolling="no" marginheight="0" marginwidth="0" src="http://www.openstreetmap.org/export/embed.html?bbox=-1.55302,47.19581,-1.50817,47.22307&amp;layer=mapnik&amp;marker=47.21659,-1.53457"></iframe>
									--></div>
							
							<div class="block inside-small-block retractable" id="block-summary">
								<div class="block-title">
									<span class="block-title-picto"></span>
									<span class="block-title-name text-blue"><s:text name="areaprogress.workorderprogress.summary"/></span>
									<span class="block-arrow open"></span>
								</div>
								<div class="content-wrapper">
									<div class="content text-grey">										
										<div class="sub-block-summary">
											<div class="sub-block-summary-title"><s:text name="areaprogress.workorderprogress.summary.numberofworkorders"/> :</div>
											<div id="block-summary-content-wo-count" class="sub-block-summary-content">         </div>
										</div>										
										<div class="sub-block-summary">
											<div class="sub-block-summary-title"><s:text name="areaprogress.workorderprogress.summary.workordertypes"/> :</div>
											<div id="summary-workordertypes-selected" style="max-height:500px;overflow-y:scroll">  
											</div>
										</div>
														
									</div>
								</div>
							</div>
							
							<div id="chart-wrapper">
								<div id="block-work-order-chart-view">
									
								</div>
								<div id="block-work-order-chart-view2">
									
								</div>
								
								<div class="content-wrapper full-height">
								<div class="content text-grey">
								
								<div style="width: 640px;height: 445; float: left;"   id="block-work-order-status-chart">
								
								</div>
								
								<div style="width: 260px;height: 445; float: right;" id="block-work-order-status-chart-right">
								
								</div>
						</div>
					</div>
								
							</div>
						</div>
					</div>
				</div>
				
				
			</div>
			<%@ include file="footerv311.inc" %>
			<SCRIPT type="text/javascript">
			loadvalues();
			
			</SCRIPT>
		</div >
		
	</body >
</html>
