<cfsilent>
<!--- -->
<fusedoc fuse="act_deletedata.cfm">
	<responsibilities>
		I delete a an earlier version wireframe file from the history.
	</responsibilities>
	<properties>
		<history author="Lee Bjork Borkman" email="bjork@bjork.net" role="Architect" type="Create" date="23-Feb-2001" />
		<history author="Lee Bjork Borkman" email="bjork@bjork.net" role="Architect" type="Update" date="19-Apr-2001">
			Amended for use of special chars in page names, and to stop exposing full server paths.
		</history>
		<property name="licence" value="See licence.txt" />
		<property name="version" value="$Revision$" />
		<property name="lastupdated" value="$Date$" />
		<property name="updatedby" value="$Author$" />
	</properties>
	<io>
		<in>
			<string name="fullwireframedir" scope="attributes"/>
		</in>
		<out>
		</out>
	</io>
</fusedoc>
--->

<cffile action="DELETE" file="#attributes.fullwireframedir##request.os.delimiter##attributes.version#.wir">

<!---
$Log: act_deletedata.cfm,v $
Revision 1.0  2002-04-26 21:07:24+10  leeb
Initial revision

Revision 1.3  2001/08/21 13:26:58  leeborkman
Added CVS Log block to the bottom of each file

--->
</cfsilent>
