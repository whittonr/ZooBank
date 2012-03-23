<!--- References controller --->
<cfif format is "html">

	<cfinclude template="/header.cfm">
	
	<cfoutput>
	<cfinvoke component="services" method="find_pub" returnvariable="get_reference_details">
		<cfinvokeargument name="ReferenceID" value="#search_term#">
	</cfinvoke>
	<cfset ref_details = DeserializeJSON(get_reference_details)>
	<!---<cfdump var="#ref_details#"><cfabort>--->
	<div class="container">
		<div class="actSummary">
			<h2 class="actName">
				#ref_details[1].title#
			</h2>
			<cfif ref_details[1].lsid is not "">
			<div class="lsidWrapper">
				<span class="lsidLogo">LSID</span><input type="text" value="#ref_details[1].lsid#" class="selectAll lsid"><object width="110" height="14" id="clippy" classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000">
					<param value="/public/flash/clippy.swf" name="movie">
					<param value="always" name="allowScriptAccess">
					<param value="high" name="quality">
					<param value="noscale" name="scale">
					<param value="text=#ref_details[1].lsid#" name="FlashVars">
					<param value="##f5f5ff" name="bgcolor">
					<embed width="110" height="14" bgcolor="##F5F5FF" flashvars="text=#ref_details[1].lsid#" pluginspage="http://www.macromedia.com/go/getflashplayer" type="application/x-shockwave-flash" allowscriptaccess="always" quality="high" name="clippy" src="/public/flash/clippy.swf">
				</object><script charset="utf-8" type="text/javascript">
	$(".selectAll").click(function(){ this.select(); });
				</script>
			</div>
			</cfif>
			<table>
				<tbody>
					<tr>
						<th scope="row">
							Publication
						</th>
						<td colspan="2">
							<span class="biblio-entry"><span class="biblio-authors">#ref_details[1].CheatFullAuthors#</span> #ref_details[1].Year# <span class="biblio-title">#ref_details[1].Title#</span> #ref_details[1].CheatCitationDetails#</span>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
	
	</cfoutput>
	<cfinvoke component="services" method="get_nomenclatural_acts" returnvariable="get_reference_acts">
		<cfinvokeargument name="ReferenceID" value="#search_term#">
	</cfinvoke>
	<div class="container">
		<div id="actsResults">
		<ol>
		<cfoutput query="get_reference_acts">
			<li><a href="/TaxonActs/#TaxonNameUsageID#">#FormattedDisplay#</a> <span><cfif lsid is not "">#lsid#</cfif></span></li>
		</cfoutput>
		</ol>
		</div>
	</div>
	<!--- <cfdump var="#get_reference_acts#">--->
	<cfinclude template="/footer.cfm">
	<cfabort>
<cfelseif format is "json">
	<cfinvoke component="services" method="find_pub" returnvariable="get_reference_details">
		<cfinvokeargument name="ReferenceID" value="#search_term#">
	</cfinvoke>
	
	<cfinvoke component="services" method="get_nomenclatural_acts" returnvariable="get_reference_acts">
		<cfinvokeargument name="ReferenceID" value="#search_term#">
	</cfinvoke>

	<cfset response = '#Replace(get_reference_details,"]",",","ONE")# #SerializeJSON(get_reference_acts,false,"lower","long")# ]'>
	<cfif format is "jsonp">
		<cfset response = "#callback_value# (#response#)">
	</cfif>
	<cfset responseBinary = toBinary(toBase64(response)) />
	 <!---

	Tell the client how much data to expect so that it knows when
	to close the connection with the server.
	--->
	<cfheader
	name="content-length"
	value="#arrayLen( responseBinary )#"
	/>
	 <cfheader
	statuscode="200"
	statustext="ok"
	/>
	<!--- Stream the content back to the client. --->
	<cfcontent
	type="application/json; charset=utf-8"
	variable="#responseBinary#"
	/>
	
</cfif>


