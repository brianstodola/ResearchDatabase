<cfsilent>
<!--- -->
<?xml version="1.0" encoding="UTF-16"?>
<fusedoc fuse="$RCSfile$" language="ColdFusion" specification="2.0">
	<responsibilities>
		I display the help page.
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
			    <cfparam name="attributes.context" default="help">
				
				<!--- Choose the help for the page that user came from --->
			    <cfswitch expression="#attributes.context#">
					<cfcase value="wireframe.help,wireframe.credits">
					</cfcase>
					
					<cfcase value="wireframe.quickmap,wireframe.previewVersion">
						<h3>QuickMap</h3>
						<p>The QuickMap shows a summary view of the current WireFrame.</p>
						<p>
						  <ul>
			              	<li>The left column displays the text description of each page/state/function.
			              	<li>The right hand column shows the Exits from each page/state/function, and the corresponding destinations.
			              	<li>"Menu" items are separated from the "main flow" Exits/Destinations by a dotted line.
			              	<li>Click on any Destination to show that page/state/function.
						  </ul>
						</p>
					</cfcase>
					<cfcase value="wireframe.generate">
						<h3>Generate Code</h3>
						<p>Generates a basic ColdFusion/FuseBox CFSWITCH block based on the current wireframe.</p>
						<p>
						  <ul>
							<li>Maps each page/state/function to a fuseaction
							<li>Maps each Exit=Destination pair to an XFA (event-handler) definition
							<li>Maps the description of each page/state/function to a comment
			              </ul>
						</p>  
					</cfcase>
					<cfcase value="wireframe.showpage">
						<h3>Show page/state/function</h3>
						<p>Shows the detail of a single page/state/function</p>
						<p>
						  <ul>
							<li>Displays the title
							<li>Displays the text description
							<li>Displays the text of each Exit, linked to the corresponding Destinations
						  </ul>
						</p>
					</cfcase>
					<cfcase value="wireframe.editform">
						<h3>Edit</h3>
						<p>Use this form to edit the wireframe's text data-file.</p>
						<p>
						  <ul>
							<li>The "Click to add another page/state" link adds a new blank page/state/function to the bottom of the datafile.
							<li>The text description must be included on a single line, beginning with a ";" character.
							<li>Exit/Destination pairs follow, and are of the form "Exit Text = Destination Name" or "menu.Exit Text = Destination Name"
							<li>Include a brief label or description of the changes you have made in the supplied text box before submitting the form.  
							This will later be used when showing the History of your wireframe.
						  </ul>
						</p>
					</cfcase>
					<cfcase value="wireframe.history,wireframe.revert,wireframe.delete">
						<h3>History</h3>
						<p>Shows a list of all previous version of the current wireframe</p>
						<p>
						  <ul>
							<li>Shows the description/label supplied for each version
							<li>Shows the size of each version
							<li>Shows links to Preview each version - ie, display a QuickMap of the selected version
							<li>Shows links to Revert to each version - ie, begin editing/viewing the selected version
							<li>Shows links to Delete each version - ie, remove it permanently from the historical archive
						  </ul>
						</p>
					</cfcase>
					<cfcase value="wireframe.admin">
						<h3>Admin</h3>
						<p>Options available for Wireframe administration.</p>
						<p>
						  <ul>
							<li>Select a wireframe to view/edit
							<li>Create a new wireframe
						  </ul>
						</p>
					</cfcase>
					<cfcase value="wireframe.selectorcreateform">
						<h3>Select or Create a Wireframe</h3>
						<p>Displays all wireframes which exist in the wireframe data directory. 
						Select which wireframe to open by clicking on the name.</p>
						<p>You can also create a new wireframe by entering a new name in the box. 
						You can then edit the template wireframe and adding your page information.
						Do not use a .wir suffix after the name, it will be added automatically.</p>
					</cfcase>
					<cfdefaultcase>
					</cfdefaultcase>
				</cfswitch>
				<h3>General Information</h3>
				<p>The WireFrame Viewer/Editor is a tool for the gathering of				                                                                                                                                            functional				                                                                                                                                                   
				requirements. You and your client can sit down with 
				it and decide WHAT you want the the proposed application to do.  You
				will get to describe each stage/page/function of the application in English
				or Spanish or any natural language you like.  You will also define all of
				the ways the application can get from one state to another state, using
				Exit=Destination pairs.</p>
				<p>Your clients can edit the wireframe data, with just a few minutes' training, and
				they can browse through the proposed application, looking at each state, until they
				are happy that the wireframe correctly describes the application they
				want built.  At this point, the wireframe datafile can be printed, or the QuickMap of the
				wireframe, and signed-off by all parties.</p>
				<p>At no time during the wireframing phase is the look of the application
				considered.</p>
				<p>The wireframe becomes part of your development agreement.  Use it as the
				basis for your prototype, and later as the basis for your actual code.  Use
				it for doing function-point estimation, as it gives a very good indication
				about the number, type, and complexity of the various application functions.
				</p>
				<br />
			</td>
		</tr>
	</table>
</cfoutput>
<!---
  $Log: out_help.cfm,v $
  Revision 1.0  2002-04-26 21:07:37+10  leeb
  Initial revision

  Revision 1.3  2001/09/06 22:00:17  jabeynon
  added context sensitive help for admin pages

  Revision 1.2  2001/08/21 13:26:58  leeborkman
  Added CVS Log block to the bottom of each file

--->
