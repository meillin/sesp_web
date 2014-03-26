<div id="header">	
	<div class="nav">	
		<div class="welcomeuser"><s:text name="webportal.header.welcome"/> <span><%=session.getAttribute("username")%></span></div>
    	<div class="loginLogout">
    		<ul><li><a href="<%=request.getContextPath()%>/std/Home"><s:text name="webportal.link.home"/><a/></li><li>|</li> <li><a href="<%=request.getContextPath()%>/std/Logout"><s:text name="webportal.link.logout"/></a></li></ul>
    	</div>
	</div>
	<div class="logoSection">
		<div id="logoCG"><img src="<%=request.getContextPath()%>/images/capgemini_logo.png" alt="Capgemini" /></div>	
	</div>
</div>