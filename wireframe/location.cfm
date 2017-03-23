<!-- location.cfm -->
<!---

FUSEDOC
	file:			location.cfm
	responsibility:		I replace the functionality of <CF_LOCATION> to fix problems created
				when the HTTP header attempts (and fails) to set a cookie at the
				same time as it relocates the web browse. As well I add easy of use
				functionality to automatically create dynamic URL paths
	considerations:		This tag has not been tested on any non-windows machine, any
				ompatibility issues found on other platforms would be appreciated.

DEPENDANCY
	--> url - string, required: identifies location to move browse to
	--> addToken - boolean, optional: automatically appends application variables to location
	--> doSlash - boolean, optional: converts location into directory style format
	
HISTORY v2.0.1
	Author:		Jordan Clark (JClark@ImagineeringStudio.com)
	Datetime:	7/27/00 2:50:46 AM
	Summary:	Changed directory style attribute to "doStyle" boolean variable
			Added directory style support for null variables
			Added directory style ".htm" extension to query string
	
HISTORY v2.0
	Author:		Jordan Clark (JClark@ImagineeringStudio.com)
	Datetime:	7/22/00 12:00:46 PM
	Summary:	Added ability to specify block & equal characters in URL
			Added ability to automatically append any passed attributes to URL
			Added better addToken support for client or application management
			Added better blocking technique between URL variables
	
HISTORY v1.0
	Author:		Christopher Bradford (bradford@aliveonline.com)
	Datetime:	?
	Summary:	Original Author, discovered method to relocate and set cookies
			in a single HTTP header response
	
--->

<CFSETTING ENABLECFOUTPUTONLY="yes">

<CFPARAM NAME="attributes.url" TYPE="string">
<CFPARAM NAME="attributes.doSlash" TYPE="boolean" DEFAULT="yes">
<CFPARAM NAME="attributes.addToken" TYPE="boolean" DEFAULT="no">

<!--- setup the first blocks --->
<CFIF attributes.doSlash>
	<CFSET nextblock = "/">
	<CFSET equals = "/">
	<CFSET blocks = "/">
<CFELSE>
	<CFSET equals = "=">
	<CFSET nextblock = "&">
	<CFIF find( "?", attributes.url ) IS NOT 0>
		<CFSET blocks = "&">
	<CFELSE>
		<CFSET blocks = "?">
	</CFIF>
</CFIF>

<!--- try to addToken --->
<CFIF attributes.addToken IS true>
	<CFTRY>
		<CFSET attributes.url = attributes.url & blocks & "CFID" & equals & CFID>
		<CFSET blocks = nextblock>
		<CFSET attributes.url = attributes.url & blocks & "CFTOKEN" & equals & CFTOKEN>
	
		<!--- catch any errors caused by missing application variables --->
		<CFCATCH>
			<CFABORT SHOWERROR='You must have <b>CLIENTMANAGEMENT="Yes"</b>
			OR <b>applicationMANAGEMENT="Yes"</b> in your CFAPPLICATION tag if you
			choose to specify <b>ADDTOKEN="Yes"</b> in CF_LOCATION.'>
		</CFCATCH>
	</CFTRY>
</CFIF>

<!--- append any attributes passed to location custom tag --->
<CFLOOP COLLECTION="#attributes#" ITEM="item">
	<!---	blocks out any attributes you can't use in custom tags --->
	<CFIF listContainsNoCase( "url,addToken,dodoSlash,template,name,cfid,cftoken", item, "," ) IS false>
		<CFSET value = urlEncodedFormat( evaluate( "attributes." & item ) )>
		<!--- replace slash address null values with "null" value --->
		<CFIF attributes.doSlash AND NOT len(value)>
			<CFSET value = "null">
		</CFIF>			
		<CFSET attributes.url = attributes.url & blocks & ucase( item ) & equals & value>
		<CFSET blocks = nextblock>
	</CFIF>
</CFLOOP>

<!--- add an extension to complete slash address if necessar --->
<CFIF attributes.doSlash AND reFind("(.\../.)", attributes.url)>
	<CFSET attributes.url = attributes.url & ".htm">
</CFIF>

<!--- preform relocation after cookies are able to set --->
<CFHEADER STATUSCODE="302" STATUSTEXT="Object Temporarily Moved">
<CFHEADER NAME="location" VALUE="#attributes.url#">

<!--- stop processing passed this point --->
<CFABORT>
