<cfsilent>
<!--- -->
<fusedoc fuse="act_switchblock.cfm">
	<responsibilities>
		I take the CF structures and create a basic FuseBox 3 cfswitch block
	</responsibilities>
	<properties>
		<history author="Hal Helms" email="hal.helms@TeamAllaire.com" role="Designer" type="Create"/>
		<history author="Lee Bjork Borkman" email="bjork@bjork.net" role="Fusecoder" type="Update" date="15 Feb 2001">
			Amended to use structures instead of a database, and to separate "menu" links. 
		</history>
	</properties>
	<io>
		<in>
			<string name="wireframename" scope="attributes"/>
			
			<structure name="#wireframename#" scope="application" comments="A structure with same name as wireframe to hold parsed data">
				<list name="pl" comments="Page list: a list of pagestate names in order as they appear in data"/>
				<string name="df" comments="Data file: the contents of the text data-file (minus changedescription data)"/>
				<structure name="pagestate" comments="One structure for each pagestate">
					<string name="text" comments="The displayed name of the pagestate (can include difficult characters etc)"/>
					<array name="content" comments="One element per description block (usually 1 only)">
						<structure>
						<string name="display" comments="The title of the description block"/>
						<string name="content" comments="The text of the description block"/>
						</structure>
					</array>
			    	<array name="link" comments="One element per exit=destination pair">
				    	<structure>
							<string name="display" comments="The text for an exit"/>
							<string name="rfadisplay" comments="The text for a destination (rfa originally meant returnfuseaction"/>
							<string name="rfa" comments="The name of a destination pagestate"/>
						</structure>
					</array>
				</structure>
			</structure>
		</in>
		<out>
			<string name="content"/>
		</out>
	</io>
</fusedoc>
--->
</cfsilent>
<cfsavecontent variable="switchblock">
<cflock timeout="60" throwontimeout="Yes" type="EXCLUSIVE">
<!--- Display start of CFSWITCH --->
	<cfoutput>
	<pre>
&lt;cfswitch expression="##fusebox.fuseaction##"&gt;
	</cfoutput>
    <cfmodule template="../../customtags/lesswhitespace.cfm">
	<cfset firstAction=true><!--- @PDL: For each PageState --->
	<cfloop index="pagestate" list="#evaluate("application." & attributes.wireframeName & ".pl")#">
		<cfif pageState IS NOT "df">		    
		    <cfset pagedisplayname = evaluate("application." & attributes.wireframename & "." & pagestate & ".text")><!--- Get usable FuseAction name --->		    
		    <cfset fuseactionName = rereplace(pagedisplayname, "[']", "", "all")>		    
		    <cfset fuseactionName = rereplace(fuseactionName, '["]', "", "all")>		    
		    <cfset fuseactionName = rereplace(fuseactionName, "[^a-zA-Z0-9_]", "_", "all")>		    
		    <cfset fuseactionName = rereplace(fuseactionName, "_+", "_", "all")><!--- @PDL: +Show PageState name (hyperlinked)--->
			<cfoutput>
	&lt;cfcase value="#fuseactionName#<cfif firstAction>,default<cfset firstAction=false></cfif>"&gt;
			</cfoutput>
		    <cftry>
		    	<cfset content=evaluate("application.#Attributes.wireframename#.#pagestate#.content[1].content")>		    
		    	<cfset content=replace(content, "''", "'", "all")>		    
		    	<cfset display=evaluate("application.#Attributes.wireframename#.#pagestate#.content[1].display")>		    
		    	<cfset display=replace(display, "''", "'", "all")>
		    	<cfcatch type="expression">
					<!--- No content for the page --->
				</cfcatch>
			</cftry>
			<cfoutput>
		&lt;!---@FuseAction: #fuseactionName#: #content# ---&gt;
			</cfoutput>
			<cfoutput>
		&lt;cfoutput&gt;&lt;P&gt#content#&lt;/P&gt;&lt;/cfoutput&gt;
			</cfoutput>
			<!--- @PDL: +For each Link --->
			<cfloop index="link" from="1" to="#evaluate("arraylen(application." & attributes.wireframename & "." & pagestate & ".link) ")#">
			    			    <cfset displayText = rereplace(evaluate("application." & attributes.wireframename & "." & pagestate & ".link[" & link & "].display"), "([^\.]+)\.", "\1: ")>					
				<cfif left(displayText, 6) IS "menu: ">
				    <cfbreak>
				</cfif>
			    			    <cfset extra_text = "">			    
			    <cfset destination_code = #evaluate("application." & attributes.wireframename & "." & pagestate & ".link[" & link & "].RFA")#>			    
			    <cfset destination_text = #evaluate("application." & attributes.wireframename & "." & pagestate & ".link[" & link & "].RFAdisplay")#>
			    <cftry>
			    			    <cfset tmp = #evaluate("application." & attributes.wireframename & "." & destination_code & ".text")#>
			    <cfcatch type="expression">
<!--- Destination page not yet defined --->			    
			    <cfset extra_text="&nbsp;&nbsp;<I>[undef.]</I>"></cfcatch></cftry>			    
			    <cfset displayText = rereplace(displayText, "[']", "", "all")>			    
			    <cfset displayText = rereplace(displayText, '["]', "", "all")>			    
			    <cfset displayText = rereplace(displayText, "[^a-zA-Z0-9_]", "_", "all")>			    
			    <cfset displayText = rereplace(displayText, "_+", "_", "all")>			    
			    <cfset destination_text = rereplace(destination_text, "[']", "", "all")>			    
			    <cfset destination_text = rereplace(destination_text, '["]', "", "all")>			    
			    <cfset destination_text = rereplace(destination_text, "[^a-zA-Z0-9_]", "_", "all")>			    
			    <cfset destination_text = rereplace(destination_text, "_+", "_", "all")>
				<cfoutput>
		&lt;cfset request.XFA.#displayText# = "#attributes.wireframename#.#destination_text#"&gt;
				</cfoutput>
				<!--- @PDL: +Next Link --->
			</cfloop>
			<cfoutput>
		&lt;cfoutput&gt;
			</cfoutput>
			<!--- @PDL: +For each Link --->
			<cfloop index="link" from="1" to="#evaluate("arraylen(application." & attributes.wireframename & "." & pagestate & ".link)")#">
			    			    <cfset displayText = rereplace(evaluate("application." & attributes.wireframename & "." & pagestate & ".link[" & link & "].display"), "([^\.]+)\.", "\1: ")>			    
			    <cfset displayOriginal = displayText>					
				<cfif left(displayText, 6) IS "menu: ">
				    <cfbreak>
				</cfif>
			    			    <cfset extra_text = "">			    
			    <cfset destination_code = #evaluate("application." & attributes.wireframename & "." & pagestate & ".link[" & link & "].RFA")#>			    
			    <cfset destination_text = #evaluate("application." & attributes.wireframename & "." & pagestate & ".link[" & link & "].RFAdisplay")#>
			    <cftry>
			    			    <cfset tmp = #evaluate("application." & attributes.wireframename & "." & destination_code & ".text")#>
			    <cfcatch type="expression">
<!--- Destination page not yet defined --->			    
			    <cfset extra_text="&nbsp;&nbsp;<I>[undef.]</I>"></cfcatch></cftry>			    
			    <cfset displayText = rereplace(displayText, "[']", "", "all")>			    
			    <cfset displayText = rereplace(displayText, '["]', "", "all")>			    
			    <cfset displayText = rereplace(displayText, "[^a-zA-Z0-9_]", "_", "all")>			    
			    <cfset displayText = rereplace(displayText, "_+", "_", "all")>			    
			    <cfset destination_text = rereplace(destination_text, "[']", "", "all")>			    
			    <cfset destination_text = rereplace(destination_text, '["]', "", "all")>			    
			    <cfset destination_text = rereplace(destination_text, "[^a-zA-Z0-9_]", "_", "all")>			    
			    <cfset destination_text = rereplace(destination_text, "_+", "_", "all")>
				<cfoutput>
			&lt;a href="index.cfm?fuseaction=##request.XFA.#displaytext###"&gt;#displayOriginal#&lt;/a&gt;&lt;br /&gt;
				</cfoutput>
				<!--- @PDL: +Next Link --->
			</cfloop>
			<cfoutput>
		&lt;/cfoutput&gt;
			</cfoutput>
			<cfoutput>
		&lt;cfset request.page.subtitle = "#pagedisplayname#"&gt;
			</cfoutput>
			<cfoutput>
	&lt;/cfcase&gt;
			</cfoutput>
		</cfif>
		<!--- @PDL: Next PageState --->
	</cfloop>
	<!--- Display end of CFSWITCH --->
	</cfmodule>
	<cfoutput>
	&lt;cfdefaultcase&gt;
		&lt;cfset request.error.type="Unknown Action"&gt;
		&lt;cfset request.error.message='Action "##attributes.original_fuseaction##" unknown.'&gt;
		&lt;cfthrow&gt;
	&lt;/cfdefaultcase&gt;
		
&lt;/cfswitch&gt;
</pre>
	</cfoutput>
</cflock>
</cfsavecontent>
<cfsilent>
<!---
  $Log: out_switchblock.cfm,v $
  Revision 1.0  2002-04-26 21:07:40+10  leeb
  Initial revision

  Revision 1.2  2001/08/21 13:26:58  leeborkman
  Added CVS Log block to the bottom of each file

--->
</cfsilent>
