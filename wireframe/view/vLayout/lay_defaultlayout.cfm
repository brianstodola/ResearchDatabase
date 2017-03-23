<!--- -->
<fusedoc fuse="DefaultLayout.cfm">
	<responsibilities>
		I output the page layout with the value of request.page.maincontent embedded.
	</responsibilities>
	<properties>
		<history author="Russ Johnson" email="russ.johnson@cyberfusionsolutions.com" type="create"></history>
	</properties>
	<io>
		<in>
			<string name="fusebox.layout" />
		</in>
	</io>
</fusedoc>
--->

<cfparam name="attributes.suppressLayout" default="false">

<cfif attributes.suppresslayout is "false">

	<cfset request.wireframename=attributes.wireframename>
	<cfset request.wireframedir=attributes.wireframedir>
	
	<cfoutput>
		<html>
		<head>
			<title>#request.page.title#</title>
			<style>
				<cfinclude template="wireframe.css">
			</style>
		</head>
		<body>
		<h1 class=heading1>#request.page.title#</h1>
		<h2 class=heading2>#request.page.subtitle#</h2>
		<cfinclude template="dsp_smallmenu.cfm">
	</cfoutput>
	
	<!--- Override style --->
	<cfoutput>
		<style>
			h1, h2, h3, h4 {font-family:arial,helvetic,sans-serif}
			a {text-decoration:none;}
		</style>
	</cfoutput>
</cfif>

<!--- Here is where we output the savedcontent --->
<cfoutput>
#request.page.maincontent#
</cfoutput>

<cfif attributes.suppressLayout is "false">
	
	<cfif isdefined("request.app.Date") is "Yes">
		<cfset tmp=setlocale("English (Australian)")>
		<cfset date = request.app.date>
	</cfif>
	
	<cfif isdefined("request.page.Width") is "Yes">
		<cfset width = request.page.width>
	</cfif>
	
	<cfoutput>
		<hr align="left" width="#WIDTH#">
		</body>
		</html>
	</cfoutput>

</cfif>
