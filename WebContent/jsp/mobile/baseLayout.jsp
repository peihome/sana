<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix = "tiles"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
	<div id="mobilePageContainer">
 		<tiles:insertAttribute name = "header" />
    	<tiles:insertAttribute name = "body" />
    	<tiles:insertAttribute name = "footer" />
	</div>
</html>