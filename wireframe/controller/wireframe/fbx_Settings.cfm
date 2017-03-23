<!--- -->
<fusedoc fuse="fbx_Settings.cfm">
	<responsibilities>
		I set up the enviroment settings for this circuit. If this settings file is being inherited, then you can use CFSET to override
		a value set in a parent circuit or CFPARAM to accept a value set by a parent circuit
	</responsibilities>
	<properties>
		<history author="lee borkman" />
		<history author="Russ Johnson" date="10/21/2001 10:30:13 PM" type="update">
	</properties>
	<io>
		<in>
			<structure name="fusebox">
				<boolean
					name="isHomeCircuit"
					comments="Is the circuit currently executing the home circuit?" />
			</structure>
		</in>
		<out>
			<string name="self" scope="variables" />
			<string name="self" scope="request" />
			<string name="fusebox.layoutDir" />
			<string name="fusebox.layoutFile" />
			<boolean name="fusebox.suppressErrors" />
		</out>
	</io>
</fusedoc>
--->

<!--- In case no fuseaction was given, I'll set up one to use by default. --->
<cfif isDefined("attributes.wireframename")>
	<cfparam name="attributes.fuseaction" default="home.quickmap">
<cfelse>
	<cfparam name="attributes.fuseaction" default="home.selectorcreateform">
</cfif>


<!--- useful constants --->
<cfparam name="request.self" default="index.cfm">
<cfparam name="self" default="index.cfm">
<cfset suppresslayout = false>

<!--- should fusebox silently suppress its own error messages? default is FALSE --->
<cfset fusebox.suppresserrors = false>

<!--- Get file-system delimiter documentRoot (automatic) --->
<cfparam name="request.os.delimiter" default="#rereplace(gettemplatepath(), "[^\\/]*([\\/]).*", "\1")#">

<!--- put settings here that you want to execute only when this is the application's home circuit (for example "<cfapplication>" )--->
<cfapplication name="wireframe_fuse" clientmanagement="Yes" sessionmanagement="Yes" setclientcookies="No" applicationtimeout="#createtimespan(1,0,0,0)#" >

<!--- Variables which should exist in EVERY application --->
<cfset request.urltoken=client.urltoken>
<cfset request.page.width="100%">

<cfset request.page.title = "WireFrame Viewer/Editor 5.0 beta">
<cfset request.page.subtitle = "">

<cfset request.app.date = "05 December 2006">
<cfset request.app.year = "2002 - 2006">
<cfset request.app.author="Team Fusebox">

<cfset self = cgi.script_name>

<!--- Variables which only exist in THIS application --->
<cfparam name="attributes.wireframename" default="movies">
<cfparam name="attributes.wireframedir" default="wireframedata">
<cfset attributes.fullwireframedir="#getdirectoryfrompath(gettemplatepath())##attributes.wireframedir#">
<cfparam name="attributes.pagestatename" default="home">

<cfsetting enablecfoutputonly="no">



<!---
  $Log: fbx_settings.cfm,v $
  Revision 1.0  2002-04-26 21:07:33+10  leeb
  Initial revision

  Revision 1.7 10/21/2001 11:49:46 PM russ johnson
  Moved all settings from config/app_globals to this file.

  Revision 1.6  2001/09/07 09:10:49  leeborkman
  New version number, etc

  Revision 1.5  2001/08/21 13:30:57  leeborkman
  Added CVS Log block to the bottom of each file

--->
