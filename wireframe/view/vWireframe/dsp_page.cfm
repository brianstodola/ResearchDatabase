<cfsilent>
<!--- -->
<?xml version="1.0" encoding="UTF-16"?>
<fusedoc fuse="$RCSfile$" language="ColdFusion" specification="2.0">
	<responsibilities>
		I display a form allowing a single page state to be edited.
		There is a text area for the description and a row of boxes for each of the XFAs.
	</responsibilities>
	<properties>
		<property name="licence" value="See licence.txt" />
		<property name="version" value="$Revision$" />
		<property name="lastupdated" value="$Date$" />
		<property name="updatedby" value="$Author$" />
	</properties>
	<io>
		<in>
			<string name="XFA.onSubmit" scope="variables" />
			<string name="self" scope="variables" />
			<string name="page" scope="attributes" />
			<string name="return" scope="attributes" />
			<string name="wireframename" scope="attributes" />
			<string name="wireframedir" scope="attributes" />
			<string name="pagedisplayname" scope="attributes" />
			<string name="pagedisplayname" scope="attributes" />
			
			<structure name="#Attributes.wireframename#" scope="application" >
				<structure name="#attributes.page#">
					<array name="content">
						<string name="content"/>
						<string name="display"/>
					</array>
					<array name="link">
						<string name="RFA"/>
						<string name="display"/>
					</array>
				</structure>
			</structure>
			
		</in>
		<out>
			<string name="fuseaction" scope="formOrUrl" />
			<string name="page" scope="formOrUrl" />
			<string name="return" scope="formOrUrl" />
			<string name="wireframename" scope="formOrUrl" />
			<string name="wireframedir" scope="formOrUrl" />
			<string name="pagedisplayname" scope="formOrUrl" />
			<string name="Responsibilities" scope="formOrUrl" />
			
			
			<string name="isMenu_#exitnum#" scope="formOrUrl" comments="Indicates that exit is a main menu item." />
			<string name="exit_#exitnum#" scope="formOrUrl" comments="Exit text or image description on the page"/>
			<string name="dest_#exitnum#" scope="formOrUrl" comments="Page name"/>
			<string name="newDest_#exitnum#" scope="formOrUrl" comments="New Page name"/>
			
		</out>
	</io>
</fusedoc>
 ---></cfsilent>

<cfset pagedisplayname = evaluate("application." & attributes.wireframename & "." & attributes.page & ".text")>
<cfoutput>
	<form name="form1" method="post" action="#self#">
		<input type="Hidden" name="fuseaction" value="#XFA.onSubmit#" />
		<input type="hidden" name="page" value="#attributes.page#">
		<input type="hidden" name="return" value="#attributes.return#">
		<input type="hidden" name="wireframename" value="#attributes.wireframename#">
		<input type="hidden" name="wireframedir" value="#attributes.wireframedir#">
  		<p><strong>Title</strong>:<br>
		<input type="text" name="pagedisplayname" size="40" value="#pagedisplayname#">
		</p>
		<p><strong>Responsibilities</strong>:<br>
		<cfmodule template="../../customtags/LessWhiteSpace.cfm" justify="yes" removecrlf="yes">
   		<textarea name="Responsibilities" cols="80" rows="5" wrap="VIRTUAL">
			<cfloop index="ContentIndex" from="1" to="#evaluate('ArrayLen(application.' & Attributes.wireframename & '.' & attributes.page & '.content)')#">
				<cfset content=evaluate("application.#Attributes.wireframename#.#attributes.page#.content[#ContentIndex#].content")>
				<cfset content=replace(content, "''", "'", "all")>
				<cfset display=evaluate("application.#Attributes.wireframename#.#attributes.page#.content[#ContentIndex#].display")>
				<cfset display=replace(display, "''", "'", "all")>
				<cfif display IS "comment">
					#trim(content)#
				<cfelse>
					#display#: #content#
				</cfif>
			</cfloop>
		</textarea>
		</cfmodule>
		</p>
	    <p>
	      <input type="submit" name="Submit" value="Submit">
	    </p>
	
		<table border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td><strong>Menu?&nbsp;&nbsp;&nbsp;</strong></td>
				<td><strong>Exit</strong></td>
				<td><strong>Existing Page</strong></td>
				<td><strong>New Page</strong></td>
			</tr>
			<cfset exitnum = 0>
			<cfloop index="RFAindex" FROM="1" TO="#evaluate('ArrayLen(application.' & Attributes.wireframename & '.' & attributes.page & '.link)')#">
				<cfset exitnum = exitnum + 1>
				<cfset RFA=evaluate("application.#Attributes.wireframename#.#attributes.page#.link[#RFAindex#].RFA")>
				<cfset display=evaluate("application.#Attributes.wireframename#.#attributes.page#.link[#RFAindex#].display")>
				<cfset display=replace(display, "''", "'", "all")>
				<cfif left(display, 5) IS "menu.">
					<cfset isMenu = true>
				<cfelse>
					<cfset isMenu = false>
				</cfif>
				<cfif isMenu AND NOT isDefined("menuheadingdone")>
					<cfset menuheadingdone = true>
				</cfif>
				<cfset display=rereplacenocase(display, "^menu.", "")>
				<cfif listlen(RFA, ".") GT 1>
					<cfset nextApp = ListGetAt(RFA,1,".")>
					<cfset RFA = ListGetAt(RFA,2,".")>
				<cfelse>
					<cfset nextApp = Attributes.wireframename>
				</cfif>
				<tr>
					<td>
						<input type="checkbox" name="isMenu_#exitnum#" value="isMenu_#exitnum#" <cfif isMenu>checked</cfif>>
					</td>
					<td>
						<input type="text" name="exit_#exitnum#" value="#display#" size="25"><b>&nbsp;=>&nbsp;</b>
					</td>
					<td>
						<select name="dest_#exitnum#" size="1">
							<option>
							<cfloop index="pagestate" LIST="#evaluate("application." & attributes.wireframeName & ".pl")#">
								<option <cfif RFA EQ pagestate>selected</cfif>>#evaluate("application." & attributes.wireframeName & "." & pagestate & ".text")#
							</cfloop>
						</select>&nbsp;
	      			</td>
					<td>
						<input type="text" name="newDest_#exitnum#" size="25">
					</td>
				</tr>
			</cfloop>
			<cfloop index="x" from="#val(exitnum+1)#" to="#val(exitnum+6)#">
				<tr>
					<td>
						<input type="checkbox" name="isMenu_#x#" value="isMenu_#x#">
					</td>
					<td>
						<input type="text" name="exit_#x#" value="" size="25"><b>&nbsp;=>&nbsp;</b>
					</td>
					<td>
						<select name="dest_#x#" size="1">
							<option>
							<cfloop index="pagestate" LIST="#evaluate("application." & attributes.wireframeName & ".pl")#">
								<option>#evaluate("application." & attributes.wireframeName & "." & pagestate & ".text")#
							</cfloop>
				
						</select>
					</td>
					<td><input type="text" name="newDest_#x#" size="25">&nbsp;
					</td>
				</tr>
			</cfloop>
			<tr>
				<td colspan="4">&nbsp;</td>
			</tr>
		</table>
		<p><input type="submit" name="Submit" value="Submit"></p>
		
	</form>

</cfoutput>


