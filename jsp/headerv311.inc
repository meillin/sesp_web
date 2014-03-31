<header id="header">
	<div class="row">
		<div class="large-4 columns">
			<ul class="inline-list">
				<li class="slide-menu-left">
					<a><i id="show-nav" class="fi-list size-24"></i></a> 
					<ul class="overlapping-menu">
						<li><a href="<%=request.getContextPath()%>/std/Index" id="menu-button-delivery-performance">HOME</a></li>
						<li><a href="<%=request.getContextPath()%>/std/ViewResourceProjectionAction" id="menu-button-resource-projections">RESOURCE PROJECTIONS</a></li>
						<li><a href="<%=request.getContextPath()%>/std/AreaProgress" id="menu-button-technician-positioning">AREA PROGRESS</a></li><br />
						<li><a href="<%=request.getContextPath()%>/std/StockManagement1" id="menu-button-logistics">LOGISTICS</a></li>
						<li><a href="<%=request.getContextPath()%>/std/AlarmManagementReports" id="menu-button-alarm-management">ALARM MANAGEMENT</a></li>
						<li><a href="javascript: openDashboard();" id="menu-button-system-utilization">SYSTEM UTILIZATION</a></li>
						<li><a href="<%=request.getContextPath()%>/std/WorkOrderProgress" id="menu-button-work-order-progress">WORK ORDER PROGRESS</a></li>
						<li><a href="<%=request.getContextPath()%>/std/AnalyzeFieldWorkEfficiency" id="menu-button-technician-work-load">FIELD WORK EFFICIENCY</a></li>
						<li><a href="<%=request.getContextPath()%>/std/TimeReservationCallList" id="menu-button-delivery-performance">TIME RESERVATION CALL LIST</a></li>
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
					<a><i class="fi-filter size-24"></i></a> 
				</li>
			</ul>
		</div>

	</div>
</header>
<script>
	function openDashboard() { window.open('<%=request.getContextPath()%>/std/SysDashboard?refreshInterval=5', '', '');}
</script>