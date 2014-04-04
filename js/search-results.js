jQuery(document).ready(function($){
          
    //Hide all submenu at the start
	$(".accordion ul.subMenu").hide();
	//$(".accordion ul.subMenu").show();	
	
	
});

$(function(){	
	
	renderTable("#instresults");
	renderTable("#instMepResults");
	renderTable("#instMupResults");
	renderTable("#deviceResults");
	renderTable("#caseResults");
	$(".accordion ul.subMenu").hide();

});	

function showTable(){
	$(function() {
		var instresults = $("#instresults tbody tr");
		var instMepResults = $("#instMepResults tbody tr");
		var instMupResults = $("#instMupResults tbody tr");
		var deviceResults = $("#deviceResults tbody tr");
		var caseResults = $("#caseResults tbody tr");
		
		

		if (instresults.length > 0){
			$("#block-search-results-installations").show();
		} else{
			$("#block-search-results-installations").hide();
		}
		if (deviceResults.length > 0){
			$("#block-search-results-devices").show();
		} else {
			$("#block-search-results-devices").hide();
		}
		if (instMepResults.length > 0){
			$("").show();
		} else{
			$("").hide();
		}
		if (instMupResults.length > 0){
			$("").show();
		} else {
			$("#block-search-results-devices").hide();
		}
		if (caseResults.length > 0){
			$("").show();
		} else {
			$("").hide();
		}
	});
}	





var contextPath ;
var searchId;

var i18nerrorInvalidSearchInput;
var i18nerrorInvalidSearchAction;
var i18nerrorNoDataForSearch;
var isAjaxSearch;  

var limit = 10;

var instSearchLength = 0;
var mepSearchLength = 0;
var mupSearchLength = 0;
var caseSearchLength = 0;
var deviceSearchLength = 0;

var instSearchOffset = 0;
var mepSearchOffset = 0;
var mupSearchOffset = 0;
var caseSearchOffset = 0;
var deviceSearchOffset = 0;

var normal_val = "normal";
var close_val = "close";
var open_val = "open";

function validateSearchInput(searchInputTxt) {
	
	var regexp = /^[0-9a-zA-Z ,_]{0,50}$/;	
	return regexp.test(searchInputTxt);
}

function submitOnEnter(myfield,e)
{
    var keycode;
    if (window.event) keycode = window.event.keyCode;
    else if (e) keycode = e.which;
    else return true;

    if (keycode == 13){
    	searchentities();
        return false;
    } else {
    	return true;
    }      
}

function searchentities() {

	var searchInputTxt=$("#search-input").val();
	if(searchInputTxt == null || searchInputTxt.length == 0){
		return;
	}	
	if(isAjaxSearch) {
		
		clearAll();
		reset();	
		
		$('#result-id').html(searchInputTxt);
		
	    if(validateSearchInput(searchInputTxt)) {
	    	searchInputTxt = ("'"+searchInputTxt.replace(/^[,\s]+|[,\s]+$/g, '').replace(/,[,\s]*,/g, ',')+"'").replace(/\s*,\s*/g, ',').split(',').join("','");
	    	searchId = searchInputTxt;
			var obj= {};
			obj.url=contextPath+"/std/SearchEntities.action";
			obj.pdata = "id="+searchInputTxt;
			obj.successfunc = populateSearchResults;
			obj.errorfunc = errorSearchResults;
			run_ajax_json(obj);
			return;	
			
		} else {
			errorInvalidSearchInput();
		}
	} else {
		if(validateSearchInput(searchInputTxt)) {
			window.location.replace(contextPath+"/std/ViewSearch?id="+searchInputTxt);
		} else {
			errorInvalidSearchInput();
		}
	}
}

function showMoreResults(resultType) {
	
	if(searchId!= null && resultType != null) {
		
		var obj= {};	
		switch (resultType)
		{
			case "INST":
						instSearchOffset = instSearchOffset + limit;
						obj.url=contextPath+"/std/ShowMoreInstallationSearchResults.action";
						obj.pdata = "id="+searchId+"&offset="+instSearchOffset;
						obj.successfunc = populateInstSearchResults;
						break;
			case "MEP":
						mepSearchOffset = mepSearchOffset + limit;
						obj.url=contextPath+"/std/ShowMoreMeasurepointSearchResults.action";
						obj.pdata = "id="+searchId+"&offset="+mepSearchOffset;
						obj.successfunc = populateMepSearchResults;
						break;
			case "MUP":
						mupSearchOffset = mupSearchOffset + limit;
						obj.url=contextPath+"/std/ShowMoreMultipointSearchResults.action";
						obj.pdata = "id="+searchId+"&offset="+mupSearchOffset;
						obj.successfunc = populateMupSearchResults;
						break;
			case "DEVICE":
						deviceSearchOffset = deviceSearchOffset + limit;
						obj.url=contextPath+"/std/ShowMoreDeviceSearchResults.action";
						obj.pdata = "id="+searchId+"&offset="+deviceSearchOffset;
						obj.successfunc = populateDeviceSearchResults;
						break;
			case "CASE":
						caseSearchOffset = caseSearchOffset + limit;
						obj.url=contextPath+"/std/ShowMoreCaseSearchResults.action";
						obj.pdata = "id="+searchId+"&offset="+caseSearchOffset;
						obj.successfunc = populateCaseSearchResults;
						break;
			default:
						alert(i18nerrorInvalidSearchAction);
	    }
				
		obj.errorfunc = errorShowMoreResults;
		run_ajax_json(obj);
		return;
		
	} else {
		alert(i18nerrorInvalidSearchInput);
	}	
}


function populateSearchResults(data) {
	
	if(data!=null || data != "" ) {
		
		var searchListData = eval(data);	
	
		if(searchListData.instList.length == 0 && searchListData.mepList.length == 0 
				&& searchListData.mupList.length == 0 && searchListData.deviceList.length == 0 
				&& searchListData.caseList.length == 0 ) {	
			errorSearchResults();
		}
		
		populateInstSearchResults(searchListData.instList);
		populateMepSearchResults(searchListData.mepList);
		populateMupSearchResults(searchListData.mupList);	
		populateDeviceSearchResults(searchListData.deviceList);
		populateCaseSearchResults(searchListData.caseList);
	
	} else {
		errorSearchResults();
		$(".accordion ul.subMenu").hide();		
	}
	//The below line was commented  for SESPSTD-2930 -In case of search results, only those rows which have data should drop down the list
	//$(".accordion ul.subMenu").show();		
}

function populateInstSearchResults(instData) {
	
	if(instData != null) {

		var currentInstLength = instData.length;
		instSearchLength = instSearchLength + currentInstLength;
		
		if(currentInstLength > 0) {	
			
			if(currentInstLength > limit){
				$('#block-search-results-installations-link-more').show();
				currentInstLength = limit;
			    instSearchLength = instSearchLength - 1;	          
			} else {
				$('#block-search-results-installations-link-more').hide();
			}  
					
			var trString = new StringBuffer();
			for(var i=0; i<currentInstLength; i++) {		
				var trClass = '';
				var statusClass='';
				if(i==0||i%2==0) {
					trClass = 'table-line line-grey';
				} else {
					trClass = 'table-line';
				}
				 
				var instDetail = instData[i];
				 if(instDetail.instStatus=="Active") {
					 statusClass="ok";
				 } else {
					 statusClass="error";
				 }
				 
				 trString.append("<tr class='"+trClass+"'>");				 
				 if(instDetail.id != null) {
					 trString.append("<td> &nbsp;&nbsp;&nbsp; <a href='"+contextPath+"/std/ViewInstallation?id="+instDetail.id+"' class='text-blue'>"+instDetail.id+"</a></td>");	 
				 } else {
					 trString.append("<td></td>");
				 }
				 if(instDetail.instCode != null) {
					 trString.append("<td>"+instDetail.instCode+"</td>");	 
				 } else {
					 trString.append("<td></td>");
				 }
				 if(instDetail.instEcode != null) {
					 trString.append("<td>"+instDetail.instEcode+"</td>");	 
				 } else {
					 trString.append("<td></td>");
				 }
				 if(instDetail.domain != null) {
					 trString.append("<td>"+instDetail.domain+"</td>");	 
				 } else {
					 trString.append("<td></td>");
				 }
				 if(instDetail.lastChanged != null) {
					 trString.append("<td>"+instDetail.lastChanged+"</td>");	 
				 } else {
					 trString.append("<td></td>");
				 }
				 if(instDetail.regionArea != null) {
					 trString.append("<td>"+instDetail.regionArea+"</td>");	 
				 } else {
					 trString.append("<td></td>");
				 }
				 if(instDetail.milestoneArea != null) {
					 trString.append("<td>"+instDetail.milestoneArea+"</td>");	 
				 } else {
					 trString.append("<td></td>");
				 }
				 if(instDetail.netArea != null) {
					 trString.append("<td>"+instDetail.netArea+"</td>");	 
				 } else {
					 trString.append("<td></td>");
				 }
				 if(instDetail.instStatus != null) {
					 trString.append("<td class='"+statusClass+"'>"+instDetail.instStatus+"</td>");	 
				 } else {
					 trString.append("<td></td>");
				 }
				 trString.append("</tr>");						 
				
			}
			$("#instresults > tbody").append(trString.toString());	
			openSubMenu("block-search-results-installations");
		} else {
			closeSubMenu("block-search-results-installations");
			$('#block-search-results-installations-link-more').hide();
		}  
		$('#block-search-results-installations-number').html("("+instSearchLength+")");	
	}
}

function populateMepSearchResults(mepData) {
	
	if(mepData != null) {
		
		var currentMepLength = mepData.length;
		mepSearchLength = mepSearchLength + currentMepLength;
		
		if(currentMepLength > 0) {	
	
			if(currentMepLength > limit){
				$('#block-search-results-measurepoints-link-more').show();
				currentMepLength = limit;
				mepSearchLength = mepSearchLength - 1;	          
			} else {
				$('#block-search-results-measurepoints-link-more').hide();
			}  
		
			var trString = new StringBuffer();
			for(var i=0; i<currentMepLength; i++) {	
				var trClass = '';
				var statusClass='';
				if(i==0||i%2==0) {
					trClass = 'table-line line-grey';
				} else {
					trClass = 'table-line';
				}
				 var mepDetail = mepData[i];
				 if(mepDetail.status != null && mepDetail.status=="Active") {
					 statusClass="ok";
				 } else {
					 statusClass="error";
				 }
				 
				 trString.append("<tr class='"+trClass+"'>");				 
				 if(mepDetail.id != null) {
					 trString.append("<td> &nbsp;&nbsp;&nbsp; <a href='"+contextPath+"/std/ViewMeasurepoint?id="+mepDetail.id+"' class='text-blue'>"+mepDetail.id+"</a></td>");	 
				 } else {
					 trString.append("<td></td>");
				 }
				 if(mepDetail.mepCode != null) {
					 trString.append("<td>"+mepDetail.mepCode+"</td>");	 
				 } else {
					 trString.append("<td></td>");
				 }
				 if(mepDetail.instEcode != null) {
					 trString.append("<td>"+mepDetail.instEcode+"</td>");	 
				 } else {
					 trString.append("<td></td>");
				 }
				 if(mepDetail.domain != null) {
					 trString.append("<td>"+mepDetail.domain+"</td>");	 
				 } else {
					 trString.append("<td></td>");
				 }
				 if(mepDetail.gsrn != null) {
					 trString.append("<td>"+mepDetail.gsrn+"</td>");	 
				 } else {
					 trString.append("<td></td>");
				 }
				 if(mepDetail.utility != null) {
					 trString.append("<td>"+mepDetail.utility+"</td>");	 
				 } else {
					 trString.append("<td></td>");
				 }
				 if(mepDetail.regionArea != null) {
					 trString.append("<td>"+mepDetail.regionArea+"</td>");	 
				 } else {
					 trString.append("<td></td>");
				 }
				 if(mepDetail.milestoneArea != null) {
					 trString.append("<td>"+mepDetail.milestoneArea+"</td>");	 
				 } else {
					 trString.append("<td></td>");
				 }
				 if(mepDetail.netArea != null) {
					 trString.append("<td>"+mepDetail.netArea+"</td>");	 
				 } else {
					 trString.append("<td></td>");
				 }
				 if(mepDetail.netArea != null) {
					 trString.append("<td class='"+statusClass+"'>"+mepDetail.status+"</td>");	 
				 } else {
					 trString.append("<td></td>");
				 }
				 trString.append("</tr>");		
			}	
			$("#instMepResults > tbody").append(trString.toString());
			
			openSubMenu("block-search-results-measurepoints");
		} else {
			closeSubMenu("block-search-results-measurepoints");
			$('#block-search-results-measurepoints-link-more').hide();
		}  
		$('#block-search-results-measurepoints-number').html("("+mepSearchLength+")");
	}
}


function populateMupSearchResults(mupData) {
	
	if(mupData != null) {
		
		var currentMupLength = mupData.length;
		mupSearchLength = mupSearchLength + currentMupLength;
		
		if(currentMupLength > 0) {
			
			if(currentMupLength > limit){
				$('#block-search-results-multipoints-link-more').show();
				currentMupLength = limit;
				mupSearchLength = mupSearchLength - 1;	          
			} else {
				$('#block-search-results-multipoints-link-more').hide();
			}  
			
			var trString = new StringBuffer();
			for(var i=0; i<currentMupLength; i++) {
				var trClass = '';
				if(i==0||i%2==0) {
					trClass = 'table-line line-grey';
				} else {
					trClass = 'table-line';
				}
				
				 var mupDetail = mupData[i];					 
				 trString.append("<tr class='"+trClass+"'>");				 
				 if(mupDetail.id != null) {
					 trString.append("<td> &nbsp;&nbsp;&nbsp; <a href='"+contextPath+"/std/ViewMultipoint?id="+mupDetail.id+"' class='text-blue'>"+mupDetail.id+"</a></td>");	 
				 } else {
					 trString.append("<td></td>");
				 }
				 if(mupDetail.mupCode != null) {
					 trString.append("<td>"+mupDetail.mupCode+"</td>");	 
				 } else {
					 trString.append("<td></td>");
				 }
				 if(mupDetail.domain != null) {
					 trString.append("<td>"+mupDetail.domain+"</td>");	 
				 } else {
					 trString.append("<td></td>");
				 }
				 if(mupDetail.netstation != null) {
					 trString.append("<td>"+mupDetail.netstation+"</td>");	 
				 } else {
					 trString.append("<td></td>");
				 }
				 if(mupDetail.street != null) {
					 trString.append("<td>"+mupDetail.street+"</td>");	 
				 } else {
					 trString.append("<td></td>");
				 }
				 if(mupDetail.regionArea != null) {
					 trString.append("<td>"+mupDetail.regionArea+"</td>");	 
				 } else {
					 trString.append("<td></td>");
				 }
				 if(mupDetail.milestoneArea != null) {
					 trString.append("<td>"+mupDetail.milestoneArea+"</td>");	 
				 } else {
					 trString.append("<td></td>");
				 }
				 if(mupDetail.netArea != null) {
					 trString.append("<td>"+mupDetail.netArea+"</td>");	 
				 } else {
					 trString.append("<td></td>");
				 }			 
				 trString.append("</tr>");			
			}
			$("#instMupResults > tbody").append(trString.toString());
			
			openSubMenu("block-search-results-multipoints");
			
		} else {
			closeSubMenu("block-search-results-multipoints");
			$('#block-search-results-multipoints-link-more').hide();
		}  
		$('#block-search-results-multipoints-number').html("("+mupSearchLength+")");
	}
}

function populateDeviceSearchResults(deviceData) {
	
	if(deviceData != null) {
			
		var currentDeviceLength = deviceData.length;
		deviceSearchLength = deviceSearchLength + currentDeviceLength;
		
		if(currentDeviceLength > 0) {	
			
			if(currentDeviceLength > limit){
				$('#block-search-results-devices-link-more').show();
				currentDeviceLength = limit;
				deviceSearchLength = deviceSearchLength - 1;	          
			} else {
				$('#block-search-results-devices-link-more').hide();
			}  
			
			var trString = new StringBuffer();
			for(var i=0; i<currentDeviceLength; i++) {
				var trClass = '';
				if(i==0||i%2==0) {
					trClass = 'table-line line-grey';
				} else {
					trClass = 'table-line';
				}
				 
				var deviceDetail = deviceData[i];
				
				 trString.append("<tr class='"+trClass+"'>");				 
				 if(deviceDetail.id != null) {
					 trString.append("<td> &nbsp;&nbsp;&nbsp; <a href='"+contextPath+"/std/ViewDevice?id="+deviceDetail.id+"' class='text-blue'>"+deviceDetail.id+"</a></td>");	 
				 } else {
					 trString.append("<td></td>");
				 }
				 if(deviceDetail.giai != null) {
					 trString.append("<td>"+deviceDetail.giai+"</td>");	 
				 } else {
					 trString.append("<td></td>");
				 }	
				 if(deviceDetail.serialNumber != null) {
					 trString.append("<td>"+deviceDetail.serialNumber+"</td>");	 
				 } else {
					 trString.append("<td></td>");
				 }				 
				 if(deviceDetail.propNumber != null) {
					 trString.append("<td>"+deviceDetail.propNumber+"</td>");	 
				 } else {
					 trString.append("<td></td>");
				 }
				 if(deviceDetail.type != null) {
					 trString.append("<td>"+deviceDetail.type+"</td>");	 
				 } else {
					 trString.append("<td></td>");
				 }
				 if(deviceDetail.deviceModel != null) {
					 trString.append("<td>"+deviceDetail.deviceModel+"</td>");	 
				 } else {
					 trString.append("<td></td>");
				 }
				 if(deviceDetail.timestamp != null) {
					 trString.append("<td>"+deviceDetail.timestamp+"</td>");	 
				 } else {
					 trString.append("<td></td>");
				 }
				 if(deviceDetail.status != null) {
					 trString.append("<td>"+deviceDetail.status+"</td>");	 
				 } else {
					 trString.append("<td></td>");
				 }
				 trString.append("</tr>");						
			}
			$("#deviceResults > tbody").append(trString.toString());
			openSubMenu("block-search-results-devices");
		} else {
			closeSubMenu("block-search-results-devices");
			$('#block-search-results-devices-link-more').hide();
		}  
		$('#block-search-results-devices-number').html("("+deviceSearchLength+")");
	}
}

function populateCaseSearchResults(caseData) {
	
	if(caseData != null) {
		
		var currentCaseLength = caseData.length;
		caseSearchLength = caseSearchLength + currentCaseLength;	
		
		if(currentCaseLength > 0) {
			
			if(currentCaseLength > limit){
				$('#block-search-results-cases-link-more').show();
				currentCaseLength = limit;
				caseSearchLength = caseSearchLength - 1;	          
			} else {
				$('#block-search-results-cases-link-more').hide();
			}  
			
			$("#block-search-results-cases-submenu").css("display", "none");
			
			var trString = new StringBuffer();
			for(var i=0; i<currentCaseLength; i++) {		
				var trClass = '';
				var statusClass='';
				if(i==0||i%2==0) {
					trClass = 'table-line line-grey';
				} else {
					trClass = 'table-line';
				}
				 
				var caseDetail = caseData[i];
				 var caseStatus = caseDetail.status;
				 if(caseStatus != null) {
					 caseStatus =  caseStatus.toUpperCase();
					 if(caseStatus == "IN PROGRESS") {
						 statusClass="info";
					 } else if(caseStatus == "ERROR" || caseStatus == "ERROR STARTING") {
						 statusClass="error";
					 } else {
						 statusClass="ok";
					 } 
				 }
				 
				 trString.append("<tr class='"+trClass+"'>");				 
				 if(caseDetail.id != null) {
					 trString.append("<td> &nbsp;&nbsp;&nbsp; <a href='"+contextPath+"/std/ViewCase?id="+caseDetail.id+"' class='text-blue'>"+caseDetail.id+"</a></td>");	 
				 } else {
					 trString.append("<td></td>");
				 }
				 if(caseDetail.caseType != null) {
					 trString.append("<td>"+caseDetail.caseType+"</td>");	 
				 } else {
					 trString.append("<td></td>");
				 }
				 if(caseDetail.userName != null) {
					 trString.append("<td>"+caseDetail.userName+"</td>");	 
				 } else {
					 trString.append("<td></td>");
				 }
				 if(caseDetail.lastChanged != null) {
					 trString.append("<td>"+caseDetail.lastChanged+"</td>");	 
				 } else {
					 trString.append("<td></td>");
				 }
				 if(caseDetail.status != null) {
					 trString.append("<td class='"+statusClass+"'>"+caseDetail.status+"</td>");	 
				 } else {
					 trString.append("<td></td>");
				 }	 
				 trString.append("</tr>");			
			}
			$("#caseResults > tbody").append(trString.toString());
			$(showTable);
			
			/*$("#block-search-results-cases-submenu").slideDown("normal");
			$("#block-search-results-cases-arrow").removeClass("close");
			$("#block-search-results-cases-arrow").addClass("open");*/
			openSubMenu("block-search-results-cases");
		} else {
			closeSubMenu("block-search-results-cases");
			/*$("#block-search-results-cases-submenu").slideUp("normal");
			$("#block-search-results-cases-arrow").removeClass("open");
			$("#block-search-results-cases-arrow").addClass("close");*/
			$('#block-search-results-cases-link-more').hide();
			
		}  
		$('#block-search-results-cases-number').html("("+caseSearchLength+")");

	}
	//alert("testing: "+$('#block-search-results-cases-submenu').css('display') +"," +$("#block-search-results-cases-submenu").find(":visible").text().length);
	/*$("li.toggleSubMenu  ul.subMenu").slideUp("normal");
    $("li.toggleSubMenu  ul.subMenu").parent().children('.accordion-title').children('.accordion-arrow').removeClass("open");
	$("li.toggleSubMenu  ul.subMenu").parent().children('.accordion-title').children('.accordion-arrow').addClass("close");
	*/
	
	//$("#block-search-results-cases-submenu").slideDown("normal");
	//$("#block-search-results-cases-submenu").css("display", "block");
	//$("#block-search-results-cases-submenu").hide();
	/*if($("#block-search-results-cases-submenu").find(":visible").text().length != 0){
		$("#block-search-results-cases-submenu").slideUp("normal");
	}*/	
	/*$("#block-search-results-cases-submenu").css("display", "none");
    $("#block-search-results-cases-arrow").removeClass("open");
	$("#block-search-results-cases-arrow").addClass("close");
	$(".accordion ul.subMenu").hide();*/	
	//alert("testing: "+$('#block-search-results-cases-submenu').css('display') +"," +$("#block-search-results-cases-submenu").find(":visible").text().length);
}

function closeSubMenu(menuId){
	menuId = "#" + menuId;
	$(menuId+"-submenu").slideUp(normal_val);
	$(menuId+"-arrow").removeClass(open_val);
	$(menuId+"-arrow").addClass(close_val);
}

function openSubMenu(menuId){
	menuId = "#" + menuId;
	$(menuId+"-submenu").slideDown(normal_val);
	$(menuId+"-arrow").removeClass(close_val);
	$(menuId+"-arrow").addClass(open_val);
	
}

function clearAll() {
	
	// Resetting table contents.
	$('#instresults > tbody').html(' ');
	$('#instMepResults > tbody').html(' ');    
	$('#instMupResults > tbody').html(' ');    
	$('#caseResults > tbody').html(' ');    
	$('#deviceResults > tbody').html(' ');    
	
	// Resetting search results numbers.
	$('#block-search-results-installations-number').html('(0)');    
	$('#block-search-results-measurepoints-number').html('(0)');    
	$('#block-search-results-multipoints-number').html('(0)');    
	$('#block-search-results-devices-number').html('(0)');    
	$('#block-search-results-cases-number').html('(0)'); 
	
}

function reset() {
	
	// Resetting search id.
	searchId = null;
	
	// Resetting search data length
	instSearchLength = 0;
	mepSearchLength = 0;
	mupSearchLength = 0;
	caseSearchLength = 0;
	deviceSearchLength = 0;
	
	// Resetting search offsets
	instSearchOffset=0;
	mepSearchOffset=0;
	mupSearchOffset=0;
	caseSearchOffset=0;
	deviceSearchOffset=0;
}

//Error Functions

function errorSearchResults() {
	alert(i18nerrorNoDataForSearch);
}

function errorInvalidSearchInput() {
	alert(i18nerrorInvalidSearchInput);
}

function errorShowMoreResults() {
	alert(i18nerrorNoDataForSearch);
}


// String Buffer Functions

function StringBuffer() {
	  this.buffer = [];
}

StringBuffer.prototype.append = function append(string) {
	  this.buffer.push(string);
	  return this;
};

StringBuffer.prototype.toString = function toString() {
		return this.buffer.join("");
}; 