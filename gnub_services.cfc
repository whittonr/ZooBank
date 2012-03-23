<!--- ----------------------------------------- --->
<!--- 
	NAME: gnub_services.cfc

	PURPOSE:  Provide a library of general functions to handle processing, to centralize the code.

	LAST MODIFIED: 3/22/2011 - created
	
	CREATED:  3/22/2011 - created
	
	AUTHOR: Robert Whitton

	NOTES:  
		METHODS
			find_author
			
			
 --->
<!--- ----------------------------------------- --->
<cfcomponent>
	<cfset datasource = "taxonomer_sandbox">
	
	<!---  AUTHORS --->
	<!---  AUTHORS --->
	<cffunction name="get_author" output="true">
		<cfargument name="search_term" type="string" required="no" default="">
		<cfargument name="Family_name" type="string" required="no">
		<cfargument name="Given_Name" type="string" required="no">
		<cfargument name="AgentId" type="string" required="no" default="">
		<cfargument name="AgentUUID" type="string" required="no" default="">
		<!--- INPUTS:
		AgentId
		AgentUUID
		FamilyNm
		GivenNm
		SearchTerm
		IncludePers
		IncludeOrg
		SearchType - default to begins with
		--->

		<cfquery datasource="#datasource#" name="get_authors">
			EXEC dbo.sp_SearchAgentName @IncludePers=1
			<cfif Arguments.search_term is not "">
				,@SearchTerm='#search_term#'
			</cfif>
			<cfif isDefined("Family_name")>
				,@FamilyNm = '#Family_Name#'
			</cfif>
			<cfif isDefined("Given_Name")>
				,@GivenNm = '#Given_Name#'
			</cfif>
			<cfif Arguments.AgentId gt 0>
			,@AgentId='#Arguments.parentID#'
			</cfif>
			<cfif Arguments.AgentUUID gt 0>
			,@AgentUUID='#Arguments.AgentUUID#'
			</cfif>
		</cfquery>	
		<cfreturn get_authors />
	</cffunction>
	
	<!---  PROTONYMS --->
	<!---  PROTONYMS --->
	<cffunction name="get_protonym" hint="Returns a list of names that match search string">
		<cfargument name="RankGroup" type="string" required="no" default="Species">
		<cfargument name="search_term" type="string" required="no">
		<cfargument name="ProtonymID" type="numeric" required="no">
		<cfargument name="display_type" type="string" required="no" default="autocomplete">
		<!--- INPUT:
		@RankGroup ('Family'|'Genus'|'Species')
		@SearchTerm - any part of taxon name you'r looking for
		
		OUTPUT:
		LSID
		ProtonymID
		TaxonRankID
		NameString - the name only (no author)
		CheatNameComplete - formatted?
		CleanDisplay - No HTML markup added
		FormattedDisplay - HTML markup added
		Sort --->
		<cfquery name="get_names" datasource="#datasource#">
			EXEC 	sp_SearchProtonym
			@RankGroup = <cfqueryparam cfsqltype="cf_sql_varchar" value="#Arguments.RankGroup#">,
			@SearchTerm = <cfqueryparam cfsqltype="cf_sql_varchar" value="#Arguments.search_term#">	

			<!---SELECT     p.ProtonymID, p.TypeProtonymID, p.WordTypeID, p.NomenCodeID, p.GenderID, p.IsFossil, p.Grade, p.CheatAvailable, p.CheatHomonym, p.CheatFullProtonym, 
                      p.CheatAcceptedUsageID, p.CheatHierarchy, p.OriginalParent, p.Types, p.TypeLocality, p.Authors, p.IsGenderMatched, tn.TaxonNameUsageID, 
                      tn.ProtonymID AS Expr1, tn.ReferenceID, tn.TaxonRankID, tn.ValidUsageID, tn.ParentUsageID, tn.ReliabilityID, tn.NameString, tn.Prefix, tn.Suffix, tn.Pages, 
                      tn.Illustration, tn.IsNothoTaxon, tn.IsQuestioned, tn.IsNewCombination, tn.IsFirstRevision, tn.tsn, tn.CheatNameComplete, tn.CheatIsAutonym, tn.CheatStatus
			FROM         Protonym AS p INNER JOIN
								  TaxonNameUsage AS tn ON tn.ProtonymID = p.ProtonymID
			WHERE     p.ProtonymID <> 0
			<cfif Arguments.search_term is not "">
				AND (tn.CheatNameComplete like '#Arguments.search_term#')
			</cfif>
			--->
			
		</cfquery>
		<cfif Arguments.display_type is not "autocomplete">
			<cfreturn get_names />
		<cfelse>
		</cfif>
	</cffunction>
	<!--- REFERENCES --->
	<!--- REFERENCES --->
	<cffunction name="get_reference">
		<cfargument name="search_term" type="string" required="no">
		<cfargument name="journals_only" type="string" required="no" default="0">
		<cfargument name="ReferenceID" type="string" required="no">
		<!---  Stored Procedures
		input Parameters:  @ReferenceID, @UUID, @AuthorIDList (comma delimited list of authors), @SearchTerm (parsed), @FuzzyMatch (boolean, defaults to true (ignores diacritics), @IsRegistered (has LSID) (1 registered only, 0 only unregistered, else both), @IsPeriodical, @PublishedOnly (hides the in press entries)
		
		RETURNS: UUID, ReferenceID (PKID), ParentReferenceID, LSID, SearchString, CleanSearchString (no diacriticals - plain text), IsPublished, ReferenceTypeID, CheatFullAuthors,Year,Title,Publisher,PlacePublished, Volume,Number,Pages,Edition,DatePublished,Figures,StartDate (earliest poss. published date), EndDate (latest poss. date published), CheatCitation (Author and Year), CheatCitationDetails (everything after title), CheatAuthors (last names only), CleanTitle (no HTML tags)
		--->
		<cfquery datasource="#datasource#" name="get_pubs">
			EXEC sp_SearchReference 
			@IsPeriodical = #Arguments.journals_only#
			<cfif Arguments.search_term is not "">,@SearchTerm = '#Arguments.search_term#'</cfif>			
			<cfif Arguments.ReferenceID gt 0>,@ReferenceID = #Arguments.ReferenceID#</cfif>			
		</cfquery>

		
		<cfreturn get_pubs />	
	</cffunction>
	
	<cffunction name="get_external_identifiers">
		<cfargument name="uuid" type="string" required="no">
		<cfargument name="pkid" type="string" required="no" default="">
		<!---INPUT
		@UUID
		@PKID--->
		
		<cfquery datasource="#datasource#" name="get_ids">
			EXEC sp_GetExternalIdentifiers
			<cfif Arguments.uuid is not "">
				@UUID = '#Arguments.uuid#'
			<cfelse>
				@PKID = '#Arguments.PKID#'
			</cfif>
		</cfquery>
	
		<cfreturn get_ids />
	</cffunction>
	
</cfcomponent>