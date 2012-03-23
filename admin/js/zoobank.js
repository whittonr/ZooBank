// JavaScript Document
var test_environment = 0;
function show_pubs(author_id, author_name,layer_name,show_select_button){
	var show_select_button = 0;
	document.getElementById(layer_name).innerHTML = '<span class="question_options_text">Recalling published works...</span><img src="/images/loading_blue.gif" />';
	var pub_list_html = '<table>';
	if(show_select_button==1){
			pub_list_html = pub_list_html + '&nbsp;<button onclick="add_author_to_list('+author_id+',&quot;'+author_name+'&quot;);$( &quot;#select_author&quot; ).dialog(&quot;close&quot;);$( &quot;#pub_layer&quot; ).dialog(&quot;close&quot;);">This is the author</button>';
		}	
	var get_pubs = $.ajax({
	url: "/services.cfc?method=show_author_pubs",
	type: "get",
	data: ({AuthorID:author_id}),
	success: function(msg){
		
		var results = JSON.parse(msg);//some browsers cannot natively parse the JSON result
		if(results.status=="undefined") document.getElementById('pub_layer').innerHTML = "no results";
		else if(results.data.length>0){
			pub_list_html = pub_list_html + '<tr><td colspan="2" style="width:800px;" class="form_instructions_text"><span>Review the list of Published Works below and select the Work involved with this Registration. If the Work is not on the list, ensure this is the correct person, and select (or create) the name of the author <em>exactly</em> as it appears in the Published Work itself.<br \/>'+results.data.length+' Publication';
				   
			if(results.data.length>1) pub_list_html = pub_list_html + 's';
			pub_list_html = pub_list_html + ':</span><br \/><\/td><\/tr>';
			for(x=0;x<results.data.length;x++){
				row_class = 'regular_row';
				if(x%2==0) row_class = 'alt_row';
				
				full_citation = results.data[x][8] +', '+results.data[x][9]+'. '+results.data[x][10]+' '+results.data[x][22];
				pub_list_html = pub_list_html + '<tr class="'+row_class+'"><td>' + full_citation +'<\/td><td><button type="button" onclick="select_publication('+results.data[x][1]+',&quot;'+full_citation+'&quot;,&quot;'+results.data[x][23]+'&quot;);$( &quot;#select_author&quot; ).dialog(&quot;close&quot;);$( &quot;#pub_layer&quot; ).dialog(&quot;close&quot;);">Select<\/button><\/td><\/tr>';
			
			}//end for loop
			   
		document.getElementById(layer_name).innerHTML = pub_list_html + '<\/table>';
		//style the buttons
		$( "button" ).button();
		}//end else
		else document.getElementById(layer_name).innerHTML = '';
		}
	}
).responseText;			
	
}//end function show_pubs

function get_pub_types(layer_name){
	var select_html = '<select name="pub_type" id="pub_type">';
	var get_pub_types = $.ajax({
	url: "/services.cfc?method=get_pub_types",
	type: "get",
	success: function(msg){
		
		//var results = msg;
		var results = JSON.parse(msg);//some browsers cannot natively parse the JSON result
		//alert(results.geonames[0].countryName);
		if(results.status=="undefined") document.getElementById('pub_layer').innerHTML = "no results";
		else {
			for(x=0;x<results.data.length;x++){
				select_html = select_html + '<option value="' + results.data[x][0] + '">'+results.data[x][1]+'<\/option>';
			
			}//end for loop
		document.getElementById(layer_name).innerHTML = select_html + '<\/select>';
		}//end else
		}
	}
).responseText;			

}//end function get_pub_types


function get_aliases(pkid,layer_name){
	var alias_html = '<form id="form_select_author" name="form_select_author" action="" method="get">';
	var get_alias = $.ajax({
	url: "/services.cfc?method=find_author",
	type: "get",
	data: ({parentID:pkid}),
	success: function(msg){
		
		//var results = msg;
		var results = JSON.parse(msg);//some browsers cannot natively parse the JSON result
		//alert(results.geonames[0].countryName);
		if(results.status=="undefined") document.getElementById('alias_layer').innerHTML = "no alias";
		else {
			var has_lsid = 0;
			var lsid_html = '';
			for(x=0;x<results.length;x++){
				if(results.length==1||results[x].id==pkid) display_checked = 'checked';
				else display_checked = '';
				alias_html = alias_html + '<input type="radio" name="group1" id="correct_author_id" value="'+results[x].id+'~'+results[x].label+'~'+results[x].validagentid+'~'+results[x].givenname+'~'+results[x].familyname+'~'+results[x].ZBLSID+'" '+display_checked+' \/> '+results[x].label;
				if(results[x].ZBLSID=='') alias_html = alias_html + '';
				else {
					//alias_html = alias_html + ' <img src="/images/lsidlogo.jpg" onclick="$(&quot;#lsid_display_'+x+'&quot;).toggle();" /><span id="lsid_display_'+x+'" style="display:none;"> '+results[x].ZBLSID+'<\/span>';
					if(has_lsid==0) {
						has_lsid = results[x].ZBLSID;
						lsid_html = ' <img src="/images/lsidlogo.jpg" onclick="$(&quot;#lsid_display&quot;).toggle();" /><span id="lsid_display" style="display:none;"> '+results[x].ZBLSID+'<\/span>';
						}
					}
				alias_html = alias_html + '<br \/>';
				//<button onclick="add_author_to_list('+pkid+',&quot;'+results[x].label+'&quot;);$(&quot;#select_author&quot;).dialog(&quot;close&quot;);clear_author_form();" type="button">This is the Correct Author</button>
			}//end for loop
		
		alias_html = alias_html + '<button type="button" id="btn_correct_name_and_author">This Person and This Name<\/button>&nbsp;<button id="btn_correct_author_wrong_name" type="button">This Person, Under a Different Name<\/button>&nbsp;<button  id="btn_not_correct_author" type="button">Not this person<\/button>';
		document.getElementById(layer_name).innerHTML = lsid_html + alias_html + "<\/form>";
		//style the buttons
		$( "button" ).button();
		var checked_id = 0;
		var checked_name = "";
		var checked_validagentid = 0;
		//clear the author search form
		document.getElementById("author_search_string").value='';
		
		//build tool tips for the buttons and apply them to the events for that Button				
		set_tip("btn_correct_name_and_author","Correct Name and Author","Click here if this is the right person, and the<br \/	>selected name above matches what appears in the Published Work.");
		
		set_tip("btn_correct_author_wrong_name","Correct Author, Wrong Name","Click here if this is the right person, but the name as<br \/	>it appears in the Published Work is not listed above.");
		
		set_tip("btn_not_correct_author","Not the Correct Author","Click here if this is the not the right person.");
		
		//add the appropriate onclick events to each Button
		$("#btn_correct_name_and_author").click(function () { 
			id_name_array = $("input[name='group1']:checked").val().split("~");
			checked_id = id_name_array[0];
			checked_name = id_name_array[1];
			checked_validagentid = id_name_array[2];
			checked_lsid = id_name_array[5];
			add_author_to_list(checked_id,checked_name,checked_lsid);
			$("#select_author").dialog("close");
			clear_author_form();
			//document.getElementById("author_search_string").focus();
		});
		
		$("#btn_correct_author_wrong_name").click(function () { 
			create_alias_form(checked_id);
			//set the alias form PKID to the valid agent id
			id_name_array = $("input[name='group1']:checked").val().split("~");
			document.getElementById("pkid").value=id_name_array[2];
			document.getElementById("GivenName").value=id_name_array[3];
			document.getElementById("FamilyName").value=id_name_array[4];
			//clear the add_author_result layer
			document.getElementById("add_author_result").innerHTML = '';
		});
		$("#btn_not_correct_author").click(function () { 
     	clear_author_form();
		$("#select_author").dialog("close");
		//document.getElementById("btn_author_form_label").innerHTML = "Create New Author";
		
		$( '#new_author' ).dialog( 'open' );
		document.getElementById('btn_author_form').disabled=false;
		});
		
		
		}//end else
		}
	}
).responseText;			

}//end function get_aliases

//function to invoke Tip and UnTip mouseover events on any element - usses Walter Zorn's tool tip library
function set_tip(element_id,tip_title,tip_text){
	$("#"+element_id).mouseover(function () { 
		if(tip_title=="") Tip(""+tip_text+"",BGCOLOR,"#9CD9F7",BALLOON,true,ABOVE,true,LEFT,true,BALLOONSTEMOFFSET,-48,OFFSETX,-40);
		else Tip(""+tip_text+"",BGCOLOR,"#E6E6E6",TITLE,""+tip_title+"",BGCOLOR,'#9CD9F7',TITLEBGCOLOR,'#063455');
	});
	$("#"+element_id).mouseout(function () { 
		UnTip();
	});

}

var closedialog;

function overlayclickclose(dialog_name) {
	//alert(closedialog);
	if (closedialog) {
		$('#'+dialog_name).dialog('close');
	}
	//set to one because click on dialog box sets to zero
	closedialog = 1;
}

function find_author(term,familyName,givenName){//check if the author is already in ZooBank DB
	var check_author = $.ajax({
			url: "/services.cfc?method=find_author",
			asynch: false,
			data: ({
			term:term,
			FamilyName:familyName,
			GivenName:givenName
			}),
			type: "get",
			success: function(msg){
				//var results = JSON.parse(msg);
				//find_author_response_action(results,term,familyName,givenName);
				}//end success
			}//end ajax section arguments
			).responseText;	
		
}//end function find_author

function find_reference(authorIdList,publicationYear,journalId,referenceTitle){
	
	var search_refrences = $.ajax({
		url: "/services.cfc?method=filtered_refererence_search",
		data: ({
		author_id_list:authorIdList,
		publication_year:publicationYear,
		journal_id:journalId,
		reference_title:referenceTitle
		}),
		type: "get",
		success: function(msg){
			var results = JSON.parse(msg);
			find_reference_response_action(results,authorIdList,publicationYear,journalId,referenceTitle);
			}//end success
		}//end ajax section arguments
		).responseText;	

}





function get_pub_acts(ReferenceID,include_radio_btns,layer_name,RankGroup){//get the current nomenclatural acts for a given pub
	var taxon_rank_group
	if(RankGroup==""||RankGroup=="undefined") taxon_rank_group = "";
	else taxon_rank_group = RankGroup;
	if(ReferenceID>0){
		var get_acts = $.ajax({
			url: "/services.cfc?method=get_nomenclatural_acts",
			//url: "http://www.zoobank.org/References/"+ReferenceID+"/taxonacts.json",
			data: ({ReferenceID:ReferenceID,
			RankGroup:taxon_rank_group
			//,apikey:'2345j2h3g5k2j3g523kj4gh3458768723465'
			}),
			type: "get",
			success: function(msg){
				var results = JSON.parse(msg);
				get_pub_acts_response_action(results,include_radio_btns,layer_name,RankGroup);
				}//end success
			}//end ajax section arguments
			).responseText;	
		}
	else alert("Reference Not Selected");
}//end function get_pub_acts

function submit_publication(ParentReferenceID,ReferenceTypeID,LanguageID,Year,Title,ShortTitle,Series,Volume,Number,Pages,Figures,DatePublished,Authors,LogUserName){
	var continue_submit = 1;
	if (selected_authors_array.toString()=="") {
		alert("Please complete the authorship section first");
		continue_submit=0;
		}//end if
	if((document.getElementById("pub_type").value==1||document.getElementById("pub_type").value==3)&&document.getElementsByName("ParentReferenceID").value==0){
		alert("Please indicate the parent reference for this publication.");
		continue_submit=0;
		}//end if
	if (continue_submit==1){
		var insert_ref = $.ajax({
		url: "/services.cfc?method=insert_reference",
		data: ({
			ParentReferenceID:ParentReferenceID,
			LanguageID:LanguageID,
			Year:Year,
			Title:Title,
			ShortTitle:ShortTitle,
			Edition:Series,
			Volume:Volume,
			Number:Number,
			Pages:Pages,
			Figures:Figures,
			DatePublished:DatePublished,
			Authors:Authors,
			ReferenceTypeID:ReferenceTypeID,
			LogUserName:LogUserName
			}),
		type: "get",
		success: function(msg){
			var results = JSON.parse(msg);//some browsers cannot natively parse the JSON result
			submit_publication_response_action(results,ParentReferenceID,ReferenceTypeID,LanguageID,Year,Title,ShortTitle,Series,Volume,Number,Pages,Figures,DatePublished,Authors,LogUserName);
			}//end success
		}//end ajax section arguments
		).responseText;		
		}//end if	
	
}//end function submit_publication

//function to create a select list based upon a previous AJAX service call 
function build_select_list(target_field_name,results,layer_name){
	var display_html = '<select name="'+target_field_name+'" id="'+target_field_name+'">';
	for(i=0;i<results.length;i++){
		display_html =  display_html + '<option value="'+results[i].id+'">' + results[i].label + '<\/option>';
	}//end for
	document.getElementById(layer_name).innerHTML = display_html + '<\/select>';
}

function build_taxon_select_list(target_field_name,current_rank_group){
	//clear the current options from the select list
	$('#'+target_field_name)[0].options.length = 0;
	//get the values for the select list
	var get_family_level_taxon = $.ajax({
		url: "/services.cfc?method=find_taxon_level",
		data: ({
		rank_group:current_rank_group}),
		type: "get",
		success: function(msg){
			var results = JSON.parse(msg);
			//build the select list for family values
			for(i=0;i<results.length;i++){
				//display_html =  display_html + '<option value="'+results[i].id+'">' + results[i].label + '<\/option>';
				 $('#'+target_field_name).
				append($("<option></option>").
				attr("value",results[i].id).
				text(results[i].label)); 	
			}//end for
			}//end success
		}//end ajax section arguments
		).responseText;			
	
}//end function build_taxon_select_list

function get_author_by_pub (pubid) {
	var get_authors = $.ajax({
		url: "/services.cfc?method=get_pub_authors",
		data: ({ReferenceID:pubid}),
		type: "get",
		success: function(msg){
			var results = JSON.parse(msg);//some browsers cannot natively parse the JSON result
			get_author_by_pub_response_action(pubid,results);				
			}//end success
		}//end ajax section arguments
		).responseText;		
}

//function to submit a new name
function submit_new_name(pub_ReferenceID,new_rank_id,new_name_spelling,new_name_pages,new_name_type_genus,new_name_authors,is_fossil,LogUserName,establish_protonym,assign_zb_lsid,ProtonymID,new_name_figures,ParentUsageID){
	var continue_submit = 1;
	if (selected_authors_array.toString()=="") {
		alert("Please complete the authorship section first");
		continue_submit=0;
		}//end if
	if(pub_ReferenceID==0){
		alert("Please select the publication or enter a new publication first.");
		continue_submit=0;
	}
	if(continue_submit==1){
		var insert_acts = $.ajax({
		url: "/services.cfc?method=insert_taxon_name",
		data: ({
		"Pages": new_name_pages,
		"ReferenceID":pub_ReferenceID,
		"TaxonRankID": new_rank_id,
		"NameString": new_name_spelling,
		Authors: new_name_authors,
		Types: new_name_type_genus,
		IsFossil: is_fossil,
		LogUserName:LogUserName,
		establish_protonym:establish_protonym,
		assign_zb_lsid:assign_zb_lsid,
		ProtonymID:ProtonymID,
		Illustration:new_name_figures,
		ParentUsageID:ParentUsageID
		}),
		type: "get",
		success: function(msg){
			submit_new_name_response_action(msg,new_name_spelling,establish_protonym,assign_zb_lsid);			
			}//end success
		}//end ajax section arguments
		).responseText;		
	}
}

//function to push text into a layer
function show_text (layer_name,text_to_display,append,prepend){
	if(append==1) document.getElementById(layer_name).innerHTML = document.getElementById(layer_name).innerHTML + text_to_display;
	else if (prepend==1) document.getElementById(layer_name).innerHTML = text_to_display + document.getElementById(layer_name).innerHTML;
	else document.getElementById(layer_name).innerHTML = text_to_display;
	
	$("#"+layer_name).show();
}

function clear_layer (layer_name) {
	document.getElementById(layer_name).innerHTML = '';
}

function setSectionClass(class_name,section_name,unique_class){
	if(unique_class==1) {//remove the class from all other elements
		 $("."+class_name).removeClass(class_name);
		}
	$("#"+section_name).addClass(class_name);
		
}

function get_pub_details(pubid){

		var get_authors = $.ajax({
		url: "/services.cfc?method=find_pub",
		data: ({ReferenceID:pubid}),
		type: "get",
		success: function(msg){
			var results = JSON.parse(msg);//some browsers cannot natively parse the JSON result
			get_pub_details_response_action(pubid,results);				
			}//end success
		}//end ajax section arguments
		).responseText;	

}

function get_bhl_data(method,title,volume,year,lname){//method, title, volume, year of publication
	var api_key = "f0116e4a-33d5-46f4-acea-1e9238a6563b";
	if(method="book_search"){
		var get_title_data = $.ajax({
		url: "http://www.biodiversitylibrary.org/api2/httpquery.ashx?op=BookSearch&apikey="+api_key+"",
		crossDomain: true,
        contentType: "application/json; charset=utf-8",
		dataType: "jsonp",
		data: ({
		title:title,
		volume:volume,
		lname:lname,
		year:year,
		format:"json"
		}),
		type: "GET",
		success: function(msg){
			//var results = JSON.parse(msg);//some browsers cannot natively parse the JSON result
			get_bhl_data_response_action(msg,method,title,volume,year);				
			}//end success
		}//end ajax section arguments
		).responseText;	
	
	}

}

function get_gni_data(searchterm,options){
	
	//options:
	//add_register_link - instructs the function to tell the response function whether to display register links or not
	var register_link = 0;
	if(options.add_register_link==1) register_link = 1;
	
	//options.add_register_link = options.add_register_link || "some default";
	
	
	var get_gni = $.ajax({
		url: "http://gni.globalnames.org/name_strings.json",
		crossDomain: true,
        contentType: "application/json; charset=utf-8",
		dataType: "jsonp",
		data: ({search_term:searchterm,
		
		}),
		type: "get",
		success: function(msg){
			get_gni_data_response_action(msg,searchterm,register_link);				
			}//end success
		}//end ajax section arguments
		).responseText;	


}

function get_exp_log_data(term){
	//alert("calling EL");
	var get_el = $.ajax({
		//url: "http://explorers-log.com/App/taxon_lookup.cfc?method=taxon_search_json&__BDRETURNFORMAT=jsonp&callback=?",
		url: "http://explorers-log.com/names.json?",
		crossDomain: true,
        contentType: "application/json; charset=utf-8",
		dataType: "jsonp",
		data: ({search_term:term,
		valid_only:0
		,__BDRETURNFORMAT:"jsonp"
		}),
		type: "get",
		success: function(results){
			//alert("success");
			//get_exp_log_data_response_action(results,term);				
			get_el_evidence_data_response_action(results,term);
			}//end success
		}//end ajax section arguments
		).responseText;	
	//alert("ajax success skipped");

}

function get_el_evidence_data(cas_spc){
	//alert("calling EL");
	var get_el_evidence = $.ajax({
		url: "http://explorers-log.com/App/darwin_core_functions.cfc?method=get_evidence_data&__BDRETURNFORMAT=jsonp&callback=?",
		crossDomain: true,
        contentType: "application/json; charset=utf-8",
		dataType: "jsonp",
		data: ({
		return_type:"jsonp",
		TaxonID:cas_spc,
		TaxonRankID:70
		}),
		type: "get",
		success: function(results){
			get_el_evidence_data_response_action(results,cas_spc);				
			}//end success
		}//end ajax section arguments
		).responseText;	
	//alert("ajax call done");

}





