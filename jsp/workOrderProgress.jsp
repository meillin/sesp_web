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
		<%  String contextPath = request.getContextPath(); %>
		<link rel="stylesheet" type="text/css" href="<%=contextPath%>/styles/bootstrap.css"/>
		<link rel="stylesheet" type="text/css" href="<%=contextPath%>/styles/color.css"/>
		<link rel="stylesheet" type="text/css" href="<%=contextPath%>/styles/jquery.multiselect.css"/>
		<link rel="stylesheet" type="text/css" href="<%=contextPath%>/styles/general.css" />
		<link rel="stylesheet" type="text/css" href="<%=contextPath%>/styles/header.css" />
		<link rel="stylesheet" type="text/css" href="<%=contextPath%>/styles/content-block.css" />
		<link rel="stylesheet" type="text/css" href="<%=contextPath%>/styles/footer.css" />
		<link rel="stylesheet" type="text/css" href="<%=contextPath%>/styles/datepicker.css" />
		<link rel="stylesheet" type="text/css" href="<%=contextPath%>/styles/content-work-order-progress.css" />
		<link rel="stylesheet" type="text/css" href="<%=contextPath%>/styles/style.tidy.css" />
		<link rel="stylesheet" type="text/css" href="<%=contextPath%>/styles/bubble-map.css"/>
		<link rel="shortcut icon" type="image/png" href="<%=contextPath%>/images/favicon.png" />	
			
		<script type="text/javascript" src="<%=contextPath%>/js/jquery-1.9.1.min.js"></script>
		<script type="text/javascript" src="<%=contextPath%>/js/jquery-migrate-1.1.1.js"></script>
		<script type="text/javascript" src="<%=contextPath%>/js/jquery-ui-1.10.2.custom.js"></script>		
		<script type="text/javascript" src="<%=contextPath%>/js/bootstrap-datepicker.js"></script>
		<script type="text/javascript" src="<%=contextPath%>/js/jquery.multiselect.js"></script>		
		<script type="text/javascript" src="<%=contextPath%>/js/jquery.cookie.js"></script>
		<script type="text/javascript" src="<%=contextPath%>/js/colResizable-1.3.min.js"></script>
		<script type="text/javascript" src="<%=contextPath%>/js/init.js"></script>
		<script type="text/javascript" src="<%=contextPath%>/js/fusionchartsxt/charts/FusionCharts.js"></script>
		<script type="text/javascript" src="<%=contextPath%>/js/OpenLayers.js"></script>	
		<script type="text/javascript" src="<%=contextPath%>/js/sesp_ajax.js"></script>		
		<script type="text/javascript" src="<%=contextPath%>/js/spin.js"></script>		
		<script type="text/javascript" src="<%=contextPath%>/js/map.js"></script>
		<script type="text/javascript" src="<%=contextPath%>/js/ajax-loader.js"></script>
		<script type="text/javascript" src="<%=contextPath%>/js/work-order-progress.js"></script>				
		<script type="text/javascript" src="<%=contextPath%>/js/search-results.js"></script>	
	</head>
	
	<script>
        contextPath = "<%=contextPath%>";     
        from_err_msg="<s:text name='workorderprogress.filters.from.err.msg'/>";
        to_err_msg="<s:text name='workorderprogress.filters.to.err.msg'/>";
        i18nerrorFromDateOlderThanToDate = "<s:text name='webportal.analyzefieldwork.fieldworkefficiency.filters.datesvalidation'/>";
        domain_err_msg="<s:text name='workorderprogress.filters.domain.err.msg'/>";
        areatype_err_msg="<s:text name='workorderprogress.filters.areatype.err.msg'/>";
        workordertype_err_msg="<s:text name='workorderprogress.filters.workordertype.err.msg'/>";
        dateinterval_err_msg="<s:text name='workorderprogress.filters.dateinterval.err.msg'/>";
        filters_msg="<s:text name='workorderprogress.filters.msg'/>";
        area_err_msg="<s:text name='webportal.error.selectarea'/>";
        var apreqObject = {};
        
        function loadPointsForAreaMap(domain,areaType,workOrderType,unplanned,dateInterval,dateFrom,dateTo,area){

        	apreqObject.dateInterval=dateInterval;
        	apreqObject.dateFrom=dateFrom;
        	apreqObject.dateTo=dateTo;
        	apreqObject.domain=domain;
        	apreqObject.areaType=areaType;
        	apreqObject.workOrderType=workOrderType;
        	apreqObject.unplanned=unplanned;
        	apreqObject.area=area;
        	
	    	var obj= {};
		    obj.url=contextPath+"/std/WOMapAreas.action";   
	
		    obj.pdata = 'dateInterval='+dateInterval+'&dateFrom='+dateFrom+'&dateTo='+dateTo+'&domain='+domain+
	   		'&areatypes='+areaType+'&workOrderType='+workOrderType+'&unplanned='+unplanned+'&area='+area;		
		    areaWOMapInfoRParams = 	'dateInterval='+dateInterval+'&dateFrom='+dateFrom+'&dateTo='+dateTo+'&domain='+domain+
	   		'&workOrderType='+workOrderType+'&unplanned='+unplanned+'&area='+area;		
		    //obj.pdata = "domains="+domain+"&areatypes="+areaType;
		 	obj.successfunc = createWOAreaJSON;
		    obj.errorfunc = errorDetails;
		    
			run_ajax(obj);
	    	return;
    	
        } 


	function fetchBubbleContent(id) {
        var obj= {};
    	obj.url=contextPath+"/std/WOMapAreasStatusInfo.action";
    	obj.pdata = areaWOMapInfoRParams+"&area="+id;
    	obj.successfunc = function(msg){ 
       		if(msg == "") {
    			return;
    		}
    		var o = eval(msg);
    		if(o == null)
    			return; 

    		populateBubbleContent(o);
    		
       };
    	obj.errorfunc = populateErrorBubbleContent;
    	run_ajax_Sync(obj);
    	return;
	}

        function woAreaProgressCallback(aname,aid) {
       		var returnData;
       	  
			//areaprogressLink = contextPath+"/std/AreaProgress.action?"+areaWOMapInfoRParams+"&aid="+aid+"&aname="+aname;			
       		//alert(areaprogressLink);
       		html = "<form id=\"bubbleForm\" name=\"bubbleForm\" method=\"post\" action=\""+contextPath+"/std/AreaProgress.action\">";
       		html += "<div id=\"bubble\" class=\"bubble-chart text-grey\" style=\"width:350px; height:350px;\">";
       		html +=	"<div id=\"bubble-header\"></div>";
       		html += "<div class=\"bubble-title\">";
       		html += "	<div class=\"bubble-category\">Area name :</div>";
       		html +=	"	<div class=\"bubble-value text-light-grey\"><a href=\"javascript:document.getElementById('bubbleForm').submit();\">"+aname+"</a></div>";
       		html +=	"</div>";
       		html +=	"<div class=\"bubble-value text-light-grey\" id=\"bubble-content\">";        	
       		html += "</div>";
       		html += "<div id=\"bubble-arrow\">";   
       		   		
       		html+= "<input type=\"hidden\" name=\"aid\" value=\""+aname+"\"/>";
       		html+= "<input type=\"hidden\" name=\"aname\" value=\""+aid+"\"/>";
       		html+= "<input type=\"hidden\" name=\"dateInterval\" value=\""+apreqObject.dateInterval+"\"/>";
       		html+= "<input type=\"hidden\" name=\"dateFrom\" value=\""+apreqObject.dateFrom+"\"/>";
       		html+= "<input type=\"hidden\" name=\"dateTo\" value=\""+apreqObject.dateTo+"\"/>";
       		html+= "<input type=\"hidden\" name=\"domain\" value=\""+apreqObject.domain+"\"/>";
       		html+= "<input type=\"hidden\" name=\"areaType\" value=\""+apreqObject.areaType+"\"/>";
       		html+= "<input type=\"hidden\" name=\"workOrderType\" value=\""+apreqObject.workOrderType+"\"/>";
       		html+= "<input type=\"hidden\" name=\"unplanned\" value=\""+apreqObject.unplanned+"\"/>";
       		html+= "<input type=\"hidden\" name=\"area\" value=\""+apreqObject.area+"\"/>";
       		
       		html += "</div>";
       		html += "</div></form>";        		
       		
       		returnData =  html;

       		saveAreaProgressFilters(apreqObject.dateInterval,apreqObject.dateFrom,apreqObject.dateTo,apreqObject.domain,apreqObject.areaType,apreqObject.workOrderType,apreqObject.unplanned,apreqObject.area);	
        		
        	return returnData;
        }

        function populateErrorBubbleContent(data) {
        	document.getElementById("bubble-content").innerHTML=data.responseText;
        }


        function populateBubbleContent(data) {
        	//Work Order Progress
    		var bubbleWOAreaChart = new FusionCharts(contextPath+"/js/fusionchartsxt/charts/Doughnut2D.swf", "mapWOareaProgressChartId"+bci++,"300","300");
    		bubbleWOAreaChart.setDataXML(data.workOrderProgress);
    		bubbleWOAreaChart.render("bubble-content");
        }

        function submitWO2AreaProgress(formRef)
    	{
    		if(formRef.username.value=="")
    		{
    			alert(i18nerrorPleaseEnterUsername);
    			formRef.username.focus();
    			return;
    		} if(formRef.password.value=="")
    		{
    			alert(i18nerrorPleaseEnterPassword);
    			formRef.password.focus();
    			return;
    		}
    		document.getElementById("divenable").style.display="none";
    		document.getElementById("divdisable").style.display="block";
    		loginSpinner();
    		formRef.submit();	
    	}

		var bci = 0;
        
       
   </script>
	<body onload="loadvalues(),initmap('<%=request.getSession().getAttribute("MAP_SERVER_URL")%>')">

		<div id="wrapper">
			<%@ include file="headerv311.inc"%>	
			<div id="main-content">

				<div class="title-large-block large-block text-grey" >
					<s:text name="workorderprogress.workorderprogress"/>
				</div>
				
				<div class="large-block block retractable" id="block-filters">
					<div class="block-title">
						<span class="block-title-picto"></span>
						<span class="block-title-name text-blue"><s:text name="workorderprogress.filters"/></span>
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
									</div><!--
									--><div class="small-select-wrapper right-select">
										<span class="select-title text-red"><s:text name="workorderprogress.filters.to"/> :</span>
										<div class="custom-input-datepicker input-append date"  data-date="12-02-2012" data-date-format="yyyy-mm-dd">
											<input id="filter-date-to" type="text" class="input-datepicker text-red"  readonly="readonly"/>
										</div>
									</div>
								</div>
								
							</div>
							<div class="quarter-column">
								<div class="select-wrapper">
									<span class="select-title text-grey"><s:text name="workorderprogress.filters.domain"/></span>
									<div class="custom-select">
										<select id="filter-multiselect-domain" class="custom-multi-select" onchange="domainChanged()" name="multiselect-domain" multiple="multiple">
									<!--		<option value="option_1">Option 1</option>
											<option value="option_2">Option 2</option>								
											<option value="option_3">Option 3</option>
											<option value="option_4">Option 4</option>
											<option value="option_5">Option 5</option>
											<option value="option_6">Option 6</option>
											<option value="option_7">Option 7</option>    -->
										</select>
									</div>
									
									<span class="select-title text-grey" style="margin-top:20px;"><s:text name="workorderprogress.filters.workordertype"/></span>
									<div class="custom-select">
										<select id="filter-multiselect-work-order-type" class="custom-multi-select" name="multiselect-work-order-type" multiple="multiple">								
										</select>
									</div>
								</div>
							</div>
							<div class="quarter-column">	
								<div class="select-wrapper">
									<span class="select-title text-grey"><s:text name="workorderprogress.filters.areatype"/></span>
									<div class="custom-select">
										<select id="filter-multiselect-area-type" class="custom-multi-select" onchange="areaTypeChanged()" name="multiselect-area-type" multiple="multiple">
									<!-- 	<option value="option_1">Option 1</option>
											<option value="option_2">Option 2</option>								
											<option value="option_3">Option 3</option>
											<option value="option_4">Option 4</option>
											<option value="option_5">Option 5</option>
											<option value="option_6">Option 6</option>
											<option value="option_7">Option 7</option>   -->
										</select>
									</div>
								</div>
								
								<div class="select-wrapper">
										<span class="select-title text-grey"><s:text name="webportal.alarm.area"/></span>
										<div class="custom-select">
											<select id="filter-multiselect-area" class="custom-multi-select" name="multiselect-area" multiple="multiple">													
											</select>
										</div>
									</div>
								<div class="select-title text-grey" style="padding-right: 0px; padding-top:4px; text-align: left;">
										<span class="select-title text-grey">Unplanned<input type="checkbox" id="filter-checkbox-unplanned" name="unplanned" value="checked"/> </span>
									</div>
							</div>
						
							
							<div class="center-wrapper">
								
							</div>							
						</div>
						<div style="margin-top:35px;margin-left:420px;">
						<div class="button-wrapper">
									<a id="block-filter-button-update" class="text-blue custom-button" onclick="filter_submit()"><s:text name="workorderprogress.filters.update"/></a>						
								</div>	
						</div>
					</div>
				</div>
				
				<div class="large-block block retractable" id="block-work-order-status">
					<div class="block-title">
						<span class="block-title-picto"></span>
						<span class="block-title-name text-blue"><s:text name="workorderprogress.workorderstatus"/> </span>
						<span class="block-arrow open"></span>
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
				
				<div class="large-block block retractable" id="block-progress-overview">
					<div class="block-title">
						<span class="block-title-picto"></span>
						<span class="block-title-name text-blue"><s:text name="workorderprogress.progressoverview"/></span>
						<span class="block-arrow open"></span>
					</div>
					<div class="content-wrapper full-height">
						<div class="content text-grey">
							<div id="block-progress-overview-total-progress">
								
							</div>
							<div id="block-progress-overview-work-order-progress">
								
							</div>
							<div id="block-progress-overview-detailed-progress">
								
							</div>
							<div id="block-progress-overview-detailed-timebased-perfomance-workorders">
								
							</div>
							<div id="block-progress-overview-detailed-timebased-perfomance-notperformed">
								
							</div>
							
						</div>
					</div>
				</div>
				
				
				
				<div class="large-block block retractable" id="block-area-progress">
					<div class="block-title">
						<span class="block-title-picto"></span>
						<span class="block-title-name text-blue"><s:text name="workorderprogress.areaprogress"/></span>
						<span class="block-arrow open"></span>
					</div>
					<div class="content-wrapper full-height">
						<div class="content text-grey">
							<div style = "height:660px;width:930px;opacity:0.99;" id="map-wrapper">
								<!-- <iframe width="930" height="660" frameborder="0" scrolling="no" marginheight="0" marginwidth="0" src="http://www.openstreetmap.org/export/embed.html?bbox=-1.55302,47.19581,-1.50817,47.22307&amp;layer=mapnik&amp;marker=47.21659,-1.53457"></iframe>  -->
								
							</div>							
					</div>
				</div>
				
			</div>
			<%@ include file="footerv311.inc"%>
		</div>
	</body>
</html>
