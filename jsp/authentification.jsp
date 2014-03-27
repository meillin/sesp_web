<!DOCTYPE html>
<%@ taglib prefix="s" uri="/struts-tags"%>
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

		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/styles/foundation.css" />
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/styles/content-login.css" />
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
				width:100%;
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

	<!--[if lt IE 9]>
	<script src="//cdnjs.cloudflare.com/ajax/libs/html5shiv/3.6.2/html5shiv.js"></script>
	<script src="//s3.amazonaws.com/nwapi/nwmatcher/nwmatcher-1.2.5-min.js"></script>
	<script src="//html5base.googlecode.com/svn-history/r38/trunk/js/selectivizr-1.0.3b.js"></script>
	<script src="//cdnjs.cloudflare.com/ajax/libs/respond.js/1.1.0/respond.min.js"></script>
	<![endif]-->
	</head>
	<body onload=getLoginFocus(document.loginForm)>

		<div id="wrapper">
			<div id="main-content" class="row">

				<div class="large-12 columns enter-title">
					<img class="logo-smart-energies" src="<%=request.getContextPath()%>/images/login-ses-icon.png" width="45"/>
					Smart Energy Services Platform
				</div>

				<div class="medium-4 medium-centered columns">
					<form name="loginForm" method="post" action="<%=request.getContextPath()%>/std/Login" onKeyPress="return submitOnEnter(this,event)">
						<div class="row">
							<div class="large-12 columns">
								<label>Username
									<input type="text" id="input-login" name="username" placeholder="Please type your username" required/>
								</label>
							</div>
						</div>

						<div class="row">
							<div class="large-12 columns">
								<label>Password
									<input type="password" id="input-password" name="password" placeholder="Your password" required/>
								</label>
							</div>
						</div>

						<div class="row">
							<div class="large-4 right columns">
								<a href="javascript:submitLogin(document.loginForm)" id="divenable" style="display:block" class="button tiny">
									<s:text name="webportal.index.signin"/>
								</a>					
								<a href="#" disabled="disabled" id="divdisable" style="display:none" class="button tiny custom-deactivebutton">
									<s:text name="webportal.index.signin"/>
								</a>
							</div>
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
					</form>
				</div>
			</div><!-- end of main content -->

		</div>

	<!--[if lt IE 9]>
	<script type="text/javascript" src="https://raw.githubusercontent.com/chuckcarpenter/REM-unit-polyfill/master/js/rem.min.js"></script>
	<![endif]-->
	</body>
</html>
