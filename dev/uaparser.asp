<!DOCTYPE html>
<html class="no-js">
<head>
	<title>PropertyWeb - DESARROLLO</title>
<script src="/lib/jquery/jquery-1.7.2.min.js"></script>
<script src="/lib/ua-parser/ua-parser.min.js" type="text/javascript"></script>
<script type="text/javascript">
$(document).ready(function() {

	var parser = new UAParser();
	var result = parser.getResult();
	
	var os = "";
	if (result.os) {
		os = os + result.os.name.replace("Windows", "win") + " " + result.os.version;
		if (result.cpu.architecture) {os = os + " " + result.cpu.architecture.replace("amd64", "64") }
		$("#uaparser_os").html(os);
		
	};
	
	if (result.browser) {
		$("#uaparser_browser").html((result.browser.name + " " + result.browser.version).toLowerCase());
	};
	
	if (result.engine) {
		$("#uaparser_engine").html((result.engine.name + " " + result.engine.version).toLowerCase());
	};
	
	var device = "";
	if (result.device.type) {
		$("#uaparser_device").html(result.device.type);
		
		device = device + result.device.vendor;
		device = device + " " + result.device.model;
		
		$("#uaparser_model").html(device);
	
	} else {
		$("#uaparser_device").html("PC");
		$("#uaparser_model").remove();
	};
	
});
</script>
</head>
<body>

<div class="widget-tittle"><strong>User Agent</strong></div>
<div class="widget-body" id="uaparser_os">os</div>
<div class="widget-body" id="uaparser_browser">browser</div>
<div class="widget-body" id="uaparser_engine">engine</div>
<div class="widget-body" id="uaparser_device">device</div>
<div class="widget-body" id="uaparser_model">model</div>

</body>
</html>
