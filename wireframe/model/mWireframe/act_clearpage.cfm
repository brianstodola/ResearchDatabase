<!--- -->
<fusedoc fuse="act_clearpage.cfm">
	<responsibilities>
		I clear the selected page from the in memory structure.
	</responsibilities>
	<properties>
		<history author="Hal Helms" email="hal.helms@TeamAllaire.com" type="Create" role="Author"/>
		<property name="licence" value="See licence.txt" />
		<property name="version" value="$Revision$" />
		<property name="lastupdated" value="$Date$" />
		<property name="updatedby" value="$Author$" />
	</properties>
	<io>
		<in>
			<string name="wireframename" scope="attributes"/>
			<string name="page" scope="attributes"/>
		</in>
		<out>
			<string name="#attributes.wireframename#.#attributes.page#" scope="application"/>
		</out>
	</io>
</fusedoc>
--->

<cfset "application.#attributes.wireframename#.#attributes.page#" = structNew()>
