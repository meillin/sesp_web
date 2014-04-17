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


						<li><a href="<%=request.getContextPath()%>/std/StockManagement1" id="menu-button-logistics">
						<i>
							<svg class="logistics-icon-pos-slideout" version="1.1" id="Layer_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px"
                             width="28px" height="28px" viewBox="0 0 512 371" enable-background="new 0 0 512 371" xml:space="preserve">
                         	<g>
                            <defs>
                              <rect class="bar" id="SVGID_1_" y="-68" width="512" height="512"/>
                            </defs>
                            <clipPath id="SVGID_2_">
                              <use xlink:href="#SVGID_1_"  overflow="visible"/>
                            </clipPath>
                            <path class="logistics-icon-slideout" clip-path="url(#SVGID_2_)" d="M435.303,81.064h-98.088v157.718c6.49-2.222,13.489-3.465,20.782-3.465
                              c30.004,0,55.184,20.733,61.983,48.691h50.23V165.729L435.303,81.064z M387.264,170.472l-23.691-64.454h55.039l26.566,64.454
                              H387.264z M286.919,37.7H65.512c-13.36,0-24.183,10.829-24.183,24.17v223.154h31.347c6.425-28.45,31.851-49.706,62.211-49.706
                              c30.414,0,55.839,21.256,62.25,49.706h98.612c2.52-11.086,7.882-21.092,15.353-29.168V61.87
                              C311.102,48.529,300.277,37.7,286.919,37.7 M134.887,260.266c-21.418,0-38.847,17.436-38.847,38.887s17.429,38.887,38.847,38.887
                              c21.469,0,38.901-17.436,38.901-38.887S156.356,260.266,134.887,260.266 M357.997,260.266c-21.452,0-38.901,17.436-38.901,38.887
                              s17.449,38.887,38.901,38.887s38.882-17.436,38.882-38.887S379.449,260.266,357.997,260.266"/>
                          </g>
                          </svg>
						</i>
						<span class="slide-out-text_logi">Logistics</span></a></li>


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