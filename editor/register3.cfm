<cfinclude template="/header.cfm">

<cfparam name="LogUserName" default = "#session.username#">
<cfjavascript src="/admin/js/register_new.js">
<cfjavascript src="/admin/js/register3.js">
<script language="JavaScript" type="text/javascript">		
	<cfset input_layer_names = "pub_year_layer,pub_type_question_layer,pub_already_published_question,pub_parent_id_layer,authors_display_layer,title_display_layer,pub_form_series,pub_form_issn,pub_form_archive_question_layer,pub_form_language,pub_form_pages,pub_form_volume,pub_form_number,pub_form_figures,pub_form_date,pub_book_series_layer">
	<cfoutput>
	$().ready(function() {
	<cfloop list="#input_layer_names#" index="layer_name">
		$("###layer_name#").click(function () { 
		setSectionClass('active_section','#layer_name#',1);
		});
	</cfloop>	
	});//end ready function
	var LogUserName = '#LogUserName#';</cfoutput>
</script>


<section id="registrationForm">
	<div class="container">
		<h3 class="cta">Register a new name</h3>
	</div>
	<div class="container">
		<div class="infoMsg">
			<p id="selected_article">All names exist within the context of a publication. To register a name, we therefore need to know where it was (or will be) published.</p>
		
		</div>	
	</div>
</section>
	<div id="new_pub" class="container" class="inlineLabels">
		<!---<div id="pub_search_form_layer" class="active_section"><span class="entry_label">Publication Title</span> 
			<input type="text" size="45" name="article_search_string" id="article_search_string" /><img id="image_help_article_search" src="/images/help.gif" /><br />
			<!---<br />
				<button id="btn_show_new_pub_form" type="button"><span class="ui-button-text">New Publication</span></button>--->
			
			<input type="hidden" name="article_id" id="article_id" />
		</div>		--->
		<br /><br />
		<form id="registration" name="registration" class="uniForm" method="get" action="">
			<!---<fieldset class="optionalInformation">
			<div id="pub_form_issn" class="ctrlHolder">
				<label for="pub_issn">ISSN</label>
				<input id="pub_issn" class="textInput" type="text" maxlength="50" name="pub_issn" style="color: rgb(85, 85, 85);">
				<img id="image_help_pub_abbr_title" src="/images/help.gif" />			
			</div>
			</fieldset>--->
		
		
			<input type="hidden" name="pub_id" id="pub_id" />
			<table border="0" id="tbl_pub_form" width="100%">
				<tbody id="pub_type_question_layer"><!---style="display:none;"--->
				<tr>
					<td class="entry_label" style="height:50px;">Publication Type</td>
					<cfset display_types = "1,2,5">
					<cfinvoke component="services" method="get_pub_types" returnvariable="get_types">					
					<cfset pub_types = DeSerializeJSON(get_types)>
					<td class="blockLabels">
					<cfoutput query="pub_types">
						<cfif ListFind(display_types,id,",")>
							<label for="pub_type_#id#">
							<input type="radio" value="#id#" id="pub_type_#id#" name="pub_type1" />#value#
							<cfif id is not ListLast(display_types,",")></label></cfif>
						</cfif>
					</cfoutput>
					<input type="hidden" name="pub_type" id="pub_type" />
					<br />&nbsp;
					</td>
				</tr><!---pub type question layer--->
				</tbody>
				
				<tbody id="pub_book_series_layer" style="display:none;">				
				<tr>
					<td class="entry_label">Is this part of a book series?</td>
					<td class="blockLabels">
						<label for="pub_part_book_series_1"><input type="radio" name="pub_part_book_series" id="pub_part_book_series_1" value="1" /> Yes </label>
						<label for="pub_part_book_series_0"><input type="radio" name="pub_part_book_series" id="pub_part_book_series_0" value="0" />No </label>				
					</td>
				</tr>
				</tbody>
							
				<tr id="pub_already_published_question"> <!--- style="display:none;"--->
					<td class="entry_label">Publication Status</td>
					<td id="pub_already_published_choices" class="blockLabels">
						<label for="pub_form_already_published_0"><input type="radio" id="pub_form_already_published_0" name="pub_form_already_published" value="" />This work has not yet been published</label>
						<label for="pub_form_already_published_1"><input type="radio" id="pub_form_already_published_1" name="pub_form_already_published" value="" />This work was published on:</label>
						 <br />
					</td>
				</tr>
				<tr><td colspan=2 ><span id="pub_form_instructions_layer" style="display:none;"></span></td></tr><!--- class="form_instructions_text" --->
				<tbody id="create_pub_layer" ><!--- style="display:none;" --->
				<tr id="pub_year_layer">
					<td class="entry_label">Date of Publication</td>
						<td><span id="pub_year_input_layer">
							<!---<input type="text" name="pub_year" id="pub_year" />--->							
							</span><!---<img id="image_help_pub_year" src="/images/help.gif" />--->
							<table class="alternate dateSelect">
								<tr>
									<td ><label for="pub_year" style="vertical-align:top;">Year</label></td>
									<td> <label for="month">Month</label> </td>
									<td> <label for="day">Day</label> </td>
								</tr> 
								<tr>
									<td><input type="text" class="textInput required auto" maxlength="4" size="8" placeholder="e.g. 1957" id="pub_year" name="pub_year" onchange="launch_find_reference();" /></td>
									<td> <select class="selectInput auto" id="month" name="month">
									<option value=""> </option>
									<option value="1">January</option>
									<option value="2">February</option>
									<option value="3">March</option>
									<option value="4">April</option>
									<option value="5">May</option>
									<option value="6">June</option>
									<option value="7">July</option>
									<option value="8">August</option>
									<option value="9">September</option>
									<option value="10">October</option>
									<option value="11">November</option>
									<option value="12">December</option>
								  </select><br /><p class="formHint">Optional</p></td>
									<td> <input type="text" class="textInput auto" maxlength="2" size="2" id="day" name="day"><br /><p class="formHint">Optional</p></td>
								</tr>
							</table>
							
							
							<span id="pub_year_explanation_text"></span>
							
						</td>
						
					</tr>
					
					<tr id="authors_display_layer">
						<td class="entry_label">Authors</td>
						<td><span id="author_citation_preview"></span><span id="author_search_span"></span>
							<div id="authors_layer">
								<span id="selected_author_instruction_layer"></span>
								<ul id="selected_author_list"></ul>
								<div id="author_entry_layer"><!---  class="active_section" --->
									<input type=hidden id="include_org" value="1" />
									<input type="text" size="47" name="author_search_string" id="author_search_string" placeholder="e.g Wilson, Edward O" /><img id="image_help_author_search" src="/images/help.gif" />&nbsp;
									<button id="btn_new_author" type="button" class="secondaryAction">New Author</button><input type="hidden" name="author_id" id="author_id" /><br />
									
									<span id="action_button_layer"></span>
								</div>
								<!---<span id="joint_pubs"></span>--->
							</div><!--- authors layer --->
							</form>
							<div id="new_author" title="Author" class="new_form" style="display:none;">
								<form id="author_form" name="author_form" method="get" action="">
								<div class="infoMsg" style="background-color:#EBEBFF" id="new_author_instructions_layer">
									<p>Enter the Family name, Given name(s) and (if applicable) suffix of <br />the Author's name exactly as they appear in the published work.</p>
								</div><br />
								<table>
									<tr>
										<td class="entry_label"><label for="GivenName">Given Name</label></td>
										<td><input type="text" name="GivenName" id="GivenName" size="25" />
										<img src="/images/help.gif" id="image_help_new_author_familyname" /><br /><br /></td>
									</tr>
									<tr>
										<td class="entry_label"><label for="FamilyName">Family Name</label></td>
										<td><input type="text" name="FamilyName" id="FamilyName" size="25" />
										<img src="/images/help.gif" id="image_help_new_author_givenname" /><br /><br /></td>
									</tr>
									<tr>
										<td class="entry_label"><label for="author_suffix">Suffix</label></td>
										<td><select name="author_suffix" id="author_suffix" >
										<option value="">&nbsp;</option>
										<option value="Jr.">Jr.</option>
										<option value="II">II</option>
										<option value="III">III</option>
										<option value="IV">IV</option>
										<option value="V">V</option>
										<option value="VI">VI</option>
										</select>
										<img src="/images/help.gif" id="image_help_new_author_suffix" /><br />
										<input type="hidden" name="pkid" id="pkid" />
										<input type="hidden" name="display_name" id="display_name" /></td>
									</tr>
									<tr>
										<td colspan=2><div class="form_button_layer">
											<button id="btn_author_form">
											<span id="secondaryAction">Create New Author</span></button>
										</div></td>
									</tr>
								</table>		
								</form>
								<div id="add_author_result"></div>
								
							</div><!---new_author--->
						</td>
					</tr>
					
					<tr id="title_display_layer">
						<td class="entry_label" style="height:5em;">Article Title</td>
						<td><textarea cols="36" rows="2" name="pub_title" id="pub_title" onchange="launch_find_reference();"></textarea>
							<img id="image_help_pub_title" src="/images/help.gif" /></td>
					</tr>
					<tbody id="pub_parent_id_layer" ><!---style="display:none;"--->
					<!---<input type="hidden" name="pub_type_id" id="pub_type_id" value="" />--->
					<tr id="parent_pub_question_section">
						<td class="entry_label">Journal name</td>
						<td><input id="pub_search_string" size="57" type="text" placeholder="e.g. Bulletin of the Museum of Comparative Zoology" />
							<input type="hidden" id="ParentReferenceID" name="ParentReferenceID" />
							<img id="image_help_pub_search" src="/images/help.gif" />
							<button id="btn_show_new_periodical_form" type="button" class="secondaryAction"><span id="btn_show_new_periodical_form_text">Create New Periodical</span></button>
						</td>
					</tr>
					<tr>
						<td colspan="2">
						<div id="reference_search_results_layer"></div>
						</td>
					</tr>
					</tbody>
					<tbody id="optional_ref_fields_layer" style="display:none;">
					<tr>
						<td colspan=2>
					<div class="infoMsg">
						<p>The following fields are optional, but are appreciated.</p>
					</div>
						</td>
					</tr>
				
					<tr id="pub_form_abbr_title" style="display:none;">	
						<td class="entry_label">Short Title</td>
						<td><input type="text" name="pub_abbr_title" id="pub_abbr_title" value="" />
							<img id="image_help_pub_abbr_title" src="/images/help.gif" /></td>
					</tr>
					<tr id="pub_form_issn">	
						<td class="entry_label">ISSN</td>
						<td><input type="text" name="pub_issn" id="pub_issn" value="" size="57" />
							</td>
					</tr>
					<tr id="pub_form_series" style="display:none;">	
						<td class="entry_label">Series</td>
						<td><input type="text" name="pub_series" id="pub_series" value="" size="57" />
							<img id="image_help_pub_series" src="/images/help.gif" /></td>
					</tr>
					<tr id="pub_form_volume">	
						<td class="entry_label">Volume</td>
						<td><input type="text" name="pub_volume" id="pub_volume" size="57" />
							<img id="image_help_pub_volume" src="/images/help.gif" /></td>
					</tr>
					<tr id="pub_form_number">		
						<td class="entry_label">Number</td>
						<td><input type="text" name="pub_number" id="pub_number" size="57" />
							<img id="image_help_pub_number" src="/images/help.gif" /></td>
					</tr>
					<tr id="pub_form_pages">	
						<td class="entry_label">Pages</td>
						<td><input type="text" name="pub_pages" id="pub_pages" size="57" />
							<img id="image_help_pub_pages" src="/images/help.gif" /></td>
					</tr>
					<tr id="pub_form_figures">		
						<td  class="entry_label">Figures</td>
						<td><input type="text" name="pub_figures" id="pub_figures" size="57" /></td>
					</tr>
					<!---<tr id="pub_form_date">		
						<td class="label">Date</td>
						<td><input type="text" name="pub_date" id="pub_date" size="57" />
							<img id="image_help_pub_date" src="/images/help.gif" /></td>
					</tr>--->
					<tr id="pub_form_language">		
						<td class="entry_label">Language</td>
						<td><span id="pub_language_input_field">
								<input id="language_search_string" type="text" size="57" />
							</span>
						<span id="selected_language" class="completed_question_result_text"></span>
						<input type="hidden" id="LanguageID" />	</td>
					</tr>
					<tr id="pub_form_archive_question_layer" style="display:none;">
						<td class="entry_label">Archive</td> 
						<td><input type="text" id="pub_archive" name="pub_archive" />
							<img src="/images/help.gif" id="image_help_pub_archive" /></td>
					</tr>
					</tbody>
					<!---<tr>
						<td colspan=2 align="center"><button id="btn_new_pub_form" name="btn_new_pub_form">Enter New Publication</button></td>
					</tr>--->
				</tbody><!---create_pub_layer--->
			</table>
		</form><!---pub_form--->
	</div><!--- new_pub --->
	
	
	<div id="taxonName" style="background-color:#EBEBFF;display:none;">
	<fieldset class="inlineLabels" id="nomenclaturalActs">
	<legend>Nomenclatural Acts</legend>
	<div class="container">
	    <div class="infoMsg">
		  <p>If you are registering multiple taxa in this publication, your life might be easier if you start with higher-order taxa first.</p>
	    </div>
		<!---
		<div class="ctrlHolder">
			<label for="rank_id">Taxonomic rank</label>
			<select name="rank_id" id="rank_id">
				
				<option value="50">Family</option>
			
				<option value="53">&nbsp;&nbsp;Subfamily</option>
			
				<option value="55">&nbsp;&nbsp;Tribe</option>
			
				<option value="60">Genus</option>
			
				<option value="63">&nbsp;&nbsp;Subgenus</option>
			
				<option selected="selected" value="70">Species</option>
			
				<option value="73">&nbsp;&nbsp;Subspecies</option>
			
			</select>
		</div>
		
		<div class="ctrlHolder">
			<label for="name">Species epithet</label>
			<input type="text" class="textInput required" maxlength="50" size="35" placeholder="" id="name" name="name">
		</div>
		
		
			
				<div class="ctrlHolder">
					<p class="label">Parent rank</p>
					<ul>
					
						<li><label for="parent_60"><input type="radio" checked="checked" name="parent_rank_id" id="parent_60" value="60"> Genus</label></li>	
					
						<li><label for="parent_63"><input type="radio" name="parent_rank_id" id="parent_63" value="63"> Subgenus</label></li>	
					
					</ul>
				</div>
			
		
		<div class="ctrlHolder">
			<label for="parent_name">Parent genus</label>
			<input type="text" class="textInput required ui-autocomplete-input" maxlength="50" size="35" placeholder="" id="parent_name" name="parent_name" autocomplete="off" role="textbox" aria-autocomplete="list" aria-haspopup="true">
		</div>
		
		--->
	</div>
</fieldset>
</div>
	
	
	
	
	
	
	
		
	
	
	
	
	
	<center>
	<div id="nomenclatural_acts_layer" style="background-color:#EBEBFF;display:none;">
		<span id="name_act_search_layer" style="display:none;">Nomenclatural Acts
			<span class="celllg">Search</span>
			<input type="text" size="30" name="taxon_act_search_string" id="taxon_act_search_string" /><br />
			<span id="selected_taxon_act" class="cellmed1"></span>
			<input type="hidden" name="taxon_act_id" id="taxon_act_id" />		
		</span>
		
		
		<div id="new_name" title="New Nomenclatural Act">
			<form name="form_new_name" id="form_new_name" method="get" action="">
			<table>
				<tr>
					<td class="entry_label">Rank Group</td>
					<td>
					<div id="name_acts_button_layer" class="nomenclatural_acts_layer_style" style="text-align:left;">	
						<input type="radio" name="rank_group_selection" id="btn_show_new_name_form_family" />Family
						<input type="radio" name="rank_group_selection" id="btn_show_new_name_form_genus" />Genus
						<input type="radio" name="rank_group_selection" id="btn_show_new_name_form_species" />Species
					<!---
						<button id="btn_show_new_name_form_family" type="button">New Family-Group Name</button>
						<button id="btn_show_new_name_form_genus" type="button">New Genus-Group Name</button>
						<button id="btn_show_new_name_form_species" type="button">New Species-Group Name</button>--->
					</div>				
					<div id="new_name_instruction_layer" class="form_instructions_text" style="display:none;"></div>
					<div id="new_act_current_names_in_pub"></div>
					</td>
				</tr>
				<tr id="new_name_parent_layer">
					<td class="entry_label" id="new_name_parent_label">Parent</td>
					<td><span id="new_name_parent_search_layer"><input id="parent_search_string" size="57" type="text" />[Required for Species or Subspecies]</span>
					<span id="selected_parent" class="completed_question_result_text completed_section"></span><br />
					<input type="hidden" name="parent_id" id="parent_id" />
					<input type="hidden" name="parent_name" id="parent_name" />
					<div id="new_name_parent_confirmation_layer"></div>
					</td>
				</tr>
				<tr id="new_nomenclatural_act_main_form_layer" ><!---style="display:none;"--->
					<td class="entry_label">Rank *</td>
					<td><select id="rank_id" name="rank_id"></select>
						<!---<input id="rank_search_string" type="text" />--->
						<img src="/images/help.gif" id="image_help_taxon_rank" />
						
					<!---<span id="selected_rank"></span><input type="hidden" id="rank_id" name="rank_id" />---></td>
					<td rowspan="9"><div class="current_acts_layer">
						<span id="current_acts_layer"></span>
					</div></td>
				</tr>
				<tr>
					<td class="entry_label">Spelling *</td>
					<td><input type="text" size="57" id="new_name_spelling" name="new_name_spelling" />
						<img src="/images/help.gif" id="image_help_taxon_spelling" /><br /><br /></td>
				</tr>
				<tr>
					<td class="entry_label">Page(s)</td>
					<td><input type="text" size="57" name="new_name_pages" id="new_name_pages" />
						<img src="/images/help.gif" id="image_help_taxon_pages" /><br /><br /></td>
				</tr>
				<tr id="new_name_figures_layer">
					<td class="entry_label">Fig(s)</td>
					<td><input type="text" size="57" name="new_name_figures" id="new_name_figures" />
						<img src="/images/help.gif" id="image_help_taxon_figures" /><br /><br /></td>
				</tr>
				<tr>
					<td class="entry_label" id="new_name_type_label">Type Genus</td>
					<td><input type="text" size="57" name="new_name_type_genus" id="new_name_type_genus" />
						<img src="/images/help.gif" id="image_help_taxon_type" /><br /><br /></td>
				</tr>
				<tr>
					<td colspan=2 style="font-weight:bolder;">Is the authorship of the name identical to the authorship of the Published Work?</td> 
				</tr>
				<tr>
					<td class="entry_label">&nbsp;</td>
					<td>Yes <input type="radio" value="1" name="is_authorship_identical" id="new_name_is_authorship_identical_1" checked />
						| No <input type="radio" value="0" name="is_authorship_identical" id="new_name_is_authorship_identical_0" />
						<img src="/images/help.gif" id="image_help_taxon_authorship" /><br /><br /></td>
				</tr>
				<!---<label class="entry_label">Type Locality</label> <input type="text" /><br /><br />--->
				<tr id="new_name_authorship_input_layer" class="disabled">
					<td class="entry_label">Author(s)</td>
					<td><input type="text" name="new_name_authors" id="new_name_authors" size="57" disabled class="disabled" />
						<img src="/images/help.gif" id="image_help_taxon_authors" /><br /><br /></td>
				</tr>
				<tr>
					<td class="entry_label">Is this new taxon name based on fossil material?</td>
					<td><input type="checkbox" name="is_fossil" id="is_fossil" value="1" /><br /><br /></td>
				</tr>
					<!---
					<div class="form_button_layer">
						<button id="btn_new_name_form" type="button">Save Record</button>
					</div>--->
				<tr>
					<td colspan="2"><div id="new_name_confirm_layer"></div></td>
				</tr>
				<tr>
					<td colspan="2">
					<fieldset class="buttons">
						<div class="container">
							<div class="buttonHolder">
								<button class="primaryAction" type="submit">Register Name</button>
							</div>
							<!---<p><a href="step_2.html">[author disambiguation]</a> <a id="enableParentDisambiguation" href="#">[parent disambiguation]</a></p>--->
						</div>
					</fieldset>
				
				
					</td>
				</tr>
			</table>
				</div><!--- new_nomenclatural_act_main_form_layer --->
			</form>
		</div><!---new_name--->
	</div><!---nomenclatural_acts_layer--->
</center>
	<div id="review_container" class="review_container" style="display:none;">
		Summary:<br /><div id="review_layer" style="text-align:left;">
		
		<span id="selected_pub" class="completed_section"></span>
		<span id="pub_type_display_layer" class="completed_question_result_text"></span>
		<span id="edited_volume_instructions_layer" style="display:none;"></span>
		<span id="reference_citation_preview"></span>
		<span id="pub_already_published_completed_value" class="completed_section"></span>
		
		</div>
	</div>

<div class="form_instructions_text" id="registration_instruction_layer" style="display:none;">
	<br />To start the registration process, begin by entering the authors of the published work in which the nomenclatural acts appear (you will be prompted later for the authors of new taxon names, if different from the authors of the published work). If the acts appear in a chapter or section of an edited volume, begin by entering the editors of the edited volume (you will be prompted later for the authors of the chapter or section). <br /><br />
</div>

<div id="create_periodical_layer" style="display:none;" title="Create Periodical">
	<form id="form_create_periodical" name="form_create_periodical" method="get" action="">
	<table>
		<tr>
			<td class="entry_label"><span id="new_periodical_full_title_label" style="height:5em;">Full Title of Periodical*</span></td>
			<td><textarea cols="50" rows="3" name="new_periodical_full_title" id="new_periodical_full_title"></textarea>
			<img src="/images/help.gif" id="image_help_periodical_full_title" /></td>
		</tr>
		<tr>
			<td class="entry_label"><span id="new_periodical_abbr_title_label">Abbreviated title of periodical</label></td>
			<td><input type="text" name="new_periodical_abbr_title" id="new_periodical_abbr_title" />
			<img src="/images/help.gif" id="image_help_periodical_abbr_title" /></td>
		</tr>
		<tr id="new_periodical_form_fields">
			<td><label class="label">Series</label></td>
			<td><input type="text" name="new_periodical_series" id="new_periodical_series" />
			<img src="/images/help.gif" id="image_help_periodical_series" /></td>
		</tr>
		<tr id="new_book_series_questions_layer" style="display:none;">
			<td class="label">Year</td>
			<td><input type="text" name="new_periodical_bookseries_year" id="new_periodical_bookseries_year" />
			<img src="/images/help.gif" id="image_help_periodical_bookseries_year" /></td>
		</tr>
		<tr>
			<td class="label">Publisher</td>
			<td><input type="text" name="new_bookseries_publisher" id="new_bookseries_publisher" />
			<img src="/images/help.gif" id="image_help_bookseries_publisher" /></td>
		</tr>
		<tr>
			<td class="label">Place Published</td>
			<td><input type="text" name="new_bookseries_place_published" id="new_bookseries_place_published" />
			<img src="/images/help.gif" id="image_help_bookseries_place_published" /></td>
		</tr>
		<tr>
			<td class="label">Edition</td>
			<td><input type="text" name="new_bookseries_edition" id="new_bookseries_edition" />
			<img src="/images/help.gif" id="image_help_bookseries_edition" /></td>
		</tr>
		<tr>
			<td class="label">Volumes</td>
			<td><input type="text" name="new_bookseries_volumes" id="new_bookseries_volumes" />
			<img src="/images/help.gif" id="image_help_bookseries_volumes" /></td>
		</tr>
		<tr>
			<td colspan="2"><input type="hidden" name="new_periodical_ReferenceTypeID" id="new_periodical_ReferenceTypeID" value="39" />
			<div class="form_button_layer">
				<button id="btn_create_new_periodical" name="btn_create_new_periodical"><span id="btn_create_new_periodical_text">Create Periodical</span></button>
			</div></td>
		</tr>
	</table>
	</form>
</div><!---create_periodical_layer--->

<div id="pub_layer" class="cellsm" style="text-align:left" title="Author Publications">
</div>

<div id="select_author" title="Select Author" style="display:none;">
	<span class=celllg>Confirm Author's Name:</span> <img src="/images/help.gif" id="image_help_select_author_name" />
	<div id="alias_layer"></div>
	<div id="author_pub_layer" style="text-align:left"></div>
</div><!---select_author--->




<!---</fieldset>--->

<!---<p class="cellxsm">
Example Article <br />
Zootaxa 2913: 1–15 (10 Jun. 2011) 7 plates; 8 references     <br />                   Accepted: 11 May 2011<br />
A new genus Microphylacinus and revision of the closely related Phylacinus Fairmaire, 1896 (Coleoptera: Tenebrionidae: Pedinini) from Madagascar<br />
DARIUSZ IWAN (Poland), MARCIN KAMINSKI (Poland) &amp; ROLF AALBU (USA)<br />
Publication is Zootaxa</p>--->
<cfinclude template="/footer.cfm">

		