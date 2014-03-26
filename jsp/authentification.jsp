<!DOCTYPE html>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title><s:text name="webportal.head.title"/></title>

		<!-- Enable html5 tags for 6-7-8 -->
		<!--[if lte IE 8]>
		<script type="text/javascript">
		document.createElement("header");
		document.createElement("footer");
		document.createElement("section");
		document.createElement("aside");
		document.createElement("nav");
		document.createElement("article");
		document.createElement("figure");
		</script>
		<![endif]-->
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/styles/color.css"/>
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/styles/general.css" />
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/styles/general-custom.css" />
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/styles/header.css" />
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/styles/content-login.css" />
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/styles/footer.css" />
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-1.9.1.min.js"></script>
		<%-- <script type="text/javascript" src="<%=request.getContextPath()%>/js/init.js"></script> --%>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/authentification.js"></script>
		<script src="<%=request.getContextPath()%>/js/spin.js"></script>
		<script src="<%=request.getContextPath()%>/js/ajax-loader.js"></script>
		<link rel="shortcut icon" type="image/png" href="<%=request.getContextPath()%>/images/favicon.png" />
		<style type="text/css">  
		.errors {
			background-color:#FFCCCC;
			border:1px solid #CC0000;
			width:500px;
			margin-bottom:8px;
		}
		.errors li{ 
			list-style: none; 
			font-family:"Helvetica Neue",Helvetica,Arial,sans-serif;
			width:auto;
			color:red;
			font-size:10px;
		}
		</style>
	</head>
	<body onload=getLoginFocus(document.loginForm)>

		<div id="wrapper">
			<header id="header">
				<div id="first-header">
					<div class="left-block">
						<img class="logo-capgemini" src="<%=request.getContextPath()%>/images/logo-cap-header.png" />
					</div>
					<div class="title text-green">
						
						<img class="logo-smart-energies" src="<%=request.getContextPath()%>/images/logo-ses-header.png"/>
						<span><s:text name="webportal.head.title"/></span>
					</div>
					<div class="right-block">
						<br/>
					</div>
				</div>
				<div id="second-header" class="background-grey">
					<div id="barre">
						<div class="left-block">
							
						</div>
						<div class="right-block">
							
						</div>
					</div>
					
				</div>

			</header>

			<div id="main-content">
			 <form name="loginForm" method="post" action="<%=request.getContextPath()%>/std/Login" onKeyPress="return submitOnEnter(this,event)">    
				<div class="left-column column text-white">
					<img class="logo-smart-energies" src="<%=request.getContextPath()%>/images/login-ses-icon.png"/>
					<span><s:text name="webportal.head.title"/></span>
				</div>
				<div class="separator column"></div>
				<div class="right-column text-grey column text-white">
					<span class="title"><s:text name="webportal.index.signin"/></span>
					<div class="user-box">
						<span><s:text name="webportal.index.username"/></span>
						<div class="input-wrapper">
							<input type="text" id="input-login" name="username"/>
						</div>
					</div>
					<div class="password-box">
						<span><s:text name="webportal.index.password"/></span>
						<div class="input-wrapper">
							<input type="password" id="input-password" name="password"/>
						</div>
					</div>
					<div class="button-wrapper">							
						<a href="javascript:submitLogin(document.loginForm)" id="divenable" style="display:block" class="text-blue custom-button"><s:text name="webportal.index.signin"/></a>					
						<a href="#" disabled="disabled" id="divdisable" style="display:none" class="text-blue custom-deactivebutton"><s:text name="webportal.index.signin"/></a>
					</div>									
					<s:if test="hasActionErrors()">
						  <div class="errors">
						     <s:actionerror/>
						  </div>
					</s:if>
					<script type="text/javascript">
						i18nerrorPleaseEnterUsername="<s:text name='webportal.error.enterusername'/>";
						i18nerrorPleaseEnterPassword="<s:text name='webportal.error.enterpassword'/>";					
	
						function loginSpinner(){
							$('<div id ="spinner_center" style="position:fixed;top:70px;left:49%;"></div>').appendTo('body');
							   spinner.spin($('#spinner_center')[0]);
							   ajax_cnt++;
						}
					</script>					
				</div>
			 </form>
			</div>
			
			<!-- Footer -->
			<%@ include file="footerv311.inc"%>

		</div>
	</body>
</html>
