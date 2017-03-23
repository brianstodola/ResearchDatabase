<!--- -->
<fusedoc fuse="dsp_pagestate.cfm">
	<responsibilities>
		I show the contents and links for a particular PageState.
	</responsibilities>
	<properties>
		<history author="Hal Helms" email="hal.helms@TeamAllaire.com" role="Author" type="Create"/>
		<history author="Lee Bjork Borkman" email="bjork@bjork.net" date="15-Feb-2001" role="Fusecoder" type="Update">
			Amended to use structures instead of a database, and to separate "menu" links.
		</history>
		<property name="licence" value="See licence.txt"/>
	    <property name="version" value="$Revision$"/>
	    <property name="lastupdated" value="$Date$"/>
	    <property name="updatedby" value="$Author$"/>
	</properties>
	<io>
		<in>
			<string name="XFA.editpage"/>
			<string name="XFA.showpage"/>
			<string name="self"/>
			<string name="page.width" scope="request"/>
			<string name="pagedisplayname"/>
			<string name="page" scope="attributes" comments="The page/state to be displayed"/>
			<string name="wireframename" scope="attributes"/>
			<string name="wireframedir" scope="attributes"/>
			<string name="Attributes.wireframename" scope="attributes"/>
			<string name="ContentIndex"/>
		</in>
		<out>
			<string name="pagedisplayname"/>
			<string name="content"/>
			<string name="display"/>
			<string name="menudivider"/>
			<string name="displayText"/>
			<boolean name="isMenuLink"/>
			<string name="extra_text"/>
			<string name="destination_code"/>
			<string name="destination_text"/>
			<string name="tmp"/>
		</out>
	</io>
</fusedoc>
--->
    
<cflock timeout="60" throwontimeout="Yes" type="EXCLUSIVE">
	<cfoutput>
		<br />
		<table width="#request.page.width#" cellspacing="0" cellpadding="5" border="1">
			<tr>
				<td>						
					<cfif isdefined('application.' & Attributes.wireframename & '.' & attributes.page & '.content')>					    
					    <cfset pagedisplayname = evaluate("application." & attributes.wireframename & "." & attributes.page & ".text")>					          
						<font size=+2>#pagedisplayname#</font>&nbsp;&nbsp;&nbsp;&nbsp;					                 
						<font size=-1>[<a href="index.cfm?fuseaction=#XFA.editpage#&page=#attributes.page#&wireframename=#attributes.wireframename#&wireframedir=#attributes.wireframedir#&return=single">Edit&nbsp;Page</a>]</font>

						<p>
						<cfloop index="ContentIndex" from="1" to="#evaluate('ArrayLen(application.' & Attributes.wireframename & '.' & attributes.page & '.content)')#">
		              	    <cfset content=evaluate("application.#Attributes.wireframename#.#attributes.page#.content[#ContentIndex#].content")>					              	    
		              	    <cfset content=replace(content, "''", "'", "all")>					              	    
							<cfset display=evaluate("application.#Attributes.wireframename#.#attributes.page#.content[#ContentIndex#].display")>					              	    
							<cfset display=replace(display, "''", "'", "all")>					              			
							<cfif display IS "comment">
								#content#<br>
							<cfelse>
								<i>#display#</i>: #content#<br>
							</cfif>
		              	</cfloop>
					<cfelse>
						<cfset pagedisplayname = replace(attributes.page, "p_", "")>
						<cfset pagedisplayname = replace(pagedisplayname, "_", " ", "all")>
						<h2>#pagedisplayname#</h2>
						<p><i>No content defined</i></p>
					</cfif>
					<blockquote>
					<font size=+1>Exits</font>
					
					<cfif isdefined('application.' & Attributes.wireframename & '.' & attributes.page & '.link')>				              	    
						<cfset menudivider = false>
						<ul>
						<cfloop index="i" from="1" to="2">
							<cfloop index="link" from="1" to="#evaluate("arraylen(application." & attributes.wireframename & "." & page & ".link)")#">
								<cfset displayText = rereplace(evaluate("application." & attributes.wireframename & "." & page & ".link[" & link & "].display"), "([^\.]+)\.", "\1: ")>				              			    
								<cfset isMenuLink = iif(left(displayText, 6) IS "menu: ", true, false)>				              					
								<cfif isMenuLink>
									<cfset displayText = replacenocase(displayText, "menu: ", "")>
								</cfif>
								<cfif ((i EQ 2) AND isMenuLink) OR ((i EQ 1) AND NOT isMenuLink)>
									<cfif (isMenuLink AND NOT MenuDivider)>
										</ul>
										<font size=+1>Menu</font>
										<ul>
										<cfset menudivider = true>
									</cfif>
									<cfset extra_text = "">
									<cfset destination_code = #evaluate("application." & attributes.wireframename & "." & page & ".link[" & link & "].RFA")#>				              				    
									<cfset destination_text = #evaluate("application." & attributes.wireframename & "." & page & ".link[" & link & "].RFAdisplay")#>
									<cftry>
										<cfset tmp = #evaluate("application." & attributes.wireframename & "." & destination_code & ".text")#>
										<cfcatch type="expression">
											<!--- Destination page not yet defined --->
											<cfset extra_text="&nbsp;&nbsp;<I>[undef.]</I>">
										</cfcatch>
									</cftry>
				              		<li><a href="#self#?fuseaction=#XFA.showpage#&page=#destination_code#&wireframename=#attributes.wireframename#&wireframedir=#attributes.wireframedir#">#displayText#</a>
								</cfif>
							</cfloop>
						</cfloop>
						</ul>
					<cfelse>
						<p><i>No links defined</i></p>
					</cfif>
					</blockquote>
				</td>
			</tr>
		</table>
		<p>
	</cfoutput>
</cflock>
<!---
$Log: out_pagestate.cfm,v $
Revision 1.1  2002-04-27 22:55:25+10  leeb
First GUI beta demo-ed but not released on bjork.net

Revision 1.0  2002-04-26 21:07:38+10  leeb
Initial revision

Revision 1.3  2001/08/21 13:26:58  leeborkman
Added CVS Log block to the bottom of each file

--->
