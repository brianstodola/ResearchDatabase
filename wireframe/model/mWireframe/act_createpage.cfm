<!--- -->
<fusedoc fuse="act_createpage.cfm">
	<responsibilities>
		I process the data from the edit page form and create the page in memory.
	</responsibilities>
	<properties>
		<history author="" email="" role="Architect" type="Create"/>
		<property name="licence" value="See licence.txt" />
		<property name="version" value="$Revision$" />
		<property name="lastupdated" value="$Date$" />
		<property name="updatedby" value="$Author$" />
	</properties>
	<io>
		<in>
			<string name="wireframename" scope="attributes"/>
			<string name="pagedisplayname" scope="attributes"/>
			<string name="Responsibilities" scope="formOrUrl" />
			
			<list name="form.fieldnames" delimiters=","/>
			
			<string name="isMenu_#exitnum#" scope="attributes" comments="Indicates that exit is a main menu item." />
			<string name="exit_#exitnum#" scope="attributes" comments="Exit text or image description on the page"/>
			<string name="dest_#exitnum#" scope="attributes" comments="Page name"/>
			<string name="newDest_#exitnum#" scope="attributes" comments="New Page name"/>
		</in>
		<out>
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
		</out>
	</io>
</fusedoc>
--->
<cflock timeout="60" throwontimeout="Yes" type="EXCLUSIVE">
	<cfset newpage = "p_" & rereplace(attributes.pagedisplayname, "[^a-zA-Z0-9_]", "_", "all")>    
	<cfset "application.#Attributes.wireframename#.#newpage#" = structNew()>    
	<cfset "application.#Attributes.wireframename#.pl" = ListSetAt(evaluate("application.#Attributes.wireframename#.pl"),ListFindNoCase(evaluate("application.#Attributes.wireframename#.pl"),attributes.page),newpage)>
	
	<!--- Set pointer to page structure --->    
	<cfset thisPage = evaluate('application.' & Attributes.wireframename & '.' & newpage)>    
	<cfset "thisPage.content" = arrayNew(1)>    
	<cfset tmp = ArrayAppend(thisPage.content, structNew())>
	
	<!--- Set pointer to page content --->    
	<cfset thisContent = thisPage.content[1]>    
	<cfset tmp = setvariable('thisContent.content', trim(attributes.responsibilities))>    
	<cfset tmp = setvariable('thisContent.display', "comment")>    
	<cfset tmp = setvariable("thisPage.text", trim(attributes.pagedisplayname))>    
	<cfset thisPage.link = ArrayNew(1)>
	
	<!--- Set pointer to links array --->    
	<cfset thisLinks = thisPage.link>
	
	<!--- loop through all fields --->    
	<cfset arrayIndex = 1>
	<cfloop index="fieldname" list="#form.fieldnames#">
		<cfif (left(fieldname, 5) is 'exit_') AND (len(trim(evaluate("attributes." & fieldname))))>		    
			<cfset exitnum = rereplacenocase(fieldname, "exit_", "")>
			<cfoutput>
				#exitnum# #evaluate("attributes.exit_" & exitnum)# : #evaluate("attributes.dest_" & exitnum)#<br>
			</cfoutput>
			<cfset thisPage.link[arrayIndex] = structnew()>				
			<cfif isDefined("attributes.ismenu_" & exitnum)>			    
			    <cfset thisPage.link[arrayIndex].display = "menu." &evaluate("attributes.exit_" & exitnum)>
			<cfelse>
				<cfset thisPage.link[arrayIndex].display = evaluate("attributes.exit_" & exitnum)>
			</cfif>
			<cfif len(trim(evaluate("attributes.newDest_" & exitnum)))>			    
			    <cfset dest=trim(evaluate("attributes.newDest_" & exitnum))>			    
			    <cfset destinationEscaped =   "p_" & rereplace(dest, "[^a-zA-Z0-9_]", "_", "all")>					
				<cfif not isDefined('application.' & Attributes.wireframename & '.' & destinationEscaped)>				    
				    <cfset tmp = setvariable('application.' & Attributes.wireframename & '.' & destinationEscaped, structNew())>				    
				    <cfset tmp = setvariable('application.' & Attributes.wireframename & '.' & destinationEscaped & '.text', dest)>				    
				    <cfset tmp = setvariable('application.' & Attributes.wireframename & '.' & destinationEscaped & '.link', arrayNew(1))>				    
				    <cfset tmp = setvariable('application.' & Attributes.wireframename & '.' & destinationEscaped & '.content', arrayNew(1))>				    
				    <cfset tmp = arrayAppend(evaluate('application.' & Attributes.wireframename & '.' & destinationEscaped & '.content'), structNew())>				    
				    <cfset "application.#Attributes.wireframename#.pl" = ListAppend(evaluate('application.' & Attributes.wireframename & '.pl'), destinationEscaped)>
				</cfif>
			<cfelse>
				<cfset dest=trim(evaluate("attributes.dest_" & exitnum))>			    
			    <cfset destinationEscaped =   "p_" & rereplace(dest, "[^a-zA-Z0-9_]", "_", "all")>
			</cfif>
			<cfset thisPage.link[arrayIndex].rfadisplay = dest>		    
		    <cfset thisPage.link[arrayIndex].rfa = destinationEscaped>		    
		    <cfset arrayIndex = arrayIndex + 1>
		</cfif>
	</cfloop>
</cflock>

<!---
$Log: out_pagestate.cfm,v $
Revision 1.3  2001/08/21 13:26:58  leeborkman
Added CVS Log block to the bottom of each file

--->
