<cfinclude template="header.cfm">




<div class="container">
<H3>API</h3>
<div style="width:1000px;text-align:left;">
<h2>Authors</h2>
Find an Author: <a href="http://test.zoobank.org/editor/services.cfc?method=find_author&term=pyle" target="_blank">http://test.zoobank.org/editor/services.cfc?method=find_author&term=pyle</a><br />

Find an Author's aliases: <a href="http://test.zoobank.org/editor/services.cfc?method=find_author&parentID=19670408" target="_blank">http://test.zoobank.org/editor/services.cfc?method=find_author&parentID=19670408</a><br />

Show an Author's Publications: <a href="http://test.zoobank.org/editor/services.cfc?method=show_author_pubs&AuthorID=19670408" target="_blank">http://test.zoobank.org/editor/services.cfc?method=show_author_pubs&AuthorID=19670408</a><br />


<h2>Publications</h2>
Search Publications: <a href="http://test.zoobank.org/editor/services.cfc?method=find_pub&term=hoplolat" target="_blank">http://test.zoobank.org/editor/services.cfc?method=find_pub&term=hoplolat</a> <br />


For a given reference, show the authors: <a href="http://test.zoobank.org/editor/services.cfc?method=get_pub_authors&ReferenceID=19729101" target="_blank">http://test.zoobank.org/editor/services.cfc?method=get_pub_authors&ReferenceID=19729101</a><br />

For a given reference, show the taxonom acts: <a href="http://test.zoobank.org/editor/services.cfc?method=get_nomenclatural_acts&ReferenceID=19729101" target="_blank">http://test.zoobank.org/editor/services.cfc?method=get_nomenclatural_acts&ReferenceID=19729101</a><br />

<h2>Taxon Name</h2>

Find a taxonomic name: <a href="http://zoobank.explorers-log.com/Names?search_term=chromi&RankGroup=Genus" target="_blank">
	http://zoobank.explorers-log.com/Names?search_term=chromi&RankGroup=Genus</a><br /><br />
	
	<a href="http://zoobank.explorers-log.com/Names.json?search_term=chromi" target="_blank">
	http://zoobank.explorers-log.com/Names.json?search_term=chromi</a><br /><br />

<h2>Taxon Name Usage</h2>	
	
	Search for a taxon name usage: 
	http://zoobank.explorers-log.com/TaxonActs.json?search_term=&TaxonNameUsageID=20393331</a><br /><br />
	
	Get a specific usage:
	http://zoobank.explorers-log.com/TaxonActs/20393331<br /><br />

	
	
	
	
	
	
	
	
Add a new taxon name usage: http://test.zoobank.org/editor/services.cfc?method=insert_taxon_name&Pages=&ReferenceID=19729101&TaxonRankID=60&NameString=Hoplolatilus&Authors=Basset%2C+Novotny%2C+Miller+%26+Pyle&Types=&IsFossil=0&LogUserName=whittonr&establish_protonym=0&assign_zb_lsid=0&ProtonymID=20316739&Illustration=&ParentUsageID=
<br /><br />
This example shows the registration of the usage of the genus (TaxonRankID=60) "Hoplolatilus" (TaxonID: 20316739) in Reference 19729101 ; not a fossil record (IsFossil=0) and do not establish_protonym since this is already a known genus<br />

Returns: new_taxon_name_usage_id - internal ZooBank ID - not an LSID
</div>


</div>

<cfinclude template="footer.cfm">