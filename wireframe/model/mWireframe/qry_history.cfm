<!--- -->
<fusedoc fuse="qry_history.cfm">
	<responsibilities>
		I get a recordset of the wireframe history.
	</responsibilities>
	<properties>
		<history author="Lee Bjork Borkman" email="bjork@bjork.net" type="Create" date="23-Feb-2001" role="Designer"/>
	</properties>
	<io>
		<in>
			<string name="fullwireframedir" scope="attributes"/>
			<string name="wireframename" scope="attributes"/>
		</in>
		<out>
			<recordset name="history">
			</recordset>
		</out>
	</io>
</fusedoc>
--->

<cfdirectory action="LIST" 
			 directory="#attributes.fullwireframedir#" 
			 name="history" 
			 filter="#attributes.wireframename#*.wir" 
			 sort="name desc">

<!---
$Log: sel_history.cfm,v $
Revision 1.0  2002-04-26 21:07:41+10  leeb
Initial revision

Revision 1.3  2001/08/21 13:26:58  leeborkman
Added CVS Log block to the bottom of each file

--->
