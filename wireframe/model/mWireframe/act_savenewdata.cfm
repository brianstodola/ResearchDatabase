<cfsilent>
<!--- -->
<fusedoc fuse="act_savenewdata.cfm">
	<responsibilities>
		I save a copy of the current wireframe datafile.
	</responsibilities>
	<properties>
		<history author="Lee Bjork Borkman" email="bjork@bjork.net" role="Designer" type="Create"/>
		<property name="licence" value="See licence.txt" />
		<property name="version" value="$Revision$" />
		<property name="lastupdated" value="$Date$" />
		<property name="updatedby" value="$Author$" />
	</properties>
	<io>
		<in>
			<string name="changedescription" default="created by gui" optional="Yes" scope="attributes"/>
			<string name="fullwireframedir" scope="attributes"/>
			<string name="wireframename" scope="attributes"/>
			<string name="os.delimiter" scope="request"/>
			
			<string name="datafile" scope="attributes"/>
		</in>
		<out>
			<file name="#attributes.fullwireframedir##request.os.delimiter##attributes.wireframename#.wir"/>
		</out>
	</io>
</fusedoc>
--->

<cfparam name="attributes.changedescription" default="Created by GUI">
<cfset attributes.datafile = rereplace(attributes.datafile, "[#chr(10)##chr(13)#][#chr(10)##chr(13)#]+", "#chr(10)#", "all")>
<cfset setvariable("application." & attributes.wireframeName & ".df", attributes.datafile)>
<cfset attributes.datafile = attributes.datafile & "#chr(10)#[[:changedescription:]]#chr(10)##attributes.changedescription#">

<cffile action="WRITE"
        file="#attributes.fullwireframedir##request.os.delimiter##attributes.wireframename#.wir"
        output="#attributes.datafile#"
        addnewline="Yes">

<!---
  $Log: act_savenewdata.cfm,v $
  Revision 1.0  2002-04-26 21:07:26+10  leeb
  Initial revision

  Revision 1.3  2001/08/21 13:26:58  leeborkman
  Added CVS Log block to the bottom of each file

--->
</cfsilent>
