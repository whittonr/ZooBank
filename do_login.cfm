<!--- Check that the username is valid--->
<cfinvoke component="admin.user_services" method="validate_user" returnvariable="isValid">
	<cfinvokeargument name="username" value="#form.username#">
</cfinvoke>
<cfif IsValid is 1>
	<cfset session.username = username>
	<cfset session.IsAuthenticated = true>
	<cflocation url="/editor" addtoken="no">
<cfelse>
	<cfinclude template="/header.cfm">
		<div class="container">
		<h1 class=celllg>Invalid Username</h1>
		<p class="celllg">Forgotten Username?<br />
		Enter your registered email address below and we will send your username to that address.<br /><br />
		Registered Email Address <input type="text" size="80" name="registered_email" id="registered_email" /><br /><br />
		<button>Send me my username</button>
		</p>
		<cfset session.IsAuthenticated = false>
		<cfset session.username = "">
		</div>
	<cfinclude template="/footer.cfm">
</cfif>