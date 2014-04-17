<header id="header">
	<ul class="inline-list top-menu">
		<li class="top-menu-first">
			<ul class="inline-list">
				<li class="slide-menu-left">
					<a class="slide" id="show-nav"><i class="fi-list size-24"></i></a>
					<ul class="overlapping-menu">
						<li><a href="<%=request.getContextPath()%>/std/Index" id="menu-button-delivery-performance"><i class="fi-home size-24"></i><span class="slide-out-text">Home</span></a></li>
						<li><a href="<%=request.getContextPath()%>/std/ViewResourceProjectionAction" id="menu-button-resource-projections"><i class="fi-torsos size-24"></i><span class="slide-out-text">Resources Projections</span></a></li>
						<li><a href="<%=request.getContextPath()%>/std/AreaProgress" id="menu-button-technician-positioning"><i class="fi-graph-horizontal size-24"></i><span class="slide-out-text">Area Progress</span></a></li>
						<li><a href="<%=request.getContextPath()%>/std/StockManagement1" id="menu-button-logistics"><i class="fi-mountains size-24"></i><span class="slide-out-text">Logistics</span></a></li>
						<li><a href="<%=request.getContextPath()%>/std/AlarmManagementReports" id="menu-button-alarm-management"><i class="fi-alert size-24"></i><span class="slide-out-text">Alarm Management</span></a></li>
						<li><a href="javascript: openDashboard();" id="menu-button-system-utilization"><i class="fi-monitor size-24"></i><span class="slide-out-text">System Utilization</span></a></li>
						<li><a href="<%=request.getContextPath()%>/std/WorkOrderProgress" id="menu-button-work-order-progress"><i class="fi-graph-trend size-24"></i><span class="slide-out-text">Work Order Overview</span></a></li>
						<li><a href="<%=request.getContextPath()%>/std/AnalyzeFieldWorkEfficiency" id="menu-button-technician-work-load"><i class="fi-arrow-up size-24"></i><span class="slide-out-text">Field Work Efficency</span></a></li>
						<li><a href="<%=request.getContextPath()%>/std/TimeReservationCallList" id="menu-button-delivery-performance"><i class="fi-clock size-24"></i><span class="slide-out-text">Time Reservation Call List</span></a></li>
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
					<select class="lang-dropdown">
						<option value="English">English (UK)</option>
						<option value="Swedish">Swedish (SE)</option>
						<option value="German">German (GE)</option>
						<option value="French">French (FR)</option>
					</select>
				</li>
				<li class="slide-menu-right">
					<a class="toggle-filter"><i class="fi-filter size-18"></i> Filter </a>
				</li>
				<li class="logout-right">
					<a href="<%=request.getContextPath()%>/std/Logout" id="logout-button"><i class="fi-power size-18"></i> Log Out </a>
				</li>
			</ul>
		</li>
	</ul>

</header>
<script>
	function openDashboard() { window.open('<%=request.getContextPath()%>/std/SysDashboard?refreshInterval=5', '', '');}
</script>