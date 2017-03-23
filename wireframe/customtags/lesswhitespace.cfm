<cfsilent>
<!--- 
CF_LessWhiteSpace
Custom Tag based on Nate Weiss' CF_StripWhiteSpace.  Thanks Nate.

Amended by Lee Borkman:

a) Preserves indentation by default, but takes a JUSTIFY attribute ("y" or "yes")
to completely left justify everything).

b) Checks for <pre> or <code> and does NOTHING AT ALL to the output if found.
Very simple.

Last edited: 13 April 2000
--->

<cfparam name="attributes.justify" default="no">
<cfparam name="attributes.removecrlf" default="no">

<cfif NOT ThisTag.HasEndTag>
	<cfabort showerror="You need to supply a closing &lt;CF_FileWriteText&gt; tag.">
</cfif>  

<cfif ThisTag.ExecutionMode is "End">
	<!--- If it has <pre> or <code> tags, just leave the whole page alone!! --->
	<!--- When CF reg expressions have non-greedy searching, I'll deal with this more intelligently --->
	<cfif REFindNoCase("<pre>|<code>", ThisTag.GeneratedContent) EQ 0>
		<!--- Replace whitespace between CR/LFs with a single CF/LF --->
		<!--- That fixes almost all of the major whitespace --->
		<cfset ThisTag.GeneratedContent = REReplace(ThisTag.GeneratedContent, "[#Chr(13)##Chr(10)#]+[[:space:]]*[#Chr(13)##Chr(10)#]+", "#Chr(13)##Chr(10)#", "ALL")>
		<!--- If justifying, remove whitespace at beginning of each line --->
		<cfif attributes.justify EQ "Y" OR attributes.justify EQ "Yes" OR attributes.justify EQ "true">
			<cfset ThisTag.GeneratedContent = REReplace(ThisTag.GeneratedContent, "[#Chr(13)##Chr(10)#][[:space:]]*", "#Chr(13)##Chr(10)#", "ALL")>
		</cfif>
		<cfif attributes.removecrlf EQ "Y" OR attributes.removecrlf EQ "Yes" OR attributes.removecrlf EQ "true">
			<cfset ThisTag.GeneratedContent = REReplace(ThisTag.GeneratedContent, "[#Chr(13)##Chr(10)#]", "", "ALL")>
		</cfif>
	</cfif>
</cfif>

</cfsilent>
