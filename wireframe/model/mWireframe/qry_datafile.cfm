<!--- -->
<fusedoc fuse="out_datafile.cfm">
	<responsibilities>
		I take the CF structures and display an INI-format definition of the wireframe.
	</responsibilities>
	<properties>
		<history author="Lee Bjork Borkman" email="bjork@bjork.net" role="Designer" type="Create"/>
		<history author="Hal Helms" email="hal.helms@TeamAllaire.com" role="Fusecoder" type="Create"/>
		<history author="Lee Bjork Borkman" email="bjork@bjork.net" role="Fusecoder" type="Update" date="23-Feb-2001">
			Amended to use structures instead of a database, and to separate "menu" links.
		</history>
		<history author="Lee Bjork Borkman" email="bjork@bjork.net" role="Fusecoder" type="Update" date="19-Apr-2001">
			Amended for use of special chars in page names, and to stop exposing full server paths
		</history>
		<history author="Lee Bjork Borkman" email="bjork@bjork.net" role="Fusecoder" type="Update" date="21-Apr-2001">
			Better Map - CustomTags included in top directory for easy install
		</history>
		<history author="Lee Bjork Borkman" email="bjork@bjork.net" role="Fusecoder" type="Update" date="22-Apr-2001">
			cflock around application variables
		</history>
		<property name="licence" value="See licence.txt" />
		<property name="version" value="$Revision$" />
		<property name="lastupdated" value="$Date$" />
		<property name="updatedby" value="$Author$" />
	</properties>
	<io>
		<in>
			<structure name="wireframename" scope="application" comments="A structure with same name as wireframe to hold parsed data">
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
			<string name="datafile" scope="attributes"/>
		</out>
	</io>
</fusedoc>
--->
<cfparam name="attributes.doLinks" default="yes">
<cflock timeout="60" throwontimeout="Yes" type="EXCLUSIVE">
    <cfsavecontent variable="attributes.datafile">
    <cfmodule template="../../customtags/lesswhitespace.cfm" justify="true">
	<cfoutput>
		<!--- @PDL: For each PageState --->
		<cfloop index="pagestate" list="#evaluate("application." & attributes.wireframename & ".pl")#">
			<cfif pageState IS NOT "df">				
				<!--- @PDL: +Show PageState name (hyperlinked)--->			    
			    <cfset pagedisplayname = evaluate("application." & attributes.wireframename & "." & pagestate & ".text")>
[#pagedisplayname#]
			    <cftry>
					<cfset content=evaluate("application.#Attributes.wireframename#.#pagestate#.content[1].content")>
					<cfset content=replace(content, "''", "'", "all")>
					<cfset display=evaluate("application.#Attributes.wireframename#.#pagestate#.content[1].display")>
					<cfset display=replace(display, "''", "'", "all")>
					<cfcatch type="expression">
						<cfset content="">
					</cfcatch>
				</cftry>
;#content##Chr(13)##Chr(10)#
				<!--- Links --->
			    <cfset menudivider = false>
				<cfloop index="i" from="1" to="2">
					<cfloop index="link" from="1" to="#evaluate("arraylen(application." & attributes.wireframename & "." & pagestate & ".link) ")#">
						<cfset displayText = rereplace(evaluate("application." & attributes.wireframename & "." & pagestate & ".link[" & link & "].display"), "([^\.]+)\.", "\1: ")>
					    <cfset isMenuLink = iif(left(displayText, 6) IS "menu: ", true, false)>
						<cfif isMenuLink>						    
						    <cfset displayText = replacenocase(displayText, "menu: ", "")>
						</cfif>
						<cfif ((i EQ 2) AND isMenuLink) OR ((i EQ 1) AND NOT isMenuLink)>						    
						    <cfset extra_text = "">						    
						    <cfset destination_code = #evaluate("application." & attributes.wireframename & "." & pagestate & ".link[" & link & "].RFA")#>
						    <cfset destination_text = #evaluate("application." & attributes.wireframename & "." & pagestate & ".link[" & link & "].RFAdisplay")#>
						    <cftry>
								<cfset tmp = #evaluate("application." & attributes.wireframename & "." & destination_code & ".text")#>
								<cfcatch type="expression">
									<!--- Destination page not yet defined --->						    
									<cfset extra_text="&nbsp;&nbsp;<I>[undef.]</I>">
								</cfcatch>
							</cftry>								
<cfif isMenulink>menu.</cfif>#displayText# = #destination_text##Chr(13)##Chr(10)#
						</cfif>
					</cfloop>
				</cfloop>
			</cfif>
			<!--- @PDL: Next PageState --->
		</cfloop>
	</cfoutput>
	</cfmodule>
	</cfsavecontent>
</cflock>
<cfsetting enablecfoutputonly="no">
<!---
  $Log: out_quickmap.cfm,v $
  Revision 1.3  2001/08/21 13:26:58  leeborkman
  Added CVS Log block to the bottom of each file

--->
