<cfsilent>
<!--- -->
<?xml version="1.0" encoding="UTF-16"?>
<fusedoc fuse="$RCSfile$" language="ColdFusion" specification="2.0">
	<responsibilities>
		I display a form to allow the user to enter a new wireframe name.
	</responsibilities>
	<properties>
		<property name="licence" value="See licence.txt" />
		<property name="version" value="$Revision$" />
		<property name="lastupdated" value="$Date$" />
		<property name="updatedby" value="$Author$" />
	</properties>
	<io>
		<in>
			<string name="self" scope="variables"/>
			<string name="XFA.createnewwireframe" scope="variables"/>
		</in>
		<out>
			<string name="fuseaction" scope="formOrUrl" />
			<string name="newwirename" scope="formOrUrl" />
		</out>
	</io>
</fusedoc>
 ---></cfsilent>

<cfoutput>
	<form method="post" action="#self#">
	
		<b>Create a new WireFrame:</b><br />(enter the name of the new WireFrame, without any extension)<br /><br />
		<input type="text" name="newwirename">
		<input type="submit" value="Create WireFrame">
		<input type="hidden" name="fuseaction" value="#XFA.createnewwireframe#">
	
	</form>
</cfoutput>
<!---
$Log: out_createwire.cfm,v $
Revision 1.0  2002-04-26 21:07:36+10  leeb
Initial revision

Revision 1.3  2001/09/07 06:26:46  leeborkman
Minor formatting changes

Revision 1.2  2001/09/06 22:00:17  jabeynon
added context sensitive help for admin pages

Revision 1.1  2001/09/06 14:19:36  jabeynon
amended files adding ADMIN section to out_smallmenu.cfm to allow selecting and deleting of Wireframes

--->
