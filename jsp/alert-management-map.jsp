<!DOCTYPE html>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="java.sql.*"%>
<%@page import="java.util.*, java.text.*" %>
<%@page import="com.capgemini.sesp.ast_sep.webclient.util.*"%>
<%@page import="com.capgemini.sesp.ast_sep.webclient.util.to.*"%>
<%@page import="com.capgemini.sesp.ast_sep.webclient.util.DBConnection"%>
<%
	Connection con = DBConnection.getInstance().getConnection();
	List<UnitEventTTO> unitEventTTOs = ServiceClass.getUnitEventTypes(con);
	Map<Long, String> selectedImage = new HashMap<Long, String>();
	Map<Long, String> unselectedImage = new HashMap<Long, String>();
	String[] symbols = new String[] {"blue","green","orange","pink","purple","red","yellow"};
	
	int symbolCounter = 0;
	for(UnitEventTTO unitEventTTO : unitEventTTOs) {
		unselectedImage.put(unitEventTTO.getId(), ((HttpServletRequest)pageContext.getRequest()).getContextPath() + "/jsp/images/silk/bullet_" + symbols[symbolCounter%symbols.length] + ".png");
		selectedImage.put(unitEventTTO.getId(),  ((HttpServletRequest)pageContext.getRequest()).getContextPath() + "/jsp/images/silk/flag_" +symbols[symbolCounter%symbols.length] + ".png");
		symbolCounter++;	
	
	}
%>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <META HTTP-EQUIV="Pragma" CONTENT="no-cache">    
        <META HTTP-EQUIV="Expires" CONTENT="-1">            
        <title>SESP Report Map</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="">
        <meta name="author" content="">
        
        
        <!-- Le styles -->     
        <link href="/ast_sep_webclient/jsp/styles/global-styles-min.css" rel="stylesheet"> 
        <link href="/ast_sep_webclient/jsp/styles/style.css" rel="stylesheet">
        <link href="/ast_sep_webclient/jsp/styles/application-styles-min.css" rel="stylesheet">  
        
        <script src="/ast_sep_webclient/jsp/js/OpenLayers.js"></script>
    	<link rel="stylesheet" href="/ast_sep_webclient/jsp/styles/style.tidy.css" type="text/css" />
   		<script src="/ast_sep_webclient/jsp/map.js"></script>
   		
   		<script type ="text/javascript">
   			function displayInfo(id) {
   				if(id == null) {
   					document.getElementById("pointInfo").innerHTML = "";
   				} else {
   					document.getElementById("pointInfo").innerHTML = id + " clicked";
   				}
   				
   			}
   			
   			function infoDataCallback(id) {
   				var data;
   				$.ajax({
   			        url: "/ast_sep_webclient/jsp/alert-management-get-data.jsp?rt=getEventInfo&id=" + id,
   			        type: 'GET',
   			        async: false,
   			        cache: false,
   			        timeout: 30000,
   			        error: function(msg){
   			        	data = "error:" + msg;
   			        },
   			        success: function(msg){ 
   			        	if(msg == "") {
	   							return;
	   						}
	   						var o = eval("(" + msg+")");
	   						html = "<div style=\"font-size:.8em;background-color:yellow;border-radius: 5px;\">";
	   						html += "<div> start:" + o.startTimestamp +"</div> ";
	   						html += "<div> end:" + o.endTimestamp +"</div> ";
	   						html += "<div> measurepoint: " + o.measurePointCode +"</div> ";
	   						html += "<div> model:" + o.modelName +"</div> ";
	   						html += "</div>";
	   						data =  html;
   			        }
   			    });
                return data;
   			}
   		
   			function refresh() {
   				var domainCode = document.getElementById("DOMAIN").value;
   				var areaTypeCode = document.getElementById("AREA_T").value;
   				var areaCode = document.getElementById("AREA").value;
   				var commTypeCode = document.getElementById("COMM_TYPES").value;
   				var deviceModelCode = document.getElementById("DEVICE_MODEL").value;
   				var utilityCode = document.getElementById("UTILITY").value;
   				var from = document.getElementById("fromDate").value;
   				var to = document.getElementById("toDate").value;
   				//Get all the new points in the map
   				$.get(
   					"/ast_sep_webclient/jsp/alert-management-get-data.jsp?rt=getMapPoints" + 
   							"&domainCode=" + domainCode + 
   							"&areaTypeCode=" +areaTypeCode +
   							"&areaCode=" + areaCode + 
   							"&commTypeCode=" +commTypeCode +
   							"&deviceModelCode=" +deviceModelCode + 
   							"&utilityCode=" +utilityCode + 
   							"&from=" +from + 
   							"&to=" +to ,
   					function(data) {
   						function getPointCollection(object, pointCollections) {
   							var pointCollection = pointCollections[object.idUnitEventT];
   							if(typeof pointCollection == "undefined") {
   								<%
   									for(UnitEventTTO unitEventTTO : unitEventTTOs) {
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
   				  		alert("PointData:\r\n" + data);
   					}	
   				);
   					
   					
   				//Get all the new areas in the map
   	   				$.get(
   	   					"/ast_sep_webclient/jsp/alert-management-get-data.jsp?rt=getMapAreas" + 
   	   							"&domainCode=" + domainCode + 
   	   							"&areaTypeCode=" +areaTypeCode ,
   	   					function(data) {
   	   						createAreaJSON(data);
   	   						alert("AreaData:\r\n" + data);
   	   					}	
   	   				);
   			}
   			function area_t_domain_changed() {
   				var domainCode = document.getElementById("DOMAIN").value;
   				var areaTypeCode = document.getElementById("AREA_T").value;
   				
   				//Update the areas
   				$.get(
   					"/ast_sep_webclient/jsp/alert-management-get-data.jsp?rt=getAreas&domainCode=" + domainCode + "&areaTypeCode=" +areaTypeCode ,
   					function(data) {
   						var areaObject = eval('(' + data + ')');
   						element = document.getElementById("AREA");
   						var html = "<option value=\"ALL\">All Areas</option>";
   						for(var i = 0; i< areaObject.length; i++) {
   				  			var area = areaObject[i];
   				  			html += "<option value=\"" + area.id + "\">" + area.name + "</option>";
   				  		}
   						element.innerHTML = html;
   					}	
   	   			);
   				
   				//Update the device model list
   				$.get(
   	   					"/ast_sep_webclient/jsp/alert-management-get-data.jsp?rt=getDeviceModels&domainCode=" + domainCode,
   	   					function(data) {
   	   						var deviceObject = eval('(' + data + ')');
   	   						element = document.getElementById("DEVICE_MODEL");
   	   						var html = "<option value=\"ALL\"> All Device Models</option>";
   	   						for(var i = 0; i< deviceObject.length; i++) {
   	   				  			var deviceModel = deviceObject[i];
   	   				  			html += "<option value=\"" + deviceModel.id + "\">" + deviceModel.name + "</option>";
   	   				  		}
   	   						element.innerHTML = html;
   	   					}	
   	   	   			);
   			}
   		</script>
    </head>
    <body onLoad="init();">    
        <!-- Navbar
        ================================================== -->
        <nav class="navbar">   
              <div class="custom-navbar-inner">
                <div class="container-fluid">
                    <div class="row-fluid">
                    		 <div class="columns1">
                             	<div class="logo"><a href="#"><img src="/ast_sep_webclient/jsp/img/logo.png"></a></div>
                             </div>
                              <div class="columns9">
                             	<div class="logo"><a class="brand" href="mainscreen.html"><b>Smart Energy Services</b> Platform</a></div>
                             </div>
                      <!--  <div class="columns2">
                          <div class="meter-input-box"><input type="text" class="columns12"  placeholder="Enter Meter Number"></div>
                        </div>
                        <div class="columns3">
                         <div style="float:left"><button type="submit" class="btn" style="float:right">View Consumption Reports</button>		                              </div>
                        </div>-->
                            <div class="columns2">
                             <!-- <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
                                <span class="icon-bar"></span>
                                <span class="icon-bar"></span>
                                <span class="icon-bar"></span>
                              </a>-->
                                   <div class="pull-right margin-top20">
                                    <a href="#" title="User" class="signout"><i class="icon-user"></i></a> 
                                    <a href="#" title="Email" class="signout"><i class="icon-envelope"></i></a>
                                    <a href="#" title="Sign Out" class="signout"><i class="icon-off"></i></a> 
                                  </div>
                          </div>
                  </div><!--/row -->
                 </div><!--/.fluid-container-->
              </div>
        </nav> 



        <!-- Map Area ================================================== -->
       <div class="rounded-border5 margin-top10">
          	<div class="title-bgcolor5 padding5">
        		<h4 class="title-color5">Alert Map</h4>
        		<br/>
        		<form>
	        		Domain:
	        		<select id = "DOMAIN" onChange="javascript:area_t_domain_changed()">
	        			<%
	        				for(DomainTO domain : ServiceClass.getDataDomains(con)) {
	        					%>
	        						<option value="<%out.print(domain.getId());%>"><%out.print(domain.getName());%></option>
	        					<%
	        				}
	        			%>
					</select> 
					Area Type:
	        		<select id = "AREA_T" onChange="javascript:area_t_domain_changed()">
	        			<%
	        				for(AreaTTO areaTTO : ServiceClass.getAreaTypes(con)) {
	        					%>
	        						<option value="<%out.print(areaTTO.getId());%>"><%out.print(areaTTO.getName());%></option>
	        					<%
	        				}
	        			%>
					</select> 
					Area:
	        		<select id = "AREA">
	        			<option value="ALL">All Areas</option>
					</select> 
					Communication Types:
	        		<select id = "COMM_TYPES">
	        			<option value="ALL">All Communication Types</option>
	        			<%
	        				for(UnitCommTTO unitCommTTO : ServiceClass.getUnitCommTypes(con)) {
	        					%>
	        						<option value="<%out.print(unitCommTTO.getId());%>"><%out.print(unitCommTTO.getName());%></option>
	        					<%
	        				}
	        			%>
					</select> 
					Device Model:
	        		<select id = "DEVICE_MODEL">
	        			<option value="ALL">All Device Models</option>
					</select> 
					Utility:
	        		<select id = "UTILITY">
	        			<option value="ALL">All Utilities</option>
	        			<%
	        				for(InstMepUtilityTTO instMepUtilityType : ServiceClass.getInstMepUtilityTypes(con)) {
	        					%>
	        						<option value="<%out.print(instMepUtilityType.getId());%>"><%out.print(instMepUtilityType.getName());%></option>
	        					<%
	        				}
	        			%>
					</select> 
					
					<span class="input-append date"  id="dp1" data-date='todaydate' data-date-format="yyyy-mm-dd" data-date-today-btn="true">
                       <input type="text" id="fromDate" name="meterdate" style="width:100px" value="<%="2010-09-08"/*readDate*/%>">
                       <span class="add-on"><i class="icon-calendar"></i></span>										  
                     </span> 
                     <span class="input-append date" data-date='todaydate' id="dp2" data-date-format="yyyy-mm-dd" data-date-today-btn="true">
                       <input type="text" id = "toDate" name="meterdate"  style="width:100px" value="<%="2012-09-08"/*readDate*/%>">
                       <span class="add-on"><i class="icon-calendar"></i></span>										  
                  	</span> 
					<input type="button" onclick="refresh()" value="Search"/>
        		</form>
        		
        		<%
        			for(UnitEventTTO uniEventTTO : unitEventTTOs) {
        				%>
        				<img src="<%=unselectedImage.get(uniEventTTO.getId())%>"/>
        				<img src="<%=selectedImage.get(uniEventTTO.getId())%>"/>
        				<span>
	        				<%=uniEventTTO.getCode()%>
	        			</span>
        				<% 
        			}
        		
        		%>
        		<div></div>
        		<div id="basicMap" style="width: 1024px; height: 400px; border: 1px solid #ccc; float: right;"></div>
        		
        		<div id="pointInfo" style="height: 400px; border: 1px solid #ccc;">
        			
        		</div>
        		
		    </div><!--/title-bgcolor -->
            
            <div id="Summary-table" class="hide show-details">
       			
      		</div>
        </div><!--/rounded-border -->
        
        
        <!-- Modal Window-->
            <div class="modal hide" id="myMeaterModal">
              <div class="modal-header">
                <button type="button" class="close cmodal-close" data-dismiss="modal">×</button>
                <h3>Meter Number</h3>
              </div>
              <div class="modal-body">
                <input type="text" class="columns5">
              </div>
              <div class="modal-footer">
                <a href="#" class="btn cmodal-close" data-dismiss="modal">Close</a>
                <a href="#" class="btn btn-info cmodal-close" data-dismiss="modal">View Consumption Reports</a>
              </div>
            </div><!--/modal window -->
                            
                            
        <!-- Footer
        ================================================== -->    
        <section id="footer">
        	<br/>
            <div class="container-fluid">
                <div class="row-fluid" style="padding-top: 100px;">
                    <div class="columns12">
                        <footer class="footer">
                            <p class="columns12" id = "apa">© Capgemini 2012</p>
                        </footer>
                    </div>
                </div><!--/row -->
            </div><!--/.fluid-container-->
        </section>
        <!-- Le javascript
        ================================================== -->
        <!-- Placed at the end of the document so the pages load faster -->
        
        <script src="/ast_sep_webclient/jsp/js/jquery.min.js"></script>
        <script src="/ast_sep_webclient/jsp/js/global-scripts-min.js"></script>
        <script type ="text/javascript" src="/ast_sep_webclient/jsp/js/jquery.jdpicker.js"></script>
        <script type ="text/javascript" src="/ast_sep_webclient/jsp/js/jquery.jqtransform.js"></script>
        <script src="/ast_sep_webclient/jsp/js/application-scripts-min.js"></script>
        <script type="text/javascript" src="/ast_sep_webclient/jsp/js/jquery-ui.js"></script>
        <script type="text/javascript" src="/ast_sep_webclient/jsp/js/ui.js"></script>
        
		<script>
			area_t_domain_changed();
		</script>
        
      </body>
</html>
