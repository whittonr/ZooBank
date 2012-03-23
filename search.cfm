

<cfobject component="gnub_services" name="service">
<cfinvoke component="#service#" method="get_author" returnvariable="author_results">
	<cfinvokeargument name="search_term" value="#search_term#">
</cfinvoke>
<cfinvoke component="#service#" method="get_protonym" returnvariable="protonym_results">
	<cfinvokeargument name="search_term" value="#search_term#">
</cfinvoke>
<cfinvoke component="#service#" method="get_reference" returnvariable="reference_results">
	<cfinvokeargument name="search_term" value="#search_term#">
</cfinvoke>

<cfif format is "html">
	<cfinclude template="/header.cfm">
	<div class="container">
		<h2>Search Results</h2>
		<hr>
		<h3>Authors</h3>
		<ol>
		<cfoutput query="author_results">
			<li><a href="/Authors/#AgentUUID#"><cfif IsPerson is 1>#FamilyName#, #GivenName# #Prefix#<cfelse>#OrganizationName#</cfif></a>
			<cfif PreferredID is not PKID>
				&nbsp;[alias of: <a href="/Authors/#PreferredUUID#"><cfif IsPerson is 1>#PreferredFamilyName#, #PreferredGivenName# #PreferredPrefix#<cfelse>#PreferredOrganizationName#</cfif></a>]
			</cfif>
			</li>
		</cfoutput>
		</ol>
		
		
		<hr>
		<h3>Names</h3>
		<cfdump var="#protonym_results#">
		<hr>
		<h3>Publications</h3>
		<cfdump var="#reference_results#">
	</div>
	<cfinclude template="/footer.cfm">
<cfelseif format is "json">



<cfelseif format is "xml">



</cfif>








