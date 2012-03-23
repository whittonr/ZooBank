<!--- References controller --->
<cfif format is "html">
	 <cfheader
	statuscode="200"
	statustext="ok"
	/>
	<cfinclude template="/header.cfm">
	

	
	<cfinvoke component="services" method="find_taxon_act" returnvariable="get_act_details">
		<cfif IsNumeric(search_term)>
			<cfinvokeargument name="TaxonNameUsageID" value="#search_term#">
		<cfelse>
			<cfinvokeargument name="term" value="#search_term#">
		</cfif>
	</cfinvoke>
	
	<!---<cfdump><cfabort>--->
	
	<cfset act_details = DeserializeJSON(get_act_details)>
	<cfoutput>
	<cfif act_details[1].id gt 0>
		<div class="container">
			<div class="actSummary">
				<h2 class="actName">
					#act_details[1].NameComplete#
				</h2>
				<cfif act_details[1].lsid is not "">
				<div class="lsidWrapper">
					<span class="lsidLogo">LSID</span><input type="text" value="#act_details[1].lsid#" class="selectAll lsid"><object width="110" height="14" id="clippy" classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000">
						<param value="/public/flash/clippy.swf" name="movie">
						<param value="always" name="allowScriptAccess">
						<param value="high" name="quality">
						<param value="noscale" name="scale">
						<param value="text=#act_details[1].lsid#" name="FlashVars">
						<param value="##f5f5ff" name="bgcolor">
						<embed width="110" height="14" bgcolor="##F5F5FF" flashvars="text=#act_details[1].lsid#" pluginspage="http://www.macromedia.com/go/getflashplayer" type="application/x-shockwave-flash" allowscriptaccess="always" quality="high" name="clippy" src="/public/flash/clippy.swf">
					</object><script charset="utf-8" type="text/javascript">
		$(".selectAll").click(function(){ this.select(); });
					</script>
				</div>
				</cfif>
				<table>
					<tbody>
						<tr>
							<th scope="row">
								Rank
							</th>
							<td>
								#act_details[1].Rank#
							</td>
						</tr>
						<tr>
							<th scope="row">
								Parent
							</th>
							<td>
								#act_details[1].FormattedParent#
							</td>
						</tr>
						<tr>
							<th scope="row">
								Publication
							</th>
							<td colspan="2">
								<span class="biblio-entry"><span class="biblio-authors">#act_details[1].CheatFullAuthors#</span> #act_details[1].Year# <span class="biblio-title">#act_details[1].Title#</span> #act_details[1].CheatCitationDetails#&nbsp;<a href="/References/#act_details[1].ReferenceID#">[show all names in ref.]</a></span>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		<div id="bhl_results" class="bhl_results alt_row">
			<div class="container">
				<div class="outlink">
					<h3>Literature</h3>
			
					<div class="attribution">
						<a class="attributionLogoWrapper" href="http://biodiversitylibrary.org" target="_blank" >
							<img src="/images/BHLlogo.png" />
						</a>
						<!-- You want to se the line-height below to the height of the logo image above + 6px to get the text to line up nicely-->
						<p style="line-height: 34px">Literature images courtesy of the <a href="http://biodiversitylibrary.org" target="_blank">Biodiversity Heritage Library</a>.</p>
					</div>
			
			
					<div class="bhlPageImages">
						<cfloop list="#act_details[1].bhl_pageid#" index="temp_imageid">
						<div class="bhlPage">
							<a class="thumbnail" href="http://www.biodiversitylibrary.org/pagethumb/#temp_imageid#,600,800" target="_blank">
								<img src="http://www.biodiversitylibrary.org/pagethumb/#temp_imageid#,80,200">
							</a>
							<a href="http://biodiversitylibrary.org/page/#temp_imageid#" target="_blank">Page: ___</a>
						</div>
						</cfloop>
					</div>
				</div>
			</div>
			
		</div><!--- end bhl_results --->
		<div id="gni_detailed_results_layer" class="gni_results">
				<div class="container">
					<div class="outlink">

						<h3>Related Names</h3>
				
						<div class="attribution">
							<a class="attributionLogoWrapper" href="http://gni.globalnames.org" target="_blank" >
								<img src="/images/gni-logo.png" />
							</a>
							<!-- You want to se the line-height below to the height of the logo image above + 6px to get the text to line up nicely-->
							<p style="line-height: 42px">Additional names information provided courtesy of the <a href="http://gni.globalnames.org" target="_blank">Global Names Index</a>.</p>
						</div>
				<cfhttp URL="http://gni.globalnames.org/name_strings.json">
					<cfhttpparam name="search_term" value="#act_details[1].NameComplete#" type="url">
				</cfhttp>
				<cfset results = DeserializeJSON(cfhttp.filecontent)>
				
						<ol>
							<cfloop from="1" to="#Len(results)#" step="1" index="i">
							<li>#results.name_strings[i].name#</li>
							</cfloop>

						</ol>
					</div>
				</div>
			</div>
			
		<cfhttp URL="http://explorers-log.com/names.json?">
			<cfhttpparam name="search_term" value="#act_details[1].NameComplete#" type="url">
			<cfhttpparam name="__BDRETURNFORMAT" value="jsonp" type="url">
		</cfhttp>
		
		<cfset result_set = DeserializeJSON(cfhttp.filecontent)>
		<!---
		<cfloop index="json" list="#cfhttp.filecontent#" delimiters="#chr(10)#">
			#json#<br />
		</cfloop>--->
		<cfset best_image_uuid = "">
		<cfset best_image_quality = 10>
		<cfset number_video_clips = 0>
		<cfset number_still_images = 0>
		<cfset number_visual_observations = 0>
		<cfoutput query="result_set">
			<cfif media_type is "MovingImage">
				<cfset number_video_clips = number_video_clips + 1>
			</cfif>
			<cfif media_type is "StillImage">
				<cfset number_still_images = number_still_images + 1>
			</cfif>
			<cfif samplingprotocol is "Visual Observation">
				<cfset number_visual_observations = number_visual_observations + 1>
			</cfif>
			<cfif content_quality lt best_image_quality>
				<cfset best_image_uuid = media_uuid>
			</cfif>
		</cfoutput>
		<!---<cfdump var="#result_set#">--->
		<!---<cfif Len(cfhttp.filecontent) gt 5>--->
		<cfoutput>
			<div id="el_results_layer" class="el_results alt_row">
				<div class="container">
					<div class="outlink">
						<h3>Observations from Explorer's Log</h3>
						<div class="attribution">
							<a class="attributionLogoWrapper" href="http://www.explorers-log.com" target="_blank" >
								<img src="/images/el-logo.png" />
							</a>
							<!-- You want to se the line-height below to the height of the logo image above + 6px to get the text to line up nicely-->
							<p style="line-height: 34px">Observation data provided courtesy of <a href="http://www.explorers-log.com" target="_blank">Explorer's Log</a>.</p>
						</div>
				
						#result_set.recordcount# records in Explorers Log<br>
						#number_video_clips# Video Clips<br>
						#number_still_images# Still Images<br>
						#number_visual_observations# Visual Observations<br>
						<img src="http://www.explorers-log.com/#best_image_uuid#">
					</div>
				</div>
			</div>
		<!---</cfif>--->
		</cfoutput>
		</div>
	<cfelse>
		NOT FOUND #search_term#  - #method#
	</cfif>
	<!---<cfdump var="#act_details#">--->
	
		
	</cfoutput>
	<cfinclude template="/footer.cfm">
	<cfabort>
<cfelseif format is "json">
	
	<cfinvoke component="services" method="find_taxon_act" returnvariable="get_act_details">
		<cfif search_term is not "">
			<cfif IsNumeric(search_term)>
				<cfinvokeargument name="TaxonNameUsageID" value="#search_term#">
			<cfelse>
				<cfinvokeargument name="term" value="#search_term#">
			</cfif>
		<cfelse>
			<cfinvokeargument name="TaxonNameUsageID" value="#url.TaxonNameUsageID#">
		</cfif>
	</cfinvoke>
	
	
	
	
	<cfset response = get_act_details>
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


