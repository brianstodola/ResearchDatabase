<cfsilent>
<!--- -->
<?xml version="1.0" encoding="UTF-16"?>
<fusedoc fuse="$RCSfile$" language="ColdFusion" specification="2.0">
	<responsibilities>
		I take the CF structures and display a basic "map" of the wireframe.
	</responsibilities>
	<properties>
		<history author="Lee Bjork Borkman" email="bjork@bjork.net" type="Create" date="15-Feb-2001" role="Designer"/>
		<history author="Lee Bjork Borkman" email="bjork@bjork.net" type="Modify" date="23-Feb-2001" role="FuseCoder">
			Use structures instead of a database, and to separate "menu" links.
		</history>
		<history author="Lee Bjork Borkman" email="bjork@bjork.net" type="Modify" date="19-April-2001" role="FuseCoder">
			Amended for use of special chars in page names, and to stop exposing full server paths.
		</history>
		<history author="Lee Bjork Borkman" email="bjork@bjork.net" type="Modify" date="21-April-2001" role="FuseCoder">
			Better Map - CustomTags included in top directory for easy install
		</history>
		<history author="Lee Bjork Borkman" email="bjork@bjork.net" type="Modify" date="22-April-2001" role="FuseCoder">
			CFLOCK around application variables
		</history>
		
		<property name="licence" value="See licence.txt" />
		<property name="version" value="$Revision$" />
		<property name="lastupdated" value="$Date$" />
		<property name="updatedby" value="$Author$" />
	</properties>
	<io>
		<in>
			<boolean name="doLinks" default="true" comments="Make links for navigating" />
			<string name="wireframename" optional="No" />
		</in>
		<out>
			
		</out>
	</io>
</fusedoc>
 --->
</cfsilent>

<cfparam name="attributes.doLinks" default="true">
<cflock timeout="60" throwontimeout="Yes" type="EXCLUSIVE" scope="APPLICATION">
<cfoutput>
	<h2>Quick Map of "#attributes.wireframename#"</h2>
	<table border="1" width="#request.page.width#" cellspacing="0" cellpadding="3">
		<tr>
			<th width="35%">Page</th>
			<th width="65%">Exits and Destinations</th>
		</tr>	<!--- @PDL: For each PageState --->
		<cfloop index="pagestate" list="#evaluate("application." & attributes.wireframeName & ".pl")#">
			<cfif pageState IS NOT "df">
				<tr>
					<td>	<!--- @PDL: +Show PageState name (hyperlinked)--->						    
					    <cfset pagedisplayname = evaluate("application." & attributes.wireframename & "." & pagestate & ".text")>								
						<cfif attributes.doLinks>
							<table width="100%" border="0" cellpadding="0" cellspacing="0">
								<tr>
									<td>
										<a href="#self#?fuseaction=#XFA.showpage#&page=#pagestate#&wireframename=#attributes.wireframename#&wireframedir=#attributes.wireframedir#">
											#pagedisplayname#
										</a>
									</td>
									<td align="right">										   
									   <font size="-2">[<a href="index.cfm?fuseaction=#XFA.editpage#&page=#pagestate#&wireframename=#attributes.wireframename#&wireframedir=#attributes.wireframedir#&return=map">Edit</a>]</font>
									</td>
								</tr>
							</table>
						<cfelse>
							#pagedisplayname#<br>
						</cfif>
						<cftry>
						    <cfset content=evaluate("application.#Attributes.wireframename#.#pagestate#.content[1].content")>						    
						    <cfset content=replace(content, "''", "'", "all")>						    
						    <cfset display=evaluate("application.#Attributes.wireframename#.#pagestate#.content[1].display")>						    
						    <cfset display=replace(display, "''", "'", "all")>
						    <cfcatch type="expression">
						    	<cfset content="">
							</cfcatch>
						</cftry>						   
						<font size="-2">#content#</font>
					</td>
					<td>
						<table border="0" width="100%" cellspacing="1" cellpadding="1">							    
							<cfset menudivider = false>
								<cfloop index="i" from="1" to="2">
									<cfloop index="link" from="1" to="#evaluate(" arraylen(application." & attributes.wireframename & "." & pagestate & ".link) ")#">
										<cfset displayText = rereplace(evaluate("application." & attributes.wireframename & "." & pagestate & ".link[" & link & "].display"), "([^\.]+)\.", "\1: ")>									    
									    <cfset isMenuLink = iif(left(displayText, 6) IS "menu: ", true, false)>											
										<cfif isMenuLink>										    
										    <cfset displayText = replacenocase(displayText, "menu: ", "")>
										</cfif>
										<cfif ((i EQ 2) AND isMenuLink) OR ((i EQ 1) AND NOT isMenuLink)>												
											<cfif (isMenuLink AND NOT MenuDivider)>
												<tr>
													<td colspan="3">	------------------------------------------------------
													</td>
												</tr>											    
											    <cfset menudivider = true>
											</cfif>
											<tr>
												<td width="45%">												   
												   <font size="-2">#displayText#
												</td>
												<td width="10%">	-->
												</td>											    
											    <cfset extra_text = "">											    
											    <cfset destination_code = #evaluate("application." & attributes.wireframename & "." & pagestate & ".link[" & link & "].RFA")#>											    
											    <cfset destination_text = #evaluate("application." & attributes.wireframename & "." & pagestate & ".link[" & link & "].RFAdisplay")#>
											    <cftry>
											    <cfset tmp = #evaluate("application." & attributes.wireframename & "." & destination_code & ".text")#>
											    <cfcatch type="expression">
												<!--- Destination page not yet defined --->											    
											    <cfset extra_text="&nbsp;&nbsp;<I>[undef.]</I>"></cfcatch></cftry>
												<td width="45%">												   
												   <font size="-2">														
													<cfif attributes.doLinks><a href="#self#?fuseaction=#XFA.showpage#&page=#destination_code#&wireframename=#attributes.wireframename#&wireframedir=#attributes.wireframedir#">
														<font size="-2">#destination_text##extra_text#
														</a>
													<cfelse>
														<font size="-2">#destination_text##extra_text#
													</cfif>
												</td>
											</tr>
										</cfif>
									</cfloop>
								</cfloop>
							</table></font>
						</td>
					</tr>
				</cfif>
				<!--- @PDL: Next PageState --->
			</cfloop>
		</table>
	</cfoutput>
</cflock>
<cfsilent>
<!---
  $Log: out_quickmap.cfm,v $
  Revision 1.3  2001/08/21 13:26:58  leeborkman
  Added CVS Log block to the bottom of each file

--->
</cfsilent>
