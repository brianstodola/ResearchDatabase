<!--- -->
<?xml version="1.0" encoding="UTF-8"?>
<!-- edited with XML Spy v3.5 NT (http://www.xmlspy.com) by John Beynon (ERA Technology Ltd) -->
<!DOCTYPE fusedoc SYSTEM "C:\Documents and Settings\jbeynon\Desktop\Fusedoc.dtd">
<fusedoc fuse="selectwireframe">
	<responsibilities>
		I display the wireframe files available in a list format.
	</responsibilities>
	<properties>
		<history author="John Beynon" date="19/08/2001" email="john.beynon@era.co.uk"/>
		<note>Code built on Kevin Roche's wirelist snippet</note>
	</properties>
	<io>
		<in>
			<list name="lFileList" scope="variables" comments="List of wireframe files."/>
		</in>
		<out>
			<string name="wireframename" scope="url"/>
		</out>
	</io>
</fusedoc>
--->
<cfif wireframelist.recordcount gt 0>
	<cfoutput><br /><b>Select an existing WireFrame:</b>
	<ul>
		<!--- Loop through the files --->
		<cfloop index="thisFile" list="#lFileList#">
			<!--- Display clickable links to each of the wireframes --->
			<li><a href="#self#?fuseaction=#XFA.quickmap#&wireframename=#thisfile#">#thisfile#</a>
		</cfloop>
	</ul>
	</cfoutput>
</cfif>
<!---
$Log: out_wirelist.cfm,v $
Revision 1.0  2002-04-26 21:07:40+10  leeb
Initial revision

Revision 1.3  2001/09/07 06:35:57  leeborkman
Added CVS Log at bottom of the code

--->

