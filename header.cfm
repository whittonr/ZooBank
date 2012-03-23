<cfparam name="method" default="">
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en"> 
<head>
	<cfif FindNoCase("MSIE",HTTP_USER_AGENT)>
		<script type="text/javascript" src="https://getfirebug.com/firebug-lite.js"></script>
	</cfif>
	<meta http-equiv="Content-Language" content="English" />
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title>ZooBank.org</title>
	

	<cfset cssFiles = ArrayNew(1)>
<cfset ArrayAppend( cssFiles, "/admin/css/redmond/jquery-ui-1.8.16.custom.css" )>
<cfset ArrayAppend( cssFiles, "/admin/css/zoobank.css" )>
<cfset ArrayAppend( cssFiles, "/admin/css/dynamicCSS.css" )>
<cfstylesheet src="#cssfiles#" minimize="true">
	<cfset jsFiles = ArrayNew(1)>
	<cfset ArrayAppend( jsFiles, "/admin/js/zoobank.js" )>
	<cfset ArrayAppend( jsFiles, "/admin/js/jquery-1.6.2.min.js" )>
	<cfset ArrayAppend( jsFiles, "/admin/js/jquery-ui-1.8.16.custom.min.js" )>
	<cfset ArrayAppend( jsFiles, "/admin/js/jquery.validate.min.js" )>
	<cfset ArrayAppend( jsFiles, "/admin/js/json2.js" )>
	<cfset ArrayAppend( jsFiles, "/admin/js/jquery.corner.js" )>
	<cfset ArrayAppend( jsFiles, "/admin/js/autocompletes.js" )>
	
	<cfjavascript src="#jsFiles#" minimize="true" munge="true" output="head">
	
</head>
<body>
	<cfset jsFiles = ArrayNew(1)>
	<cfset ArrayAppend( jsFiles, "/admin/js/wz_tooltip.js" )>
	<cfset ArrayAppend( jsFiles, "/admin/js/tip_balloon.js" )>
	<cfset ArrayAppend( jsFiles, "/admin/js/index.js" )>
	<cfjavascript src="#jsFiles#" minimize="true" munge="true" output="body">
	

	<!---<link href="https://raw.github.com/rschenk/ZooBank-UI/master/public/stylesheets/screen.css" media="screen, projection" rel="stylesheet" type="text/css" />--->
	<link href="/admin/css/screen.css" media="screen, projection" rel="stylesheet" type="text/css" />
	<!---
	<link href="https://raw.github.com/rschenk/ZooBank-UI/styles_for_rob/public/stylesheets/screen.css?login=rschenk&token=f8f7020bf795e2beb0ac067c089e8600" media="screen, projection" rel="stylesheet" type="text/css" />--->
	<header id="header">
	<div class="container">
		<h1 class="logo"><a href="/">ZooBank</a></h1>
		<nav>
			<ul>
				<li><a href="/about">about</a></li>
				<li><a href="/contact">contact</a></li>
				<li><a href="/api">api</a></li>
				<li class="login_container">
				   <a id="login_link" href="#login_form_layer">login</a>
				   <div id="login_form_layer" style="display:none;" class="login_form">
					   <form action="/do_login.cfm" method="post" class="uniForm">
						   <fieldset>
							   <div class="ctrlHolder">
								 <label for="username">Username</label> <input name="username" id="username" type="text" >
							   </div>
							   <div class="ctrlHolder">
								 <label for="password">Password</label> <input name="password" id="password" type="password" >
							   </div>
						   </fieldset>
						   <div class="buttonHolder">
								   <button type="submit" id="btn_login" class="primaryAction small">Log In</button>
								   <!-- You'll need some jquery to hide the login button when Cancel is clicked -->
								   <button type="submit" id="btn_canel_login" class="secondaryAction">Cancel</button>
						   </div>
						   <div class="helpful_links">
								   <p><a href="{{{{forgot password}}}}">Forgot your password?</a></p>
								   <p><a href="{{{{create an account}}}}">Create an account</a></p>
						   </div>
					   </form>
				   </div>
				</li>	
			</ul>	
			
			
		</nav>
	</header>
	<cfif ListLast(cgi.PATH_TRANSLATED,"\") is "index.cfm" or method is "register" or method is "log_out">
	<cfelse>
	<div class="searchBar">
		<div class="container">
			<input type="text" class="search_input_field" id="taxon_act_search_string" onchange="general_search();" dir="ltr" x-webkit-speech="" x-webkit-grammar="builtin:search" lang="en" size="65">
			<span onclick="general_search();" class="primaryAction small">search</span><span id="search_error"></span>
		</div>
	</div>
	</cfif>
	<cfparam name="display_message" default="">
	<cfif display_message is not "">
		<cfset message_vis = "">
	<cfelse>
		<cfset message_vis = " style='display:none;'">
	</cfif>
	<cfoutput>
	<div class="container">
		<div class="okMsg"#message_vis#>#display_message#
		</div>
	</div>
	</cfoutput>
		