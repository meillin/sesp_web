			<header id="header">
				<div id="first-header">
					<div class="left-block">
						<a href="<%=request.getContextPath()%>/std/Index" id="logo-home">
							<img class="logo-capgemini" src="<%=request.getContextPath()%>/images/logo-cap-header.png" />
						</a>
					</div>
					<div class="title text-green">
						
						<img class="logo-smart-energies" src="<%=request.getContextPath()%>/images/logo-ses-header.png"/>
						<span>Smart Energy Services Platform</span>
					</div>
					<div class="right-block">
						<a href="<%=request.getContextPath()%>/std/Logout" id="logout-button">
							<img src="<%=request.getContextPath()%>/images/sign-out-icon.png" />
							<!-- SESP StandardSESPSTD-2926 changes-->
							<!-- <span class="text-red">SIGN OUT</span> -->
						</a>
					</div>
				</div>
				<div id="second-header" class="background-grey">
					<div id="barre">
						<div class="left-block">
							<div id="home-button" style="float:left;">
							<a href="<%=request.getContextPath()%>/std/Index">
								<span class="menu-button-text text-grey" style="margin-left:20px;">HOME</span>
							</a>	
							</div>
							<div id="menu-button">
								<span class="menu-button-text">MENU</span>
								<span class="menu-button-arrow close"></span>
							</div>
						</div>
						<div class="right-block">
							<div class="search-box">
								<input type="text" id="search-input" placeholder="SEARCH" onKeyPress="return submitOnEnter(this,event)"/>
								<a href="javascript:searchentities()"  id="search-button"></a>								
							</div>
						</div>
					</div>
					<div id="menu">
						<div id="menu-inner" class="background-light-grey">
							
							<!-- SESPSTD-2928 changes
							
							<div class="menu-element">
								<a href="<%=request.getContextPath()%>/std/Index" id="menu-button-home">
									<span class="menu-element-picto"></span>
									<span class="menu-element-name text-grey">Home</span>
								</a>
							</div>
							
							-->							
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
							<script>
							function openDashboard() {
						        window.open('<%=request.getContextPath()%>/std/SysDashboard?refreshInterval=5', '', '');
						    	}  	
						    	</script>
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
							
							<!-- SESP StandardSESPSTD-2928 changes -->
						<!--	<div class="menu-element">
								<a href="#" id="menu-button-settings">
									<span class="menu-element-picto"></span>
									<span class="menu-element-name text-grey">SETTINGS</span>
								</a>
							</div> -->
						</div>

					</div>
				</div>

			</header>