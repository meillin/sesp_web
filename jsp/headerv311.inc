<header id="header">
	<div class="row">
		<div class="large-4 columns">
			<ul class="inline-list">
				<li class="slide-menu-left">
					<a><i id="show-nav" class="fi-list size-24"></i></a> 
					<ul class="overlapping-menu">
						<li><a href="<%=request.getContextPath()%>/std/Index" id="menu-button-delivery-performance"><i class="fi-home"></i> Home</a></li>
						<li><a href="<%=request.getContextPath()%>/std/ViewResourceProjectionAction" id="menu-button-resource-projections"><i class="fi-home"></i> Resources Projections</a></li>
						<li><a href="<%=request.getContextPath()%>/std/AreaProgress" id="menu-button-technician-positioning"><i class="fi-home"></i> Area Progress</a></li><br />
						<li><a href="<%=request.getContextPath()%>/std/StockManagement1" id="menu-button-logistics"><i class="fi-home"></i> Logistics</a></li>
						<li><a href="<%=request.getContextPath()%>/std/AlarmManagementReports" id="menu-button-alarm-management"><i class="fi-home"></i> Alarm Management</a></li>
						<li><a href="javascript: openDashboard();" id="menu-button-system-utilization"><i class="fi-home"></i> System Utilization</a></li>
						<li><a href="<%=request.getContextPath()%>/std/WorkOrderProgress" id="menu-button-work-order-progress"><i class="fi-home"></i> Work Order Progress</a></li>
						<li><a href="<%=request.getContextPath()%>/std/AnalyzeFieldWorkEfficiency" id="menu-button-technician-work-load"><i class="fi-home"></i> Field work Efficency</a></li>
						<li><a href="<%=request.getContextPath()%>/std/TimeReservationCallList" id="menu-button-delivery-performance"><i class="fi-home"></i> Time Reservation call list</a></li>
					</ul>
				</li>
				<li>
					<a href="<%=request.getContextPath()%>/std/Index" id="logo-home" class="logo-capgemini">
						<img src="<%=request.getContextPath()%>/images/logo-cap-header.png" />
					</a>
				</li>
			</ul>
		</div>

		<div class="large-4 columns">
			<div class="row">
				<div class="small-12 columns">
					<ul class="inline-list search-bar">
						<li class="search-input">
							<input type="text" id="search-input" placeholder="SEARCH" onKeyPress="return submitOnEnter(this,event)"/>
						</li>
						<li class="search-button">
							<a href="javascript:searchentities()"  id="search-button" class="postfix"><i class="fi-magnifying-glass size-20"></i></a>	
						</li>
					</ul>
				</div>
			</div>
		</div>

		<div class="large-4 columns">
			<ul class="inline-list right">
				<li class="slide-menu-right">
					<a class="toggle-filter">Filter <i class="fi-filter size-24"></i></a> 
				</li>
			</ul>
		</div>

	</div>
</header>
<script>
	function openDashboard() { window.open('<%=request.getContextPath()%>/std/SysDashboard?refreshInterval=5', '', '');}
</script>