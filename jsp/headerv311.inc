<header id="header">
	<ul class="inline-list top-menu">
		<li class="top-menu-first">
			<ul class="inline-list">
				<li class="slide-menu-left">
					<a class="slide" id="show-nav"><i class="fi-list size-24"></i></a>

					<ul class="overlapping-menu" style="display:none">

						<li>
							<a href="<%=request.getContextPath()%>/std/Index" id="menu-button-delivery-performance">
							<i class="fi-home size-24"></i><span class="slide-out-text">Home</span></a>
						</li>

						<li>
							<a href="<%=request.getContextPath()%>/std/ViewResourceProjectionAction" id="menu-button-resource-projections">
							<i class="fi-torsos size-24"></i><span class="slide-out-text">Resources Projections</span></a>
						</li>

						<li>
							<a href="<%=request.getContextPath()%>/std/AreaProgress" id="menu-button-technician-positioning">
							<i class="fi-graph-horizontal size-24"></i><span class="slide-out-text">Area Progress</span></a>
						</li>

						<li>
							<a href="<%=request.getContextPath()%>/std/StockManagement1" id="menu-button-logistics">
							<i class="icon-truck size-22"></i><span class="slide-out-text">Logistics</span></a>
						</li>

						<li>
							<a href="<%=request.getContextPath()%>/std/AlarmManagementReports" id="menu-button-alarm-management">
							<i class="fi-alert size-24"></i><span class="slide-out-text">Alarm Management</span></a>
						</li>

						<li>
							<a href="javascript: openDashboard();" id="menu-button-system-utilization">
							<i class="fi-monitor size-24"></i><span class="slide-out-text">System Utilization</span></a>
						</li>

						<li>
							<a href="<%=request.getContextPath()%>/std/WorkOrderProgress" id="menu-button-work-order-progress">
							<i class="fi-graph-trend size-24"></i><span class="slide-out-text">Work Order Overview</span></a>
						</li>

						<li>
							<a href="<%=request.getContextPath()%>/std/AnalyzeFieldWorkEfficiency" id="menu-button-technician-work-load">
							<i class="fi-arrow-up size-24"></i><span class="slide-out-text">Field Work Efficency</span></a>
						</li>

						<li>
							<a href="<%=request.getContextPath()%>/std/TimeReservationCallList" id="menu-button-delivery-performance">
							<i class="fi-clock size-24"></i><span class="slide-out-text">Time Reservation Call List</span></a>
						</li>

						<li class="logout-button">
							<a href="<%=request.getContextPath()%>/std/Logout" id="logout-button">
							<i class="fi-power size-24"></i><span class="slide-out-text">Log Out</span></a>
						</li>

					</ul>

				</li>
			</ul>
		</li>
		<li class="top-menu-second">
			<ul class="inline-list search-bar">
				<li class="search-input">
					<input type="text" id="search-input" placeholder="Search" onKeyPress="return submitOnEnter(this,event)"/>
				</li>
				<li class="search-button">
					<a href="javascript:searchentities()"  id="search-button" class="postfix"><i class="fi-magnifying-glass size-20"></i></a>
				</li>
			</ul>
		</li>
		<li class="top-menu-third">
			<ul class="inline-list right">
				<li>
                  				   
				   <select id="localeId" name="localeName" class="lang-dropdown" onchange="changeLocale()">	
				
				   		<s:if test="%{#session.I18N_LOCALE == 'English_US'}">					
							<option value="English_US" selected><s:text name="webportal.sesp.locale.english.us"/></option>
						</s:if> 
						<s:else> 
							<option value="English_US"><s:text name="webportal.sesp.locale.english.us"/></option>
						</s:else>	
						
						<s:if test="%{#session.I18N_LOCALE == 'English_GB'}">					
							<option value="English_GB" selected><s:text name="webportal.sesp.locale.english.gb"/></option>
						</s:if> 
						<s:else> 
							<option value="English_GB"><s:text name="webportal.sesp.locale.english.gb"/></option>
						</s:else>
						
						<s:if test="%{#session.I18N_LOCALE == 'English_UA'}">					
							<option value="English_UA" selected><s:text name="webportal.sesp.locale.english.au"/></option>
						</s:if> 
						<s:else> 
							<option value="English_UA"><s:text name="webportal.sesp.locale.english.au"/></option>
						</s:else>
						
						<s:if test="%{#session.I18N_LOCALE == 'English_CA'}">					
							<option value="English_CA" selected><s:text name="webportal.sesp.locale.english.ca"/></option>
						</s:if> 
						<s:else> 
							<option value="English_CA"><s:text name="webportal.sesp.locale.english.ca"/></option>
						</s:else>
						
						<s:if test="%{#session.I18N_LOCALE == 'Swedish_SE'}">
							<option value="Swedish_SE" selected><s:text name="webportal.sesp.locale.swedish.se"/></option>
						</s:if> 
						<s:else> 
							<option value="Swedish_SE"><s:text name="webportal.sesp.locale.swedish.se"/></option>
						</s:else>
						
						<s:if test="%{#session.I18N_LOCALE == 'German_AT'}">					
							<option value="German_AT" selected><s:text name="webportal.sesp.locale.german.at"/></option>
						</s:if> 
						<s:else> 
							<option value="German_AT"><s:text name="webportal.sesp.locale.german.at"/></option>
						</s:else>
						
						<s:if test="%{#session.I18N_LOCALE == 'German_DE'}">					
							<option value="German_DE" selected><s:text name="webportal.sesp.locale.german.de"/></option>
						</s:if> 
						<s:else> 
							<option value="German_DE"><s:text name="webportal.sesp.locale.german.de"/></option>
						</s:else>
						
						<s:if test="%{#session.I18N_LOCALE == 'German_LU'}">					
							<option value="German_LU" selected><s:text name="webportal.sesp.locale.german.lu"/></option>
						</s:if> 
						<s:else> 
							<option value="German_LU"><s:text name="webportal.sesp.locale.german.lu"/></option>
						</s:else>
						<s:if test="%{#session.I18N_LOCALE == 'German_CH'}">					
							<option value="German_CH" selected><s:text name="webportal.sesp.locale.german.ch"/></option>
						</s:if> 
						<s:else> 
							<option value="German_CH"><s:text name="webportal.sesp.locale.german.ch"/></option>
						</s:else>
						
						<s:if test="%{#session.I18N_LOCALE == 'French_BE'}">					
							<option value="French_BE" selected><s:text name="webportal.sesp.locale.french.be"/></option>
						</s:if> 
						<s:else> 
							<option value="French_BE"><s:text name="webportal.sesp.locale.french.be"/></option>
						</s:else>
						
						<s:if test="%{#session.I18N_LOCALE == 'French_CA'}">					
							<option value="French_CA" selected><s:text name="webportal.sesp.locale.french.ca"/></option>
						</s:if> 
						<s:else> 
							<option value="French_CA"><s:text name="webportal.sesp.locale.french.ca"/></option>
						</s:else>
						<s:if test="%{#session.I18N_LOCALE == 'French_FR'}">					
							<option value="French_FR" selected><s:text name="webportal.sesp.locale.french.fr"/></option>
						</s:if> 
						<s:else> 
							<option value="French_FR"><s:text name="webportal.sesp.locale.french.fr"/></option>
						</s:else>
						<s:if test="%{#session.I18N_LOCALE == 'French_LU'}">					
							<option value="French_LU" selected><s:text name="webportal.sesp.locale.french.lu"/></option>
						</s:if> 
						<s:else> 
							<option value="French_LU"><s:text name="webportal.sesp.locale.french.lu"/></option>
						</s:else>
						<s:if test="%{#session.I18N_LOCALE == 'French_CH'}">					
							<option value="French_CH" selected><s:text name="webportal.sesp.locale.french.ch"/></option>
						</s:if> 
						<s:else> 
							<option value="French_CH"><s:text name="webportal.sesp.locale.french.ch"/></option>
						</s:else>
																		
						<s:if test="%{#session.I18N_LOCALE == 'Finnish_FI'}">
							<option value="Finnish_FI" selected><s:text name="webportal.sesp.locale.finnish.fi"/></option>
						</s:if>
						<s:else>
							<option value="Finnish_FI"><s:text name="webportal.sesp.locale.finnish.fi"/></option>
						</s:else>
						
						<s:if test="%{#session.I18N_LOCALE == 'Norwegian_NO'}">
							<option value="Norwegian_NO" selected><s:text name="webportal.sesp.locale.norwegian.no"/></option>
						</s:if>
						<s:else>
							<option value="Norwegian_NO"><s:text name="webportal.sesp.locale.norwegian.no"/></option>
						</s:else>
						
						<s:if test="%{#session.I18N_LOCALE == 'Chinese_CN'}">
							<option value="Chinese_CN" selected><s:text name="webportal.sesp.locale.chinese.cn"/></option>
						</s:if>
						<s:else>
							<option value="Chinese_CN"><s:text name="webportal.sesp.locale.chinese.cn"/></option>
						</s:else>
						
						<s:if test="%{#session.I18N_LOCALE == 'Chinese_HK'}">
							<option value="Chinese_HK" selected><s:text name="webportal.sesp.locale.chinese.hk"/></option>
						</s:if>
						<s:else>
							<option value="Chinese_HK"><s:text name="webportal.sesp.locale.chinese.hk"/></option>
						</s:else>
						
						<s:if test="%{#session.I18N_LOCALE == 'Chinese_SG'}">
							<option value="Chinese_SG" selected><s:text name="webportal.sesp.locale.chinese.sg"/></option>
						</s:if>
						<s:else>
							<option value="Chinese_SG"><s:text name="webportal.sesp.locale.chinese.sg"/></option>
						</s:else>
						
						<s:if test="%{#session.I18N_LOCALE == 'Chinese_TW'}">
							<option value="Chinese_TW" selected><s:text name="webportal.sesp.locale.chinese.tw"/></option>
						</s:if>
						<s:else>
							<option value="Chinese_TW"><s:text name="webportal.sesp.locale.chinese.tw"/></option>
						</s:else>
						
				     <select>
				     
				</li>
				<li class="slide-menu-right">
					<a class="toggle-filter"><i class="fi-filter size-18"></i> Filter </a>
				</li>
				<!--<li class="logout-right">
					<a href="<%=request.getContextPath()%>/std/Logout" id="logout-button"><i class="fi-power size-18"></i> Log Out </a>
				</li>-->
			</ul>
		</li>
	</ul>

</header>
<script>
	<!--window.onload = changeLocale; -->
	function openDashboard() { window.open('<%=request.getContextPath()%>/std/SysDashboard?refreshInterval=5', '', '');}
</script>