<header id="header">
	<div class="row">
		<div class="large-4 columns">
			<ul class="inline-list">
				<li class="slide-menu-left">
					<a class="left-off-canvas-toggle"><i class="fi-list size-24"></i></a>
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
			<!--<div class="row collapse">
				<div class="small-11 columns">
					<input type="text" id="search-input" placeholder="SEARCH" onKeyPress="return submitOnEnter(this,event)"/>
				</div>
				<div class="small-1 columns">
					<a href="javascript:searchentities()"  id="search-button" class="postfix">Search</a>	
				</div>
			</div>-->
		</div>
		<div class="large-4 columns">
			<ul class="inline-list right">
				<li class="slide-menu-right">
					<a class="test"><i class="fi-filter size-24"></i></a> 
				</li>
			</ul>
		</div>
	</div>
	<!--<div id="second-header" class="background-grey" style="display:none;">
		<div id="menu">
			<div id="menu-inner" class="background-light-grey">						
			<div class="menu-element">
				<a href="<%=request.getContextPath()%>/std/TimeReservationCallList" id="menu-button-delivery-performance">
					<span class="menu-element-picto"></span>
					<span class="menu-element-name text-grey">Time Reservation Call List</span>
				</a>
			</div>
			<div class="menu-element">
				<a href="<%=request.getContextPath()%>/std/StockManagement1" id="menu-button-logistics">
					<span class="menu-element-picto"></span>
					<span class="menu-element-name text-grey">LOGISTICS</span>
				</a>
			</div>  
			<div class="menu-element">
				<a href="javascript: openDashboard();" id="menu-button-system-utilization">
					<span class="menu-element-picto"></span>
					<span class="menu-element-name text-grey">SYSTEM UTILIZATION</span>
				</a>
			</div>
			<div class="menu-element">
				<a href="<%=request.getContextPath()%>/std/AlarmManagementReports" id="menu-button-alarm-management">
					<span class="menu-element-picto"></span>
					<span class="menu-element-name text-grey">ALARM MANAGEMENT</span>
				</a>
			</div> 
			<div class="menu-element">
				<a href="<%=request.getContextPath()%>/std/WorkOrderProgress" id="menu-button-work-order-progress">
					<span class="menu-element-picto"></span>
					<span class="menu-element-name text-grey">WORK ORDER PROGRESS</span>
				</a>
			</div>							
			<div class="menu-element">
				<a href="<%=request.getContextPath()%>/std/AreaProgress" id="menu-button-technician-positioning">
					<span class="menu-element-picto"></span>
					<span class="menu-element-name text-grey">AREA PROGRESS</span>
				</a>
			</div>
			<div class="menu-element">
				<a href="<%=request.getContextPath()%>/std/AnalyzeFieldWorkEfficiency" id="menu-button-technician-work-load">
					<span class="menu-element-picto"></span>
					<span class="menu-element-name text-grey">Field Work Efficiency</span>
				</a>
			</div>
			<div class="menu-element">
				<a href="<%=request.getContextPath()%>/std/ViewResourceProjectionAction" id="menu-button-resource-projections">
					<span class="menu-element-picto"></span>
					<span class="menu-element-name text-grey">RESOURCE PROJECTIONS</span>
				</a>
			</div>
			</div>
		</div>
	</div>-->
</header>

<script>
function openDashboard() {
	window.open('<%=request.getContextPath()%>/std/SysDashboard?refreshInterval=5', '', '');
}  	
</script>