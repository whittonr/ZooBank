<cfinclude template="header.cfm">

<div class="container">
	<p class="introduction"><span class="tagline">The official registry of zoological nomenclature.</span> ZooBank provides a means for authors and publishers to electronically register new nomenclatural acts, and assigns unique Life Science Identifiers (<abbr title="Life Science Identifier">lsid</abbr>s) to those names. </p>
</div>


<div class="searchBar">
	<div class="container">
		<input type="text" value="chaetodon tinkeri" class="search_input_field" id="taxon_act_search_string" onchange="general_search();" dir="ltr" x-webkit-speech="" x-webkit-grammar="builtin:search" lang="en" size="65">
		<span onclick="general_search();" class="primaryAction small">search</span><span id="search_error"></span>
	</div>
</div>


<div id="results_display_layer"      class="results_display_layer container"></div>
<div id="detailed_results_container" class="detailed_results_container container">
	<div id="ref_details_layer" class="ref_details_layer"></div>
	<div id="ref_names_layer" class="ref_names_layer"></div>
	<div id="ref_authors_layer" class="ref_authors_layer"></div>
</div>
<!---
<div class="container">
	<p class="introduction"><span class="tagline">The official registry of zoological nomenclature.</span> ZooBank provides a means for authors and publishers to electronically register new nomenclatural acts, and assigns unique Life Science Identifiers (<abbr title="Life Science Identifier">lsid</abbr>s) to those names. </p>
</div>

<table class="search_table">
<tr>
	<td><div class="search_container">
<input type="text" class="search_input_field" id="taxon_act_search_string" onchange="general_search();" dir="ltr" x-webkit-speech="" x-webkit-grammar="builtin:search" lang="en" size="65" /> 
</div></td>
	<td><span onclick="general_search();" class="primaryAction small">search</span><span id="search_error"></span></td>
</tr>
</table>


<br />
<br />
<div id="results_display_layer" class="results_display_layer"></div>
<div id="detailed_results_container" class="detailed_results_container">
	<div id="ref_details_layer" class="ref_details_layer"></div>
	<div id="ref_names_layer" class="ref_names_layer"></div>
	<div id="ref_authors_layer" class="ref_authors_layer"></div>		
</div>--->
<!---
<span onclick="launch_get_bhl_data('Proceedings of the United States','101','1951','');">BHL</span>
<div id="bhl_results_layer"></div>
<cfinvoke component="services" method="get_bhl" returnvariable="service_results">
	<cfinvokeargument name="year" value="1951">
	<cfinvokeargument name="title" value="Proceedings of the United States National Museum">
	<cfinvokeargument name="volume" value="101">
</cfinvoke>
<cfoutput>
	<cfdump var="#service_results#">
	#service_results.Result[1].Items[1].ItemID#
</cfoutput>--->


<!---
<cfset myXML = XmlFormat(service_results)>
<cfset inXML = XmlParse(myXML)>
--->
<cfinclude template="footer.cfm">
<cfabort>
<cfquery name="check_BHL" datasource="bhl_h2">
	<!---CREATE INDEX IDXCREATORENAME ON creator(CreatorName)
	CREATE INDEX IDXFULLTITLE ON title(FullTitle)
	CREATE INDEX IDXCREATORTITLEID ON creator(TitleID)
	CREATE INDEX IDXTITLEID ON title(TitleID)
	CREATE INDEX IDXENTITYID ON doi(EntityID)
	CREATE INDEX IDXSUBJTITLEID ON subject(TitleID)
	CREATE INDEX IDXSUBJECT ON subject(subject)
	CREATE INDEX IDXTIDTITLEID ON titleidentifier(TitleID)
	CREATE INDEX IDXITEMID ON page(ItemID)
	CREATE INDEX IDXPAGEID ON page(PageID)
	CREATE INDEX IDXPAGENAMEPAGEID ON pagename(PageID)
	CREATE INDEX IDXNAMECONFIRMED ON pagename(NameConfirmed)
	CREATE INDEX IDXIITEMITEMID ON Item(ItemID)
	CREATE INDEX IDXIITEMTITLEID ON Item(TitleID)
	SELECT COUNT(PageID) from page as EXPR1
	DROP INDEX IF EXISTS IDXIITEM_TITLEID
	SELECT t.FullTitle,p.*,pn.NameConfirmed,t.TitleURL
	from title as t join item as i on t.TitleID = i.TitleID join page as p on i.itemid = p.itemid 	left outer join pagename as pn on pn.PageID = p.PageID 
	where pn.NameCOnfirmed = 'Chaetodon imperator'
	
	SELECT pn.NameConfirmed,p.PageID 
	from PageName as pn join page as p on pn.PageID = p.PageID join item as i on p.itemid = i.itemid
	where pn.NameCOnfirmed like 'Chaetodon imperat%'--->
	
	select pn.*
	from
	pagename as pn
	where <!---p.itemid = 33302--->
	pn.NameConfirmed like 'Chaetodon tink%'
	
	<!---
	SELECT pn.NameConfirmed,p.PageID 
	from PageName as pn join page as p on pn.PageID = p.PageID join item as i on p.itemid = i.itemid
	where pn.NameCOnfirmed like 'Chaetodon imperat%'
	
	SELECT t.FullTitle,p.*,pn.NameConfirmed,t.TitleURL
	from title as t join page as p on t.TitleID = p.itemid 	left outer join pagename as pn on pn.PageID = p.PageID 
	where t.TitleID = 29911
	
	SELECT t.FullTitle,p.PageNumber,pn.NameConfirmed
	from tital as t join page as p on t.TitleID = p.itemid 	join pagename as pn on pn.PageID = p.PageID
	where pn.NameConfirmed like 'imperator'
	
	SELECT t.* , p.PageNumber, p.Year as page_year
	from title as t join page as p on t.TitleID = p.ItemID
	where TitleID = 12540
	
	SELECT t.FullTitle, pn.NameConfirmed,p.PageNumber
	from title as t join page as p on t.TitleID = p.itemID join pagename as pn on pn.PageID = p.PageID
	where TitleID = 52237
	
	SELECT     TOP (200) pn.NameConfirmed,p.PageNumber,c.CreatorType, c.CreatorName, c.CreationDate, t.FullTitle, t.LanguageCode, t.TitleURL, t.ShortTitle,s.subject ,tid.IdentifierName,tid.identifierValue,d.DOI
	FROM         creator as c join title as t on c.TitleID = t.TitleID join subject as s on s.TitleID = t.TitleID left outer join titleidentifier as tid on tid.TitleID = t.TitleID
	LEFT OUTER JOIN doi as d on d.EntityID = t.TitleID left outer join page as p on t.titleid = p.ItemID left outer join pagename as pn on p.PageID = pn.PageID
	WHERE     (c.CreatorName LIKE 'Pyle, R%')
	
	SELECT     TOP (200) c.CreatorType, c.CreatorName, c.CreationDate, t.FullTitle, t.LanguageCode, t.TitleURL, t.ShortTitle,s.subject ,tid.IdentifierName,tid.identifierValue,d.DOI
	FROM         creator as c join title as t on c.TitleID = t.TitleID join subject as s on s.TitleID = t.TitleID left outer join titleidentifier as tid on tid.TitleID = t.TitleID
	LEFT OUTER JOIN doi as d on d.EntityID = t.TitleID
	WHERE     (c.CreatorName LIKE 'Pyle, R%') --->
</cfquery><!---
<cfoutput query="check_bhl">

	#FullTitle#  #TitleURL# <a href="http://www.biodiversitylibrary.org/pagethumb/#PageID#,400,600" target="_blank">BHL Page</a><br />
</cfoutput>--->




<cfdump var="#check_BHL#">		