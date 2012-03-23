$().ready(function() {
$( "#author_search_string" ).autocomplete({
		search: function(event, ui) {
			$(this).addClass("wait");
			},
        	open: function(event, ui) {
            $(this).removeClass("wait");
        },
		source: "/services.cfc?method=find_author",
		minLength: 2,
		select: function(event, ui) {
			if(test_environment==1){
				if(ui.item.id==0) document.getElementById("author_id").value="no match";
				else document.getElementById("author_id").value=ui.item.id;
			}
			else author_lookup_autocomplete_action(ui);
			//clear the search string
			return false;
			document.getElementById("author_search_string").value='';
		}			
	});//end author autocomplete
	
	$( "#pub_search_string" ).autocomplete({
		search: function(event, ui) {
			$(this).addClass("wait");
			},
        	open: function(event, ui) {
            $(this).removeClass("wait");
        },
		source: "/services.cfc?method=find_journal&journals_only=1",
		minLength: 2,
		select: function(event, ui) {
			if(test_environment==1){
				if(ui.item.id==0) document.getElementById("ParentReferenceID").value="no match";
				else document.getElementById("ParentReferenceID").value=ui.item.id;
				}
			else journal_lookup_autocomplete_action(ui);
		}//end select event	
	});//end journal search autocomplete
	
	
	//$("#author_search_string").focus();
	$( "#article_search_string" ).autocomplete({
		search: function(event, ui) {
			$(this).addClass("wait");
			},
        	open: function(event, ui) {
            $(this).removeClass("wait");
        },
		source: "/services.cfc?method=find_pub&journals_only=0",
		minLength: 2,
		select: function(event, ui) {document.getElementById("article_id").value=ui.item.id;
		var result_content = '<span onclick="show_search_form(&quot;selected_pub&quot;,&quot;pub_search_string&quot;,&quot;pub_id&quot;,&quot;find_journal&quot;,&quot;'+ui.item.value+'&quot;)";>'+ui.item.value+'<\/span>';
		document.getElementById("selected_article").innerHTML = "<span class='completed_question_label'>Published Work: <\/span>" + result_content;
		document.getElementById("article_search_string").value = '';
		select_publication(ui.item.id,ui.item.value,ui.item.cheatauthors);
		document.getElementById("reference_citation_preview").innerHTML = ui.item.value;
		//call the function to get all names in this pub, regardless of rankgroup (ReferenceID,include_radio_btns,layer_name,RankGroup)
		get_pub_acts(ui.item.id,0,'current_acts_layer');
		//display the taxonomic acts section
		$("#nomenclatural_acts_layer").show();
		selected_pub_pkid = ui.item.id;
		}			
	});
	
	
	/*$( "#taxon_act_search_string" ).autocomplete({
		search: function(event, ui) {
			$(this).addClass("wait");
			},
        	open: function(event, ui) {
            $(this).removeClass("wait");
        },
		source: "/services.cfc?method=find_taxon_act",
		minLength: 2,
		select: function(event, ui) {document.getElementById("taxon_act_id").value=ui.item.id;
		var result_content = '<span onclick="show_search_form(&quot;selected_pub&quot;,&quot;pub_search_string&quot;,&quot;pub_id&quot;,&quot;find_journal&quot;,&quot;'+ui.item.value+'&quot;)";>'+ui.item.value+'<\/span>';
		document.getElementById("selected_taxon_act").innerHTML = result_content;
		}			
	})*/
	$( "#language_search_string" ).autocomplete({
		search: function(event, ui) {
			$(this).addClass("wait");
			},
        	open: function(event, ui) {
            $(this).removeClass("wait");
        },
		source: "/services.cfc?method=find_language",
		minLength: 2,
		select: function(event, ui) {
			if(test_environment==1){
				if(ui.item.id==0) document.getElementById("LanguageID").value="no match";
				else document.getElementById("LanguageID").value=ui.item.id;
				}
			else language_lookup_autocomplete_action(ui);
			
		}			
	});//end language autocomplete
	$( "#rank_search_string" ).autocomplete({
		search: function(event, ui) {
			$(this).addClass("wait");
			},
        	open: function(event, ui) {
            $(this).removeClass("wait");
        },
		source: "/services.cfc?method=find_taxon_level",
		minLength: 2,
		select: function(event, ui) {
			if(test_environment==1){
				if(ui.item.id==0) document.getElementById("rank_id").value="no match";
				else document.getElementById("rank_id").value=ui.item.id;
				}
			else rank_lookup_autocomplete_action(ui);
		}			
	});//end rank autocomplete
	
	$( "#parent_search_string" ).autocomplete({		
		search: function(event, ui) {
			$(this).addClass("wait");
			},
        	open: function(event, ui) {
            $(this).removeClass("wait");
        },
		source: "/services.cfc?method=get_protonym&RankGroup=Genus&display_type=autocomplete",
		minLength: 2,
		select: function(event, ui) {
			if(test_environment==1){
				if(ui.item.id==0) document.getElementById("parent_id").value="no match";
				else document.getElementById("parent_id").value=ui.item.id;
				}
			else protonym_lookup_autocomplete_action(ui);
		}			
	});//end parent taxon name autocomplete
});//end ready function