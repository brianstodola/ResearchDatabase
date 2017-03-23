<!---@ Description: Fuse to display a small text-linked  Menu  --->
<!---@ Designer: Lee Borkman  --->
<cfoutput>
	<table border="0" cellpadding="0" cellspacing="0" width="#request.page.width#">
		<tr>
			<td>						
				<cfif NOT ListFind("help,credits",attributes.fuseaction)>
					<a href="#self#?fuseaction=#XFA.quickmap#&wireframename=#request.wireframename#&wireframedir=#request.wireframedir#">
						<font size=-2>Map</font>
					</a>&nbsp;&nbsp;&nbsp;&nbsp;
					<a href="#self#?fuseaction=#XFA.editform#&wireframename=#request.wireframename#&wireframedir=#request.wireframedir#">
					   	<font size=-2>Edit&nbsp;All</font>
					</a>&nbsp;&nbsp;&nbsp;&nbsp;
					<a href="#self#?fuseaction=#XFA.history#&wireframename=#request.wireframename#&wireframedir=#request.wireframedir#">
					   	<font size=-2>History</font>
					</a>&nbsp;&nbsp;&nbsp;&nbsp;
					<a href="#self#?fuseaction=#XFA.generate#&wireframename=#request.wireframename#&wireframedir=#request.wireframedir#">
					   	<font size=-2>Generate Code</font>
					</a>
				<cfelse>
					&nbsp;
				</cfif>
			</td>
			<td align="right">
				<a href="#self#?fuseaction=#XFA.selectorcreateform#&wireframename=#request.wireframename#&wireframedir=#request.wireframedir#">
			   		<font size=-2>Admin</font>
				</a>&nbsp;&nbsp;&nbsp;&nbsp;
				<a href="#self#?fuseaction=#XFA.help#&context=#attributes.fuseaction#&wireframename=#request.wireframename#&wireframedir=#request.wireframedir#" target="wireframehelp">
			   		<font size=-2>Help</font>
				</a>&nbsp;&nbsp;&nbsp;&nbsp;
				<a href="#self#?fuseaction=#XFA.credits#&wireframename=#request.wireframename#&wireframedir=#request.wireframedir#" target="wireframecredits">
			   		<font size=-2>Credits</font>
				</a>
			</td>
		</tr>
	</table>
</cfoutput>
<!---
$Log: out_smallmenu.cfm,v $
Revision 1.1  2002-04-27 22:55:24+10  leeb
First GUI beta demo-ed but not released on bjork.net

Revision 1.0  2002-04-26 21:07:28+10  leeb
Initial revision

Revision 1.6  2001/09/07 06:30:38  leeborkman
Maded Admin link point to "selectorcreateform", and added extra parameters for wireframename and  data directory

Revision 1.5  2001/09/06 14:13:34  jabeynon
amended files adding ADMIN section to out_smallmenu.cfm to allow selecting and deleting of Wireframes

--->
