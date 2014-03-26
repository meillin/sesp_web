<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page import="java.util.*, java.text.*, java.io.*" %>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta http-equiv="CACHE-CONTROL" content="NO-CACHE" />
<title><s:text name="webportal.head.title"/></title>
<link href="<%=request.getContextPath()%>/styles/style.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath()%>/styles/application-styles-min.css" rel="stylesheet"/>
<link href="<%=request.getContextPath()%>/styles/jquery/jquery.ui.all.css" rel="stylesheet" type="text/css" />
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>

<script src="<%=request.getContextPath()%>/js/jquery.min.js"></script>
<script src="<%=request.getContextPath()%>/js/global-scripts-min.js"></script>
<script src="<%=request.getContextPath()%>/js/jquery.selectBox.js"></script>
<script src="<%=request.getContextPath()%>/js/jquery.jqtransform.js"></script>
<script src="<%=request.getContextPath()%>/js/jquery.ui.core.js"></script>
<script src="<%=request.getContextPath()%>/js/jquery.ui.datepicker.js"></script>
<script src="<%=request.getContextPath()%>/js/sesp.js"></script>
<script src="<%=request.getContextPath()%>/js/sesp_ajax.js"></script>
<script src="<%=request.getContextPath()%>/js/fusioncharts/charts/FusionCharts.js"></script>
<script src="<%=request.getContextPath()%>/js/jquery.loadmask.min.js"></script>
<script src="<%=request.getContextPath()%>/js/functions.js"	type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/js/spin.js"></script>
<script src="<%=request.getContextPath()%>/js/ajax-loader.js"></script>

	  
    <script>
        $(document).ready(function(){
            $('.head').click(function(e){
                e.preventDefault();
                $(this).closest('li').find('.contentMT').slideToggle();
            });
        });

        contextPath = "<%=request.getContextPath()%>";

        i18nerrorPleaseentermeternumber="<s:text name='webportal.error.entermeterno'/>";
    	i18nerrorPleasechooseadate="<s:text name='webportal.error.choosedate'/>";
    	i18nerrorPleaseselectcompareparameters="<s:text name='webportal.error.choosecompareparams'/>";
    	i18nSelect="<s:text name='webportal.reports.daily.select'/>";
    	i18nJan="<s:text name='webportal.reports.daily.selectjan'/>";
    	i18nFeb="<s:text name='webportal.reports.daily.selectfeb'/>";
    	i18nMar="<s:text name='webportal.reports.daily.selectmar'/>";
    	i18nApr="<s:text name='webportal.reports.daily.selectapr'/>";
    	i18nMay="<s:text name='webportal.reports.daily.selectmay'/>";
    	i18nJun="<s:text name='webportal.reports.daily.selectjun'/>";
    	i18nJul="<s:text name='webportal.reports.daily.selectjul'/>";
    	i18nAug="<s:text name='webportal.reports.daily.selectaug'/>";
    	i18nSep="<s:text name='webportal.reports.daily.selectsep'/>";
    	i18nOct="<s:text name='webportal.reports.daily.selectoct'/>";
    	i18nNov="<s:text name='webportal.reports.daily.selectnov'/>";
    	i18nDec="<s:text name='webportal.reports.daily.selectdec'/>";    	
    	i18nerrorChartError="<s:text name='webportal.error.nodataavailable'/>";    	
    </script>  

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

<body class="pagebg" onload="getFocus('')">

<div id="wrapper"><%@ include file="header.inc"%>

<div id="middlecontainer">
<div class="headSearch">
<h2 class="mainHead"><s:text name="webportal.reports.header"/></h2>

<div id="searchTop">
	<input type="text" placeholder="<s:text name='webportal.reports.searchtext'/>" class="searchBox" name="meterno" id="meterno" value="" onkeypress="return isNumberKey(event)" maxlength="6" />
 	<img src="<%=request.getContextPath()%>/images/search_icon.png" height="22px" width="21px" onclick="getMeterDetails();"></img></div>
</div>

<ul class="tabs">	
	<li><a href="javascript:tabSwitch_2(1, 3, 'tab_', 'content_');"	id="tab_1"><s:text name="webportal.reports.dailytabtext"/></a></li>		
	<li><a href="javascript:tabSwitch_2(2, 3, 'tab_', 'content_');" id="tab_2"><s:text name="webportal.reports.monthlytabtext"/></a></li>
    <li><a href="javascript:tabSwitch_2(3, 3, 'tab_', 'content_');" id="tab_3" ><s:text name="webportal.reports.loadprofiletabtext"/></a></li>	
</ul>



<div id="tabbed_box_1" class="tabbed_box">
<div class="tabbed_area">
<form name="dailyConsumptionForm">
	<input type="hidden" name="readDatehidden" id="readDatehidden" />
	<input type="hidden" name="fromDatehidden" id="fromDatehiddenDC"/>
	<input type="hidden" name="toDatehidden" id="toDatehiddenDC"/>
	<input type="hidden" name="reportType" value="dailyConsumption" id="reportType"/>
<div id="content_1" class="content">
<div id="formtop">
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="search-box">
	<tr>
		<td></td>
		<td></td>
		<td><s:text name="webportal.reports.daily.yearly"/></td>
		<td><s:text name="webportal.reports.daily.quaterly"/></td>
		<td><s:text name="webportal.reports.daily.monthly"/></td>
		<td><s:text name="webportal.reports.daily.compare"/></td>
	</tr>
	<tr>
		<td valign="top" style="width: 180px"><input type="text"
			name="meterdate" id="meterdate"
			class="text ui-widget-content ui-corner-all" value="">
		</input></td>		
		
		<td valign="top"><a href="javascript:getDCData()" title="<s:text name='webportal.reports.viewgraph_tooltip'/>">
				<img title="<s:text name='webportal.reports.viewgraph_tooltip'/>" src="<%=request.getContextPath()%>/images/viewgraph.png" alt="<s:text name='webportal.reports.viewgraph_tooltip'/>" /></a>
		</td>

		<td valign="top">
			<select name="yearly" id="yearlyDC" onchange="validateYear(this.form)">
				<option value="0"><s:text name='webportal.reports.daily.select'/></option>
				<option value="2013">2013</option>
				<option value="2012">2012</option>
				<option value="2011">2011</option>			
			</select>
		</td>
		<td valign="top">
			<select name="quarterly" id="quarterlyDC" onchange="validateQuarter(this.form)">
				<option value="0"><s:text name='webportal.reports.daily.select'/></option>			
				<option value="1"><s:text name='webportal.reports.daily.selectfirstquarter'/></option>
				<option value="2"><s:text name='webportal.reports.daily.selectsecondquarter'/></option>
				<option value="3"><s:text name='webportal.reports.daily.selectthirdquarter'/></option>
				<option value="4"><s:text name='webportal.reports.daily.selectfourthquarter'/></option>			
			</select>
		</td>
		<td valign="top">
			<select name="monthly" id="monthlyDC" onchange="validateMontly(this.form)">
				<option><s:text name='webportal.reports.daily.select'/></option>			
				<option value="01"><s:text name='webportal.reports.daily.selectjan'/></option>
				<option value="02"><s:text name='webportal.reports.daily.selectfeb'/></option>
				<option value="03"><s:text name='webportal.reports.daily.selectmar'/></option>			
			</select>
		</td>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="checkbox-font">			
			<tr>
				<td><input type="radio" class="r1" name="compare" value="sameweekday" onclick="getDCCompareData(this.value);"/></td>
				<td><s:text name='webportal.reports.daily.compareweekday'/></td>
			</tr>
			<tr>
				<td><input type="radio" class="r1" name="compare" value="alldays" onclick="getDCCompareData(this.value);"/></td>
				<td><s:text name='webportal.reports.daily.compareallday'/></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<div class="arrowForm"><img	src="<%=request.getContextPath()%>/images/downarrow.png" alt="Arrow" /></div>
</div>

<h3 class="subhead"><s:text name='webportal.reports.daily.chartheader'/></h3>
<div class="graphLogistics" align="center">
<div id="chartdiv"></div>
</div>


</div>
</form>
</div>
</div>


<div id="tabbed_box_2" class="tabbed_box">
<div class="tabbed_area">

<form name="monthlyEnergyForm" method="post" action="/ast_sep_webclient/ReportServlet">
   <input type="hidden" name="fromDatehidden" id="fromDatehiddenEC"/> 
   <input type="hidden" name="toDatehidden" id="toDatehiddenEC"/> 
   <input type="hidden" name="meterno" id="meterno"/> 
   <input type="hidden" name="reportType" value="monthlyEnergy" />
<div id="content_2" class="content">
<div id="formtop">
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="search-box">
	<col width="80" />
	<col width="40" />
	<col width="40" />
	<col width="20" />
	<col width="10" />
	<col width="200" />

	<tr>
		<td><s:text name="webportal.reports.daily.yearly"/></td>
		<td><s:text name="webportal.reports.daily.quaterly"/></td>
		<td><s:text name="webportal.reports.daily.monthly"/></td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td valign="top" align="left"><select name="yearly" id="yearlyEC"
			onchange="validateYear(this.form)">
			<option value="0"><s:text name='webportal.reports.daily.select'/></option>
			<option value="2013">2013</option>
			<option value="2012">2012</option>
			<option value="2011">2011</option>			
		</select>
		</td>
		<td valign="top" align="left"><select name="quarterly"
			id="quarterlyEC" onchange="validateQuarter(this.form)">
				<option value="0"><s:text name='webportal.reports.daily.select'/></option>			
				<option value="1"><s:text name='webportal.reports.daily.selectfirstquarter'/></option>
				<option value="2"><s:text name='webportal.reports.daily.selectsecondquarter'/></option>
				<option value="3"><s:text name='webportal.reports.daily.selectthirdquarter'/></option>
				<option value="4"><s:text name='webportal.reports.daily.selectfourthquarter'/></option>			
		</select>
		</td>
		<td valign="top" align="left"><select name="monthly" id="monthlyEC"
			onchange="validateMontly(this.form)">
			<option><s:text name='webportal.reports.daily.select'/></option>			
			<option value="01"><s:text name='webportal.reports.daily.selectjan'/></option>
			<option value="02"><s:text name='webportal.reports.daily.selectfeb'/></option>
			<option value="03"><s:text name='webportal.reports.daily.selectmar'/></option>			
		</select></td> 					
		<td valign="top" align="left"> <a href="javascript:getECData()" title="<s:text name='webportal.reports.viewgraph_tooltip'/>">
		<img title="<s:text name='webportal.reports.viewgraph_tooltip'/>" src="<%=request.getContextPath()%>/images/viewgraph.png" alt="<s:text name='webportal.reports.viewgraph_tooltip'/>" /></a>
		</td>
		<td>&nbsp;</td>
	</tr>
</table>
<div class="arrowForm"><img
	src="<%=request.getContextPath()%>/images/downarrow.png" alt="Arrow" /></div>
</div>

<div class="clearboth">

<div class="column1ME">
<h3 class="subhead"><s:text name='webportal.reports.monthly.chartheader'/></h3>
<div id="ecmechartdiv"></div>
</div>

<div class="column1ME floatRight">
<h3 class="subhead"><s:text name='webportal.reports.monthly.summarytext'/></h3>
<div align="center" class="summary">

<table width="100%" border="0" cellspacing="1" cellpadding="5">
	<tr>
		<th colspan="3"><s:text name='webportal.reports.monthly.summarytext'/>:</th>		
	</tr>
	<tr>
		<td colspan="3" class="summerysubHead"><s:text name='webportal.reports.monthly.total'/></td>
	</tr>
	<tr>
		<td><s:text name='webportal.reports.monthly.energy'/></td>
		<td id="sumtotal">&nbsp;</td>		
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td colspan="3" class="summerysubHead"><s:text name='webportal.reports.monthly.dailyenergy'/></td>
	</tr>
	<tr>
		<td><s:text name='webportal.reports.monthly.max'/></td>	
		<td id="summax">&nbsp;</td>
		<td id="summaxdate">&nbsp;</td>
	</tr>
	<tr>
		<td><s:text name='webportal.reports.monthly.avg'/></td>	
		<td id="sumavg">&nbsp;</td>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td><s:text name='webportal.reports.monthly.min'/></td>
		<td id="summin">&nbsp;</td>
		<td id="summindate">&nbsp;</td>		
	</tr>
</table>
</div>
</div>

<div style="clear: both"></div>




<h3 class="subhead"><s:text name='webportal.reports.monthly.weekendenergyheader'/>
only</h3>
<div class="graphImgconsumption" align="center">
<div id="ecweekchartdiv"></div>
</div>
</div>
</div>
</form>


</div>
</div>





<div id="tabbed_box_3" class="tabbed_box">
	<div class="tabbed_area">		
		<form name="loadProfileform" method="post" action="/ast_sep_webclient/ReportServlet" >
			<input type="hidden" name="meterdate"/> 
			<input type="hidden" name="readDatehidden"/>
			<input type="hidden" name="meterNoHidden"/>
			<input type="hidden" name="fromDatehidden" id="fromDatehiddenLP"/>
			<input type="hidden" name="toDatehidden" id="toDatehiddenLP"/>
			<input type="hidden" name="meterno"/>
			<input type="hidden" name="reportType" value="loadProfile"/>	
			<div id="content_3" class="content">
				<div id="formtop">
					<table width="100%" border="0" cellspacing="0" cellpadding="0" class="search-box">
						<col width="20%"/> 
						<col width="20%"/> 
						<col width="15%"/> 
						<col width="10%"/> 
						<col width="10%"/> 
						<col width="10%"/> 
						<col width="15%"/> 
						<tr>
							<td><s:text name='webportal.reports.profile.fromdate'/> </td>
							<td><s:text name='webportal.reports.profile.todate'/> </td>
							<td></td>
							<td><s:text name="webportal.reports.daily.yearly"/></td>
							<td><s:text name="webportal.reports.daily.quaterly"/></td>
							<td><s:text name="webportal.reports.daily.monthly"/></td>  
							<td>&nbsp;</td>	
						</tr>
						<tr>
							<td valign="top" style="width:180px">                       
								<input type="text"  name="lpFromDate" id="lpFromDate" class="text ui-widget-content ui-corner-all" value=""> </input>                      
							</td>
							<td valign="top" align="left" style="width:180px">
								<input type="text"  name="lpToDate" id="lpToDate" class="text ui-widget-content ui-corner-all" value=""> </input>									
							</td>
							<td align="left" valign="top">
								<a href="javascript:getLPData(false)" title="<s:text name='webportal.reports.viewgraph_tooltip'/>">
									<img title="<s:text name='webportal.reports.viewgraph_tooltip'/>" src="<%=request.getContextPath()%>/images/viewgraph.png" alt="<s:text name='webportal.reports.viewgraph_tooltip'/>"/>
								</a>
							</td>
							<td valign="top">
								<select name="yearly" id="yearlyLP" onchange="validateYear(this.form)">
								<option value="0"><s:text name='webportal.reports.daily.select'/></option>
								<option value="2013">2013</option>
								<option value="2012">2012</option>
								<option value="2011">2011</option> 
								</select> 
							</td>
							<td valign="top">
								<select name="quarterly" id="quarterlyLP" onchange="validateQuarter(this.form)">
								<option value="0"><s:text name='webportal.reports.daily.select'/></option>			
								<option value="1"><s:text name='webportal.reports.daily.selectfirstquarter'/></option>
								<option value="2"><s:text name='webportal.reports.daily.selectsecondquarter'/></option>
								<option value="3"><s:text name='webportal.reports.daily.selectthirdquarter'/></option>
								<option value="4"><s:text name='webportal.reports.daily.selectfourthquarter'/></option>  
								</select>					
							</td>
							<td valign="top">
								<select name="monthly" id="monthlyLP" onchange="validateMontly(this.form)">
								<option><s:text name='webportal.reports.daily.select'/></option>			
								<option value="01"><s:text name='webportal.reports.daily.selectjan'/></option>
								<option value="02"><s:text name='webportal.reports.daily.selectfeb'/></option>
								<option value="03"><s:text name='webportal.reports.daily.selectmar'/></option>           
								</select>					
							</td>
							<td align="left" valign="top">
								<a href="javascript:getLPData(true)" title="<s:text name='webportal.reports.viewgraph_tooltip'/>">
									<img src="<%=request.getContextPath()%>/images/viewgraph.png" alt="<s:text name='webportal.reports.viewgraph_tooltip'/>"/>
								</a>   
							</td>                               
						
						</tr>
					</table>
					<div class="arrowForm"><img	src="<%=request.getContextPath()%>/images/downarrow.png" alt="Arrow" /></div>
				</div>
				<h3 class="subhead"><s:text name='webportal.reports.profile.chartheader'/></h3>
				<div class="graphImgconsumption" align="center">
				<div id="lpchartdiv"></div>
				</div>
			</div>
		</form> 
	</div>
</div>
<!--
<div id="tabbed_box_2" class="tabbed_box">
	<div class="tabbed_area">		
		<form name="loadProfileform" method="post" action="/ast_sep_webclient/ReportServlet" >
			
			<div id="content_2" class="content">
				<div id="formtop">
					
					<div class="arrowForm"><img src="/ast_sep_webclient/jsp/images/downarrow.png" alt="Arrow" /></div>
				</div>
				<h3 class="subhead">Monthly</h3>
				<div class="graphImgconsumption" align="center">
				</div>
			</div>
		</form> 
	</div>
</div>
-->
<!-- tab end area --> <!-- meter details section start -->
<div class="meterDT">

<ul>
	<li><a href="#" class="head"><s:text name='webportal.reports.details.header'/></a>
	<div class="contentMT">
	<div class="meterDTcontent">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
		class="meterDetails">
		<tbody>
			<tr>
				<td valign="top" class="mdthead"><s:text name='webportal.reports.details.meterno'/>:</td>
				<td style="width: 250px;" id="mdid"></td>
			</tr>
			<tr>
				<td valign="top" class="mdthead"><s:text name='webportal.reports.details.mepcode'/>:</td>
				<td id="mdmepcode"></td>
			</tr>
			<tr>
				<td valign="top" class="mdthead"><s:text name='webportal.reports.details.streetstreetno'/>:</td>
				<td id="mdstreet"></td>
			</tr>
			<tr>
				<td valign="top" class="mdthead"><s:text name='webportal.reports.details.postcode'/>:</td>
				<td id="mdpcode"></td>
			</tr>
			<tr>
				<td valign="top" class="mdthead"><s:text name='webportal.reports.details.city'/>:</td>
				<td id="mdcity"></td>
			</tr>			

			<tr>
				<td valign="top" class="mdthead"><s:text name='webportal.reports.details.custname'/>:</td>
				<td id="mdcust"></td>
			</tr>
			<tr>
				<td valign="top" class="mdthead"><s:text name='webportal.reports.details.custno'/>:</td>
				<td id="mdcustno"></td>
			</tr>
			<tr>
				<td valign="top" class="mdthead"><s:text name='webportal.reports.details.fusetype'/>:</td>
				<td id="mdfuse"></td>
			</tr>
			<tr>
				<td valign="top" class="mdthead"><s:text name='webportal.reports.details.metersno'/>:</td>
				<td id="mdsno"></td>
			</tr>
			<tr>
				<td valign="top" class="mdthead"><s:text name='webportal.reports.details.metermodel'/>:</td>
				<td id="mdmodel"></td>
			</tr>
			<tr>
				<td valign="top" class="mdthead"><s:text name='webportal.reports.details.metertype'/>:</td>
				<td id="mdtype"></td>
			</tr>
		</tbody>
	</table>
	
	</div>
	</div>
	</li>
</ul>
<!-- meter details section end -->
</div>

</div>
<%@ include file="footer.inc"%>
</div>
</body>
</html>
