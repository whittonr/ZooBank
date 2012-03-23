

<cfobject component="gnub_services" name="service">
<cfinvoke component="#service#" method="get_author" returnvariable="author_results">
	<cfif Len(search_term) is 36 or Len(search_term) is 33>
		<cfinvokeargument name="AgentUUID" value="#search_term#">
	<cfelse>
		<cfinvokeargument name="search_term" value="#search_term#">
	</cfif>
</cfinvoke>




<cfif format is "html">
	<cfinclude template="/header.cfm">
	<div class="container">
		
		<h2><cfif author_results.IsPerson>Person<cfelse>Organization</cfif> Details</h2>
		<hr>
		<h3>Name</h3>
		<cfoutput>
			<li><cfif author_results.IsPerson>#author_results.FamilyName#, #author_results.GivenName# #author_results.Prefix#<cfelse>#author_results.Organization#</cfif></li>
		</cfoutput>
		Alias<br />
		<cfoutput query="author_results" startrow="2">
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<cfif author_results.IsPerson>#author_results.FamilyName#, #author_results.GivenName# #author_results.Prefix#<cfelse>#author_results.Organization#</cfif><br />
		</cfoutput>
		
		<cfinvoke component="#service#" method="get_external_identifiers" returnvariable="get_ids">
			<cfinvokeargument name="UUID" value="#author_results.AgentUUID#">
		</cfinvoke>
		<hr>
		<h3>External Identifiers</h3>
		<cfoutput query="get_ids">
			#IdentifierClass# #Identifier#<br/>
		
		</cfoutput>
		<hr>
		<h3>Publications</h3>
		<!---<cfdump var="#reference_results#">--->
	<cfinclude template="/footer.cfm">
<cfelseif format is "json">



<cfelseif format is "xml">



</cfif>








