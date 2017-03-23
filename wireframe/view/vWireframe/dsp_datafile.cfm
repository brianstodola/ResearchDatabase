<cfsilent>
<!--- -->
<?xml version="1.0" encoding="UTF-16"?>
<fusedoc fuse="$RCSfile$" language="ColdFusion" specification="2.0">
    <responsibilities>
		I display a form with a text box for editing the current datafile.
		I also display a field for a brief Change Desription.
	</responsibilities>
    <properties>
    	<history author="Lee Bjork Borkman" email="bjork@bjork.net" type="Create" date="23-Feb-2001" role="Designer"/>
    	<history author="Lee Bjork Borkman" email="bjork@bjork.net" type="Create" date="23-Feb-2001" role="Fusecoder"/>
    	<history author="Lee Bjork Borkman" email="bjork@bjork.net" type="Update" date="19-Apr-2001" role="Fusecoder">
			Amended for use of special chars in page names, and to stop exposing full server paths.
		</history>
	    <property name="licence" value="See licence.txt"/>
	    <property name="version" value="$Revision$"/>
	    <property name="lastupdated" value="$Date$"/>
	    <property name="updatedby" value="$Author$"/>
	</properties>
    <io>
    	<in>
			<string name="XFA.processnewdata" scope="variables" />
			<string name="self" scope="variables" />
			<string name="data" scope="variables"/>
			<string name="#attributes.wireframeName#.df" scope="application" comments="Contains a copy of the data file for the wireframe."/>
			
			<string name="wireframename" scope="attributes" />
			<string name="wireframedir" scope="attributes" />
		</in>
		<out>
			<string name="fuseaction" scope="formOrUrl" />
			<string name="wireframename" scope="formOrUrl" />
			<string name="wireframedir" scope="formOrUrl" />
    		<string name="datafile" scope="formOrUrl" comments="Modified version of the data file."/>
    		<string name="ChangeDescription" scope="formOrUrl" comments="Descrition of Mods made."/>
		</out>
	</io>
</fusedoc>
--->
</cfsilent>    
<cfset data = evaluate("application." & attributes.wireframeName & ".df")>    
<cfset data = rereplace(data, "[#chr(10)##chr(13)#]\[", "#chr(10)##chr(13)#---------------------------------------------------------#chr(10)##chr(13)#[", "all")>   
  
<cfoutput>
	<script>function addpagestate() {
		document.datafileform.datafile.value = document.datafileform.datafile.value + "\n---------------------------------------------------------\n[TITLE]\n;BLURB\nlink = XFA\n";
	}
	</script>

	<hr width="#request.page.width#" align="left">
	<h3>Edit the wireframe datafile for "#attributes.wireframename#":</h3>
	Data-file<br>	                    
	<form name="datafileform" id="datafileform" action="#self#" method="post">
		<input type="Hidden" name="fuseaction" value="#XFA.processnewdata#" />
		<input type="Hidden" name="wireframename" value="#attributes.wireframename#" />
		<input type="Hidden" name="wireframedir" value="#attributes.wireframedir#" />
		<textarea name="datafile" cols="70" rows="25" wrap="virtual">#data#</textarea>
		<br>
		<a href="javascript:addpagestate();">Click to add another page/state</a>
		<p><h3>Describe the Change you have made:</h3>
		<textarea name="ChangeDescription" cols="70" rows="3" wrap="virtual"></textarea>
		<p>
		<input type="submit" value="SUBMIT CHANGES" />
	</form>
</cfoutput>
<cfsilent>
<!---
  $Log: in_datafile.cfm,v $
  Revision 1.0  2002-04-26 21:07:34+10  leeb
  Initial revision

  Revision 1.4  2001/08/21 13:26:58  leeborkman
  Added CVS Log block to the bottom of each file

--->
</cfsilent>
