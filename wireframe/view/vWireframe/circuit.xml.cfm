<?xml version="1.0" encoding="UTF-8"?>
<circuit access="public"> 
	<prefuseaction callsuper="false">
	</prefuseaction>
	<postfuseaction callsuper="false">
	</postfuseaction>
  
	<!--
    	Description: 
		I display a map of the circuit with a section for each page and the links to other pages.
	-->
	<fuseaction name="quickmap">
		<include template="dsp_quickmap.cfm" />
	</fuseaction>

	<!--
    	Description: 
		I display a form with the details of a single fuseaction.
		I allow the user to change the description or any of the links.
	-->
	<fuseaction name="editpage">
		<include template="dsp_page.cfm" />
	</fuseaction>
	
	<!--
    	Description: 
		I display a map of the circuit with a section for each page and the links to other pages.
		This is displayed without links within the application so that it can be pasted easily into a document.
	-->
	<fuseaction name="previewVersion">
		<set name="attributes.dolinks" value="false" />
		<include template="out_quickmap.cfm" contentvariable="request.page.maincontent" append="true" />
		<set name="attributes.showlayout" value="false" />
	</fuseaction>
	
	<!--
    	Description: 
		I display a simulation of the page.
		On the simulation you can click links to go to other pages.
	-->
	<fuseaction name="showpage">
		<include template="dsp_pagestate.cfm" />
	</fuseaction>
	
	<!--
    	Description: 
		I display a form with a textarea allowing the user to edit the wireframe file.
	-->
	<fuseaction name="editform">
		<include template="dsp_datafile.cfm" />
	</fuseaction>
	
	<!--
    	Description: 
		I display the version history of the wireframe.
	-->
	<fuseaction name="history">
		<include template="dsp_history.cfm" />
	</fuseaction>
	
	<!--
    	Description: 
		I display the help page.
	-->
	<fuseaction name="help">
		<include template="dsp_help.cfm" />
	</fuseaction>
	
	<!--
    	Description: 
		I display the credits page.
	-->
	<fuseaction name="credits">
		<include template="dsp_credits.cfm" />
	</fuseaction>
	
	<!--
    	Description: 
		I display the list of current wireframes allowing the user to select a wireframe.
		I display a form which allows the user to enter a name for a new wireframe.
	-->
	<fuseaction name="selectorcreateform">
		<include template="dsp_wirelist.cfm" />
		<include template="dsp_createwire.cfm" />
	</fuseaction>
	
	<!--
    	Description: 
		I display the generated code.
	-->
	<fuseaction name="displaycode">
		<include template="dsp_displaycode.cfm" />
	</fuseaction>
  
</circuit> 
