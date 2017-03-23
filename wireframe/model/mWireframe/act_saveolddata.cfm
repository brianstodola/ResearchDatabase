<cfsilent>
<!--- -->
<fusedoc fuse="act_saveolddata.cfm">
	<responsibilities>
		I save an earlier version over current wireframe datafile.
	</responsibilities>
	<properties>
		<history author="Lee Bjork Borkman" email="bjork@bjork.net" role="Architect" type="Create" date="23-Feb-2001"/>
		<history author="Lee Bjork Borkman" email="bjork@bjork.net" role="Architect" type="Create" date="19-Apr-2001">
			Amended for use of special chars in page names, and to stop exposing full server paths.
		</history>
		<property name="licence" value="See licence.txt" />
		<property name="version" value="$Revision$" />
		<property name="lastupdated" value="$Date$" />
		<property name="updatedby" value="$Author$" />
	</properties>
	<io>
		<in>
			<string name="version" scope="attributes"/>
			<string name="wireframename" scope="attributes"/>
			<string name="fullwireframedir" scope="attributes"/>
			<file name="#attributes.fullwireframedir##request.os.delimiter##attributes.version#.wir" />
		</in>
		<out>
			<file name="#attributes.fullwireframedir##request.os.delimiter##attributes.wireframename#.wir" />
		</out>
	</io>
</fusedoc>
--->
<cffile action="COPY" 
		source="#attributes.fullwireframedir##request.os.delimiter##attributes.version#.wir" 
		destination="#attributes.fullwireframedir##request.os.delimiter##attributes.wireframename#.wir">
 
<!---
  $Log: act_saveolddata.cfm,v $
  Revision 1.0  2002-04-26 21:07:27+10  leeb
  Initial revision

  Revision 1.3  2001/08/21 13:26:58  leeborkman
  Added CVS Log block to the bottom of each file

--->
</cfsilent>
