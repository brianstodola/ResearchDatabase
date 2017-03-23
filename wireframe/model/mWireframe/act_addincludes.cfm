<!--- -->
<fusedoc fuse="act_addincludes.cfm">
	<responsibilities>
		I look through the list of links in each page for links called *include* and then
		replace them with a copy of the links on the included page state.
	</responsibilities>
	<properties>
		<history author="Hal Helms" email="hal.helms@TeamAllaire.com" type="Create" role="Author"/>
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

<cfloop index="pagestate" list="#evaluate("application." & attributes.wireframeName & ".pl")#">
	<cfif pageState IS NOT "df">		    
	    <cfset L=1>
		<cfloop condition='L LTE ArrayLen(evaluate("application." & attributes.wireframeName & "." & pagestate & ".link"))'>
			<cfif evaluate("application." & attributes.wireframeName & "." & pagestate & ".link[" & L & "].display") IS "*include*">				    
			    <cfset D = evaluate("application." & attributes.wireframeName & "." & pagestate & ".link[" & L & "].RFA")>				    
			    <cfset A = StructFind(evaluate("application." & attributes.wireframeName & "." & pagestate), "link")>				    
			    <cfset tmp=arrayDeleteAt(A, L)>				    
			    <cfset L=L-1>				    
			    <cfset tmp=StructInsert(evaluate("application." & attributes.wireframeName & "." & pagestate), "link", A, "true")>						
				<cfif isDefined("application." & attributes.wireframeName & "." & D & ".link")>					    
				    <cfset A = StructFind(evaluate("application." & attributes.wireframeName & "." & pagestate), "link")>
					<cfloop index="DL" from="1" to="#ArrayLen(evaluate("application." & attributes.wireframeName & "." & D & ".link "))#">
						<cfset tmp=arrayAppend(A,evaluate("application." & attributes.wireframeName & "." & D & ".link[" & DL & "]"))>
					</cfloop>
					<cfset tmp=StructInsert(evaluate("application." & attributes.wireframeName & "." & pagestate), "link", A, "true")>
				</cfif>
			</cfif>
			<cfset L=L+1>
		</cfloop>
	</cfif>
	<!--- @PDL: Next PageState --->
</cfloop>
