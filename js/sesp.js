	
	var contextPath ;
	var i18nerrorPleaseentermeternumber;
	var i18nerrorPleasechooseadate;
	var i18nerrorPleaseselectcompareparameters;
	var i18nSelect;
	var i18nJan;
	var i18nFeb;
	var i18nMar;
	var i18nApr;
	var i18nMay;
	var i18nJun;
	var i18nJul;
	var i18nAug;  
	var i18nSep;
	var i18nOct;
	var i18nNov;
	var i18nDec;
	var i18nerrorPleaseEnterUsername;
	var i18nerrorPleaseEnterPassword;
	var i18nerrorChartError;
	
	function validateGetMeterDetails()
   {	   
		if(document.getElementById("meterno").value=="")
		{
			alert(i18nerrorPleaseentermeternumber);			
			return false;
		}
	   return true;
   }

	function validateDCAggregation() {		
		if(document.getElementById("meterno").value=="")
		{
			alert(i18nerrorPleaseentermeternumber);			
			return false;
		}
		if(document.getElementById("meterdate").value=="")
		{
			alert(i18nerrorPleasechooseadate);			
			return false;
		}
		return true;
	}	
          
	function validateComparisonAggregation() {		
		if(document.getElementById("meterno").value=="")
		{
			alert(i18nerrorPleaseentermeternumber);		
			for (i = 0; i < document.getElementsByName('compare').length; i++) {
							
				document.getElementsByName('compare')[i].checked=false;                 
            }
			return false;
		}
		
		if(document.getElementById("meterdate").value=="")
		{
			alert(i18nerrorPleasechooseadate);			
			return false;
		}
		
		

		if(document.getElementById("meterdate").value != null ){
			var meterDate = document.getElementById("meterdate").value;
			var readDatehidden = document.getElementById("readDatehidden");
			if (meterDate.length == 0) {
				meterDate = new Date();
				meterDate = meterDate.getFullYear() + (meterDate.getMonth() + 1) + (meterDate.getDate() - 1);					
				readDatehidden.value=meterDate;			
			}else{		
				readDatehidden.value = meterDate;			
			}
		}		
		assignFromDate('DC');
		assignToDate('DC');	
	    
	    if(document.getElementById("fromDatehiddenDC").value==""||document.getElementById("fromDatehiddenDC").value==null || document.getElementById("toDatehiddenDC").value==""||document.getElementById("toDatehiddenDC").value==null)
		{
			alert(i18nerrorPleaseselectcompareparameters);
			return false;
		}
        
        return true;
	}
	
	function validateLP1Aggregation() {		
		if(document.getElementById("meterno").value=="")
		{
			alert(i18nerrorPleaseentermeternumber);			
			return false;
		}
		if(document.getElementById("lpFromDate").value=="" || document.getElementById("lpToDate").value=="")
		{			
			alert(i18nerrorPleasechooseadate);			
			return false;
		}		
		return true;
	}
	
	function validateLP2Aggregation() {		
		if(document.getElementById("meterno").value=="")
		{
			alert(i18nerrorPleaseentermeternumber);			
			return false;
		}		
			
		assignFromDate('LP');
		assignToDate('LP');
		
	    document.getElementById("lpFromDate").value =document.getElementById("fromDatehiddenLP").value;
	    document.getElementById("lpToDate").value =document.getElementById("toDatehiddenLP").value;
	    
	    if(document.getElementById("fromDatehiddenLP").value==""||document.getElementById("fromDatehiddenLP").value==null || document.getElementById("toDatehiddenLP").value==""||document.getElementById("toDatehiddenLP").value==null)
		{
	    	alert(i18nerrorPleasechooseadate);	
			return false;
		}		
				
		return true;
	}
	
	
	function validateMontlyConsumption()
	   {	   
			if(document.getElementById("meterno").value=="")
			{
				alert(i18nerrorPleaseentermeternumber);			
				return false;
			}
			if(document.getElementById("yearlyEC").value=="0")
			{
				alert(i18nerrorPleasechooseadate);			
				return false;
			}
		   return true;
	  }
	

	function populateFromDate(year, quarter, month )
	{
		//var fromDatehidden = document.dailyConsumptionForm.fromDatehidden;
		var fromDatehidden = document.getElementById("fromDatehidden");
		var quarterStart = new Array("01","04","07","10");
		var yearValue = year;
		if(yearValue!=0)
        {		    
     	   // fromDatehidden.value=yearValue+"/01/01";     	   
     	  fromDatehidden.value=yearValue+"0101";
        }
        if(yearValue !=0 && quarter !=0)
        {
        	fromDatehidden.value = yearValue+quarterStart[quarter-1]+"01";
           //fromDatehidden.value = year+"/"+quarterStart[quarter-1]+"/"+"01";
        }
        if(yearValue !=0 && quarter !=0 && month !=0 )
        {
        	fromDatehidden.value = yearValue+month+"01";
        	//fromDatehidden.value = year+"/"+month+"/"+"01";
        }
        //alert("From Date " + fromDatehidden.value);
	} 

   function populateToDate(year, quarter, month) 
	 {		 
	   var toDatehidden = document.getElementById("toDatehidden");
	   var quarterEndMonth = new Array("03","06","09","12");
	   var quarterEndDate = new Array("31","30","30","31");
	   var monthEndDate = new Array("31","28","31","30","31","30","31","31","30","31","30","31");  
	   var yearValue = year;
	   if(yearValue!=0)
       {
		   toDatehidden.value=yearValue+"1231";
    	  //toDatehidden.value=year+"/12/31";     	   
       }
	   if(yearValue !=0 && quarter !=0)
       {
		   toDatehidden.value = yearValue+quarterEndMonth[quarter-1]+quarterEndDate[quarter-1];
          //toDatehidden.value = year+"/"+quarterEndMonth[quarter-1]+"/"+quarterEndDate[quarter-1];
       }
       if(yearValue !=0 && quarter !=0 && month !=0 )
       {
    	//toDatehidden.value = yearValue+"/"+month+"/"+monthEndDate[month-1];
       	toDatehidden.value = yearValue+month+monthEndDate[month-1];
       }
       //alert("To Date " + toDatehidden.value);
     } 


   function disableElements(formRef) {	  
	   //formRef.yearly.selectedIndex=0;	   
	 //  formRef.yearly.disabled=true;	   
		formRef.quarterly.selectedIndex=0;
		//document.getElementById("quarterly").selectedIndex = 0;
		formRef.quarterly.disabled=true;
		//document.getElementById('quarterly').disabled = true;		
		formRef.monthly.selectedIndex=0;
		//document.getElementById("monthly").selectedIndex = 0;
		formRef.monthly.disabled=true;
		//document.getElementById('monthly').disabled = true;
		//formRef.weekly.selectedIndex=0;
		//document.getElementById("weekly").selectedIndex = 0;
		//formRef.weekly.disabled=true;
		//document.getElementById('weekly').disabled = true;
		 if(formRef==document.dailyConsumptionForm)
		 {
			  for(i=0;i<formRef.compare.length;i++)
				{	//alert("Before clearing radio buttons");
	                 formRef.compare[i].checked=false;
	            }
		 }
   }

	function validateYear(formRef) {
		//alert("Inside validate year");
		
		//var yearList = document.dailyConsumptionForm.yearly;
		var yearList = formRef.yearly;	

		 if(formRef==document.loadProfileform) {

			 formRef.lpFromDate.value="";
			 formRef.lpToDate.value="";			 
		 }
		
		//alert ("Value  " + yearList[yearList.selectedIndex].value);
		if (yearList[yearList.selectedIndex].value != "0") {
			formRef.quarterly.disabled=false;
			//document.getElementById('quarterly').disabled = false;
			formRef.quarterly.selectedIndex=0;
			//document.getElementById("quarterly").selectedIndex = 0;
			formRef.monthly.selectedIndex=0;
			//document.getElementById("monthly").selectedIndex = 0;
			formRef.monthly.disabled=true;
			//document.getElementById('monthly').disabled = true;			
			//formRef.weekly.selectedIndex=0;
			//document.getElementById("weekly").selectedIndex = 0;
			//formRef.weekly.disabled=true;
			//document.getElementById('weekly').disabled = true;
			if(formRef==document.dailyConsumptionForm)
			 {
			  for(i=0;i<formRef.compare.length;i++)
				{	//alert("Before clearing radio buttons");
	                 formRef.compare[i].checked=false;
	            }
			 }			
		 } else {
			disableElements(formRef);
		}
	}

	function validateQuarter(formRef) {

		
		//var quarterList = document.dailyConsumptionForm.quarterly;
		var quarterList = formRef.quarterly;
		//document.getElementById('monthly').disabled=false;
		//alert ("Value  " + quarterList[quarterList.selectedIndex].value);
		if (quarterList[quarterList.selectedIndex].value != "0") {
			//alert("inside if");
			formRef.monthly.disabled=false;
			//document.getElementById('monthly').disabled = false;
			if(formRef==document.dailyConsumptionForm)
			 {
			  for(i=0;i<formRef.compare.length;i++)
				{	//alert("Before clearing radio buttons");
	                 formRef.compare[i].checked=false;
	            }
		     }
		} else {
			formRef.monthly.selectedIndex=0;
			//document.getElementById("monthly").selectedIndex = 0;
			formRef.monthly.disabled=true;
			//document.getElementById('monthly').disabled = true;
			//formRef.weekly.selectedIndex=0;
			//document.getElementById("weekly").selectedIndex = 0;
			//formRef.weekly.disabled=true;
			//document.getElementById('weekly').disabled = true;
			if(formRef==document.dailyConsumptionForm)
			 {
			  for(i=0;i<formRef.compare.length;i++)
				{	//alert("Before clearing radio buttons");
	                 formRef.compare[i].checked=false;
	            }
		     }
		}

		//var quarterList = document.dailyConsumptionForm.quarterly;
		var quarterList = formRef.quarterly;
		//ClearOptions(document.dailyConsumptionForm.monthly);
        ClearOptions(formRef.monthly); 
		if (quarterList[quarterList.selectedIndex].value == "0") {
			//AddToOptionList(document.dailyConsumptionForm.monthly, "", "--Select--");
			AddToOptionList(formRef.monthly, "", i18nSelect);
		}

		if (quarterList[quarterList.selectedIndex].value == "1") {
			//AddToOptionList(document.dailyConsumptionForm.monthly, "0", "--Select--");
			AddToOptionList(formRef.monthly, "0", i18nSelect);
			AddToOptionList(formRef.monthly, "01", i18nJan);
			AddToOptionList(formRef.monthly, "02", i18nFeb);
			AddToOptionList(formRef.monthly, "03", i18nMar);
			//formRef.weekly.selectedIndex=0;
			//document.getElementById("weekly").selectedIndex = 0;
		}

		if (quarterList[quarterList.selectedIndex].value == "2") {
			//AddToOptionList(document.dailyConsumptionForm.monthly, "0", "--Select--");
			AddToOptionList(formRef.monthly, "0", i18nSelect)
			AddToOptionList(formRef.monthly, "04", i18nApr);
			AddToOptionList(formRef.monthly, "05", i18nMay);
			AddToOptionList(formRef.monthly, "06", i18nJun);
			//formRef.weekly.selectedIndex=0;
			//document.getElementById("weekly").selectedIndex = 0;
		}
		if (quarterList[quarterList.selectedIndex].value == "3") {
			//AddToOptionList(document.dailyConsumptionForm.monthly, "0", "--Select--");
			AddToOptionList(formRef.monthly, "0", i18nSelect);
			AddToOptionList(formRef.monthly, "07", i18nJul);
			AddToOptionList(formRef.monthly, "08", i18nAug);
			AddToOptionList(formRef.monthly, "09", i18nSep);
			//formRef.weekly.selectedIndex=0;
			//document.getElementById("weekly").selectedIndex = 0;
		}
		if (quarterList[quarterList.selectedIndex].value == "4") {
			//AddToOptionList(document.dailyConsumptionForm.monthly, "0", "--Select--");
			AddToOptionList(formRef.monthly, "0", i18nSelect);
			AddToOptionList(formRef.monthly, "10", i18nOct);
			AddToOptionList(formRef.monthly, "11", i18nNov);
			AddToOptionList(formRef.monthly, "12", i18nDec);
			//formRef.weekly.selectedIndex=0;
			//document.getElementById("weekly").selectedIndex = 0;
		}
	}

	function validateMontly(formRef) {
		
		var montlyList = formRef.monthly;
		if (montlyList[montlyList.selectedIndex].value != "0") {
			//formRef.weekly.disabled=false;
			//document.getElementById('weekly').disabled = false;
			//formRef.weekly.selectedIndex=0;
			//document.getElementById("weekly").selectedIndex = 0;
			if(formRef==document.dailyConsumptionForm)
			 {
			  for(i=0;i<formRef.compare.length;i++)
				{	//alert("Before clearing radio buttons");
	                 formRef.compare[i].checked=false;
	            }
		     }
		} else {
			//formRef.weekly.selectedIndex=0;
			//document.getElementById("weekly").selectedIndex = 0;
			//formRef.weekly.disabled=true;
			//document.getElementById('weekly').disabled = true;
			if(formRef==document.dailyConsumptionForm)
			 {
			  for(i=0;i<formRef.compare.length;i++)
				{	//alert("Before clearing radio buttons");
	                 formRef.compare[i].checked=false;
	            }
		     }
		}
	}

	function ClearOptions(OptionList) {
		for (x = OptionList.length; x >= 0; x = x - 1) {
			OptionList[x] = null;
		}
	}

	function AddToOptionList(OptionList, OptionValue, OptionText) {
		OptionList[OptionList.length] = new Option(OptionText, OptionValue);
	}

	function getFocus(reportType) {
		$('#date').datepicker({
 			//dateFormat: 'DD, MM dd, yy',
 			dateFormat: 'dd-M-yy',
 			//dateFormat: 'yymmdd',
 			showOn: "button",
 			buttonImage: contextPath+"/images/calendar.gif",
 			buttonImageOnly: true
 			});
		$('#meterdate').datepicker({
 			//dateFormat: 'DD, MM dd, yy',
 			dateFormat: 'yymmdd',
 			showOn: "button",
 			buttonImage: contextPath+"/images/calendar.gif",
 			buttonImageOnly: true
 			});
		$('#lpToDate').datepicker({
 			//dateFormat: 'DD, MM dd, yy',
 			dateFormat: 'yymmdd',
 			showOn: "button",
 			buttonImage: contextPath+"/images/calendar.gif",
 			buttonImageOnly: true
 			});
		$('#lpFromDate').datepicker({
 			//dateFormat: 'DD, MM dd, yy',
 			dateFormat: 'yymmdd',
 			showOn: "button",
 			buttonImage: contextPath+"/images/calendar.gif",
 			buttonImageOnly: true
 			});
		document.getElementById('meterno').focus();
		//alert("report Type " + reportType);
		if(reportType == "dailyConsumption")
		{
			tabSwitch_2(1, 3, 'tab_', 'content_');
		}
		else if(reportType == "monthlyEnergy")
		{
			tabSwitch_2(2, 3, 'tab_', 'content_');
		}
		else if(reportType == "loadProfile")
		{
			tabSwitch_2(3, 3, 'tab_', 'content_');
		}else
		{
			tabSwitch_2(1, 3, 'tab_', 'content_');
		}		
		//document.dailyConsumptionForm.yearly.focus();		
	}

	function clearFields(formRef) {		
		if(formRef==document.loadProfileform)
			{
			//alert("Inside clearfields");
			formRef.yearly.selectedIndex=0;
		}
	}

	function isNumberKey(evt)
    {
       var charCode = (evt.which) ? evt.which : event.keyCode
       if (charCode > 31 && (charCode < 48 || charCode > 57))
          return false;

       return true;
    }
	
	
	function submitLogin(formRef)
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
		loginSpinner();
		formRef.submit();	
	}
	
	function toggleSubmitBtn(formRef) {		
		if(formRef.username.value!="" && formRef.password.value!="") {
			document.getElementById("divenable").style.display="block";
			document.getElementById("divdisable").style.display="none";			
		} else {
			document.getElementById("divenable").style.display="none";
			document.getElementById("divdisable").style.display="block";
		}
	}

	function submitOnEnter(event, formRef)
	{
		if(event.keyCode == 13) {
			if(formRef.password.value=="")
			{
				alert(i18nerrorPleaseEnterPassword);
				formRef.password.focus();
				return;
			}
			formRef.submit();
		}
	}

	function getLoginFocus(formRef)
	{
		formRef.username.focus();
	}
	
	function tabSwitch_2(active, number, tab_prefix, content_prefix) {
		
		for (var i=1; i < number+1; i++) {
		  document.getElementById(content_prefix+i).style.display = 'none';
		  document.getElementById(tab_prefix+i).className = '';
		}
		document.getElementById(content_prefix+active).style.display = 'block';
		document.getElementById(tab_prefix+active).className = 'active';	
		
	}
	
	var myChart; 
	function drawChart(data) {
		
		
		myChart = new FusionCharts(contextPath+"/js/fusioncharts/charts/FCF_Column3D.swf", "dcchartId", "600", "375");
		myChart.setDataXML(data);
		myChart.setTransparent(true);
		//myChart.setDataXML("<graph caption='Business Results 2005 v 2006' PYAxisName='Revenue' SYAxisName='Quantity'xAxisName='Month' showValues='0' decimalPrecision='0' bgcolor='F3f3f3' bgAlpha='70' showColumnShadow='1' divlinecolor='c5c5c5' divLineAlpha='60' showAlternateHGridColor='1' alternateHGridColor='f8f8f8' alternateHGridAlpha='60' SYAxisMaxValue='750'> <categories><category name='Jan' /><category name='Feb' /><category name='Mar' /><category name='Apr' /><category name='May' /><category name='Jun' /><category name='Jul' /><category name='Aug' /> <category name='Sep' /> <category name='Oct' /><category name='Nov' /><category name='Dec' /></categories><dataset seriesName='2006' parentYAxis='P' color='c4e3f7' numberPrefix='$'><set value='27400' /><set value='29800' /><set value='25800' /><set value='26800' /><set value='29600' /><set value='32600' /><set value='31800' /><set value='36700' /><set value='29700' /><set value='31900' /><set value='34800' /><set value='24800' /></dataset><dataset seriesName='2005' parentYAxis='P' color='Fad35e' numberPrefix='$'><set value='10000' /><set value='11500' /><set value='12500' /><set value='15000' /><set value='11000' /><set value='9800'  /><set value='11800' /><set value='19700' /><set value='21700' /><set value='21900' /><set value='22900' /><set value='20800' /></dataset><dataset seriesName='Total Quantity' parentYAxis='S' color='8BBA00' anchorSides='10' anchorRadius='3' anchorBorderColor='009900' ><set value='270' /><set value='320' /><set value='290' /><set value='320' /><set value='310' /><set value='320' /><set value='340' /><set value='470' /><set value='420' /><set value='440' /><set value='480 '/><set value='360' /> </dataset></graph>");
		//myChart.setDataXML("<graph caption='Monthly Unit Sales' xAxisName='Month' yAxisName='Units' showNames='1' decimalPrecision='0' formatNumberScale='0'><set name='Jan' value='462' color='AFD8F8' /><set name='Feb' value='857' color='F6BD0F' /><set name='Mar' value='671' color='8BBA00' /><set name='Apr' value='494' color='FF8E46'/><set name='May' value='761' color='008E8E'/><set name='Jun' value='960' color='D64646'/><set name='Jul' value='629' color='8E468E'/><set name='Aug' value='622' color='588526'/><set name='Sep' value='376' color='B3AA00'/><set name='Oct' value='494' color='008ED6'/><set name='Nov' value='761' color='9D080D'/><set name='Dec' value='960' color='A186BE'/></graph>");
	    myChart.render("chartdiv");
	}

	function drawCompareChart(data) {
		
		myChart = new FusionCharts(contextPath+"/js/fusioncharts/charts/FCF_MSColumn3DLineDY.swf", "dccomparechartId", "600", "375");
		myChart.setDataXML(data);
		myChart.setTransparent(true);
		//myChart.setDataXML("<graph caption='Business Results 2005 v 2006' PYAxisName='Revenue' SYAxisName='Quantity'xAxisName='Month' showValues='0' decimalPrecision='0' bgcolor='F3f3f3' bgAlpha='70' showColumnShadow='1' divlinecolor='c5c5c5' divLineAlpha='60' showAlternateHGridColor='1' alternateHGridColor='f8f8f8' alternateHGridAlpha='60' SYAxisMaxValue='750'> <categories><category name='Jan' /><category name='Feb' /><category name='Mar' /><category name='Apr' /><category name='May' /><category name='Jun' /><category name='Jul' /><category name='Aug' /> <category name='Sep' /> <category name='Oct' /><category name='Nov' /><category name='Dec' /></categories><dataset seriesName='2006' parentYAxis='P' color='c4e3f7' numberPrefix='$'><set value='27400' /><set value='29800' /><set value='25800' /><set value='26800' /><set value='29600' /><set value='32600' /><set value='31800' /><set value='36700' /><set value='29700' /><set value='31900' /><set value='34800' /><set value='24800' /></dataset><dataset seriesName='2005' parentYAxis='P' color='Fad35e' numberPrefix='$'><set value='10000' /><set value='11500' /><set value='12500' /><set value='15000' /><set value='11000' /><set value='9800'  /><set value='11800' /><set value='19700' /><set value='21700' /><set value='21900' /><set value='22900' /><set value='20800' /></dataset><dataset seriesName='Total Quantity' parentYAxis='S' color='8BBA00' anchorSides='10' anchorRadius='3' anchorBorderColor='009900' ><set value='270' /><set value='320' /><set value='290' /><set value='320' /><set value='310' /><set value='320' /><set value='340' /><set value='470' /><set value='420' /><set value='440' /><set value='480 '/><set value='360' /> </dataset></graph>");
		//myChart.setDataXML("<graph caption='Monthly Unit Sales' xAxisName='Month' yAxisName='Units' showNames='1' decimalPrecision='0' formatNumberScale='0'><set name='Jan' value='462' color='AFD8F8' /><set name='Feb' value='857' color='F6BD0F' /><set name='Mar' value='671' color='8BBA00' /><set name='Apr' value='494' color='FF8E46'/><set name='May' value='761' color='008E8E'/><set name='Jun' value='960' color='D64646'/><set name='Jul' value='629' color='8E468E'/><set name='Aug' value='622' color='588526'/><set name='Sep' value='376' color='B3AA00'/><set name='Oct' value='494' color='008ED6'/><set name='Nov' value='761' color='9D080D'/><set name='Dec' value='960' color='A186BE'/></graph>");
	    myChart.render("chartdiv");
	}
	
	function drawLPChart(data) {
		
		myChart = new FusionCharts(contextPath+"/js/fusioncharts/charts/FCF_MSArea2D.swf", "dccomparechartId", "600", "375");
		myChart.setDataXML(data);	
		myChart.setTransparent(true);
		//myChart.setDataXML("<graph caption='Load Profile -20110901-20111231' divlinecolor='F47E00' numdivlines='4' showAreaBorder='1' areaBorderColor='000000' numberPrefix='KwH' showNames='1' numVDivLines='29' vDivLineAlpha='30' formatNumberScale='0' rotateNames='0' ><categories><category name='1' /><category name='2' /><category name='3' /><category name='4' /><category name='5' /><category name='6' /><category name='7' /><category name='8' /><category name='9' /><category name='10' /><category name='11' /><category name='12' /><category name='13' /><category name='14' /><category name='15' /><category name='16' /><category name='17' /><category name='18' /><category name='19' /><category name='20' /><category name='21' /><category name='22' /><category name='23' /><category name='24' /></categories><dataset seriesname='Max' color='FF0000' showValues='0' areaAlpha='50' showAreaBorder='1' areaBorderThickness='2' areaBorderColor='FF0000'><set value='152.65343' /><set value='180.2489' /><set value='168.16779' /><set value='183.74614' /><set value='161.02072' /><set value='191.81839' /><set value='187.30359' /><set value='146.84476' /><set value='141.8888' /><set value='171.76065' /><set value='150.65385' /><set value='165.21304' /><set value='177.75368' /><set value='191.66945' /><set value='159.71661' /><set value='191.11716' /><set value='173.58394' /><set value='161.13531' /><set value='167.27498' /><set value='162.78354' /><set value='152.0551' /><set value='190.89862' /><set value='151.19556' /><set value='181.90297' /></dataset><dataset seriesname='Avg' color='00FF00' showValues='0' areaAlpha='50' showAreaBorder='1' areaBorderThickness='2' areaBorderColor='00FF00'><set value='133.90343' /><set value='161.4989' /><set value='149.41777' /><set value='164.99612' /><set value='142.27074' /><set value='173.06837' /><set value='168.55359' /><set value='128.09476' /><set value='123.138794' /><set value='153.01064' /><set value='131.90384' /><set value='146.46303' /><set value='159.00368' /><set value='172.91945' /><set value='140.9666' /><set value='172.36717' /><set value='154.83395' /><set value='142.3853' /><set value='148.525' /><set value='144.03355' /><set value='133.30508' /><set value='172.14864' /><set value='132.44556' /><set value='163.15297' /></dataset><dataset seriesname='Min' color='FFFF00' showValues='0' areaAlpha='50' showAreaBorder='1' areaBorderThickness='2' areaBorderColor='FFFF00'><set value='131.65343' /><set value='139.2489' /><set value='127.16779' /><set value='142.74614' /><set value='120.02072' /><set value='150.81839' /><set value='146.30359' /><set value='105.844765' /><set value='100.8888' /><set value='130.76065' /><set value='109.65385' /><set value='124.21304' /><set value='136.75368' /><set value='150.66945' /><set value='118.71661' /><set value='150.11716' /><set value='132.58394' /><set value='120.13531' /><set value='126.27498' /><set value='121.78354' /><set value='111.0551' /><set value='149.89862' /><set value='110.19556' /><set value='140.90297' /></dataset></graph>");
		//myChart.setDataXML("<graph caption='Load Profile -20110101-20111231' divlinecolor='F47E00' numdivlines='4' showAreaBorder='1' areaBorderColor='000000' numberPrefix='$' showNames='1' numVDivLines='29' vDivLineAlpha='30' formatNumberScale='0' rotateNames='1' ><categories><category name='1' /><category name='2' /><category name='3' /><category name='4' /><category name='5' /><category name='6' /><category name='7' /><category name='8' /><category name='9' /><category name='10' /><category name='11' /><category name='12' /><category name='13' /><category name='14' /><category name='15' /><category name='16' /><category name='17' /><category name='18' /><category name='19' /><category name='20' /><category name='21' /><category name='22' /><category name='23' /><category name='24' /></categories><dataset seriesname='Max' color='FF0000' showValues='0' areaAlpha='50' showAreaBorder='1' areaBorderThickness='2' areaBorderColor='FF0000'><set value='131.65343' /><set value='159.2489' /><set value='147.16779' /><set value='162.74614' /><set value='140.02072' /><set value='170.81839' /><set value='166.30359' /><set value='125.844765' /><set value='120.8888' /><set value='150.76065' /><set value='129.65385' /><set value='144.21304' /><set value='156.75368' /><set value='170.66945' /><set value='138.71661' /><set value='170.11716' /><set value='152.58394' /><set value='140.13531' /><set value='146.27498' /><set value='141.78354' /><set value='131.0551' /><set value='169.89862' /><set value='130.19556' /><set value='160.90297' /></dataset><dataset seriesname='Avg' color='00FF00' showValues='0' areaAlpha='50' showAreaBorder='1' areaBorderThickness='2' areaBorderColor='00FF00'><set value='136.88872' /><set value='164.48424' /><set value='152.40305' /><set value='167.9814' /><set value='145.25603' /><set value='176.05367' /><set value='171.53893' /><set value='131.08003' /><set value='126.12409' /><set value='155.99596' /><set value='134.88913' /><set value='149.44835' /><set value='161.98897' /><set value='175.90474' /><set value='143.95187' /><set value='175.35246' /><set value='157.81924' /><set value='145.37057' /><set value='151.51027' /><set value='147.01883' /><set value='136.29039' /><set value='175.13394' /><set value='135.43085' /><set value='166.13829' /></dataset></graph>");
	    myChart.render("lpchartdiv");
	}


	function populateMeterDetails(data){
		
		if(data!=""||data!=null) {
		    var meterDetails = eval(data);
		    document.getElementById("mdid").innerHTML=meterDetails.id;
		    document.getElementById("mdmepcode").innerHTML= meterDetails.measurepointCode;
		    document.getElementById("mdstreet").innerHTML=meterDetails.streetno+" / "+meterDetails.street;
		    document.getElementById("mdpcode").innerHTML=meterDetails.postcode;
		    document.getElementById("mdcity").innerHTML=meterDetails.city;
		    document.getElementById("mdsno").innerHTML=meterDetails.serialNumber;
		    document.getElementById("mdmodel").innerHTML=meterDetails.modelCode;
		    document.getElementById("mdtype").innerHTML=meterDetails.meterType;    
		    $('.contentMT').slideToggle();
		}
	    
	}

	function errorChartDetails(data) {
		document.getElementById("chartdiv").innerHTML="";
		alert(i18nerrorChartError);	
	}

	function errorMeterDetails(data) {
		alert(i18nerrorChartError);
	}

	function getMeterDetails() {
		if(validateGetMeterDetails()) {
			var obj= {};
			obj.url=contextPath+"/std/ViewMeterDetails.action";
			obj.pdata = "id="+document.getElementById("meterno").value; // post variable data
			obj.successfunc = populateMeterDetails;
			obj.errorfunc = errorMeterDetails;
			run_ajax_json(obj);
			return;
		}
	}

	function getDCData() {
		if(validateDCAggregation()) {
			var obj= {};
			obj.url=contextPath+"/std/DailyConsumptionData.action";
			obj.pdata = "id="+document.getElementById("meterno").value +"&dcdate="+document.getElementById("meterdate").value;// post variable data
			obj.successfunc = drawChart;
			obj.errorfunc = errorMeterDetails;
			run_ajax(obj);
			return;
		}
	}

	function getDCCompareData(compare) {

		if(validateComparisonAggregation()) {
			var obj= {};
			obj.url=contextPath+"/std/DailyConsumptionCompareData.action";
			obj.pdata = "id="+document.getElementById("meterno").value +"&dcdate="+document.getElementById("meterdate").value+"&compareby="+compare+"&comparefrom="+document.getElementById("fromDatehiddenDC").value+"&compareto="+document.getElementById("toDatehiddenDC").value;// post variable data
			obj.successfunc = drawCompareChart;
			obj.errorfunc = errorMeterDetails;
			run_ajax(obj);
			return;
		}
		
	}
	
	function getLPData(validation2) {
		var validation = false; 
		if(validation2) {
			validation = validateLP2Aggregation();
		} else {
			validation = validateLP1Aggregation();			
		}
		if(validation) {
			var obj= {};
			obj.url=contextPath+"/std/LoadProfileData.action";
			obj.pdata = "id="+document.getElementById("meterno").value +"&lpFromDate="+document.getElementById("lpFromDate").value+"&lpToDate="+document.getElementById("lpToDate").value;// post variable data
			obj.successfunc = drawLPChart;
			obj.errorfunc = errorMeterDetails;
			run_ajax(obj);
			return;
		}
	}

	
	function assignFromDate(tabName)
	{
		var fromDateId = 'fromDatehidden'+tabName; // Hidden variable for from date.
		var yearId =  'yearly' + tabName; 
	    var quarterId = 'quarterly' + tabName;
	    var monthId =  'monthly' + tabName;	    
	    var year = document.getElementById(yearId).value;	 
	    var quarter = document.getElementById(quarterId).value;
	    var month = document.getElementById(monthId).value;
	    
		var fromDatehidden = document.getElementById(fromDateId);		
		var quarterStart = new Array("01","04","07","10");		
		if(year!=0)
        {		    
     	  fromDatehidden.value=year+"0101";
        }
        if(year !=0 && quarter !=0)
        {
        	fromDatehidden.value = year+quarterStart[quarter-1]+"01";        
        }
        if(year !=0 && quarter !=0 && month !=0 )
        {
        	fromDatehidden.value = year+month+"01";        	
        }
	}
	
	function assignToDate(tabName)
	{
		var toDateId = 'toDatehidden'+tabName; // Hidden variable for to date.		
		var yearId =  'yearly' + tabName; 
	    var quarterId = 'quarterly' + tabName;
	    var monthId =  'monthly' + tabName;		
		var quarterEndMonth = new Array("03","06","09","12");
		var quarterEndDate = new Array("31","30","30","31");
		
		var year = document.getElementById(yearId).value;	
		
		var monthEndDate ;
		   if(year%4==0) {
			   monthEndDate = new Array("31","29","31","30","31","30","31","31","30","31","30","31");
		   } else {
			   monthEndDate = new Array("31","28","31","30","31","30","31","31","30","31","30","31");
		   }	
		   
		var quarter = document.getElementById(quarterId).value;
		var month = document.getElementById(monthId).value;
		
		var toDatehidden = document.getElementById(toDateId);
		if(year!=0)
	       {
			   toDatehidden.value=year+"1231";	    	    	   
	       }
		   if(year !=0 && quarter !=0)
	       {
			   toDatehidden.value = year+quarterEndMonth[quarter-1]+quarterEndDate[quarter-1];	        
	       }
	       if(year !=0 && quarter !=0 && month !=0 )
	       {
	       	toDatehidden.value = year+month+monthEndDate[month-1];
	       }
	}
	
	function drawMonthlyEnergyChart(data)
	{
		if(data!=""||data!=null) {
		var ecDetails = eval(data);		
		weeklyChart = new FusionCharts(contextPath+"/js/fusioncharts/charts/FCF_Column3D.swf", "ecweekchartId", "800", "506");
		monthlyChart = new FusionCharts(contextPath+"/js/fusioncharts/charts/FCF_StackedColumn3D.swf", "ecmonthchartId", "460", "506");		
		monthlyChart.setDataXML(ecDetails.monthlyConsumption);		
		monthlyChart.render("ecmechartdiv");		
		weeklyChart.setDataXML(ecDetails.weekEndAverage);
		weeklyChart.render("ecweekchartdiv");
		document.getElementById("sumtotal").innerHTML=ecDetails.summaryConsumption.totalEnergy;
		document.getElementById("summax").innerHTML=ecDetails.summaryConsumption.maxDailyEnergy;
		document.getElementById("summaxdate").innerHTML=ecDetails.summaryConsumption.maxDailyEnergyDate;
		document.getElementById("sumavg").innerHTML=ecDetails.summaryConsumption.avgDailyEnergy;
		document.getElementById("summin").innerHTML=ecDetails.summaryConsumption.minDailyEnergy;
		document.getElementById("summindate").innerHTML=ecDetails.summaryConsumption.minDailyEnergyDate;
		}
	}
	
	function getECData()
	{
		if(validateMontlyConsumption()) {
			assignFromDate('EC'); 
			assignToDate('EC');			
			var obj= {};
			obj.url=contextPath+"/std/EnergyConsumptionMonthlyData.action";
			obj.pdata = "id="+document.getElementById("meterno").value + "&ecFromDate="+document.getElementById("fromDatehiddenEC").value+"&ecToDate="+document.getElementById("toDatehiddenEC").value;// post variable data
			obj.successfunc = drawMonthlyEnergyChart;
			obj.errorfunc = errorMeterDetails;
			run_ajax_json(obj);
			return;
		}
	}
	