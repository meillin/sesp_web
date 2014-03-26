<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.capgemini.sesp.ast_sep.webclient.util.to.*"%>
<%@page import="com.capgemini.sesp.ast_sep.webclient.util.*"%>
<%@page import="com.skvader.rsp.cft.webservice_client.service.provider.ServiceProvider"%>
<%@page import="com.capgemini.sesp.ast_sep.webclient.service.StockService"%>
<%@page import="com.capgemini.sesp.ast_sep.webclient.service.AlertService"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="java.lang.StringBuilder"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map.Entry"%>
<%@page import="java.sql.*"%>
<%@page import="com.fasterxml.jackson.annotation.JsonInclude.Include"%>
<%@page import="com.fasterxml.jackson.databind.ObjectMapper"%>
<%
 
    String requestType = request.getParameter("rt");
	
	if(requestType==null){
		return;
	} 
// TESTURL: localhost:8080/ast_sep_webclient/jsp/alert-management-get-data.jsp?rt=area	
	Connection con = null;
	try {
		//con = DBConnection.getInstance().getConnection();
		
		String query = "";
		//Find all the areas for the Area Combobox
		
		if(requestType.equalsIgnoreCase("getAreas")){
			
			Long idDomain = ServiceClass.getValue(request.getParameter("domainCode"));
			Long idAreaType = ServiceClass.getValue(request.getParameter("areaTypeCode"));
						
			List<AreaTO> areas = ServiceClass.getAreas(idDomain, idAreaType, con);
			ObjectMapper om = WebClientUtils.getJsonMapper();
			out.print(om.writeValueAsString(areas));
		//Find all the device models for the device model Combobox
		} else if(requestType.equalsIgnoreCase("getDeviceModels")){
			
			Long idDomain = ServiceClass.getValue(request.getParameter("domainCode"));		
			List<UnitModelTO> unitModels = ServiceClass.getDeviceModels(con, idDomain);
			ObjectMapper om = WebClientUtils.getJsonMapper();
			out.print(om.writeValueAsString(unitModels));
		} else if(requestType.equalsIgnoreCase("getWarehouses")){
			Long idDomain = ServiceClass.getValue(request.getParameter("domainCode"));
			List<WarehouseTO> Warehouses = ServiceClass.getWarehouses(con, idDomain);
			ObjectMapper om = WebClientUtils.getJsonMapper();
			out.print(om.writeValueAsString(Warehouses));
		} else if(requestType.equalsIgnoreCase("getDeviceTypes")){
			List<UnitTypeTO> unitTypes = ServiceClass.getDeviceTypes(con);
			ObjectMapper om = WebClientUtils.getJsonMapper();
			out.print(om.writeValueAsString(unitTypes));
		} else if(requestType.equalsIgnoreCase("getMapPoints")){
			Long idDomain = ServiceClass.getValue(request.getParameter("domainCode"));
			Long idAreaT = ServiceClass.getValue(request.getParameter("areaTypeCode"));
			Long idArea = ServiceClass.getValue(request.getParameter("areaCode"));
			Long idUnitCommT = ServiceClass.getValue(request.getParameter("commTypeCode"));
			Long idUnitModel = ServiceClass.getValue(request.getParameter("deviceModelCode"));
			Long idInstMepUtilityT = ServiceClass.getValue(request.getParameter("utilityCode"));
			String from = request.getParameter("from");
			String to = request.getParameter("to");
			AlertService alertService = ServiceProvider.getInstance().getService(AlertService.class);
			//List<UnitEventTO> unitEventTOs = ServiceClass.getMapPointsUnitEvent(con, idDomain, idAreaT, idArea, idUnitCommT, idInstMepUtilityT,idUnitModel, from, to);
			List<UnitEventTO> unitEventTOs = alertService.getMapPointsUnitEvent(idDomain, idAreaT, idArea, idUnitCommT, idInstMepUtilityT,idUnitModel, from, to);
			ObjectMapper om = WebClientUtils.getJsonMapper();
			out.print(om.writeValueAsString(unitEventTOs));
		} else if (requestType.equalsIgnoreCase("inst")){
			//out.print(AlertManagementHelper.getInsts(request,con));
		} else if (requestType.equalsIgnoreCase("getEventInfo")){
			if(request.getParameter("id") == null || request.getParameter("id").equalsIgnoreCase("null")) {
				return;
			}
			Long id = Long.parseLong(request.getParameter("id"));
			ObjectMapper om = WebClientUtils.getJsonMapper();
			AlertService alertService = ServiceProvider.getInstance().getService(AlertService.class);	
			out.print(om.writeValueAsString(alertService.getEventInfo(id)));
		} else if(requestType.equalsIgnoreCase("getMapAreas")) {
			ObjectMapper om = WebClientUtils.getJsonMapper();
			Long idDomain = ServiceClass.getValue(request.getParameter("domainCode"));
			Long idAreaT = ServiceClass.getValue(request.getParameter("areaTypeCode"));
			AlertService alertService = ServiceProvider.getInstance().getService(AlertService.class);			
			out.print(om.writeValueAsString(alertService.getMapAreas(idDomain, idAreaT)));
		} else if(requestType.equalsIgnoreCase("getStockInformation")) {
			if(request.getParameter("id") == null || request.getParameter("id").equalsIgnoreCase("null")) {
				return;
			}
			Long id = Long.parseLong(request.getParameter("id"));
			
			StockService stockService = ServiceProvider.getInstance().getService(StockService.class);
	 		StockInfoTO stockInfoTO = stockService.getStockInfo(id);
	 		if(stockInfoTO==null) {				
	 			stockInfoTO = new StockInfoTO();				
			}		
			ObjectMapper om = WebClientUtils.getJsonMapper();
			out.print(om.writeValueAsString(stockInfoTO));
		} else if(requestType.equalsIgnoreCase("getStockPoints"))  {
			String idDomain = request.getParameter("domainCode");
			//List<StockPointTO> stockPointTOs = ServiceClass.getMapPointsStock(con, idDomain);
			
			StockService stockService = ServiceProvider.getInstance().getService(StockService.class);
	 		List<StockPointTO> stockPointTOs = stockService.getMapPointsStock(idDomain,"");
	 		if(stockPointTOs==null) {				
	 			stockPointTOs = new ArrayList<StockPointTO>();				
			}			
			
			ObjectMapper om = WebClientUtils.getJsonMapper();
			out.print(om.writeValueAsString(stockPointTOs));	
		//Find all the domains for the Combobox AR 10/1/2012
		} else if(requestType.equalsIgnoreCase("getDomains")){
				List<DomainTO> domains = ServiceClass.getDataDomains(con);
				ObjectMapper om = WebClientUtils.getJsonMapper();
				out.print(om.writeValueAsString(domains));
		} else if(requestType.equalsIgnoreCase("getAreaTypes")){
			List<AreaTTO> areaTypes = ServiceClass.getAreaTypes(con);
			ObjectMapper om = WebClientUtils.getJsonMapper();
			out.print(om.writeValueAsString(areaTypes));
		}  else if(requestType.equalsIgnoreCase("getUnitEventTypes")){
			List<UnitEventTTO> uniteventTypes = ServiceClass.getUnitEventTypes(con);
			ObjectMapper om = WebClientUtils.getJsonMapper();
			out.print(om.writeValueAsString(uniteventTypes));
		}  else if(requestType.equalsIgnoreCase("getInstMepUtilityTypes")){
			List<InstMepUtilityTTO> InstMepUtilityTypes = ServiceClass.getInstMepUtilityTypes(con);
			ObjectMapper om = WebClientUtils.getJsonMapper();
			out.print(om.writeValueAsString(InstMepUtilityTypes));
		}  else if(requestType.equalsIgnoreCase("getUnitCommTypes")){
				List<UnitCommTTO> UnitCommTypes = ServiceClass.getUnitCommTypes(con);
				ObjectMapper om = WebClientUtils.getJsonMapper();
				out.print(om.writeValueAsString(UnitCommTypes));
			}
		
		
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		if(con!=null) {
			//con.close();
		}
	}
%>
