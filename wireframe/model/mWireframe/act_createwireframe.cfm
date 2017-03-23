<cfsilent>
<!--- -->
<fusedoc fuse="act_createwireframe.cfm">
	<responsibilities>
		I create a new wireframe by copying the template.wir
	</responsibilities>
	<properties>
		<history type="Update" date="23-Apr-2007" author="Gavin Baumanis" role="Fusecoder" email="gavin@thespidernet.com">
			Stripped invalid characters from new wireframe names.
				[space],['],[.],[#],[_],[/],[\],[?],[<],[>],[-]
		</history>
	</properties>
	<io>
		<in>
			<string name="fullwireframedir" scope="attributes"/>
			<string name="newwirename" scope="attributes"/>
			<file name="#attributes.fullwireframedir#\template.wir" />
		</in>
		<out>
			<file name="#attributes.fullwireframedir#\#attributes.newwirename#.wir" />
		</out>
	</io>
</fusedoc>
--->

<!--- strip invalid "variable" characters from filename. This stops problems later of not being able to read a filename into a coldfusion variable - despite the filename being valid. --->
<cfset attributes.newwirename = #replacelist(attributes.newwirename," ,',.,##,_,/,\,?,<,>,-","")#>

<cffile action="copy" source="#attributes.fullwireframedir#\template.wir" destination="#attributes.fullwireframedir#\#attributes.newwirename#.wir">

<!--- 
$Log: act_createwireframe.cfm,v $
Revision 1.0  2002-04-26 21:07:24+10  leeb
Initial revision

Revision 1.1  2001/09/06 14:19:36  jabeynon
amended files adding ADMIN section to out_smallmenu.cfm to allow selecting and deleting of Wireframes
 
---> 
</cfsilent>
