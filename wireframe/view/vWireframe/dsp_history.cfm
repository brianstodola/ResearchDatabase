<cfsilent>
<!--- -->
<?xml version="1.0" encoding="UTF-16"?>
<fusedoc fuse="$RCSfile$" language="ColdFusion" specification="2.0">
	<responsibilities>
		I display a list of the previous versions of the datafile,
		with links to revert and delete.
	</responsibilities>
	<properties>
		<history author="Lee Bjork Borkman" email="bjork@bjork.net" type="Create" date="23-Feb-2001" role="Designer"/>
		<history author="Lee Bjork Borkman" email="bjork@bjork.net" type="Update" date="19-Apr-2001" role="FuseCoder">
			Amended for use of special chars in page names,
  			and to stop exposing full server paths
		</history>
		<property name="licence" value="See licence.txt" />
		<property name="version" value="$Revision$" />
		<property name="lastupdated" value="$Date$" />
		<property name="updatedby" value="$Author$" />
	</properties>
	<io>
		<in>
			<string name="XFA.previewVersion"/>
			<string name="XFA.revert"/>
			<string name="XFA.delete"/>
			<string name="page.width" scope="request"/>
			<string name="wireframedir" scope="attributes"/>
			<string name="wireframename" scope="attributes"/>
			<string name="desc"/>
			<recordset name="history">
				<string name="key"/>
				<string name="size"/>
				<string name="self"/>
				<string name="jsdesc"/>
			</recordset>
		</in>
		<out>
			<string name="key"/>
			<string name="desc"/>
			<string name="jsdesc"/>
		</out>
	</io>
</fusedoc>
 --->
</cfsilent>

<cfoutput>
	<table border="1" width="#request.page.width#" cellspacing="0" cellpadding="3">
		<tr>
			<th>Version</th>
			<th>Description</th>
			<th>Size</th>
			<th>Preview</th>
			<th>Revert</th>
			<th>Delete</th>
		</tr> 
	    <cfset key = attributes.wireframename>		    
	    <cfset desc = rereplace(evaluate("descriptions." & key), '"', "", "all")>		    
	    <cfset desc = rereplace(desc, "'", "", "all")>
		<tr>
			<td>Current</td>
			<td>#evaluate("descriptions." & key)#&nbsp;</td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
		</tr>
</cfoutput>
<cfoutput query="history">
	<cfset key = replace(name, ".wir", "")>
	<cfif key IS NOT attributes.wireframename>
	    <cfset desc = rereplace(evaluate("descriptions." & key), '"', "", "all")>
	    <cfset desc = rereplace(desc, "'", "", "all")>
		<tr>
			<td>						
				<cfif key IS attributes.wireframename>
					Current
				<cfelse>
					#key#
				</cfif>
			</td>
			<td>#evaluate("descriptions." & key)#&nbsp;</td>
			<td align="right">#size#</td>
			<td>						
				<cfif key IS NOT attributes.wireframename>
					<a href="#self#?fuseaction=#XFA.previewVersion#&wireframedir=#attributes.wireframedir#&wireframename=#key#" target="#key#">Preview</a>
				<cfelse>
					&nbsp;
				</cfif>
			</td>
			<td>						
				<cfif key IS NOT attributes.wireframename>
					<a href="#self#?fuseaction=#XFA.revert#&version=#key#&wireframedir=#attributes.wireframedir#&wireframename=#attributes.wireframename#">Revert</a>
				<cfelse>
					&nbsp;
				</cfif>
			</td>
			<td>						
				<cfif key IS NOT attributes.wireframename>					    
				    <cfset jsdesc=rereplace(desc, "[^a-zA-Z1-9 \.,;:]", " ", "all")>
					<a href="#self#?fuseaction=#XFA.delete#&wireframedir=#attributes.wireframedir#&wireframename=#attributes.wireframename#&version=#key#" onclick="return(confirm('Are you sure you wish to delete version #key#?:\n\n#jsdesc#'))">Delete</a>
				<cfelse>
					&nbsp;
				</cfif>
			</td>
		</tr>
	</cfif>
</cfoutput>
<cfoutput>
	</table>
	<p>
</cfoutput>
<cfsilent>
<!---
$Log: out_history.cfm,v $
Revision 1.0  2002-04-26 21:07:38+10  leeb
Initial revision

Revision 1.3  2001/08/21 13:26:58  leeborkman
Added CVS Log block to the bottom of each file

--->
</cfsilent>
