<cfsilent>
<!--- -->
<?xml version="1.0" encoding="UTF-16"?>
<fusedoc fuse="$RCSfile$" language="ColdFusion" specification="2.0">
	<responsibilities>
		I read the wireframe data file and create an in memory structure.
	</responsibilities>
	<properties>
		<history author="Hal Helms" email="hal.helms@TeamAllaire.com" type="Create" role="Author"/>
		<history author="Lee Bjork Borkman" email="bjork@bjork.net" type="Create" date="15-Feb-2001" role="Fusecoder">
			Amended to use structures instead of a database, and to separate "menu" links.
		</history>
		<property name="licence" value="See licence.txt" />
		<property name="version" value="$Revision$" />
		<property name="lastupdated" value="$Date$" />
		<property name="updatedby" value="$Author$" />
	</properties>
	<io>
		<in>
			<boolean name="refresh" scope="Request" comments="Do we force a re-parse?"/>
			<string name="wireframename" scope="Attributes"/>
			<string name="wireframedir" scope="Attributes" comments="Relative to the wireframetool's install directory"/>
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
</cfsilent>

<!--- @COMMENT: For testing purposes; may be removed for production --->
<cfparam name="attributes.refresh" default="false">

<cflock timeout="60" throwontimeout="Yes" type="EXCLUSIVE">
	<cfif NOT isdefined("application.#attributes.wireframeName#") OR (attributes.refresh IS "true")>
		<!--- We need to read and parse the wireframe data file --->
		<cftry>
			<!--- Read in the wireframe specification file. --->
		    <cffile action="READ" file="#attributes.fullwireframedir##request.os.delimiter##attributes.wireframename#.wir" variable="fileString">
			<cfset fileString=rereplace(fileString, "\[\[\:changedescription\:\]\].*", "")>	    
	    	<cfset fileString=rereplace(fileString, "[#chr(10)##chr(13)#][#chr(10)##chr(13)#]", "#chr(10)#", "all")>	    
			<cfset fileString=rereplace(fileString, "#chr(10)#\-+#chr(10)#", "#chr(10)#", "all")>
			<cfcatch>
				<cfoutput>
					Couldn't find the application's wireframe specification file, 
					"#attributes.fullwireframedir##request.os.delimiter##attributes.wireframename#.wir".
				</cfoutput>
	    		<cfabort>
			</cfcatch>
		</cftry>
		
		<!--- Clear the old structure if its there --->
		<cfif isdefined("application.#attributes.wireframeName#")>		    
		    <cfset tmp = evaluate("StructClear(application.#attributes.wireframename#)")>
		</cfif>
		
		<!--- Create a new copy in memory --->
		<cfset "application.#attributes.wireframename#" = StructNew()>
	    <cfset "application.#attributes.wireframename#.pl" = "">
	    <cfset "application.#attributes.wireframeName#.df" = fileString>
		
		<!--- Create an array to hold faIncludes --->
	    <cfset faIncludes = ArrayNew(2)>
		<!--- Loop over the entire file --->
		<cfloop list="#fileString#" index="aLine" delimiters="#chr(10)#">
			<!--- If I find a fuseaction, mark it --->			
			<cfif Left( Trim( aLine ), 1 ) is "[">		    
			    <cfset fa = ReplaceList( trim(aLine), '[,]', '' )>			    
			    <cfset fatext = fa>			    
			    <cfset fa = 'p_#rereplace(fa, "[^a-zA-Z0-9_]", "_", "all")#'>			    
			    <cfset tmp = evaluate("application.#attributes.wireframename#.#fa# = StructNew()")>			    
			    <cfset tmp = evaluate("structinsert(application.#attributes.wireframename#.#fa#, 'text', fatext)")>			    
			    <cfset tmp = evaluate("structinsert(application.#attributes.wireframename#.#fa#, 'content', ArrayNew(1))")>			    
			    <cfset tmp = evaluate("structinsert(application.#attributes.wireframename#.#fa#, 'link', ArrayNew(1))")>			    
			    <!--- Add the pagestate to the page list --->
				<cfset "application.#attributes.wireframeName#.pl" = ListAppend(evaluate("application." & attributes.wireframeName & ".pl"), fa)>
			</cfif>
			
			<!--- As long as i'm in the same fa, find the elements and enter them into the database --->
			<!--- get rid of the line break --->		    
			<cfset aLine = REReplace( aLine, '#chr(10)#', '', 'ALL' )>
			<!--- if i don't find a new fa --->
			<cfif NOT REFindNoCase( '[\[{]', aLine )>
			<!--- and if i'm not in an include section --->
				<cfif REFind( '[=:]', aLine ) OR left(aLine, 1) IS ';'>
					<!--- include any RFAs --->
					<cfif left(aLine, 16) IS NOT 'Responsibilities' AND left(aLine, 11) IS NOT 'Description'AND left(aLine, 1) IS NOT ';'>					    
					    <cfset tmp = evaluate("ArrayAppend(application.#attributes.wireframename#.#fa#.link, StructNew())")>					    
					    <cfset index = evaluate ("ArrayLen(application.#attributes.wireframename#.#fa#.link)")>					    
					    <cfset displayString = Trim( GetToken( aLine, 1, ':=' ) )>					    
					    <cfset displayString = replace(displayString , "'", "''", "all")>					    
					    <cfset tmp = evaluate("structinsert(application.#attributes.wireframename#.#fa#.link[#index#], 'display', '#displayString#')")>					    
					    <cfset destination = Trim(GetToken(aLine, 2, ':='))>					    
					    <cfset prefix="">							
						<cfif ListLen(destination, ".") GT 1>						    
						    <cfset prefix = ListFirst(destination, ".")>						    
						    <cfset destination = ListDeleteAt(destination, 1, ".")>
						</cfif>
						<cfset destinationDisplay = destination>					    
					    <cfset destination = 'p_#rereplace(destination, "[^a-zA-Z0-9_]", "_", "all")#'>							
						<cfif len(prefix)>						    
						    <cfset destination = "#prefix#.#destination#">
						</cfif>
						<cfset tmp = evaluate("structinsert(application.#attributes.wireframename#.#fa#.link[#index#], 'RFA', '#destination#')")>					    
					    <cfset destinationDisplay=replace(destinationDisplay,"'", "", "all")>					    
					    <cfset destinationDisplay=replace(destinationDisplay,'"', "", "all")>					    
					    <cfset tmp = evaluate("structinsert(application.#attributes.wireframename#.#fa#.link[#index#], 'RFAdisplay', '#destinationDisplay#')")><!--- or include any responsibilities --->
					<cfelse>
						<cfset tmp = evaluate("ArrayAppend(application.#attributes.wireframename#.#fa#.content, StructNew())")>					    
					    <cfset index = evaluate ("ArrayLen(application.#attributes.wireframename#.#fa#.content)")>							
						<cfif left(aLine, 1) IS ';'>	    
						    <cfset displayString = "Comment">
						<cfelse>
							<cfset displayString = Trim( GetToken( aLine, 1, ':=' ) )>
						    <cfset displayString = replace(displayString , "'", "''", "all")>
						</cfif>
						<cfset tmp = evaluate("structinsert(application.#attributes.wireframename#.#fa#.content[#index#], 'display', '#displayString#')")>							
						<cfif left(aLine, 1) IS ';'>
						    <cfset displayString = replace(aline, ";", "")>
						<cfelse>
							<cfset displayString = Trim( GetToken( aLine, 2, ':=' ) )>
						</cfif>
						<cfset displayString = replace(displayString , "'", "''", "all")>
					    <cfset tmp = evaluate("structinsert(application.#attributes.wireframename#.#fa#.content[#index#], 'content', '#DisplayString#')")>
					</cfif>
					<!--- /include RFAs or responsibilities --->
				<cfelse>
					<!--- /if i'm not in an include section --->				
					<cfif GetToken( aLine, 1, ' ' ) is "include">					    
					    <cfset nextRow = Evaluate( ArrayLen( faIncludes ) + 1 )>					    
					    <cfset faIncludes[nextRow][1] =  fa >					    
					    <cfset faIncludes[nextRow][2] =  GetToken( aLine, 2, ' ' )>
					</cfif>
				</cfif>
				<!--- /if i'm not in an include section --->
			</cfif>
			<!--- /if i don't find a new fa --->
		</cfloop>
	</cfif>
</cflock>

<!---
$Log: act_checkdata.cfm,v $
Revision 1.0  2002-04-26 21:07:19+10  leeb
Initial revision

Revision 1.5  2001/08/22 13:58:56  leeborkman
Removed the extraneous copy of the XML spec

Revision 1.4  2001/08/22 13:49:47  leeborkman
Added a first XML-FuseDoc spec for the current data-structure.  The data-structure obviously needs improving, or at least some more meaningful names.

Revision 1.3  2001/08/21 13:26:58  leeborkman
Added CVS Log block to the bottom of each file

--->
