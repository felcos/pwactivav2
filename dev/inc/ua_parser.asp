<div class="panel panel-default">
    <div class="panel-heading"><strong>UA Parser</strong></div>
    
    <ul class="list-group">
    	
        <li class="list-group-item">
            <div class="row">
            	<div class="col-xs-4">Device:</div>
            	<div class="col-xs-4" id="uaparser_device_type">-</div>
            	<div class="col-xs-4"></div>
    		</div>
        </li>
    	
        <li class="list-group-item" id="uaparser_device">
            <div class="row">
            	<div class="col-xs-4">Model:</div>
            	<div class="col-xs-4" id="uaparser_device_model">-</div>
            	<div class="col-xs-4" id="uaparser_device_vendor">-</div>
    		</div>
        </li>
    	
        <li class="list-group-item">
            <div class="row">
            	<div class="col-xs-4">OS:</div>
            	<div class="col-xs-4" id="uaparser_os_name">-</div>
            	<div class="col-xs-4" id="uaparser_os_version">-</div>
    		</div>
        </li>
        
        <li class="list-group-item">
            <div class="row">
            	<div class="col-xs-4">Browser:</div>
            	<div class="col-xs-4" id="uaparser_browser_name">-</div>
            	<div class="col-xs-4" id="uaparser_browser_version">-</div>
    		</div>
        </li>
        
        <li class="list-group-item">
            <div class="row">
            	<div class="col-xs-4">Engine:</div>
            	<div class="col-xs-4" id="uaparser_engine_name">-</div>
            	<div class="col-xs-4" id="uaparser_engine_version">-</div>
    		</div>
        </li>
        
    </ul>
    
    <div class="panel-footer">
    	https:// <a href="https://faisalman.github.io/ua-parser-js/" target="_blank">UA Parser</a>
    </div>
    
</div>
<script type="text/javascript" src="/lib/ua-parser/ua-parser.min.js"></script>
<script type="text/javascript">
var result = UAParser()

var tmp = "";

if (result.os.name) {
	document.getElementById("uaparser_os_name").innerHTML = result.os.name;
	tmp = result.os.version;
	if (result.cpu.architecture) {tmp = tmp + ' ' + result.cpu.architecture.replace("amd64", "&nbsp;<span class='peq'>x64</span>") }
	document.getElementById("uaparser_os_version").innerHTML = tmp;
};

if (result.browser.name) {
	document.getElementById("uaparser_browser_name").innerHTML = result.browser.name;
	document.getElementById("uaparser_browser_version").innerHTML = result.browser.version;
};

if (result.engine.name) {
	document.getElementById("uaparser_engine_name").innerHTML = result.engine.name;
	document.getElementById("uaparser_engine_version").innerHTML = result.engine.version;
};

if (result.device.type) {
	document.getElementById("uaparser_device_type").innerHTML = result.device.type;
	document.getElementById("uaparser_device_model").innerHTML = result.device.model;
	document.getElementById("uaparser_device_vendor").innerHTML = result.device.vendor;
} else {
	document.getElementById("uaparser_device_type").innerHTML = "PC";
	$("#uaparser_device").remove();
};

</script>