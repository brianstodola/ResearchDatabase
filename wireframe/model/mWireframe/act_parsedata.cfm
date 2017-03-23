<CFSETTING ENABLECFOUTPUTONLY="Yes">

<!--- 
|| BEGIN FUSEDOC ||

|| DESCRIPTION || 
I parse data-file and create CF application-scope structures,...
...unless structures are already present and current.
Uses a clearer data-structure to hold the parsed data.

|| DESIGNER ||
hal.helms@TeamAllaire.com
Amended by Lee Bjork Borkman (bjork@bjork.net)

|| PROGRAMMER ||
hal.helms@TeamAllaire.com
Amended by Lee Bjork Borkman (bjork@bjork.net)


|| END FUSEDOC ||
--->

<!---
<FUSEDOC>
    <IO>
        <IN>
            <BOOLEAN NAME="refresh" SCOPE="Request" COMMENTS="Do we force a re-parse?"/>
            <STRING NAME="wireframename" SCOPE="Attributes"/> 
            <STRING NAME="wireframedir" SCOPE="Attributes" COMMENTS="Relative to the wireframetool's install directory/> 
        </IN>
        <OUT>
            <STRUCTURE NAME="~wireframename~" SCOPE="application" COMMENTS="A structure with same name as wireframe to hold parsed data">
                <LIST NAME="PageList" COMMENTS="A list of Page names in order as they appear in data"/>
                <STRING NAME="RawData" COMMENTS="The contents of the text data-file (minus changeDescription data)"/>
                <STRUCTURE NAME="~Page~" COMMENTS="One structure for each Page.  The Page name is stripped of difficulat characters">
                    <STRING NAME="DisplayName" COMMENTS="The displayed name of the Page (can include difficult characters)">
                    <ARRAY NAME="Lines" COMMENTS="Lines of the Description/Responsibilities block">
                         <STRING COMMENTS="Text of the Description/Responsibilities block"/>
                    </ARRAY>
                    <ARRAY NAME="Path" COMMENTS="1 element per Exit=Destination pair">
                        <STRUCTURE>
                            <STRING NAME="ExitText" COMMENTS="The text for the Exit"/>
                            <STRING NAME="DestText" COMMENTS="The text for the Destination (may include difficult characters)"/>
                            <STRING NAME="DestName" COMMENTS="The name of the Destination Page (stripped of difficult charcters)"/>
                        </STRUCTURE>
                    </ARRAY>
                </STRUCTURE>
            </STRUCTURE>
        </OUT>
    </IO>
</FUSEDOC>
--->

