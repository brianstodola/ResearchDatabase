<cfsilent>
<!--- -->
<?xml version="1.0" encoding="UTF-8"?>
<!-- edited with XML Spy v3.5 NT (http://www.xmlspy.com) by John Beynon (ERA Technology Ltd) -->
<!DOCTYPE fusedoc SYSTEM "C:\Documents and Settings\jbeynon\Desktop\Fusedoc.dtd">
<fusedoc fuse="selectwireframe">
	<responsibilities>
		I retrieve the directory listings from attributes.fullwireframedir directory.
	</responsibilities>
	<properties>
		<history author="John Beynon" date="19/08/2001" email="john.beynon@era.co.uk"/>
		<note>Code built on Kevin Roche's wirelist snippet</note>
	</properties>
	<io>
		<in>
			<string name="fullwireframedir" scope="attributes"/>
		</in>
		<out>
			<list name="lFileList" scope="variables" comments="List of wireframe files."/>
			<string name="filebase" scope="variables"/>
		</out>
	</io>
</fusedoc>
--->

<!--- Retrieve directory listings --->
<cfdirectory action="LIST" directory="#attributes.fullwireframedir#" name="wireframeList" filter="*.wir">

<!--- Output result of the directory contents --->
<cfset lFileList = "">
<cfloop query="wireframelist">
	<!--- Determine individual file names --->
	<cfif wireframelist.type is "file">
	<!--- remove info after dots in directory listing--->
	<cfset filename = ListDeleteAt(wireframelist.name, ListLen(Wireframelist.Name, "."),".")>
	<!--- remove history files with _ in them --->
		<cfif filename contains "_">
		<cfset filebase = ListDeleteAt(wireframelist.name, Listlen(wireframelist.name, "_"), "_")>
		<cfelse>
		<!--- not a history file so set filebase information --->
		<cfset filebase = filename>
		</cfif>

		<!--- Create new list containing only the filebase information --->
		<cfif NOT ListContains(lFileList, filebase)>
		<cfset lFileList = ListAppend(lFileList, filebase)>
		</cfif>
	</cfif>
</cfloop>
<!---
$Log: out_wirelist.cfm,v $
Revision 1.0  2002-04-26 21:07:40+10  leeb
Initial revision

Revision 1.3  2001/09/07 06:35:57  leeborkman
Added CVS Log at bottom of the code

--->
</cfsilent>
