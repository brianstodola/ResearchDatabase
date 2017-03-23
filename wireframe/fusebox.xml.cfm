<?xml version="1.0" encoding="UTF-8"?> 
<fusebox> 

  <circuits> 
	<circuit alias="wireframe" path="controller/wireframe/" parent="" />
	<circuit alias="mWireframe" path="model/mWireframe/" parent="" />
	<circuit alias="vWireframe" path="view/vWireframe/" parent="" />
	<circuit alias="vLayout" path="view/vLayout/" parent="" />
  </circuits>
  
  <parameters> 
    <parameter name="fuseactionVariable" value="fuseaction" />
    <parameter name="mode" value="development-full-load" />
    <parameter name="defaultFuseaction" value="wireframe.selectorcreateform" />
    <parameter name="precedenceFormOrUrl" value="form" />
    <parameter name="password" value="moggie" />
    <parameter name="scriptFileDelimiter" value="cfm" />
    <parameter name="maskedFileDelimiters" value="htm,cfm,cfml,php,php4,asp,aspx" />
    <parameter name="characterEncoding" value="utf-8" />
	<parameter name="debug" value="true" /> 
  </parameters> 
  
  <globalfuseactions>
    <preprocess>
    </preprocess>
    <postprocess>
    </postprocess>
  </globalfuseactions> 
  
  <plugins> 
    <phase name="preProcess">
    </phase>
    <phase name="preFuseaction">
    </phase>
    <phase name="postFuseaction">
    </phase>
    <phase name="postProcess">
    </phase>
    <phase name="processError">
    </phase>
    <phase name="fuseactionException">
    </phase>
  </plugins> 
  
</fusebox> 
