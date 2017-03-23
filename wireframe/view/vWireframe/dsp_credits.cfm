<cfsilent>
<!--- -->
<?xml version="1.0" encoding="UTF-16"?>
<fusedoc fuse="$RCSfile$" language="ColdFusion" specification="2.0">
	<responsibilities>
		I display the credits text which tells the user who buit the application.
	</responsibilities>
	<properties>
		<property name="licence" value="See licence.txt" />
		<property name="version" value="$Revision$" />
		<property name="lastupdated" value="$Date$" />
		<property name="updatedby" value="$Author$" />
	</properties>
	<io>
		<in>
		</in>
		<out>
		</out>
	</io>
</fusedoc>
 --->
</cfsilent>
<cfoutput>
	<br />
	<table border="0" cellpadding="5" cellspacing="0" width="#request.page.width#">
		<tr>
			<td>
				<p>The original idea for WireFraming was conceived by <a href="http://www.halhelms.com" target="hal">Hal Helms</a>.
				The technique was intended as a fundamental aspect of Hal's eXtended FuseBox (XFB) methodology. 
				Hal developed the format of the wireframe data-file, and also built the first WireFrame Viewer.</p>
				
				<p>Hal's WireFrame Viewer was then amended by <a href="http://bjork.net" target="bjork">Lee Bjork Borkman</a>,
				who removed the need for a back-end database, and added various features suggested by Hal and by the FuseBox
				community, including the ability to edit the wireframe data-file directly online.</p>
				
				<p>Suggestions and enhancements continued to flow from the FuseBox community, so it was decided 
				to launch the WireFrame Viewer/Editor as an Open Source project
				(<a href="http://sourceforge.net/projects/wireframetool/" target="sourceforge">http://sourceforge.net/projects/wireframetool/</a>).</p>

				<p>This version of the tool was converted from Fusebox 3 to Fusebox 5 by <a href="www.objectiveinternet.com" target="_blank">Kevin Roche</a>.</p>
				
				<p>For their critique, their suggestions, and their contributions, many thanks to:
				<ul>
					<li>Steve Nelson;
					<li>Patrick McElhaney;
					<li>Brian Shearer;
					<li>Timothy Heald;
					<li>John Quarto-vonTivadar;
					<li>Peter Robertson;
					<li>Kevin Roche;
					<li>John Beynon; and
					<li>the entire FuseBox community.
				</ul>
				</p>
			</td>
		</tr>
	</table>
</cfoutput>
<!---
$Log: out_credits.cfm,v $
Revision 1.0  2002-04-26 21:07:37+10  leeb
Initial revision

Revision 1.4  2001/09/07 06:26:14  leeborkman
Added Kevin Roche to the credits

Revision 1.3  2001/09/06 13:21:43  jabeynon
added Steve Nelson to credits list

Revision 1.2  2001/08/21 13:26:58  leeborkman
Added CVS Log block to the bottom of each file
--->
