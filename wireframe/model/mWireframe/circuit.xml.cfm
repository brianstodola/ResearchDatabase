<?xml version="1.0" encoding="UTF-8"?>
<circuit access="public"> 
	<prefuseaction callsuper="false">
		
	</prefuseaction>
	<postfuseaction callsuper="false">
		
	</postfuseaction>
  
	<!--
    	Description: 
		I read the wireframe file and create the in memory data structure.
	-->
	<fuseaction name="checkdata">
		<include template="act_checkdata.cfm" />
		<include template="act_addincludes.cfm" />
	</fuseaction>

	<!--
    	Description: 
		I clear the selected page from the in memory structure.
	-->
	<fuseaction name="clearpage">
		<include template="act_clearpage.cfm" />
	</fuseaction>

	<!--
    	Description: 
		I process the data from the edit page form and create the information for the page in memory.
	-->
	<fuseaction name="createpage">
		<include template="act_createpage.cfm" />
	</fuseaction>

	<!--
    	Description: 
		I create a text version of the in memory structure.
	-->
	<fuseaction name="make_datafile">
		<include template="qry_datafile.cfm" />
	</fuseaction>
	
	<!--
    	Description: 
		I create a text version of the in memory structure.
	-->
	<fuseaction name="save_datafile">
		<include template="act_savenewdata.cfm" />
	</fuseaction>
	
	<!--
    	Description: 
		I generate a switchblock for the wireframe.
	-->
	<fuseaction name="generate">
		<include template="act_switchblock.cfm" />
	</fuseaction>
	
	<!--
    	Description: 
		I save a copy of the current wireframe datafile, with datestamped suffix.
	-->
	<fuseaction name="archivedata">
		<include template="act_archivedata.cfm" />
	</fuseaction>
	
	<!--
    	Description: 
		I save a copy of the current wireframe datafile.
	-->
	<fuseaction name="savenewdata">
		<include template="act_savenewdata.cfm" />
	</fuseaction>
	
	<!--
    	Description: 
		I display the version history of the wireframe.
	-->
	<fuseaction name="history">
		<include template="qry_history.cfm" />
		<include template="act_getdescriptions.cfm" />
	</fuseaction>
	
	<!--
    	Description: 
		I save a an earlier version datafile over current wireframe datafile.
	-->
	<fuseaction name="saveolddata">
		<include template="act_saveolddata.cfm" />
	</fuseaction>
	
	<!--
    	Description: 
		I delete a an earlier version wireframe file from the history.
	-->
	<fuseaction name="delete">
		<include template="act_deletedata.cfm" />
	</fuseaction>
	
	<!--
    	Description: 
		I get the list of current wireframes.
	-->
	<fuseaction name="wirelist">
		<include template="qry_wirelist.cfm" />
	</fuseaction>
	
	<!--
    	Description: 
		I create a new wireframe with the name supplied.
	-->
	<fuseaction name="createnewwireframe">
		<include template="act_createwireframe.cfm" />
	</fuseaction>
  
</circuit> 
