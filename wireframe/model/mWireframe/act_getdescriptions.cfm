<cfsilent>
<!--- -->
<?xml version="1.0" encoding="UTF-16"?>
<fusedoc fuse="$RCSfile$" language="ColdFusion" specification="2.0">
	<responsibilities>
		I get a list of the previous versions of the datafile, with links to revert and delete.
	</responsibilities>
	<properties>
		<history author="Lee Bjork Borkman" email="bjork@bjork.net" type="Create" date="23-Feb-2001" role="Designer"/>
		<history author="Lee Bjork Borkman" email="bjork@bjork.net" type="Update" date="19-Apr-2001" role="FuseCoder">
			Amended for use of special chars in page names,	and to stop exposing full server paths
		</history>
		<property name="licence" value="See licence.txt" />
		<property name="version" value="$Revision$" />
		<property name="lastupdated" value="$Date$" />
		<property name="updatedby" value="$Author$" />
	</properties>
	<io>
		<in>
			<string name="fullwireframedir" scope="attributes"/>
			<string name="name"/>
			<recordset name="history">
				<number name="descindex"/>
			</recordset>
		</in>
		<out>
			<struct name="descriptions"/>
			<string name="content"/>
		</out>
	</io>
</fusedoc>
--->

<cfset descriptions = StructNew()>
<cfoutput query="history">
	<cffile action="READ" file="#attributes.fullwireframedir##request.os.delimiter##name#" variable="content">
	<cfset key = replace(name, ".wir", "")>	    
	<cfset descindex = 	find("[[:changedescription:]]", content)>			
	<cfif descindex>		    
		<cfset content = right(content, len(content)-descindex+1)>		    
		<cfset tmp = StructInsert(descriptions, key, trim(rereplace(content, ".*\[\[\:changedescription\:\]\]", "")), "true") >
	<cfelse>
		<cfset tmp = StructInsert(descriptions, key, "", "true")>
	</cfif>
</cfoutput>

<!---
$Log: act_getdescriptions.cfm,v $
Revision 1.0  2002-04-26 21:07:25+10  leeb
Initial revision

Revision 1.4  2001/08/21 13:26:58  leeborkman
Added CVS Log block to the bottom of each file

--->
</cfsilent>
