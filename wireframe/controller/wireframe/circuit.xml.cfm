<?xml version="1.0" encoding="UTF-8"?>
<circuit access="public"> 
	<prefuseaction callsuper="false">
		<include template="fbx_settings.cfm" />
	</prefuseaction>
	<postfuseaction callsuper="false">
		<!-- Build the menu -->
		<xfa name="quickmap" value="quickmap" />
		<xfa name="editform" value="editform" />
		<xfa name="history" value="history" />
		<xfa name="generate" value="generate" />
		<xfa name="selectorcreateform" value="selectorcreateform" />
		<xfa name="help" value="help" />
		<xfa name="credits" value="credits" />
		<do action="vLayout.layout"/>
	</postfuseaction>
  
	<!--
    	Description: 
		I display a map of the circuit with a section for each page and the links to other pages.
	-->
	<fuseaction name="quickmap">
		<set name="request.page.subtitle" value="#attributes.wireframename#" />
		<xfa name="showpage" value="showpage" />
		<xfa name="editpage" value="editpage" />
		<set name="attributes.refresh" value="true" />
		<do action="mWireframe.checkdata" />
		<do action="vWireframe.quickmap" contentvariable="request.page.maincontent" append="true" />
	</fuseaction>

	<!--
    	Description: 
		I display a form with the details of a single fuseaction.
		I allow the user to change the description or any of the links.
	-->
	<fuseaction name="editpage">
		<xfa name="onSubmit" value="handle_editpage" />
		<set name="attributes.refresh" value="true" />
		<do action="mWireframe.checkdata" />
		<do action="vWireframe.editpage" contentvariable="request.page.maincontent" append="true" />
		<set name="request.page.subtitle" value="Edit Page: #pagedisplayname#" />
	</fuseaction>
	
	<!--
    	Description: 
		I handle the form submitted from editpage.
	-->
	<fuseaction name="handle_editpage">
	    <if condition="attributes.return IS 'map'" >
			<true>
	    		<xfa name="onComplete" value="quickmap" />
			</true>
			<false>
	    		<xfa name="onComplete" value="showpage" />
			</false>
	    </if>
		<do action="mWireframe.clearpage" />
		<do action="mWireframe.createpage" />
		<do action="mWireframe.make_datafile" />
		<do action="mWireframe.save_datafile" />
		<do action="mWireframe.checkdata" />
		<relocate url="#self#?fuseaction=#XFA.onComplete#&amp;wireframename=#attributes.wireframename#&amp;wireframedir=#attributes.wireframedir#&amp;page=#newpage#" />
	</fuseaction>
	
	<!--
    	Description: 
		I generate a switchblock for the wireframe.
	-->
	<fuseaction name="generate">
		<set name="request.page.subtitle" value="Fusebox code: #attributes.wireframename#" />
		<do action="mWireframe.checkdata" />
		<do action="mWireframe.generate" />
		<do action="vWireframe.displaycode" contentvariable="request.page.maincontent" append="true" />
	</fuseaction>
	
	<!--
    	Description: 
		I display a map of the circuit with a section for each page and the links to other pages.
		This is displayed without links within the application so that it can be pasted easily into a document.
	-->
	<fuseaction name="previewVersion">
		<set name="request.page.subtitle" value="Preview: #attributes.wireframename#" />
		<set name="request.page.header" value="" />
		<xfa name="showpage" value="showpage" />
		<do action="mWireframe.checkdata" />
		<set name="attributes.dolinks" value="false" />
		<do action="vWireframe.quickmap" contentvariable="request.page.maincontent" append="true" />
		<set name="attributes.showlayout" value="false" />
	</fuseaction>
	
	<!--
    	Description: 
		I display a simulation of the page.
		On the simulation you can click links to go to other pages.
	-->
	<fuseaction name="showpage">
		<set name="request.page.subtitle" value="#attributes.wireframename#" />
		<xfa name="showpage" value="showpage" />
		<xfa name="editpage" value="editpage" />
		<set name="attributes.refresh" value="true" />
		<do action="mWireframe.checkdata" />
		<do action="vWireframe.showpage" contentvariable="request.page.maincontent" append="true" />
	</fuseaction>
	
	<!--
    	Description: 
		I display a form with a textarea allowing the user to edit the wireframe file.
	-->
	<fuseaction name="editform">
		<set name="request.page.subtitle" value="Edit data: #attributes.wireframename#" />
		<xfa name="processnewdata" value="processnewdata" />
		<do action="mWireframe.checkdata" />
		<do action="vWireframe.editform" contentvariable="request.page.maincontent" append="true" />
	</fuseaction>
	
	<!--
    	Description: 
		I handle the data from editform.
	-->
	<fuseaction name="processnewdata">
		<do action="mWireframe.archivedata" />
		<do action="mWireframe.savenewdata" />
		<set name="attributes.refresh" value="true" />
		<do action="mWireframe.checkdata" />
		<relocate url="#self#?wireframename=#attributes.wireframename#&amp;wireframedir=#attributes.wireframedir#" />
	</fuseaction>
	
	<!--
    	Description: 
		I display the version history of the wireframe.
	-->
	<fuseaction name="history">
		<set name="request.page.subtitle" value="Version history: #attributes.wireframename#" />
		<xfa name="previewVersion" value="previewVersion" />
		<xfa name="revert" value="revert" />
		<xfa name="delete" value="delete" />
		<do action="mWireframe.history" />
		<do action="vWireframe.history" contentvariable="request.page.maincontent" append="true" />
	</fuseaction>
	
	<!--
    	Description: 
		I revert the current version to an earlier one in the history.
	-->
	<fuseaction name="revert">
		<do action="mWireframe.archivedata" />
		<do action="mWireframe.saveolddata" />
		<set name="attributes.refresh" value="true" />
		<do action="mWireframe.checkdata" />
		<relocate url="#self#?wireframename=#attributes.wireframename#&amp;wireframedir=#attributes.wireframedir#" />
	</fuseaction>
	
	<!--
    	Description: 
		I delete a an earlier version wireframe file from the history.
	-->
	<fuseaction name="delete">
		<xfa name="history" value="history" />
		<do action="mWireframe.delete" />
		<relocate url="#self#?fuseaction=#XFA.history#&amp;wireframename=#attributes.wireframename#&amp;wireframedir=#attributes.wireframedir#" />
	</fuseaction>
	
	<!--
    	Description: 
		I display the help page.
	-->
	<fuseaction name="help">
		<set name="request.page.subtitle" value="Help" />
		<do action="vWireframe.help" contentvariable="request.page.maincontent" append="true" />
	</fuseaction>
	
	<!--
    	Description: 
		I display the credits page.
	-->
	<fuseaction name="credits">
		<set name="request.page.subtitle" value="Credits" />
		<do action="vWireframe.credits" contentvariable="request.page.maincontent" append="true" />
	</fuseaction>
	
	<!--
    	Description: 
		I display the admin page which allows the user to select a wireframe or create a new one.
	-->
	<fuseaction name="selectorcreateform">
		<set name="request.page.subtitle" value="Select or Create a wireframe" />
		<xfa name="quickmap" value="quickmap" />
		<xfa name="createnewwireframe" value="createnewwireframe" />
		
		<do action="mWireframe.wirelist" />
		<do action="vWireframe.selectorcreateform" contentvariable="request.page.maincontent" append="true" />
	</fuseaction>
	
	<!--
    	Description: 
		I create a new wireframe with the name supplied.
	-->
	<fuseaction name="createnewwireframe">
		<do action="mWireframe.createnewwireframe" />
		<relocate url="index.cfm?wireframename=#attributes.newwirename#"/>
	</fuseaction>
  
</circuit> 
